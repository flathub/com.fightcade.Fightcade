/*
 * launch-inhibit: run a command while holding an org.freedesktop.ScreenSaver
 * inhibition for the whole lifetime of that command.
 *
 * A one-shot dbus-send/gdbus call is not enough: since GNOME 3.36 the inhibit
 * is released as soon as the D-Bus connection that requested it closes. This
 * helper keeps a single session-bus connection open until the wrapped command
 * exits, so the screensaver stays inhibited for the entire session.
 *
 * The runtime's Python has no PyGObject, but the freedesktop Platform ships
 * libgio, so this is implemented in C and compiled at build time against the
 * SDK's gio-2.0.
 *
 * Usage: launch-inhibit <command> [args...]
 *
 * Inhibition is best-effort: if the session bus or the ScreenSaver interface
 * is unavailable, the wrapped command is still run normally.
 */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

#include <gio/gio.h>

#define APP_NAME "com.fightcade.Fightcade"
#define REASON "Fightcade gameplay"
#define SS_NAME "org.freedesktop.ScreenSaver"
#define SS_PATH "/org/freedesktop/ScreenSaver"

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "usage: %s <command> [args...]\n", argv[0]);
        return 2;
    }

    GError *error = NULL;
    GDBusConnection *conn = g_bus_get_sync(G_BUS_TYPE_SESSION, NULL, &error);
    guint32 cookie = 0;
    gboolean inhibited = FALSE;

    if (conn == NULL) {
        fprintf(stderr, "launch-inhibit: no session bus: %s\n",
                error ? error->message : "unknown error");
        g_clear_error(&error);
    } else {
        GVariant *reply = g_dbus_connection_call_sync(
            conn, SS_NAME, SS_PATH, SS_NAME, "Inhibit",
            g_variant_new("(ss)", APP_NAME, REASON), G_VARIANT_TYPE("(u)"),
            G_DBUS_CALL_FLAGS_NONE, -1, NULL, &error);
        if (reply == NULL) {
            fprintf(stderr, "launch-inhibit: could not inhibit screensaver: %s\n",
                    error ? error->message : "unknown error");
            g_clear_error(&error);
        } else {
            g_variant_get(reply, "(u)", &cookie);
            g_variant_unref(reply);
            inhibited = TRUE;
        }
    }

    pid_t pid = fork();
    if (pid < 0) {
        perror("launch-inhibit: fork");
        return 1;
    }
    if (pid == 0) {
        execvp(argv[1], &argv[1]);
        perror("launch-inhibit: execvp");
        _exit(127);
    }

    int status = 0;
    while (waitpid(pid, &status, 0) < 0 && errno == EINTR) {
        /* retry */
    }

    if (inhibited && conn != NULL) {
        GVariant *r = g_dbus_connection_call_sync(
            conn, SS_NAME, SS_PATH, SS_NAME, "UnInhibit",
            g_variant_new("(u)", cookie), NULL, G_DBUS_CALL_FLAGS_NONE, -1, NULL,
            &error);
        if (r != NULL)
            g_variant_unref(r);
        g_clear_error(&error);
    }

    if (WIFEXITED(status))
        return WEXITSTATUS(status);
    if (WIFSIGNALED(status))
        return 128 + WTERMSIG(status);
    return 1;
}

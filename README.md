# com.fightcade.Fightcade

[com.fightcade.Fightcade on Flathub.org](https://flathub.org/apps/details/com.fightcade.Fightcade)

[com.fightcade.Fightcade.Wine extension on Github](https://github.com/flathub/com.fightcade.Fightcade.Wine)

## Where do my downloaded files go?
In the appropriate subdirectory under `~/.var/app/com.fightcade.Fightcade/data/ROMs/`

Flycast accepts BIOS files in its subdirectory, but the `flycast/data/` directory is mapped to `~/.var/app/com.fightcade.Fightcade/data/config/flycast/data` just in case you'd prefer to put them in there.

## FBNeo is crashing with 'Couldn't initialize DirectX9 Alternate video output' module
This issue happens on Nvidia sometimes, you'll need to install the GL32 Flatpak version of your Nvidia driver. See [this link](https://www.linuxuprising.com/2018/06/how-to-get-flatpak-apps-and-games-built.html) for instructions.

## Can I use DXVK?
Override the USE_DXVK environment variable using Flatseal or any similar tool. When set to `true` Fightcade will automatically install DXVK at launch.

Please ensure that your hardware is DXVK capable (Vulkan support) before doing this.

## I'm having issues on my Steam Deck/SteamOS device!
If you are having issues in gaming mode (such as replays not opening) please install `com.fightcade.Fightcade.Steamos`.

This is an optional extension that improves compatibility with SteamOS.

Please report any SteamOS-specific bugs [in that repo's issue tracker](https://github.com/flathub/com.fightcade.Fightcade.Steamos/issues)

## How do I use Fightcade JSON?
Extract the zip with the json files directly into `~/.var/app/com.fightcade.Fightcade/data`

There is a logfile located at `~/.var/app/com.fightcade.Fightcade/data/frm.log`. Use `tail -f` from a terminal to follow it live and ensure it is working.

## My controller doesn't work
Make sure to have the controller plugged in _before_ running Fightcade. Flatpak currently doesn't support USB hotplugging.

## Flycast is laggy!
If Flycast is laggy try disabling vsync.

## Removing other Fightcade installs
If you install the Fightcade Flatpak but find it's still trying to launch another version of Fightcade, remove the following files and try again (might require a reboot)
```
~/.local/share/applications/Fightcade.desktop
~/.local/share/applications/fcade-quark.desktop
```

## Help! Something else is wrong!
Join the official Discord at https://discord.gg/EyERRSg and ask in **#linux-version**

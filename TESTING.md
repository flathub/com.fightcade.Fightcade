## Testing in the Fightcade Flatpak
This document is intended for developers who want to test their precompiled programs against the Flatpak environment.

### Get your data into the Flatpak
`~/.var/data/com.fightcade.Fightcade` on your host is mapped to `/var/data` inside of the Flatpak sandbox, so copy any files/folders you want there.

### Enter the sandbox and run your program
`flatpak run --command=sh com.fightcade.Fightcade` will give you a shell inside of the Fightcade Flatpak sandbox environment.

Now you can navigate over to `/var/data` and run your program inside of the context of the Flatpak.

### Debugging why my application won't run
The most common reason precompiled applications don't run in the sandbox is due to library mismatch issues. Use a tool like `ldd` to see what libraries your binary is linked against.

(example `ldd` output)
```
    libzip.so.5 => /app/lib/libzip.so.5 (0x00007f0a9f4c3000)
    libssl.so.1.1 => /usr/lib/x86_64-linux-gnu/libssl.so.1.1 (0x00007f0a9f42c000)
    libcrypto.so.1.1 => /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 (0x00007f0a9f148000)
```

If your application requires `wine` you can find the binary at `/app/wine/bin/wine`. Keep in mind that is provided by the `com.fightcade.Fightcade.Wine` extension so you'll need to ensure that it is installed.

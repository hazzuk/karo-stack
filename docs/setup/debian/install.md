---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/server
---

# Server install

With the preseed file setup, Debian can now be installed onto your server hardware.

## Debian ISO

1. Download the latest Debian release

    === "Complete ISO (3.7 GB~)"

        - [Direct download](https://cdimage.debian.org/images/release/current/amd64/iso-dvd/)
            `debian-1.0.0-amd64-DVD-1.iso`

        - [Bittorrent file](https://cdimage.debian.org/images/release/current/amd64/bt-dvd/)
            `debian-1.0.0-amd64-DVD-1.iso.torrent`

    === "Network installer ISO (800 MB~)"

        - [Direct download](https://cdimage.debian.org/images/release/current/amd64/iso-cd/)
            `debian-1.0.0-amd64-netinst.iso`

        - [Bittorrent file](https://cdimage.debian.org/images/release/current/amd64/bt-cd/)
            `debian-1.0.0-amd64-netinst.iso.torrent`

1. Create a bootable USB drive with the Debian ISO file

    ??? abstract "Using Ventoy"

        - Install [Ventoy](https://www.ventoy.net/en/index.html) onto an 8 GB+ USB drive

        - Move the Debian ISO file to the Ventoy directory on your removable device

        - Safely remove the USB drive

        - Boot into the Ventoy USB on your server

        - Select the Debian ISO file

        - (Optional) Check the ISO file integrity
            - Select `File checksum`
            - Select `Calculate sha256sum`
            - Compare the output of the checksum to the value on the
                [Debian website](https://cdimage.debian.org/images/release/current/amd64/iso-dvd/SHA256SUMS)

        - Select `Boot in normal mode`

## Debian installer

1. Select `Advanced options ...`

1. Select `... Automated install`

1. When prompted for the preconfiguration file, enter the URL of your preseed file

    > e.g. `https://pastebin.com/raw/aBcdEf` or `192.168.0.76:8000`

    ??? failure "Handling 'preconfiguration could not be retrieved'"

        If you receive an error after entering the preseed file URL,
        abort the installation and try again.
        This usually occurs because the URL was typed incorrectly,
        or the server's network configuration was misconfigured.

1. Set your localisation preferences

    - Select a language

    - Select your location

    - Select a keymap to use

1. Select the disk to partition (when multiple storage devices are connected)

    !!! danger

        All data on the disk selected will be erased!

1. Wait for the installer to finish and the system to reboot into Debian

    ??? failure "Handling 'Failed to run preseeded command'"

        If you receive an error at the end of the install process, continue,
        then attempt the full installation again.
        This often occurs because the pressed file was edited incorrectly when
        [adding the authorised SSH key](preseed.md#normal-setup).

    !!! success

        ``` sh { .no-copy }
        Debian GNU/Linux debian tty1

        debian login:
        ```

## Login with SSH

1. Open a terminal on your desktop computer (i.e. Powershell on Windows)

1. Connect to the server using SSH

    > e.g. `ssh -A karo@homeserver.example.com`

    > Your domain `homeserver.example.com`, should resolve to your server's local IPv4 address.

    ??? failure "Handling 'Could not resolve hostname'"

        If you receive an error when connecting, try the following:

        - Ensure you've substituted 'example.com' for your own domain name

            > e.g. `ssh -A karo@homeserver.yourdomain.net`

        - Ping the domain name

            ``` sh
            ping homeserver.example.com
            ```

        - Check you've correctly configured the domain's [DNS records](../prepare/dns.md)

        - Try connecting directly using the server's IPv4 address

            > e.g. `ssh -A karo@192.168.0.142`

    !!! info "Authentication forwarding"

        Using `ssh -A` allows for forwarding connections from your password manager's ssh-agent.

1. When prompted, change your user's password (default is `changelater`)

    > It's recommended you use a [short passphrase](https://xkcd.com/936/),
    which is memorable and easy to type out.

    > e.g. `horsebatterystaple`

1. SSH again after updating your password

??? tip "Restoring a previous karo-stack setup"

    If you've previously used the karo-stack,
    you can immediately proceed with the full remaining setup.

    Follow the advanced guide [Restore setup](../../advanced/restore.md).

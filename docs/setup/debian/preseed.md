---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/sprout
---

# Debian preseed

The [preseed file](https://github.com/hazzuk/karo-stack/blob/main/debian/server/d-i/trixie/preseed.cfg)
is a list of answers to questions,
which a user would normally be prompted to complete by the Debian installer.
This automates the majority of the OS's installation.

## Hosting the file

The easiest way for the Debian installer to access your preseed file
is by hosting it via a web server.
Either with a site like pastebin.com, or a computer on your local network.

One essential change needs to be made to your preseed file beforehand,
which is adding your public SSH authentication key.
The Debian installer will automatically insert your public key
into the server's SSH `authorized_keys` file.
Making first time authentication over SSH straightforward.

??? info "Automatic partitioning"

    The preseed file will automatically format the storage device you select.
    Creating a partition which spans the entire drive.
    If you want a more specific setup,
    you can remove the 'partitioning' section from the preseed file.

=== "Normal setup"

    1. Download the
        [latest preseed file](https://github.com/hazzuk/karo-stack/blob/main/debian/server/d-i/trixie/preseed.cfg)
        from the karo-stack GitHub repo

    1. Find and replace `<key>` with your public SSH authentication key

        > e.g. `echo 'ssh-ed25519 AAAAC3NqnC1bZEIl2...' \`

    1. Copy and paste the contents of the modified file to a text storage site
        (e.g. [pastebin.com](https://pastebin.com/))

        !!! tip "Recommended paste settings"

            - Paste Expiration: 1 Day
            - Paste Exposure: Unlisted
            - Password: Disabled

    1. Note down the URL for the **raw** text file, to later provide the Debian installer

        > e.g. https://pastebin.com/raw/aBcdEf

=== "Automatic setup (advanced)"

    ### Preamble

    !!! info

        You'll need to have previously setup your private `karo-inventory` git repo.
        As instructed in a later section of the karo-stack documentation.
        If this doesn't sound familiar,
        then please follow the manual setup guide for the preseed file.

    The karo-stack has a `just` recipe,
    which fully automates dynamically adding your public SSH key to the preseed file,
    then serving it via a local webserver.
    This method was primarily intended for rapid testing of the Debian installer
    during the karo-stack's development.
    But can equally be used by anyone with the right setup.

    !!! abstract "Requirements"

        - Unix shell (sh/bash/zsh)
        - Port `8000` (TCP) must be allowed on the host's firewall
        - Git
        - Python
        - [just](https://just.systems/man/en/packages.html)

    ### Local setup

    - Clone the karo-stack and your private inventory repo (adjust paths accordingly):

        --8<-- "docs/snippets.md:git_clone"

    - And if required, add/update your public SSH key inside your inventory repo:

        ``` sh
        micro key.txt

        git add key.txt
        git commit -m "add public ssh key for preseed"
        git push
        ```

    ### Run

    - After setup, simply run the following:

        ``` sh
        just preseed server
        ```

    !!! tip

        When later prompted for the preseed file's URL,
        use the IP address of the host and port 8000.

        > e.g. `192.168.0.76:8000`

        Both the default protocol (`http://`)
        and default path of the file (`/d-i/trixie/./preseed.cfg`)
        are assumed by the Debian installer, when the URL doesn't include them.

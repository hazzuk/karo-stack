---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/folder-git-2
---

# Git changes

## Commit changes

Having made local changes to your `karo-inventory` repo,
you'll need to 'commit' and 'push' the new changes.
Ensuring your server's configuration is synced with your remote GitHub repository.

``` sh
# commit inventory changes
cd /srv/karo/inventory
git add *
git commit -m "update inventory files"
git push
```

??? info "SSH key prompts"

    Your desktop password manager might prompt you when running git commands.
    Using both your SSH signing key, to sign your git commits.
    And SSH auth key, to authenticate access with your remote repository.

You should repeat these commands after making any new substantial changes to your repository.

## Upgrade your karo-stack

It is recommended to keep the `karo-stack` repo up to date.
The following commands assume you've only made changes to files inside your
`./inventory` or `./custom` directories.

!!! warning

    Make sure to read the karo-stack's
    [release notes](https://github.com/hazzuk/karo-stack/releases)
    first. And check for any breaking changes before upgrading.

    It's also recommended to stop any stack's you're currently running with
    `just compose down homeserver`.

=== "Latest"

    ``` sh
    # upgrade karo-stack to latest
    cd /srv/karo
    git pull origin main
    ```

=== "Specific version"

    ``` bash
    # set karo-stack version
    KAROSTACK_VERSION=v3.0.0
    ```

    ``` sh
    # checkout karo-stack version
    cd /srv/karo
    git fetch origin tag ${KAROSTACK_VERSION}
    git checkout ${KAROSTACK_VERSION}
    ```

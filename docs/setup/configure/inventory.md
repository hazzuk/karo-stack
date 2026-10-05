---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/backpack
---

# Inventory files

The [inventory](https://docs.ansible.com/projects/ansible/latest/inventory_guide/intro_inventory.html)
repo is placed inside the karo-stack as a subdirectory,
and is used to configure what Ansible does.
This allows the karo-stack codebase to remain unchanged.
While tracking all your personal configuration separately,
inside a dedicated private repository.

Your inventory repo will eventually look something like this:

``` toml { .no-copy }
inventory/
├── host_vars/
│   └── homeserver/ # name of your server
│       └── vault.yml # encrypted Ansible vault, contains almost all your configuration
├── hosts.ini # directs Ansible to the target host (e.g. localhost)
└── key.txt # contains your public SSH authentication key
```

For now, create the first two files:

-   :lucide-file-key: `key.txt`

    This file will store your public SSH authentication key.

    ``` sh
    # create public ssh key file
    cp /home/karo/.ssh/authorized_keys /srv/karo/inventory/key.txt
    ```

-   :lucide-file-box: `hosts.ini`

    This config is used to tell the automation tool Ansible which host to target.

    ``` sh
    # create ansible hosts file
    micro /srv/karo/inventory/hosts.ini
    ```

    (As your target for Ansible is the server itself,
    simply copy the following localhost setup)

    === "Local setup"

        ``` ini { title="/srv/karo/inventory/hosts.ini" }
        [server]
        homeserver ansible_host=localhost ansible_connection=local ansible_user=karo
        ```

    === "Remote setup (advanced)"

        ``` ini { title="/srv/karo/inventory/hosts.ini" }
        [server]
        testserver ansible_host=192.168.122.142 ansible_connection=ssh ansible_user=karo
        ```

    !!! info "`micro` bindings"

        Use ++alt+g++ when using Micro to see all available keyboard shortcuts.

---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/folder-tree
---

# Repo structure

=== ":lucide-bolt: karo-custom (public repo)"

    A karo-custom repo is a dedicated public git repository for custom stacks.

    ``` text { .no-copy title="Repo example" }
    karo-custom/
    ├── karo-compose/...
    ├── LICENSE
    └── README.md
    ```

    1. [Create a new public git repo](https://github.com/new)
        named `karo-custom` on GitHub

        - Visibility: :octicons-repo-16: Public
        - Readme: On
        - `No .gitignore`
        - [Choose a license](https://choosealicense.com/)
        (e.g. 'GNU General Public License v3.0' or 'MIT License')

    1. Clone your new repo to wherever you wish to work on it

        - To your PC, cloning it manually using git
        - To your karo-stack homeserver `just custom get <GITHUB USERNAME>`

=== ":lucide-backpack: karo-inventory (private repo)"

    You can also create private custom stacks inside
    your existing karo-inventory repository.

    ``` text { .no-copy title="Repo example" }
    karo-inventory/
    ├── karo-compose/...
    ├── host_vars/...
    └── hosts.ini
    ```

!!! tip "karo-cli"

    To help you quickly generate the required structure,
    and lint your custom repo.
    You can use the [karo-cli](https://github.com/hazzuk/karo-cli) tool.

## Example layout

Files for custom stacks are symbolically linked
to the inside of the karo-stack's Ansible playbook.
Because of this, custom stacks must follow a very specific structure.

=== "Ansible role"

    ``` toml { .no-copy title="Extend the Ansible compose role" hl_lines="1" }
    --8<-- "docs/snippets.md:custom_compose_filetree"
    ```

=== "Role directories"

    ``` toml { .no-copy title="Defaults and templates directories" hl_lines="2 6" }
    --8<-- "docs/snippets.md:custom_compose_filetree"
    ```

=== "Stack groups"

    ``` toml { .no-copy title="Stack group directories" hl_lines="3 7" }
    --8<-- "docs/snippets.md:custom_compose_filetree"
    ```

    !!! info "Stack group naming"

        - There must always be at least one stack group.

        - Stack groups must follow a strict naming convention `<username>_<scope>`.

        - Do **not** use any of the following words for the scope name:

            - [Ansible role names](https://github.com/hazzuk/karo-stack/tree/main/roles) (e.g. `compose` or `system`)
            - `stack` or `stacks`
            - `custom`
            - `karo`

=== "Defaults"

    ``` toml { .no-copy title="Stack group defaults files" hl_lines="4-5" }
    --8<-- "docs/snippets.md:custom_compose_filetree"
    ```

=== "Templates"

    ``` toml { .no-copy title="Stack group templates" hl_lines="8-9" }
    --8<-- "docs/snippets.md:custom_compose_filetree"
    ```

    !!! info "Template files"

        - Template files **must** end with the `.j2` file extension

        - You can create multiple template files for each stack

            === "Templates"

                ``` toml { .no-copy }
                templates/
                └── hazzuk_extra/
                    └── godns/
                        ├── compose.yml.j2
                        └── config.json.j2
                ```

            === "Deployed files"

                ``` toml { .no-copy }
                /srv/
                └── docker/
                    └── hazzuk_extra/
                        └── godns/
                            ├── compose.yml.j2
                            └── config.json.j2
                ```

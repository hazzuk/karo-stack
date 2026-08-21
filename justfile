# SPDX-FileCopyrightText: 2025 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only


# help

# Print help
help:
    @{{ just_executable() }} --list --unsorted --list-prefix "  - " --justfile "{{ justfile() }}"

# (Internal use) Reusable confirmation statement
[confirm("proceed? (y/N)")]  
_confirm:
    @echo


# preseed

# Host preseed.cfg
[group('Debian install')]
@preseed platform='server':
    # check user input for platform
    [ "{{platform}}" = "server" ] || [ "{{platform}}" = "desktop" ] || { echo "platform must be 'server' or 'desktop'" >&2; exit 1; }
    # check user key file exists
    [ -e "inventory/key.txt" ] || { echo "inventory/key.txt not found" >&2; exit 1; }
    # insert public ssh key into preseed file
    just _insert-preseed-key "$(cat inventory/key.txt)" {{platform}}
    # run webserver
    -just _host-preseed {{platform}}
    -# revert change to preseed file
    -just _insert-preseed-key "<key>" {{platform}}

# (Internal use) Write the authorized SSH key to the Debian preseed file
_insert-preseed-key value platform:
    @sed -i "s|echo '.*'|echo '{{value}}'|" debian/{{platform}}/d-i/trixie/preseed.cfg

# (Internal use) Run a Python HTTP server to host the preseed file
_host-preseed platform:
    @echo "press 'Ctrl + C' to exit"
    -python3 -m http.server 8000 --bind 0.0.0.0 --directory ./debian/{{platform}}


# server

# Setup a system
[group('System setup')]
@install hostname='': _check-password
    ansible-playbook run.yml --tags install --limit "{{hostname}}"


# compose

# Up/down Docker stacks
[group('System setup')]
[arg("stack", long, short="s")]
compose action hostname='' stack='all': _check-password
    #!/bin/bash
    # check user input for action
    if [ "{{action}}" = "up" ]; then
        skip_tags="down"
    elif [ "{{action}}" = "down" ]; then
        skip_tags="up"
    else
        echo "action must be 'up' or 'down'" >&2; exit 1;
    fi
    # manage symlinks
    just _custom-symlink
    # run user action
    ANSIBLE_DISPLAY_SKIPPED_HOSTS=false ansible-playbook run.yml \
        --extra-vars "karo_compose_justfile_stack={{stack}}" \
        --tags compose \
        --skip-tags "$skip_tags" \
        --limit "{{hostname}}"


# vault

password := "/run/user/1000/karo/ansible/vault_pass"

# Manage a vault
[group('Ansible vault')]
vault hostname:
    #!/bin/bash
    # check password file exists
    if [ -e "{{password}}" ]; then
        # check vault file exists
        export vault="inventory/host_vars/{{hostname}}/vault.yml"; echo $vault
        if [ -e "$vault" ]; then
            # edit existing vault
            ansible-vault edit "$vault"
        else
            # create new vault
            ansible-vault create "$vault"
        fi
    else
        echo "{{password}} not found, run 'just password'." >&2; exit 1;
    fi

# (Internal use) Create the Ansible vault password file when missing
_check-password:
    @[ -e "{{password}}" ] || micro -backup false -mkparents true "{{password}}"

# Set password
[group('Ansible vault')]
password:
    @micro -backup false -mkparents true "{{password}}"


# wireguard

# Generate key pair
_wireguard:
    @priv="$(wg genkey)"; \
    pub="$(wg pubkey <<<"$priv")"; \
    printf 'Private key: %s\n' "$priv"; \
    printf 'Public key: %s\n' "$pub"


# custom

# Get/remove custom repos
[group('Custom repos')]
custom action username:
    #!/usr/bin/env bash
    set -euo pipefail
    case "{{action}}" in
        get)
            echo "Getting repo {{lowercase(username)}}/karo-custom"
            just _custom-get {{lowercase(username)}}
            ;;
        remove)
            echo "removing custom/{{lowercase(username)}}"
            just _custom-remove {{lowercase(username)}}
            ;;
        *)
            echo "action must be 'get' or 'remove'" >&2; exit 1;
            ;;
    esac

repo_name := "karo-custom"

# (Internal use) Get remote karo-custom repo
_custom-get username:
    #!/usr/bin/env bash
    set -euo pipefail
    # clone karo-custom git repo
    git clone git@github.com:{{username}}/{{repo_name}}.git custom/{{username}}
    # check karo-custom repo dir not empty
    if [ -z "$(find custom/{{username}}/karo-compose -mindepth 1 -maxdepth 1)" ]; then
        exit 0
    else
        # manage symlinks
        just _custom-symlink
        # list stack groups for username
        echo "new karo-compose stack groups:"
        ls -1 roles/karo-compose/templates | grep {{username}} | awk '{print "- " $0}'
    fi

# (Internal use) Remove a karo-custom repo
@_custom-remove username:
    # check username dir exists
    test -d "custom/{{username}}"
    # confirm removal
    just _confirm
    # remove custom dir
    rm -rf "custom/{{username}}"
    # manage symlinks
    just _custom-symlink

# (Internal use) Manage symbolic links for custom files
_custom-symlink:
    #!/usr/bin/env bash
    set -euo pipefail
    # clear existing symlinks
    find roles/karo-compose/defaults/main/ -mindepth 1 -maxdepth 1 ! -name "main.yml" -delete
    find roles/karo-compose/templates/ -mindepth 1 -maxdepth 1 ! -name ".gitkeep" -delete
    # check custom dir not empty
    if [ -z "$(find custom -mindepth 1 -maxdepth 1)" ]; then
        exit 0
    else
        # symlink custom files
        ln -sr custom/*/karo-compose/defaults/main/*/ roles/karo-compose/defaults/main/
        ln -sr custom/*/karo-compose/templates/*/ roles/karo-compose/templates/
    fi

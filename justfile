# SPDX-FileCopyrightText: 2025 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only


# help

# Print help
help:
    @{{ just_executable() }} --list --unsorted --list-prefix "  - " --justfile "{{ justfile() }}"


# preseed

# Host preseed.cfg
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
@install hostname='': _check-password
    ansible-playbook run.yml --tags install --limit "{{hostname}}"


# compose

# Deploy/remove stacks
[arg("stack", long, short="s")]
compose action hostname='' stack='all': _check-password
    #!/bin/bash
    # check user input for action
    if [ "{{action}}" = "up" ]; then
        skip_tags="down"
    elif [ "{{action}}" = "down" ]; then
        skip_tags="deploy,up"
    else
        echo "action must be 'up' or 'down'" >&2; exit 1;
    fi
    # run user action
    ANSIBLE_DISPLAY_SKIPPED_HOSTS=false ansible-playbook run.yml \
        --extra-vars "karo_compose_justfile_stack={{stack}}" \
        --tags compose \
        --skip-tags "$skip_tags" \
        --limit "{{hostname}}"


# vault

password := "/run/user/1000/karo/ansible/vault_pass"

# Manage a vault
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
password:
    @micro -backup false -mkparents true "{{password}}"


# wireguard

# Generate key pair
wireguard:
    @priv="$(wg genkey)"; \
    pub="$(wg pubkey <<<"$priv")"; \
    printf 'Private key: %s\n' "$priv"; \
    printf 'Public key: %s\n' "$pub"


# custom stacks

@_stack-remove:
    # remove role defaults
    find roles/karo-compose/defaults/main/ -mindepth 1 ! -name "main.yml" -delete
    # remove role templates
    find roles/karo-compose/templates/ -mindepth 1 -delete

@_stack-add:
    # symlink custom defaults
    ln -sr custom/*/defaults/main/*.yml roles/karo-compose/defaults/main/
    # symlink custom templates
    ln -sr custom/*/templates/*/ roles/karo-compose/templates/

@stack:
    just _stack-remove
    just _stack-add

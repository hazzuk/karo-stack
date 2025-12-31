# SPDX-FileCopyrightText: 2025 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

# help

# Print help
help:
    @{{ just_executable() }} --list --unsorted --list-prefix "  - " --justfile "{{ justfile() }}"

# preseed

# Host the Debian preseed.cfg file for use over a local network
@preseed-server:
    # check user key file exists
    [ -e "inventory/key.txt" ] || { echo "error: inventory/key.txt not found!" >&2; exit 1; }
    # insert public ssh key into preseed file
    just _insert-preseed-key "$(cat inventory/key.txt)" server
    # run webserver
    -just _host-preseed server
    -# revert change to preseed file
    -just _insert-preseed-key "<key>" server

# (Internal use) Write the authorized SSH key to the Debian preseed file
_insert-preseed-key value platform:
    @sed -i "s|echo '.*'|echo '{{value}}'|" debian/{{platform}}/d-i/trixie/preseed.cfg

# (Internal use) Run a Python HTTP server to host the preseed file
_host-preseed platform:
    @echo "info: Press 'Ctrl + C' to exit"
    -python3 -m http.server 8000 --bind 0.0.0.0 --directory ./debian/{{platform}}

# server

# Run Ansible to provision the Debian server
setup-server: _check-password
    ansible-playbook run.yml --tags setup

# compose

# Run Ansible to deploy Docker compose stacks
setup-compose: _check-password
    ansible-playbook run.yml --tags compose --skip-tags stop

# Run Ansible to stop Docker compose stacks
stop-compose: _check-password
    ansible-playbook run.yml --tags compose --skip-tags start


# vault

password := "/run/user/1000/karo/vault_password"

# Manage an Ansible vault
setup-vault hostname:
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
        echo "error: {{password}} not found! Run 'just setup-password'" >&2
        exit 1
    fi

# (Internal use) Create the Ansible vault password file when missing
_check-password:
    @[ -e "{{password}}" ] || micro -mkparents true "{{password}}"

# Edit the Ansible vault password file
setup-password:
    @micro -mkparents true "{{password}}"

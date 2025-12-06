# SPDX-FileCopyrightText: 2025 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

# help

# Prints help
help:
    @{{ just_executable() }} --list --justfile "{{ justfile() }}"

# server

# Runs ansible-playbook to provision the debian server
setup-server: set-password
    ansible-playbook run.yml --tags setup

# compose

# Runs ansible-playbook to deploy docker compose stacks
setup-compose: set-password
    ansible-playbook run.yml --tags compose --skip-tags stop

# Runs ansible-playbook to stop docker compose stacks
stop-compose: set-password
    ansible-playbook run.yml --tags compose --skip-tags start

# Runs ansible-playbook to start docker compose stacks
start-compose: set-password
    ansible-playbook run.yml --tags compose

# misc

# Creates ansible-vault password file
set-password:
    @export P="/run/user/1000/karo/vault_password"; [ -e "$P" ] || micro -mkparents true "$P"

# Opens the ansible-vault password file
edit-password:
    @micro -mkparents true "/run/user/1000/karo/vault_password"

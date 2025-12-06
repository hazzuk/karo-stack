# SPDX-FileCopyrightText: 2025 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

# help

# Print help
help:
    @{{ just_executable() }} --list --justfile "{{ justfile() }}"

# server

# Host the Debian preseed.cfg file for use over a local network
preseed-server:
    python -m http.server 8000 --bind 0.0.0.0 --directory ./debian/server

setup-server: set-password
# Run ansible-playbook to provision the Debian server
    ansible-playbook run.yml --tags setup

# compose

setup-compose: set-password
# Run ansible-playbook to deploy Docker compose stacks
    ansible-playbook run.yml --tags compose --skip-tags stop

stop-compose: set-password
# Run ansible-playbook to stop Docker compose stacks
    ansible-playbook run.yml --tags compose --skip-tags start

start-compose: set-password
# Run ansible-playbook to start Docker compose stacks
    ansible-playbook run.yml --tags compose

# misc

# (Internal use) Create an ansible-vault password file
set-password:
    @export P="/run/user/1000/karo/vault_password"; [ -e "$P" ] || micro -mkparents true "$P"

# Open the ansible-vault password file
edit-password:
    @micro -mkparents true "/run/user/1000/karo/vault_password"

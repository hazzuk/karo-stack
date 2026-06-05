# Changelog

All notable changes to the karo-stack will be documented in this file.

## [2.0.0] - 2026-06-05

### 🚀 Features

- *(justfile)* Allow limiting server hostnames
- *(justfile)* Allow limiting compose hostnames
- *(compose)* [**breaking**] Deploy stacks inside directory groups
- *(compose)* Add forward auth toggle options
- *(justfile)* Add wireguard key gen recipe
- *(nftables)* Add icmp and logging options
- *(compose)* Add proxy stack
- *(compose)* Configure traefik proxy protocol
- *(nftables)* Automatically allow stack traffic
- *(compose)* Adjust haproxy config timeouts
- *(compose)* Allow custom domains in traefik
- *(justfile)* Allow preseeding different platforms
- *(docker)* Disable userland proxy in daemon.json
- *(docker)* Handle daemon.json changes
- *(system)* Load br_netfilter kernel module
- *(system)* Configure system hostname
- *(compose)* Inject secrets securely using files
- *(ansible)* Unify loop logging with labels
- *(justfile)* Reduce redundant compose role logging
- *(ansible)* Disable become_ask_pass by default
- *(compose)* Assert docker setup and stack name
- *(preseed)* Enable debian backports source
- Use pipx to install ansible and just

### 🐛 Bug Fixes

- *(preseed)* Do not hardcode locale or timezone
- *(nftables)* Add default values for compose vars
- *(nftables)* Remove wireguard interface check
- *(system)* Load kernel modules before karo-docker

### 🚜 Refactor

- *(compose)* Avoid double quotes in lookup vars
- *(compose)* Move templates inside group dirs
- *(docker)* Allow privileged ports with sysctl
- *(nftables)* Simplify input chain rules
- *(compose)* [**breaking**] Only use the root domain
- *(justfile)* Simplify recipe names/descriptions
- *(justfile)* Shorten echo messages
- *(justfile)* Unify compose recipes
- *(compose)* Rearrange the docker secrets
- *(ansible)* Remove with_items from playbook
- *(compose)* Restructure secrets variables
- *(compose)* Consolidate become/tags parameters
- *(compose)* Simplify stack name check
- *(compose)* Defer secrets dir creation
- *(system)* Wrap tasks inside blocks
- *(preseed)* Simplify late command
- Order system packages alphabetically
- *(system)* Change system tag to 'install'
- *(ansible)* Reorder system and nftables roles

### 📚 Documentation

- Remove karo-stack ascii image
- Update readme tagline and warning
- Add shields and not-by-ai badge to readme
- Add documentation site link to readme
- *(readme)* Update project tagline

### ⚙️ Miscellaneous

- *(ansible)* Remove unused rootful docker task
- *(compose)* Normalise glance stack uid
- *(compose)* Remove unused glance stack volume
- Update compose template links to karo-docs
- Add cspell file to gitignore
- *(compose)* Allow more control over haproxy config
- *(justfile)* Use simpler recipe name for wireguard
- *(compose)* Update proxy stack haproxy version
- *(compose)* Update pocketid stack
- *(compose)* Update traefik stack
- *(compose)* Update tinyauth for traefik stack
- *(compose)* Update qui for qbittorrent stack
- *(compose)* Update seerr stack
- *(compose)* Update non-breaking stacks
- *(compose)* Mark qui_oidc_client_secret as a secret
- *(ansible)* Unify tmpfs directory path usage
- *(compose)* Disable marking secrets tasks as changed
- Change ssh directory modes

## [1.0.0] - 2026-02-10

### 🚀 Features

- *(justfile)* Add ansible-vault recipes
- *(system)* Add password file clean-up task
- *(justfile)* Add preseed recipe
- *(justfile)* Insert local ssh key into preseed file
- *(justfile)* Add recipe to manage ansible vaults
- *(system)* Set default directory for karo user
- *(ansible)* Create karo-git role
- *(git)* Add defaults for karo-git role
- *(compose)* Add godns dynamic dns client stack
- *(compose)* Add gluetun vpn client stack
- *(compose)* Add timezone variable
- *(compose)* Add qbittorrent downloads manager stack
- *(nftables)* Allow for custom udp and tcp ports
- *(compose)* Fetch public domain tls cert
- *(compose)* Set traefik frontend static ip
- *(justfile)* Allow for compose recipe parameters
- *(compose)* Add pocket-id oidc stack
- *(compose)* Add prowlarr indexer manager stack
- *(compose)* Add servarr media management stack
- *(compose)* Add seerr media requests stack
- *(compose)* Add jellyfin media server stack
- *(compose)* Add ntfy push notifications stack
- *(compose)* Add tinyauth forward auth stack
- *(compose)* Add forward auth to existing stacks
- *(compose)* Add more log_level variables to stacks
- *(compose)* Add glance dashboard stack
- *(changelog)* Add git-cliff config

### 🐛 Bug Fixes

- *(preseed)* Skip redundant partition method selection
- *(justfile)* Use python3 command for preseed
- *(compose)* Log errors from start-up order

### 🚜 Refactor

- *(docker)* Use ansible copy for bash profile task
- *(justfile)* Remove start-compose recipe
- *(compose)* Move when conditions into lists
- *(compose)* Add stack domain variables
- *(compose)* Reposition defaults variables
- *(compose)* Sort defaults alphabetically
- *(compose)* Remove unused nginx demo container
- *(compose)* Move docker image values to variables
- *(compose)* Remove defaults placeholder values
- *(compose)* Standardise healthcheck format
- *(compose)* Split servarr stack into radarr sonarr
- *(ansible)* Change vault password file path
- *(compose)* Explicitly define tinyauth domains

### ⚙️ Miscellaneous

- *(ansible)* Move files to repository root
- *(ansible)* Move inventory directory path
- *(ansible)* Change vault password location
- *(justfile)* Use imperative tone for recipe descriptions
- *(justfile)* Improve help recipe readability
- *(justfile)* Reword password recipes
- *(justfile)* Reword more recipes and comments
- *(system)* Add parted and rsync packages
- *(compose)* Update qbittorrent defaults
- *(compose)* Update traefik docker image
- *(compose)* Update traefik defaults
- *(compose)* Rename traefik acme docker volume
- *(compose)* Rename compose's start & stop tasks
- *(compose)* Add missing compose deploy tags
- *(compose)* Clarify cetusguard log level

### 🛡️ Security

- *(ansible)* Prevent micro editor disclosures
- *(ansible)* Use tmpfs for tmp directory
- *(compose)* Tighten qbittorrent's compose

<!-- generated by git-cliff -->

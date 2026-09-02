<div align="center">

# karo-stack

**An open-source toolkit for creating a declarative Linux homeserver**

[![Latest release](https://img.shields.io/github/v/release/hazzuk/karo-stack?display_name=tag&cacheSeconds=7200&label=latest)](https://github.com/hazzuk/karo-stack/releases)
[![License](https://img.shields.io/badge/license-AGPL--3.0-B461B3)](https://github.com/hazzuk/karo-stack/blob/main/LICENSE)
[![Hits-of-Code](https://hitsofcode.com/github/hazzuk/karo-stack)](https://hitsofcode.com/github/hazzuk/karo-stack/view)

[![Developed by Humans, Not by AI](https://hazzuk.github.io/assets/not-by-ai/dev.svg)](https://notbyai.fyi/)

<picture>
    <img src="https://hazzuk.github.io/assets/karo-stack/header.png" alt="Connecting to a karo-stack homeserver using SSH">
</picture>

</div>

## About

The karo-stack enables users to reliably and efficiently deploy a personalised,
self-hosted homeserver.

It's a smaller, comprehensible alternative to an all-encompassing,
abstracted solution like Proxmox, Unraid or TrueNAS.
It assists with installing a lightweight Debian Linux operating system.
Then further configuration is all performed declaratively,
using Ansible and Git.
This includes creating a secure 'rootless' Docker environment.

Knowledge of these different underlying technologies is not required,
as the project is accompanied by both in-depth documentation,
and a simplified set of project-specific commands.

It also provides an extensible system for community-maintained,
'write once, run anywhere'-style Docker Compose stacks.

This project is the result of nearly a decade of self-hosting experience.
It is free and open-source under the AGPL-v3 license.
Written with careful consideration, attention to detail, readability,
and long-term stability in mind.

## Documentation

Learn more about the project at [docs.karolabs.dev](https://docs.karolabs.dev/).

## Repositories

- **karo-stack** - Core server configuration (Debian preseed and Ansible playbook)

- [karo-custom](https://github.com/hazzuk/karo-custom) - Official custom files (Docker Compose stacks)

- [karo-docs](https://github.com/hazzuk/karo-docs) - The project's documentation site

- [karo-cli](https://github.com/hazzuk/karo-cli) - Tool for generating and linting karo-custom setups

## Copyright & License

Copyright © hazzuk. Licensed AGPL-3.0-only.

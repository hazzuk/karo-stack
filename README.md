<div align="center">

# karo-stack

**A minimal toolkit for building a declarative Linux homeserver**

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

It's a smaller, more comprehensible alternative to an all-encompassing,
abstracted solution like Proxmox, Unraid or TrueNAS.
It assists with the installation of a lightweight Debian Linux operating system.
Then further configuration is all performed declaratively,
using Ansible and Git. This includes creating a dedicated
'rootless' Docker environment to run services more securely.

Prior knowledge of these underlying technologies isn't required,
as the project is accompanied by both in-depth documentation
and a set of simplified, project-specific commands.

It also provides an extensible system for community-maintained,
'write once, run anywhere'-style Docker Compose stacks.
This means users can easily deploy numerous templated stacks,
designed to work smoothly together on a karo-stack homeserver.

The project is completely free and open-source software,
written with careful consideration and long-term stability in mind.
It is a deliberately minimal and opinionated toolkit,
built to provide a focused set of practical features.
It takes care of the fundamentals needed for a well-optimised homeserver,
while preserving the user's sovereignty over their system.

## Documentation

Learn more about the project at [docs.karolabs.dev](https://docs.karolabs.dev/).

## Repositories

- **karo-stack** - Core server configuration (Debian preseed and Ansible playbook)

- [karo-custom](https://github.com/hazzuk/karo-custom) - Official custom files (Docker Compose stacks)

- [karo-docs](https://github.com/hazzuk/karo-docs) - The project's documentation site

- [karo-cli](https://github.com/hazzuk/karo-cli) - Tool for generating and linting karo-custom setups

## Copyright & License

Copyright © hazzuk. Licensed AGPL-3.0-only.

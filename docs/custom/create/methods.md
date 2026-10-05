---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/shapes
---

# Setup methods

There are multiple possible approaches to deploying
Docker stacks on a karo-stack homeserver:

-   **Don't want to create a custom stack?**
    - Deploy stacks from an [existing karo-custom repo](../deploy/stacks.md)

-   **Want to create a custom stack and allow others to use it?**
    - Create stacks inside a new public karo-custom repo

-   **Want to create a custom stack but keep it private?**
    - Create stacks within your personal karo-inventory repo

---

This page also discusses the following options:

- Fork an existing existing karo-custom repo

- Deploy regular Docker Compose files manually

## Existing stacks

It's worth checking if the stack you want to deploy (or something similar)
isn't already provided by an existing karo-custom repo.
If this is the case, but you want options for additional configuration,
contact the karo-custom repo's maintainer,
and see if they're able to help.

Alternatively, if a stack does already exist in another repo,
but you want to make larger changes, or the stack is no longer maintained.
Consider forking the repo and updating it yourself.

## Manual Docker stacks

The karo-stack creates a normal Docker environment (running in rootless mode),
where you can execute standard Docker commands.
Because of this, it remains possible to deploy any regular Docker Compose file.
Even while running custom stacks deployed using Ansible
(though this approach should generally be avoided).

This can be a good option if you're moving from a previous server setup.
And don't want to immediately convert existing compose files.

Read the [Manual Docker stacks guide](../../advanced/docker.md).

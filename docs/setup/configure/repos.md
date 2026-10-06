---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/book-copy
---

# Repositories

## Inventory repo

You'll need to create your inventory repo.
This git repository will be used to store your personal configuration for the karo-stack.

-   [Create a new private git repo](https://github.com/new)
    named `karo-inventory` on GitHub

    - Visibility: :lucide-lock: Private
    - Readme: (Optional)
    - And `No .gitignore`, `No license`

??? question "Why use git?"

    Storing your configuration using git brings many benefits.
    Most importantly, it makes restoring your setup after a hardware failure
    or a move to a new system much simpler.
    Additionally, you'll get the full history of any changes you commit.
    So you can always revert back to a previous version of your configuration
    if something goes wrong.

??? question "First time using git?"

    While git does have a lot of features,
    and in some situations can become somewhat complex.
    For what the karo-stack needs,
    using git will be relatively straight forward.
    Simply follow the the commands shown,
    and you should get everything configured correctly.

## Clone the repos

Connected to your server via SSH,
run the following commands to clone the required repos locally.
Make sure to modify the first command to include your GitHub username.

-   Clone the karo-stack and your private karo-inventory repository:

    --8<-- "docs/snippets.md:git_clone"

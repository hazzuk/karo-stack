---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/package
---

Having used the preseed file for Debian's installation,
the system only installed a minimal number of packages.
Plus, a few hand-picked packages for convenience (e.g. `git`, `micro`, `btop`).

But to run the karo-stack, you'll need to install both `ansible` and `just`.

-   Install additional packages:

    --8<-- "docs/snippets.md:copying_commands"

    --8<-- "docs/snippets.md:terminal_paste"

    --8<-- "docs/snippets.md:pipx_install"

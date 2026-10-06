---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/notebook-pen
---

# Documentation

!!! info "Zensical documentation"

    A full authoring guide for writing markdown pages with Zensical can be [found here](https://zensical.org/docs/authoring/markdown/).

## Icons

### Generic

The docs primarily uses `lucide`.
Zensical also provides other [icon sources](https://zensical.org/docs/authoring/icons-emojis/):

- `fontawesome` (/brands /regular /solid)
- `material`
- `octicons` (append 16 or 24)
- `simple`

### Custom

For [custom icons](https://zensical.org/docs/setup/logo-and-icons/#additional-icons),
the docs uses the `docs/assets/overrides/.icons/` directory.

This contains **dark** `svg` icons sourced from:

- [selfh.st/icons](https://selfh.st/icons/)
- [dashboardicons.com/icons](https://dashboardicons.com/icons)

??? note "Zensical themed icons"

    New files should be edited to include the following attribute:

    (Added after the `xmlns` attribute)

    ``` c
    fill="currentColor"
    ```

    This ensures icons work in both light and dark modes.

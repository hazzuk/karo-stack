---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/container
---

# Manual Docker stacks

You can still create Docker `compose.yml` files directly on the server and run them manually.

To do this, you'll need to SSH in as the `dockeruser`.

> e.g. `ssh dockeruser@homeserver.example.com` or `ssh dockeruser@192.168.0.142`

Afterwards, you're free to create Docker Compose stacks manually.
It's recommended you place these files under `/srv/docker/local`.

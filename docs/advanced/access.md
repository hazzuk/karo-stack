---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/users
---

# External access

If you want services to be accessible externally, the easiest method is to expose your home network's public IP address. And configure opening ports `80` and `443` in your router, which should be pointed at your server's local IPv4 address.

??? info "Alternative method (advanced)"

    Alternatively, for better security (or if you're behind CGNAT) you can avoid opening ports and exposing your home network's public IPv4 address. Instead, it's strongly recommended to rent a small VPS. Where this second server will proxy sanitised external traffic on towards your server.

    Read the [VPS proxy](proxy.md) guide for how to configure this method.

## Public IP address

Most residential ISP's will periodically rotate your public IP address. So you'll need to use a dynamic DNS service, like the one provided by the karo-stack. This'll automatically create a DNS `A` record. And run continuously to update the record whenever your public IP address rotates.

Running your dynamic DNS service, you'll see a new DNS record similar to the following example:

| Type | Name     | Target               |
| ---- | -------- | -------------------- |
| A    | `dyndns` | `<home public ipv4>` |

## Exposing services

The project has a straightforward security model for exposing services publicly:

> Internal access is implicit, external access is always explicit.

What this means in practice is that for each service you need to expose, you'll explicitly create a matching DNS record (like the following example):

| Type  | Name       | Target               | Comment                   |
| ----- | ---------- | -------------------- | ------------------------- |
| CNAME | `jellyfin` | `dyndns.example.com` | jellyfin - public traffic |

Visiting `jellyfin.example.com` will now point to your home network's public IPv4 address (instead of your server's internal address).

!!! warning

    You should only expose services when it is absolutely necessary. Even with the hardened security practices implemented by the karo-stack. Every publicly accessible service is another possible attack vector for bad actors to potentially exploit.

## Routing internal traffic

By default, you can only access your services from the same home network as your server. However, when you expose services like shown above, all traffic (including internal traffic) is now instead pointed at your network's public IP address.

This can sometimes be problematic (and is just generally inefficient). So instead, it's recommended to setup an internal DNS server inside your home network. Which will then override the DNS records you've set publicly.

The easiest method is doing this with your router (if it supports configuring custom DNS records). Alternatively, you can run your own DNS server (which in future will be provided as an extra [stack](https://github.com/hazzuk/karo-stack/issues/30)).

You'll then simply need to set the following custom DNS record:

| Type | Name            | Target                |
| ---- | --------------- | --------------------- |
| A    | `*.example.com` | `<server local ipv4>` |

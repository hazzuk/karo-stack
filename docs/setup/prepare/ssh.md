---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/key-round
---

# SSH keys

SSH (Secure Shell Protocol) is a network protocol used to cryptographically communicate over an unsecured network.
Its main use will be to securely connect to and authenticate with the server.

??? question "How does SSH work?"

    You'll create an SSH key pair, which is a form of asymmetric cryptography.
    This means you have both a public and private key.
    You add the public key to places you want to access (e.g. the server, our GitHub account).
    Then when a request for access is made, they use the stored public key to verify a challenge.
    Which only someone with the private key could correctly respond to.

## Setup

The easy and secure way to store SSH keys is inside a password manager.
Ideally one with a desktop client that supports acting as an SSH Agent.

1.  Set up your desktop password manager to act as an SSH agent.

    > e.g. [1Password](https://developer.1password.com/docs/ssh/agent),
    [Bitwarden](https://bitwarden.com/help/ssh-agent/),
    [KeePassXC](https://keepassxc.org/docs/#faq-ssh-agent-how).

2.  Generate two SSH key pairs.

    !!! info "Key types"

        Generating Ed25519 keys is recommended over using RSA or ECDSA.

    - `key1 - auth`
    - `key2 - signing` (Used later on with git)

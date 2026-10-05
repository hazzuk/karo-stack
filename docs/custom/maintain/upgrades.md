---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/circle-fading-arrow-up
---

# Container upgrades

Version upgrades for containers should be performed on a regularly occurring basis.
And any security updates should always be applied promptly.

## Updating stacks

Version upgrades are performed manually, and the software should always be reviewed for any new important changes.

!!! tip "Test environment"

    It's highly recommended to setup the karo-stack inside a test environment (virtual machine or second server).
    And avoid testing new updates in your live environment, unless you've made backups of your stacks.

For each container...

1.  Review each subsequent release made since the current version (note any breaking changes).
    And select a recent stable version of the software (stability is preferred over new releases).

2.  Prepare a test environment with the previous version of the stack running (ideally with log levels adjusted to be more verbose).

3.  Update the image version in the stack's defaults file.

4.  Down and up the stack to test the new version of the software, reviewing the container's logs.

    ``` sh
    docker logs foobar -f
    ```

5.  Make any additional changes required to the compose file or configs, then test again.

See [this Pull Request](https://github.com/hazzuk/karo-stack/pull/64/commits) for an example of the changes that might be required when updating stacks.

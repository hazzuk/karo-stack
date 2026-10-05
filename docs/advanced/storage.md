---
# SPDX-FileCopyrightText: © 2026 hazzuk
#
# SPDX-License-Identifier: AGPL-3.0-only

icon: lucide/hard-drive
---

# Storage devices

Aside from your system drive being automatically formatted by the Debian installer. The karo-stack does not automate the configuration of storage devices. Everyone's setup is different, and so automation across so many use cases would carry unnecessary risk. Instead, this page aims to provide general guidance on how to configure storage devices attached to your system.

!!! tip "Backups"

    It is critical you backup your important data. It's a good idea to follow the 3-2-1 backup rule:

    - 3 - Maintain **three** copies of your data.

    - 2 - Store the data on **two** different media types.

    - 1 - Store **one** copy off-site.

    Your three copies includes the original data. Your two forms of media could vary from using SSD, HDD, Tape, M-DISC, Cloud. And your one off-site copy should ideally be separated by a large geographical distance.

## Partition and format

!!! info "In-depth tutorials"

    For more detailed guides, the following tutorials written by DigitalOcean are highly recommended:

    - [Partition and format storage devices in Linux](https://www.digitalocean.com/community/tutorials/how-to-partition-and-format-storage-devices-in-linux)

    - [How to use rsync to sync local and remote directories](https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories)

This is an example workflow demonstrating the following:

- Formatting the disk `/dev/sda`

- Creating an ext4 partition spanning the entire drive

- Mounting the partition using `/etc/fstab`

!!! danger

    All data on the targeted disk will be erased!

1.  Format the drive

    ``` sh { .no-copy }
    # list drives
    sudo parted -l
    ```

    ``` sh { .no-copy }
    # wipe drive partition table
    sudo parted /dev/sda mklabel gpt
    ```

2.  Partition the drive

    ``` sh { .no-copy }
    # create new ext4 partition
    sudo parted -a opt /dev/sda mkpart primary ext4 0% 100%
    ```

    ``` sh { .no-copy }
    # initialise ext4 filesystem
    # sda1 (partition), not sda (drive)
    sudo mkfs.ext4 -L drive1 /dev/sda1
    ```

3.  Mount the partition

    ``` sh { .no-copy }
    # find partition uuid
    lsblk --fs
    ```

    ``` sh { .no-copy }
    # create mountpoint
    sudo mkdir /media/drive1
    ```

    ``` sh { .no-copy }
    # edit fstab
    sudo micro /etc/fstab
    ```

    ``` ini { .no-copy title="/etc/fstab" }
    UUID=86b13cc7-tn2m... /media/drive1 ext4 defaults,nofail 0 2
    ```

    ``` sh { .no-copy }
    # mount fstab entries
    sudo mount -a
    sudo systemctl daemon-reload
    ```

    ``` sh { .no-copy }
    # list partitions and sizes
    df -h -x tmpfs
    ```

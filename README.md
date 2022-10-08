# Arch install scripts

This will eventually (hopefully) be a full install script to replace (and do
more than) the python `archinstall` tool from the Arch Linux ISO. It will
perform disk partitioning (interactively, with optional encryption), prompt for
root password and creation of additional users, and (once basic installation is
completed) install an i3-gaps system configured to my liking and with all of my
configs setup for me.

# TODO

* Disk partitioning
  * Prompt user to select installation block device (TODO: `lsblk` vs other
  methods)
  * To start with, simply run `fdisk` and allow the user to partition the disk
* Partition encryption (`dm_crypt`, etc.)
* Allow selecting file system
* More complex mount options (e.g. partition for `/home`)
* User setup
  * Root password
  * Prompt for additional users (in the same way as `archinstall`)
    * Prompt: enter username, or leave blank to continue with no more users
    * set password (with verification - probably leave this to `passwd`)
    * Should this user be a sudoer? (Maybe add additional options for `NOPASSWD`
    etc.)
* Configure root-level config files in the new root (e.g.
`/etc/ssh/sshd_config`, `/etc/pacman.conf`, etc.)
  * Crontabs
* Install all `pacman` packages (TODO: decide copying chroot scripts vs somehow
passing arguments to the top-level chroot script)
* Download and install AUR helper (yay)
* Install all AUR packages
* Download all user configs and custom scripts (e.g. `~/.config`, `~/.scripts`,
etc.)
  * Create all required symlinks for my setup (`~/.bashrc ->
  ~/.config/bash/bashrc`, etc.)
* Download and install custom built-from-source software (e.g.
`desktop-background.service`)

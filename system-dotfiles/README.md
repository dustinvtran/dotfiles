## File Paths

This documents the file paths for the system files I edited above, as well as a short description if unclear.

* `groups`: The `groups` command echo'd into a file.
* `package-list`: See `.zshrc` for the command. It's made to list all manually installed packages.
* `systemctl`: The `systemctl` command echo'd into a file.
* `/etc/fstab`
* `/etc/grub`
* `/etc/pacman.conf`
* `/etc/sudoers`
* `/etc/pacman.d/mirrorlist`
* `/etc/systemd/logind.conf`
* `/etc/udev/rules.d/hdmi.rules`
* `/etc/udev/rules.d/power-supply.rules`
* `/etc/X11/xorg.conf.d/60-synaptics-conf`: Touchpad configuration, which uses `60` to take priority over the default `50-synaptics-conf`, if it exists (using `50-synaptics-conf` itself may be overwritten on an update).
* `/usr/lib/python3.3/site-packages/ranger/gui/widgets/statusbar.py:` These are changes made in ranger's installation files
  which directly modify the interface. Substitute with these two files if you want ranger to look like my current setup.
* `/usr/lib/python3.3/site-packages/ranger/gui/ui.py`:  These are changes made in ranger's installation files which
  directly modify the interface. Substitute with these two files if you want ranger to look like my current setup.
* `/var/spool/cron/nil`

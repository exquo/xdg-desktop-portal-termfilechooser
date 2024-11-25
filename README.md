# xdg-desktop-portal-termfilechooser

[xdg-desktop-portal] backend for choosing files with your favorite file chooser.
By default, it will use the [ranger] file manager, but this is customizable.
Based on [xdg-desktop-portal-wlr] (xdpw).

## Installation

### Dependencies

Install the required packages. On apt-based systems:

	sudo apt install xdg-desktop-portal build-essential ninja-build meson libinih-dev libsystemd-dev scdoc

For Arch, see the dependencies in the [AUR package](https://aur.archlinux.org/packages/xdg-desktop-portal-termfilechooser-git#pkgdeps).

### Download the source

	git clone https://github.com/exquo/xdg-desktop-portal-termfilechooser

### Build

	cd xdg-desktop-portal-termfilechooser
	meson build
	ninja -C build
	ninja -C build install  # run with superuser privileges

On Debian, move the `termfilechooser.portal` file:

	sudo mv /usr/local/share/xdg-desktop-portal/portals/termfilechooser.portal /usr/share/xdg-desktop-portal/portals/

### Config files

Copy the `config` and any of the wrapper scripts in `contrib` dir to `~/.config/xdg-desktop-portal-termfilechooser`. Edit the files to set your preferred terminal emulator and file manager applications.
See the [man page](xdg-desktop-portal-termfilechooser.5.scd) for description of the `config` file parameters.

### Disable the original file picker portal

Check the version of xdg-desktop-portal on your system:

	xdg-desktop-portal --version

(If `xdg-desktop-portal` executable is not found on `$PATH`, try):

	/usr/libexec/xdg-desktop-portal --version

If your version is >= [`1.18.0`](https://github.com/flatpak/xdg-desktop-portal/releases/tag/1.18.0) you can specify the portal for FileChooser in `~/.config/xdg-desktop-portal/portals.conf` file (see the [flatpak docs](https://flatpak.github.io/xdg-desktop-portal/docs/portals.conf.html) and [ArchWiki](wiki.archlinux.org/title/XDG_Desktop_Portal#Configuration)):

	org.freedesktop.impl.portal.FileChooser=termfilechooser

If your `xdg-desktop-portal --version` is older, you can remove `FileChooser` from `Interfaces` of the `{gtk;kde;…}.portal` files:

	find /usr/share/xdg-desktop-portal/portals -name '*.portal' -not -name 'termfilechooser.portal' \
		-exec grep -q 'FileChooser' '{}' \; \
		-exec sudo sed -i'.bak' 's/org\.freedesktop\.impl\.portal\.FileChooser;\?//g' '{}' \;


### Systemd service

Restart the portal service:

	systemctl --user restart xdg-desktop-portal.service

### Test

	GTK_USE_PORTAL=1  zenity --file-selection

and additional options: `--multiple`, `--directory`, `--save`.

#### Troubleshooting

- After editing termfilechooser's config, restart its service:

		systemctl --user restart xdg-desktop-portal-termfilechooser.service

- The termfilechooser's executable can also be launched directly:

		systemctl --user stop xdg-desktop-portal-termfilechooser.service
		/usr/local/libexec/xdg-desktop-portal-termfilechooser -r &

	This way the output from the wrapper scripts (e.g. `ranger-wrapper.sh`) will be written to the same terminal; handy for debugging.
	When termfilechooser runs as a `systemd` service, its output can be viewed with `journalctl`.

- Since [this merge request in GNOME](https://gitlab.gnome.org/GNOME/gtk/-/merge_requests/4829), `GTK_USE_PORTAL=1` seems to be replaced with `GDK_DEBUG=portals`.

- See also: [Troubleshooting section in ArchWiki](wiki.archlinux.org/title/XDG_Desktop_Portal#Troubleshooting).

- A [discussion](https://github.com/GermainZ/xdg-desktop-portal-termfilechooser/issues/3) of the termfilechooser installation process. (Most relevant information from that thread had been incorporated into this README)


## Usage

Firefox has a setting in its `about:config` to always use the XDG desktop portal's file chooser: set `widget.use-xdg-desktop-portal.file-picker` to `1`. See https://wiki.archlinux.org/title/Firefox#XDG_Desktop_Portal_integration.


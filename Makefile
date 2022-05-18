.PHONY: pr2-users pr2-ft pr2-core pr2-core-noetic pr2-udev pr2-netboot pr2-network pr2-iptables.d pr2-ckill pr2-grant pr2-kernel pr2-kernel-headers executable-selector

all: install-dpkg-dev pr2-users pr2-ft pr2-core pr2-core-noetic pr2-udev pr2-netboot pr2-network pr2-iptables.d pr2-ckill pr2-grant pr2-kernel-meta executable-selector

install:
	cd debs/; dpkg -i pr2-users_*.deb pr2-ft_*.deb pr2-core_*.deb pr2-core-noetic_*.deb pr2-udev_*.deb pr2-netboot_*.deb pr2-network_*.deb pr2-iptables.d_*.deb pr2-ckill_*.deb pr2-grant_*.deb pr2-kernel_*.deb pr2-kernel-headers_*.deb executable-selector_*.deb

clean:
	rm debs/* -f
	cd executable-selector/; git clean -fxd .
	cd pr2-ckill/; git clean -fxd .
	cd pr2-core/; git clean -fxd .
	cd pr2-core-noetic/; git clean -fxd .
	cd pr2-ft/; git clean -fxd .
	cd pr2-grant/; git clean -fxd .
	cd pr2-iptables.d/; git clean -fxd .
	cd pr2-kernel-meta/; git clean -fxd .
	cd pr2-netboot/; git clean -fxd .
	cd pr2-network/; git clean -fxd .
	cd pr2-udev/; git clean -fxd .
	cd pr2-users/; git clean -fxd .

purge:
	sudo apt purge pr2-core pr2-core-noetic pr2-ft pr2-users pr2-netboot pr2-network pr2-iptables.d pr2-ckill pr2-grant pr2-kernel pr2-kernel-headers executable-selector

install-dpkg-dev:
	sudo apt install -y dpkg-dev fakeroot debhelper cdbs

pr2-udev: pr2-udev/* pr2-core
	cd pr2-udev/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-udev_*.buildinfo pr2-udev_*.changes pr2-udev_*.deb pr2-udev_*.dsc pr2-udev_*.tar.gz debs/

pr2-core: pr2-core/* pr2-users pr2-ft
	sudo apt install -y fortunes fortune-mod
	cd pr2-core/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-core_*.buildinfo pr2-core_*.changes pr2-core_*.deb pr2-core_*.dsc pr2-core_*.tar.gz pr2-core-dbgsym_*.ddeb debs/

pr2-core-noetic: pr2-core-noetic/*
	sudo apt install -y ros-noetic-pr2-robot ros-noetic-openni-launch
	cd pr2-core-noetic/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-core-noetic_*.buildinfo pr2-core-noetic_*.changes pr2-core-noetic_*.deb pr2-core-noetic_*.dsc pr2-core-noetic_*.tar.gz debs/

pr2-ft: pr2-ft/*
	sudo apt install -y subversion
	cd pr2-ft/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-ft_*.buildinfo pr2-ft_*.changes pr2-ft_*.deb pr2-ft_*.dsc pr2-ft_*.tar.gz debs/

pr2-users: pr2-users/*
	sudo apt install -y config-package-dev
	cd pr2-users/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-users_*.buildinfo pr2-users_*.changes pr2-users_*.deb pr2-users_*.dsc pr2-users_*.tar.gz debs/

pr2-netboot: pr2-netboot/* pr2-network executable-selector
	sudo apt install -y nfs-kernel-server nfs-client atftpd dnsmasq unionfs-fuse portmap
	cd pr2-netboot/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-netboot_*.buildinfo pr2-netboot_*.changes pr2-netboot_*.deb pr2-netboot_*.dsc pr2-netboot_*.tar.gz debs/

pr2-network: pr2-network/* pr2-iptables.d
	sudo apt install -y hostapd bridge-utils
	cd pr2-network/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-network_*.buildinfo pr2-network_*.changes pr2-network_*.deb pr2-network_*.dsc pr2-network_*.tar.gz debs/

pr2-iptables.d: pr2-iptables.d/*
	cd pr2-iptables.d/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-iptables.d_*.buildinfo pr2-iptables.d_*.changes pr2-iptables.d_*.deb pr2-iptables.d_*.dsc pr2-iptables.d_*.tar.gz debs/

pr2-ckill: pr2-ckill/*
	cd pr2-ckill/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-ckill_*.buildinfo pr2-ckill_*.changes pr2-ckill_*.deb pr2-ckill_*.dsc pr2-ckill_*.tar.gz debs/

pr2-grant: pr2-grant/*
	sudo apt install -y libcap-dev
	cd pr2-grant/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-grant_*.buildinfo pr2-grant_*.changes pr2-grant_*.deb pr2-grant_*.dsc pr2-grant_*.tar.gz pr2-grant-dbgsym_*.ddeb debs/

pr2-kernel-meta: pr2-kernel-meta/*
	sudo apt install -y linux-image-5.13.0-41-lowlatency linux-headers-5.13.0-41-lowlatency
	cd pr2-kernel-meta/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-kernel-meta_*.buildinfo pr2-kernel-meta_*.changes pr2-kernel_*.deb pr2-kernel-headers_*.deb pr2-kernel-meta_*.dsc pr2-kernel-meta_*.tar.gz debs/

executable-selector: executable-selector/*
	cd executable-selector/; dpkg-buildpackage -rfakeroot -us -uc
	mv executable-selector_*.buildinfo executable-selector_*.changes executable-selector_*.deb executable-selector_*.dsc executable-selector_*.tar.gz debs/

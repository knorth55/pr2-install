.PHONY: pr2-users pr2-ft pr2-core pr2-core-noetic pr2-netboot pr2-network pr2-iptables.d

all: install-dpkg-dev pr2-users pr2-ft pr2-core pr2-core-noetic pr2-netboot pr2-network pr2-iptables.d

install:
	cd debs/; dpkg -i pr2-users_*.deb pr2-ft_*.deb pr2-core_*.deb pr2-core-noetic_*.deb pr2-netboot_*.deb pr2-network_*.deb pr2-iptables.d_*.deb

clean:
	rm debs/* -f
	cd pr2-core/; git clean -fxd .
	cd pr2-core-noetic/; git clean -fxd .
	cd pr2-ft/; git clean -fxd .
	cd pr2-users/; git clean -fxd .
	cd pr2-netboot/; git clean -fxd .
	cd pr2-network/; git clean -fxd .
	cd pr2-iptables.d/; git clean -fxd .

purge:
	sudo apt purge pr2-core pr2-core-noetic pr2-ft pr2-users pr2-netboot pr2-network pr2-iptables.d

install-dpkg-dev:
	sudo apt install dpkg-dev fakeroot debhelper cdbs

pr2-core: pr2-core/* pr2-users pr2-ft
	sudo apt install fortunes fortune-mod 
	cd pr2-core/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-core_*.buildinfo pr2-core_*.changes pr2-core_*.deb pr2-core_*.dsc pr2-core_*.tar.gz pr2-core-dbgsym_*.ddeb debs/

pr2-core-noetic: pr2-core-noetic/*
	sudo apt install ros-noetic-pr2-robot ros-noetic-openni-launch
	cd pr2-core-noetic/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-core-noetic_*.buildinfo pr2-core-noetic_*.changes pr2-core-noetic_*.deb pr2-core-noetic_*.dsc pr2-core-noetic_*.tar.gz debs/

pr2-ft: pr2-ft/*
	sudo apt install subversion
	cd pr2-ft/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-ft_*.buildinfo pr2-ft_*.changes pr2-ft_*.deb pr2-ft_*.dsc pr2-ft_*.tar.gz debs/

pr2-users: pr2-users/*
	sudo apt install config-package-dev 
	cd pr2-users/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-users_*.buildinfo pr2-users_*.changes pr2-users_*.deb pr2-users_*.dsc pr2-users_*.tar.gz debs/

pr2-netboot: pr2-netboot/* pr2-network executable-selector
	sudo apt install nfs-kernel-server nfs-client atftpd dnsmasq unionfs-fuse portmap
	cd pr2-netboot/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-netboot_*.buildinfo pr2-netboot_*.changes pr2-netboot_*.deb pr2-netboot_*.dsc pr2-netboot_*.tar.gz debs/

pr2-network: pr2-network/* pr2-iptables.d
	sudo apt install hostapd bridge-utils
	cd pr2-network/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-network_*.buildinfo pr2-network_*.changes pr2-network_*.deb pr2-network_*.dsc pr2-network_*.tar.gz debs/

pr2-iptables.d: pr2-iptables.d/*
	cd pr2-iptables.d/; dpkg-buildpackage -rfakeroot -us -uc
	mv pr2-iptables.d_*.buildinfo pr2-iptables.d_*.changes pr2-iptables.d_*.deb pr2-iptables.d_*.dsc pr2-iptables.d_*.tar.gz debs/

executable-selector: executable-selector/*
	cd executable-selector/; dpkg-buildpackage -rfakeroot -us -uc
	mv executable-selector_*.buildinfo executable-selector_*.changes executable-selector_*.deb executable-selector_*.dsc executable-selector_*.tar.gz debs/

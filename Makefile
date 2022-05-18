.PHONY: pr2-users pr2-ft pr2-core pr2-core-noetic

all: install-dpkg-dev pr2-users pr2-ft pr2-core pr2-core-noetic

install:
	cd debs/; dpkg -i pr2-users_*.deb pr2-ft_*.deb pr2-core_*.deb pr2-core-noetic_*.deb

clean:
	rm debs/* -f
	cd pr2-core/; git clean -fxd .
	cd pr2-core-noetic/; git clean -fxd .
	cd pr2-ft/; git clean -fxd .
	cd pr2-users/; git clean -fxd .

install-dpkg-dev:
	sudo apt install dpkg-dev fakeroot debhelper cdbs

pr2-core: pr2-core/*
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


# pr2-install

PR2 package installation

## Description

Fork and modified packages for Noetic.

The submodules are originally from repo below: 
- [pr2-debs](https://github.com/pr2-debs)
- [pr2-debs-prime](https://github.com/pr2-debs-prime)

## Build deb packages

```bash
# deb files will be generated in debs/
make all
```

## Install

```bash
# install deb packages generated in debs/
sudo make install
```



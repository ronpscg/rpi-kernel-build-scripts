# Quick scripts for building a Raspberry Pi Kernel

Mostly used to crosscompile and populate kernel proper and modules:
- kernel would go into the `bootfs` partition potentially with the update of `kernel=<filename>` in `config.txt`
- modules would go under the `rootfs` /lib/modules/<kernelversions>

## Cloning the kernel sources
```
: ${MORE_GIT_OPTIONS=""}
git clone $MORE_GIT_OPTIONS https://github.com/raspberrypi/linux
```

Branches (-b <...>) have the following form `rpi-xxx' e.g. `rpi-6.6.y`

## Using the scripts
The scripts could not have been more obvious, so there is no need to document them.
Deliberately, to avoid cleanups of .configs that are being worked, there are several explicit phases, etc. the cycle is:
```
<scriptname>.sh defconfig
<scriptname>.sh menuconfig # if you need that
<scriptname>.sh build
<scriptname>.sh install # does both modules and modules install

There is also a modules_install target

If you seriously messed up and want to clean everything and restart you can do 
<scriptname>.sh mrproper

```

## What is left out (at least for now)
DTBs and DTB overlays, and overlays in general. I made the minimum necessary for devices that are already working.

## More info
https://www.raspberrypi.com/documentation/computers/linux_kernel.html


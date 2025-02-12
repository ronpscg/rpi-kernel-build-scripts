#!/bin/bash
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
export KSRC=$PWD/linux-5.4.y
export OUT=$PWD/rpi3/build/
export OUT_KERNEL=$OUT/kernel
export INSTALL=$PWD/rpi3/install
export KERNEL=kernel_2711
export DEFCONFIG=bcm2711_defconfig
export MODINSTDIR=$INSTALL/modules
export KERNINSTDIR=$INSTALL/kernel
: ${JOBS=$(nproc)}


mkdir -p $OUT || exit 1

do_defconfig() {
	make -C $KSRC O=$OUT_KERNEL $DEFCONFIG
}

do_menuconfig() {
	make -C $KSRC O=$OUT_KERNEL menuconfig
}

do_build() {
	make -C $KSRC O=$OUT_KERNEL Image modules dtbs -j$JOBS
}

do_modules_install() {
	make -C $KSRC O=$OUT_KERNEL INSTALL_MOD_PATH=$MODINSTDIR modules_install
}

do_install() {
	mkdir -p $KERNINSTDIR
	make -C $KSRC O=$OUT_KERNEL INSTALL_PATH=$KERNINSTDIR install
}

do_mrproper() {
	make -C $KSRC O=$OUT_KERNEL mrproper
}

case $1 in
	build)
		do_build
		;;
	defconfig)
		do_defconfig
		;;
	menuconfig)
		do_menuconfig
		;;
	modules_install)
		do_modules_install
		;;

	install)
		do_modules_install
		do_install
		;;
	mrproper)
		do_mrproper
		;;
	*)
		echo "Defaulting to build. We want you to do defconfig before doing this, but won't do it for you. Press any key to continue or ^C to cancel"
		read
		do_build
		;;
esac


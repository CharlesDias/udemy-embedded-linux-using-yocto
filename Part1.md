# Embedded Linux using Yocto - Part 1

[Udemy course link.](https://www.udemy.com/course/embedded-linux-using-yocto/)

Resume

* [1.1 - Build and using the core-image-minimal.](#1---build-and-using-the-core-image-minimal)
* [1.2 - Add lsusb to Yocto image.](#2---add-lsusb-to-yocto-image)
* [1.3 - Build and run an image desktop.](#3---build-and-run-an-image-desktop)

## 1 - Build and using the core-image-minimal

1. Clone the Poky project

```console
$ git clone -b kirkstone git://git.yoctoproject.org/poky
```

2. Create the export file to help export the environment variables.

```console
echo '#!/bin/sh' > export &&
echo 'BUILDDIR="../build_qemuarm"' >> export &&
echo '' >> export &&
echo 'cd poky' >> export &&
echo '. ./oe-init-build-env ${BUILDDIR}' >> export
```

3. Select the `MACHINE ?= "qemuarm"`  inside of build/conf/local.conf file.

4. Build the core-image-minimal reference image.

```console
$ bitbake -k core-image-minimal
```

5. Inside the poky/scripts folder has the runqemu script. Running the command below to see some options available to run the QEMU emulator.

```console
$ runqemu -h
```

6. Run generated image in QEMU.

```console
$ runqemu qemuarm core-image-minimal
```

7. When the QEMU finish the boot process, entre with the `root` user, without password.

Now, you can check some information, like the Kernel version

```console
# uname -a
```

CPU configuration

```console
# cat /proc/cpuinfo
```

The disk space

```console
# df -h
```

Noticed that the rootfs has the XXX size. Run the `ifconfig`

```console
# ifconfig
```

8. You can launch QEMU without the graphic window by adding the command line nographic. This way, the QEMU will be run ont he current console output.

```console
$ runqemu qemuarm core-image-minimal nographic
```

# 2 - Add lsusb to Yocto image

1. Stating the QEMU core-image-minimal.

```console
$ runqemu qemuarm core-image-minimal
```

2. After boot, check that the `lsusb` command is not available.

```console
$ lsusb
```

3. Oen the local.conf file and add the instructions below to add To add the `lsusb`. It is recommend to add a space before of the package name.

```text
IMAGE_INSTALL:append = " usbutils"
```

4. Check that the package was added to the IMAGE_INSTALL variable.

```console
$ bitbake -e core-image-minimal | grep ^IMAGE_INSTALL
```

5. Rebuild the image.

```console
$ bitbake core-image-minimal
```

And run QEMU.

```console
$ runqemu qemuarm core-image-minimal nographic
```

6. Check that `lsusb` is now available.

```console
# lsusb
```

7. The the new rootfs size

```console
# df -h
```

# 3 - Build and run an image desktop

1. The Poky has two reference desktop images, or **core-image-sato** and **core-image-weston**. 

The **core-image-sato** is the X11 Window-system-based image with a SATO theme and a GNOME mobile desktop environment.

The **core-image-weston** is a Wayland protocol and Weston reference compositor-based image.

Choose one of then and build. For example, core-image-weston

```console
$ bitbake core-image-weston
```

2. run the QEMU

```console
$ runqemu qemuarm core-image-weston
```
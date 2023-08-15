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

When the process finished, check the rootfs size.
```console
$ ls -l build_qemuarm/tmp/deploy/images/qemuarm/*.ext4
-rw-r--r-- 2 charlesdias charlesdias   9105408 ago 15 10:35 build_qemuarm/tmp/deploy/images/qemuarm/core-image-minimal-qemuarm-20230814192133.rootfs.ext4
```

The `core-image-minimal-qemuarm-20230814192133.rootfs.ext4` file has 9105408 bytes or 8.7MB.

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
root@qemuarm:~# uname -a
Linux qemuarm 5.15.120-yocto-standard #1 SMP PREEMPT Thu Jul 6 20:06:50 UTC 2023 armv7l GNU/Linux
```

CPU configuration

```console
root@qemuarm:~# cat /proc/cpuinfo 
processor       : 0
model name      : ARMv7 Processor rev 1 (v7l)
BogoMIPS        : 125.00
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc0f
CPU revision    : 1

processor       : 1
model name      : ARMv7 Processor rev 1 (v7l)
BogoMIPS        : 125.00
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc0f
CPU revision    : 1

processor       : 2
model name      : ARMv7 Processor rev 1 (v7l)
BogoMIPS        : 125.00
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc0f
CPU revision    : 1

processor       : 3
model name      : ARMv7 Processor rev 1 (v7l)
BogoMIPS        : 125.00
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x2
CPU part        : 0xc0f
CPU revision    : 1

Hardware        : Generic DT based system
Revision        : 0000
Serial          : 0000000000000000
```

The disk space

```console
root@qemuarm:~# df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/root                 7.0M      4.5M      1.9M  71% /
devtmpfs                117.3M         0    117.3M   0% /dev
tmpfs                   118.3M     72.0K    118.3M   0% /run
tmpfs                   118.3M     52.0K    118.3M   0% /var/volatile
```

Noticed that the /dev/root has the 7.0MB of size and 4.5MB (71%) are used.

Run the `ifconfig`

```console
root@qemuarm:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:02  
          inet addr:192.168.7.2  Bcast:192.168.7.255  Mask:255.255.255.0
          inet6 addr: fe80::5054:ff:fe12:3402/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:41 errors:0 dropped:0 overruns:0 frame:0
          TX packets:10 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:5897 (5.7 KiB)  TX bytes:796 (796.0 B)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
```

Power off the QEMU emulator.

```console
# poweroff
```

8. You can launch QEMU without the graphic window by adding the command line nographic. This way, the QEMU will be run ont he current console output.

```console
$ runqemu qemuarm core-image-minimal nographic
```

# 2 - Build and run the core-image-weston

1. The Poky has two reference desktop images, or **core-image-sato** and **core-image-weston**. 

The **core-image-sato** is the X11 Window-system-based image with a SATO theme and a GNOME mobile desktop environment.

The **core-image-weston** is a Wayland protocol and Weston reference compositor-based image.

Choose one of then and build. For example, core-image-weston

```console
$ bitbake core-image-weston
```

When the process finished, check the rootfs size.
```console
$ ls -l build_qemuarm/tmp/deploy/images/qemuarm/*ext4
-rw-r--r-- 2 charlesdias charlesdias 366118912 ago 15 11:04 build_qemuarm/tmp/deploy/images/qemuarm/core-image-weston-qemuarm-20230815105049.rootfs.ext4
. . .
```

The `core-image-weston-qemuarm-20230815105049.rootfs.ext4` file has 366118912 bytes or 350MB.

2. run the QEMU

```console
$ runqemu qemuarm core-image-weston
```

3. Make a SSH connection.

```console
$ sudo ssh root@192.168.7.2
```

4. Check the Kernel version

```console
root@qemuarm:~# uname -a
Linux qemuarm 5.15.120-yocto-standard #1 SMP PREEMPT Thu Jul 6 20:06:50 UTC 2023 armv7l GNU/Linux
```

and the disk space.

```console
root@qemuarm:~# df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/root               317.2M    172.2M    123.6M  58% /
devtmpfs                244.1M         0    244.1M   0% /dev
tmpfs                    40.0K         0     40.0K   0% /mnt
tmpfs                   245.1M     88.0K    245.0M   0% /run
tmpfs                   245.1M     72.0K    245.0M   0% /var/volatile
```

Noticed that the /dev/root has the 317.2MB of size and 172.2MB (58%) are used.

# 3 - Add lsusb to Yocto image

1. Start the QEMU core-image-minimal.

```console
$ runqemu qemuarm core-image-minimal
```

2. After boot, check that the `lsusb` command is not available.

```console
root@qemuarm:~# lsusb
-sh: lsusb: not found
```

Power off the QEMU emulator.

3. Run the command to check the IMAGE_INSTALL value

```console
$ bitbake -e core-image-minimal | grep ^IMAGE_INSTALL
IMAGE_INSTALL="packagegroup-core-boot "
IMAGE_INSTALL_COMPLEMENTARY=""
IMAGE_INSTALL_DEBUGFS=""
```

4. Open the local.conf file and add the instructions below to add To add the `lsusb`. It is recommend to add a space before of the package name.

```text
IMAGE_INSTALL:append = " usbutils"
```

Check the IMAGE_INSTALL variable again. This time, the package `usbutils` was added.

```console
$ bitbake -e core-image-minimal | grep ^IMAGE_INSTALL
IMAGE_INSTALL="packagegroup-core-boot  usbutils"
IMAGE_INSTALL_COMPLEMENTARY=""
IMAGE_INSTALL_DEBUGFS=""
```

5. Rebuild the image.

```console
$ bitbake core-image-minimal
```

When the process finished, check the rootfs size.
```console
$ ls -l build_qemuarm/tmp/deploy/images/qemuarm/*.ext4
-rw-r--r-- 2 charlesdias charlesdias  29111296 ago 15 10:52 build_qemuarm/tmp/deploy/images/qemuarm/core-image-minimal-qemuarm-20230815134849.rootfs.ext4
. . .
```

The `core-image-minimal-qemuarm-20230814192133.rootfs.ext4` file has 29111296 bytes or 28MB.

6. Run the QEMU emulator.

```console
$ runqemu qemuarm core-image-minimal nographic
```
 
And check that `lsusb` is now available.

```console
root@qemuarm:~# lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 0627:0001 Adomax Technology Co., Ltd QEMU USB Keyboard
Bus 001 Device 002: ID 0627:0001 Adomax Technology Co., Ltd QEMU USB Tablet
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

7. Check the new rootfs size

```console
root@qemuarm:~# df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/root                24.4M     19.1M      3.3M  85% /
devtmpfs                117.3M         0    117.3M   0% /dev
tmpfs                   118.3M    104.0K    118.2M   0% /run
tmpfs                   118.3M     56.0K    118.3M   0% /var/volatile
```

Poweroff the QEMU emulator.

8. You can build againg the core-image-weston to add the package `usbutils`.
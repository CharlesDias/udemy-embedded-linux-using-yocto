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

## 2 - Build and run the core-image-weston

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

## 3 - Add lsusb to Yocto image

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

## 4 - Burndown the core-image-minimal using the WIC

1. The fastest and easiest way of using the wic file.

2. Connecting the SD card to PC and run the command `sudo dmesg` to see witch sdX  SD card was detected. For example

```console
[ 2299.384103]  sdb: sdb1 sdb2
[ 2299.384280] sd 1:0:0:0: [sdb] Attached SCSI removable disk
```

3. Use the dd command transfer the file to SD card.

```console
$ sudo dd if=core-image-minimal-beaglebone-yocto.wic of=/dev/sdX bs=4M
```

4. Run the `sync` command. That is it! Remove the SD card and connect it to BBB.

## 5 - Burndown the image core-image-sato

**ATTENTION: If you are using the core-image-minimal, the steps are slightly different. See the link: https://www.beagleboard.org/projects/yocto-on-beaglebone-black**

### 5.1 Creating a partitions and formatting the SD card

This can be done via GPart. However, below has the instructions to performs via fdisk commands.

1. Connecting the SD card to PC and run the command `sudo dmesg` to see witch sdX  SD card was detected. For example

```console
[ 2299.384103]  sdb: sdb1 sdb2
[ 2299.384280] sd 1:0:0:0: [sdb] Attached SCSI removable disk
```

2. Umount any mounted partition, for exemplo

```console
$ umount /dev/sdXY
```

3. Launch the fdisk utility and delete the previous partitions.

```console
sudo fdisk /dev/sdX
```

4. Press `p` to see the available partitions

```console
Command (m for help): p
Disk /dev/sdb: 3,69 GiB, 3965190144 bytes, 7744512 sectors
Disk model: Storage Device  
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x1f4ea427

Device     Boot  Start     End Sectors  Size Id Type
/dev/sdb1         8192  532479  524288  256M  c W95 FAT32 (LBA)
/dev/sdb2       532480 7744511 7212032  3,4G 83 Linux
```

5. Press `d` and enter the number `1` to delete the partition. Press `d` again to delet others partitions.

6. Now, create a new partition called BOOT with 32 MB of size and primary type.

```console
Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-7744511, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-7744511, default 7744511): +32M

Created a new partition 1 of type 'Linux' and of size 32 MiB.
```

7. Create a second partition to hold rootf. We can give all the remaining space to this partition. This will be a primary type.

```console
Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (2-4, default 2): 
First sector (67584-7744511, default 67584): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (67584-7744511, default 7744511): 

Created a new partition 2 of type 'Linux' and of size 3,7 GiB.
```

8. Set the first partition bootable by setting the boot flag.

```console
Command (m for help): a
Partition number (1,2, default 2): 1

The bootable flag on partition 1 is enabled now.
```

9. Format the first partition as WIN95 FAT32 (LBA). Press the `t` and enter the number `1` to select the first partition. Press `L` to list the all codes and enter the correspondent code to `WIN95 FAT32 (LBA)` option.


```console
Command (m for help): t
Partition number (1,2, default 2): 1
Hex code or alias (type L to list all): L

00 Empty            24 NEC DOS          81 Minix / old Lin  bf Solaris        
01 FAT12            27 Hidden NTFS Win  82 Linux swap / So  c1 DRDOS/sec (FAT-
02 XENIX root       39 Plan 9           83 Linux            c4 DRDOS/sec (FAT-
03 XENIX usr        3c PartitionMagic   84 OS/2 hidden or   c6 DRDOS/sec (FAT-
04 FAT16 <32M       40 Venix 80286      85 Linux extended   c7 Syrinx         
05 Extended         41 PPC PReP Boot    86 NTFS volume set  da Non-FS data    
06 FAT16            42 SFS              87 NTFS volume set  db CP/M / CTOS / .
07 HPFS/NTFS/exFAT  4d QNX4.x           88 Linux plaintext  de Dell Utility   
08 AIX              4e QNX4.x 2nd part  8e Linux LVM        df BootIt         
09 AIX bootable     4f QNX4.x 3rd part  93 Amoeba           e1 DOS access     
0a OS/2 Boot Manag  50 OnTrack DM       94 Amoeba BBT       e3 DOS R/O        
0b W95 FAT32        51 OnTrack DM6 Aux  9f BSD/OS           e4 SpeedStor      
0c W95 FAT32 (LBA)  52 CP/M             a0 IBM Thinkpad hi  ea Linux extended 
0e W95 FAT16 (LBA)  53 OnTrack DM6 Aux  a5 FreeBSD          eb BeOS fs        
0f W95 Ext'd (LBA)  54 OnTrackDM6       a6 OpenBSD          ee GPT            
10 OPUS             55 EZ-Drive         a7 NeXTSTEP         ef EFI (FAT-12/16/
11 Hidden FAT12     56 Golden Bow       a8 Darwin UFS       f0 Linux/PA-RISC b
12 Compaq diagnost  5c Priam Edisk      a9 NetBSD           f1 SpeedStor      
14 Hidden FAT16 <3  61 SpeedStor        ab Darwin boot      f4 SpeedStor      
16 Hidden FAT16     63 GNU HURD or Sys  af HFS / HFS+       f2 DOS secondary  
17 Hidden HPFS/NTF  64 Novell Netware   b7 BSDI fs          fb VMware VMFS    
18 AST SmartSleep   65 Novell Netware   b8 BSDI swap        fc VMware VMKCORE 
1b Hidden W95 FAT3  70 DiskSecure Mult  bb Boot Wizard hid  fd Linux raid auto
1c Hidden W95 FAT3  75 PC/IX            bc Acronis FAT32 L  fe LANstep        
1e Hidden W95 FAT1  80 Old Minix        be Solaris boot     ff BBT            

Aliases:
   linux          - 83
   swap           - 82
   extended       - 05
   uefi           - EF
   raid           - FD
   lvm            - 8E
   linuxex        - 85
Hex code or alias (type L to list all): 0c

Changed type of partition 'Linux' to 'W95 FAT32 (LBA)'.
```

10. The final expected result is

```console
Command (m for help): p
Disk /dev/sdb: 3,69 GiB, 3965190144 bytes, 7744512 sectors
Disk model: Storage Device  
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x1f4ea427

Device     Boot Start     End Sectors  Size Id Type
/dev/sdb1  *     2048   67583   65536   32M  c W95 FAT32 (LBA)
/dev/sdb2       67584 7744511 7676928  3,7G 83 Linux
```

11. Press the `w` command to write the modifications.

```console
Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

**Note: Do not forget to set the first partition as WIN95 FAT32 (LBA), otherwise, BeagleBone won't be able to boot from it.**

12. Format the first partition as FAT filesystem.

```console
sudo mkfs.vfat -n "BOOT" /dev/sdXY
```

13. Format the second partition as ext4 filesystem. This takes some time.

```console
sudo mkfs.ext4 -L "ROOT" /dev/sdXY
```

### 5.2 Store the files on SD card

1. Reconnect the SD card. Check if it was automatically mounted. If is not, we can mount then via Files management or by commands.

```console
$ sudo mount /dev/sdXY /media/$USER/BOOT
$ sudo mount /dev/sdXY /media/$USER/ROOT
```

2. Copy the u-boot MLO, u-boot bootloader image, the kernel image, and the DTB files into boot partition.

```console
$ sudo cp MLO /media/$USER/BOOT
$ sudo cp u-boot.img /media/$USER/BOOT
$ sudo cp zImage /media/$USER/BOOT
$ sudo cp am335x-boneblack.dtb /media/$USER/BOOT
```

3. As a root user, uncompress core-image-minimal-beaglebone-yocto.tar.bz2 to the ext4 partition.

```console
$ sudo tar -xf core-image-minimal-beaglebone-yocto.tar.bz2 -C /media/$USER/ROOT
```

4. Run the `sync` command and umount the SD card. Connect the SD card to BBB.


```console
```

```console
```

```console
```

```console
```

```console
```
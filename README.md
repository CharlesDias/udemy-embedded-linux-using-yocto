# Udemy - Embedded Linux using Yocto

## Courses resume

* [Embedded Linux using Yocto - Part 1.](Part1.md).
* [Embedded Linux using Yocto - Part 2.](Part2.md)
* [Embedded Linux using Yocto - Part 3.](Part3.md)
* [Embedded Linux using Yocto - Part 4.](Part4.md)

## Bitbake commands

* Show some command options.
```
$ bitbake -h
```

* Build image.

```
$ bitbake <image-name>
```

* Build image and continue as much as possible after an error.
```
$ bitbake -k <image-name>
```

* Show layers
```
$ bitbake-layers show-layers
```

* List of the available image recipes inside of Poky folder.
```
$ ls poky/meta*/recipes*/images/*.bb
```

* List of the available machine supported.
```
$ ls poky/meta*/conf/machine/*.conf
```

* Check the variable value

```console
$ bitbake -e <image-name> | grep ^<variable-name>
```

Example

```console
$ bitbake -e core-image-minimal | grep ^IMAGE_INSTALL
```

* To help you see where you currently are with kernel and root filesystem sizes, you can use two tools found in the Source Directory in the scripts/tiny/ directory:

ksize.py: Reports component sizes for the kernel build objects.

dirsize.py: Reports component sizes for the root filesystem.

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

* Check the list of available image recipes inside of Poky folder.
```
$ ls poky/meta*/recipes*images/*.bb
```


${TOPDIR}/../layers/meta-toradex-distro \
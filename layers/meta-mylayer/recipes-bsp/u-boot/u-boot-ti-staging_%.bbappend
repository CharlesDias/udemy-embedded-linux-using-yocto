do_configure:append() {
    # Change the am335x-boneblack.dtb to my-custom-devicetree-file.dtb file.
    sed -i 's/am335x-boneblack.dtb/my-custom-devicetree-file.dtb/' ${S}/include/configs/am335x_evm.h
}
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

CUSTOM_DEVICETREE = "my-custom-devicetree-file"

SRC_URI += " \ 
    file://${CUSTOM_DEVICETREE}.dts \
    "

do_configure:append() {
    cp ${WORKDIR}/${CUSTOM_DEVICETREE}.dts ${S}/arch/arm/boot/dts
}
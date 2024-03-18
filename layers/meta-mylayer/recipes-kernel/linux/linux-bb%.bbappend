FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

CUSTOM_DEVICETREE = "my-custom-devicetree-file"

# SRC_URI += " \ 
#     file://${CUSTOM_DEVICETREE}.dts \
# "

# do_configure:append() {
#     cp ${WORKDIR}/${CUSTOM_DEVICETREE}.dts ${S}/arch/arm/boot/dts
# }

SRC_URI += " \ 
    file://${CUSTOM_DEVICETREE}.dts \
    file://cfg/kernel-custom.cfg \
"

do_configure:append() {
    cp ${WORKDIR}/${CUSTOM_DEVICETREE}.dts ${S}/arch/arm/boot/dts
    cat ${WORKDIR}/cfg/kernel-custom.cfg >> ${B}/.config
}
DESCRIPTION = "Recipe to start the webcam on boot and show the image on the screen"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
    file://S50playvideo \
"

do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/S50playvideo ${D}${sysconfdir}/init.d/S50playvideo

    install -d ${D}${sysconfdir}/rcS.d
    ln -s ../init.d/S50playvideo ${D}${sysconfdir}/rcS.d/S50playvideo
}

FILES_${PN} += "${sysconfdir}/init.d/S50playvideo"
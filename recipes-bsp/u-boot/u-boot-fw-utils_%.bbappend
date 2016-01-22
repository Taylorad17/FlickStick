FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot-imx:"
FILESEXTRAPATHS_prepend_wandboard :="${THISDIR}/u-boot-imx/wandboard:"
FILESEXTRAPATHS_prepend_utilite := "${THISDIR}/u-boot-imx/utilite:"

SRC_URI_append_overo := " file://fw_env.config"
SRC_URI += "file://env.txt "

DEPENDS = "u-boot-mkimage-native"

inherit deploy

# override the fw_env.config provided by the default recipe
do_install_append_overo () {
	install -m 0644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}

do_install_append_mx6 () {
  uboot-mkimage -A arm -T script -C none -d ${WORKDIR}/env.txt ${WORKDIR}/bootscript-${MACHINE} 
}

do_deploy_append_mx6 () {
    install -d ${DEPLOYDIR}
    install ${WORKDIR}/bootscript-${MACHINE} \
            ${DEPLOYDIR}/bootscript-${MACHINE}
}

addtask deploy after do_install 


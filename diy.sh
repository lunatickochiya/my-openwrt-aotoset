#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Write By lunatickochiya
# You can replace lean package with yours and patch his source
# under this directory mypatch should put your patch
# delete his package confict with yours
#=================================================
sleep 3
rm -rf package/lean/luci-app-ssr-plus package/lean/default-settings
sleep 3
function patch_openwrt() {
        for i in $( ls mypatch ); do
            echo Applying mypatch $i
            patch -p1 < mypatch/$i
        done
        }
function patch_package() {
        for packagepatch in $( ls feeds/packages/my-package-patch ); do
            cd feeds/packages/
            echo Applying my-package-patch $packagepatch
            patch -p1 < my-package-patch/$packagepatch
        done
        }
patch_openwrt
patch_package
sleep 6

cd ../..
# add luci

cat <<EOF >>.config
CONFIG_TARGET_KERNEL_PARTSIZE=16
CONFIG_TARGET_ROOTFS_PARTSIZE=512
CONFIG_PACKAGE_luci-app-alist=y
CONFIG_PACKAGE_luci-app-argon-config=y
CONFIG_PACKAGE_luci-app-aria2=y
CONFIG_PACKAGE_ariang=y
CONFIG_ARIA2_OPENSSL=y
CONFIG_ARIA2_LIBXML2=y
CONFIG_ARIA2_BITTORRENT=y
CONFIG_ARIA2_METALINK=y
CONFIG_ARIA2_SFTP=y
CONFIG_ARIA2_ASYNC_DNS=y
CONFIG_ARIA2_COOKIE=y
CONFIG_ARIA2_WEBSOCKET=y
CONFIG_PACKAGE_luci-app-cpufreq=y
CONFIG_PACKAGE_luci-app-cpulimit=y
CONFIG_PACKAGE_luci-app-diskman=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_btrfs_progs=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_lsblk=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_mdadm=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_kmod_md_raid456=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_kmod_md_linear=y
CONFIG_PACKAGE_luci-app-dockerman=y
CONFIG_PACKAGE_dockerd=y
CONFIG_DOCKER_CHECK_CONFIG=y
CONFIG_DOCKER_CGROUP_OPTIONS=y
CONFIG_DOCKER_OPTIONAL_FEATURES=y

#
# Network
#
CONFIG_DOCKER_NET_OVERLAY=y
CONFIG_DOCKER_NET_ENCRYPT=y
CONFIG_DOCKER_NET_MACVLAN=y
CONFIG_DOCKER_NET_TFTP=y
# end of Network

#
# Storage
#
CONFIG_DOCKER_STO_DEVMAPPER=y
CONFIG_DOCKER_STO_EXT4=y
CONFIG_DOCKER_STO_BTRFS=y
# end of Storage
CONFIG_PACKAGE_luci-app-filetransfer=y
CONFIG_PACKAGE_luci-app-fileassistant=y
CONFIG_PACKAGE_luci-app-modechange=y
CONFIG_PACKAGE_luci-app-mosdns=y
CONFIG_PACKAGE_luci-app-kodexplorer=y
CONFIG_PACKAGE_php8-mod-ftp=y
CONFIG_PACKAGE_luci-app-netwizard=y
CONFIG_PACKAGE_luci-app-nvr=y
CONFIG_PACKAGE_luci-app-openclash=y
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-ssr-plus=y
CONFIG_PACKAGE_luci-app-ramfree=y
CONFIG_PACKAGE_luci-app-rclone=y
CONFIG_PACKAGE_luci-app-rclone_INCLUDE_rclone-webui=y
CONFIG_PACKAGE_luci-app-rclone_INCLUDE_rclone-ng=y
CONFIG_PACKAGE_luci-app-ttyd=y
CONFIG_PACKAGE_luci-theme-argon=y
CONFIG_PACKAGE_ffmpeg=y
CONFIG_PACKAGE_autoset=y
CONFIG_PACKAGE_autoset_INCLUDE_RESIZEFS=y
CONFIG_PACKAGE_autoset_INCLUDE_FW3_IPTABLE_LEGACY=y
CONFIG_PACKAGE_autoset_INCLUDE_temperature=y
CONFIG_PACKAGE_autoset_INCLUDE_filesystem=y
CONFIG_PACKAGE_autoset_INCLUDE_usb_storage=y
#
# Build Options
#
CONFIG_OPENSSL_OPTIMIZE_SPEED=y
CONFIG_OPENSSL_WITH_ASM=y
CONFIG_OPENSSL_WITH_DEPRECATED=y
# CONFIG_OPENSSL_NO_DEPRECATED is not set
CONFIG_OPENSSL_WITH_ERROR_MESSAGES=y

#
# Protocol Support
#
CONFIG_OPENSSL_WITH_TLS13=y
CONFIG_OPENSSL_WITH_DTLS=y
CONFIG_OPENSSL_WITH_NPN=y
CONFIG_OPENSSL_WITH_SRP=y
CONFIG_OPENSSL_WITH_CMS=y

#
# Algorithm Selection
#
CONFIG_OPENSSL_WITH_EC2M=y
CONFIG_OPENSSL_WITH_CHACHA_POLY1305=y
CONFIG_OPENSSL_PREFER_CHACHA_OVER_GCM=y
CONFIG_OPENSSL_WITH_PSK=y

#
# Less commonly used build options
#
CONFIG_OPENSSL_WITH_ARIA=y
CONFIG_OPENSSL_WITH_CAMELLIA=y
CONFIG_OPENSSL_WITH_IDEA=y
CONFIG_OPENSSL_WITH_SEED=y
CONFIG_OPENSSL_WITH_SM234=y
CONFIG_OPENSSL_WITH_BLAKE2=y
CONFIG_OPENSSL_WITH_MDC2=y
CONFIG_OPENSSL_WITH_WHIRLPOOL=y
CONFIG_OPENSSL_WITH_COMPRESSION=y
CONFIG_OPENSSL_WITH_RFC3779=y

#
# Engine/Hardware Support
#
CONFIG_OPENSSL_ENGINE=y
CONFIG_OPENSSL_ENGINE_BUILTIN=y
CONFIG_OPENSSL_ENGINE_BUILTIN_AFALG=y
CONFIG_OPENSSL_ENGINE_BUILTIN_DEVCRYPTO=y
CONFIG_PACKAGE_libopenssl-conf=y
CONFIG_PACKAGE_libopenssl-gost_engine=y
# CONFIG_PACKAGE_libpolarssl is not set
CONFIG_PACKAGE_libwolfssl=y
CONFIG_WOLFSSL_HAS_AES_CCM=y
CONFIG_WOLFSSL_HAS_CHACHA_POLY=y
CONFIG_WOLFSSL_HAS_DH=y
CONFIG_WOLFSSL_HAS_ARC4=y
CONFIG_WOLFSSL_HAS_CERTGEN=y
CONFIG_WOLFSSL_HAS_TLSV10=y
CONFIG_WOLFSSL_HAS_TLSV13=y
CONFIG_WOLFSSL_HAS_SESSION_TICKET=y
# CONFIG_WOLFSSL_HAS_DTLS is not set
CONFIG_WOLFSSL_HAS_OCSP=y
CONFIG_WOLFSSL_HAS_WPAS=y
CONFIG_WOLFSSL_HAS_ECC25519=y
CONFIG_WOLFSSL_HAS_OPENVPN=y
CONFIG_WOLFSSL_ALT_NAMES=y
# CONFIG_WOLFSSL_ASM_CAPABLE is not set
CONFIG_WOLFSSL_HAS_NO_HW=y
# CONFIG_WOLFSSL_HAS_AFALG is not set
# CONFIG_WOLFSSL_HAS_DEVCRYPTO_CBC is not set
# CONFIG_WOLFSSL_HAS_DEVCRYPTO_AES is not set
# CONFIG_WOLFSSL_HAS_DEVCRYPTO_FULL is not set
# CONFIG_PACKAGE_libwolfssl-benchmark is not set
# end of SSL
CONFIG_PACKAGE_libcurl=y

#
# SSL support
#
# CONFIG_LIBCURL_MBEDTLS is not set
# CONFIG_LIBCURL_WOLFSSL is not set
CONFIG_LIBCURL_OPENSSL=y
# CONFIG_LIBCURL_GNUTLS is not set
# CONFIG_LIBCURL_NOSSL is not set

#
# Supported protocols
#
CONFIG_LIBCURL_DICT=y
CONFIG_LIBCURL_FILE=y
CONFIG_LIBCURL_FTP=y
CONFIG_LIBCURL_GOPHER=y
CONFIG_LIBCURL_HTTP=y
CONFIG_LIBCURL_COOKIES=y
CONFIG_LIBCURL_IMAP=y
CONFIG_LIBCURL_LDAP=y
CONFIG_LIBCURL_LDAPS=y
CONFIG_LIBCURL_POP3=y
CONFIG_LIBCURL_RTSP=y
CONFIG_LIBCURL_SSH2=y
CONFIG_LIBCURL_SMB=y
CONFIG_LIBCURL_SMTP=y
CONFIG_LIBCURL_TELNET=y
CONFIG_LIBCURL_TFTP=y
CONFIG_LIBCURL_NGHTTP2=y

#
# Miscellaneous
#
CONFIG_LIBCURL_PROXY=y
CONFIG_LIBCURL_CRYPTO_AUTH=y
CONFIG_LIBCURL_TLS_SRP=y
CONFIG_LIBCURL_LIBIDN2=y
CONFIG_LIBCURL_THREADED_RESOLVER=y
CONFIG_LIBCURL_ZLIB=y
CONFIG_LIBCURL_ZSTD=y
CONFIG_LIBCURL_UNIX_SOCKETS=y
CONFIG_LIBCURL_LIBCURL_OPTION=y
CONFIG_LIBCURL_VERBOSE=y
CONFIG_LIBCURL_NTLM=y
EOF


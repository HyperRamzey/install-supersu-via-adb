adb root
adb remount
Echo Mounting system...
adb shell setenforce 0

adb push common/Superuser.apk /system/app/SuperSU/SuperSU.apk
adb shell chmod 0644 /system/app/SuperSU/SuperSU.apk
adb shell chcon u:object_r:system_file:s0 /system/app/SuperSU/SuperSU.apk

adb push common/install-recovery.sh /system/etc/install-recovery.sh
adb shell chmod 0755 /system/etc/install-recovery.sh
adb shell chcon u:object_r:toolbox_exec:s0 /system/etc/install-recovery.sh

adb shell ln -s /system/etc/install-recovery.sh /system/bin/install-recovery.sh

adb push arm64/su /system/xbin/su
adb shell chmod 0755 /system/xbin/su
adb shell chcon u:object_r:system_file:s0 /system/xbin/su

adb push arm64/su /system/bin/.ext/.su
adb shell chmod 0755 /system/bin/.ext/.su
adb shell chcon u:object_r:system_file:s0 /system/bin/.ext/.su

adb push arm64/su /system/xbin/daemonsu
adb shell chmod 0755 /system/xbin/daemonsu
adb shell chcon u:object_r:system_file:s0 /system/xbin/daemonsu

adb push arm64/supolicy /system/xbin/supolicy
adb shell chmod 0755 /system/xbin/supolicy
adb shell chcon u:object_r:system_file:s0 /system/xbin/supolicy

adb push arm64/libsupol.so /system/lib64/libsupol.so
adb shell chmod 0644 /system/lib64/libsupol.so
adb shell chcon u:object_r:system_file:s0 /system/lib64/libsupol.so

adb shell cp /system/bin/app_process64 /system/bin/app_process64_original
adb shell chmod 0755 /system/bin/app_process64_original
adb shell chcon u:object_r:zygote_exec:s0 /system/bin/app_process64_original

adb shell cp /system/bin/app_process64 /system/bin/app_process_init
adb shell chmod 0755 /system/bin/app_process_init
adb shell chcon u:object_r:zygote_exec:s0 /system/bin/app_process_init

adb shell rm -rf /system/bin/app_process
adb shell rm -rf /system/bin/app_process64

adb shell ln -s /system/xbin/daemonsu /system/bin/app_process

adb shell ln -s /system/xbin/daemonsu /system/bin/app_process64

adb shell "echo 1 > /system/etc/.installed_su_daemon"
adb shell /system/xbin/su --install
echo Installing SuperSU app
adb install common\Superuser.apk

echo Installing SuperSU binary...
adb shell /system/xbin/su -c chmod 0644 /system/app/SuperSU/SuperSU.apk
adb shell /system/xbin/su -c chcon u:object_r:system_file:s0 /system/app/SuperSU/SuperSU.apk

adb shell /system/xbin/su -c chmod 0755 /system/etc/install-recovery.sh
adb shell /system/xbin/su -c chcon u:object_r:toolbox_exec:s0 /system/etc/install-recovery.sh

adb shell /system/xbin/su -c ln -s /system/etc/install-recovery.sh /system/bin/install-recovery.sh

adb shell /system/xbin/su -c chmod 0755 /system/xbin/su
adb shell /system/xbin/su -c chcon u:object_r:system_file:s0 /system/xbin/su

adb shell /system/xbin/su -c mkdir /system/bin/.ext/

adb shell /system/xbin/su -c chmod 0755 /system/xbin/daemonsu
adb shell /system/xbin/su -c chcon u:object_r:system_file:s0 /system/xbin/daemonsu

adb shell /system/xbin/su -c chmod 0755 /system/xbin/supolicy
adb shell /system/xbin/su -c chcon u:object_r:system_file:s0 /system/xbin/supolicy

adb shell /system/xbin/su -c chmod 0644 /system/lib/libsupol.so
adb shell /system/xbin/su -c chcon u:object_r:system_file:s0 /system/lib/libsupol.so

adb shell /system/xbin/su -c cp /system/bin/app_process32 /system/bin/app_process32_original
adb shell /system/xbin/su -c chmod 0755 /system/bin/app_process32_original
adb shell /system/xbin/su -c chcon u:object_r:zygote_exec:s0 /system/bin/app_process32_original

adb shell /system/xbin/su -c cp /system/bin/app_process32 /system/bin/app_process_init
adb shell /system/xbin/su -c chmod 0755 /system/bin/app_process_init
adb shell /system/xbin/su -c chcon u:object_r:zygote_exec:s0 /system/bin/app_process_init

adb shell /system/xbin/su -c rm -rf /system/bin/app_process
adb shell /system/xbin/su -c rm -rf /system/bin/app_process32

adb shell /system/xbin/su -c rm -rf /system/bin/app_process64

adb shell /system/xbin/su -c ln -s /system/xbin/daemonsu /system/bin/app_process

adb shell /system/xbin/su -c ln -s /system/xbin/daemonsu /system/bin/app_process32

adb shell /system/xbin/su -c ln -s /system/xbin/daemonsu /system/bin/app_process64

adb shell /system/xbin/su --install

adb reboot
pause

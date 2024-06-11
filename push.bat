adb root
adb remount

echo Installing SuperSU app
adb install common\Superuser.apk

echo Copying files to install SuperSU binary

adb shell mkdir /data/local/tmp/SuperSU >nul
adb push common\Superuser.apk /data/local/tmp/SuperSU >nul
adb push x86\su.pie /data/local/tmp/SuperSU >nul
adb push common\install-recovery.sh /data/local/tmp/SuperSU >nul
adb push x86\libsupol.so /data/local/tmp/SuperSU >nul
adb push x86\supolicy /data/local/tmp/SuperSU >nul

Echo Mounting system...
adb shell /system/xbin/bstk/su -c setenforce 0

adb shell /system/xbin/bstk/su -c mount -o rw,remount,rw /
adb shell /system/xbin/bstk/su -c mount -o rw,remount,rw /system
adb shell /system/xbin/bstk/su -c mount -o rw,remount,exec,rw /storage/emulated

echo Copying files to system...
adb shell /system/xbin/bstk/su -c mkdir /system/app/SuperSU
adb shell /system/xbin/bstk/su -c cp /data/local/tmp/SuperSU/Superuser.apk /system/app/SuperSU/SuperSU.apk
adb shell /system/xbin/bstk/su -c cp /data/local/tmp/SuperSU/su.pie /system/xbin/su
adb shell /system/xbin/bstk/su -c cp /data/local/tmp/SuperSU/su.pie /system/xbin/daemonsu
adb shell /system/xbin/bstk/su -c cp /data/local/tmp/SuperSU/install-recovery.sh /system/etc/install-recovery.sh
adb shell /system/xbin/bstk/su -c cp /data/local/tmp/SuperSU/libsupol.so /system/lib/libsupol.so
adb shell /system/xbin/bstk/su -c cp /data/local/tmp/SuperSU/supolicy /system/xbin/supolicy

echo Installing SuperSU binary...
adb shell /system/xbin/bstk/su -c chmod 0644 /system/app/SuperSU/SuperSU.apk
adb shell /system/xbin/bstk/su -c chcon u:object_r:system_file:s0 /system/app/SuperSU/SuperSU.apk

adb shell /system/xbin/bstk/su -c chmod 0755 /system/etc/install-recovery.sh
adb shell /system/xbin/bstk/su -c chcon u:object_r:toolbox_exec:s0 /system/etc/install-recovery.sh

adb shell /system/xbin/bstk/su -c ln -s /system/etc/install-recovery.sh /system/bin/install-recovery.sh

adb shell /system/xbin/bstk/su -c chmod 0755 /system/xbin/su
adb shell /system/xbin/bstk/su -c chcon u:object_r:system_file:s0 /system/xbin/su

adb shell /system/xbin/bstk/su -c mkdir /system/bin/.ext/

adb shell /system/xbin/bstk/su -c chmod 0755 /system/xbin/daemonsu
adb shell /system/xbin/bstk/su -c chcon u:object_r:system_file:s0 /system/xbin/daemonsu

adb shell /system/xbin/bstk/su -c chmod 0755 /system/xbin/supolicy
adb shell /system/xbin/bstk/su -c chcon u:object_r:system_file:s0 /system/xbin/supolicy

adb shell /system/xbin/bstk/su -c chmod 0644 /system/lib/libsupol.so
adb shell /system/xbin/bstk/su -c chcon u:object_r:system_file:s0 /system/lib/libsupol.so

adb shell /system/xbin/bstk/su -c cp /system/bin/app_process32 /system/bin/app_process32_original
adb shell /system/xbin/bstk/su -c chmod 0755 /system/bin/app_process32_original
adb shell /system/xbin/bstk/su -c chcon u:object_r:zygote_exec:s0 /system/bin/app_process32_original

adb shell /system/xbin/bstk/su -c cp /system/bin/app_process32 /system/bin/app_process_init
adb shell /system/xbin/bstk/su -c chmod 0755 /system/bin/app_process_init
adb shell /system/xbin/bstk/su -c chcon u:object_r:zygote_exec:s0 /system/bin/app_process_init

adb shell /system/xbin/bstk/su -c rm -rf /system/bin/app_process
adb shell /system/xbin/bstk/su -c rm -rf /system/bin/app_process32

adb shell /system/xbin/bstk/su -c ln -s /system/xbin/daemonsu /system/bin/app_process

adb shell /system/xbin/bstk/su -c ln -s /system/xbin/daemonsu /system/bin/app_process32

adb shell /system/xbin/su --install

echo Cleaning files...
adb shell /system/xbin/bstk/su -c rm -rR -f /data/local/tmp/SuperSU

echo Restarting...
adb reboot
pause

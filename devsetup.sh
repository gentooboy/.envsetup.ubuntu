#!/bin/bash

export WORK_MOUNTED=~/work
export TOOL_MOUNTED=~/tool

case $OSTYPE in
	darwin*) OS=macosx;;
	linux*)  OS=ubuntu;;
esac

ENVSETUP=~/.envsetup.$OS

export JAVA_HOME=/usr/lib/jvm/java-6-oracle
#export JAVA_HOME=/usr/lib/jvm/java-7-oracle

export COLOR_PY=$ENVSETUP/coloredlogcat.py
export ENVSETUP_SH=$ENVSETUP/envsetup.sh
export SETPATH_SH=$ENVSETUP/setpath.sh
export REPEAT_SH=$ENVSETUP/repeat.sh
export ADBCON_SH=$ENVSETUP/adbcon.sh
export GDBATTACH_SH=$ENVSETUP/gdbattach.sh
export JDBATTACH_SH=$ENVSETUP/jdbattach.sh
export FINDLIB_SH=$ENVSETUP/findlib.sh
export FINDPKG_SH=$ENVSETUP/findpkg.sh
export WHICHPKG_SH=$ENVSETUP/whichpkg.sh
export FINDTEST_SH=$ENVSETUP/findtest.sh
export PUSHAPK_SH=$ENVSETUP/pushapk.sh
export PUSHJAR_SH=$ENVSETUP/pushjar.sh
export WHEREAMINOW_SH=$ENVSETUP/whereaminow.sh
export WHATAMIDOINGNOW_SH=$ENVSETUP/whatamidoingnow.sh
export GOTOWITHTHESAMEDEPTH_SH=$ENVSETUP/gotowiththesamedepth.sh
export KILLPROCESS_SH=$ENVSETUP/killprocess.sh
export MAKEWITHLOG_SH=$ENVSETUP/makewithlog.sh
export MAKEOTAWITHLOG_SH=$ENVSETUP/makeotawithlog.sh
export GTV_REINSTALL_SH=$ENVSETUP/gtv_reinstall.sh
export DO_ALL_AT_ONCE_SH=$ENVSETUP/do_all_at_once.sh

export ANDROID_SDK_PATH=$TOOL_MOUNTED/android-sdk-linux
export ANDROID_NDK_PATH=$TOOL_MOUNTED/android-ndk-linux
export ANDROID_SWT=$ANDROID_SDK_PATH/tools/lib/x86_64/
export USE_CCACHE=1
export CCACHE_DIR=$TOOL_MOUNTED/ccache

export CPU_THREAD_NUM=$(grep processor /proc/cpuinfo | wc -l | awk '{print $1 * 2}')

# set the number of open files to be 1024 for android
ulimit -S -n 1024

emulator_cmd_common="emulator -sysdir $OUT -data $OUT/userdata.img -sdcard $sdcard -memory 1024 -gpu on -camera-front webcam0"
alias ls.skins='l $skindir'
alias emulator.build='$emulator_cmd_common'
alias emulator.build.skin='$emulator_cmd_common -skindir $skindir -skin '

alias agdb='$GDB'

alias vijdbrc='vi $ENVSETUP/.jdbrc'
alias ln.gdbinit='ln -s $ENVSETUP/.gdbinit .gdbinit'
alias ln.jdbrc='ln -s $ENVSETUP/.jdbrc .jdbrc'
gdb_name=ln.gdb
alias ln.gdb='rm -f $gdb_name; ln -s $ANDROID_TOOLCHAIN/*gdb $gdb_name'
symbols_name=ln.symbols
alias ln.symbols='rm -f $symbols_name; ln -s $OUT/symbols $symbols_name'

alias whereaminow='$WHEREAMINOW_SH'
alias whatamidoingnow='$WHATAMIDOINGNOW_SH'

alias activitiesOnce='$ADBCON_SH && adb -s $ADBHOSTPORT shell dumpsys activity activities | grep Run'
alias activities='$ADBCON_SH && $REPEAT_SH 1 adb -s $ADBHOSTPORT shell dumpsys activity activities | grep Run'
alias activities4emul='$REPEAT_SH 1 adb shell dumpsys activity activities | grep Run'
alias logcatcolor='$ADBCON_SH && adb -s $ADBHOSTPORT logcat | $COLOR_PY'
alias logcatcolor4emul='adb logcat | $COLOR_PY'
alias logcattime='$ADBCON_SH && adb -s $ADBHOSTPORT logcat -v time'
alias logcattime4emul='adb logcat -v time'

alias adbcon='$ADBCON_SH'
alias adbrecon='adb disconnect; $ADBCON_SH'
alias adbremount='$ADBCON_SH && adb -s $ADBHOSTPORT remount'
alias adbsync='$ADBCON_SH && adb -s $ADBHOSTPORT sync'
alias adbpush='$ADBCON_SH && adb -s $ADBHOSTPORT push'
alias adbpull='$ADBCON_SH && adb -s $ADBHOSTPORT pull'
alias adbinstall.help='echo "adb -s $ADBHOSTPORT install [-r] bin/*.apk"'
alias adbinstall='$ADBCON_SH && adb -s $ADBHOSTPORT install'
alias adbkillemu='$ADBCON_SH && adb -s emulator-5554 device kill'

#alias adb='adb -s $ADBHOSTPORT'

alias howtomediatest='
echo "godir libstagefright/test";
echo "mm";
echo "adbcon";
echo "adbremount";
echo "adbshell android stop";
echo "adbsync";
echo "adbreboot";
echo "adbcon";
echo "adbshell /data/nativetest/MediaExtractor_test/MediaExtractor_test";
echo "adbshell /data/nativetest/MediaMetadata_test/MediaMetadata_test";
echo "adbshell /data/nativetest/MediaPlayback_test/MediaPlayback_test";
echo "adbshell /data/nativetest/MediaPlayer_test/MediaPlayer_test";
echo "or";
echo "runtest mediacoverage";
'
alias prepare.runtest='adbcon && adbremount && adbshell android stop && adbsync && adbreboot'
alias runtest.cts.MediaCoverageTest='$ADBCON_SH && runtest cts-tv -c com.google.android.tv.media.cts.MediaCoverageTest'
alias runtest.mediacoverage='$ADBCON_SH && runtest mediacoverage'

alias prepare.cts='adbinstall -r $DEVADMIN_APK_FOR_CTS2dot3R4 && adbinstall -r $DELEGATEACCESSSERVICE_APK_FOR_CTS2dot1R2'
alias prepare.gcts='adbinstall -r $GDEVADMIN_APK_FOR_CTS2dot3R4 && adbinstall -r $GDELEGATEACCESSSERVICE_APK_FOR_CTS2dot1R2'

alias adbshell='$ADBCON_SH && adb -s $ADBHOSTPORT shell'
alias adbreboot='adbshell "reboot"'
alias adbrmdata='adbshell "rm -rf /data; reboot"'
alias adblist='adbshell ps'
alias amstart.help='echo "Usage:   am start [-a ACTION] [-c CATEGORY] [-d DATA] [-t TYPE] [-n COMPONENT]"; echo "Example: am start -a android.intent.action.VIEW -d file:///mnt/sdcard/DCIM/Camera/video-2010-08-20-08-49-48.mp4 -t video/mp4 -n com.sec.android.app.videoplayer/.activity.MoviePlayer"'
alias amstart='adbshell am start'
alias adbsql='adbshell "sqlite3"'
alias adbsqldump='adbsql /data/data/com.android.providers.media/databases/external.db .dump'
alias adbsqlvolumes='adbsql /data/data/com.android.providers.media/databases/external.db "select * from volumes"'
alias adbsqlshortcut='adbsql /data/data/com.google.tv.launcher/databases/launcher.db "select * from shortcuts"'
alias useomx='adbshell setprop media.moo.others true'
alias useavapi='adbshell setprop media.moo.others false'
alias getomx='adbshell getprop media.moo.others'
alias activities='$ADBCON_SH && $REPEAT_SH 1 adb -s $ADBHOSTPORT shell dumpsys activity activities | grep Run'
alias killprocess='$KILLPROCESS_SH'
alias killqemu='$KILLPROCESS_SH qemu'

alias createapp.help='echo "Example: android create project -n ProjectName -t 1 -p ./projectname -k com.example.projectname -a ProjectActivity"; android --help create project'
alias createapp='android create project'
alias updateapp.help='echo "Example: android update project -l $TOOL_MOUNTED/android-sdk-linux/platforms/android-11 -p ./projectname"; android --help update project'
alias updateapp='android update project'

alias deletelog='echo "delete logfiles below..."; ll make_*.log 2>/dev/null; rm ./make_*.log; echo "remained logfiles below..."; find . -name "make_*.log"'
alias makewithlog='$MAKEWITHLOG_SH'
alias makeotawithlog='$MAKEOTAWITHLOG_SH'
alias gtv_reinstall='$GTV_REINSTALL_SH'
alias do_all_at_once='$DO_ALL_AT_ONCE_SH'

#export kernel=${WORK_MOUNTED}/tool/adt-bundle-linux/sdk/system-images/android-17/armeabi-v7a/kernel-qemu
alias emulator.avd='emulator -kernel $kernel -system $OUT/system.img -datadir $OUT/userdata.img -ramdisk $OUT/ramdisk.img'
alias cp.emulator='cp -ar $OUT/*.img $system_images'
alias rb.emulator='cp -ar $system_images_org/*.img $system_images'
alias cp.userdata='cp -ar $system_images_org/userdata.img $OUT'

alias makeepkwithlog='time make epk -j8 2>&1 | tee make_epk_build.log; ll $OUT/cosmo.epk | grep $OUT/cosmo.epk'
alias copyepk='cp $OUT/cosmo.epk /var/lib/tftpboot/cosmo/cosmo.epk; sudo chmod -R 777 /var/lib/tftpboot/*; ls -alRh /var/lib/tftpboot'

alias mmwithlog='time mm -j8 2>&1 | tee make_mm_build.log'
# alias make GtvVideoViewTest -j8
alias pushapk='$PUSHAPK_SH'
alias pushjar='$PUSHJAR_SH'
alias do_apk_at_once='mmwithlog && pushapk'
alias do_jar_at_once='mmwithlog && pushjar'


# for debug
alias jdbattach='$JDBATTACH_SH'
alias gdbattach='$GDBATTACH_SH'

alias checkremote.help='echo "repo start checkremote ."; echo "git remote update"; echo "git branch -a"; echo "git diff checkremote remotes/m/master"; echo "repo abandon checkremote"'
alias checkremote='repo start checkremote .; git remote update; git branch -a; git diff checkremote remotes/m/master; repo abandon checkremote'


alias make.ctags='$ENVSETUP/makectags.sh'
alias make.cscope='$ENVSETUP/makecscope.sh'
alias make.filelist='rm filelist'
alias make.allDBs='make.ctags; make.cscope; make.filelist'

alias findlib='$FINDLIB_SH'
alias findpkg='$FINDPKG_SH'
alias whichpkg='$WHICHPKG_SH'
alias findtest='$FINDTEST_SH'
alias listtest='runtest -l'

alias test.launchHome='amstart -a android.intent.action.MAIN -c android.intent.category.HOME -n com.google.tv.launcher/.HomeActivity'
alias test.onBoot='amstart -a android.intent.action.BOOT_COMPLETED -f 0x00000010'

alias ecosenv='. /opt/ecos/ecosenv.sh'

alias copy2glibc='croot; cp out/target/product/fox_glibc/system/lib/* out/target/product/fox/system/glibc; find ./out -name libOmxCore.so -exec ls -al {} \;'

alias cdwork='cd $WORK_MOUNTED'
alias cdtool='cd $TOOL_MOUNTED'

alias cda='cd $WORK_MOUNTED/arndale'
alias cdk='cd $WORK_MOUNTED/arndale_k'
alias cds='cd $WORK_MOUNTED/secureos'
alias cdd='cd $WORK_MOUNTED/secureos_doc'

alias cdtee='cd $WORK_MOUNTED/secureos/TEE/'
alias cdree='cd $WORK_MOUNTED/secureos/REE/'
alias fullmake="make clean && make -j$CPU_THREAD_NUM && make install"

alias t32='pushd /opt/t32/iTSP; ./start_powerview.sh'

alias make.error='make 2>&1 >/dev/null | grep error'
alias make.warning='make 2>&1 >/dev/null | grep warning'
alias make.kernel='adb shell reboot && make kinstall'
alias make.test='make clean && make && make result'

alias tzdrv="adb wait-for-device remount && adb shell /.toss/start_tz_driver.sh && adb shell /.toss/tee_daemon &"

echo "    ~/.envsetup.$OS/devsetup.sh sourced!!!"

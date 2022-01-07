#!/bin/bash

systempath=$1
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

apex_ls() {
    ls $systempath/apex
  }
  apex_file() {
    apex_ls | grep -q '.apex'
  }

  # Add aosp apex
  if ! apex_file ;then
    7z x -y $thispath/11/apex_common.7z -o$systempath/apex/ > /dev/null 2>&1
    android_art_debug_check() {
      apex_ls | grep -q "art.debug" 
    }
    android_art_release_check() {
      apex_ls | grep -q "art.release"
    }
    if android_art_debug_check ;then
      7z x -y $thispath/11/art.debug.7z -o$systempath/apex/ > /dev/null 2>&1
    fi

    if android_art_release_check ;then
      7z x -y $thispath/11/art.release.7z -o$systemdpath/apex/ > /dev/null 2>&1
    fi
  fi

# Make VNDK symlinks
rm -rf $systempath/lib/vndk-29 $systempath/lib/vndk-sp-29
rm -rf $systempath/lib/vndk-28 $systempath/lib/vndk-sp-28
rm -rf $systempath/lib64/vndk-29 $systempath/lib64/vndk-sp-29
rm -rf $systempath/lib64/vndk-28 $systempath/lib64/vndk-sp-28

ln -s  /apex/com.android.vndk.v29/lib $systempath/lib/vndk-29
ln -s  /apex/com.android.vndk.v28/lib $systempath/lib/vndk-28
ln -s  /apex/com.android.vndk.v29/lib $systempath/lib/vndk-sp-29
ln -s  /apex/com.android.vndk.v28/lib $systempath/lib/vndk-sp-28

ln -s  /apex/com.android.vndk.v29/lib64 $systempath/lib64/vndk-29
ln -s  /apex/com.android.vndk.v28/lib64 $systempath/lib64/vndk-28
ln -s  /apex/com.android.vndk.v29/lib64 $systempath/lib64/vndk-sp-29
ln -s  /apex/com.android.vndk.v28/lib64 $systempath/lib64/vndk-sp-28

# Extract VNDK apex to system
rm -rf $systemapth/apex/com.android.vndk.current*
7z x -y $thispath/11/vndk.7z -o$systempath/ 2>/dev/null >> $systempath/zip.log
7z x -y $thispath/11/current.7z -o$systempath/apex/ 2>/dev/null >> $systempath/zip.log
rm -rf $systempath/zip.log

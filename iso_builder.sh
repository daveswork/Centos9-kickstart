#!/bin/bash

BOOT_ISO=/tmp/boot.iso
BASEOS_ISO=/tmp/CentOS-Stream-8-x86_64-20220913-dvd1.iso
LOOP_DIR=/tmp/bootiso
WORKING_DIR=/tmp/bootisoks
CANDIDATE_KS=/home/dave/iso/kickstart/candidate-ks.cfg
DESTINATION_KS=$WORKING_DIR/isolinux/ks.cfg
CANDIDATE_ISOLINUX_CFG=/home/dave/iso/kickstart/candidate-isolinux.cfg
DESTINATION_ISOLINUX_CFG=$WORKING_DIR/isolinux/isolinux.cfg

if [[ -f $BOOT_ISO ]]; then
    echo "$BOOT_ISO exists."
    rm $BOOT_ISO
fi

if [[ -d $LOOP_DIR ]]; then
    echo "$LOOP_DIR exists."
    rm -rf $LOOP_DIR
fi

if [[ -d $WORKING_DIR ]]; then
    echo "$WORKING_DIR exists."
    rm -rf $WORKING_DIR
fi

mkdir $LOOP_DIR
mkdir $WORKING_DIR

sudo mount -o loop $BASEOS_ISO $LOOP_DIR

cp -rT $LOOP_DIR $WORKING_DIR

sudo umount $LOOP_DIR

cp $CANDIDATE_KS $DESTINATION_KS
cp $CANDIDATE_ISOLINUX_CFG $DESTINATION_ISOLINUX_CFG

mkisofs -o $BOOT_ISO -b isolinux.bin -c boot.cat \
-no-emul-boot -boot-load-size 4 -boot-info-table -V "CentOS-Stream-8-x86_64-dvd" \
-R -J -v -T $WORKING_DIR/isolinux/. $WORKING_DIR/.

isohybrid /tmp/boot.iso
implantisomd5 /tmp/boot.iso

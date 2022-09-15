#!/bin/bash

BOOT_ISO=/tmp/boot.iso
BASEOS_ISO=/tmp/CentOS-Stream-9-latest-x86_64-dvd1.iso
LOOP_DIR=/tmp/bootiso
WORKING_DIR=/tmp/bootisoks
CANDIDATE_KS=/home/dave/iso/kickstart/
DESTINATION_KS=$WORKING_DIR/isolinux/ks.cfg
CANDIDATE_ISOLINUX_CFG=/home/dave/iso/kickstart/isolinux.cfg
DESTINATION_ISOLINUX_CFG=$WORKING_DIR/isolinux/isolinux.cfg

echo $DESTINATION_KS
echo $DESTINATION_ISOLINUX_CFG

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
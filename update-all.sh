#!/bin/bash

sudo service klipper stop
cd ~/klipper
git pull

make clean KCONFIG_CONFIG=config.spider
make menuconfig KCONFIG_CONFIG=config.spider
make KCONFIG_CONFIG=config.spider
read -p "Spider firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

./scripts/flash-sdcard.sh /dev/ttyAMA0 fysetc-spider-v1
read -p "Spider firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

make clean KCONFIG_CONFIG=config.rpi
make menuconfig KCONFIG_CONFIG=config.rpi

make KCONFIG_CONFIG=config.rpi
read -p "RPi firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
make flash KCONFIG_CONFIG=config.rpi

sudo service klipper start

#!/bin/bash

printf "FULL TEST updater\n"

printf "Updating the updater\n"
cd /home/pi/code/netv2-burner-updater
git pull origin master
if [ $? -ne 0 ]; then
    printf "Trouble updating the updater, send this info to bunnie@alphamaxmedia.com\n"
    read dummy
    exit 1
fi

printf "Updating the tester\n"
cd /home/pi/code/netv2-tests
git pull origin master
if [ $? -ne 0 ]; then
    printf "Trouble updating the tester, send this info to bunnie@alphamaxmedia.com\n"
    read dummy
    exit 1
fi

printf "Updating the tester images\n"
cd /home/pi/code/netv2-tests/bin/netv2-fpga
git pull origin tester-master
if [ $? -ne 0 ]; then
    printf "Trouble updating the tester images, send this info to bunnie@alphamaxmedia.com\n"
    read dummy
    exit 1
fi

printf "Updating the user images\n"
cd /home/pi/code/netv2-tests/bin/netv2-fpga-userimage
git pull origin master
if [ $? -ne 0 ]; then
    printf "Trouble updating the user images, send this info to bunnie@alphamaxmedia.com\n"
    read dummy
    exit 1
fi

printf "\nCompleted successfully, hit enter twice to close window\n"
read dummy
read dummy

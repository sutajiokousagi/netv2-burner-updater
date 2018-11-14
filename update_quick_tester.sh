#!/bin/bash

printf "QUICK TEST updater\n"

printf "Updating the updater\n"
cd /home/pi/code/netv2-burner-updater
git pull origin master
if [ $? -ne 0 ]; then
    printf "Trouble updating the updater, send this info to bunnie@alphamaxmedia.com\n"
    read dummy
    exit 1
fi

printf "Updating the tester - quicktest\n"
cd /home/pi/code/netv2-tests
git pull origin quicktest
if [ $? -ne 0 ]; then
    printf "Trouble updating the tester, send this info to bunnie@alphamaxmedia.com\n"
    read dummy
    exit 1
fi

printf "Building & installing quicktest voltage driver\n"
cd /home/pi/code/netv2-tests/bin/testhat-drivers
sudo rm -f tester-driver
make
sudo chown root tester-driver
sudo chmod u+s tester-driver
/home/pi/code/netv2-tests/bin/testhat-drivers/tester-driver -v

printf "Updating the tester - UI\n"
cd /home/pi/code/jig-20-interface-http
git pull alphamax master
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

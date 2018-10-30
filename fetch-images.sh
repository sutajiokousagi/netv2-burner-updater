#!/bin/bash

printf "Updating the updater\n"
cd /home/bunnie/code/netv2-burner-updater
git pull origin master
if [ $? -ne 0 ]; then
    printf "Trouble updating the updater, send this info to bunnie@alphamaxmedia.com\n"
    read dummy
    exit 1
fi

printf "Updating the burner\n"
cd /home/bunnie/code/usb-pyromaniac
git pull origin master
if [ $? -ne 0 ]; then
    printf "Trouble updating the burner, send this info to bunnie@alphamaxmedia.com\n"
    read dummy
    exit 1
fi


printf "Fetching imager files\n"
cd /home/bunnie/images/production

rm -rf *

wget https://bunniefoo.com/netv2/production/manifest.md5
wget https://bunniefoo.com/netv2/production/partition.txt
wget https://bunniefoo.com/netv2/production/part1.img
wget https://bunniefoo.com/netv2/production/part2.ext4.gz

gunzip part2.ext4.gz

md5sum part1.img >> check.md5
md5sum part2.ext4 >> check.md5
md5sum partition.txt >> check.md5

if ! cmp -s check.md5 manifest.md5 ; then
    printf "Download problem, image does not match manifest! Send this info to bunnie@alphamaxmedia.com:\n"
    printf "\nmanifest.md5: \n"
    cat manifest.md5
    printf "\ncheck.md5: \n"
    cat check.md5
    printf "\ndirectory: \n"
    ls -l

    rm -rf *

    printf "\nPress enter to continue...\n"
    read dummy
    exit 1
fi

printf "Download successful, images are ready for use\n"
printf "Please send this snapshot to bunnie@alphamaxmedia.com to confirm download\n"

printf "\nmanifest.md5: \n"
cat manifest.md5
printf "\ncheck.md5: \n"
cat check.md5
printf "\ndirectory: \n"
ls -l
date

printf "\nPress enter to continue...\n"
read dummy
exit 0
#!/bin/sh

# Usage installMobileProvisionFile.sh path/to/foobar.mobileprovision


echo $0
echo $1


if [ ! $# == 1 ]; then
echo "Usage: $0 (path/to/mobileprovision)"
exit
fi

 uuid=`grep UUID -A1 -a $1 | grep -io "[-A-F0-9]\{36\}"`
 cp $1 ~/Library/MobileDevice/Provisioning\ Profiles/$uuid.mobileprovision

echo "done"
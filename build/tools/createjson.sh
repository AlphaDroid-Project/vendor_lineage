#!/bin/bash
#
# Copyright (C) 2019-2022 crDroid Android Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#$1=TARGET_DEVICE, $2=PRODUCT_OUT, $3=FILE_NAME
existingOTAjson=./vendor/OTA/$1.json
output=$2/$1.json

#cleanup old file
if [ -f $output ]; then
	rm $output
fi

echo "Generating JSON file data for OTA support..."

if [ -f $existingOTAjson ]; then
	#get data from already existing device json
	#there might be a better way to parse json yet here we try without adding more dependencies like jq
	maintainer=`grep -m 1 -n "\"maintainer\"" $existingOTAjson | cut -d ":" -f 3 | sed 's/"//g' | sed 's/,//g' | xargs`
	oem=`grep -m 1 -n "\"oem\"" $existingOTAjson | cut -d ":" -f 3 | sed 's/"//g' | sed 's/,//g' | xargs`
	device=`grep -m 1 -n "\"device\"" $existingOTAjson | cut -d ":" -f 3 | sed 's/"//g' | sed 's/,//g' | xargs`
	version=$(awk '{ sub(/v/, ""); sub(/\.zip/, ""); print }' <<< `echo "$3" | cut -d'-' -f6`)
	buildprop=$2/system/build.prop
	linenr=`grep -m 1 -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
	timestamp=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
	md5=`md5sum "$2/$3" | cut -d' ' -f1`
	sha256=`sha256sum "$2/$3" | cut -d' ' -f1`
	size=`stat -c "%s" "$2/$3"`
	linenr=`grep -m 1 -n "ro.alpha.build.package" $buildprop | cut -d':' -f1`
	buildtype=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
	forum=`grep -m 1 -n "\"forum\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
	if [ ! -z "$forum" ]; then
		forum="https:"$forum
	fi
	gapps=`grep -m 1 -n "\"gapps\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
	if [ ! -z "$gapps" ]; then
		gapps="https:"$gapps
	fi
	firmware=`grep -m 1 -n "\"firmware\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
	if [ ! -z "$firmware" ]; then
		firmware="https:"$firmware
	fi
	modem=`grep -m 1 -n "\"modem\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
	if [ ! -z "$modem" ]; then
		modem="https:"$modem
	fi
	bootloader=`grep -m 1 -n "\"bootloader\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
	if [ ! -z "$bootloader" ]; then
		bootloader="https:"$bootloader
	fi
	recovery=`grep -m 1 -n "\"recovery\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
	if [ ! -z "$recovery" ]; then
		recovery="https:"$recovery
	fi
	paypal=`grep -m 1 -n "\"paypal\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
	if [ ! -z "$paypal" ]; then
		paypal="https:"$paypal
	fi
	telegram=`grep -m 1 -n "\"telegram\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
	if [ ! -z "$telegram" ]; then
		telegram="https:"$telegram
	fi
	dt=`grep -m 1 -n "\"dt\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
	if [ ! -z "$dt" ]; then
		dt="https:"$dt
	fi
	common=`grep -m 1 -n "\"common-dt\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
	if [ ! -z "$common" ]; then
		common="https:"$common
	fi
	kernel=`grep -m 1 -n "\"kernel\"" $existingOTAjson | cut -d ":" -f 4 | sed 's/"//g' | sed 's/,//g' | xargs`
	if [ ! -z "$kernel" ]; then
		kernel="https:"$kernel
	fi

	echo '{
	"response": [
		{
			"maintainer": "'$maintainer'",
			"oem": "'$oem'",
			"device": "'$device'",
			"filename": "'$3'",
			"download": "https://sourceforge.net/projects/alphadroid-project/files/'$1'/'$3'/download",
			"timestamp": '$timestamp',
			"md5": "'$md5'",
			"sha256": "'$sha256'",
			"size": '$size',
			"version": "'$version'",
			"buildtype": "'$buildtype'",
			"forum": "'$forum'",
			"gapps": "'$gapps'",
			"firmware": "'$firmware'",
			"modem": "'$modem'",
			"bootloader": "'$bootloader'",
			"recovery": "'$recovery'",
			"paypal": "'$paypal'",
			"telegram": "'$telegram'",
			"dt": "'$dt'",
			"common-dt": "'$common'",
			"kernel": "'$kernel'"
		}
	]
}' >> $output

echo ""
cat $output

else
	version=$(awk '{ sub(/v/, ""); sub(/\.zip/, ""); print }' <<< `echo "$3" | cut -d'-' -f6`)
	buildprop=$2/system/build.prop
	linenr=`grep -m 1 -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
	timestamp=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
	md5=`md5sum "$2/$3" | cut -d' ' -f1`
	sha256=`sha256sum "$2/$3" | cut -d' ' -f1`
	size=`stat -c "%s" "$2/$3"`

	echo '{
	"response": [
		{
			"maintainer": "''",
			"oem": "''",
			"device": "''",
			"filename": "'$3'",
			"download": "https://sourceforge.net/projects/alphadroid-project/files/'$1'/'$3'/download",
			"timestamp": '$timestamp',
			"md5": "'$md5'",
			"sha256": "'$sha256'",
			"size": '$size',
			"version": "'$version'",
			"buildtype": "''",
			"forum": "''",
			"gapps": "''",
			"firmware": "''",
			"modem": "''",
			"bootloader": "''",
			"recovery": "''",
			"paypal": "''",
			"telegram": "''",
			"dt": "''",
			"common-dt": "''",
			"kernel": "''"
		}
	]
}' >> $output

	echo 'There is no official support for this device yet'
	echo 'Consider adding official support by reading the documentation at https://github.com/alphadroid-devices/OTA/blob/alpha-13/README.md'
fi

echo ""

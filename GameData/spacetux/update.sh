#!/bin/bash

releasedir=~/release
installdir=~/install/Gamedata/spacetux
mkdir -p $releasedir

major=0
minor=`cat version-number.txt`
patch=`cat build-number.txt`

curdir=`pwd`
i=`awk -v a="$curdir" -v b="GameData" 'BEGIN{print index(a,b)}'`
i=$((i-1))
curdir=`echo $curdir | cut -c1-${i}`

if [ "$1" = "mono" ]; then
	mono /Users/jbayer/Desktop/Kerbal/bin/netkan.exe  -v SpacetuxSA.netkan
	exit
fi

if [ "$1" = "install" ]; then
	shift
	rm -fr $installdir
	mkdir -p $installdir
	cp -r $* $installdir
	exit
fi

if [ "$1" = "version" ]; then
	d=`date +%Y%m%d-%H:%m`
	FILES="SpacetuxSA.version"
	for i in $FILES; do
		mv $i ${i}.$d
		sed "s/<MAJOR>/$major/g" ${i}.template | sed "s/<MINOR>/$minor/g" | sed "s/<PATCH>/$patch/g" >$i
	done
	exit
fi


cd ~/install
zip -9r ${releasedir}/SpacetuxSA-${major}.${minor}.${patch}.zip GameData/spacetux


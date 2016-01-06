#!/bin/bash

releasedir=$HOME/release
installdir="$HOME/install/Gamedata/spacetux $HOME/install/GameData/ContractPacks/Spacetux/SharedAssets"
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
	for i in $installdir; do
		rm -fr $i
		mkdir -p $i
		cp -r $* $i
	done
	rm  $HOME/install/GameData/ContractPacks/Spacetux/SharedAssets/Agencies/spacetux.cfg
	mv $HOME/install/GameData/ContractPacks/Spacetux/SharedAssets/Agencies/spacetux-sharedassets  $HOME/install/GameData/ContractPacks/Spacetux/SharedAssets/Agencies/spacetux.cfg


	touch $HOME/install/GameData/ContractPacks/Spacetux/SharedAssets/placeholder
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


cd $HOME/install
zip -9r ${releasedir}/SpacetuxSA-${major}.${minor}.${patch}.zip GameData/spacetux GameData/ContractPacks/Spacetux/SharedAssets/placeholder


#!/bin/bash

HOME=/d/Users/jbb
releasedir=$HOME/release
installdir="$HOME/install/Gamedata/spacetux $HOME/install/GameData/ContractPacks/Spacetux/SharedAssets"
mkdir -p $releasedir

OBJECTS="CHANGELOG License.txt Agencies/spacetux.cfg Agencies/spacetux.png Agencies/spacetux_sm.png Flags/spacetux_flag.png"
OBJECTS="CHANGELOG License.txt Agencies Flags"



curdir=`pwd`
i=`awk -v a="$curdir" -v b="GameData" 'BEGIN{print index(a,b)}'`
i=$((i-1))
curdir=`echo $curdir | cut -c1-${i}`


if [ "$1" = "install" ]; then
	shift
	for i in $installdir; do
		rm -fr $i
		mkdir -p $i
		cp -r $OBJECTS $i
	done
	rm  $HOME/install/GameData/ContractPacks/Spacetux/SharedAssets/Agencies/spacetux.cfg
	mv $HOME/install/GameData/ContractPacks/Spacetux/SharedAssets/Agencies/spacetux-sharedassets  $HOME/install/GameData/ContractPacks/Spacetux/SharedAssets/Agencies/spacetux.cfg


	touch $HOME/install/GameData/ContractPacks/Spacetux/SharedAssets/placeholder
	exit
fi

if [ "$1" = "release" ]; then
	cat SpacetuxSA.version
	echo -en "\nEnter version: "
	read version
set -x
	cd $HOME/install
	zip -9r ${releasedir}/SpacetuxSA-${version}.zip GameData/spacetux GameData/ContractPacks/Spacetux/SharedAssets/placeholder
fi


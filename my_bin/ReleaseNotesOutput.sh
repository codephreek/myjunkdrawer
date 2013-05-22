#! /bin/bash

STAR_VAR=`pwd`

if [ "$1" == "-r" ]; then
	cd $HOME/bin
	python ReleaseNotesOutput.py $2
	cd $STAR_VAR
else
	cd $HOME/bin
	python ReleaseNotesOutput.py $STAR_VAR/$1
	cd $STAR_VAR
fi


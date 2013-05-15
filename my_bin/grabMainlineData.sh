#!/bin/bash

# Set Date var
D_VAR=`date +"%Y%m%d"`
F_VAR=`date +"%Y%m%d_%H%M%S"`
EX_IGN="--exclude-dir=.git,gtest,site_scons"
EX_EXT="--exclude-ext=css,bat,html,HTML,htm,HTM,xml,XML"

STAR_VAR=`pwd`
cd $HOME/MainlineRepos
FOLDER=`pwd`/"XResults"

# make the main folder if it does not exist
if [ ! -d $FOLDER ]; 
   then mkdir $FOLDER
fi;

# make the current date folder if it does not exist
if [ ! -d $FOLDER/$D_VAR ];
   then mkdir $FOLDER/$D_VAR;
fi;

# make the current date-time folder if it does not exist (this should be unique)
if [ ! -d $FOLDER/$D_VAR/$F_VAR ];
   then mkdir $FOLDER/$D_VAR/$F_VAR;
fi;


for I in *; 
    do if [ -d $I ]; #if its a direcotry
          then 
	      if [ `pwd`/$I != $FOLDER ] #if it is not the XResults folder 
                  then 	          
		     CURR_DIR=`pwd`/$I
		     echo "  ";
		     echo "  ";
		     echo "  ";
                     echo "==================================================";
	             echo "Examining Project:   "  $CURR_DIR;
         	     echo "==================================================";

                     cd $CURR_DIR;# go into project
                     for dirs in *;
                       do
			 echo "  ";
			 echo "  ";
			 echo  "********   Examining Repo   ********"  
			 echo  $dirs;
			 echo  "    " 
#			 if [ $dirs != $FOLDER ] #if it is not the XResults folder 
#			     then
			         cd $dirs;
				 echo  "************  GIT PULL"
				 git pull;
				 echo "  ";
				 echo  "************  CLOCING"
				 cloc  $EX_IGN --by-file-by-lang --out=$FOLDER/$D_VAR/$F_VAR/$I/$dirs.txt *
				 echo "  ";
				 echo  "************  GITSTATS"
				 python $HOME/GitStats/gitstats $CURR_DIR/$dirs $FOLDER/$D_VAR/$F_VAR/$I/$dirs	
#				 gitstats $CURR_DIR/$dirs $FOLDER/$D_VAR/$F_VAR/$I/$dirs
				 cd ..;
#			 fi;
                     done
                     cd ..; #back up one		     
              fi; 	
       fi;
done

# make the totals files
cloc  $EX_IGN $EX_EXT --by-file-by-lang --out=$FOLDER/$D_VAR/$F_VAR/Totals.txt .
cloc  $EX_IGN --csv --out=$FOLDER/$D_VAR/$F_VAR/Totals.csv .

cd $STAR_VAR

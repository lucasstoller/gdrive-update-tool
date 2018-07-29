#!/bin/bash

echo -e "$1\n";

ls $1 > .buffer;

while read row; do
	name="'$row'";
	
	/bin/gdrive-linux-x64 list --query "name = $name" > .buffer2;
	id="$(cat .buffer2 | grep -n ^ | grep ^2 | cut -d' ' -f1 | cut -d':' -f2)";

	if [$id == '']
	then
		echo "$name is not in Drive yet. You need to upload before update it."		
		#echo "There is no file to be updated";
	else
		file=$1$row;
		echo -e "File: $file, ID: $id\n";
	
		/bin/gdrive-linux-x64 update $id $file;
		echo -e "OK\n";
	fi
done <.buffer


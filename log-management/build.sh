#!/bin/bash
for dir in ./*/
do
	cd $dir &&
	image_name=${PWD##*/} && # to assign to a variable
	echo "==========>Building $image_name from $dir" &&
	docker build -t twistedogic/$image_name .
done

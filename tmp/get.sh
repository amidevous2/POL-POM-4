while [ 1 ]
do
	read line
	cp "../icones_install/$line" ./
	if [ "$line" = "" ]; then break; fi
done

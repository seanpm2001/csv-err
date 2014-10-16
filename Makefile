.PHONY: keepright osmi all

install:
	sh src/install.sh

all:
	sudo make keepright
	sudo make osmi

keepright-errors.txt.bz2:
	echo " --- downloading keepright dump"
	curl -f http://keepright.ipax.at/keepright_errors.txt.bz2 > keepright-errors.txt.bz2

keepright: keepright-errors.txt.bz2
	sh src/import.keepright.sh
	sh src/tasks.keepright.sh
	# sh src/s3.keepright.sh

osmi:
	sh src/import.osmi.sh
	sh src/tasks.osmi.sh
	# sh src/s3.osmi.sh

tiger-missing.json.gz:
	echo " --- downloading tigerdelta"
	curl -f "http://trafficways.org/obsolete/osm-diff-2014.json.gz" -o tiger-missing.json.gz

tigerdelta: tiger-missing.json.gz
	sh src/import.tigerdelta.sh
	sh src/tasks.tigerdelta.sh
	# sh src/s3.tigerdelta.sh

npsdiff:
	sh src/import.npsdiff.sh
	sh src/tasks.npsdiff.sh
	# sh src/s3.npsdiff.sh

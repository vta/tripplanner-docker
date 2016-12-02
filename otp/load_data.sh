#!/bin/bash

DATA_DIR="/srv/tripplanner/data"
GTFSM="python /srv/tripplanner/gtfs-manager/src/gtfs-manager/gtfsmanager.py"
GTFSM_TEMP_DIR="/srv/tripplanner/data_tmp"

cd $DATA_DIR

# OSM DATA for SF Bay Area
curl -L -o map.osm.bz2 https://s3.amazonaws.com/metro-extracts.mapzen.com/san-francisco-bay_california.osm.bz2
rm -f map.osm
bunzip2 map.osm.bz2

cd $GTFSM_TEMP_DIR

# VTA. use Google file instead
$GTFSM -o ../data/ VTA http://www.vta.org/sfc/servlet.shepherd/document/download/069A0000001NUea

#Caltrain
$GTFSM -o ../data/ Caltrain http://www.caltrain.com/Assets/GTFS/caltrain/Caltrain-GTFS.zip

# BART
$GTFSM -o ../data/ BART http://transitfeeds.com/p/bart/58/latest/download

#SFMTA
#curl -L -o gtfs_SFMTA.zip http://archives.sfmta.com/transitdata/google_transit.zip

# Golden Gate Transit
$GTFSM -o ../data/ GGT http://transitfeeds.com/p/golden-gate-bridge-highway-transportation-district/349/latest/download
$GTFSM -o ../data/ SFFarries http://transitfeeds.com/p/golden-gate-bridge-highway-transportation-district/344/latest/download

#samTrans
$GTFSM -o ../data/ samTrans http://transitfeeds.com/p/samtrans/144/latest/download

#Marin Transit
#$GTFSM -o ../data/ Marin http://transitfeeds.com/p/marin-transit/345/latest/download

#Sonoma County
#curl -L -o gtfs_Sonoma.zip http://data.trilliumtransit.com/gtfs/sonomacounty-ca-us/sonomacounty-ca-us.zip

# AC Transit
#curl -L -o gtfs_AC_1.zip http://www.actransit.org/wp-content/uploads/gtfsjune142015b.zip
#curl -L -o gtfs_AC_2.zip http://www.actransit.org/wp-content/uploads/GTFSAug232015b.zip
$GTFSM -o ../data/ ACTransit http://transitfeeds.com/p/ac-transit/121/latest/download

# Santa Cruz
$GTFSM -o ../data/ SantaCruz http://transitfeeds.com/p/santa-cruz-metro/343/latest/download

# SF Muni (same as SFMTA?)
$GTFSM -o ../data/ SFMuni http://transitfeeds.com/p/sfmta/60/latest/download

#County Connection
$GTFSM -o ../data/ CountyConnection http://transitfeeds.com/p/county-connection/222/latest/download

# San Benito County
$GTFSM -o ../data/ SanBenito http://transitfeeds.com/p/san-benito-county-express/491/latest/download

#Stanford Marguerite Shuttle
$GTFSM -o ../data/ StanfordMarguerite https://transportation-forms.stanford.edu/google/google_transit.zip

# Build OTP graph
java -Xmx6G -Xverify:none -jar /srv/vta.amigocloud.com/OTP/target/otp-1.0.0-shaded.jar --build /srv/vta.amigocloud.com/data --cache /srv/vta.amigocloud.com/ned/
mv ../data/Graph.obj ../data/graphs/default/

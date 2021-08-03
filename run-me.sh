#!/bin/bash

docker ps | awk '{if(NR>1)print}'| awk '{ print $1}' | xargs docker stop
docker ps -a | awk '{if(NR>1)print}'| awk '{ print $1}' | xargs docker rm
docker build -t doofus .;docker run -p3200:3200 -d doofus

# open http://www.example.com:3200
# open http://example.com:3200
# open http://www.example.com:3200/bob
# open http://localhost:3400
# open http://www.doofus.com:3200

container=$(docker ps | awk '{if(NR>1)print}'| awk '{ print $1}')
echo $container

echo ""
echo "============================================================="
echo "Testing - http://www.example.com:3200"
echo "============================================================="
curl http://www.example.com:3200
echo ""
echo "============================================================="
echo "Testing - http://www.example.com:3200/bob"
echo "============================================================="
curl http://www.example.com:3200/bob
echo ""
echo "============================================================="
echo "Testing - http://example.com:3200"
echo "============================================================="
curl http://example.com:3200
echo ""
echo "============================================================="
echo "Testing - http://localhost:3400"
echo "============================================================="
curl http://localhost:3400
echo ""

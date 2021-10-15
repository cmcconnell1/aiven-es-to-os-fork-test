#!/bin/bash

cd ./terraform/opensearch

./bin/init
./bin/plan
./bin/apply

cd ../../

echo

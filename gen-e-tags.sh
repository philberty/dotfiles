#!/usr/bin/env bash
set -e

PWD=`pwd`
echo "Generating TAGS for $PWD"

rm -f TAGS
find . -name "*.c" -print | etags -a -
find . -name "*.cpp" -print | etags -a -
find . -name "*.h" -print | etags -a -
find . -name "*.hpp" -print | etags -a -

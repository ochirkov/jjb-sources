#!/bin/bash -xe

tox -e $TARGET

if [[ $TARGET == 'docs' ]]; then
  mkdir -p /var/www/html/$BRANCH || /bin/true
  cp -ra doc/build/html/* /var/www/html/$BRANCH
else
  mkdir -p /tmp/cover || /bin/true
  cp cover/coverage.xml /tmp/cover/
fi

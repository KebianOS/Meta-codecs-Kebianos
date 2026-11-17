#!/bin/bash
set -e
PKG=kebianos-meta-codecs
cd "$(dirname "$0")"
ROOT=$PWD

cd "$PKG"
ver=$(dpkg-parsechangelog -S Version)
echo "$ver"

dpkg-buildpackage -us -uc -b
debian/rules clean
cd "$ROOT"

mkdir -p build
mv -f ./*.deb build/
rm -f ./*.buildinfo ./*.changes

if [ "$1" = "-u" ]; then
    git add -A
    git commit -m "$ver"
    git push origin main
fi

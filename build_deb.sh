#!/bin/sh
set -e
cd deb-build
dpkg-buildpackage -tc -b

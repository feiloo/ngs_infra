#!/bin/bash

rm -rf /tmp/ngs_release
mkdir -p /tmp/ngs_release
rsync -au --remove-source-files ukb2580:/tmp/ngs_pipeline_build/meson-dist/*.tar.xz /tmp/ngs_release/ || echo no release found && exit 1

cd /tmp/ngs_release
fname=$(ls)

tar xvf "$fname"
rm "$fname"

cd $(basename "$fname" .tar.xz)

meson setup /tmp/ngs_release_build
cd /tmp/ngs_release_build
meson compile
meson install

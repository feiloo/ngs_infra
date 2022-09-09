#!/bin/bash

rm -rf /tmp/ngs_release
mkdir -p /tmp/ngs_release
rsync -au --remove-source-files ukb2580:/tmp/ngs_pipeline_build/meson-dist/*.tar.xz /tmp/ngs_release/

cd /tmp/ngs_release
tar xvf *.tar.xz

cd $(ls)

meson setup /tmp/ngs_release_build
cd /tmp/ngs_release_build
meson compile
meson install

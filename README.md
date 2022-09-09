big files should be pulled during installation of the package on the enduser/server
prefer to use a pull deployment model

this service can be installed with `meson install` and uninstalled with `meson uninstall`
or `ninja install`  and `ninja uninstall`


to setup the ci infra for the ngs_pipeline (from source):
```
# clone the repo
git@github.com:feiloo/ngs_infra.git

cd ngs_infra
# setup
meson setup /tmp/ngs_infra_build
cd /tmp/ngs_infra_build
meson compile
meson install
```

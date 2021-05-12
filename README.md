# linbo-build-docker

## Docker build environment for linuxmuster-linbo7

This build environment allows building linuxmuster-linbo7 ubuntu packages on any linux distro, which provides docker and git.

### Installation
- Clone this repository.
- Change into the repo directory and invoke `./environment_setup.sh`.
- This will
  - create the linbo directory,
  - clone the linuxmuster-linbo7 repository into the linbo directory and
  - create the docker image containing the build environment.  

Note:
- The linbo directory will be passed to the docker container as home directory for the linbo build user.
- The linbo build user inherits his uid/gid from the current user.
- If the linuxmuster-linbo7 repository was already cloned this step will be skipped.

### Usage
- To build the debian package simply invoke `./build_pkg.sh`. This fires up the container and invokes for its part the package build script delivered with linuxmuster-linbo7.
- The console output is logged to `linbo/build.log`.
- With the termination of the script the container shuts down and will be removed.
- The resulting ubuntu packages are located in the linbo directory.

### Files
- build_pkg.sh: package build script.
- create_dockerimage.sh: creates the docker image, inkoved by environment_setup.sh.
- Dockerfile: image definition file.
- environment_setup.sh: initially sets up the build environment.
- start_container.sh: starts the container in interactive mode.

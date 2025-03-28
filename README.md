# linbo-build-docker

## Docker build environment for linuxmuster-linbo7 (main branch)

This build environment based on Ubuntu 24.04 allows building linuxmuster-linbo7 ubuntu packages on any linux distro, which provides docker and git.

Note:
- If you want to build a package of linuxmuster-linbo7 4.2.x you have to checkout branch 22.04.
- Run the scripts as an unprivileged user. The user has to member of the group _docker_.

### Installation/Update
- Clone this repository.
- Change into the repo directory and invoke `./setup_env.sh`.
- This will
  - create the linbo directory,
  - clone the linuxmuster-linbo7 repository into the linbo directory,
  - create the docker image containing the build environment.
- To update the environment simply call `./update_env.sh`. Note: This will not update the linuxmuster-linbo7 repo. You have to keep this up to date manually.

### Usage
- To build the debian package simply invoke `./build_pkg.sh`. This fires up the container and invokes for its part the package build script delivered with linuxmuster-linbo7.
- The linbo directory will be passed through to the docker container as home directory for the linbo build user.
- The linbo build user inherits his uid/gid from the current user.
- The console output is logged to `linbo/build.log`.
- With the termination of the script the container shuts down and will be removed.
- The resulting ubuntu packages are located in the linbo directory.

### Files
- build_pkg.sh: package build script.
- create_dockerimage.sh: creates the docker image, inkoved by environment_setup.sh.
- Dockerfile.tpl: image definition file (template).
- setup_env.sh: initially sets up the build environment.
- update_env.sh: pulls the git repo and recreates the docker image.
- start_container.sh: starts the container in interactive mode.

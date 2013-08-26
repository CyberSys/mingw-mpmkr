MinGW Package Maker (mpmkr)

The Makefile script, extracts the upstream source file, executes the make 
process, installs files into a staging area, processes the staging area to
create the packages deliverable for the mingw-get distribution system.  It is
expected that you have a working MinGW MSYS and MinGW gcc and g++ compilers.

In the MSYS shell type
$ make clean package 2>&1 | tee pkg.log

The newly built packages are available for upload in the rls directory.  It is
expected that if you are now maintaining this package that you know how to
modify the mingw-dist system correctly and upload files to the SF directory
structures.

If you execute make without targets it will give a usage for the package.
$ make
To use this make file do the following steps:
make prep : Unpacks the original sources.
make patch : Apply custom patches if there are any.
make configure: Runs the configure script.
make compile: Executes make.
make stage: Installs into a staging area.
make post_stage: Miscellaneous actions performed to the stage area.
make package: Packages the build results including the source.
make clean: Cleans the workspace in order to rebuild the package
make check: Runs self-tests.
make install: Installs the package into the configured directory.

If you execute "make clean package" all of the steps except
the "make check" and "make install" steps should be executed
in order. If you execute "make clean check" all of the steps
except the "make install" and "make package" steps should be
executed in order. If you execute "make clean install" all of
the steps except the "make check" and "make package" steps
should be executed in order.

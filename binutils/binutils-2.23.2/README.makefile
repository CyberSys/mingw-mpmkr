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


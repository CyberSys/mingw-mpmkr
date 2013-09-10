##
# @file Makefile
# Copyright 2013 MinGW.org project
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice (including the next
# paragraph) shall be included in all copies or substantial portions of the
# Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
# This file is part of MinGW Package Maker (mpmkr).
#
# This file is used to make the packages for pthreads-w32-2.9.1 MinGW
# distribution.
include package.ini

PACKAGE = $(PKG)-$(PKGVER)
PKGFILE = $(PACKAGE).$(PKGEXT)

MPKG = $(PKG)-$(MPKGVER)-$(MPKGRLS)-$(MPKGRT)

MPKGSRC = $(MPKG)-src.$(MPKGEXT)
MPKGBIN = $(MPKG)-bin.$(MPKGEXT)
MPKGDLL = $(MPKG)-dll.$(MPKGEXT)
MPKGDEV = $(MPKG)-dev.$(MPKGEXT)
MPKGLIC = $(MPKG)-lic.$(MPKGEXT)
MPKGINFO = $(MPKG)-info.$(MPKGEXT)
MPKGMAN = $(MPKG)-man.$(MPKGEXT)
MPKGLANG = $(MPKG)-lang.$(MPKGEXT)
DOCDIR = share/doc/$(PKG)/$(MPKGVER)
LICDIR = share/doc/$(PKG)/$(MPKGVER)
INFODIR = share/info
MANDIR = share/man
LOCALEDIR = share/locale
MPKGDOC = $(MPKG)-doc.$(MPKGEXT)

ifeq (,$(MPATCHOPT))
MPATCHOPT = -p0
endif

SRC_FILES = pthreads-w32-2-9-1-release.tar.gz Makefile README.Makefile \
  README.pthreads-w32-1-2.9.1-mingw32 $(MPATCHES)
INC_FILES = pthread.h  sched.h  semaphore.h
LIB_FILES = libpthread.a  libpthread.dll.a  libpthreadGC2.dll.a  libpthreadGCE2.dll.a

INSTALL_DATA = /bin/install -v -m 644
INSTALL_DIR  = /bin/install -v -d
INSTALL_BIN  = /bin/install -v -m 755

CPALL = /bin/cp -a
MKDIR_P = /bin/mkdir -p
RMF = /bin/rm -f
RMFR = $(RMF)r
RMPKG = $(RMFR) pkg/
MKPKGFILE = cd pkg && /bin/tar acf ../$@ *
EXTRACTPKG = /bin/tar axf $(PKGFILE)
TOUCH = /bin/touch $@
RMDIR = /bin/rmdir
MV = /bin/mv
WGET = /bin/wget
PATCH = /bin/patch
LS = /bin/ls
CONFIGURE = cd bld && ../$(PACKAGE)/configure
COMPILE = cd bld && /bin/make
STAGE = $(COMPILE) install prefix=`pwd`/../stg

all: usage

prep: $(PKGFILE) exec_prep
exec_prep:
	$(RMFR) $(PACKAGE)
	$(EXTRACTPKG)
	$(MKDIR_P) bld
	$(TOUCH)

$(PKGFILE):
	$(RMFR) part
	$(MKDIR_P) part
	$(WGET) $(PKGURL)/$(PKGFILE) -O part/$(PKGFILE)
	$(CPALL) part/$(PKGFILE) $(PKGFILE)
	$(RMFR) part

patch: prep exec_patch
exec_patch:
ifneq ($(MPATCHES),)
	for F in $(MPATCHES); do \
	  $(PATCH) $(MPATCHOPT) < $$F ; \
	done
endif
	$(TOUCH)

# There is no configure script for this package
configure: patch exec_configure
exec_configure:
	$(TOUCH)

# We must build in the source directory
compile: configure exec_compile
exec_compile:
	cd $(PACKAGE) ; \
	make -f GNUmakefile clean GC-inlined ; \
	make -f GNUmakefile clean GCE-inlined ; \
	$(CPALL) lib$(GC2).a lib$(GC2).dll.a ; \
	$(CPALL) lib$(GCE2).a lib$(GCE2).dll.a ; \
	make -f GNUmakefile clean GC-static
	$(TOUCH)

GC2=pthreadGC2
GCE2=pthreadGCE2

# This package has no install target, we must copy ourselves
stage: compile exec_stage
exec_stage: stg/include stg/bin stg/lib stg/$(HOST) stg/share/doc/$(PKG)/$(MPKGVER)
	$(TOUCH)
stg/include:
	$(INSTALL_DIR) $@
	$(INSTALL_DATA) $(PACKAGE)/pthread.h $@/pthread.h
	$(INSTALL_DATA) $(PACKAGE)/sched.h $@/sched.h
	$(INSTALL_DATA) $(PACKAGE)/semaphore.h $@/semaphore.h
stg/bin:
	$(INSTALL_DIR) $@
	$(INSTALL_BIN) $(PACKAGE)/$(GC2).dll $@/$(GC2).dll
	$(INSTALL_BIN) $(PACKAGE)/$(GCE2).dll $@/$(GCE2).dll
stg/lib:
	$(INSTALL_DIR) $@
	$(INSTALL_DATA) $(PACKAGE)/lib$(GC2).dll.a $@/lib$(GC2).dll.a
	$(INSTALL_DATA) $(PACKAGE)/lib$(GCE2).dll.a $@/lib$(GCE2).dll.a
	$(INSTALL_DATA) $(PACKAGE)/lib$(GC2).a $@/lib$(GC2).a
	$(INSTALL_DATA) $(PACKAGE)/lib$(GC2).dll.a $@/libpthread.dll.a
	$(INSTALL_DATA) $(PACKAGE)/lib$(GC2).a $@/libpthread.a
stg/$(HOST):
	$(INSTALL_DIR) $@
	$(CPALL) stg/include stg/lib $@
ALL_DOC_FILES := $(LIC_FILES) $(DOC_FILES)
stg/share/doc/$(PKG)/$(MPKGVER): stg/share/doc/$(PKG)/$(MPKGVER)/README.$(MPKG)
	$(INSTALL_DIR) $@
	for F in $(ALL_DOC_FILES); do \
	  $(INSTALL_DATA) $(PACKAGE)/$$F $@/$$F ; \
	done
stg/share/doc/$(PKG)/$(MPKGVER)/README.$(MPKG): README.$(MPKG)
	$(INSTALL_DIR) $(@D)
	$(INSTALL_DATA) $? $@

post_stage: stage exec_post_stage
exec_post_stage:
	$(TOUCH)

package: post_stage exec_package
exec_package: rls rls/$(MPKGSRC) rls/$(MPKGDLL) rls/$(MPKGBIN) rls/$(MPKGDEV) rls/$(MPKGLIC) rls/$(MPKGDOC) rls/$(MPKGINFO) rls/$(MPKGMAN) rls/$(MPKGLANG) rls/README.$(MPKG)
	$(TOUCH)

rls:
	$(RMFR) rls
	$(INSTALL_DIR) $@

rls/$(MPKGSRC): $(PKGFILE) Makefile package.ini README.makefile README.$(MPKG) $(MPATCHES)
	$(RMPKG)
	$(INSTALL_DIR) pkg/$(MPKG)
	for F in $^; do \
	  $(INSTALL_DATA) $$F pkg/$(MPKG)/$$F ; \
	done
	$(MKPKGFILE)

rls/$(MPKGBIN):
	if test `$(LS) stg/bin/* > /dev/null; echo $$?` = 0; then \
	  $(RMPKG) ; \
	  $(INSTALL_DIR) pkg/bin ; \
	  if test -d stg/$(HOST)/bin; then \
	    $(INSTALL_DIR) pkg/$(HOST)/bin ; \
	    $(CPALL) stg/$(HOST)/bin/* pkg/$(HOST)/bin/ ; \
	    $(RMF) pkg/$(HOST)/bin/*.dll ; \
	  fi ; \
	  $(CPALL) stg/bin/* pkg/bin/ ; \
	  $(RMF) pkg/bin/*.dll ; \
	  if test `$(LS) pkg/bin/* > /dev/null; echo $$?` = 0; then \
	    $(MKPKGFILE) ; \
	  fi ; \
	fi

rls/$(MPKGDLL):
	if test `$(LS) stg/bin/*.dll > /dev/null; echo $$?` = 0; then \
	  $(RMPKG) ; \
	  $(INSTALL_DIR) pkg/bin ; \
	  $(CPALL) stg/bin/*.dll pkg/bin/ ; \
	  $(MKPKGFILE) ; \
	fi

rls/$(MPKGDEV):
	$(eval NEED_TO_MAKEPKG = 0)
	if test -d stg/include -o -d stg/lib -o -d stg/libexec; then \
	  $(RMPKG) ; \
	  if test -d stg/include; then \
	    $(INSTALL_DIR) pkg/include ; \
	    $(CPALL) stg/include pkg/ ; \
	    $(eval NEED_TO_MAKEPKG = 1) \
	  fi ; \
	  if test -d stg/lib; then \
	    $(INSTALL_DIR) pkg/lib ; \
	    $(CPALL) stg/lib pkg/ ; \
	    $(RMF) pkg/lib/*.la ; \
	    $(eval NEED_TO_MAKEPKG = 1) \
	  fi ; \
	  if test -d stg/libexec; then \
	    $(INSTALL_DIR) pkg/libexec ; \
	    $(CPALL) stg/libexec pkg/ ; \
	    $(eval NEED_TO_MAKEPKG = 1) \
	  fi ; \
	fi
	if test -d stg/$(HOST)/include \
	  -o -d stg/$(HOST)/lib \
	  -o -d stg/$(HOST)/libexec; then \
	  if test -d stg/include; then \
	    $(INSTALL_DIR) pkg/$(HOST)/include ; \
	    $(CPALL) stg/$(HOST)/include/* pkg/$(HOST)/include/ ; \
	    $(eval NEED_TO_MAKEPKG = 1) \
	  fi ; \
	  if test -d stg/lib; then \
	    $(INSTALL_DIR) pkg/$(HOST)/lib ; \
	    $(CPALL) stg/$(HOST)/lib/* pkg/$(HOST)/lib/ ; \
	    $(RMF) pkg/$(HOST)/lib/*.la ; \
	    $(eval NEED_TO_MAKEPKG = 1) \
	  fi ; \
	  if test -d stg/libexec; then \
	    $(INSTALL_DIR) pkg/$(HOST)/libexec ; \
	    $(CPALL) stg/$(HOST)/libexec/* pkg/$(HOST)/libexec/ ; \
	    $(eval NEED_TO_MAKEPKG = 1) \
	  fi ; \
	fi
	if test $(NEED_TO_MAKEPKG) = 1; then \
	  $(MKPKGFILE) ; \
	fi

rls/$(MPKGLIC):
	if test ! -z "$(LIC_FILES)"; then \
	  $(RMPKG) ; \
	  for F in $(LIC_FILES); do \
	    D=`dirname $$F` ; \
	    $(INSTALL_DIR) pkg/$(LICDIR)/$$D ; \
	    $(INSTALL_DATA) stg/$(LICDIR)/$$F pkg/$(LICDIR)/$$D ; \
	  done ; \
	  $(MKPKGFILE) ; \
	fi

rls/$(MPKGDOC):
	if test ! -z "$(DOC_FILES)"; then \
	  $(RMPKG) ; \
	  for F in $(DOC_FILES) README.$(MPKG); do \
	    D=`dirname $$F` ; \
	    $(INSTALL_DIR) pkg/$(DOCDIR)/$$D ; \
	    $(INSTALL_DATA) stg/$(DOCDIR)/$$F pkg/$(DOCDIR)/$$D ; \
	  done ; \
	  $(MKPKGFILE) ; \
	fi

rls/$(MPKGINFO):
	if test -d stg/$(INFODIR); then \
	  $(RMPKG) ; \
	  $(INSTALL_DIR) pkg/$(INFODIR) ; \
	  $(CPALL) stg/$(INFODIR)/* pkg/$(INFODIR)/ ; \
	  $(RMF) pkg/$(INFODIR)/dir ; \
	  $(MKPKGFILE) ; \
	fi

rls/$(MPKGMAN):
	if test -d stg/$(MANDIR); then \
	  $(RMPKG) ; \
	  $(INSTALL_DIR) pkg/$(MANDIR) ; \
	  $(CPALL) stg/$(MANDIR)/* pkg/$(MANDIR) ; \
	  $(MKPKGFILE) ; \
	fi

rls/$(MPKGLANG):
	if test -d stg/$(LOCALEDIR); then \
	  $(RMPKG) ; \
	  $(INSTALL_DIR) pkg/$(LOCALEDIR) ; \
	  $(CPALL) stg/$(LOCALEDIR)/* pkg/$(LOCALEDIR)/ ; \
	  $(MKPKGFILE) ; \
	fi

rls/README.$(MPKG):
	cp -a README.$(MPKG) rls/

clean: 
	rm -rf $(PACKAGE)
	rm -rf stg
	rm -rf rls
	rm -rf pkg
	rm -rf bld
	rm -rf part
	rm -f exec_*
	rm -f *.log

# @TODO - complete this target
# Need to provide a good looking report based on known tests and .pass existing.
check: compile exec_check
exec_check:
	cd $(PACKAGE)/tests ; \
	make -k -j1 -f GNUmakefile clean GC 2>&1 | tee ../../check.log ; \
	make -k -j1 -f GNUmakefile clean GCE 2>&1 | tee -a ../../check.log

install: compile stage
	$(INSTALL_DIR) $(PREFIX)
	cp -a stg/* $(PREFIX)/

usage:
	@echo To use this make file do the following steps:
	@echo make prep : Unpacks the original sources.
	@echo make patch : Apply custom patches if there are any.
	@echo make configure: Runs the configure script.
	@echo make compile: Executes make.
	@echo make stage: Installs into a staging area.
	@echo make post_stage: Miscellaneous actions performed to the stage area.
	@echo make package: Packages the build results including the source.
	@echo make clean: Cleans the workspace in order to rebuild the package
	@echo make check: Runs self-tests.
	@echo make install: Installs the package into the configured directory.
	@echo
	@echo If you execute \"make clean package\" all of the steps except
	@echo the \"make check\" and \"make install\" steps should be executed
	@echo in order.

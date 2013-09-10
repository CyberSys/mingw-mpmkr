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
# This file is used to make the packages for gcc-4.8.1 MinGW distribution.
include package.ini

PACKAGE = $(PKG)-$(PKGVER)
PKGFILE = $(PACKAGE)$(PKGEXTRA).$(PKGEXT)

MPKG = $(PKG)-$(MPKGVER)-$(MPKGRLS)-$(MPKGRT)

MPKGSRC = $(MPKG)-src.$(MPKGEXT)
MPKGPART = core c++ fortran ada objc
MPKGLIC = $(MPKG)-lic.$(MPKGEXT)
MPKGLANG = $(MPKG)-lang.$(MPKGEXT)
DOCDIR = share/doc/$(PKG)/$(MPKGVER)
LICDIR = share/doc/$(PKG)/$(MPKGVER)
INFODIR = share/info
MANDIR = share/man
LOCALEDIR = share/locale

core_BIN_FILES = cpp.exe gcc.exe $(HOST)-gcc-4.8.1.exe $(HOST)-gcc.exe cc.exe gcc-ar.exe gcc-nm.exe gcc-ranlib.exe $(HOST)-cc.exe $(HOST)-gcc-ar.exe $(HOST)-gcc-nm.exe $(HOST)-gcc-ranlib.exe
core_DLL_FILES = libgomp-1.dll libquadmath-0.dll libssp-0.dll libgcc_s_dw2-1.dll
core_LIB_FILES = crtbegin.o crtend.o crtfastmath.o include include-fixed install-tools libgcc.a libgcc_eh.a libgcc_s.a libgcov.a libgomp.a libgomp.dll.a libgomp.spec libquadmath.a libquadmath.dll.a libssp.a libssp.dll.a libssp_nonshared.a
core_LIB_EXCLUDE_FILES = include/c++ include/objc
core_LIBEXEC_FILES = cc1.exe collect2.exe install-tools liblto_plugin-0.dll liblto_plugin.dll.a lto-wrapper.exe lto1.exe

cpp_BIN_FILES = c++.exe g++.exe $(HOST)-g++.exe $(HOST)-c++.exe
cpp_DLL_FILES = libstdc++-6.dll
cpp_LIB_FILES = debug include/c++ libstdc++.a libstdc++.dll.a libstdc++.dll.a-gdb.py libsupc++.a
cpp_LIBEXEC_FILES = cc1plus.exe
cpp_SHARE_FILES = python

fortran_BIN_FILES = gfortran.exe $(HOST)-gfortran.exe
fortran_DLL_FILES = libgfortran-3.dll
fortran_LIB_FILES = finclude libgfortran.a libgfortran.dll.a libgfortran.spec libgfortranbegin.a
fortran_LIBEXEC_FILES = f951.exe

objc_BIN_FILES =
objc_DLL_FILES = libobjc-4.dll
objc_LIB_FILES = include/objc libobjc.a libobjc.dll.a
objc_LIBEXEC_FILES = cc1obj.exe cc1objplus.exe

ada_BIN_FILES = gnat.exe gnatbind.exe gnatchop.exe gnatfind.exe gnatkr.exe gnatlink.exe gnatls.exe gnatmake.exe gnatprep.exe gnatxref.exe
ada_BIN_FILES+= $(HOST)-gnat.exe $(HOST)-gnatbind.exe $(HOST)-gnatchop.exe $(HOST)-gnatfind.exe $(HOST)-gnatkr.exe $(HOST)-gnatlink.exe $(HOST)-gnatls.exe $(HOST)-gnatmake.exe $(HOST)-gnatprep.exe $(HOST)-gnatxref.exe
ada_DLL_FILES = libgnat-4.8.dll libgnarl-4.8.dll
ada_LIB_FILES = adainclude adalib
ada_LIBEXEC_FILES = gnat1.exe

ifeq (,$(MPATCHOPT))
MPATCHOPT = -p0
endif

INSTALL_DATA = /bin/install -v -m 644
INSTALL_DIR = /bin/install -v -d
INSTALL_BIN = /bin/install -v -m 755

CPALL = /bin/cp -af
MKDIR_P = /bin/mkdir -p
RMF = /bin/rm -f
RMFR = $(RMF)r
RMPKG = $(RMFR) pkg/
MKPKGFILE = cd pkg && /bin/tar acf ../$@ *
MKPKGPARTFILE = cd pkg && /bin/tar acf ../$(MPKGFILE) --dereference --hard-dereference *
EXTRACTPKG = /bin/tar axf $(PACKAGE).$(PKGEXT)
TOUCH = /bin/touch $@
RMDIR = /bin/rmdir
MV = /bin/mv
WGET = /bin/wget
PATCH = /bin/patch
STRIP = strip
MVF = $(MV) -f
FIND = /usr/bin/find
LS = /bin/ls
CONFIGURE = cd bld && ../$(PACKAGE)/configure
LDFLAGS = --verbose -L/mingw/$(HOST)/lib -B/mingw/$(HOST)/lib
COMPILE = mkdir -p bld/gcc; cp -a /mingw/lib/crt2.o bld/gcc/; cd bld && \
  export GCC_EXEC_PREFIX=/mingw/lib/gcc/; \
  export LDFLAGS="$(LDFLAGS)"; \
  export LDFLAGS_FOR_TARGET="$(LDFLAGS)"; \
  export LDFLAGS_FOR_BUILD="$(LDFLAGS)"; \
  export STAGE1_LDFLAGS="$(LDFLAGS)"; \
  export POSTSTAGE1_LDFLAGS="$(LDFLAGS)"; \
  export BOOT_LDFLAGS="$(LDFLAGS)"; \
  export TOOLS_LIBS="$(LDFLAGS)"; \
  export SYSLIBS="$(LDFLAGS)"; \
  /bin/make \
  LDFLAGS_FOR_TARGET="$(LDFLAGS)" \
  LDFLAGS_FOR_BUILD="$(LDFLAGS)" \
  STAGE1_LDFLAGS="$(LDFLAGS)" \
  POSTSTAGE1_LDFLAGS="$(LDFLAGS)" \
  BOOT_LDFLAGS="$(LDFLAGS)" \
  TOOLS_LIBS="$(LDFLAGS)" \
  SYSLIBS="$(LDFLAGS)" \
  LDFLAGS="$(LDFLAGS)"
STAGE = $(COMPILE) install prefix=\`pwd\`/../stg

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

configure: patch exec_configure
exec_configure:
	$(CONFIGURE) $(CONFOPT)
	$(TOUCH)

compile: configure exec_compile
exec_compile:
	$(COMPILE)
	$(TOUCH)

stage: compile exec_stage
exec_stage: stg/share/doc/$(PKG)/$(MPKGVER)
	$(STAGE)
	if test "$(COPY_BIN_TO_HOST)" = 'y' \
	  -o "$(COPY_BIN_TO_HOST)" = 'yes'; then \
	  $(INSTALL_DIR) stg/$(HOST)/bin ; \
	  $(CPALL) stg/bin/* stg/$(HOST)/bin ; \
	  $(RMF) stg/$(HOST)/bin/*.dll ; \
	  $(RMF) stg/$(HOST)/bin/$(HOST)-*  ; \
	fi
	if test "$(COPY_LIB_TO_HOST)" = 'y' \
	  -o "$(COPY_LIB_TO_HOST)" = 'yes'; then \
	  if test -d stg/include; then \
	    $(INSTALL_DIR) stg/$(HOST)/include ; \
	    $(CPALL) stg/include/* stg/$(HOST)/include/ ; \
	  fi ; \
	  if test -d stg/lib; then \
	    $(INSTALL_DIR) stg/$(HOST)/lib ; \
	    $(CPALL) stg/lib/* stg/$(HOST)/lib/ ; \
	    $(RMF) stg/lib/*.la ; \
	  fi ; \
	  if test -d stg/libexec; then \
	    $(INSTALL_DIR) stg/$(HOST)/libexec ; \
	    $(CPALL) stg/libexec/* stg/$(HOST)/libexec/ ; \
	  fi ; \
	fi
	$(TOUCH)
stg/$(DOCDIR): \
  stg/$(DOCDIR)/README.$(MPKG) \
  $(addprefix stg/$(DOCDIR)/, $(foreach f,$(addsuffix _DOC_FILES,$(MPKGPART)), $(value $(subst ++,pp,$f)))) \
  $(addprefix stg/$(LICDIR)/, $(foreach f,$(addsuffix _LIC_FILES,$(MPKGPART)), $(value $(subst ++,pp,$f))))

stg/$(DOCDIR)/README.$(MPKG): README.$(MPKG)
	$(INSTALL_DIR) $(@D)
	$(INSTALL_DATA) $? $@

$(addprefix stg/$(DOCDIR)/, $(foreach f,$(addsuffix _DOC_FILES,$(MPKGPART)), $(value $(subst ++,pp,$f)))): 
	$(eval DFILE=$(subst stg/$(DOCDIR)/,,$@))
	$(INSTALL_DIR) $(@D)
	$(CPALL) $(PACKAGE)/$(DFILE) $(@D)

$(addprefix stg/$(LICDIR)/, $(foreach f,$(addsuffix _LIC_FILES,$(MPKGPART)), $(value $(subst ++,pp,$f)))): 
	$(eval DFILE=$(subst stg/$(LICDIR)/,,$@))
	$(INSTALL_DIR) $(@D)
	$(CPALL) $(PACKAGE)/$(DFILE) $(@D)

post_stage: stage exec_post_stage
exec_post_stage:
	$(FIND) stg/lib -name \*.dll -exec $(MVF) {} stg/bin/ \;
	$(STRIP) stg/bin/*.exe stg/bin/*.dll
	$(CPALL) stg/bin/gcc.exe stg/bin/cc.exe
	for F in stg/bin/gnat*.exe; do \
	  B=`basename $$F` ; \
	  $(CPALL) $$F stg/bin/$(HOST)-$$B ; \
	done
	$(CPALL) stg/bin/gcc.exe stg/bin/$(HOST)-cc.exe
	if test $(COPY_BIN_TO_HOST) = 'y' -o $(COPY_BIN_TO_HOST) = 'yes'; then \
	  $(CPALL) stg/bin/cc.exe stg/$(HOST)/bin ; \
	fi
	$(STRIP) stg/libexec/$(PKG)/$(HOST)/$(PKGVER)/*.exe
	$(STRIP) -g stg/lib/$(PKG)/$(HOST)/$(PKGVER)/*.a
	$(STRIP) -g stg/lib/$(PKG)/$(HOST)/$(PKGVER)/debug/*.a
	if test $(COPY_LIB_TO_HOST) = 'y' -o $(COPY_LIB_TO_HOST) = 'yes'; then \
	  $(STRIP) stg/$(HOST)/libexec/$(PKG)/$(HOST)/$(PKGVER)/*.exe ; \
	  $(STRIP) -g stg/$(HOST)/lib/$(PKG)/$(HOST)/$(PKGVER)/*.a ; \
	  $(STRIP) -g stg/$(HOST)/lib/$(PKG)/$(HOST)/$(PKGVER)/debug/*.a ; \
	fi
	$(TOUCH)

package: post_stage exec_package
exec_package: rls rls/$(MPKGSRC) \
  $(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-bin.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))) \
  $(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-dll.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))) \
  $(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-dev.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))) \
  $(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-lic.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))) \
  $(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-doc.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))) \
  $(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-info.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))) \
  $(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-man.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))) \
  rls/$(MPKGLANG) rls/README.$(MPKG)
	$(TOUCH)

rls:
	$(RMFR) rls
	$(INSTALL_DIR) $@

rls/$(MPKGSRC): $(PKGFILE) Makefile package.ini README.makefile README.$(MPKG) $(MPATCHES)
	$(RMPKG)
	$(INSTALL_DIR) pkg/$(MPKG)
	for F in $^; do \
	  $(INSTALL_DATA) $$F pkg/$(MPKG)/ ; \
	done
	$(MKPKGFILE)

$(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-dll.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))): $(addprefix exec_dll_, $(MPKGPART))
$(addprefix exec_dll_, $(MPKGPART)):
	$(RMPKG)
	$(eval RAWPART = $(subst exec_dll_,,$@))
	$(eval PART = $(subst ++,pp,$(RAWPART)))
	@echo $@
	$(eval MPKGFILE = rls/$(PKG)-$(RAWPART)-$(MPKGVER)-$(MPKGRLS)-$(MPKGRT)-dll.$(MPKGEXT))
	$(if $($(PART)_DLL_FILES), \
	  $(INSTALL_DIR) pkg/bin ; \
	  for F in $($(PART)_DLL_FILES); do \
	    $(CPALL) stg/bin/$$F pkg/bin/ ; \
	  done ; \
	)
	$(MKPKGPARTFILE)
	$(TOUCH)

$(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-bin.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))): $(addprefix exec_bin_, $(MPKGPART))
$(addprefix exec_bin_, $(MPKGPART)):
	$(RMPKG)
	$(eval RAWPART = $(subst exec_bin_,,$@))
	$(eval PART = $(subst ++,pp,$(RAWPART)))
	@echo $@
	$(eval MPKGFILE = rls/$(PKG)-$(RAWPART)-$(MPKGVER)-$(MPKGRLS)-$(MPKGRT)-bin.$(MPKGEXT))
	$(if $($(PART)_BIN_FILES), \
	  $(INSTALL_DIR) pkg/bin ; \
	  for F in $($(PART)_BIN_FILES); do \
	    $(CPALL) stg/bin/$$F pkg/bin/ ; \
	  done ; \
	)
	if test -e pkg; then \
	  $(MKPKGPARTFILE) ; \
	fi
	$(TOUCH)

$(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-dev.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))): $(addprefix exec_dev_, $(MPKGPART))
$(addprefix exec_dev_, $(MPKGPART)):
	$(RMPKG)
	$(eval RAWPART = $(subst exec_dev_,,$@))
	$(eval PART = $(subst ++,pp,$(RAWPART)))
	@echo $@
	$(eval MPKGFILE = rls/$(PKG)-$(RAWPART)-$(MPKGVER)-$(MPKGRLS)-$(MPKGRT)-dev.$(MPKGEXT))
	$(if $($(PART)_LIB_FILES), \
	  $(INSTALL_DIR) pkg/lib/$(PKG)/$(HOST)/$(PKGVER) ; \
	  if test "$(COPY_LIB_TO_HOST)" = "y" \
	    -o "$(COPY_LIB_TO_HOST)" = "yes"; then \
	    $(INSTALL_DIR) pkg/$(HOST)/lib/$(PKG)/$(HOST)/$(PKGVER) ; \
	  fi ; \
	  for F in $($(PART)_LIB_FILES); do \
	    D=`dirname $$F` ; \
	    $(INSTALL_DIR) pkg/lib/$(PKG)/$(HOST)/$(PKGVER)/$$D ; \
	    $(CPALL) stg/lib/$(PKG)/$(HOST)/$(PKGVER)/$$F pkg/lib/$(PKG)/$(HOST)/$(PKGVER)/$$D/; \
	    if test -e pkg/$(HOST); then \
	      $(INSTALL_DIR) pkg/$(HOST)/lib/$(PKG)/$(HOST)/$(PKGVER)/$$D ; \
	      $(CPALL) stg/$(HOST)/lib/$(PKG)/$(HOST)/$(PKGVER)/$$F pkg/$(HOST)/lib/$(PKG)/$(HOST)/$(PKGVER)/$$D/; \
	    fi ; \
	  done ;\
	)
	$(if $($(PART)_LIB_EXCLUDE_FILES), \
	  for F in $($(PART)_LIB_EXCLUDE_FILES); do \
	    $(RMFR) pkg/lib/$(PKG)/$(HOST)/$(PKGVER)/$$F; \
	  done; \
	)
	$(if $($(PART)_LIBEXEC_FILES), \
	  $(INSTALL_DIR) pkg/libexec/$(PKG)/$(HOST)/$(PKGVER) ; \
	  if test "$(COPY_LIB_TO_HOST)" = "y" \
	    -o "$(COPY_LIB_TO_HOST)" = "yes"; then \
	    $(INSTALL_DIR) pkg/$(HOST)/libexec/$(PKG)/$(HOST)/$(PKGVER) ; \
	  fi ; \
	  for F in $($(PART)_LIBEXEC_FILES); do \
	    $(CPALL) stg/libexec/$(PKG)/$(HOST)/$(PKGVER)/$$F pkg/libexec/$(PKG)/$(HOST)/$(PKGVER)/; \
	    if test -e pkg/$(HOST); then \
	      $(CPALL) stg/$(HOST)/libexec/$(PKG)/$(HOST)/$(PKGVER)/$$F pkg/$(HOST)/libexec/$(PKG)/$(HOST)/$(PKGVER)/; \
	    fi ; \
	  done ;\
	)
	$(if $($(PART)_SHARE_FILES), \
	  $(INSTALL_DIR) pkg/share/$(PACKAGE) ; \
	  for F in $($(PART)_SHARE_FILES); do \
	    $(CPALL) stg/share/$(PACKAGE)/$$F pkg/share/$(PACKAGE)/; \
	  done ;\
	)
	if test -e pkg; then \
	  $(MKPKGPARTFILE) ; \
	fi
	$(TOUCH)

$(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-lic.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))): $(addprefix exec_lic_, $(MPKGPART))
$(addprefix exec_lic_, $(MPKGPART)):
	$(RMPKG)
	$(eval RAWPART = $(subst exec_lic_,,$@))
	$(eval PART = $(subst ++,pp,$(RAWPART)))
	@echo $@
	$(eval MPKGFILE = rls/$(PKG)-$(RAWPART)-$(MPKGVER)-$(MPKGRLS)-$(MPKGRT)-lic.$(MPKGEXT))
	$(if $(value $(PART)_LIC_FILES), \
	  $(INSTALL_DIR) pkg/bin ; \
	  for F in $($(PART)_LIC_FILES); do \
	    D=`dirname $$F` ; \
	    $(INSTALL_DIR) pkg/$(LICDIR)/$$D ; \
	    $(INSTALL_DATA) stg/$(LICDIR)/$$F pkg/$(LICDIR)/$$D ; \
	  done ; \
	)
	if test -e pkg; then \
	  $(MKPKGPARTFILE) ; \
	fi
	$(TOUCH)

$(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-doc.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))): $(addprefix exec_doc_, $(MPKGPART))
$(addprefix exec_doc_, $(MPKGPART)):
	$(RMPKG)
	$(eval RAWPART = $(subst exec_doc_,,$@))
	$(eval PART = $(subst ++,pp,$(RAWPART)))
	@echo $@
	$(eval MPKGFILE = rls/$(PKG)-$(RAWPART)-$(MPKGVER)-$(MPKGRLS)-$(MPKGRT)-doc.$(MPKGEXT))
	$(if $(value $(PART)_DOC_FILES), \
	  $(INSTALL_DIR) pkg/bin ; \
	  for F in $($(PART)_DOC_FILES); do \
	    D=`dirname $$F` ; \
	    $(INSTALL_DIR) pkg/$(DOCDIR)/$$D ; \
	    $(INSTALL_DATA) stg/$(DOCDIR)/$$F pkg/$(DOCDIR)/$$D ; \
	  done ; \
	)
	if test -e pkg; then \
	  $(MKPKGPARTFILE) ; \
	fi
	$(TOUCH)

$(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-info.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))): $(addprefix exec_info_, $(MPKGPART))
$(addprefix exec_info_, $(MPKGPART)):
	$(RMPKG)
	$(eval RAWPART = $(subst exec_info_,,$@))
	$(eval PART = $(subst ++,pp,$(RAWPART)))
	@echo $@
	$(eval MPKGFILE = rls/$(PKG)-$(RAWPART)-$(MPKGVER)-$(MPKGRLS)-$(MPKGRT)-info.$(MPKGEXT))
	$(if $(value $(PART)_INFO_FILES), \
	  $(INSTALL_DIR) pkg/$(INFODIR) ; \
	  for F in $($(PART)_INFO_FILES); do \
	    D=`dirname $$F` ; \
	    $(INSTALL_DIR) pkg/$(INFODIR)/$$D ; \
	    $(INSTALL_DATA) stg/$(INFODIR)/$$F pkg/$(INFODIR)/$$D ; \
	  done ; \
	)
	if test -e pkg; then \
	  $(MKPKGPARTFILE) ; \
	fi
	$(TOUCH)

$(addsuffix -$(PKGVER)-$(MPKGRLS)-$(MPKGRT)-man.$(MPKGEXT), $(addprefix rls/$(PKG)-, $(MPKGPART))): $(addprefix exec_man_, $(MPKGPART))
$(addprefix exec_man_, $(MPKGPART)):
	$(RMPKG)
	$(eval RAWPART = $(subst exec_man_,,$@))
	$(eval PART = $(subst ++,pp,$(RAWPART)))
	@echo $@
	$(eval MPKGFILE = rls/$(PKG)-$(RAWPART)-$(MPKGVER)-$(MPKGRLS)-$(MPKGRT)-man.$(MPKGEXT))
	$(if $(value $(PART)_MAN_FILES), \
	  $(INSTALL_DIR) pkg/$(MANDIR) ; \
	  for F in $($(PART)_MAN_FILES); do \
	    D=`dirname $$F` ; \
	    $(INSTALL_DIR) pkg/$(MANDIR)/$$D ; \
	    $(INSTALL_DATA) stg/$(MANDIR)/$$F pkg/$(MANDIR)/$$D ; \
	  done ; \
	)
	if test -e pkg; then \
	  $(MKPKGPARTFILE) ; \
	fi
	$(TOUCH)

rls/$(MPKGLANG):
	if test -d stg/$(LOCALEDIR); then \
	  $(RMPKG) ; \
	  $(INSTALL_DIR) pkg/$(LOCALEDIR) ; \
	  $(CPALL) stg/$(LOCALEDIR)/* pkg/$(LOCALEDIR)/ ; \
	  $(MKPKGFILE) ; \
	fi

rls/README.$(MPKG):
	$(INSTALL_DATA) README.$(MPKG) rls/

clean: 
	$(RMFR) $(PACKAGE)
	$(RMFR) stg
	$(RMFR) rls
	$(RMFR) pkg
	$(RMFR) bld
	$(RMFR) part
	$(RMF) exec_*
	$(RMF) *.log

check: compile exec_check
exec_check:
	cd bld ; \
	make -k -j1 check 2>&1 | tee ../check.log
	$(TOUCH)

install: compile post_stage
	$(INSTALL_DIR) $(PREFIX)
	$(CPALL) stg/* $(PREFIX)/

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

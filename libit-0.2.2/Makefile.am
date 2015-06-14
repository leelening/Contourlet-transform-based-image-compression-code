## Makefile.am for the it library
# Some stuff taken from SDL

# require automake 1.4
AUTOMAKE_OPTIONS = 1.4

# These are the subdirectories that are always built
SUBDIRS = doc src include

bin_SCRIPTS = libit-config

EXTRA_DIST =		 \
	AUTHORS		 \
	COPYING		 \
	ChangeLog	 \
	README	 	 \
	INSTALL          \
	autogen.sh       \
	libit-config     \
	libit-config.in  \
	libit.m4.in      \
	libit.m4         \
	libit.spec.in    \
	libit.spec

# M4 macro file for inclusion with autoconf
m4datadir = $(datadir)/aclocal
m4data_DATA = libit.m4

# Rule to build tar-gzipped distribution package
$(PACKAGE)-$(VERSION).tar.gz: dist

# Rule to build Redhat distribution package
rpm: $(PACKAGE)-$(VERSION).tar.gz
	rpm -ta $(PACKAGE)-$(VERSION).tar.gz

# Rule to build Debian distribution package
deb:
	dpkg-buildpackage -rfakeroot -us -uc

# Run ldconfig after installing the library:
install-hook:
	-ldconfig

# Grab the test programs, debian package and Visual C project files for the distribution:
dist-hook:
	if test -f examples/make-all.sh; then (cd examples; ./make-all.sh clean); fi
	rm -rf $(srcdir)/examples/autom4te*
	cp -rp $(srcdir)/examples $(distdir)
	cp -rp $(srcdir)/debian $(distdir)
	cp -rp $(srcdir)/VC $(distdir)
	rm -rf `find $(distdir) -type d -name CVS -print`


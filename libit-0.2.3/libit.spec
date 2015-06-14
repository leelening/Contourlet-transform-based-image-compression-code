# Note that this is NOT a relocatable package
%define ver      0.2.3
%define rel      1
%define prefix   /usr

Summary:   Information Theory Library
Name:      libit
Version:   %ver
Release:   %rel
Copyright: LGPL
Group:     System Environment/Libraries
Source0:   libit-%{PACKAGE_VERSION}.tar.gz
BuildRoot: /tmp/libit-%{PACKAGE_VERSION}-root
Packager:  Herve Jegou <herve.jegou@irisa.fr>
Docdir: %{prefix}/doc

%description
libit provides easy to use yet efficient tools related to information theory and signal processing. It includes basic vector, matrix and function types, some common source and channel coding tools such as quantization, entropy coding, etc...

%package devel
Summary: Information Theory Library Development Files
Group: Development/Libraries
Requires: %{name}

%description devel
libit provides easy to use yet efficient tools related to information theory and signal processing. It includes basic vector, matrix and function types, some common source and channel coding tools such as quantization, entropy coding, etc... This packages add the necessary include files needed for developping applications using the library.


%prep
rm -rf ${RPM_BUILD_ROOT}

%setup -q

%build
# Needed for snapshot releases.
if [ ! -f configure ]; then
  CFLAGS="$RPM_OPT_FLAGS" ./autogen.sh --prefix=%prefix
else
  CFLAGS="$RPM_OPT_FLAGS" ./configure --prefix=%prefix
fi

if [ "$SMP" != "" ]; then
  (make "MAKE=make -k -j $SMP"; exit 0)
  make
else
  make
fi

%install
rm -rf $RPM_BUILD_ROOT

make prefix=$RPM_BUILD_ROOT%{prefix} install

%clean
rm -rf $RPM_BUILD_ROOT

%post
/sbin/ldconfig

%postun
/sbin/ldconfig

%files
%defattr(-, root, root)
%doc ChangeLog COPYING README
%{prefix}/lib/*
%{prefix}/man/*

%files devel
%defattr(-, root, root)
%doc ChangeLog COPYING README
%{prefix}/bin/libit-config
%{prefix}/include/*
%{prefix}/lib/*
%{prefix}/doc/*
%{prefix}/share/aclocal/libit.m4
%{prefix}/man/man3/*

%changelog


## Makefile.am for the it library documentation
# This is partially taken from the Linux kernel Documentation

# The directory where to install the documentation
docdir = ${prefix}/doc/$(PACKAGE)

# Include these in the distribution
EXTRA_DIST = *.sgml libit.pdf libit.ps

# What files we depend on
BOOKS = libit.tex intro.tex vecmat.tex io.tex measure.tex objects.tex source.tex channel.tex signal.tex manpages.sgml


# The tools for building the documentation
SGMLTOOLS = jw
TEX=latex
DVIPS=dvips
CONVERT=convert
MV=mv

book: libit.pdf libit.ps

libit.ps: $(BOOKS) 
	latex libit.tex
	dvips -o libit.ps libit.dvi

libit.pdf: $(BOOKS) 
	pdflatex libit.tex

man: $(BOOKS)
	$(SGMLTOOLS) -d libit.dsl\#print -o man3 -b man libit.sgml

html: $(BOOKS)
	$(SGMLTOOLS) -d libit.dsl\#html -o html -b html libit.sgml


eq-%.dvi: eq-%.tex
	$(TEX) $< -o $<

eq-%.eps: eq-%.dvi
	$(DVIPS) -E $< -o $@

eq-%.pdf: eq-%.eps
	$(EPSTOPDF) $<

eq-%.png: eq-%.eps
	$(CONVERT) -density 150 $< $@
# this is actually needed in the html directory
	$(MV) $@ html/

# Install the HTML pages in the documentation directory
install-data-hook:
	$(mkinstalldirs) $(docdir) $(mandir)/man3
	$(INSTALL) html/*.html html/*.png $(docdir)
	$(INSTALL) man3/*.3 $(mandir)/man3

###
# Temporary files left by various tools
dist-clean:
	$(RM) *.dvi *.aux *.tex *.log *.out *.ps *.pdf *.html *.3
	$(RM) -r html

# Grab the HTML manual for the distribution:
dist-hook:
	cp -rp html $(distdir)
	cp -rp man3 $(distdir)




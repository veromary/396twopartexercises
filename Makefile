SHELL=/bin/sh
FILE=main
OUTDIR=out
WEBDIR=htmlout
VIEWER=xpdf
BROWSER=firefox
LILYBOOK_PDF=lilypond-book --output=$(OUTDIR) --pdf $(FILE).lytex
LILYBOOK_HTML=lilypond-book --output=$(WEBDIR) $(FILE).lytex
PDF=cd $(OUTDIR) && pdflatex $(FILE)
HTML=cd $(WEBDIR) && latex2html $(FILE)
PREVIEW=$(VIEWER) $(OUTDIR)/$(FILE).pdf &

all: pdf web keep

pdf:
	$(LILYBOOK_PDF)  # begin with tab
	$(PDF)           # begin with tab
	$(PDF)           # begin with tab
	$(PREVIEW)       # begin with tab

web:
	$(LILYBOOK_HTML) # begin with tab
	$(HTML)          # begin with tab
	cp -R $(WEBDIR)/$(FILE)/ ./  # begin with tab
	$(BROWSER) $(FILE)/$(FILE).html &  # begin with tab

keep: pdf
	cp $(OUTDIR)/$(FILE).pdf $(FILE).pdf  # begin with tab

clean:
	rm -rf $(OUTDIR) # begin with tab

web-clean:
	rm -rf $(WEBDIR) # begin with tab

archive:
	tar -cvvf myproject.tar \ # begin this line with tab
	--exclude=out/* \
	--exclude=htmlout/* \
	--exclude=myproject/* \
	--exclude=*midi \
	--exclude=*pdf \
	--exclude=*~ \
	../396twopartexercises/*

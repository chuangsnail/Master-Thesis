# vim: set ts=8 noet:
# Specify variables by make VARNAME=val
UNAME_S := $(shell uname -s)
LATEX ?= xelatex
BIB ?= bibtex

MAIN ?= main
WORKSPACE ?= `pwd`

ifeq ($(UNAME_S),Linux)
    OPEN ?= evince
endif
ifeq ($(UNAME_S),Darwin)
    OPEN ?= open
endif


all: pdf open clean

pdf: ${MAIN}.tex
	${LATEX} ${MAIN}.tex
	${BIB}   ${MAIN}.aux
	${LATEX} ${MAIN}.tex

pdftk: ${MAIN}.pdf
	pdftk ${MAIN}.pdf output secu-${MAIN}.pdf owner_pw foo allow printing

open: ${MAIN}.pdf
	${OPEN} ${MAIN}.pdf &

.PHONY: clean
clean:
	/bin/rm -f *.dvi *.ps *.bbl *.blg *.lof *.lot *.aux *.toc

# Follow install tutorial in official site. After install...
# TEXHOME="/usr/local/texlive/2014"
# export PATH="${TEXHOME}/bin/x86_64-linux:$PATH"
# export MANPATH="${TEXHOME}/texmf/doc/man:$MANPATH"
# export INFOPATH="/{TEXHOME}/texmf/doc/info:$INFOPATH"

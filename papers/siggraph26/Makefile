TEX := latexmk
TEXFLAGS := -pdf -halt-on-error -interaction=nonstopmode

.PHONY: all build clean distclean

all: build

build:
	$(TEX) $(TEXFLAGS) main.tex

clean:
	$(TEX) -c

distclean: clean
	$(TEX) -C

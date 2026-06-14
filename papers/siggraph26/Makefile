TEX := latexmk
TEXFLAGS := -pdf -halt-on-error -interaction=nonstopmode

.PHONY: all build submit clean distclean

all: build

build:
	$(TEX) $(TEXFLAGS) main.tex

submit: build
	rm -rf siggraphfrontiers26-1 siggraphfrontiers26-1.zip
	mkdir siggraphfrontiers26-1 siggraphfrontiers26-1/pdf siggraphfrontiers26-1/Source
	cp -p main.pdf siggraphfrontiers26-1/pdf/paper.pdf
	cp -p *.tex siggraphfrontiers26-1/Source/
	zip -r siggraphfrontiers26-1.zip siggraphfrontiers26-1 -x '*/.DS_Store'

clean:
	$(TEX) -c

distclean: clean
	$(TEX) -C

.PHONY: all
all: unix_news_july-30-1975_page1.png unix_news_july-30-1975_newell.png \
	newell_teapot_drawing.jpg

unix_news_july-30-1975_waterloo.pdf:
	wget https://archive.org/download/unix_news_july-30-1975_waterloo/unix_news_july-30-1975_waterloo.pdf

# Extract page 1 and remove handwritten note added by Waterloo recipient
unix_news_july-30-1975_page1.png: unix_news_july-30-1975_waterloo.pdf
	pdfimages -f 1 -l 1 unix_news_july-30-1975_waterloo.pdf unix_news_july-30-1975
	magick unix_news_july-30-1975-0000.pbm \
		-rotate -90 \
		-fill white -draw 'rectangle 638,0 1340,53' \
		-strip \
		unix_news_july-30-1975_page1.png
	optipng -o3 unix_news_july-30-1975_page1.png
	rm unix_news_july-30-1975-0000.pbm

# Extract Martin Newell entry and cover a splotch
unix_news_july-30-1975_newell.png: unix_news_july-30-1975_waterloo.pdf
	pdfimages -f 10 -l 10 unix_news_july-30-1975_waterloo.pdf unix_news_july-30-1975
	magick unix_news_july-30-1975-0000.pbm \
		-rotate -90 \
		-crop 710x200+0+738 \
		-fill white -draw 'rectangle 343,5 349,11' \
		-strip \
		unix_news_july-30-1975_newell.png
	optipng -o3 unix_news_july-30-1975_newell.png
	rm unix_news_july-30-1975-0000.pbm

102695462-03-01-src.tif:
	wget https://archive.org/download/newell_teapot_drawing/102695462-03-01-src.tif

# Crop scanner bed border, resize, and compress
# https://stackoverflow.com/questions/7261855/best-options-parameters-for-imagemagick-to-compress-jpegs-files-to-the-minimal-s/44208640#44208640
newell_teapot_drawing.jpg: 102695462-03-01-src.tif
	magick 102695462-03-01-src.tif \
		-crop 2534x3264+12+0 \
		-resize 1000 \
		-sampling-factor 4:2:0 -quality 85 -interlace JPEG \
		-strip \
		newell_teapot_drawing.jpg

.PHONY: clean
clean:
	rm -f *.png *.pbm *.jpg

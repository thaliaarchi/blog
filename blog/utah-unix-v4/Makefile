.PHONY: all
all: unix_news_july-30-1975_page1.png unix_news_july-30-1975_newell.png \
	newell_teapot_drawing.jpg distribution_contents_1974.png

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

manitoba_unix_license_1975.pdf:
	wget -O manitoba_unix_license_1975.pdf https://archive.org/download/manitoba_unix_license_1975/1_manitoba_software_agreement_1975-02-01.pdf

# The definitions appendix page was exactly identical between Nijmegen (1974-12-01)
# and Manitoba (1975-02-01), and near-identical to UC Regents (1974-12-01),
# except for wrapping and the page head and foot. Choose Manitoba as it looks
# the best.
distribution_contents_1974.png: manitoba_unix_license_1975.pdf
	pdfimages -f 7 -l 7 manitoba_unix_license_1975.pdf manitoba_unix_license_1975
	magick manitoba_unix_license_1975-0000.pbm \
		-rotate -90 \
		-strip \
		distribution_contents_1974.png
	optipng -o3 distribution_contents_1974.png
	rm manitoba_unix_license_1975-0000.pbm

.PHONY: clean
clean:
	rm -f *.png *.pbm *.jpg

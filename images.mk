# Convert images
#
# Targets generated by this Makefile are committed to Git LFS. This is due to
# image conversion tools not being available in the readthedocs.org build
# environment.

image_dir = source/_static/images

targets := $(image_dir)/cc-by-4.0.pdf \
$(image_dir)/nissan-leaf-diagnostic-connector.jpeg

cc_by_4 = "This work is licensed under a Creative Commons Attribution 4.0 \
International License https://creativecommons.org/licenses/by/4.0/"

.PHONY: all
all: $(targets)

$(image_dir)/cc-by-4.0.pdf : $(image_dir)/cc-by-4.0.eps
	ghostscript -dEPSCrop -sDEVICE=pdfwrite -o $@ $<

$(image_dir)/nissan-leaf-diagnostic-connector.jpeg : $(image_dir)/nissan-leaf-diagnostic-connector-high-quality.jpeg
	convert -strip -interlace Plane -gaussian-blur 0.05 -quality 75% $< $@
	exiftool \
	-overwrite_original \
	-Artist="Seth Fischer" \
	-AttributionName="Seth Fischer" \
	-AttributionURL="https://seth.fischer.nz/" \
	-DateTimeOriginal="2020:09:27 17:43:49" \
	-Description="2013 Nissan Leaf diagnostic connector" \
	-License="https://creativecommons.org/licenses/by/4.0/" \
	-Rights=$(cc_by_4) \
	-UsageTerms=$(cc_by_4) \
	$@

.PHONY : clean
clean :
	-rm $(targets)
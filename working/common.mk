# This make include file depends on the following being set.
#
# ORIG_PDF_FILE - The path to the original pdf file.
# NAME - The name, something like technician-2026-2030.
# IMAGES - The image file names that we are extracting from the pdf.
# IMAGE_PREFIX - Prefix for the extracted image files, t, g, or e.


INSTALL_DIR:= ../../$(NAME)

CSV:=$(NAME).csv
YAML:=$(NAME).yaml
JSON:=$(NAME).json
PLAIN:=$(NAME).txt

QUESTIONS:= $(CSV) $(YAML) $(JSON) $(PLAIN)
RESULTS:=$(QUESTIONS) $(IMAGES)

BIN_DIR=../bin


default: build

build: $(QUESTIONS) $(IMAGES)

# Copy the original pdf file, with the long name to raw.pdf
#
raw.pdf:
	cp "$(ORIG_PDF_FILE)" raw.pdf

# Extract the text from the pdf file into raw.txt. Note that
# this is not the same as the file txt file, since raw.txt contains
# a lot of explanation, not just questions. The post process target
# provides a hook for any editing of the raw.txt file that might be
# needed.

raw.txt: extract_raw_txt post_process_raw_txt

extract_raw_txt: raw.pdf 
	python $(BIN_DIR)/extract_text.py raw.pdf raw.txt

post_process_raw_txt:

# Pull the images out of the pdf file.
extract_images: raw.pdf
	python $(BIN_DIR)/extract_images.py raw.pdf $(IMAGE_PREFIX)

# If the image files have fancy names, we might need rename the
# image files.

rename_images:

$(IMAGES): extract_images rename_images

images: $(IMAGES)

# Create the csv, yaml, json and txt files.
$(QUESTIONS): raw.txt
	python $(BIN_DIR)/convert_questions.py raw.txt $(NAME)

# Run some basic checks on the resulting files.
#
check: build run_check

run_check:
	python $(BIN_DIR)/check_questions.py $(NAME)

# Copy the generated files to their final home.
install: build
	mkdir -pv  $(INSTALL_DIR)
	cp $(RESULTS) $(INSTALL_DIR)

# Clean the local files.

clean::
	rm -f $(RESULTS) raw.txt raw.pdf

# Clean the installed files as well as the remote ones.

real_clean:: clean
	rm -rf $(INSTALL_DIR)






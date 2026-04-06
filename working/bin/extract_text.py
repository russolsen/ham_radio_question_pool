# Extract images from a pdf file.
# Needs a couple of python packages:
#
# pip install pypdf
# pip install  pypdf[image]

from pypdf import PdfReader
import sys

print(sys.argv[1])
reader = PdfReader(sys.argv[1])

text_path = sys.argv[2]
text_f = open(text_path, "w")

n = 0

for page in reader.pages:
    n += 1
    text_f.write(page.extract_text())
    text_f.write("\n")

# Extract images from a pdf file.
# Needs a couple of python packages:
#
# pip install pypdf
# pip install  pypdf[image]

from pypdf import PdfReader
import sys

print(sys.argv[1])
reader = PdfReader(sys.argv[1])

prefix = sys.argv[2]
print(f"Prefix: {prefix}")
n = 1

for page in reader.pages:
    for count, image_file_object in enumerate(page.images):
        fname = f'{prefix}-{n}.png'
        print(f"Writing image {fname}.")
        with open(fname, "wb") as fp:
            fp.write(image_file_object.data)
        n += 1

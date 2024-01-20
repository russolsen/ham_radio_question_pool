import pypandoc
import os
import sys

input_path = sys.argv[1]        # Should be the docx file
output_path = sys.argv[2]

output = pypandoc.convert_file(input_path, 'plain', outputfile='temp.txt')
assert output == ''

with open('temp.txt', 'r') as outfile:
    #fixed = outfile.read().replace('\n\n', '\n').replace('~~', '')
    fixed = outfile.read()
    with open(output_path, 'w') as output:
        output.write(fixed)

os.remove('temp.txt')

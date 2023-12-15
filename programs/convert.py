import pypandoc
import os

# Example file:
docxFilename = 'General Class Pool and Syllabus 2023-2027 Public Release with Errata Feb 1 2023.docx'
output = pypandoc.convert_file(docxFilename, 'plain', outputfile='temp.txt')
assert output == ''

with open('temp.txt', 'r') as outfile:
    fixed = outfile.read().replace('\n\n', '\n').replace('~~', '')
    with open('general.txt', 'w') as output:
        output.write(fixed)

os.remove('temp.txt')

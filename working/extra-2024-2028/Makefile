ORIG_PDF_FILE:=2024-2028 Extra Class Question Pool and Syllabus Public Release with 4th Errata Feb 4 2026.pdf
NAME:=extra-2024-2028
IMAGES= e5-1.png e6-1.png e6-2.png e6-3.png e7-1.png e7-2.png e7-3.png e9-1.png e9-2.png e9-3.png

IMAGE_PREFIX=e
-include ../common.mk

post_process_raw_txt:
	sed -i .bak '1,225d' raw.txt


rename_images:
	mv e-1.png  e5-1.png
	mv e-2.png  e6-1.png
	mv e-3.png  e6-2.png
	mv e-4.png  e6-3.png
	mv e-5.png  e7-1.png
	mv e-6.png  e7-2.png
	mv e-7.png  e7-3.png
	mv e-8.png  e9-1.png
	mv e-9.png  e9-2.png
	mv e-10.png e9-3.png
	
clean::
	rm -f raw.txt.bak


default: init technician general extra


EXTRA_SRC = originals/2024-2028\ Extra\ Class\ Question\ Pool\ and\ Syllabus\ Public\ Release\ December\ 7\ 2023.docx

extra: $(EXTRA_SRC)
	python3 programs/convert.py "$<"  working/original_extra.txt
	ruby programs/process.rb working/original_extra.txt working/extra



GEN_SRC = originals/General\ Class\ Pool\ and\ Syllabus\ 2023-2027\ Public\ Release\ with\ 3rd\ Errata\ December\ 1\ 2023.docx

general: $(GEN_SRC)
	python3 programs/convert.py "$<"  working/original_general.txt
	ruby programs/process.rb working/original_general.txt working/general

TECH_SRC = originals/Technician\ Pool\ and\ Syllabus\ 2022-2026\ Public\ Release\ Errata\ March\ 7\ 2022.docx

technician: $(TECH_SRC)
	python3 programs/convert.py "$<"  working/original_technician.txt
	ruby programs/process.rb working/original_technician.txt working/technician

install_tech: technician
	cp working/technician.*  technician-2022-2026

install_gen: general
	cp working/general.*  general-2023-2027

install_extra: extra
	cp working/extra.*  extra-2024-2028

install: install_tech install_gen install_extra

init:
	mkdir -p working

clean:
	rm -f working


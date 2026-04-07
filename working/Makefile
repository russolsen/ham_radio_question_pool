SUBDIRS := technician-2026-2030 general-2023-2027 extra-2024-2028


default:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done

build:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir build; \
	done

check:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir check; \
	done

install:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir install; \
	done

clean:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done


real_clean:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir real_clean; \
	done



OCW_ZIP_DOMAIN = https://ocw.mit.edu/ans15436/ZipForEndUsers

default: apts

apts: notes/

notes/:
	for section in ${COURSE_SECTIONS}; do ${MAKE} tmp/$$section.txt; done


tmp/${COURSE}:
	mkdir -p $@


tmp/${COURSE}.zip: tmp/${COURSE}
	curl --output $@ \
		${OCW_ZIP_DOMAIN}/${COURSE_PREFIX}/${COURSE}/${COURSE}.zip
	tar xf $@ -C $<


tmp/%.txt: tmp/${COURSE}.zip
	cat tmp/${COURSE}/${COURSE}/contents/$(shell basename $* .txt)/index.htm \
	| pup "#course_inner_section" \
	| lynx -list_inline -dump -stdin \
	| makefiles/ocw.mit.edu/${COURSE}/$(shell basename $* .txt).sh


clean:
	rm -rf notes apts
	rm -rf tmp/{x*,notes,apts}

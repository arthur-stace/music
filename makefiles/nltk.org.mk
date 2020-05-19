PATTERN = 'Exercises'

tmp/%:
	@mkdir -p $@

apts: tmp/apts tmp/notes
	@curl https://www.nltk.org/book/ch00.html \
	| pup '#tab-course-plans td text{}' \
	| split -l 3
	@mv x* $</
	@sh makefiles/notes.sh $? > $@

clean:
	@rm -rf x*
	@rm -rf tmp/*
	@rm -rf notes apts

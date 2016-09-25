.PHONY: test

test:
	nikola build
	nikola serve --browser

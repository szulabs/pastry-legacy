dist:
	@echo '-> prune working directory'
	@mkdir -p dist
	@find dist '(' -name '*.whl' -o -name '*.tar.gz' ')' -delete
	@echo '-> build assets'
	@gulp
	@echo '-> build distribution package'
	@python setup.py sdist bdist_wheel
.PHONY: dist

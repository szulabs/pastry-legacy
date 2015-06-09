dist:
	@echo '-> prune working directory'
	@mkdir -p dist
	@find dist '(' -name '*.whl' -o -name '*.tar.gz' ')' -delete
	@echo '-> build assets'
	@gulp
	@echo '-> build distribution package'
	@python setup.py sdist bdist_wheel
.PHONY: dist

compile-deps:
	@pip-compile requirements.in > requirements.txt
	@pip-compile requirements-dev.in > requirements-dev.txt
	@pip-compile requirements-testing.in > requirements-testing.txt
.PHONY: compile-deps

install-deps:
	@pip install -U pip setuptools wheel
	@pip install -r requirements.txt
	@pip install -r requirements-dev.txt
	@pip install -r requirements-testing.txt
.PHONY: install-deps

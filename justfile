version := `python3 -c "from configparser import ConfigParser; p = ConfigParser(); p.read('setup.cfg'); print(p['metadata']['version'])"`

clean:
	@find . | grep -E "(__pycache__|\.pyi|\.pyc|\.pyo$)" | xargs rm -rf
	@rm -rf src/*.egg-info/ build/ dist/ .tox/ myfoobar.build/ myfoobar.pyi myfoobar.cpython-39-x86_64-linux-gnu.so out/

format:
	isort .
	black .
	blacken-docs README.md

lint:
	black --check .
	flake8 .

publish: release

release:
	@if [ "$(git rev-parse --abbrev-ref HEAD)" != "main" ]; then exit 1; fi
	gh release create {{version}}

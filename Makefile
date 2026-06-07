# Copyright (c) 2026 Alexander Todorov <atodorov@otb.bg>
#
# Licensed under GNU Affero General Public License v3 or later (AGPLv3+)
# https://www.gnu.org/licenses/agpl-3.0.html


.PHONY: build-pkg
build-pkg:
	rm -rf dist/
	docker build --output type=local,dest=dist/ --target pkg-dist .
	ls -l dist/

.PHONY: upload-pkg
upload-pkg: build-pkg
	test -n "$(TWINE_USERNAME)" || exit 1
	test -n "$(TWINE_PASSWORD)" || exit 2
	twine upload dist/* --repository-url https://push.fury.io/kiwitcms

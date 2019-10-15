#!/usr/bin/env bash

set -e  # exit on errors

[ -f .travis/.env ] && source .travis/.env

if [ "${TRAVIS_TAG}" != "" ] && [ "${TRAVIS_REPO_SLUG}" == "hasadna/knesset-data-python" ] && [ "${TRAVIS_PYPI_USER}" != "" ] && [ "${TRAVIS_PYPI_PASS}" != "" ]; then
    echo "publishing tagged release to pypi"
    echo "${TRAVIS_TAG}" > VERSION.txt
    echo "__version__ = '${TRAVIS_TAG}'" >> knesset_data/__init__.py
    rm -rf dist build
    pip install twine
    ./setup.py bdist_wheel
    export TWINE_USERNAME="${TRAVIS_PYPI_USER}"
    export TWINE_PASSWORD="${TRAVIS_PYPI_PASS}"
    twine upload dist/*
else
    echo "skipping publishing to pypi because not a tagged release or not under hasadna repo"
fi

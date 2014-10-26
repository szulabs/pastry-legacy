# Pastry

[![Build Status](http://img.shields.io/travis/szulabs/pastry/master.svg?style=flat)](https://travis-ci.org/szulabs/pastry)

The official site of [szulabs](https://szulabs.org).

## Quick Start Guide

1. Install Python 3.4, pip and virtualenv. You may want to use [pyenv](pyenv) and [pyenv-virtualenv][pyenv-virtualenv] to archive it.
2. Install Node.js and PostgreSQL.
3. Install other tools:
  - [honcho][honcho]: `pip install https://github.com/nickstenning/honcho/archive/master.zip`
  - [gulp][gulp]: `npm install -g gulp`
4. Prepare the development environment:
  - Create a virtualenv: `pyenv install 3.4.1 && pyenv virtualenv 3.4.1 @pastry` or `virtualenv -p python3.4 ~/.venvs/pastry`
  - Activate the virtualenv: `pyenv activate @pastry` or `. ~/.venvs/pastry/bin/activate`
  - Install backend requirements: `pip install -r requirements.txt` and `pyenv rehash`
  - Install frontend requirements: `npm install`
  - Create a environment file from the example and modify it to match the local environment: `cp .env.example .env && vim .env`
5. Prepare the database:
  - Create a empty PostgreSQL database: `createdb pastry`
  - Make sure you are inside the correct virtualenv
  - Migrate to the latest schema: `honcho run ./manage.py migrate`
  - Create your administrator account: `honcho run ./manage.py createsuperuser`
6. Now `honcho start` and access `http://127.0.0.1:5000/` in your browser.

[pyenv]: https://github.com/yyuu/pyenv
[pyenv-virtualenv]: https://github.com/yyuu/pyenv-virtualenv
[honcho]: https://honcho.readthedocs.org
[gulp]: http://gulpjs.com

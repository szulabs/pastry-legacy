# Pastry

[![Build Status](https://img.shields.io/travis/szulabs/pastry/master.svg?style=flat)](https://travis-ci.org/szulabs/pastry)
[![Current Version](https://img.shields.io/github/release/szulabs/pastry.svg?style=flat)](https://github.com/szulabs/pastry/releases)

The official site of [szulabs](https://szulabs.org).

## Quick Start Guide

### The Global Environment

1. Install [pyenv][pyenv] and [pyenv-up][pyenv-up] by following the guides.
2. Install Python 3.4.2 via pyenv: `pyenv install 3.4.2`
3. Install Node.js and PostgreSQL via your system package management. (`apt-get`, `yum`, `brew` and more)
4. Install the latest [Honcho][honcho] via [pipsi][pipsi]: `pipsi install http://git.io/ZLc33g`
5. Install the [Gulp][gulp] in global: `npm install -g gulp`

### The Project Environment

1. Fork and clone the project repository: `git clone git@github.com:<yourname>/pastry.git`
2. Go into the project's directory: `cd pastry`
3. Install the frontend dependencies: `(pyenv shell system && npm install)`
4. Go into the [virtualenv][virtualenv]: `pyenv up`
5. Install the backend dependencies: `pip install -r requirements.txt -r requirements-dev.txt -r requirements-testing.txt`

### The Local Server for Development

1. Edit your local environment variable file from the `.env.example` template: `cp .env.example .env && vim .env`
2. Make sure you are inside the shell opening by `pyenv up`
3. Prepare the database:
  - Create a empty PostgreSQL database: `createdb pastry`
  - Migrate to the latest schema: `python manage.py migrate`
  - Create your administrator account: `python manage.py createsuperuser`
3. Run `honcho start` and access `http://127.0.0.1:5000/` in your browser, and `http://127.0.0.1:5100` is a [BrowserSync][browser-sync] proxy server which can be more convenient in frontend development.

Feel free to ask in the [#szulabs][irc-szulabs] IRC channel on chat.freenode.net.

[pyenv]: https://github.com/yyuu/pyenv
[pyenv-up]: https://github.com/tonyseek/pyenv-up
[honcho]: https://honcho.readthedocs.org
[pipsi]: https://github.com/mitsuhiko/pipsi
[gulp]: http://gulpjs.com
[browser-sync]: http://www.browsersync.io
[irc-szulabs]: https://webchat.freenode.net/?channels=szulabs

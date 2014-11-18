# Deployment

1. Tag the prepared release:

  ```
  $ pipsi install bumpversion  # in first time
  $ cd path/to/pastry
  $ bumpversion minor  # or "bumpversion major"
  $ git push --tags upstream master
  ```

2. Wait for Travis CI
3. Install the [uploaded package][releases] to production machines

  ```
  $ wget https://github.com/szulabs/pastry/releases/download/<VERSION>/<NAME>.whl
  $ /path/to/venv/pip install <NAME>.whl
  ```
4. Restart the processes in the production machines

[releases]: https://github.com/szulabs/pastry/releases

import subprocess


def test_available():
    output = subprocess.check_output(['pastry-admin']).decode('ascii')
    assert 'Usage: pastry-admin' in output
    assert 'collectstatic' in output
    assert 'settings are not configured' not in output

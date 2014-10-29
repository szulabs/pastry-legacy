import os
import sys

import django.core.management


def execute_from_command_line():
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'pastry.settings')
    django.core.management.execute_from_command_line(sys.argv)

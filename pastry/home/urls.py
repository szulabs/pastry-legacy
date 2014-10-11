from django.conf.urls import patterns, url

from .views import home

urlpatterns = patterns(
    'home',
    url(r'^$', home, name='home'),
)

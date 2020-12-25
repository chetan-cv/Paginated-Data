from django.contrib import admin
from django.urls import path, include
from .views import paginatedApiView


urlpatterns = [
    path("",  paginatedApiView.as_view(), name="paginated api"),
]
from django.contrib import admin
from .models import paginatedApiModel


class paginatedApiAdmin(admin.ModelAdmin):
    list_display = ['title', 'subTitile']
    search_fields = ('title', 'subTitile')
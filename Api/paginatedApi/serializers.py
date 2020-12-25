from rest_framework import serializers
from .models import paginatedApiModel


class paginatedApiSerializers(serializers.ModelSerializer):
    class Meta:
        model = paginatedApiModel
        fields = '__all__'
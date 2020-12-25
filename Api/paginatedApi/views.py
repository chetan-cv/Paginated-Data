from django.core.exceptions import ObjectDoesNotExist
from rest_framework import generics
from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response
from .serializers import paginatedApiSerializers
from .models import paginatedApiModel

class StandardResultsSetPagination(PageNumberPagination):
    page_size = 20
    page_size_query_param = 'page_size'
    max_page_size = 100


class paginatedApiView(generics.ListCreateAPIView):
    queryset = paginatedApiModel.objects.order_by("pk")
    serializer_class = paginatedApiSerializers
    pagination_class = StandardResultsSetPagination

    @staticmethod
    def post(request):
        serializer = paginatedApiSerializers(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({"msg": "data Added"}, status=200)
        return Response(serializer.errors, status=400)

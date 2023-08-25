from django.contrib import admin
from django.urls import path, include

from rest_framework.routers import DefaultRouter

from crud_note.note.views import NoteVS

router = DefaultRouter()
router.register("notes", NoteVS, basename="notes")


urlpatterns = [
    path("admin/", admin.site.urls),
    path("", include(router.urls)),
]

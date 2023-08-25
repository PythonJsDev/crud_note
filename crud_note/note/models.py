from django.db import models


class Note(models.Model):
    note_title = models.CharField(max_length=30)
    note_content = models.CharField(max_length=300, blank=True)
    create_date_time = models.DateTimeField(auto_now_add=True)
    last_edit_date_time = models.DateTimeField(blank=True, null=True)

    def __str__(self) -> str:
        return f"{self.id} {self.note_title}"

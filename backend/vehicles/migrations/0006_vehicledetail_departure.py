# Generated by Django 4.2.5 on 2023-12-04 13:54

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("vehicles", "0005_remove_vehicledetail_driver_id"),
    ]

    operations = [
        migrations.AddField(
            model_name="vehicledetail",
            name="departure",
            field=models.CharField(default=15, max_length=256),
        ),
    ]

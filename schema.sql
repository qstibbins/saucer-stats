-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "sightings_2025" (
    "id" INT   NOT NULL,
    "report_link" VARCHAR(255)   NOT NULL,
    "sighting_datetime" DATETIME   NOT NULL,
    "city" VARCHAR(100)   NOT NULL,
    "state_province" VARCHAR(100)   NOT NULL,
    "country" VARCHAR(100)   NOT NULL,
    "ufo_shape" VARCHAR(50)   NOT NULL,
    "report_summary" TEXT   NOT NULL,
    "reported_datetime" DATETIME   NOT NULL,
    "media" VARCHAR(255)   NOT NULL,
    "explanation" TEXT   NOT NULL,
    CONSTRAINT "pk_sightings_2025" PRIMARY KEY (
        "id"
     ),
    CONSTRAINT "uc_sightings_2025_report_link" UNIQUE (
        "report_link"
    )
);

CREATE TABLE "sightings_2024" (
    "id" INT   NOT NULL,
    "report_link" VARCHAR(255)   NOT NULL,
    "sighting_dateTime" DATETIME   NOT NULL,
    "city" VARCHAR(100)   NOT NULL,
    "state_province" VARCHAR(100)   NOT NULL,
    "country" VARCHAR(100)   NOT NULL,
    "ufo_shape" VARCHAR(50)   NOT NULL,
    "report_summary" TEXT   NOT NULL,
    "reported_datetime" DATETIME   NOT NULL,
    "media" VARCHAR(255)   NOT NULL,
    "explanation" TEXT   NOT NULL,
    CONSTRAINT "pk_sightings_2024" PRIMARY KEY (
        "id"
     ),
    CONSTRAINT "uc_sightings_2024_report_link" UNIQUE (
        "report_link"
    )
);

CREATE TABLE "small_dataset" (
    "id" INT   NOT NULL,
    "report_link" VARCHAR(255)   NOT NULL,
    "sighting_dateTime" DATETIME   NOT NULL,
    "city" VARCHAR(100)   NOT NULL,
    "state_province" VARCHAR(100)   NOT NULL,
    "country" VARCHAR(100)   NOT NULL,
    "ufo_shape" VARCHAR(50)   NOT NULL,
    "report_summary" TEXT   NOT NULL,
    "media" VARCHAR(255)   NOT NULL,
    "explanation" TEXT   NOT NULL,
    CONSTRAINT "pk_small_dataset" PRIMARY KEY (
        "id"
     ),
    CONSTRAINT "uc_small_dataset_report_link" UNIQUE (
        "report_link"
    )
);

CREATE TABLE "reports_by_month" (
    "id" INT   NOT NULL,
    "sighting_year" INT   NOT NULL,
    "sighting_month" INT   NOT NULL,
    "count" INT   NOT NULL,
    "sighting_year_month" VARCHAR(7)   NOT NULL,
    CONSTRAINT "pk_reports_by_month" PRIMARY KEY (
        "id"
     ),
    CONSTRAINT "uc_reports_by_month_sighting_year_month" UNIQUE (
        "sighting_year_month"
    )
);

ALTER TABLE "sightings_2024" ADD CONSTRAINT "fk_sightings_2024_id_report_link_sighting_dateTime_city_state_province_country_ufo_shape_report_summary_reported_datetime_media_explanation" FOREIGN KEY("id", "report_link", "sighting_dateTime", "city", "state_province", "country", "ufo_shape", "report_summary", "reported_datetime", "media", "explanation")
REFERENCES "sightings_2025" ("id", "report_link", "sighting_datetime", "city", "state_province", "country", "ufo_shape", "report_summary", "reported_datetime", "media", "explanation");

ALTER TABLE "small_dataset" ADD CONSTRAINT "fk_small_dataset_id_report_link_sighting_dateTime_city_state_province_country_ufo_shape_report_summary_media_explanation" FOREIGN KEY("id", "report_link", "sighting_dateTime", "city", "state_province", "country", "ufo_shape", "report_summary", "media", "explanation")
REFERENCES "sightings_2024" ("id", "report_link", "sighting_dateTime", "city", "state_province", "country", "ufo_shape", "report_summary", "media", "explanation");

ALTER TABLE "reports_by_month" ADD CONSTRAINT "fk_reports_by_month_id" FOREIGN KEY("id")
REFERENCES "sightings_2025" ("id");


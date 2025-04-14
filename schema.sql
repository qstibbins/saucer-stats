-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "sightings_2025" (
    "report_link" TEXTUNIQUE   NOT NULL,
    "sighting_datetime" TIMESTAMP   NOT NULL,
    "city" VARCHAR(100)   NOT NULL,
    "state_province" VARCHAR(100)   NOT NULL,
    "country" VARCHAR(100)   NOT NULL,
    "ufo_shape" VARCHAR(50)   NOT NULL,
    "report_summary" TEXT   NOT NULL,
    "reported_datetime" TIMESTAMP   NOT NULL,
    "media" VARCHAR(255)   NOT NULL,
    "explanation" TEXT   NOT NULL
);

CREATE TABLE "sightings_2024" (
    "report_link" TEXT   NOT NULL,
    "sighting_datetime" TIMESTAMP   NOT NULL,
    "city" VARCHAR(100)   NOT NULL,
    "state_province" VARCHAR(100)   NOT NULL,
    "country" VARCHAR(100)   NOT NULL,
    "ufo_shape" VARCHAR(50)   NOT NULL,
    "report_summary" TEXT   NOT NULL,
    "reported_datetime" TIMESTAMP   NOT NULL,
    "media" VARCHAR(255)   NOT NULL,
    "explanation" TEXT   NOT NULL,

    CONSTRAINT "uc_sightings_2024_report_link" UNIQUE (
        "report_link"
    )
);

CREATE TABLE "small_dataset" (
    "id" INT   NOT NULL,
    "report_link" TEXT   NOT NULL,
    "sighting_datetime" TIMESTAMP   NOT NULL,
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
    "sighting_year" INT   NOT NULL,
    "sighting_month" INT   NOT NULL,
    "count" INT   NOT NULL
);

ALTER TABLE "sightings_2024" ADD CONSTRAINT "fk_sightings_2024_report_link" FOREIGN KEY("report_link")
REFERENCES "sightings_2025" ("report_link");

ALTER TABLE "small_dataset" ADD CONSTRAINT "fk_small_dataset_report_link" FOREIGN KEY("report_link")
REFERENCES "sightings_2024" ("report_link");


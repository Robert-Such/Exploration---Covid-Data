--check for record count to see if all records have been imported
select COUNT(*)
From Portfolio_Project_1..[owid-covid-data]

--quick look at the main table
select *
From Portfolio_Project_1..[owid-covid-data]

--create sub-tables as 'covid_deaths' and 'covid vaccinations'
SELECT
    iso_code,
    continent,
    location,
    date,
    population,
    total_cases,
    new_cases,
    new_cases_smoothed,
    total_deaths,
    new_deaths,
    new_deaths_smoothed,
    total_cases_per_million,
    new_cases_per_million,
    new_cases_smoothed_per_million,
    total_deaths_per_million,
    new_deaths_per_million,
    new_deaths_smoothed_per_million,
    reproduction_rate,
    icu_patients,
    icu_patients_per_million,
    hosp_patients,
    hosp_patients_per_million,
    weekly_icu_admissions,
    weekly_icu_admissions_per_million,
    weekly_hosp_admissions,
    weekly_hosp_admissions_per_million
INTO covid_deaths
FROM Portfolio_Project_1..[owid-covid-data];

--quick look at covid_deaths table
select *
From Portfolio_Project_1..covid_deaths

--create sub-tables as 'covid vaccinations'
SELECT *
INTO covid_vaccinations
FROM Portfolio_Project_1..[owid-covid-data];

ALTER TABLE covid_vaccinations
DROP COLUMN
    population,
    total_cases,
    new_cases,
    new_cases_smoothed,
    total_deaths,
    new_deaths,
    new_deaths_smoothed,
    total_cases_per_million,
    new_cases_per_million,
    new_cases_smoothed_per_million,
    total_deaths_per_million,
    new_deaths_per_million,
    new_deaths_smoothed_per_million,
    reproduction_rate,
    icu_patients,
    icu_patients_per_million,
    hosp_patients,
    hosp_patients_per_million,
    weekly_icu_admissions,
    weekly_icu_admissions_per_million,
    weekly_hosp_admissions,
    weekly_hosp_admissions_per_million

--quick look at covid_vaccinations table
select *
From Portfolio_Project_1..covid_vaccinations






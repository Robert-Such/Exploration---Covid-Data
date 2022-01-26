--select data that we are going to be using
select
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
From Portfolio_Project_1..covid_deaths
order by 1,2

--comparing total cases to total deaths
select
    location,
    date,
    total_cases,
    total_deaths,
    ROUND((total_deaths/CAST(total_cases AS FLOAT)*100),2,2) AS Death_Percentage
From Portfolio_Project_1..covid_deaths
Where location = 'United States'
order by 2




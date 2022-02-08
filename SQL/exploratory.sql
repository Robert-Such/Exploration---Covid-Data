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
    ROUND((total_deaths/total_cases*100),3,3) AS Death_Percentage
From Portfolio_Project_1..covid_deaths
Where location = 'United States'
order by 2

-- Looking at Total Cases vs Population
select
    location,
    date,
    population,
    total_cases,
    ROUND((total_cases/population*100),3,3) AS Case_Percentage
From Portfolio_Project_1..covid_deaths
Where location = 'United States'
order by 2

--Looking at countries with highest infection rate compared to population
select
    location,
    population,
    MAX(total_cases) as HighestInfectionCount,
    ROUND(MAX(total_cases/population*100),3,3) AS Case_Percentage
From Portfolio_Project_1..covid_deaths
--Where location = 'United States'
Group by location, population
order by Case_Percentage desc

--showing countries with highest death count
select
    location,
    MAX(total_deaths) as TotalDeathCount
From Portfolio_Project_1..covid_deaths
Where continent is not null --filters out continents as locations
Group by location
order by TotalDeathCount desc

--showing continents with highest death count
select
    location,
    MAX(total_deaths) as TotalDeathCount
From Portfolio_Project_1..covid_deaths
Where continent is null --filters out continents as locations
Group by location
order by TotalDeathCount desc

--looking at how cases and deaths increased over time
select
    date,
    SUM(new_cases) as New_Case_Sum,
    SUM(new_deaths) as New_Death_Sum,
    ROUND((SUM(new_deaths)/SUM(new_cases))*100,3,3) as DeathPercentage
From Portfolio_Project_1..covid_deaths
where continent is not null
Group by date
order by date

--looking at total population vs vaccinations
--note that the VacPercentage will eventually exceed 100% since the vaccinations involve multiple doses
With PopvsVac (Continent, location, date, population, New_Vaccinations, RollingVac)
as
(
Select
    dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingVac
From Portfolio_Project_1..covid_deaths dea
Join Portfolio_Project_1..covid_vaccinations vac
    on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
Select *, ROUND((RollingVac/Population)*100,3,3) as VacPercentage
From PopvsVac

-- Creating Views for later visualizations
Create View PercentPopulationVaccinated as
Select
    dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (Partition by dea.location Order by dea.location, dea.date) as RollingVac
From Portfolio_Project_1..covid_deaths dea
Join Portfolio_Project_1..covid_vaccinations vac
    on dea.location = vac.location
    and dea.date = vac.date
where dea.continent is not null
--order by 2,3

Create View OverallDeathPercentage as
select
    SUM(new_cases) as New_Case_Sum,
    SUM(new_deaths) as New_Death_Sum,
    ROUND((SUM(new_deaths)/SUM(new_cases))*100,3,3) as DeathPercentage
From Portfolio_Project_1..covid_deaths
where continent is not null



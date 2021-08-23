USE COVID
--From more generic to more specific
--Location wise

--World total cases and total deaths
create view WorldDeathPercentage as
select location, 
	population ,
	max(total_cases) as TotalCases,
	max(cast(total_deaths as int)) as TotalDeaths,
	(max(cast(total_deaths as int))/max(total_cases))*100 as DeathPercentage
from CovidDeaths
where Location = 'WORLD'
group by location, population

--location total cases and total deaths
create view LocationDeathPercentage as
select continent, 
	location, 
	population,
	max(total_cases) as TotalCases, 
	max(cast(total_deaths as int)) as TotalDeaths,
	(max(cast(total_deaths as int))/max(total_cases))*100 as DeathPercentage
from CovidDeaths
where continent is not null
group by continent, location, population

-- Date wise
-- Death Percentage by date
create view DeathPercentageByDate as
select date, 
	max(total_cases) as TotalCases,
	max(cast(total_deaths as int)) as TotalDeaths,
	(max(cast(total_deaths as int))/max(total_cases))*100 as DeathPercentage
from CovidDeaths
where continent is not null and total_cases IS NOT NULL
group by date
-- order by date

-- People that are fully vaccinated
-- Locationwise
-- World
create view WorldVaccinationPercentage as 
(select location, 
	population,
	max(cast(people_fully_vaccinated as int)) as People_Fully_Vaccinated
from CovidVaccinations
where location = 'WORLD'
group by location, population)
go

--Location
create view LocationVaccinationPercentage as
select continent,
	location, 
	population, 
	max(Convert(int, people_fully_vaccinated)) as People_Fully_Vaccinated,
	max(cast(people_fully_Vaccinated as int))/population*100 as PercentagePeopleFullyVaccinated
from CovidVaccinations
where continent IS NOT NULL and people_fully_vaccinated is not null
group by continent, location, population

-- Percentage of people that are fully vaccinated with date
Create View DateVaccinationPercentage as
select continent, 
	location, 
	population,
	date, 
	people_fully_vaccinated,
	(people_fully_vaccinated/population)*100 as PercentagePeopleFullyVaccinated
from CovidVaccinations
where continent is not null AND people_fully_vaccinated IS NOT NULL
group by continent, location, population, date,people_fully_vaccinated
-- order by continent, location


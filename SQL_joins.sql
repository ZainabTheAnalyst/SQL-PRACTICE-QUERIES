--DATASET ON COLLEGE FOOTBALL PLAYERS COLLECTED FROM ESPN ON JANUARY 15,2014

--ALIASES 
--Creating a query that selects the school name, player name, position, and weight for every player in Georgia, ordered by weight (heaviest to lightest)
SELECT players.school_name, players.player_name, players.position,players.weight
FROM benn.college_football_players AS players 
WHERE players.state = 'GA'
ORDER BY players.weight DESC

--JOINS 
--Showing player names, school names and conferences for schools in the "FBS (Division I-A Teams)" division
SELECT players.player_name, players.school_name, teams.conference
  FROM benn.college_football_players AS players
  JOIN benn.college_football_teams AS teams
    ON teams.school_name = players.school_name
  WHERE teams.division = 'FBS (Division I-A Teams)'

--DATASET ON CRUNCHBASE (a crowdsourced index of startups, founders, investors, and the activities of all three) COLLECTED ON FEBRUARY 5, 2014
--Write a query that performs an inner join between crunchbase_acquisitions table and crunchbase_companies table, counting the number of non-null rows in each table
SELECT COUNT(companies.permalink) AS companies_count,
       COUNT(acquisitions.company_permalink) AS acquisitions_count
FROM tutorial.crunchbase_companies companies
JOIN tutorial.crunchbase_acquisitions acquisitions 
ON companies.permalink = acquisitions.company_permalink -- SAME COUNT OF 1673 IN BOTH TABLES 
    
--Modify the query above to be a LEFT JOIN. Note the difference in results
SELECT COUNT(companies.permalink) AS companies_count,
       COUNT(acquisitions.company_permalink) AS acquisitions_count
FROM tutorial.crunchbase_companies companies
LEFT JOIN tutorial.crunchbase_acquisitions acquisitions 
ON companies.permalink = acquisitions.company_permalink -- DIFFERENT COUNTS IN BOTH TABLES WITH THE 'tutorial.crunchbase_companies' HAVING MORE ROWS

--Count the number of unique companies and unique acquired companies by state.Do not include results for which there is no state data, and order by the number of acquired companies (high to low)
SELECT companies.state_code,
       COUNT(DISTINCT companies.permalink) AS companies_uniquecount,
       COUNT(DISTINCT acquisitions.company_permalink) AS acquisitions_uniquecount
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink
  WHERE companies.state_code IS NOT NULL   
  GROUP BY 1
  ORDER BY 3 DESC

--Showing company's name, status and the number of unique investors in the company.Order by number of investors and limit only to companies in NY
SELECT companies.name AS company_name,
       companies.status,
       COUNT(DISTINCT investments.investor_name) AS unqiue_investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink
 WHERE companies.state_code = 'NY'
 GROUP BY 1,2
 ORDER BY 3 DESC
 
 --UNIONS 
-- Write a query that includes the two crunchbase_investments datasets above (including duplicate values). Filter the first dataset to only companies with names that start with the letter "T", and filter the second to companies with names starting with "M"
SELECT company_permalink, company_name, investor_name
  FROM tutorial.crunchbase_investments_part1
  WHERE company_name ILIKE 'T%'

 UNION

 SELECT company_permalink, company_name, investor_name
   FROM tutorial.crunchbase_investments_part2
   WHERE company_name ILIKE 'M%'

--Write a query that shows 3 columns. The first indicates which dataset (part 1 or 2) the data comes from, the second shows company status, and the third is a count of the number of investors
SELECT 'investments_part1' AS dataset_name,
       companies.status,
       COUNT(DISTINCT investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part1 investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1,2

 UNION ALL
 
 SELECT 'investments_part2' AS dataset_name,
       companies.status,
       COUNT(DISTINCT investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part2 investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1,2

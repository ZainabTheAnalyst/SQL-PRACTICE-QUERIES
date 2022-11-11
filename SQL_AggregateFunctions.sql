-- AGGREGATE FUNCTIONS IN SQL 
--Apple Stock Prices Dataset from Google Finance January 2014

--1. COUNT,SUM,MIN/MAX,AVG
--Count the number of non-null rows in the low column
SELECT COUNT(low) AS "Low"
FROM tutorial.aapl_historical_stock_price

--Show Count of every single column. With these counts, can you tell which column has the most null values?
SELECT COUNT(year)AS "Year",
       COUNT(month)AS "Month",
       COUNT(open)AS "Open",
       COUNT(high)AS "High",  -- High has most null values 
       COUNT(low)AS "Low",
       COUNT(close)AS "Close",
       COUNT(volume)AS "Volume"
FROM tutorial.aapl_historical_stock_price

--Calculate the average opening price using Sum 
SELECT SUM(open)/COUNT(open) AS avg_open_price
  FROM tutorial.aapl_historical_stock_price

--What was Apple's lowest stock price (at the time of this data collection)?
SELECT MIN(low)
  FROM tutorial.aapl_historical_stock_price

--Calculate the highest single-day increase in Apple's share value
SELECT MAX(close-open)
  FROM tutorial.aapl_historical_stock_price

--Calculate the average daily trade volume for Apple stock
SELECT AVG(volume)
  FROM tutorial.aapl_historical_stock_price

--2. GROUPBY
--Calculate the total number of shares traded each month. Order your results chronologically
SELECT year,
       month,
      SUM(volume) AS "SumofSharesTraded"
  FROM tutorial.aapl_historical_stock_price
  GROUP BY year,month
  ORDER BY year,month

--Calculate the average daily price change in Apple stock, grouped by year
SELECT year,AVG(close-open)
  FROM tutorial.aapl_historical_stock_price
  GROUP BY year
  ORDER BY year

--Calculate the lowest and highest prices that Apple stock achieved each month
SELECT year,month,MIN(low),MAX(high)
  FROM tutorial.aapl_historical_stock_price
  GROUP BY year,month
  ORDER BY year,month

-- DISTINCT 
--Showing unique values in the year column, in chronological order
SELECT  DISTINCT year 
  FROM tutorial.aapl_historical_stock_price
  ORDER BY year 

-- Creating a query that counts the number of unique values in the month column for each year
SELECT year, 
      COUNT(DISTINCT month)
FROM tutorial.aapl_historical_stock_price
GROUP BY year 
ORDER BY year 


--College Football Players Dataset collected from ESPN 

--CASE STATEMENTS
--Write a query that includes a column that is flagged "yes" when a player is from California, and sort the results with those players first
SELECT player_name, state,
      CASE WHEN state = 'CA'
      THEN 'Yes' ELSE NULL
      END AS from_California
FROM benn.college_football_players
ORDER BY 3

--Creating a column that classifies height into different categories 
SELECT player_name,height,
      CASE 
           WHEN height BETWEEN 1 AND 75 THEN 'Under 75'
           WHEN height >=75 THEN 'Over 75'
           WHEN height = 0 THEN NULL
           END AS height_bracket
FROM benn.college_football_players
ORDER BY 1

--Creating a query with all columns from benn.college_football_players and an additional column that displays the player's name if that player is a junior or senior
SELECT *,
      CASE WHEN year IN ('JR','SR') THEN player_name 
      ELSE NULL
      END
FROM benn.college_football_players

--Creating a query that counts the number of 300lb+ players for each of the following regions: West Coast (CA, OR, WA), Texas, and Other (everywhere else)
SELECT
       CASE WHEN state IN ('CA','OR','WA') THEN 'WEST COAST'
            WHEN state = 'TX' THEN 'TEXAS'
            ELSE 'OTHERS'
            END AS regional_designation,
            COUNT(1) AS players
FROM benn.college_football_players
WHERE weight >= 300
GROUP BY 1 

--Creating a query that calculates the combined weight of all underclass players (FR/SO) in California as well as the combined weight of all upperclass players (JR/SR) in California
SELECT 
    CASE WHEN year IN('FR','SO') THEN 'Underclass'
         WHEN year IN('JR','SR') THEN 'Upperclass'
         END AS class_group,
        SUM(weight) AS combined_weight
FROM benn.college_football_players
WHERE state = 'CA'
GROUP BY class_group

--Creating a query that shows the number of players at schools with names that start with A through M, and the number at schools with names starting with N - Z
SELECT 
      CASE WHEN player_name <'N' THEN 'A-M'
           WHEN player_name >='N' THEN 'N-Z'
           ELSE NULL 
           END AS name_group,
           COUNT(1)
  FROM benn.college_football_players
  GROUP BY 1
  ORDER BY 1

--Creating a query that displays no. of players in each state, with FR, SO, JR, and SR players in separate columns and another column for the total no. of players
--(Order results such that states with the most players come first)
SELECT state, 
       COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
       COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
       COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
       COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count,
       COUNT(1) AS total_players
FROM benn.college_football_players
GROUP BY 1
ORDER BY 6 DESC







        

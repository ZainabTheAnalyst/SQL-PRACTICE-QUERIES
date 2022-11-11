-- LOGICAL OPERATORS IN SQL 
-- DATA FROM BILLBOARDS MUSIC CHART FROM 1956 TO 2013

-- PRACTISING LIKE 
 --1.Where "LUDACRIS" was the member of the group 
 SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" ilike '%ludacris%'

 --2.Where artist listed in the group has a name that begins with "DJ"
 SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" LIKE 'DJ%'

 --PRACTISING IN 
 --1.Show all the enteries of "USHER" and "TAYLOR SWIFT"
 SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" IN ('Usher', 'Taylor Swift')
 
 --PRACTISING BETWEEN 
 --1.Show Top 100 songs from January 1, 1985 through December 31, 1990
 SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "year" BETWEEN 1985 AND 1990

 --PRACTISING NULL 
 --1.Show where song_name is NULL 
 SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE song_name IS NULL

 --PRACTISING AND 
 --1.Show all rows for top-10 hits for which Ludacris is part of the Group 
 SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank <= 10
   AND "group" ILIKE '%ludacris%'

--2.Show top-ranked records in 1990, 2000, and 2010
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year_rank = 1
   AND "year" IN (1990, 2000, 2010)

--3.Show the list of all songs from the 1960s with "love" in the title
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "year" BETWEEN 1960 AND 1969
   AND song_name ilike '%love%'

--PRACTISING OR 
--1.Show top-10 songs that featured either Katy Perry or Bon Jovi
SELECT *
    FROM tutorial.billboard_top_100_year_end
  WHERE year_rank <= 10
     AND ("group" ILIKE '%katy perry%' OR "group" ILIKE '%bon jovi%')

--2.Show all songs with titles that contain the word "California" in either the 1970s or 1990s
    SELECT *
      FROM tutorial.billboard_top_100_year_end
     WHERE song_name LIKE '%California%'
     AND (year BETWEEN 1970 AND 1979 OR year BETWEEN 1990 AND 1999)

--3.Show all top-100 recordings that feature Dr. Dre before 2001 or after 2009
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" ILIKE '%dr. dre%'
   AND (year <2001 OR year >2009)
 
--PRACTISING NOT 
--1. Show songs that were on the charts in 2013 and do not contain the letter "a"
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2013
   AND song_name NOT ILIKE '%a%'

--PRACTISING ORDER BY 
--1. Show all rows from 2012, ordered by song title from Z to A
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "year" = 2012
 ORDER BY song_name DESC

 --2. Show all rows from 2010 ordered by rank, with artists ordered alphabetically for each song
 SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year = 2010
 ORDER BY year_rank, artist 

 --3. Show all rows for which T-Pain was a group member, ordered by rank on the charts, from lowest to highest rank (from 100 to 1)
 SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE "group" ILIKE '%t-pain'
 ORDER BY year_rank DESC

--4. Show songs that ranked between 10 and 20 (inclusive) in 1993, 2003, or 2013. Order the results by year and rank
 SELECT *
  FROM tutorial.billboard_top_100_year_end
  WHERE year IN (2013,2003,1993)
  AND year_rank >= 10 AND year_rank <= 20
 ORDER BY year, year_rank



 

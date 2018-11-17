-- create table with average income
DROP TABLE IF  EXISTS `taxdatasum`;
CREATE TABLE IF NOT EXISTS `termproject`.`taxdatasum` (
	`id` INT NOT NULL auto_increment,
    PRIMARY KEY (`id`))
    SELECT state, zipcode, county, sum(numReturns) as numReturns, sum(totalIncome) as totalIncome,
			ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6) as avgIncome  
            from taxdata group by state, zipcode;

-- any hardcoded zips, counties, states, or restaurants would be replaced by variables
-- ZIP/COUNTY
-- top 3 in zip
SELECT name, count(*) as number
FROM restaurants
WHERE zipcode = 36117
GROUP BY name 
ORDER BY count(*) DESC 
LIMIT 3;

-- top 3 in county
SELECT name, count(*) as number
FROM restaurants
WHERE zipcode IN (
	SELECT zipcode
    FROM taxdatasum
    WHERE county = 'Morgan County' AND state = 'AL')
GROUP BY name 
ORDER BY count(*) DESC 
LIMIT 3;

-- avg income zip
SELECT avgIncome
FROM taxdatasum
WHERE zipcode = 36117;

-- avg income county
SELECT ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6)
FROM taxdatasum
WHERE  county = 'Morgan County' AND state = 'AL';

-- total returns zip
SELECT numReturns
FROM taxdatasum
WHERE zipcode = 36117;

-- total returns county
SELECT sum(numReturns)
FROM taxdatasum
WHERE  county = 'Morgan County' AND state = 'AL';


-- STATE
-- top 3 in state
SELECT name, count(*) as number
FROM restaurants
WHERE zipcode IN (
	SELECT zipcode
    FROM taxdatasum
    WHERE state = 'AL')
GROUP BY name 
ORDER BY count(*) DESC 
LIMIT 3;
-- avg income in state
SELECT avgIncome
FROM taxdatasum
WHERE state = 'AL' AND zipcode = 0;

-- total returns in state
SELECT numReturns
FROM taxdatasum
WHERE state = 'AL' AND zipcode = 0;

-- richest counties
SELECT county, ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6) as avgIncome
FROM taxdatasum
WHERE state = 'AL'
GROUP BY county
ORDER BY ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6) DESC
LIMIT 3;

-- poorest counties
SELECT county, ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6) as avgIncome
FROM taxdatasum
WHERE state = 'AL'
GROUP BY county
ORDER BY ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6)
LIMIT 3; 


-- common in richest
SELECT name, count(*) as number
FROM restaurants
WHERE zipcode IN (
	SELECT zipcode
    FROM taxdatasum
    WHERE county IN (
		SELECT * from (SELECT county
		FROM taxdatasum
		WHERE state = 'AL'
		GROUP BY county
		ORDER BY ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6) DESC
		LIMIT 3) as t1
    )

)
GROUP BY name 
ORDER BY count(*) DESC 
LIMIT 3;


-- common in poorest
SELECT name, count(*) as number
FROM restaurants
WHERE zipcode IN (
	SELECT zipcode
    FROM taxdatasum
    WHERE county IN (
		SELECT * from (SELECT county
		FROM taxdatasum
		WHERE state = 'AL'
		GROUP BY county
		ORDER BY ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6)
		LIMIT 3) as t1
    )

)
GROUP BY name 
ORDER BY count(*) DESC 
LIMIT 3;

-- ALL STATES
-- top 3 overall
SELECT name, count(*) as number
FROM restaurants
GROUP BY name 
ORDER BY count(*) DESC 
LIMIT 3;

-- avg income
SELECT ROUND((sum(totalIncome) * 1.0) / nullif(sum(numReturns), 0), 6)
FROM taxdatasum
WHERE zipcode = 0;

-- total returns
SELECT sum(numReturns)
FROM taxdatasum
WHERE zipcode = 0;

-- richest states
SELECT state, avgIncome
FROM taxdatasum
WHERE zipcode = 0
ORDER BY avgIncome DESC
LIMIT 3;

-- poorest states
SELECT state, avgIncome
FROM taxdatasum
WHERE zipcode = 0
ORDER BY avgIncome
LIMIT 3;

-- common in richest
SELECT name, count(*) as number
FROM restaurants
WHERE zipcode IN (
	SELECT zipcode
    FROM taxdatasum
    WHERE state IN (
		SELECT * from (SELECT state
		FROM taxdatasum
		WHERE zipcode = 0
		ORDER BY avgIncome DESC
		LIMIT 3) as t1
    )

)
GROUP BY name 
ORDER BY count(*) DESC 
LIMIT 3;

-- common in poorest
SELECT name, count(*) as number
FROM restaurants
WHERE zipcode IN (
	SELECT zipcode
    FROM taxdatasum
    WHERE state IN (
		SELECT * from (SELECT state
		FROM taxdatasum
		WHERE zipcode = 0
		ORDER BY avgIncome
		LIMIT 3) as t1
    )

)
GROUP BY name 
ORDER BY count(*) DESC 
LIMIT 3;
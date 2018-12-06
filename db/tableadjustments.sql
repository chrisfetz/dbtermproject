use termproject;
ALTER TABLE restaurants
    drop latitude, drop longitude, drop county, drop state;
 
DROP TABLE IF  EXISTS `taxdatasum`;
CREATE TABLE IF NOT EXISTS `termproject`.`taxdatasum` (
	`id` INT NOT NULL auto_increment,
    PRIMARY KEY (`id`))
    SELECT state, zipcode, county, sum(numReturns) as numReturns, sum(totalIncome) as totalIncome
            from taxdata group by state, zipcode;
	
CREATE INDEX idxzip
ON taxdatasum (zipcode);
CREATE INDEX idxstate
ON taxdatasum (state);
CREATE INDEX idxcounty
ON taxdatasum (county);
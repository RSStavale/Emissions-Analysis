DROP TABLE emissions_agriculture_burning_savanna_result
CREATE TABLE emissions_agriculture_burning_savanna_result(
	ID serial,
	country varchar,
	item varchar,
	element varchar,
	value numeric,
	year varchar
);

INSERT INTO emissions_agriculture_burning_savanna_result(country, item, element, value, year)
SELECT country, item, element, value, year 
		FROM emissions_agriculture_burning_savanna;


select * from emissions_agriculture_burning_savanna_result
		


create database Weather;

use Weather;

/*Q1. Create a table “Station” to store information about weather observation stations:*/

create table Station
(ID INT,
CITY CHAR(20),
STATE CHAR(2),
LAT_N INT,
LONG_W INT,
Constraint s_pk PRIMARY KEY(ID)
);


/*Q2. Insert the following records into the table:*/

Insert into station(ID, CITY, STATE, LAT_N, LONG_W)
values(13, "Phoenix", "AZ", 33, 112),
(44, "Denver", "CO", 40, 105),
(66, "Caribou", "ME", 47, 68);

/*Q3. Execute a query to look at table STATION in undefined order.*/

select * from Station;

/*Q4. Execute a query to select Northern stations (Northern latitude > 39.7).*/

select *	 
from station
where lat_n > 39.7;

/*Q5. Create another table, ‘STATS’, to store normalized temperature and precipitation data:*/

create table STATS
(ID INT references station(ID),
MONTH INT check (MONTH between 1 and 12),
TEMP_F  real check (TEMP_F BETWEEN -80 AND 150),
RAIN_I real check (RAIN_I BETWEEN 0 AND 100),
Constraint st_pk PRIMARY KEY(ID,Month)
);


/*Q6. Populate the table STATS with some statistics for January and July:*/

Insert into Stats(ID, MONTH, TEMP_F, RAIN_I)
values(13, 1, 57.4, 0.31),
(13, 7, 91.7, 5.15),
(44, 1, 27.3, 0.18),
(44, 7, 74.8, 2.11),
(66, 1, 6.7, 2.1),
(66, 7, 65.8, 4.52);

select * from stats;

/*Q7. Execute a query to display temperature stats (from STATS table) for each city (from Station table).*/

select temp_f, city
from station s INNER JOIN stats st ON s.id = st.id
order by 2; 

/*Q8. Execute a query to look at the table STATS, ordered by month and greatest rainfall, with columns rearranged.
It should also show the corresponding cities.*/

select month, rain_I, city 
from station s INNER JOIN stats st ON s.id = st.id
order by month, rain_I desc;

/*Q9. Execute a query to look at temperatures for July from table STATS, lowest temperatures first,
picking up city name and latitude.*/

select temp_f, city, lat_n
from station s INNER JOIN stats st ON s.id = st.id
where month = 7
order by temp_f asc;

/*Q10. Execute a query to show MAX and MIN temperatures as well as average rainfall for each city.*/

select city, max(temp_f) as MaxTemp, min(temp_f) as MinTemp, avg(rain_i) as AvgRain
from station s INNER JOIN stats st ON s.id = st.id
group by city;

/*Q11. Execute a query to display each city’s monthly temperature in Celcius and rainfall in Centimeter.*/

/* 1cm in inches - 0.3937008in */
/* C = (F-32)*5/9 */

select id, month, (temp_f-32) * 5/9 as TempCelcius, rain_i * 0.3937008 as RainfallCm
from stats; 

/*Q12. Update all rows of table STATS to compensate for faulty rain gauges known to read 0.01 inches low.*/

SET SQL_SAFE_UPDATES =0;

update stats
set rain_i = rain_i + 0.01;

/*13. Update Denver's July temperature reading as 74.9*/

update stats
set temp_f = 74.9
where id = 44 and month = 7;

/*Now we again look at the stats table to see the change*/

select * from stats;

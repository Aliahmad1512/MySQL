Use school_db;

select * from student;

/*ETL
1. Extract - the girls who have scored more than 90 in Maths
2. Transform - convert their maths test score to Final Maths test score by 35%.
3. Load (or Save) the transformed Final Maths score into final reports.
*/

/*Extract*/

SELECT id, fullname, sex, mtest
FROM student
WHERE SEX = "f" and Mtest > 90;

/*Transform - Multiply Maths score by 35%*/

SELECT id, fullname, sex, mtest * .35 as FinalMtest
from student 
where sex = "f" and Mtest > 90;

/*Create the destination table to Load the data*/

CREATE TABLE FinalScore
(id int,
fullname char(100),
sex char(5),
FinalMtest int
);

INSERT INTO FinalScore(id, fullname, sex, FinalMtest)
SELECT id, fullname, sex, mtest * .35 as FinalMtest
from student 
where sex = "f" and Mtest > 90;

/*Now looking at the FinalScore table*/
SELECT * from FinalScore;

/* EXTRACT TRANSFORM LOAD (ETL)*/

use zomato;

select * from zomato;

/*ETL
1. Extract - cuisines that are Japenese and Filipino and HasTablebooking is Yes.
2. Transform - divide the averagecostfortwo by pricerange .
3. Load (or Save) the transformed Final Maths score into final reports.
*/

/*Extract*/

SELECT restaurantname, cuisines, averagecostfortwo, pricerange, HasTablebooking 
from zomato
where cuisines IN ("Japanese", "Filipino") and HasTablebooking = "Yes";

/*Transform - divide the averagecostfortwo by pricerange*/

SELECT restaurantname, cuisines, averagecostfortwo, pricerange, HasTablebooking,
averagecostfortwo / pricerange as Final
from zomato
where cuisines IN ("Japanese", "Filipino") and HasTablebooking = "Yes";

/*Load - Create the destination table to Load the transformed data*/
CREATE TABLE FinalZomato
(restaurantname char(100), 
cuisines char(100), 
averagecostfortwo int, 
pricerange int ,
HasTablebooking char(100),
Final int);

INSERT INTO FinalZomato(restaurantname, cuisines, averagecostfortwo, pricerange, HasTablebooking, Final)
SELECT restaurantname, cuisines, averagecostfortwo, pricerange, HasTablebooking,
averagecostfortwo / pricerange as Final
from zomato
where cuisines IN ("Japanese", "Filipino") and HasTablebooking = "Yes";

/*Now looking at the FinalZomato table*/

SELECT * from Finalzomato;


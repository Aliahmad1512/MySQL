create database HarryPotter;

use harrypotter;

select * from wands;

select * from wands_property;

/*Query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power.
If more than one wand has same power, sort the result in order of descending age.*/

select w.id, wp.age, min(w.coins_needed) as MinCoinsNeed, w.power
from wands as w, wands_property as wp
where w.code = wp.code and wp.is_evil = 0
group by w.power, wp.age
order by w.power desc, wp.age desc;

/*count for power*/
select id, power , count(power)
from wands 
group by power;

/*OR*/

select w.id, wp.age, w.coins_needed, w.power
from wands w inner join wands_property wp on w.code = wp.code
where w.coins_needed = (select min(coins_needed) 
			from wands w1 inner join wands_property wp1 on w1.code = wp1.code
			where wp1.is_evil = 0 and w.power = w1.power and wp.age = wp1.age) 
			order by w.power desc, wp.age desc;







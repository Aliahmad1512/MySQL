create database FacilityServices;

use FacilityServices;

create table TransactionMaster
(Key_ID int,
Branch_Number int,	
Customer_Number int,
Product_Number int,
Invoice_Number int,	
Service_Date date,
Invoice_Date date, 
Sales_Amount int,	
ContractedHours int,	
Sales_Period varchar(10),
Sales_Rep int
);

create table CustomerMaster
(Customer_Number int,
FirstOfCustomer_Name varchar(100),
FirstOfCity varchar(50),
FirstOfState varchar(50)
);

Create table employee_master
(Employee_Number INT, 
Last_Name Char(100), 
First_Name Char(100), 
Employee_Status Char(100), 
Hire_Date date, 
Last_Date_Worked date, 
Job_Title Char(100), 
Job_Code Char(100), 
Home_Branch Int
);

create table LocationMaster
(Branch_Number int,
Market varchar(100),
Region varchar(100)
);

create table PriceMaster
(Branch_Number int,
Product_Number int,
Price int
);

create table ProductMaster
(Product_Number int,
Product_Description varchar(100),
Business_Segment varchar(100)
);

create table TestComments
(CommentNumber int,
Comment varchar(100), 
CommentLength int
);

/*EXERCISE 1*/

/*1.From the TransactionMaster table, select a list of all items purchased for Customer_Number 296053. Display the Customer_Number, Product_Number, and Sales_Amount for this customer.*/

select customer_number, product_number, sales_amount
from transactionmaster 
where customer_number= 296053;

/*2.Select all columns from the LocationMaster table for transactions made in the Region = NORTH.*/

select Branch_Number, market, region 
from locationmaster  
where region = "NORTH";

/*3.Select the distinct products in the TransactionMaster table. Display a listing of each of the unique products from the TransactionMaster table.*/

select distinct product_number
from transactionmaster;

/*4.List all the customers without duplication*/

select distinct customer_number
from transactionmaster;

/*EXERCISE 2*/

/*1.Find the average sales amount for product number 30300 in sales period P03.*/

select product_number, sales_period, avg(sales_amount) as AvgSalesAmt 
from transactionmaster 
where product_number = 30300 and sales_period = "P03";

/*2.Find the maximum sales amount amongsrt all the transactions*/

select max(sales_amount) as MaxAmt
from transactionmaster;

/*3.Count the total number of transactions for each product number and display in descending order*/

select product_number, count(product_number) as TotalNoTransaction 
from transactionmaster 
group by product_number 
order by product_number desc;

/*4.List the total number of transactions in sales period P02 and P03*/

select sales_amount, count(sales_amount) as TotalNoTransaction 
from transactionmaster 
where sales_period IN ("P02", "P03");

/*5.What is the total number of rows in the transactionmaster table?*/

select count(*) as TotalNoOfRows 
from transactionmaster;

/*6.Look into the Pricemaster table to find the price of the cheapest product that was ordered*/

select branch_number, product_number, min(price) as MinPrice 
from pricemaster;

/*EXERCISE 3*/

/*1.Select all Employees where Employee-Status = “A”*/

select last_name, first_name, employee_status 
from employee_master 
where employee_status like "A";

/*2.Select all Employees where JobDescription is “TEAMLEAD1”.*/

select employee_number, last_name, first_name, job_title 
from employee_master 
where job_title like "teamlead 1";

/*3.List the Lastname, EmployeeStatus and JobTitle of all employees whose names contain the letter "o" as the second letter*/  

select last_name, employee_status, job_title 
from employee_master 
where last_name like "_o%";
            
/*4.List the lastname, emolyee status and job title of all employees whose first names start with letter "A" and doest not contain the letter "i"*/

select last_name, employee_status, job_title 
from employee_master 
where first_name like "A%" 

/*5.List the first name and last names of employees with employee status "I" whose job code is not SR2 and SR3*/

select first_name, last_name 
from employee_master 
where employee_status like "%I%" and job_code not in ("SR2","SR3");

/*6.Find out details of employees whose last name ends with "N" and first name begins with "A" or "D"*/

select employee_number, first_name, last_name 
from employee_master 
where last_name like "%N" and first_name regexp "^[AD]";

/*7.Find the list of products with the word "maintenance" in their product description*/

select product_number, product_description 
from productmaster 
where product_description like "%maintenance%";


/*EXERCISE 4*/

/*1.List the employees who were hired before 01/01/2000*/

select last_name, first_name, hire_date 
from employee_master 
where hire_date < "2000-01-01";

/*2.Find the total number years of employment for all the employees who have retired*/

select count(Last_Date_Worked) as TotalNoYrs 
from employee_master;

/*3.List the transactions which were performed on weds or sats*/

select key_id, (Weekday(Invoice_Date)),
dayname(Invoice_Date) as Wkdayname
from transactionmaster
where Weekday(Invoice_Date) IN (2,5);

/*EXERCISE 5*/

/*2.*/

select sales_period, avg(sales_amount) 
from transactionmaster 
group by sales_period;

/*3.*/

select count(customer_number) CntOfCust 
from transactionmaster;

/*4.*/

select count(customer_number) as Cnt, avg(sales_amount) as Avg 
from transactionmaster 
group by branch_number;

/*5.*/

select product_number, max(sales_amount), min(sales_amount) 
from transactionmaster 
group by product_number;

/*EXERCISE 6*/

/*1.*/

select customer_number, firstofcustomer_name, firstofcity, firstofstate 
from customermaster 
order by FirstOfCustomer_Name asc;

/*2.*/

select customer_number, firstofcustomer_name, firstofcity, firstofstate 
from customermaster 
order by FirstOfCustomer_Name desc;

/*3.*/

select product_number, sales_amount 
from transactionmaster 
where sales_amount > 100.00 order by sales_amount desc;

/*EXERCISE 7*/

/*1.*/

select region, count(*) as CntOfBrNum 
from locationmaster 
group by region 
having CntOfBrNum > 1;

/*2.*/

select product_number, max(sales_amount) as Max, min(sales_amount) as Min 
from transactionmaster 
group by product_number 
having Max > 390.00;

/*3.*/

select customer_number, count(*) as NoOfOrders
from transactionmaster
group by customer_number
having count(invoice_number) > 1;

/*EXERCISE 8*/

/*1.*/

select employee_number, last_name, first_name, hire_date
from employee_master 
where hire_date between "2004-03-22" and "2004-04-21"
order by hire_date asc;

/*2.*/

select employee_number, last_name, first_name, job_code 
from employee_master 
where job_code IN ("SR1", "SR2","SR3") order by job_code asc;

/*3.*/

select invoice_date, product_number, branch_number 
from transactionmaster 
where sales_amount between 150.00 and 200.00;

/*4.*/

select branch_number, market, region 
from locationmaster 
where market IN ('Dallas','Denver','Tulsa', 'Canada');



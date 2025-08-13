create database books_database;

use books_database;

create table books(
book_id int auto_increment primary key,
title varchar(100),
author varchar(100),
genre varchar(100),
published_year int,
price numeric(10,2),
stock int
)engine=InnoDB;

create table customers(
customer_id int auto_increment primary key,
name varchar(100),
mail varchar(100),
phone varchar(15),
city varchar(20),
country varchar(20)
)engine=InnoDB;

create table orders(
order_id int auto_increment primary key,
customer_id int ,
book_id int,
order_date VARCHAR(20),
quantity int,
total_amount numeric(10,2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (book_id) REFERENCES books(book_id)
)engine=InnoDB;

select * from books;
select * from customers;
select * from orders;

-- drop table books;
-- drop table customers;
-- drop table orders  

-- 1) Retrieve all books in the "Fiction" genre:
select * from books where genre="Fiction";

-- 2) Find books published after the year 1950:
select * from books where published_year="1950";

-- 3) List all customers from the Canada:
select * from customers where country ="Canada";

-- 4) Show orders placed in November 2023:
alter table orders add column order_month varchar(20);
UPDATE orders
SET order_month = MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
WHERE order_id > 0;

alter table orders add column order_year varchar(20);
SET SQL_SAFE_UPDATES = 0;
UPDATE orders SET order_year = YEAR(STR_TO_DATE(order_date, '%d-%m-%Y'))WHERE STR_TO_DATE(order_date, '%d-%m-%Y') IS NOT NULL;

select * from orders where order_month="November" and order_year="2023" ;

-- 5) Retrieve the total stock of books available:
select sum(stock) from books;

-- 6) Find the details of the most expensive book:
select * from books where price = (select max(price) from books);
select * from(select *, dense_rank() over(order by price desc)as ranks from books) as ranked_book where ranks=1;


-- 7) Show all customers who ordered more than 1 quantity of a book:
select name,quantity from customers join  orders on customers.customer_id = orders.customer_id where quantity>1 order by quantity desc;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders where total_amount>20 ;

-- 9) List all genres available in the Books table
select distinct(genre) from books ;

-- 10) Find the book with the lowest stock:
select * from books where stock=1; 

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) as revenue from orders;


-- Advance Questions : 
-- 1) Retrieve the total number of books sold for each genre:
select  * from books ;
select * from orders ;

select genre,sum(quantity) as total_sold_book from books join orders
on books.book_id = orders.book_id
group by genre order by total_sold_book desc;

-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) from books where genre="Fantasy";

-- 3) List customers who have placed at least 2 orders:

select orders.customer_id ,customers.name, count(orders.customer_id) as total_count 
from orders join customers
on orders.customer_id = customers.customer_id
group by customer_id having total_count>=2  
order by total_count;

-- 4) Find the most frequently ordered book:
select * from (
select orders.book_id ,books.title ,count(order_id) as count ,
dense_rank() over(order by count(order_id) desc) as ranks
from orders join books
on orders.book_id = books.book_id
group by orders.book_id,books.title
order by count desc) as ranked_data
where ranks=1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select title,genre,price from books where genre="Fantasy" order by price desc limit 3;	

-- 6) Retrieve the total quantity of books sold by each author:
select author , sum(orders.quantity)as total_quantity
from books join orders
on books.book_id = orders.book_id
group by author order by total_quantity;

-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city,sUM(o.total_amount)
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.city
HAVING SUM(o.total_amount) > 30;
 
-- 8) Find the customer who spent the most on orders:

select customers.customer_id ,customers.name ,sum(orders.total_amount) as spent 
from orders  join customers
on orders.customer_id = customers.customer_id
group by customers.customer_id,customers.name 
order by sum(orders.total_amount) desc limit 1;

-- 9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;

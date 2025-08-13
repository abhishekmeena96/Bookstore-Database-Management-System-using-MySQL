# Bookstore-Database-Management-System-using-MySQL

Bookstore Database Management System – MySQL
Overview
This project demonstrates the design, creation, and management of a bookstore database using MySQL. It includes a relational database schema with three main tables – books, customers, and orders – connected through primary and foreign key relationships. The project covers data insertion, retrieval, and analysis to generate valuable business insights for decision-making and inventory control.

The SQL scripts include both basic queries (for filtering, sorting, and aggregating data) and advanced queries (using JOIN, GROUP BY, subqueries, window functions, and MySQL built-in functions like MONTHNAME(), YEAR(), and COALESCE()).

Database Schema
Tables:

books – Stores book details including title, author, genre, price, publication year, and stock quantity.

customers – Contains customer details such as name, email, phone, city, and country.

orders – Stores order transactions, linking customers to purchased books with order date, quantity, and total amount.

Features & Queries Implemented
Basic Queries
Retrieve books by genre, publication year, and stock levels.

List customers from specific locations.

View orders within specific months and years.

Find most expensive or lowest stock books.

Calculate total revenue and available stock.

Advanced Queries
Total books sold by genre.

Average price of books in specific genres.

Customers with multiple orders.

Most frequently ordered books.

Top-selling authors and high-spending customers.

Remaining stock after fulfilling orders.

Key Skills Demonstrated
Database design with primary/foreign keys and InnoDB engine.

Data analysis using aggregations, subqueries, and window functions.

Data formatting and transformation with MySQL functions.

Writing optimized, readable, and well-structured SQL queries.

How to Use

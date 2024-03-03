# SQL
SQL - Lab Assignments


Lab 1
Due October 24, 2023 8:00 PM
Instructions
Think about a simple application that requires a database. Represent the application data in a relational structure and implement the structure in a SQL Server database. The database must contain at least 6 tables and also to implement at least one 1-n relationship and at least one m-n relationship.

-----------------------------------

Lab 2
Due November 21, 2023 8:00 PM
•
Closes December 20, 2023 8:30 PM
Instructions
For the database created for the first lab, write SQL statements that ♦ insert data – for at least 4 tables; 

♦ update data – for at least 1 table; 

♦ delete date – for at least 1 table. 

In the UPDATE / DELETE statements, use at least once (in the WHERE clause):  the relational operators {<, <=, >, >=, =, <>}, the logical operators {AND, OR,  NOT}, {IS NULL, IS NOT NULL}, {IN, BETWEEN}, {LIKE, NOT LIKE}. At  least one operator from each category (mention above) should be used.  

On the same database, write the following SELECT queries: 

a. 3 queries with UNION, INTERSECT, EXCEPT (one query per operator); b. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN (one  query per operator); one query will join at least 3 tables; 

c. 2 queries using IN and EXISTS to introduce a subquery in the WHERE  clause (one query per operator); 

d. 1 query with a subquery in the FROM clause; 

e. 3 queries with the GROUP BY clause, from which 2 queries will also  contain the HAVING clause; 1 query from the latter 2 will also have a  subquery in the HAVING clause; use the aggregation operators: SUM,  AVG, MIN, MAX, COUNT. 

In the SELECT queries mentioned above, you must use: 

♦ At least one composed condition with AND, OR, NOT in the WHERE  clause, for 2 queries; 

♦ DISTINCT in at least 1 query; TOP in at least 1 query; 

♦ ORDER BY in at least 2 queries. 

-----------------------------------

Lab 3
Due December 5, 2023 8:00 PM
•
Closes December 20, 2023 8:30 PM
Instructions
Sometimes, after we design a database, we need to change its structure. But,
unfortunately, not all the changes performed are correctly every time, so they
must be reverted. The task is to create a versioning mechanism that will facilitate
the transition between different versions of the database.

For the database created for the first lab, write SQL scripts that:
add / remove a column;
add / remove a DEFAULT constraint;
create / drop a table;
add / remove a foreign key.
For each of the scripts above, write another one that reverts the operation. Also,
create a new table in which will be hold the current version of the database. For
simplicity, the version of the database is assumed to be an integer number.

Place each of the scripts in a different stored procedure and use a simple and
intuitive naming convention.

Write another stored procedure that receives as a parameter a version number and
brings the database to that version.

-----------------------------------

Lab 4
Due December 19, 2023 8:00 PM
•
Closes December 20, 2023 8:30 PM
Instructions
Consider the database created for the first lab.

a. Implement a stored procedure for the INSERT operation on 2 tables in 1-
n relationship; the procedure’s parameters should describe the entities /
relationships in the tables; the procedure should use at least 1 user-defined
function to validate certain parameters.

b. Create a view that extract data from at least 3 tables and write a SELECT
on the view that returns useful information for a potential user.

c. Implement a trigger for a table, for INSERT, UPDATE or/and DELETE;
the trigger will introduce in a log table, the following data: the date and the
time of the triggering statement, the trigger type (INSERT / UPDATE /
DELETE), the name of the affected table and the number of added /
modified / removed records.

d. Write a query that contains at least 2 of the following operators in the
execution plan (by using WHERE, ORDER BY, JOIN’s clauses):
clustered index scan;
clustered index seek;
nonclustered index scan;
nonclustered index seek;
key lookup

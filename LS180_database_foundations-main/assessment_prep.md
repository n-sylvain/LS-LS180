# [Study Guide](https://launchschool.com/lessons/79816993/assignments/8b5cf8b4)

## SQL

1. Identify the different types of JOINs and explain their differences.

- INNER: This is the default type of join. It returns the rows where both tables have corresponding data.
- LEFT: (AKA LEFT OUTER) Takes all the rows from the left hand table (ie the first table to be referenced in the query) even when there is no corresponding data in the right hand table. Missing values will be represented by null.
- RIGHT: (AKA RIGHT OUTER) As above, but the right hand table (ie the second table to be referenced in the JOIN) has all rows represented.
- FULL: (AKA FULL OUTER) A combination of the Left and RIght outer joins, so all rows of data from both tables will be returned, even when there are NULL values on either side.
- CROSS JOIN: (AKA cartesian join) returns all possible combinations of rows from both tables. Since all possible combinations are returned there is no ON clause/join condition.
- multiple joins: This is simply adding multiple JOINS together in the same query. This is how many to many relationships between tables are implemented, with a third table acting as a join table.

2. Name and define the three sublanguages of SQL and be able to classify different statements by sublanguage.
- DDL: Data Definition Language: For defining the structure of databases. Their tables and columns. For example all `CREATE` statements (even CREATE SEQUENCE) and `ALTER TABLE ALTER COLUMN`  
- DML: Data Manipulation Language: For retrieving and modifying data. `SELECT` queries for example. 
- DCL: Data Control Language: Used to determine what various users are allowed to do when interacting with a database. For example `GRANT SELECT ON employees TO john;`

3. Write SQL statements using INSERT, UPDATE, DELETE, CREATE/ALTER/DROP TABLE, ADD/ALTER/DROP COLUMN.

```
INSERT INTO cheeses(name, weight_grams) VALUES ('Gouda', 200), ('Stilton', 300);
```

```
UPDATE food__consumed
SET weight_int = NULL
WHERE DATE(time) = '2023-06-09 22:00:00' AND food_name = 'milk';
```

```
DELETE FROM people WHERE state = 'CA';
```

```
CREATE TABLE temperatures(
  date timestamp NOT NULL,
  low integer NOT NULL,
  high integer NOT NULL); 
```

```
ALTER TABLE temperatures ALTER COLUMN rainfall TYPE decimal(6,4);
```

```
DROP TABLE albums;
```

```
ALTER TABLE months_2023
      ADD COLUMN id int;
```

```
ALTER TABLE employees ALTER COLUMN department SET DEFAULT 'unassigned';
```

```
ALTER TABLE animals DROP COLUMN name;
```

4. Understand how to use GROUP BY, ORDER BY, WHERE, and HAVING.

- GROUP BY: This is a query clause that allows one to group the results in order to make them more meaningful. Any column that is not included in the GROUP BY clause must be used with an aggregate function or be part of the GROUP BY clause. This is because SQL needs to know how to aggregate or summarize the data for each group. Example:
```
SELECT product_id, SUM(quantity_sold) AS total_quantity
FROM sales
GROUP BY product_id;
```
- ORDER BY: This is a clause which states in what order results should be displayed. It can take the arguments `ASC` and `DESC`.
```
SELECT product_name, price
FROM products
WHERE category_id = 1
ORDER BY price DESC;
```
- WHERE: This clause in SQL is used to filter rows based on a condition. It can be used with comparison operators (`=`, `<`, `>`) or logical operators like `NOT`, `LIKE` and `IN`. For example:

```
SELECT product_name, price
FROM products
WHERE category_id = 1;
```

- HAVING: This clause is used in conjunction with the `GROUP BY` clause to filter results. It's often used with aggregate functions like `SUM` to filter the results of those queries. For instance:

```
SELECT category_id, AVG(price) AS avg_price
FROM products
GROUP BY category_id
HAVING AVG(price) > 100;
```

5. Understand how to create and remove constraints, including CHECK constraints

`ALTER TABLE films ADD CONSTRAINT date_20th_century CHECK (year BETWEEN 1900 AND 2100);`
`ALTER TABLE films ADD CONSTRAINT title_unique UNIQUE (title);`
`ALTER TABLE films DROP CONSTRAINT title_unique;`
`ALTER TABLE orders
ADD CONSTRAINT fk_order_customer
FOREIGN KEY (customer_id)
REFERENCES customers (customer_id);
`

6. Be familiar with using subqueries

- lots of examples in `/Users/sandyboy/Desktop/LS180_database_foundations/03_sql_fundamentals_exercises/06_medium_subqueries_and_more.sql`
```
SELECT items.name AS "Bid on Item" FROM items WHERE id IN
  (SELECT item_id FROM bids);
```

## PostgreSQL

7. Describe what a sequence is and what they are used for.

- A sequence is a type of relation which is used to create indexes for columns. When we use the data-type `serial`, SQL automatically created a sequence which is a series of numbers which auto-increments by keeping track of the last number. The next number in a sequence can be returned using `nextval`. For example `SELECT nextval('colors_id_seq');`.
- Sequences are usually created using the `serial` data-type so:

```
-- this statement:
CREATE TABLE tractors (id serial, name text);

-- is athe same as:

CREATE SEQUENCE tractors_id_seq;
CREATE TABLE tractors (
    id integer NOT NULL DEFAULT nextval('tractors_id_seq'),
    name text
);
```

or

```
CREATE TABLE aliens (
  name text DEFAULT 'unknown'
);

CREATE SEQUENCE aliens_id_seq;

ALTER TABLE aliens ADD COLUMN id integer NOT NULL DEFAULT nextval('aliens_id_seq');
```

9. Define a default value for a column.

` CREATE TABLE aliens (
  name text DEFAULT 'unknown'
);`

8. Create an auto-incrementing column.

```
CREATE TABLE furniture (
  id serial
);
```

or

```
CREATE SEQUENCE furniture_id_seq;
CREATE TABLE furniture (
  id integer NOT NULL DEFAULT nextval('furniture_id_seq`)
);
```

10. Be able to describe what primary, foreign, natural, and surrogate keys are.

- PRIMARY KEYS: A constraint placed on a column to link two tables with common data. This can be an important way of enforcing referencinal integrity by de-duplicating and normalizing data. Usually the primary key will be unique automatically incrementing integers, such as a sequence. Also ensures that the column cannot contain NULL values. Tables can only have 1 primary key.
- FOREIGN KEYS: A constraint placed on a column in one table creating a link to another table's PRIMARY KEY. This is done with the `REFERENCES` clause.

```
FOREIGN KEY (fk_col_name)
REFERENCES target_table_name (pk_col_name);
```
 
- SURROGATE KEYS: Natural keys are values that exist in the the table that can be adopted as a key. THis is fraught with problems as almost nothing is naturally unique. Surrogate keys are columns of data created only for use as a key. They usually contain auto-incremnenting integers

```
CREATE TABLE colors (id serial PRIMARY KEY, name text);
```

11. Create and remove CHECK constraints from a column.

- `ALTER TABLE films ADD CONSTRAINT date_20th_century CHECK (year BETWEEN 1900 AND 2100);`
- `ALTER TABLE films ADD CONSTRAINT director_length CHECK length(director) >= 3 AND substring(director ' ');`

12. Create and remove foreign key constraints from a column.

```
ALTER TABLE countries DROP CONSTRAINT countries_continent_id_fkey;

ALTER TABLE countries
ADD CONSTRAINT countries_continent_id_fkey
FOREIGN KEY (continent_id)
REFERENCES continents(id);
```

## Database Diagrams

13. Talk about the different levels of schema.

  - Conceptual (boxes and lines) = least detail, bigger objects
    - "A high level design focused on identifying entities and their relationships."
    - An ERD (Entity relationship diagram)
      - This can show one-to-one, one-to-many and many-to-many relationships. 
  - logical (skip) a combination of the other two. Not often dealth with. 
  - Physical (tables)
    - "A low-level design focused on implementation".
    -  most detail. Includes attirbutes, datatypes, rules about how these entitites will relate.
    - Little 'p's and 'f's  and 'n's for contstraints.

14. Define cardinality and modality.

- Cardinality: How many relations a table has. "The number of objects on each side of the relationship".
- Modality: whether a relationship is necessary or not ("required or optional")

15. Be able to draw database diagrams using crow's foot notation.

- tick

## Quiz corrections:

Q1 

5. Read the question carefully, the following snippets are actually correct:

A:

```
CREATE TABLE airlines (
  id serial PRIMARY KEY,
  airline_name varchar(30),
  country varchar(50),
  iata_code char(2),
  icao_code char(3),
  website varchar(40),
  CHECK (length(iata_code) = 2),
  CHECK (length(icao_code) = 3)
);
ALTER TABLE airlines
  ALTER COLUMN airline_name SET NOT NULL;
```

C:

```
CREATE TABLE airlines (
  id serial PRIMARY KEY,
  airline_name varchar(30) NOT NULL,
  country varchar(50),
  iata_code char(2),
  icao_code char(3),
  website varchar(40)
);
ALTER TABLE airlines
  ADD CHECK (length(iata_code) = 2),
  ADD CHECK (length(icao_code) = 3);
```

7. F: Remove a column (including all the data in that column) is achieved with `ALTER`:

`ALTER TABLE aliens
      DROP COLUMN name;`

8. This is the only correct syntax available:

```
ALTER TABLE todos
  ADD COLUMN status boolean NOT NULL;
```

9. When inserting data you can't have more target columns than data actually entered. You can leave out the columns, but in that case PostgreSQL will add the data in the order of the columns, so usually starting with `id`, which can be dangerous.

10. We are trying to add a `1` into the id column, but there already is a `1` and it is a `PRIMARY KEY`, which means it cannot contain duplicates.

11. This error was pure carelessness.

15. Left outer join also returns the desired output. Maybe do some more exercises with JOINS.

Q2

5. This was carelessness.
6.  Carelessness.

Q3

7. A LEFT OUTER JOIN would return all the users in the `library_users` table regardless of whether they had taken out a book or not.
8. Ascending names means A at the top, just as ascending numbers means 1 at the top and 20 at the bottom.

## To do (25.11.23)

|  | Once | Twice | Thrice |
| :--- | :---: | :---: | :---: |
| Write answers for 'study guide' questions above (with bullet-proof examples)| 26.11.23 |  
| redo quizes | 27.11.23 |
| write out quiz-errors | 27.11.23 | 
| Re-do LS exercises that I failed/peaked first time.| 
| Refine 'study guide' answers above | 
| 2nd go through course + fill-out notes|
| fancy extras (aggregate functions) |
| fancy extras(Stringagg) |
| Take assessment on/before Thursday 30th November| 


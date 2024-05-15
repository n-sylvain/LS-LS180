
# Relational Data and Joins

## [What to Focus On](https://launchschool.com/lessons/5ae760fa/assignments/28d79a9d)

- How to work with multiple tables using `JOIN`
- SQL optional keywords
- How schemas change over time
- Make sure you spend some time with the Summary at the end of this lesson.

## [What is Relational Data?](https://launchschool.com/lessons/5ae760fa/assignments/074f64a8)

- This page explains about what is a 'relations' and what is a 'relationship'. I feel confident that I know this.

## [Database Diagrams: Levels of Schema](https://launchschool.com/lessons/5ae760fa/assignments/2f3bc8f7)

- video
  - Conceptual (boxes and lines) = least detail, bigger objects
    - "A high level design focused on identifying entities and their relationships."
    - An ERD (Entity relationship diagram)
      - This can show one-to-one, one-to-many and many-to-many relationships. 
  - logical (skip) a combination of the other two. Not often dealth with. 
  - Physical (tables)
    - "A low-level design focused on implementation".
    -  most detail. Includes attirbutes, datatypes, rules about how these entitites will relate.
    - Little 'p's and 'f's  and 'n's for contstraints.

## [Database Diagrams: Cardinality and Modality](https://launchschool.com/lessons/5ae760fa/assignments/46053e3b)
## [A Review of JOINs](https://launchschool.com/lessons/5ae760fa/assignments/0391f663)
## [Working with Multiple Tables](https://launchschool.com/lessons/5ae760fa/assignments/285d837e)


2. `SELECT COUNT(*) FROM tickets;`
3. `SELECT count(distinct customer_id) FROM tickets;`
4. Write a query that determines what percentage of the customers in the database have purchased a ticket to one or more of the events. (First day I failed, second day I got it)

```
SELECT round(count(DISTINCT t.customer_id) / count(DISTINCT c.id)::decimal * 100, 2)
AS percent FROM customers AS c
LEFT OUTER JOIN tickets AS t
ON c.id = t.customer_id
;
```

5.

```
SELECT e.name, count(t.id) AS popularity FROM events AS e
LEFT OUTER JOIN tickets as t
ON t.event_id = e.id
GROUP BY e.name
ORDER BY popularity DESC;
```

6.

```
SELECT c.id, c.email, count(DISTINCT t.event_id) AS count 
FROM tickets AS t
RIGHT OUTER JOIN customers AS c
ON c.id = t.customer_id
GROUP BY c.id
HAVING count(DISTINCT t.event_id) = 3
;
```

7. This ate up a lot of my time, I got this far, which joins all the tables, but with incorrect output

```
SELECT e.name AS event, e.starts_at, sec.name, s.row, s.number AS seat
FROM events AS e
LEFT OUTER JOIN tickets AS t
ON t.event_id = t.id
LEFT OUTER JOIN seats AS s
ON s.id = t.seat_id
LEFT OUTER JOIN sections AS sec
ON s.section_id = sec.id
LEFT OUTER JOIN customers AS c
ON c.id = t.customer_id
;
```
LS solution:

```
SELECT events.name AS event,
       events.starts_at,
       sections.name AS section,
       seats.row,
       seats.number AS seat
  FROM tickets
  INNER JOIN events
    ON tickets.event_id = events.id
  INNER JOIN customers
    ON tickets.customer_id = customers.id
  INNER JOIN seats
    ON tickets.seat_id = seats.id
  INNER JOIN sections
    ON seats.section_id = sections.id
  WHERE customers.email = 'gennaro.rath@mcdermott.co';
```

The problem is, I don't know why my solution didn't work.


## [Using Foreign Keys](https://launchschool.com/lessons/5ae760fa/assignments/bb4f3ba2)

2. Update the orders table so that referential integrity will be preserved for the data between orders and products.   CORRECT

`ALTER TABLE orders ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id);`

3. & 4. My solution (which fit the criteria and is correct):   CORRECT
```
INSERT INTO products(name) VALUES 
('small bolt'),
('small bolt'),
('large bolt');

INSERT INTO orders(product_id, quantity) VALUES
(1, 10),
(1, 25),
(3, 15);

SELECT o.quantity, p.name AS product FROM orders AS o
INNER JOIN products AS p
ON o.product_id = p.id
;
```

LS solution:

```
foreign-keys=# INSERT INTO products (name) VALUES ('small bolt');
INSERT 0 1
foreign-keys=# INSERT INTO products (name) VALUES ('large bolt');
INSERT 0 1
foreign-keys=# SELECT * FROM products;
 id |    name
----+------------
  1 | small bolt
  2 | large bolt
(2 rows)

foreign-keys=# INSERT INTO orders (product_id, quantity) VALUES (1, 10);
INSERT 0 1
foreign-keys=# INSERT INTO orders (product_id, quantity) VALUES (1, 25);
INSERT 0 1
foreign-keys=# INSERT INTO orders (product_id, quantity) VALUES (2, 15);
INSERT 0 1

SELECT quantity, name FROM orders INNER JOIN products ON orders.product_id = products.id;
```

5. Yes, it is possible, but it shouldn't be:   CORRECT

`INSERT INTO orders(quantity) VALUES (10);`

6. CORRECT

```
ALTER TABLE orders
      ALTER COLUMN product_id
      SET NOT NULL;
```

causes this error message:

`ERROR:  column "product_id" of relation "orders" contains null values`

7. `DELETE FROM orders WHERE product_id IS NULL;`  CORRECT


8.  INCORRECT

LS solution:

```
CREATE TABLE reviews (
  id serial PRIMARY KEY,
  body text NOT NULL,
  product_id integer REFERENCES products (id)
);
```

9.
```
INSERT INTO  reviews(body, product_id) VALUES 
('a little small', 1), ('very round!', 2), ('could have been smaller', 3);

SELECT p.name AS product, r.body AS review FROM products AS p
INNER JOIN reviews AS r
ON p.id = r.product_id
;
```

10. False - CORRECT

## [One-to-Many Relationships](https://launchschool.com/lessons/5ae760fa/assignments/e94816bd)

- 'update anomaly'
- 'insertion anomaly'
- 'deletion anomaly'
- Normalization is the process of designing schema to avoid these anomalies.

- `SELECT * FROM calls, contacts;`

1. `INSERT INTO calls("when", duration, contact_id) VALUES 
('2016-01-18 14:47:00',	632, 6);`               CORRECT

2. 

```
SELECT c."when", c.duration, con.first_name, con.last_name, c.id  FROM calls AS c 
INNER JOIN contacts AS con
ON c.contact_id = con.id
WHERE c.contact_id != 6;
```

3. CORRECT
```
SELECT c."when", c.duration, con.first_name FROM calls AS c 
INNER JOIN contacts AS con
ON c.contact_id = con.id
WHERE c.contact_id != 6;
```

LS solution:
```
SELECT calls.when, calls.duration, contacts.first_name
FROM calls INNER JOIN contacts ON calls.contact_id = contacts.id
WHERE (contacts.first_name || ' ' || contacts.last_name) != 'William Swift';
```

3. 
```

INSERT INTO contacts(first_name, last_name, number) VALUES
('Merve',	'Elk', 6343511126), 
('Sawa',	'Fyodorov', 6125594874);


INSERT INTO calls("when",	duration, contact_id) VALUES 
('2016-01-17 11:52:00',	175, 27),
('2016-01-18 21:22:00',	79, 28);
```

4. I got it wrong - through rushing.

```
ALTER TABLE contacts 
ADD CONSTRAINT number_unique
UNIQUE (number);
```
5. CORRECT

`INSERT INTO contacts(first_name, last_name, number) VALUES ('Barry', 'Manilow', 6125594874);`

```
ERROR:  duplicate key value violates unique constraint "number_unique"
DETAIL:  Key (number)=(6125594874) already exists.
```

6. Because it is a reserved-word in SQL.

## [Extracting a 1:M Relationship From Existing Data](https://launchschool.com/lessons/5ae760fa/assignments/871779cc)



## [Assignment: SQL Fundamentals - DDL (Data Definition Language)](https://launchschool.com/lessons/5ae760fa/assignments/035424b7)

-[exercises](https://launchschool.com/exercise_sets/7d622479)

## [Assignment: SQL Fundamentals - DML (Data Manipulation Language)](https://launchschool.com/lessons/5ae760fa/assignments/6ca37b56)

- 

## [Many-to-Many Relationships](https://launchschool.com/lessons/5ae760fa/assignments/95ff0606)

1.  CORRECT
```
ALTER TABLE books_categories
DROP CONSTRAINT books_categories_book_id_fkey,
ADD CONSTRAINT books_categories_book_id_fkey
FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
ALTER COLUMN book_id SET NOT NULL;


ALTER TABLE books_categories
DROP CONSTRAINT books_categories_category_id_fkey,
ADD CONSTRAINT books_categories_category_id_fkey
FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE,
ALTER COLUMN category_id SET NOT NULL;
```

2. CORRECT
```
SELECT b.id, b.author, STRING_AGG(c.name, ', ') AS categories
FROM books AS b
JOIN books_categories AS bc
ON bc.book_id = b.id
JOIN categories AS c
ON bc.category_id = c.id
GROUP BY b.id
ORDER BY b.id
;
```

3. CORRECT

```
ALTER TABLE books
ALTER COLUMN title
TYPE varchar(100);

INSERT INTO books(author, title) VALUES
('Lynn Sherr',	'Sally Ride: America''s First Woman in Space'),
('Charlotte Brontë',	'Jane Eyre'),
('Meeru Dhalwala and Vikram Vij',	'Vij''s: Elegant and Inspired Indian Cuisine');


INSERT INTO categories(name) VALUES ('Space Exploration'), ('Cookbook'), ('South Asia');

INSERT INTO books_categories(book_id, category_id) VALUES
(4, 5), (4, 1), (4, 7),
(5, 2), (5, 4), 
(7, 8), (7, 1), (7, 9)
;
```

4. CORRECT

```
ALTER TABLE books_categories ADD CONSTRAINT books_id_categories_id_both_unique UNIQUE (book_id, category_id);
```

5. CORRECT
```
SELECT c.name, count(b.id) AS book_count, string_agg(b.title, ', ') AS book_titles 
FROM categories AS c
LEFT OUTER JOIN books_categories AS bc
ON c.id = bc.category_id
LEFT OUTER JOIN books AS b
ON b.id = bc.book_id
GROUP BY c.name
ORDER BY c.name
;
```

## [Converting a 1:M Relationship to a M:M Relationship](https://launchschool.com/lessons/5ae760fa/assignments/5c789742)

2. 
```
CREATE TABLE directors_films (
  id serial PRIMARY KEY,
  director_id integer REFERENCES directors (id) ON DELETE CASCADE,
  film_id integer REFERENCES films (id) ON DELETE CASCADE,
  UNIQUE(director_id, film_id)
);
```

3. 

```
INSERT INTO directors_films(director_id, film_id) VALUES
(1, 1), (2, 2), (3, 3), (4 ,4), (5, 5), (6, 6), (3, 7), (7, 8), (8, 9), (4, 10)
;
```

4. `ALTER TABLE films DROP COLUMN director_id ;`

5.

```
 SELECT f.title, d.name FROM films AS f
JOIN directors_films AS df
ON f.id = df.film_id
JOIN directors AS d
ON d.id = df.director_id
ORDER BY f.title
;
```

6. MOSTLY CORRECT (a few details off)
```
INSERT INTO films(title, year, genre, duration) VALUES
('Fargo', 1996, 'comedy', 98),
('No Country for Old Men',	2007,	'western',	122),
('Sin City',	2005,	'crime',	124),
('Spy Kids',	2001,	'scifi',	88);

INSERT INTO directors(name) VALUES
('Joel Coen'), ('Ethan Coen'), ('Frank Miller'), ('Robert Rodriguez');

INSERT INTO directors_films(director_id, film_id) VALUES
(9, 11), (9, 12), (10, 12), (11, 13), (12, 13), (12, 14);
```

7.
```
SELECT d.name, count(f.title) FROM films AS f
JOIN directors_films AS df
ON f.id = df.film_id
JOIN directors AS d
ON d.id = df.director_id
GROUP BY d.name
ORDER BY count(f.title) DESC, d.name
;
```

## [Assignment: SQL Fundamentals - Many to Many](https://launchschool.com/lessons/5ae760fa/assignments/74f45364)



## [Summary](https://launchschool.com/lessons/5ae760fa/assignments/b1cb2305)


## [Quiz Lesson 3](https://launchschool.com/quizzes/936f6956)

- First go: 8/9 (89%)
- Second go: 8/9(89%) - but a different wrong answer.
1. D
2. C
3. B, C, E, F.
4. B, D
5. C
6. B
7. A, B, D
8. C
- INCORRECT - it was A. Ascending names means A at the top, just as ascending numbers means 1 at the top and 20 at the bottom.
9. B, C

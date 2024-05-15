# [Schema, data and SQL](https://launchschool.com/lessons/a1779fd2/assignments)

## [What to Focus On](https://launchschool.com/lessons/a1779fd2/assignments/71713836)

- 

## [The SQL Language](https://launchschool.com/lessons/a1779fd2/assignments/7673d9a9)

- SQL is declarative. It says what it means.
- As with most languages the implementation of an SQL search query is hidden from the user. But if you know a little about it you can tweak for optimisaton.
- SQL is 3 sub-languages:
  - Data Definition Language: create and modify schema, ie
    - `CREATE TABLE`
    - `ALTER TABLE`
    - `ADD COLUMN`
  - Data Manipulation Language: retrieve and modify data, ie
    - `SELECT`
    - `INSERT`
    - `UPDATE`
    - `DELETE`
  - Data Control Language: controls the rights and "access roles" of the user. We don't go into this much on this course. Usually it just means being granted 'read-only' access and only being able to use `SELECT` statements.
 
### Syntax

- ` SELECT (1 + 4) * 6;`

### Practice problems:

1. Declarative.
   - Their answer: Special purpose language. The special purpose is interacting with relational databases.
2. DDL, DML, DCL.
3. 
```
'canoe'
'a long road' 
'weren''t'
'"No way!"'
```
4. ||
5. `lower('InPut')`
6. `t` `f`
7. `SELECT round((4 * 3.14159265359) * (26.3 * 26.3));` (8692)
  - Their answer: `SELECT trunc(4 * pi() * 26.3 ^ 2);`

[Assignment: SQL Fundamentals - DML, DDL, and DCL](https://launchschool.com/exercise_sets/eac14e3d)

1. The other 2 sublanguages are
- DDL, ie
  - CREATE TABLE
  - ALTER TABLE
- DML ie
  - INSERT
  - UPDATE

2. DML because it is selecting the information, but not changing it.
3. CREATE TABLE is DDL
4. DDL
5. DML
6. DML
7. None. Trick question.
8. DML
9. DDL
10. DDL

## [SQL Style Guide](https://launchschool.com/lessons/a1779fd2/assignments/dc780258)

- We don't bother with this here, but [here it is](https://www.sqlstyle.guide).

## [PostgreSQL Data Types](https://launchschool.com/lessons/a1779fd2/assignments/834815910)

- There are a whole bunch of data types, from moneys and geometric shapes, but we look at these guys:
  - varchar
  - text
  - integer
  - real
  - decimal
  - timestamp
  - date
  - boolean
 
### NULL

- When you ask SQL if NULL is NULL, it says, 'NULL', not 'true'
- That's why we have `IS NULL` and `IS NOT NULL`.

### Practice problems:

1. `text` is unlimited, where `varchar` takes an argument that limits how long it can be.
2. `integer` is a whole number, `decimal` takes an argument saying how precise it should be, `real` is like unlimited `decimal`
3. between -2147483648 and +2147483647.
4. `timestamp` = date and time, `date` is only date.
5. No, but you can with `timestamp with time zone` or `timestamptz`

## [Working with a Single Table](https://launchschool.com/lessons/a1779fd2/assignments/4f4df8a4)

1.
```
CREATE TABLE people (
  name varchar(50),
  age integer,
  occupation varchar(50)
);

2.

INSERT INTO people (name, age, occupation) VALUES 
('Abby', 34, 'biologist'), 
('Mu''nisah', 26, NULL), 
('Mirabelle', 40, 'contractor');
```

3.

```
SELECT * FROM people WHERE occupation IS NULL;
SELECT * FROM people WHERE age < 27;
SELECT name, age, occupation FROM people WHERE name LIKE '%sah%';
```

4.

```
CREATE TABLE birds (
  name varchar(50),
  length decimal(3,1),
  wingspan decimal(3,1),
  family varchar(30)
  extinct boolean
);
```

5.
```
INSERT INTO birds VALUES 
('Spotted Towhee',	21.6,	26.7,	'Emberizidae',	false),
('American Robin',	25.5,	36.0,	'Turdidae',	false),
('Greater Koa Finch',	19.0,	24.0,	'Fringillidae',	true),
('Carolina Parakeet',	33.0,	55.8,	'Psittacidae',	true),
('Common Kestrel', 35.5, 73.5, 'Falconidae', false);
```
6.
```
SELECT name, family FROM birds WHERE extinct = false ORDER BY length DESC;
```

7.
```
SELECT avg(wingspan), min(wingspan), max(wingspan) FROM birds;
```
8.
```
CREATE TABLE menu_items (
  item varchar(50),
  prep_time integer,
  ingredient_cost decimal(3,2),
  sales integer,
  menu_price decimal(4,2)
);
```

9.
```
INSERT INTO menu_items VALUES 
('omelette',	10,	1.50,	182,	7.99),
('tacos',	5,	2.00,	254,	8.99),
('oatmeal',	1,	0.50,	79,	5.99);
```

10. I peaked
```
SELECT item, menu_price - ingredient_cost AS profit FROM menu_items ORDER BY profit DESC LIMIT 1;
```

11.
```
SELECT item, menu_price, ingredient_cost, 
round((13.00/60 * prep_time),2) AS labor, 
round((menu_price - ingredient_cost) - (13.00/60 * prep_time), 2) AS profit
FROM menu_items ORDER BY profit DESC;
```

[Loading Database Dumps](https://launchschool.com/lessons/a1779fd2/assignments/fa05a889)

1.
- The file deletes any existing `film` table, then creates one and adds three entries.
- The output looks like this:
```
NOTICE:  table "films" does not exist, skipping
DROP TABLE
CREATE TABLE
INSERT 0 1
INSERT 0 1
INSERT 0 1
```
2. `SELECT * FROM films;`
3. 'SELECT * FROM films WHERE length(title) > 12;'
4. 
```
ALTER TABLE films ADD COLUMN director varchar(255);
ALTER TABLE films ADD COLUMN duration integer;
```

5. 
```
UPDATE films SET director = 'John McTiernan', duration = 132 WHERE title = 'Die Hard';
UPDATE films SET director = 'Michael Curtiz', duration = 102 WHERE title = 'Casablanca';
UPDATE films SET director = 'Francis Ford Coppola', duration = 113 WHERE title = 'The Conversation';
```

6. 
```
INSERT INTO films(title, year, genre, director, duration) VALUES 
('1984', 1956,	'scifi',	'Michael Anderson',	90),
('Tinker Tailor Soldier Spy',	2011,	'espionage',	'Tomas Alfredson',	127),
('The Birdcage',	1996,	'comedy',	'Mike Nichols',	118);
```

7.
```
SELECT title, 2023 - year AS age FROM films ORDER BY age ASC;
```

8.
```
SELECT title, duration FROM films WHERE duration > 120 ORDER BY duration DESC;
```

9. `SELECT title FROM films ORDER BY duration DESC LIMIT 1;`

## [More Single Table Queries](https://launchschool.com/lessons/a1779fd2/assignments/e5d34504)

1. `createdb residents`
2. `psql -d residents < residents_with_data.sql`
3. `SELECT state, COUNT(id) FROM people GROUP BY state ORDER BY count DESC LIMIT 10;`  (I peaked)
4.   (I peaked)

```
SELECT substr(email, strpos(email, '@') + 1) as domain,
         COUNT(id)
  FROM people
  GROUP BY domain
  ORDER BY count DESC;
```

5. `DELETE FROM people WHERE id = 3399;`
6. 'DELETE FROM people WHERE state = 'CA';'
7. `UPDATE people SET given_name = UPPER(given_name) WHERE email LIKE '%teleworm.us';`
8. `DELETE FROM people;`


## [NOT NULL and Default Values](https://launchschool.com/lessons/a1779fd2/assignments/c6a5a6cb)

- The precision with which you store your data decides how powerful your database is.
- This page describes how adding an employee with 2 fields empty confuses sorting and selecting functions.
- We solve the problem by setting these fields to `NOT NULL`. ALso with `DEFAULT` entries.

### Practice problems

1. Using an operator on NULL returns NULL.

2.
```
ALTER TABLE employees ALTER COLUMN department SET DEFAULT 'unassigned';
UPDATE employees SET department = 'unassigned' WHERE department IS NULL;
ALTER TABLE employees ALTER COLUMN department SET NOT NULL;
```

3.
```
CREATE TABLE temperatures(
  date timestamp NOT NULL,
  low integer NOT NULL,
  high integer NOT NULL);
```

4.

```
SELECT date, ROUND((high + low) / 2.0, 1) as average
  FROM temperatures
 WHERE date BETWEEN '2016-03-02' AND '2016-03-08';
```

5. 
```
SELECT date, ROUND((high + low) / 2.0, 1) as average
  FROM temperatures
 WHERE date BETWEEN '2016-03-02' AND '2016-03-08';
```

6. `ALTER TABLE temperatures ADD COLUMN rainfall integer DEFAULT 0;` 

7. `UPDATE temperatures SET rainfall = (round((low + high)/2, 1) - 35) WHERE (round((low + high)/2, 1) - 35) > 0;`

8.
```
ALTER TABLE temperatures ALTER COLUMN rainfall TYPE decimal(6,4);
UPDATE temperatures SET rainfall = rainfall/25.4;
```

9. `\d weather`

10. `pg-dump -d sql-course -t weather --inserts > dump.sql`

## [More Constraints](https://launchschool.com/lessons/a1779fd2/assignments/f5b732e5)

1. `psql -d residents < films2.sql`
2. 
```
ALTER TABLE films ALTER COLUMN title SET NOT NULL;
ALTER TABLE films ALTER COLUMN year SET NOT NULL;
ALTER TABLE films ALTER COLUMN genre SET NOT NULL;
ALTER TABLE films ALTER COLUMN director SET NOT NULL;
ALTER TABLE films ALTER COLUMN duration SET NOT NULL;
```
3. Nullable column is filled with 'not null' value.
4. `ALTER TABLE films ADD CONSTRAINT title_unique UNIQUE (title);` (i peaked)
5. `Indexes:
    "title_unique" UNIQUE CONSTRAINT, btree (title)`
6.`ALTER TABLE films DROP CONSTRAINT title_unique;`
7. `ALTER TABLE films ADD CONSTRAINT title_length CHECK (length(title) >= 1);`  I peaked
8. `INSERT INTO films VALUES ('', 1, 'ho', 'ho', 1);`
9. `Check constraints:
    "title_length" CHECK (length(title::text) >= 1)`
10. `ALTER TABLE films DROP CONSTRAINT title_length;`
11. `ALTER TABLE films ADD CONSTRAINT year_range CHECK (year BETWEEN 1900 AND 2100);`  I peaked
12. `Check constraints:
    "year_range" CHECK (year >= 1900 AND year <= 2100)`
13. ` ALTER TABLE films ADD CONSTRAINT director_name
    CHECK (length(director) >= 3 AND position(' ' in director) > 0);` I peaked.
14. `"director_name" CHECK (length(director::text) >= 3 AND POSITION((' '::text) IN (director)) > 0)`.
15. 
```
UPDATE films SET director = 'Johnny' WHERE title = 'Die Hard';
ERROR:  new row for relation "films" violates check constraint "director_name"
DETAIL:  Failing row contains (Die Hard, 1988, action, Johnny, 132).
```
16. 
- Data type (including length limitation)
- NOT NULL constraint
- Check constraint.
17. I peaked ( I ned a nap)
18. `\d tablename`

## [Using Keys](https://launchschool.com/lessons/a1779fd2/assignments/00e428da)

- The problem that is solved by using keys is that rows of data can be identical, while representing different real-world objects.

### Natural Keys

- ie. using a value that exists already in the data set as a unique identifier. The problem here is that very few things are truly unique. Even SSNs are not universal.

### Surrogate Keys: 

- most commonly an auto-incrementing number, ie `serial`.

#### Sequences

```
-- This statement:
CREATE TABLE colors (id serial, name text);

-- is actually interpreted as if it were this one:
CREATE SEQUENCE colors_id_seq;
CREATE TABLE colors (
    id integer NOT NULL DEFAULT nextval('colors_id_seq'),
    name text
);
```

- [Documentation](https://www.postgresql.org/docs/9.5/sql-createsequence.html)

### Enforcing uniqueness

### Primary keys:


General rules:

1. All tables should have a primary key column called id.
2. The id column should automatically be set to a unique value as new rows are inserted into the table.
3. The id column will often be an integer, but there are other data types (such as UUIDs) that can provide specific benefits.

##### UUIDs

- just really long id numbers. They don't increment.

### Practice problems

1. `CREATE SEQUENCE counter;`
2. `SELECT nextval('counter');`
3. `DROP SEQUENCE counter;`
4. yes: `CREATE SEQUENCE even_counter INCREMENT BY 2 MINVALUE 2;`, `SELECT nextval('even_counter');`.
5. `regions_id_seq` (peaked)
6. Write a SQL statement to add an auto-incrementing integer primary key column to the films table.
`ALTER TABLE films ADD COLUMN id serial PRIMARY KEY;`
or
`CREATE SEQUENCE films_id_seq;`
`ALTER TABLE films ADD COLUMN integer NOT NULL DEFAULT nextval('films_id_seq') PRIMARY KEY;`
7. `ERROR:  duplicate key value violates unique constraint "id_unique"
DETAIL:  Key (id)=(3) already exists.`
8. `ERROR:  multiple primary keys for table "films" are not allowed`
9. `ALTER TABLE films DROP CONSTRAINT films_pkey;`



## [GROUP BY and Aggregate Functions](https://launchschool.com/lessons/a1779fd2/assignments/2e9b453b)

2. 
```
INSERT INTO films(title, year, genre, director, duration)  VALUES
('Wayne''s World',	1992,	'comedy',	'Penelope Spheeris',	95),
('Bourne Identity',	2002,	'espionage',	'Doug Liman',	118);
```

3. `SELECT DISTINCT genre FROM films ;`
4. `SELECT genre FROM films GROUP BY genre;`
5. `SELECT round(avg(duration)) FROM films;`
6. `SELECT genre, round(avg(duration)) FROM films GROUP BY genre;`
7. My solution (half the results are off):
`SELECT round(year, -1) AS decade, round(avg(duration)) AS duration FROM films GROUP BY decade ORDER BY decade;`
LS solution:
`SELECT year / 10 * 10 as decade, ROUND(AVG(duration)) as average_duration
  FROM films GROUP BY decade ORDER BY decade;`
8. `SELECT * FROM films WHERE director ILIKE 'john%';`
9. `SELECT genre, count(genre) AS count FROM films GROUP BY genre ORDER BY count DESC;`
10. `SELECT genre, sum(duration) AS total_duration FROM films GROUP BY genre ORDER BY total_duration;` - this misses a sub-sorting of genre
LS: `SELECT genre, sum(duration) AS total_duration
  FROM films GROUP BY genre ORDER BY total_duration, genre ASC;`

## [How PostgreSQL Executes Queries](https://launchschool.com/lessons/a1779fd2/assignments/f4b7a9dc)



## [Table and Column Aliases](https://launchschool.com/lessons/a1779fd2/assignments/d4825863)

- video

## [Summary](https://launchschool.com/lessons/a1779fd2/assignments/3967e2b2)	

-

## [Quiz Lesson 2](https://launchschool.com/quizzes/c393ad07)

- First go = 80% (8/10)
- Second go (27.11.23) = 90% (9/10)
1. B, D. CORRECT
2. A, D  CORRECT
3. A, D, G.  CORRECT
4. B  CORRECT
5. B, C, D  CORRECT
6. A, D, F.
- Not A, `NULL` is not 'not true'
7. A  CORRECT
8. B  CORRECT
9. A, B  CORRECT
10. B,  CORRECT

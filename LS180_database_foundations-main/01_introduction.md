# [Introduction to the Course](https://launchschool.com/lessons/234afac4/assignments)

## [Welcome](https://launchschool.com/lessons/234afac4/assignments/8c69fd57)

- Set up Postgresql
- Read SQL book
- Read PostgresQL documentation

## [What this Course Covers](https://launchschool.com/lessons/234afac4/assignments/873ccdc3)

- How to think about data in a relational way.
- You needn't master every point, but take them as points to further practice.

## [Setting Up Cloud Development Environments](https://launchschool.com/lessons/234afac4/assignments/1e12a2f9)

- Skip

## [Read the Launch School SQL Book](https://launchschool.com/lessons/234afac4/assignments/113b986c)

- I have read this. I feel confident with all of this except 'Working with multiple tables'.
- I'll have a second go through here:

### [Normalization](https://launchschool.com/books/sql/read/table_relationships#normalization)

- The process of splitting up data across multiple tables and creating relations between them in order to reduce duplication and improve data integrity.
- The rules by which a database is judged to be 'normalized' are known as 'normal-forms' and are not dealt with here.
- We normalize for 2 reasons:
  - To reduce data redundancy
  - To improve data-integrity
- We normalize in 2 ways:
  - Arranging data in multiple tables
  - Defining relationships between them.

### [Keys](https://launchschool.com/books/sql/read/table_relationships#keys)

- A special kind of constraint used to establish the relationships and uniqueness.
- They can be used:
    - to identify a specific row in the current table
    - to refer to a specific row in another table.
 
#### Primary Keys

- A primary key is a unique identifier for a row of data. This data must be unique and not null.
- This is often `id`.
- Primary keys only work with foreign keys.

#### Foreign keys

- We establish a foreign key as referencing a primary key. This links rows in different tables:

```
FOREIGN KEY (fk_col_name)
REFERENCES target_table_name (pk_col_name);
```

- By setting up such a relationship we make sure that a value can't exist if its partner doesn't exist. So you can't have a book without a writer, or an egg without a mother.
- You can have these the other way around. (mother without egg, primary key table without foreign key table).

- It can be useful to write out these relationships in the design phase:
  - A user can only have one address. An address can only have one user.
  - A review can only be about one book. A book can have many reviews.

### [Referencial integrity](https://launchschool.com/books/sql/read/table_relationships#referentialintegrity)

- Table relationships must always be consistent. A one to one relationship forces this to be so, because for example, you can't give a child multiple birth-mothers.
- 'ON DELETE CASCADE` is used to ensure this.

### [One to Many](https://launchschool.com/books/sql/read/table_relationships#onetomany)

```
CREATE TABLE books (
  id serial,
  title varchar(100) NOT NULL,
  author varchar(100) NOT NULL,
  published_date timestamp NOT NULL,
  isbn char(12),
  PRIMARY KEY (id),
  UNIQUE (isbn)
);

/*
 one-to-many: Book has many reviews
*/

CREATE TABLE reviews (
  id serial,
  book_id integer NOT NULL,
  reviewer_name varchar(255),
  content varchar(255),
  rating integer,
  published_date timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (book_id)
      REFERENCES books(id)
      ON DELETE CASCADE
);
```

### [Many to many](https://launchschool.com/books/sql/read/table_relationships#manytomany)

- Requires a join table to have 2 one to many relationships.
- Join tables have 2 foreign keys, each referencing a different primary key.
- 

### [Database design](https://launchschool.com/books/sql/read/table_relationships#databasedesign)

- To design a database we need to zoom-out and think abstractly about the real world **entities** and the **relationships** between them.
- Entitites are the nouns. They can be stored in multiple tables.
- Examples of entities in the SQL_book app:
  - a user
  - a book
  - checkouts
  - reviews
  - addresses
- Relationships
  - 3 types:
    - 1 to 1
    - 1 to many
    - many to many
  - 

### [SQL joins](https://launchschool.com/books/sql/read/joins#joinsyntax)

- For queries across multiple tables.
- Ok this makes sense now.

### [Types of joins](https://launchschool.com/books/sql/read/joins#typesofjoins)

- `INNER` is the default type of join. It returns the common rows of the two tables. By looking at the Primary and Foreign keys of the 2 tables. Rows which exist in only one table are left out.
- `LEFT` (AKA left outer) takes everything from the left (even if there's no relation for that row with the other table) and chooses what coems from the right based on a condition. So there will be lots of `NULLS` where the data doesn't match.
- `RIGHT` - As above, but it's the right table with the nulls and the left table is full.
- `FULL` - like a right and left at the same time. Where the jopin condition is met the rows match otherwise, nulls.
- `CROSS JOIN` - has no condition. Just returns all combinations. These are fairly useless and rarely encountered.

#### [Multiple jpoins](https://launchschool.com/books/sql/read/joins#multiplejoins)

- joining more than one table together. Postgresql creates transient tables from each join clause in order to refine the result.

### [Aliasing](https://launchschool.com/books/sql/read/joins#aliasing)

- eg
```
SELECT u.full_name, b.title, c.checkout_date
       FROM users AS u
       INNER JOIN checkouts AS c
           ON u.id = c.user_id
       INNER JOIN books AS b
           ON b.id = c.book_id;
```

- you can even leave out the `AS`
- Also for columns.

### [Subqueries](https://launchschool.com/books/sql/read/joins#subqueries)

- Another way of getting the results better achieved with join tables.

## [Reading PostgreSQL Documentation](https://launchschool.com/lessons/234afac4/assignments/5aafff3f)

- `www.postgresql.org`
- documentation
- version that matches yours
- Search bar
- within square brackets = optional
- within curly braces = one in necessary.
- 'from item' is a list lower down where options are listed.
- Yes you can find solutions elsewhere, but it's generally good to become comfortable with the documentation.

## [The PostgreSQL Command Line Interface](https://launchschool.com/lessons/234afac4/assignments/bc529bcf)

- `$ psql -d sql_book` (The `-d` can be left out if the first argument is the db name).
- `sequencing` ?
- `\l` for listing dbs.
- `\?`  shows commands
- `\h` help

## [Assignment: SQL Fundamentals - Easy 1](https://launchschool.com/lessons/234afac4/assignments/20d963df)

- done

## [Quiz Lesson 1](https://launchschool.com/lessons/234afac4/assignments/cada07f4)

- 10/15 on 6.11.23
- 2nd attempt 27.11.23 11/15 (73%)
1.  D. Correct
2.  C. Correct
3.  B, D. Correct
4.  A, B, C. Correct
5.  B, D.
- WRONG - also A, and C. In A: I read too fast and missed the final NOT NULL alteration. I'm not sure how I missed C.
6.  C, D Correct
7.  A, C, E. 
- WRONG, missed F. Remove a column is also `alter table`.
8.  D. Correct
9.  A, D. Correct
10.  A
- Wrong: I missed the primary key constraint at the bottom of the table.
11.  A, D Correct
12.  A, B, D Correct
13.  C Correct
14.  B Correct
15.  D
- WRONG , also B. It is a Left outer join because it will show all rows from `pet_owners` plus any matching rows from `pets`. This means the left table can have multiples and the right can have NULLs.


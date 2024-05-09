=begin

When we initially created our birds table, we forgot to take into account a key factor: preventing certain values from being entered into the database. For instance, we would never find a bird that is negative n years old. We could have included a constraint to ensure that bad data isn't entered for a database record, but we forgot to do so.

For this exercise, write some code that ensures that only birds with a positive age may be added to the database. Then write and execute an SQL statement to check that this new constraint works correctly.

=end

ALTER TABLE birds ADD CONSTRAINT check_age CHECK (age > 0);

INSERT INTO birds (age, name, species) VALUES (-2, 'Alan', 'Blue Jay');

=begin

Feedback:

I think this section needs to explain exactly what the syntax is for adding constraints. As it is, it does not tell me how practically to add a constraint.

`To add any other constraint to an existing table, you must use this syntax to add a table constraint:

```
ALTER TABLE table_name
      ADD [ CONSTRAINT constraint_name ]
      constraint_clause;
```
The brackets around constraint_name indicate that the name is optional.`

- The brackets are not just around constraint_name, they are around 'CONSTRAINT' also. Are they both optional?
- What is the syntax for a constraint_clause? No examples are given in the book. The section [Keys and constraints](https://launchschool.com/books/sql/read/create_table#keysandconstraints) says it will go into more detail later on, but I can't see it. Specifically I am struggling to find and example which will help me complete the [adding a constraint](https://launchschool.com/exercises/d176489a) exercise.

Many thanks

=end
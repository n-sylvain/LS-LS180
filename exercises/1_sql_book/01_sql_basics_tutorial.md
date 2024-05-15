![alt text](image.png)

SELECT:
```sql
SELECT side FROM orders; -- Selecting one column
SELECT drink, side FROM orders; -- Selecting two or more column
SELECT * FROM orders WHERE id = 1; -- Selecting rows
SELECT customer_name FROM orders WHERE side = 'Fries'; -- Selecting columns and rows
```

EXERCISES:
```sql
-- Write a query that returns all of the customer names from the orders table.
SELECT customer_name FROM orders;

-- Write a query that returns all of the orders that include a Chocolate Shake.
SELECT * FROM orders WHERE drink = 'Chocolate Shake';

--Write a query that returns the burger, side, and drink for the order with an id of 2.
SELECT burger, side, drink FROM orders WHERE id = 2;

--Write a query that returns the name of anyone who ordered Onion Rings.
SELECT customer_name FROM orders WHERE side = 'Onion Rings';
```


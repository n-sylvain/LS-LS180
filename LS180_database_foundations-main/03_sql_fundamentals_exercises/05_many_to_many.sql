-- 1 Missed a few details, but 99% there

createdb billing;
psql -d billing

CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token varchar(8) CHECK (payment_token = UPPER(payment_token))
);

CREATE TABLE services (
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric(10, 2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE customers_services (
  id serial PRIMARY KEY,
  customer_id integer REFERENCES customers (id) ON DELETE CASCADE,
  service_id integer REFERENCES services (id),
  UNIQUE(customer_id, service_id)
);

INSERT INTO customers(name, payment_token) VALUES
('Pat Johnson', 'XHGOAHEQ'), ('Nancy Monreal', 'JKWQPJKL'), ('Lynn Blake', 'KLZXWEEE'), ('Chen Ke-Hua', 'KWETYCVX'),
 ('Scott Lakso', 'UUEAPQPS'), ('Jim Pornot', 'XKJEYAZA');

 INSERT INTO services(description, price) VALUES
 ('Unix Hosting', 5.95), ('DNS', 4.95), ('Whois Registration', 1.95), ('High Bandwidth', 15.00), ('Business Support', 250.00), ('Dedicated Hosting', 50.00), ('Bulk Email', 250.00), ('One-to-one Training', 999.00);

INSERT INTO customers_services(customer_id, service_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, NULL),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(4, 1),
(4, 4),
(5, 1),
(5, 2),
(5, 6),
(6, 1),
(6, 6),
(6, 7)
;

-- 2 Write a query to retrieve the customer data for every customer who currently subscribes to at least one service.

SELECT c.name, c.payment_token, STRING_AGG(s.description, ', ') AS services FROM customers AS c
LEFT OUTER JOIN customers_services AS cs
ON c.id = cs.customer_id
LEFT OUTER JOIN services AS s
ON s.id = cs.service_id
WHERE s.id IS NOT NULL
GROUP BY c.id
;

-- LS solution:

SELECT DISTINCT customers.* FROM customers
INNER JOIN customers_services
        ON customer_id = customers.id;

-- 3. Write a query to retrieve the customer data for every customer who does not currently subscribe to any services.

SELECT *
FROM customers AS c
WHERE NOT EXISTS (
    SELECT *
    FROM customers_services AS cs
    WHERE c.id = cs.customer_id
);

-- LS solution:

SELECT customers.* FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
WHERE service_id IS NULL;

-- FURTHER EXPLORATION

SELECT c.*, s.* FROM customers AS c
FULL JOIN customers_services AS cs
             ON cs.customer_id = c.id
FULL JOIN services AS s
             ON s.id = cs.service_id
             WHERE cs.service_id IS NULL
             OR cs.customer_id IS NULL
;

-- Using RIGHT OUTER JOIN, write a query to display a list of all services that are not currently in use.

SELECT DISTINCT s.description, cs.customer_id FROM customers_services AS cs
RIGHT OUTER JOIN services AS s
ON s.id = cs.service_id
WHERE cs.customer_id IS NULL;

-- Write a query to display a list of all customer names together with a comma-separated list of the services they use.

SELECT c.name, STRING_AGG(s.description, ', ') AS services FROM customers AS c
LEFT OUTER JOIN customers_services AS cs
ON c.id = cs.customer_id
LEFT OUTER JOIN services AS s
ON s.id = cs.service_id
GROUP BY c.id
;
-- FURTHER EXPLORATION:

SELECT customers.name,
       lag(customers.name)
         OVER (ORDER BY customers.name)
         AS previous,
       services.description
FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = service_id;
             
-- 5. Write a query that displays the description for every service that is subscribed to by at least 3 customers. Include the customer count for each description in the report.

SELECT s.description, count(cs.customer_id) AS count FROM services AS s
LEFT OUTER JOIN customers_services AS cs
ON s.id = cs.service_id
GROUP BY
s.id
HAVING
count(cs.customer_id) >= 3;
;

-- 6. Assuming that everybody in our database has a bill coming due, and that all of them will pay on time, write a query to compute the total gross income we expect to receive.

SELECT sum(s.price) FROM customers AS c
JOIN customers_services AS cs
ON c.id = cs.customer_id
JOIN services AS s
ON s.id = cs.service_id
;

-- 7 A new customer, 'John Doe', has signed up with our company. His payment token is 'EYODHLCN'. Initially, he has signed up for UNIX hosting, DNS, and Whois Registration. Create any SQL statement(s) needed to add this record to the database.

INSERT INTO customers(name, payment_token) VALUES 
('John Doe', 'EYODHLCN');
-- 7
INSERT INTO customers_services(customer_id, service_id) VALUES
(7, 1), (7, 2), (7, 3);

-- 8

SELECT sum(s.price) FROM customers AS c
JOIN customers_services AS cs
ON c.id = cs.customer_id
JOIN services AS s
ON s.id = cs.service_id
GROUP BY
s.price
HAVING
s.price > 100;
;

SELECT  count(c.id) * sum(s.price) AS sum FROM customers AS c
LEFT OUTER JOIN customers_services AS cs
ON c.id = cs.customer_id
FULL JOIN services AS s
ON s.id = cs.service_id
GROUP BY s.price
HAVING s.price > 100;

SELECT count(c.id) FROM customers AS c; -- there are 7 customers
SELECT sum(price) FROM services WHERE price > 100; -- 1499.00

-- LS solution

SELECT SUM(price)
FROM services
INNER JOIN customers_services
        ON services.id = service_id
WHERE price > 100;

SELECT SUM(price)
FROM customers
CROSS JOIN services
WHERE price > 100;

-- 9 Write the necessary SQL statements to delete the "Bulk Email" service and customer "Chen Ke-Hua" from the database.

DELETE FROM customers WHERE name LIKE 'Chen Ke-Hua';
DELETE FROM customers_services WHERE service_id = 7;
DELETE FROM services WHERE description LIKE 'Bulk Email';


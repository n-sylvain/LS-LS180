-- https://launchschool.com/exercise_sets/1be8559d

--1 

createdb auction
psql auction

CREATE TABLE bidders (
  id serial PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE items (
  id serial PRIMARY KEY,
  name text NOT NULL,
  initial_price numeric(6,2) NOT NULL,
  sales_price numeric(6,2));

CREATE TABLE bids (
  id serial PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount numeric(6,2) NOT NULL);

CREATE INDEX ON bids (bidder_id, item_id);

COPY FROM bidders.csv to id.bidders, name.bidders;

-- LS solution:

CREATE TABLE bidders (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  initial_price DECIMAL(6,2) NOT NULL CHECK(initial_price BETWEEN 0.01 AND 1000.00),
  sales_price DECIMAL(6,2) CHECK(sales_price BETWEEN 0.01 AND 1000.00)
);

CREATE TABLE bids (
  id SERIAL PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount DECIMAL(6,2) NOT NULL CHECK(amount BETWEEN 0.01 AND 1000.00)
);

CREATE INDEX ON bids (bidder_id, item_id);

\copy bidders FROM 'bidders.csv' WITH HEADER CSV
\copy items FROM 'items.csv' WITH HEADER CSV
\copy bids FROM 'bids.csv' WITH HEADER CSV

-- 2 

SELECT items.name AS "Bid on Item" FROM items WHERE id IN
  (SELECT item_id FROM bids);

-- 3

SELECT items.name AS "Not Bid On" FROM items WHERE id NOT IN
(SELECT item_id FROM bids);

-- 4

SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

SELECT DISTINCT b.name FROM bidders AS b
JOIN bids
ON b.id = bids.bidder_id
;

-- 5 (peaked)

-- works, but doesn't follow instructions:

SELECT DISTINCT count(bids.bidder_id) FROM bids
GROUP BY bids.bidder_id
LIMIT 1;

-- LS solution: 

SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;
 
-- 6

SELECT name, (SELECT COUNT(bids.item_id) FROM bids WHERE bids.item_id = items.id) FROM items;

-- 7 (peaked)

SELECT id FROM items WHERE ROW('Painting', 100.00, 250.00) = ROW(name, initial_price, sales_price);

-- 8

EXPLAIN SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

                         QUERY PLAN  
--------------------------------------------------------------------------
 Hash Join  (cost=33.38..66.47 rows=635 width=32)
   Hash Cond: (bidders.id = bids.bidder_id)
   ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36)
   ->  Hash  (cost=30.88..30.88 rows=200 width=4)
         ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4)
               Group Key: bids.bidder_id
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4)
(7 rows)

                                                     QUERY PLAN                                 
                     
------------------------------------------------------------------------------------------------
---------------------
 Hash Join  (cost=33.38..66.47 rows=635 width=32) (actual time=0.108..0.113 rows=6 loops=1)
   Hash Cond: (bidders.id = bids.bidder_id)
   ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36) (actual time=0.030..0.031 rows
=7 loops=1)
   ->  Hash  (cost=30.88..30.88 rows=200 width=4) (actual time=0.051..0.052 rows=6 loops=1)
         Buckets: 1024  Batches: 1  Memory Usage: 9kB
         ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4) (actual time=0.033..0.035 rows=
6 loops=1)
               Group Key: bids.bidder_id
               Batches: 1  Memory Usage: 40kB
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.017..0.
021 rows=26 loops=1)
 Planning Time: 0.252 ms
 Execution Time: 0.207 ms
(11 rows)

EXPLAIN SELECT name FROM bidders;

                         QUERY PLAN                         
------------------------------------------------------------
 Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=32)
(1 row)

EXPLAIN ANALYSE SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);


-- ANALYZE adds:
  -- (actual time=0.033..0.035 rows=6 loops=1) for each operation.
  -- Buckets: 1024  Batches: 1  Memory Usage: 9kB
  -- Batches: 1  Memory Usage: 40kB
  -- Planning Time: 0.252 ms
  -- Execution Time: 0.207 ms

-- 9

 EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

  -- planning time:  0.106 ms
  -- execution time: 0.087 ms
  -- total time
  -- total costs

 EXPLAIN ANALYZE  SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;

  -- planning time:  0.133 ms
  -- execution time: 0.066 ms
  -- total time
  -- total costs

  -- The 2nd statment is quicker by 0.006 ms
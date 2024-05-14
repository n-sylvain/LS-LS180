--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12 (Homebrew)
-- Dumped by pg_dump version 14.12 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    customer_name character varying(100)
);


ALTER TABLE public.customers OWNER TO "sylvain.ni";

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO "sylvain.ni";

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: email_addresses; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.email_addresses (
    customer_id integer NOT NULL,
    customer_email character varying(50)
);


ALTER TABLE public.email_addresses OWNER TO "sylvain.ni";

--
-- Name: order_items; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.order_items OWNER TO "sylvain.ni";

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_items_id_seq OWNER TO "sylvain.ni";

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    customer_id integer,
    order_status character varying(20)
);


ALTER TABLE public.orders OWNER TO "sylvain.ni";

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO "sylvain.ni";

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.products (
    id integer NOT NULL,
    product_name character varying(50),
    product_cost numeric(4,2) DEFAULT 0,
    product_type character varying(20),
    product_loyalty_points integer
);


ALTER TABLE public.products OWNER TO "sylvain.ni";

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO "sylvain.ni";

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.customers (id, customer_name) FROM stdin;
1	James Bergman
2	Natasha O'Shea
3	Aaron Muller
\.


--
-- Data for Name: email_addresses; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.email_addresses (customer_id, customer_email) FROM stdin;
1	james1998@email.com
2	natasha@osheafamily.com
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.order_items (id, order_id, product_id) FROM stdin;
1	1	3
2	1	5
3	1	6
4	1	8
5	2	2
6	2	5
7	2	7
8	3	4
9	3	2
10	3	5
11	3	5
12	3	6
13	3	10
14	3	9
15	4	1
16	4	5
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.orders (id, customer_id, order_status) FROM stdin;
1	1	In Progress
2	2	Placed
3	2	Complete
4	3	Placed
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.products (id, product_name, product_cost, product_type, product_loyalty_points) FROM stdin;
1	LS Burger	3.00	Burger	10
2	LS Cheeseburger	3.50	Burger	15
3	LS Chicken Burger	4.50	Burger	20
4	LS Double Deluxe Burger	6.00	Burger	30
5	Fries	1.20	Side	3
6	Onion Rings	1.50	Side	5
7	Cola	1.50	Drink	5
8	Lemonade	1.50	Drink	5
9	Vanilla Shake	2.00	Drink	7
10	Chocolate Shake	2.00	Drink	7
11	Strawberry Shake	2.00	Drink	7
\.


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.customers_id_seq', 3, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.order_items_id_seq', 16, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.orders_id_seq', 4, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.products_id_seq', 11, true);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: email_addresses email_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.email_addresses
    ADD CONSTRAINT email_addresses_pkey PRIMARY KEY (customer_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: email_addresses email_addresses_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.email_addresses
    ADD CONSTRAINT email_addresses_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


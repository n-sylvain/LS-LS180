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
-- Name: addresses; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.addresses (
    user_id integer NOT NULL,
    street character varying(30) NOT NULL,
    city character varying(30) NOT NULL,
    state character varying(30) NOT NULL
);


ALTER TABLE public.addresses OWNER TO "sylvain.ni";

--
-- Name: books; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.books (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    author character varying(100) NOT NULL,
    published_date timestamp without time zone NOT NULL,
    isbn character(12)
);


ALTER TABLE public.books OWNER TO "sylvain.ni";

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_id_seq OWNER TO "sylvain.ni";

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- Name: checkouts; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.checkouts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    book_id integer NOT NULL,
    checkout_date timestamp without time zone,
    return_date timestamp without time zone
);


ALTER TABLE public.checkouts OWNER TO "sylvain.ni";

--
-- Name: checkouts_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.checkouts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.checkouts_id_seq OWNER TO "sylvain.ni";

--
-- Name: checkouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.checkouts_id_seq OWNED BY public.checkouts.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    book_id integer NOT NULL,
    reviewer_name character varying(255),
    content character varying(255),
    rating integer,
    published_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.reviews OWNER TO "sylvain.ni";

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_id_seq OWNER TO "sylvain.ni";

--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.users (
    id integer NOT NULL,
    full_name character varying(25) NOT NULL,
    enabled boolean DEFAULT true,
    last_login timestamp without time zone DEFAULT now(),
    CONSTRAINT users_full_name_check CHECK (((full_name)::text <> ''::text))
);


ALTER TABLE public.users OWNER TO "sylvain.ni";

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO "sylvain.ni";

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: books id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- Name: checkouts id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.checkouts ALTER COLUMN id SET DEFAULT nextval('public.checkouts_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.addresses (user_id, street, city, state) FROM stdin;
1	1 Market Street	San Francisco	CA
2	2 Elm Street	San Francisco	CA
3	3 Main Street	Boston	MA
\.


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.books (id, title, author, published_date, isbn) FROM stdin;
1	My First SQL Book	Mary Parker	2012-02-22 12:08:17.320053	981483029127
2	My Second SQL Book	John Mayer	1972-07-03 09:22:45.050088	857300923713
3	My Third SQL Book	Cary Flint	2015-10-18 14:05:44.547516	523120967812
\.


--
-- Data for Name: checkouts; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.checkouts (id, user_id, book_id, checkout_date, return_date) FROM stdin;
1	1	1	2017-10-15 14:43:18.095143	\N
2	1	2	2017-10-05 16:22:44.593188	2017-10-13 13:00:12.673382
3	2	2	2017-10-15 11:11:24.994973	2017-10-22 17:47:10.407569
4	5	3	2017-10-15 09:27:07.215217	\N
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.reviews (id, book_id, reviewer_name, content, rating, published_date) FROM stdin;
1	1	John Smith	My first review	4	2017-12-10 05:50:11.127281
2	2	John Smith	My second review	5	2017-10-13 15:05:12.673382
3	2	Alice Walker	Another review	1	2017-10-22 23:47:10.407569
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.users (id, full_name, enabled, last_login) FROM stdin;
1	John Smith	f	2024-05-13 16:59:06.665103
3	Harry Potter	t	2024-05-13 17:00:28.854084
5	Jane Smith	t	2024-05-13 18:19:27.181104
2	Alice Walker	t	2024-05-13 17:00:28.854084
\.


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.books_id_seq', 1, false);


--
-- Name: checkouts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.checkouts_id_seq', 1, false);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (user_id);


--
-- Name: books books_isbn_key; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_isbn_key UNIQUE (isbn);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: checkouts checkouts_pkey; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.checkouts
    ADD CONSTRAINT checkouts_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: users users_id_key; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_id_key UNIQUE (id);


--
-- Name: addresses addresses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: checkouts checkouts_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.checkouts
    ADD CONSTRAINT checkouts_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: checkouts checkouts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.checkouts
    ADD CONSTRAINT checkouts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


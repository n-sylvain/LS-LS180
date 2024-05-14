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
-- PostgreSQL database dump complete
--


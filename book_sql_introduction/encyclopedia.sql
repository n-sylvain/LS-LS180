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
-- Name: albums; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.albums (
    id integer NOT NULL,
    album_name character varying(100),
    released date,
    genre character varying(100),
    label character varying(100),
    singer_id integer
);


ALTER TABLE public.albums OWNER TO "sylvain.ni";

--
-- Name: albums_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.albums_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.albums_id_seq OWNER TO "sylvain.ni";

--
-- Name: albums_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.albums_id_seq OWNED BY public.albums.id;


--
-- Name: animals; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.animals (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    binomial_name character varying(100) NOT NULL,
    max_weight_kg numeric(10,4),
    max_age_years integer,
    conservation_status character(2),
    class character varying(100),
    phylum character varying(100),
    kingdom character varying(100)
);


ALTER TABLE public.animals OWNER TO "sylvain.ni";

--
-- Name: animals_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.animals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.animals_id_seq OWNER TO "sylvain.ni";

--
-- Name: animals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.animals_id_seq OWNED BY public.animals.id;


--
-- Name: continents; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.continents (
    id integer NOT NULL,
    continent_name character varying(50)
);


ALTER TABLE public.continents OWNER TO "sylvain.ni";

--
-- Name: continents_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.continents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.continents_id_seq OWNER TO "sylvain.ni";

--
-- Name: continents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.continents_id_seq OWNED BY public.continents.id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    capital character varying(50) NOT NULL,
    population integer,
    continent_id integer
);


ALTER TABLE public.countries OWNER TO "sylvain.ni";

--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.countries_id_seq OWNER TO "sylvain.ni";

--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: singers; Type: TABLE; Schema: public; Owner: sylvain.ni
--

CREATE TABLE public.singers (
    id integer NOT NULL,
    first_name character varying(80) NOT NULL,
    occupation character varying(150),
    date_of_birth date NOT NULL,
    deceased boolean DEFAULT false NOT NULL,
    last_name character varying(100)
);


ALTER TABLE public.singers OWNER TO "sylvain.ni";

--
-- Name: famous_people_id_seq; Type: SEQUENCE; Schema: public; Owner: sylvain.ni
--

CREATE SEQUENCE public.famous_people_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.famous_people_id_seq OWNER TO "sylvain.ni";

--
-- Name: famous_people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sylvain.ni
--

ALTER SEQUENCE public.famous_people_id_seq OWNED BY public.singers.id;


--
-- Name: albums id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.albums ALTER COLUMN id SET DEFAULT nextval('public.albums_id_seq'::regclass);


--
-- Name: animals id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.animals ALTER COLUMN id SET DEFAULT nextval('public.animals_id_seq'::regclass);


--
-- Name: continents id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.continents ALTER COLUMN id SET DEFAULT nextval('public.continents_id_seq'::regclass);


--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: singers id; Type: DEFAULT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.singers ALTER COLUMN id SET DEFAULT nextval('public.famous_people_id_seq'::regclass);


--
-- Data for Name: albums; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.albums (id, album_name, released, genre, label, singer_id) FROM stdin;
1	Born to Run	1975-08-25	Rock and roll	Columbia	1
2	Purple Rain	1984-06-25	Pop, R&B, Rock	Warner Bros	6
3	Born in the USA	1984-06-04	Rock and roll, pop	Columbia	1
4	Madonna	1983-07-27	Dance-pop, post-disco	Warner Bros	5
5	True Blue	1986-06-30	Dance-pop, Pop	Warner Bros	5
6	Elvis	1956-10-19	Rock and roll, Rhythm and Blues	RCA Victor	7
7	Sign o' the Times	1987-03-30	Pop, R&B, Rock, Funk	Paisley Park, Warner Bros	6
8	G.I. Blues	1960-10-01	Rock and roll, Pop	RCA Victor	7
\.


--
-- Data for Name: animals; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.animals (id, name, binomial_name, max_weight_kg, max_age_years, conservation_status, class, phylum, kingdom) FROM stdin;
1	Dove	Columbidae Columbiformes	2.0000	15	LC	Aves	Chordata	Animalia
2	Golden Eagle	Aquila Chrysaetos	6.3500	24	LC	Aves	Chordata	Animalia
3	Peregrine Falcon	Falco Peregrinus	1.5000	15	LC	Aves	Chordata	Animalia
4	Pigeon	Columbidae Columbiformes	2.0000	15	LC	Aves	Chordata	Animalia
5	Kakapo	Strigops habroptila	4.0000	60	CR	Aves	Chordata	Animalia
\.


--
-- Data for Name: continents; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.continents (id, continent_name) FROM stdin;
1	Africa
2	Asia
3	Europe
4	North America
5	South America
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.countries (id, name, capital, population, continent_id) FROM stdin;
2	USA	Washington D.C.	325365189	\N
4	Japan	Tokyo	126672000	\N
1	France	Paris	67158000	\N
3	Germany	Berlin	82349400	\N
\.


--
-- Data for Name: singers; Type: TABLE DATA; Schema: public; Owner: sylvain.ni
--

COPY public.singers (id, first_name, occupation, date_of_birth, deceased, last_name) FROM stdin;
1	Bruce	Singer, Songwriter	1949-09-23	f	Springsteen
3	Frank	Singer, Actor	1915-12-12	t	Sinatra
5	Madonna	Singer, Actress	1958-08-16	f	\N
6	Prince	Singer, Songwriter, Musician, Actor	1958-06-07	t	\N
7	Elvis	Singer, Musician, Actor	1935-08-01	t	Presley
\.


--
-- Name: albums_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.albums_id_seq', 8, true);


--
-- Name: animals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.animals_id_seq', 5, true);


--
-- Name: continents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.continents_id_seq', 5, true);


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.countries_id_seq', 7, true);


--
-- Name: famous_people_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sylvain.ni
--

SELECT pg_catalog.setval('public.famous_people_id_seq', 7, true);


--
-- Name: albums albums_pkey; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (id);


--
-- Name: continents continents_pkey; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.continents
    ADD CONSTRAINT continents_pkey PRIMARY KEY (id);


--
-- Name: countries countries_name_key; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_name_key UNIQUE (name);


--
-- Name: singers unique_id; Type: CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.singers
    ADD CONSTRAINT unique_id UNIQUE (id);


--
-- Name: albums albums_singer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_singer_id_fkey FOREIGN KEY (singer_id) REFERENCES public.singers(id);


--
-- Name: countries countries_continent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sylvain.ni
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_continent_id_fkey FOREIGN KEY (continent_id) REFERENCES public.continents(id);


--
-- PostgreSQL database dump complete
--


--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)

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
-- Name: aircrafts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aircrafts (
    aircraft_code character(3) NOT NULL,
    model text NOT NULL,
    range integer NOT NULL,
    CONSTRAINT aircrafts_range_check CHECK ((range > 0))
);


ALTER TABLE public.aircrafts OWNER TO postgres;

--
-- Name: birthdays; Type: TABLE; Schema: public; Owner: workstation
--

CREATE TABLE public.birthdays (
    person text NOT NULL,
    birthday date NOT NULL
);


ALTER TABLE public.birthdays OWNER TO workstation;

--
-- Name: databases; Type: TABLE; Schema: public; Owner: workstation
--

CREATE TABLE public.databases (
    is_open_source boolean,
    dbms_name text
);


ALTER TABLE public.databases OWNER TO workstation;

--
-- Name: test_check; Type: TABLE; Schema: public; Owner: workstation
--

CREATE TABLE public.test_check (
    mark integer DEFAULT 7 NOT NULL
);


ALTER TABLE public.test_check OWNER TO workstation;

--
-- Name: mark_sum; Type: VIEW; Schema: public; Owner: workstation
--

CREATE VIEW public.mark_sum AS
 SELECT sum(test_check.mark) AS mark_sum
   FROM public.test_check;


ALTER TABLE public.mark_sum OWNER TO workstation;

--
-- Name: pilot_hobbies; Type: TABLE; Schema: public; Owner: workstation
--

CREATE TABLE public.pilot_hobbies (
    pilot_name text,
    hobbies jsonb
);


ALTER TABLE public.pilot_hobbies OWNER TO workstation;

--
-- Name: pilots; Type: TABLE; Schema: public; Owner: workstation
--

CREATE TABLE public.pilots (
    pilor_name text,
    schedule integer[],
    meal text[]
);


ALTER TABLE public.pilots OWNER TO workstation;

--
-- Name: seats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seats (
    aircraft_code character(3) NOT NULL,
    seat_no character varying(4) NOT NULL,
    fare_conditions character varying(10) NOT NULL,
    CONSTRAINT seats_fare_conditions_check CHECK (((fare_conditions)::text = ANY ((ARRAY['Economy'::character varying, 'Comfort'::character varying, 'Business'::character varying])::text[])))
);


ALTER TABLE public.seats OWNER TO postgres;

--
-- Name: seats_by_cond; Type: VIEW; Schema: public; Owner: workstation
--

CREATE VIEW public.seats_by_cond AS
 SELECT seats.aircraft_code,
    seats.fare_conditions,
    count(*) AS count
   FROM public.seats
  GROUP BY seats.aircraft_code, seats.fare_conditions
  ORDER BY seats.aircraft_code;


ALTER TABLE public.seats_by_cond OWNER TO workstation;

--
-- Name: seats_by_fare_cond; Type: VIEW; Schema: public; Owner: workstation
--

CREATE VIEW public.seats_by_fare_cond AS
 SELECT seats.aircraft_code,
    seats.fare_conditions,
    count(*) AS num_seats
   FROM public.seats
  GROUP BY seats.aircraft_code, seats.fare_conditions
  ORDER BY seats.aircraft_code;


ALTER TABLE public.seats_by_fare_cond OWNER TO workstation;

--
-- Name: students; Type: TABLE; Schema: public; Owner: workstation
--

CREATE TABLE public.students (
    record_book numeric(5,0) NOT NULL,
    name text NOT NULL,
    doc_ser numeric(4,0),
    doc_num numeric(6,0),
    who_adds_row text DEFAULT CURRENT_USER,
    time_add timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.students OWNER TO workstation;

--
-- Name: test_bool; Type: TABLE; Schema: public; Owner: workstation
--

CREATE TABLE public.test_bool (
    a boolean,
    b text
);


ALTER TABLE public.test_bool OWNER TO workstation;

--
-- Name: test_numeric; Type: TABLE; Schema: public; Owner: workstation
--

CREATE TABLE public.test_numeric (
    measurement numeric,
    description text
);


ALTER TABLE public.test_numeric OWNER TO workstation;

--
-- Name: test_serial; Type: TABLE; Schema: public; Owner: workstation
--

CREATE TABLE public.test_serial (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.test_serial OWNER TO workstation;

--
-- Name: test_serial_id_seq; Type: SEQUENCE; Schema: public; Owner: workstation
--

CREATE SEQUENCE public.test_serial_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_serial_id_seq OWNER TO workstation;

--
-- Name: test_serial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: workstation
--

ALTER SEQUENCE public.test_serial_id_seq OWNED BY public.test_serial.id;


--
-- Name: test_serial id; Type: DEFAULT; Schema: public; Owner: workstation
--

ALTER TABLE ONLY public.test_serial ALTER COLUMN id SET DEFAULT nextval('public.test_serial_id_seq'::regclass);


--
-- Data for Name: aircrafts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aircrafts (aircraft_code, model, range) FROM stdin;
763	Boeing 767-300	7900
320	Airbus A320-200	5700
321	Airbus A321-200	5600
319	Airbus A319-100	6700
733	Boeing 767-300	4200
\.


--
-- Data for Name: birthdays; Type: TABLE DATA; Schema: public; Owner: workstation
--

COPY public.birthdays (person, birthday) FROM stdin;
Ken Thompson	1955-03-23
Ben Johnson	1971-03-19
Andy Gibson	1987-08-12
\.


--
-- Data for Name: databases; Type: TABLE DATA; Schema: public; Owner: workstation
--

COPY public.databases (is_open_source, dbms_name) FROM stdin;
t	PostgreSQL
f	Oracle
t	MySQL
f	MS SQL Server
\.


--
-- Data for Name: pilot_hobbies; Type: TABLE DATA; Schema: public; Owner: workstation
--

COPY public.pilot_hobbies (pilot_name, hobbies) FROM stdin;
Ivan	{"trips": 3, "sports": ["футбол", "плавание"], "home_lib": true}
Petr	{"trips": 2, "sports": ["теннис", "плавание"], "home_lib": true}
Pavel	{"trips": 4, "sports": ["плавание"], "home_lib": false}
Boris	{"trips": 0, "sports": ["хоккей"], "home_lib": true}
\.


--
-- Data for Name: pilots; Type: TABLE DATA; Schema: public; Owner: workstation
--

COPY public.pilots (pilor_name, schedule, meal) FROM stdin;
Ivan	{1,2,3,4}	{{сосиска,макароны,кофе},{котлета,каша,кофе},{сосиска,каша,кофе},{котлета,каша,чай}}
Oleg	{1,2,3,4}	{{сосиска,макароны,кофе},{котлета,суп,кофе},{сосиска,макароны,кофе},{котлета,каша,чай}}
\.


--
-- Data for Name: seats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seats (aircraft_code, seat_no, fare_conditions) FROM stdin;
733	1A	Business
733	1B	Business
733	10A	Economy
733	10B	Economy
733	10F	Economy
733	20F	Economy
763	1A	Business
763	1B	Business
763	10A	Economy
763	10B	Economy
763	10F	Economy
763	20F	Economy
320	1A	Business
320	1B	Business
320	10A	Economy
320	10B	Economy
320	10F	Economy
320	20F	Economy
321	1A	Business
321	1B	Business
321	10A	Economy
321	10B	Economy
321	10F	Economy
321	20F	Economy
319	1A	Business
319	1B	Business
319	10A	Economy
319	10B	Economy
319	10F	Economy
319	20F	Economy
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: workstation
--

COPY public.students (record_book, name, doc_ser, doc_num, who_adds_row, time_add) FROM stdin;
10	test	1	1	workstation	2023-06-08 17:17:07.463477
\.


--
-- Data for Name: test_bool; Type: TABLE DATA; Schema: public; Owner: workstation
--

COPY public.test_bool (a, b) FROM stdin;
t	yes
t	true
t	true
t	true
t	true
t	true
t	true
t	true
\.


--
-- Data for Name: test_check; Type: TABLE DATA; Schema: public; Owner: workstation
--

COPY public.test_check (mark) FROM stdin;
2
4
6
\.


--
-- Data for Name: test_numeric; Type: TABLE DATA; Schema: public; Owner: workstation
--

COPY public.test_numeric (measurement, description) FROM stdin;
1234567890.0987654321	Точность 20 знаков, масштаб 10 знаков
1.5	Точность 2 знака, масштаб 1 знак
0.12345678901234567890	Точность 21 знак, масштаб 20 знаков
1234567890	Точность 10 знаков, масштаб 0 знаков (целое число)
\.


--
-- Data for Name: test_serial; Type: TABLE DATA; Schema: public; Owner: workstation
--

COPY public.test_serial (id, name) FROM stdin;
1	Вишневая
2	Прохладная
3	Грушевая
5	Луговая
\.


--
-- Name: test_serial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: workstation
--

SELECT pg_catalog.setval('public.test_serial_id_seq', 5, true);


--
-- Name: aircrafts aircrafts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aircrafts
    ADD CONSTRAINT aircrafts_pkey PRIMARY KEY (aircraft_code);


--
-- Name: seats seats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_pkey PRIMARY KEY (aircraft_code, seat_no);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: workstation
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (record_book);


--
-- Name: test_serial test_serial_pkey; Type: CONSTRAINT; Schema: public; Owner: workstation
--

ALTER TABLE ONLY public.test_serial
    ADD CONSTRAINT test_serial_pkey PRIMARY KEY (id);


--
-- Name: seats seats_aircraft_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_aircraft_code_fkey FOREIGN KEY (aircraft_code) REFERENCES public.aircrafts(aircraft_code) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


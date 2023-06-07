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
    pilot_name text,
    schedule integer[]
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
SU9	Sukhoi SuperJet-100	7000
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

COPY public.pilots (pilot_name, schedule) FROM stdin;
Boris	{3,5,6,7}
Pavel	{1,2,5,6}
Ivan	{1,3,6,7}
Petr	{2,3,5,7}
\.


--
-- Data for Name: seats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seats (aircraft_code, seat_no, fare_conditions) FROM stdin;
SU9	1A	Business
SU9	1B	Business
SU9	10A	Economy
SU9	10B	Economy
SU9	10F	Economy
SU9	20F	Economy
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
2	Грушевая
3	Зеленая
13	Вишневая
4	Луговая
\.


--
-- Name: test_serial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: workstation
--

SELECT pg_catalog.setval('public.test_serial_id_seq', 4, true);


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
-- Name: seats seats_aircraft_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seats
    ADD CONSTRAINT seats_aircraft_code_fkey FOREIGN KEY (aircraft_code) REFERENCES public.aircrafts(aircraft_code) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


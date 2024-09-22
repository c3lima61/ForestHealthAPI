--
-- PostgreSQL database dump
--

-- Dumped from database version 17rc1
-- Dumped by pg_dump version 17rc1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: burnseverity_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.burnseverity_enum AS ENUM (
    'Unburnt',
    'Low',
    'Moderate',
    'Extreme'
);


ALTER TYPE public.burnseverity_enum OWNER TO postgres;

--
-- Name: groundlayer_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.groundlayer_enum AS ENUM (
    'Unburnt',
    'New Growth visible',
    'No new growth',
    'No ground cover present'
);


ALTER TYPE public.groundlayer_enum OWNER TO postgres;

--
-- Name: landscapeposition_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.landscapeposition_enum AS ENUM (
    'Flat/Undulating',
    'Ridge or Hill',
    'Slope',
    'Valley/Gully'
);


ALTER TYPE public.landscapeposition_enum OWNER TO postgres;

--
-- Name: layer_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.layer_enum AS ENUM (
    'Ground Layer',
    'Shrub Layer',
    'Upper Canopy Layer'
);


ALTER TYPE public.layer_enum OWNER TO postgres;

--
-- Name: shrublayer_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.shrublayer_enum AS ENUM (
    'Unburnt',
    'Shoots present',
    'Seedlings present',
    'Both shoots and seedlings present',
    'No shoots or seedlings present',
    'No shrub layer present'
);


ALTER TYPE public.shrublayer_enum OWNER TO postgres;

--
-- Name: stage_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.stage_enum AS ENUM (
    'Old',
    'Mature',
    'Regrowth',
    'Mixed',
    'Few trees present'
);


ALTER TYPE public.stage_enum OWNER TO postgres;

--
-- Name: subcanopylayer_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.subcanopylayer_enum AS ENUM (
    'Unburnt',
    'Shoots present',
    'No shoots present',
    'No sub canopy present'
);


ALTER TYPE public.subcanopylayer_enum OWNER TO postgres;

--
-- Name: tallesttreelayer_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tallesttreelayer_enum AS ENUM (
    'Unburnt',
    'Basal shoots present',
    'Epicormic shoots present',
    'Epicormic and basal shoots present',
    'No epicormic or basal shoots present'
);


ALTER TYPE public.tallesttreelayer_enum OWNER TO postgres;

--
-- Name: vegetation_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.vegetation_type_enum AS ENUM (
    'Eucalypt forest (fern or herb)',
    'Eucalypt forest (grassy)',
    'Eucalypt forest (shrubby)',
    'Rainforest',
    'Riparian'
);


ALTER TYPE public.vegetation_type_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: animal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.animal (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.animal OWNER TO postgres;

--
-- Name: animal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.animal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.animal_id_seq OWNER TO postgres;

--
-- Name: animal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.animal_id_seq OWNED BY public.animal.id;


--
-- Name: animalcall; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.animalcall (
    id integer NOT NULL,
    locationid integer NOT NULL,
    animalid integer NOT NULL
);


ALTER TABLE public.animalcall OWNER TO postgres;

--
-- Name: animalcall_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.animalcall_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.animalcall_id_seq OWNER TO postgres;

--
-- Name: animalcall_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.animalcall_id_seq OWNED BY public.animalcall.id;


--
-- Name: animalspotted; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.animalspotted (
    id integer NOT NULL,
    locationid integer NOT NULL,
    animalid integer NOT NULL
);


ALTER TABLE public.animalspotted OWNER TO postgres;

--
-- Name: animalspotted_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.animalspotted_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.animalspotted_id_seq OWNER TO postgres;

--
-- Name: animalspotted_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.animalspotted_id_seq OWNED BY public.animalspotted.id;


--
-- Name: condition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.condition (
    id integer NOT NULL,
    burn_severity public.burnseverity_enum NOT NULL
);


ALTER TABLE public.condition OWNER TO postgres;

--
-- Name: condition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.condition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.condition_id_seq OWNER TO postgres;

--
-- Name: condition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.condition_id_seq OWNED BY public.condition.id;


--
-- Name: development; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.development (
    id integer NOT NULL,
    stage public.stage_enum NOT NULL
);


ALTER TABLE public.development OWNER TO postgres;

--
-- Name: development_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.development_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.development_id_seq OWNER TO postgres;

--
-- Name: development_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.development_id_seq OWNED BY public.development.id;


--
-- Name: floweringplant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.floweringplant (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.floweringplant OWNER TO postgres;

--
-- Name: floweringplant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.floweringplant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.floweringplant_id_seq OWNER TO postgres;

--
-- Name: floweringplant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.floweringplant_id_seq OWNED BY public.floweringplant.id;


--
-- Name: floweringplantlocation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.floweringplantlocation (
    id integer NOT NULL,
    locationid integer NOT NULL,
    plantid integer NOT NULL,
    layer public.layer_enum NOT NULL
);


ALTER TABLE public.floweringplantlocation OWNER TO postgres;

--
-- Name: floweringplantlocation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.floweringplantlocation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.floweringplantlocation_id_seq OWNER TO postgres;

--
-- Name: floweringplantlocation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.floweringplantlocation_id_seq OWNED BY public.floweringplantlocation.id;


--
-- Name: location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location (
    id integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    coordinates point NOT NULL,
    photo character varying(100) NOT NULL,
    landscape_position public.landscapeposition_enum NOT NULL,
    altitude integer,
    compass_direction double precision,
    CONSTRAINT location_compassdirection_check CHECK (((compass_direction >= (0)::double precision) AND (compass_direction <= (360)::double precision)))
);


ALTER TABLE public.location OWNER TO postgres;

--
-- Name: location_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.location_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.location_id_seq OWNER TO postgres;

--
-- Name: location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.location_id_seq OWNED BY public.location.id;


--
-- Name: locationcondition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locationcondition (
    id integer NOT NULL,
    conditionid integer NOT NULL,
    locationid integer NOT NULL
);


ALTER TABLE public.locationcondition OWNER TO postgres;

--
-- Name: locationcondition_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locationcondition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locationcondition_id_seq OWNER TO postgres;

--
-- Name: locationcondition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locationcondition_id_seq OWNED BY public.locationcondition.id;


--
-- Name: locationdevelopment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locationdevelopment (
    id integer NOT NULL,
    developmentid integer NOT NULL,
    locationid integer NOT NULL
);


ALTER TABLE public.locationdevelopment OWNER TO postgres;

--
-- Name: locationdevelopment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locationdevelopment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locationdevelopment_id_seq OWNER TO postgres;

--
-- Name: locationdevelopment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locationdevelopment_id_seq OWNED BY public.locationdevelopment.id;


--
-- Name: locationvegetation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locationvegetation (
    id integer NOT NULL,
    locationid integer NOT NULL,
    vegetationid integer NOT NULL
);


ALTER TABLE public.locationvegetation OWNER TO postgres;

--
-- Name: locationvegetation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locationvegetation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locationvegetation_id_seq OWNER TO postgres;

--
-- Name: locationvegetation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locationvegetation_id_seq OWNED BY public.locationvegetation.id;


--
-- Name: recovery; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recovery (
    id integer NOT NULL,
    locationid integer NOT NULL,
    ground_layer public.groundlayer_enum NOT NULL,
    shrub_layer public.shrublayer_enum NOT NULL,
    sub_canopy_layer public.subcanopylayer_enum NOT NULL,
    tallest_tree_layer public.tallesttreelayer_enum NOT NULL
);


ALTER TABLE public.recovery OWNER TO postgres;

--
-- Name: recovery_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recovery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recovery_id_seq OWNER TO postgres;

--
-- Name: recovery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recovery_id_seq OWNED BY public.recovery.id;


--
-- Name: vegetation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vegetation (
    id integer NOT NULL,
    type public.vegetation_type_enum NOT NULL
);


ALTER TABLE public.vegetation OWNER TO postgres;

--
-- Name: vegetation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vegetation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vegetation_id_seq OWNER TO postgres;

--
-- Name: vegetation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vegetation_id_seq OWNED BY public.vegetation.id;


--
-- Name: animal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animal ALTER COLUMN id SET DEFAULT nextval('public.animal_id_seq'::regclass);


--
-- Name: animalcall id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animalcall ALTER COLUMN id SET DEFAULT nextval('public.animalcall_id_seq'::regclass);


--
-- Name: animalspotted id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animalspotted ALTER COLUMN id SET DEFAULT nextval('public.animalspotted_id_seq'::regclass);


--
-- Name: condition id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.condition ALTER COLUMN id SET DEFAULT nextval('public.condition_id_seq'::regclass);


--
-- Name: development id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.development ALTER COLUMN id SET DEFAULT nextval('public.development_id_seq'::regclass);


--
-- Name: floweringplant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.floweringplant ALTER COLUMN id SET DEFAULT nextval('public.floweringplant_id_seq'::regclass);


--
-- Name: floweringplantlocation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.floweringplantlocation ALTER COLUMN id SET DEFAULT nextval('public.floweringplantlocation_id_seq'::regclass);


--
-- Name: location id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location ALTER COLUMN id SET DEFAULT nextval('public.location_id_seq'::regclass);


--
-- Name: locationcondition id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locationcondition ALTER COLUMN id SET DEFAULT nextval('public.locationcondition_id_seq'::regclass);


--
-- Name: locationdevelopment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locationdevelopment ALTER COLUMN id SET DEFAULT nextval('public.locationdevelopment_id_seq'::regclass);


--
-- Name: locationvegetation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locationvegetation ALTER COLUMN id SET DEFAULT nextval('public.locationvegetation_id_seq'::regclass);


--
-- Name: recovery id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recovery ALTER COLUMN id SET DEFAULT nextval('public.recovery_id_seq'::regclass);


--
-- Name: vegetation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vegetation ALTER COLUMN id SET DEFAULT nextval('public.vegetation_id_seq'::regclass);


--
-- Data for Name: animal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.animal (id, name) FROM stdin;
1	Kangaroo
2	Koala
3	Wombat
4	Dingo
5	Platypus
6	Echidna
7	Emu
8	Wallaby
9	Tasmanian Devil
10	Cassowary
11	Kookaburra
12	Sugar Glider
13	Possum
14	Frilled-Neck Lizard
15	Blue-Tongue Lizard
16	Redback Spider
17	Tiger Snake
18	Goanna
19	Numbat
20	Bilby
21	Fairy Penguin
22	Eastern Brown Snake
23	Perentie
24	Carpet Python
25	Bush Stone-Curlew
26	Black Swan
27	Tree Kangaroo
28	Brush-Tailed Rock Wallaby
29	Antechinus
30	Thorny Devil
31	Lyrebird
32	Grey Kangaroo
33	Pygmy Possum
34	Yellow-Tailed Black Cockatoo
35	Australian Magpie
36	Brolga
37	Fairy-Wren
38	Galah
39	Masked Owl
40	Frogmouth
41	Quokka
42	Bandicoot
43	Cockatoo
44	Lorikeet
45	Spotted Quoll
46	Rufous Bettong
47	Long-Nosed Potoroo
48	Feathertail Glider
49	Tawny Frogmouth
50	Mulga Snake
51	Eastern Quoll
52	Wedge-Tailed Eagle
\.


--
-- Data for Name: animalcall; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.animalcall (id, locationid, animalid) FROM stdin;
1	1	1
2	2	2
3	6	11
4	7	7
5	10	25
6	19	36
7	20	50
8	13	15
9	33	49
10	50	12
\.


--
-- Data for Name: animalspotted; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.animalspotted (id, locationid, animalid) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	4
5	5	6
6	6	11
7	7	7
8	8	10
9	9	12
10	10	25
11	11	13
12	12	14
13	13	15
14	14	17
15	15	26
16	16	28
17	17	32
18	18	33
19	19	36
20	20	50
21	51	2
22	52	41
\.


--
-- Data for Name: condition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.condition (id, burn_severity) FROM stdin;
1	Unburnt
2	Low
3	Moderate
4	Extreme
\.


--
-- Data for Name: development; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.development (id, stage) FROM stdin;
1	Old
2	Mature
3	Regrowth
4	Mixed
5	Few trees present
\.


--
-- Data for Name: floweringplant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.floweringplant (id, name) FROM stdin;
1	Golden Wattle
2	Waratah
3	Kangaroo Paw
4	Banksia
5	Bottlebrush
6	Grevillea
7	Eucalyptus Flower
8	Hibiscus
9	Woolly Tea-tree
10	Common Heath
11	Flannel Flower
12	Native Violet
13	Native Rosella
14	Bluebell
15	Sturt's Desert Pea
16	Daisy Bush
17	Myrtle
18	Christmas Bush
19	Paper Daisy
20	Fairy Fan Flower
21	Rock Daisy
22	Blue Devil
23	Snake Vine
24	Fan Grevillea
25	Native Hibiscus
26	Coral Pea
27	Running Postman
28	Emu Bush
29	Trigger Plant
30	Guinea Flower
31	Giant Spear Lily
32	Hairy Yellow Pea
33	Spider Flower
34	Velvet Daisy Bush
35	Mountain Bell
36	Large-leaved Bush-pea
37	Slender Rice Flower
38	Dainty Guinea Flower
39	Australian Indigo
40	Leafless Tongue-orchid
41	Dusky Pink Hibiscus
42	Dorrigo Waratah
43	Swamp Lily
44	Pink Ziera
45	River Rose
46	Showy Boronia
47	Twining Fringe Lily
48	Winged Everlasting
49	Golden Guinea Vine
50	Native Fuchsia
\.


--
-- Data for Name: floweringplantlocation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.floweringplantlocation (id, locationid, plantid, layer) FROM stdin;
1	5	1	Ground Layer
2	12	5	Shrub Layer
3	25	6	Upper Canopy Layer
4	3	1	Ground Layer
5	18	5	Shrub Layer
6	7	6	Upper Canopy Layer
7	10	3	Ground Layer
8	16	4	Shrub Layer
9	30	8	Upper Canopy Layer
10	22	3	Ground Layer
11	4	4	Shrub Layer
12	29	8	Upper Canopy Layer
13	13	9	Ground Layer
14	8	10	Shrub Layer
15	21	13	Upper Canopy Layer
16	9	9	Ground Layer
17	15	10	Shrub Layer
18	23	13	Upper Canopy Layer
19	33	2	Ground Layer
20	6	11	Shrub Layer
21	27	18	Upper Canopy Layer
22	35	2	Ground Layer
23	14	11	Shrub Layer
24	40	18	Upper Canopy Layer
25	2	19	Ground Layer
26	48	20	Shrub Layer
27	11	46	Upper Canopy Layer
28	45	19	Ground Layer
29	19	20	Shrub Layer
30	37	46	Upper Canopy Layer
31	5	2	Shrub Layer
32	12	3	Upper Canopy Layer
33	25	9	Ground Layer
34	3	8	Shrub Layer
35	18	6	Upper Canopy Layer
36	7	10	Ground Layer
37	10	11	Shrub Layer
38	16	12	Upper Canopy Layer
39	13	4	Ground Layer
40	13	7	Upper Canopy Layer
41	33	1	Ground Layer
42	33	19	Upper Canopy Layer
43	40	9	Ground Layer
44	40	10	Upper Canopy Layer
45	45	18	Shrub Layer
46	45	2	Upper Canopy Layer
47	51	3	Ground Layer
48	52	22	Ground Layer
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.location (id, "timestamp", coordinates, photo, landscape_position, altitude, compass_direction) FROM stdin;
51	2024-10-12 14:35:00	(-31.9615,115.856)	Photo 51	Ridge or Hill	1500	45.25
52	2024-10-13 09:20:00	(-33.865,151.209)	Photo 52	Valley/Gully	2000	78.35
1	2024-09-01 10:30:00	(-26.31779,116.94564)	Photo 01	Slope	2052	\N
2	2024-09-01 20:40:26	(-26.27386,142.25439)	Photo 02	Slope	\N	\N
3	2024-09-02 14:44:01	(-24.14137,122.80399)	Photo 03	Slope	\N	\N
4	2024-09-03 18:40:11	(-32.67832,135.98683)	Photo 04	Slope	2904	\N
5	2024-09-04 16:17:05	(-40.2595,139.88478)	Photo 05	Ridge or Hill	1613	324.01
6	2024-09-05 19:00:59	(-20.21244,131.39031)	Photo 06	Slope	2383	288.59
7	2024-09-06 07:05:24	(-36.90682,122.14333)	Photo 07	Ridge or Hill	1818	79.33
8	2024-09-07 08:23:11	(-42.16865,128.29699)	Photo 08	Flat/Undulating	481	11.43
9	2024-09-07 11:49:18	(-20.38971,141.44568)	Photo 09	Ridge or Hill	1588	70.31
10	2024-09-08 09:09:06	(-10.04687,117.02528)	Photo 10	Valley/Gully	1312	210.21
11	2024-09-09 06:40:24	(-33.73853,148.76537)	Photo 11	Valley/Gully	2127	64.65
12	2024-09-09 19:17:56	(-31.54385,147.41862)	Photo 12	Ridge or Hill	1980	224.43
13	2024-09-10 07:50:08	(-28.76311,118.0937)	Photo 13	Ridge or Hill	48	\N
14	2024-09-11 10:09:37	(-40.48784,151.74724)	Photo 14	Flat/Undulating	1007	224.52
15	2024-09-11 22:49:08	(-41.09027,125.8517)	Photo 15	Ridge or Hill	710	90.3
16	2024-09-12 21:37:36	(-34.11328,120.1806)	Photo 16	Ridge or Hill	824	182.27
17	2024-09-13 22:26:26	(-29.60193,150.28441)	Photo 17	Ridge or Hill	1444	268.13
18	2024-09-14 03:24:45	(-11.29737,133.20874)	Photo 18	Slope	2616	170.53
19	2024-09-14 21:43:35	(-26.40534,132.19693)	Photo 19	Flat/Undulating	\N	\N
20	2024-09-16 00:53:07	(-39.79713,143.33555)	Photo 20	Slope	83	189.14
21	2024-09-16 22:34:33	(-17.44447,129.85643)	Photo 21	Slope	2894	103.28
22	2024-09-18 02:35:46	(-17.15255,133.9526)	Photo 22	Flat/Undulating	911	226.05
23	2024-09-19 00:17:57	(-26.51903,148.82755)	Photo 23	Slope	590	22
24	2024-09-20 00:01:11	(-32.42753,134.01875)	Photo 24	Flat/Undulating	\N	\N
25	2024-09-20 18:00:53	(-30.29829,152.50615)	Photo 25	Flat/Undulating	1909	292.86
26	2024-09-21 04:37:22	(-33.76359,114.92491)	Photo 26	Ridge or Hill	2929	283.72
27	2024-09-21 15:33:06	(-39.01729,140.66875)	Photo 27	Ridge or Hill	2102	94.83
28	2024-09-23 03:21:47	(-21.54929,125.03547)	Photo 28	Flat/Undulating	914	98.46
29	2024-09-23 15:55:33	(-36.54101,150.27817)	Photo 29	Ridge or Hill	1134	205.83
30	2024-09-24 21:42:57	(-26.3569,151.25507)	Photo 30	Slope	1830	65.8
31	2024-09-25 22:51:13	(-12.85088,138.44155)	Photo 31	Ridge or Hill	1123	68.4
32	2024-09-26 19:52:21	(-16.66456,136.79685)	Photo 32	Ridge or Hill	1481	23.61
33	2024-09-27 15:24:45	(-39.91636,119.265)	Photo 33	Ridge or Hill	2635	\N
34	2024-09-27 21:55:55	(-12.5375,141.4933)	Photo 34	Ridge or Hill	2002	314.8
35	2024-09-28 13:17:21	(-39.38703,125.32847)	Photo 35	Slope	2753	330.81
36	2024-09-28 22:59:58	(-22.19248,138.63448)	Photo 36	Ridge or Hill	2911	205.38
37	2024-09-30 06:44:48	(-42.98417,129.23679)	Photo 37	Ridge or Hill	2431	168.78
38	2024-09-30 21:05:11	(-10.32917,120.96758)	Photo 38	Slope	237	150.05
39	2024-10-01 02:31:02	(-13.54901,120.51281)	Photo 39	Flat/Undulating	\N	\N
40	2024-10-01 13:54:57	(-19.17453,114.3617)	Photo 40	Slope	612	157.92
41	2024-10-01 22:25:59	(-38.16955,138.26995)	Photo 41	Slope	2780	5.04
42	2024-10-02 13:08:49	(-30.66461,147.7503)	Photo 42	Ridge or Hill	1220	41.74
43	2024-10-03 04:33:41	(-13.08324,150.93048)	Photo 43	Ridge or Hill	939	133.63
44	2024-10-03 22:43:13	(-32.93446,125.61332)	Photo 44	Ridge or Hill	1203	124.99
45	2024-10-04 17:49:18	(-43.62852,112.79168)	Photo 45	Slope	1381	26.87
46	2024-10-05 18:18:27	(-41.37997,137.25172)	Photo 46	Slope	\N	\N
47	2024-10-06 03:19:13	(-27.4228,115.72182)	Photo 47	Ridge or Hill	2277	318.38
48	2024-10-07 06:41:08	(-30.89307,144.86315)	Photo 48	Flat/Undulating	680	165.57
49	2024-10-08 09:39:57	(-21.47394,120.40742)	Photo 49	Ridge or Hill	1298	321.63
50	2024-10-09 07:58:24	(-16.76316,144.30883)	Photo 50	Ridge or Hill	22	\N
\.


--
-- Data for Name: locationcondition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locationcondition (id, conditionid, locationid) FROM stdin;
1	1	1
2	1	3
3	1	7
4	1	13
5	1	15
6	1	19
7	1	22
8	1	26
9	1	27
10	1	30
11	1	32
12	1	34
13	1	35
14	1	36
15	1	38
16	1	39
17	1	40
18	1	41
19	1	42
20	1	43
21	1	45
22	1	46
23	1	49
24	1	50
25	1	5
26	2	2
27	2	4
28	2	6
29	2	8
30	2	9
31	2	10
32	2	11
33	2	12
34	2	14
35	2	16
36	2	18
37	2	20
38	2	21
39	2	23
40	2	24
41	3	25
42	3	17
43	3	33
44	3	31
45	3	37
46	3	28
47	3	44
48	4	29
49	4	47
50	4	48
51	2	51
52	1	52
\.


--
-- Data for Name: locationdevelopment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locationdevelopment (id, developmentid, locationid) FROM stdin;
1	1	5
2	1	17
3	1	29
4	1	32
5	1	45
6	1	50
7	1	3
8	1	7
9	2	8
10	2	13
11	2	21
12	2	36
13	2	42
14	2	15
15	2	30
16	2	16
17	3	1
18	3	4
19	3	14
20	3	25
21	3	41
22	3	48
23	3	19
24	3	11
25	4	2
26	4	10
27	4	18
28	4	23
29	4	37
30	4	33
31	4	44
32	4	22
33	5	6
34	5	9
35	5	12
36	5	27
37	5	38
38	5	40
39	5	49
40	5	24
41	1	28
42	2	35
43	3	39
44	4	34
45	5	31
46	1	20
47	2	26
48	3	43
49	4	46
50	5	47
51	2	51
52	2	52
\.


--
-- Data for Name: locationvegetation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locationvegetation (id, locationid, vegetationid) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	1
5	5	5
6	6	4
7	7	2
8	8	3
9	9	1
10	10	5
11	11	1
12	12	3
13	13	3
14	14	2
15	15	4
16	16	3
17	17	2
18	18	4
19	19	5
20	20	4
21	21	1
22	22	2
23	23	3
24	24	1
25	25	5
26	26	4
27	27	2
28	28	3
29	29	1
30	30	5
31	31	1
32	32	3
33	33	3
34	34	2
35	35	4
36	36	3
37	37	2
38	38	4
39	39	5
40	40	4
41	41	1
42	42	2
43	43	3
44	44	1
45	45	5
46	46	4
47	47	2
48	48	3
49	49	1
50	50	5
51	51	3
52	52	5
\.


--
-- Data for Name: recovery; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recovery (id, locationid, ground_layer, shrub_layer, sub_canopy_layer, tallest_tree_layer) FROM stdin;
1	1	Unburnt	Unburnt	Unburnt	Unburnt
2	3	Unburnt	Unburnt	Unburnt	Unburnt
3	7	Unburnt	Unburnt	Unburnt	Unburnt
4	13	Unburnt	Unburnt	Unburnt	Unburnt
5	15	Unburnt	Unburnt	Unburnt	Unburnt
6	19	Unburnt	Unburnt	Unburnt	Unburnt
7	22	Unburnt	Unburnt	Unburnt	Unburnt
8	26	Unburnt	Unburnt	Unburnt	Unburnt
9	27	Unburnt	Unburnt	Unburnt	Unburnt
10	30	Unburnt	Unburnt	Unburnt	Unburnt
11	32	Unburnt	Unburnt	Unburnt	Unburnt
12	34	Unburnt	Unburnt	Unburnt	Unburnt
13	35	Unburnt	Unburnt	Unburnt	Unburnt
14	36	Unburnt	Unburnt	Unburnt	Unburnt
15	38	Unburnt	Unburnt	Unburnt	Unburnt
16	39	Unburnt	Unburnt	Unburnt	Unburnt
17	40	Unburnt	Unburnt	Unburnt	Unburnt
18	41	Unburnt	Unburnt	Unburnt	Unburnt
19	42	Unburnt	Unburnt	Unburnt	Unburnt
20	43	Unburnt	Unburnt	Unburnt	Unburnt
21	45	Unburnt	Unburnt	Unburnt	Unburnt
22	46	Unburnt	Unburnt	Unburnt	Unburnt
23	49	Unburnt	Unburnt	Unburnt	Unburnt
24	50	Unburnt	Unburnt	Unburnt	Unburnt
25	5	Unburnt	Unburnt	Unburnt	Unburnt
26	2	No new growth	Unburnt	No sub canopy present	Basal shoots present
27	4	Unburnt	Unburnt	Shoots present	Unburnt
28	6	No ground cover present	Both shoots and seedlings present	Shoots present	Unburnt
29	8	Unburnt	Unburnt	Unburnt	Basal shoots present
30	9	Unburnt	Unburnt	Unburnt	Unburnt
31	10	Unburnt	Both shoots and seedlings present	Unburnt	Epicormic shoots present
32	11	Unburnt	Unburnt	Unburnt	Unburnt
33	12	Unburnt	Unburnt	Unburnt	Unburnt
34	14	No ground cover present	Unburnt	Unburnt	Unburnt
35	16	Unburnt	Unburnt	Unburnt	Unburnt
36	18	New Growth visible	Shoots present	Unburnt	Basal shoots present
37	20	Unburnt	Unburnt	Unburnt	Unburnt
38	21	New Growth visible	Unburnt	Unburnt	Unburnt
39	23	No new growth	Unburnt	Unburnt	Unburnt
40	24	Unburnt	No shrub layer present	Unburnt	Unburnt
41	25	No new growth	No shrub layer present	Unburnt	Epicormic and basal shoots present
42	17	Unburnt	No shrub layer present	Unburnt	No epicormic or basal shoots present
43	33	Unburnt	No shrub layer present	Unburnt	Unburnt
44	31	No new growth	Unburnt	No shoots present	Unburnt
45	37	No ground cover present	Unburnt	Shoots present	Unburnt
46	28	No new growth	Unburnt	Shoots present	Epicormic and basal shoots present
47	44	No ground cover present	No shoots or seedlings present	Unburnt	Unburnt
48	29	No ground cover present	Seedlings present	No shoots present	Epicormic shoots present
49	47	New Growth visible	No shoots or seedlings present	No shoots present	No epicormic or basal shoots present
50	48	No ground cover present	No shrub layer present	Shoots present	Basal shoots present
51	51	New Growth visible	Shoots present	Unburnt	Unburnt
52	52	Unburnt	Unburnt	Unburnt	Unburnt
\.


--
-- Data for Name: vegetation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vegetation (id, type) FROM stdin;
1	Eucalypt forest (fern or herb)
2	Eucalypt forest (grassy)
3	Eucalypt forest (shrubby)
4	Rainforest
5	Riparian
\.


--
-- Name: animal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.animal_id_seq', 52, true);


--
-- Name: animalcall_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.animalcall_id_seq', 10, true);


--
-- Name: animalspotted_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.animalspotted_id_seq', 22, true);


--
-- Name: condition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.condition_id_seq', 4, true);


--
-- Name: development_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.development_id_seq', 5, true);


--
-- Name: floweringplant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.floweringplant_id_seq', 50, true);


--
-- Name: floweringplantlocation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.floweringplantlocation_id_seq', 48, true);


--
-- Name: location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.location_id_seq', 52, true);


--
-- Name: locationcondition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locationcondition_id_seq', 52, true);


--
-- Name: locationdevelopment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locationdevelopment_id_seq', 52, true);


--
-- Name: locationvegetation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locationvegetation_id_seq', 52, true);


--
-- Name: recovery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recovery_id_seq', 52, true);


--
-- Name: vegetation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vegetation_id_seq', 5, true);


--
-- Name: animal animal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animal
    ADD CONSTRAINT animal_pkey PRIMARY KEY (id);


--
-- Name: animalcall animalcall_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animalcall
    ADD CONSTRAINT animalcall_pkey PRIMARY KEY (id);


--
-- Name: animalspotted animalspotted_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animalspotted
    ADD CONSTRAINT animalspotted_pkey PRIMARY KEY (id);


--
-- Name: condition condition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.condition
    ADD CONSTRAINT condition_pkey PRIMARY KEY (id);


--
-- Name: development development_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.development
    ADD CONSTRAINT development_pkey PRIMARY KEY (id);


--
-- Name: floweringplant floweringplant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.floweringplant
    ADD CONSTRAINT floweringplant_pkey PRIMARY KEY (id);


--
-- Name: floweringplantlocation floweringplantlocation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.floweringplantlocation
    ADD CONSTRAINT floweringplantlocation_pkey PRIMARY KEY (id);


--
-- Name: location location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- Name: locationcondition locationcondition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locationcondition
    ADD CONSTRAINT locationcondition_pkey PRIMARY KEY (id);


--
-- Name: locationdevelopment locationdevelopment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locationdevelopment
    ADD CONSTRAINT locationdevelopment_pkey PRIMARY KEY (id);


--
-- Name: locationvegetation locationvegetation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locationvegetation
    ADD CONSTRAINT locationvegetation_pkey PRIMARY KEY (id);


--
-- Name: recovery recovery_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recovery
    ADD CONSTRAINT recovery_pkey PRIMARY KEY (id);


--
-- Name: vegetation vegetation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vegetation
    ADD CONSTRAINT vegetation_pkey PRIMARY KEY (id);


--
-- Name: animalcall animalcall_animalid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animalcall
    ADD CONSTRAINT animalcall_animalid_fkey FOREIGN KEY (animalid) REFERENCES public.animal(id);


--
-- Name: animalcall animalcall_locationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animalcall
    ADD CONSTRAINT animalcall_locationid_fkey FOREIGN KEY (locationid) REFERENCES public.location(id);


--
-- Name: animalspotted animalspotted_animalid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animalspotted
    ADD CONSTRAINT animalspotted_animalid_fkey FOREIGN KEY (animalid) REFERENCES public.animal(id);


--
-- Name: animalspotted animalspotted_locationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animalspotted
    ADD CONSTRAINT animalspotted_locationid_fkey FOREIGN KEY (locationid) REFERENCES public.location(id);


--
-- Name: floweringplantlocation floweringplantlocation_locationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.floweringplantlocation
    ADD CONSTRAINT floweringplantlocation_locationid_fkey FOREIGN KEY (locationid) REFERENCES public.location(id);


--
-- Name: floweringplantlocation floweringplantlocation_plantid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.floweringplantlocation
    ADD CONSTRAINT floweringplantlocation_plantid_fkey FOREIGN KEY (plantid) REFERENCES public.floweringplant(id);


--
-- Name: locationcondition locationcondition_conditionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locationcondition
    ADD CONSTRAINT locationcondition_conditionid_fkey FOREIGN KEY (conditionid) REFERENCES public.condition(id);


--
-- Name: locationcondition locationcondition_locationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locationcondition
    ADD CONSTRAINT locationcondition_locationid_fkey FOREIGN KEY (locationid) REFERENCES public.location(id);


--
-- Name: locationdevelopment locationdevelopment_developmentid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locationdevelopment
    ADD CONSTRAINT locationdevelopment_developmentid_fkey FOREIGN KEY (developmentid) REFERENCES public.development(id);


--
-- Name: locationdevelopment locationdevelopment_locationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locationdevelopment
    ADD CONSTRAINT locationdevelopment_locationid_fkey FOREIGN KEY (locationid) REFERENCES public.location(id);


--
-- Name: locationvegetation locationvegetation_locationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locationvegetation
    ADD CONSTRAINT locationvegetation_locationid_fkey FOREIGN KEY (locationid) REFERENCES public.location(id);


--
-- Name: locationvegetation locationvegetation_vegetationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locationvegetation
    ADD CONSTRAINT locationvegetation_vegetationid_fkey FOREIGN KEY (vegetationid) REFERENCES public.vegetation(id);


--
-- Name: recovery recovery_locationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recovery
    ADD CONSTRAINT recovery_locationid_fkey FOREIGN KEY (locationid) REFERENCES public.location(id);


--
-- PostgreSQL database dump complete
--


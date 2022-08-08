--
-- PostgreSQL database dump
--

-- Dumped from database version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)

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
-- Name: clicks; Type: TABLE; Schema: public; Owner: mircs
--

CREATE TABLE public.clicks (
    _id bigint NOT NULL,
    high_score double precision,
    date timestamp with time zone
);


ALTER TABLE public.clicks OWNER TO mircs;

--
-- Name: clicks__id_seq; Type: SEQUENCE; Schema: public; Owner: mircs
--

CREATE SEQUENCE public.clicks__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clicks__id_seq OWNER TO mircs;

--
-- Name: clicks__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mircs
--

ALTER SEQUENCE public.clicks__id_seq OWNED BY public.clicks._id;


--
-- Name: cnn; Type: TABLE; Schema: public; Owner: mircs
--

CREATE TABLE public.cnn (
    _id bigint NOT NULL,
    sixteen_baseline_accuracy double precision,
    nineteen_baseline_accuracy double precision,
    sixteen_attention_accuracy double precision,
    nineteen_attention_accuracy double precision,
    epochs bigint,
    date character varying
);


ALTER TABLE public.cnn OWNER TO mircs;

--
-- Name: cnn__id_seq; Type: SEQUENCE; Schema: public; Owner: mircs
--

CREATE SEQUENCE public.cnn__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cnn__id_seq OWNER TO mircs;

--
-- Name: cnn__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mircs
--

ALTER SEQUENCE public.cnn__id_seq OWNED BY public.cnn._id;


--
-- Name: image_count; Type: TABLE; Schema: public; Owner: mircs
--

CREATE TABLE public.image_count (
    _id bigint NOT NULL,
    num_images bigint,
    current_generation bigint,
    iteration_generation bigint,
    generations_per_epoch bigint
);


ALTER TABLE public.image_count OWNER TO mircs;

--
-- Name: image_count__id_seq; Type: SEQUENCE; Schema: public; Owner: mircs
--

CREATE SEQUENCE public.image_count__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_count__id_seq OWNER TO mircs;

--
-- Name: image_count__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mircs
--

ALTER SEQUENCE public.image_count__id_seq OWNED BY public.image_count._id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: mircs
--

CREATE TABLE public.images (
    _id bigint NOT NULL,
    image_path character varying,
    syn_name character varying,
    click_path json,
    answers json,
    generations bigint
);


ALTER TABLE public.images OWNER TO mircs;

--
-- Name: images__id_seq; Type: SEQUENCE; Schema: public; Owner: mircs
--

CREATE SEQUENCE public.images__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.images__id_seq OWNER TO mircs;

--
-- Name: images__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mircs
--

ALTER SEQUENCE public.images__id_seq OWNED BY public.images._id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: mircs
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.session OWNER TO mircs;

--
-- Name: users; Type: TABLE; Schema: public; Owner: mircs
--

CREATE TABLE public.users (
    _id bigint NOT NULL,
    cookie character varying,
    name character varying,
    score double precision,
    email character varying,
    last_click_time timestamp with time zone
);


ALTER TABLE public.users OWNER TO mircs;

--
-- Name: users__id_seq; Type: SEQUENCE; Schema: public; Owner: mircs
--

CREATE SEQUENCE public.users__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users__id_seq OWNER TO mircs;

--
-- Name: users__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mircs
--

ALTER SEQUENCE public.users__id_seq OWNED BY public.users._id;


--
-- Name: clicks _id; Type: DEFAULT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY public.clicks ALTER COLUMN _id SET DEFAULT nextval('public.clicks__id_seq'::regclass);


--
-- Name: cnn _id; Type: DEFAULT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY public.cnn ALTER COLUMN _id SET DEFAULT nextval('public.cnn__id_seq'::regclass);


--
-- Name: image_count _id; Type: DEFAULT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY public.image_count ALTER COLUMN _id SET DEFAULT nextval('public.image_count__id_seq'::regclass);


--
-- Name: images _id; Type: DEFAULT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY public.images ALTER COLUMN _id SET DEFAULT nextval('public.images__id_seq'::regclass);


--
-- Name: users _id; Type: DEFAULT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY public.users ALTER COLUMN _id SET DEFAULT nextval('public.users__id_seq'::regclass);


--
-- Data for Name: clicks; Type: TABLE DATA; Schema: public; Owner: mircs
--

COPY public.clicks (_id, high_score, date) FROM stdin;
1	0	\N
\.


--
-- Data for Name: cnn; Type: TABLE DATA; Schema: public; Owner: mircs
--

COPY public.cnn (_id, sixteen_baseline_accuracy, nineteen_baseline_accuracy, sixteen_attention_accuracy, nineteen_attention_accuracy, epochs, date) FROM stdin;
\.


--
-- Data for Name: image_count; Type: TABLE DATA; Schema: public; Owner: mircs
--

COPY public.image_count (_id, num_images, current_generation, iteration_generation, generations_per_epoch) FROM stdin;
1	2	4	5	4
\.


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: mircs
--

COPY public.images (_id, image_path, syn_name, click_path, answers, generations) FROM stdin;
8	images/0_000.jpg	 tench	\N	\N	0
7	images/1_000.jpg	 goldfish	{"x":[["85","120.84375"],[],[],[],[],["62","66.17269998786077","70.3011923128639","74.42968463786704","78.55817696287018","82.68666928787331","87.13958297759903","92.3867533043154","98.77576693713199","105.4260005886847","112.07623424023741","118.72646789179012","125.37670154334283","127.3861677950776","129.39563404681238","131.40510029854713","133.41456655028188","135.42403280201665","137.4334990537514","139.44296530548618","141"]],"y":[["78.16669057871233","122.3622632047306"],[],[],[],[],["145.21875","150.8391214122206","156.49204553362804","162.14496965503548","167.79789377644295","173.4508178978504","178.8518881317812","183.48515949901486","186.34531767640362","188.53035597807155","190.71539427973948","192.90043258140742","195.08547088307535","201.79084524869722","208.4962196143191","215.20159397994098","221.90696834556286","228.61234271118474","235.31771707680662","242.0230914424285","247.21875"]]}	{"answers":["wrong","skip","skip","skip","skip","skip"]}	0
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: mircs
--

COPY public.session (sid, sess, expire) FROM stdin;
gWeXc9yTsQyyOOHScAOt4iWWWjWLFeTM	{"cookie":{"originalMaxAge":31536000000,"expires":"2023-08-04T19:32:07.533Z","httpOnly":true,"path":"/"},"user_data":{"click_count":6,"score":0,"name":"condemned union","userid":"N42pjGmgp","app_version":2,"email":"","expiration":1662004800000}}	2023-08-04 15:32:09
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mircs
--

COPY public.users (_id, cookie, name, score, email, last_click_time) FROM stdin;
1	N42pjGmgp	condemned union	0	\N	\N
\.


--
-- Name: clicks__id_seq; Type: SEQUENCE SET; Schema: public; Owner: mircs
--

SELECT pg_catalog.setval('public.clicks__id_seq', 1, true);


--
-- Name: cnn__id_seq; Type: SEQUENCE SET; Schema: public; Owner: mircs
--

SELECT pg_catalog.setval('public.cnn__id_seq', 1, false);


--
-- Name: image_count__id_seq; Type: SEQUENCE SET; Schema: public; Owner: mircs
--

SELECT pg_catalog.setval('public.image_count__id_seq', 1, true);


--
-- Name: images__id_seq; Type: SEQUENCE SET; Schema: public; Owner: mircs
--

SELECT pg_catalog.setval('public.images__id_seq', 8, true);


--
-- Name: users__id_seq; Type: SEQUENCE SET; Schema: public; Owner: mircs
--

SELECT pg_catalog.setval('public.users__id_seq', 1, true);


--
-- Name: clicks clicks_pkey; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY public.clicks
    ADD CONSTRAINT clicks_pkey PRIMARY KEY (_id);


--
-- Name: cnn cnn_pkey; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY public.cnn
    ADD CONSTRAINT cnn_pkey PRIMARY KEY (_id);


--
-- Name: image_count image_count_pkey; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY public.image_count
    ADD CONSTRAINT image_count_pkey PRIMARY KEY (_id);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (_id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: users users_cookie_key; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_cookie_key UNIQUE (cookie);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: mircs
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (_id);


--
-- PostgreSQL database dump complete
--


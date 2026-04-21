--
-- PostgreSQL database dump
--

\restrict lAFrOr5xaaklMpovcOHqcFf5IfwT5VZojiYiZlJhuYBgXCl20nHcixDccorVVJy

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

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

ALTER TABLE IF EXISTS ONLY public.mfa_mfakey DROP CONSTRAINT IF EXISTS mfa_mfakey_user_id_6b721525_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_user_id_c564eba6_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.dashboard_incidentreport DROP CONSTRAINT IF EXISTS dashboard_incidentreport_created_by_id_b04d4f74_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.dashboard_incidentreport DROP CONSTRAINT IF EXISTS dashboard_incidentre_assigned_to_id_79f5ecda_fk_auth_user;
ALTER TABLE IF EXISTS ONLY public.dashboard_incidentauditlog DROP CONSTRAINT IF EXISTS dashboard_incidentauditlog_actor_id_157d053a_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.dashboard_incidentauditlog DROP CONSTRAINT IF EXISTS dashboard_incidentau_to_assigned_to_id_41a14441_fk_auth_user;
ALTER TABLE IF EXISTS ONLY public.dashboard_incidentauditlog DROP CONSTRAINT IF EXISTS dashboard_incidentau_incident_id_37cc59d2_fk_dashboard;
ALTER TABLE IF EXISTS ONLY public.dashboard_incidentauditlog DROP CONSTRAINT IF EXISTS dashboard_incidentau_from_assigned_to_id_9eeb2e68_fk_auth_user;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_group_id_97559544_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
ALTER TABLE IF EXISTS ONLY public.api_securityauditevent DROP CONSTRAINT IF EXISTS api_securityauditevent_actor_id_b9437454_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.api_alertrule DROP CONSTRAINT IF EXISTS api_alertrule_recipient_user_id_17a04008_fk_auth_user_id;
ALTER TABLE IF EXISTS ONLY public.api_alertevent DROP CONSTRAINT IF EXISTS api_alertevent_rule_id_378d3d20_fk_api_alertrule_id;
ALTER TABLE IF EXISTS ONLY public.api_alertevent DROP CONSTRAINT IF EXISTS api_alertevent_reading_id_8afe6803_fk_api_sensorreading_id;
DROP INDEX IF EXISTS public.mfa_mfakey_user_id_6b721525;
DROP INDEX IF EXISTS public.django_session_session_key_c0390e0f_like;
DROP INDEX IF EXISTS public.django_session_expire_date_a5c62663;
DROP INDEX IF EXISTS public.django_admin_log_user_id_c564eba6;
DROP INDEX IF EXISTS public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX IF EXISTS public.dashboard_incidentreport_created_by_id_b04d4f74;
DROP INDEX IF EXISTS public.dashboard_incidentreport_assigned_to_id_79f5ecda;
DROP INDEX IF EXISTS public.dashboard_incidentauditlog_to_assigned_to_id_41a14441;
DROP INDEX IF EXISTS public.dashboard_incidentauditlog_incident_id_37cc59d2;
DROP INDEX IF EXISTS public.dashboard_incidentauditlog_from_assigned_to_id_9eeb2e68;
DROP INDEX IF EXISTS public.dashboard_incidentauditlog_actor_id_157d053a;
DROP INDEX IF EXISTS public.auth_user_username_6821ab7c_like;
DROP INDEX IF EXISTS public.auth_user_user_permissions_user_id_a95ead1b;
DROP INDEX IF EXISTS public.auth_user_user_permissions_permission_id_1fbb5f2c;
DROP INDEX IF EXISTS public.auth_user_groups_user_id_6a12ed8b;
DROP INDEX IF EXISTS public.auth_user_groups_group_id_97559544;
DROP INDEX IF EXISTS public.auth_permission_content_type_id_2f476e4b;
DROP INDEX IF EXISTS public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX IF EXISTS public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX IF EXISTS public.auth_group_name_a6ea08ec_like;
DROP INDEX IF EXISTS public.api_sensorreading_timestamp_5624486f;
DROP INDEX IF EXISTS public.api_sensorr_timesta_7d4e8f_idx;
DROP INDEX IF EXISTS public.api_sensorr_sensor__9238f9_idx;
DROP INDEX IF EXISTS public.api_securityauditevent_event_type_07657f79_like;
DROP INDEX IF EXISTS public.api_securityauditevent_event_type_07657f79;
DROP INDEX IF EXISTS public.api_securityauditevent_created_at_b5bff9e8;
DROP INDEX IF EXISTS public.api_securityauditevent_actor_id_b9437454;
DROP INDEX IF EXISTS public.api_alertrule_recipient_user_id_17a04008;
DROP INDEX IF EXISTS public.api_alertevent_rule_id_378d3d20;
DROP INDEX IF EXISTS public.api_alertevent_reading_id_8afe6803;
ALTER TABLE IF EXISTS ONLY public.mfa_mfakey DROP CONSTRAINT IF EXISTS mfa_mfakey_pkey;
ALTER TABLE IF EXISTS ONLY public.django_session DROP CONSTRAINT IF EXISTS django_session_pkey;
ALTER TABLE IF EXISTS ONLY public.django_migrations DROP CONSTRAINT IF EXISTS django_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_pkey;
ALTER TABLE IF EXISTS ONLY public.django_content_type DROP CONSTRAINT IF EXISTS django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE IF EXISTS ONLY public.django_admin_log DROP CONSTRAINT IF EXISTS django_admin_log_pkey;
ALTER TABLE IF EXISTS ONLY public.dashboard_incidentreport DROP CONSTRAINT IF EXISTS dashboard_incidentreport_pkey;
ALTER TABLE IF EXISTS ONLY public.dashboard_incidentauditlog DROP CONSTRAINT IF EXISTS dashboard_incidentauditlog_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user DROP CONSTRAINT IF EXISTS auth_user_username_key;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_user_user_permissions DROP CONSTRAINT IF EXISTS auth_user_user_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user DROP CONSTRAINT IF EXISTS auth_user_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_user_id_group_id_94350c0c_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_user_groups DROP CONSTRAINT IF EXISTS auth_user_groups_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_permission DROP CONSTRAINT IF EXISTS auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_group_permissions DROP CONSTRAINT IF EXISTS auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE IF EXISTS ONLY public.auth_group DROP CONSTRAINT IF EXISTS auth_group_name_key;
ALTER TABLE IF EXISTS ONLY public.api_sensorreading DROP CONSTRAINT IF EXISTS api_sensorreading_sensor_id_timestamp_3bd478e5_uniq;
ALTER TABLE IF EXISTS ONLY public.api_sensorreading DROP CONSTRAINT IF EXISTS api_sensorreading_pkey;
ALTER TABLE IF EXISTS ONLY public.api_securityauditevent DROP CONSTRAINT IF EXISTS api_securityauditevent_pkey;
ALTER TABLE IF EXISTS ONLY public.api_alertrule DROP CONSTRAINT IF EXISTS api_alertrule_pkey;
ALTER TABLE IF EXISTS ONLY public.api_alertevent DROP CONSTRAINT IF EXISTS api_alertevent_pkey;
DROP TABLE IF EXISTS public.mfa_mfakey;
DROP TABLE IF EXISTS public.django_session;
DROP TABLE IF EXISTS public.django_migrations;
DROP TABLE IF EXISTS public.django_content_type;
DROP TABLE IF EXISTS public.django_admin_log;
DROP TABLE IF EXISTS public.dashboard_incidentreport;
DROP TABLE IF EXISTS public.dashboard_incidentauditlog;
DROP TABLE IF EXISTS public.auth_user_user_permissions;
DROP TABLE IF EXISTS public.auth_user_groups;
DROP TABLE IF EXISTS public.auth_user;
DROP TABLE IF EXISTS public.auth_permission;
DROP TABLE IF EXISTS public.auth_group_permissions;
DROP TABLE IF EXISTS public.auth_group;
DROP TABLE IF EXISTS public.api_sensorreading;
DROP TABLE IF EXISTS public.api_securityauditevent;
DROP TABLE IF EXISTS public.api_alertrule;
DROP TABLE IF EXISTS public.api_alertevent;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: api_alertevent; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.api_alertevent (
    id bigint NOT NULL,
    triggered_at timestamp with time zone NOT NULL,
    to_email character varying(254) NOT NULL,
    subject character varying(200) NOT NULL,
    body text NOT NULL,
    reading_id bigint NOT NULL,
    rule_id bigint NOT NULL
);


ALTER TABLE public.api_alertevent OWNER TO smartenv;

--
-- Name: api_alertevent_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.api_alertevent ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_alertevent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_alertrule; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.api_alertrule (
    id bigint NOT NULL,
    name character varying(120) NOT NULL,
    enabled boolean NOT NULL,
    sensor_id character varying(100) NOT NULL,
    metric character varying(40) NOT NULL,
    operator character varying(8) NOT NULL,
    threshold_number double precision,
    threshold_text character varying(80) NOT NULL,
    recipient_email character varying(254) NOT NULL,
    cooldown_minutes integer NOT NULL,
    last_triggered_at timestamp with time zone,
    subject_template character varying(200) NOT NULL,
    body_template text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    recipient_user_id integer,
    CONSTRAINT api_alertrule_cooldown_minutes_check CHECK ((cooldown_minutes >= 0))
);


ALTER TABLE public.api_alertrule OWNER TO smartenv;

--
-- Name: api_alertrule_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.api_alertrule ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_alertrule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_securityauditevent; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.api_securityauditevent (
    id bigint NOT NULL,
    event_type character varying(40) NOT NULL,
    outcome character varying(20) NOT NULL,
    detail text NOT NULL,
    path character varying(255) NOT NULL,
    method character varying(10) NOT NULL,
    ip_address character varying(64) NOT NULL,
    user_agent character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    actor_id integer
);


ALTER TABLE public.api_securityauditevent OWNER TO smartenv;

--
-- Name: api_securityauditevent_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.api_securityauditevent ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_securityauditevent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: api_sensorreading; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.api_sensorreading (
    id bigint NOT NULL,
    sensor_id character varying(100) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    quality character varying(50) NOT NULL,
    battery_life double precision,
    turbidity double precision,
    water_temperature double precision,
    wave_height double precision,
    wave_period double precision,
    retention_days integer NOT NULL,
    CONSTRAINT api_sensorreading_retention_days_check CHECK ((retention_days >= 0))
);


ALTER TABLE public.api_sensorreading OWNER TO smartenv;

--
-- Name: api_sensorreading_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.api_sensorreading ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.api_sensorreading_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO smartenv;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO smartenv;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO smartenv;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO smartenv;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO smartenv;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO smartenv;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: dashboard_incidentauditlog; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.dashboard_incidentauditlog (
    id bigint NOT NULL,
    action character varying(40) NOT NULL,
    from_status character varying(20) NOT NULL,
    to_status character varying(20) NOT NULL,
    comment text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    actor_id integer,
    from_assigned_to_id integer,
    incident_id bigint NOT NULL,
    to_assigned_to_id integer
);


ALTER TABLE public.dashboard_incidentauditlog OWNER TO smartenv;

--
-- Name: dashboard_incidentauditlog_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.dashboard_incidentauditlog ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.dashboard_incidentauditlog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: dashboard_incidentreport; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.dashboard_incidentreport (
    id bigint NOT NULL,
    title character varying(120) NOT NULL,
    beach_name character varying(120) NOT NULL,
    description text NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    created_by_id integer,
    assigned_to_id integer,
    closed_at timestamp with time zone,
    closed_comment text NOT NULL
);


ALTER TABLE public.dashboard_incidentreport OWNER TO smartenv;

--
-- Name: dashboard_incidentreport_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.dashboard_incidentreport ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.dashboard_incidentreport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO smartenv;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO smartenv;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO smartenv;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO smartenv;

--
-- Name: mfa_mfakey; Type: TABLE; Schema: public; Owner: smartenv
--

CREATE TABLE public.mfa_mfakey (
    id bigint NOT NULL,
    method character varying(8) NOT NULL,
    name character varying(32) NOT NULL,
    secret text NOT NULL,
    user_id integer NOT NULL,
    last_code character varying(32) NOT NULL
);


ALTER TABLE public.mfa_mfakey OWNER TO smartenv;

--
-- Name: mfa_mfakey_id_seq; Type: SEQUENCE; Schema: public; Owner: smartenv
--

ALTER TABLE public.mfa_mfakey ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.mfa_mfakey_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: api_alertevent; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.api_alertevent (id, triggered_at, to_email, subject, body, reading_id, rule_id) FROM stdin;
\.


--
-- Data for Name: api_alertrule; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.api_alertrule (id, name, enabled, sensor_id, metric, operator, threshold_number, threshold_text, recipient_email, cooldown_minutes, last_triggered_at, subject_template, body_template, created_at, updated_at, recipient_user_id) FROM stdin;
\.


--
-- Data for Name: api_securityauditevent; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.api_securityauditevent (id, event_type, outcome, detail, path, method, ip_address, user_agent, created_at, actor_id) FROM stdin;
\.


--
-- Data for Name: api_sensorreading; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.api_sensorreading (id, sensor_id, "timestamp", quality, battery_life, turbidity, water_temperature, wave_height, wave_period, retention_days) FROM stdin;
1	Montrose Beach	2026-04-13 08:34:16.873679+00	OK	9.4	1.18	20.3	0.08	3	365
2	Osterman Beach	2026-04-13 08:34:28.940334+00	OK	9.4	3.51	21.5	0.231	4	365
3	Ohio Street Beach	2026-04-13 08:34:41.012447+00	OK	9.4	4.97	21.9	0.241	7	365
4	Calumet Beach	2026-04-13 08:34:53.104796+00	OK	9.4	3.63	23.2	0.174	6	365
5	63rd Street Beach	2026-04-13 08:35:05.17921+00	OK	11	7.56	18.9	0.14	4	365
6	Rainbow Beach	2026-04-13 08:35:17.229476+00	OK	12.6	0.74	27.1	0.013	10	365
7	Montrose Beach	2026-04-13 08:35:29.292722+00	OK	11.9	3.36	14.4	0.298	4	365
8	Calumet Beach	2026-04-13 08:35:41.35264+00	OK	11.7	1.26	16.2	0.147	4	365
9	Montrose Beach	2026-04-13 08:35:53.438893+00	OK	11.9	2.72	14.5	0.306	3	365
10	Calumet Beach	2026-04-13 08:36:05.48817+00	OK	11.7	1.28	16.3	0.162	4	365
11	Calumet Beach	2026-04-13 08:36:17.556176+00	OK	11.7	1.32	16.5	0.185	4	365
12	Montrose Beach	2026-04-13 08:36:29.625915+00	OK	11.9	2.97	14.8	0.328	3	365
13	Montrose Beach	2026-04-13 08:36:41.707004+00	OK	11.9	4.3	14.5	0.328	3	365
14	Calumet Beach	2026-04-13 08:36:53.797477+00	OK	11.7	1.31	16.8	0.196	4	365
15	Calumet Beach	2026-04-13 08:37:05.87537+00	OK	11.7	1.37	17.1	0.194	4	365
16	Montrose Beach	2026-04-13 08:37:17.917642+00	OK	11.9	4.87	14.4	0.341	3	365
17	Calumet Beach	2026-04-13 08:37:29.975553+00	OK	11.7	1.48	17.2	0.203	4	365
18	Montrose Beach	2026-04-13 08:37:42.044323+00	OK	11.9	5.06	14.1	0.34	4	365
19	Calumet Beach	2026-04-13 08:37:54.153481+00	OK	11.7	1.8	17.1	0.188	4	365
20	Montrose Beach	2026-04-13 08:38:06.23206+00	OK	11.9	5.76	14.2	0.356	3	365
21	Calumet Beach	2026-04-13 08:38:18.30748+00	OK	11.7	1.82	17	0.194	4	365
22	Montrose Beach	2026-04-13 08:38:30.388032+00	OK	11.9	6.32	14.2	0.346	3	365
23	Montrose Beach	2026-04-13 08:38:42.468346+00	OK	11.9	6.89	14.4	0.38	4	365
24	Calumet Beach	2026-04-13 08:38:54.543656+00	OK	11.7	1.83	17	0.196	4	365
25	Calumet Beach	2026-04-13 08:39:06.588286+00	OK	11.7	1.9	16.8	0.181	4	365
26	Montrose Beach	2026-04-13 08:39:18.637913+00	OK	11.9	7.11	14.5	0.361	5	365
27	Calumet Beach	2026-04-13 08:39:30.681563+00	OK	11.7	1.83	16.7	0.18	4	365
28	Montrose Beach	2026-04-13 08:39:42.749772+00	OK	11.9	6.88	14.5	0.345	4	365
29	Montrose Beach	2026-04-13 08:39:54.834897+00	OK	11.9	7.32	14.3	0.331	4	365
30	Calumet Beach	2026-04-13 08:40:06.883244+00	OK	11.7	1.69	16.5	0.177	4	365
31	Calumet Beach	2026-04-13 08:40:18.930751+00	OK	11.7	1.62	16.3	0.159	4	365
32	Montrose Beach	2026-04-13 08:40:31.023154+00	OK	11.9	7.18	14.2	0.305	4	365
33	Montrose Beach	2026-04-13 08:40:43.111956+00	OK	11.9	6.35	14.2	0.321	3	365
34	Calumet Beach	2026-04-13 08:40:55.209426+00	OK	11.7	1.57	16.2	0.154	4	365
35	Montrose Beach	2026-04-13 08:41:07.2729+00	OK	11.8	6.78	14.1	0.285	4	365
36	Calumet Beach	2026-04-13 08:41:19.304878+00	OK	11.7	1.8	16.1	0.163	4	365
37	Calumet Beach	2026-04-13 08:41:31.367623+00	OK	11.7	1.82	16.1	0.156	4	365
38	Montrose Beach	2026-04-13 08:41:43.448453+00	OK	11.8	6.27	14.1	0.306	3	365
39	Montrose Beach	2026-04-13 08:41:55.539446+00	OK	11.8	5.63	14	0.282	3	365
40	Calumet Beach	2026-04-13 08:42:07.633982+00	OK	11.7	1.73	15.9	0.158	3	365
41	Calumet Beach	2026-04-13 08:42:19.682293+00	OK	11.7	1.73	15.9	0.151	3	365
42	Montrose Beach	2026-04-13 08:42:31.761288+00	OK	11.8	5.05	13.8	0.248	4	365
43	Montrose Beach	2026-04-13 08:42:43.825483+00	OK	11.8	5.73	13.8	0.235	4	365
44	Calumet Beach	2026-04-13 08:42:55.883177+00	OK	11.7	1.74	15.9	0.148	4	365
45	Calumet Beach	2026-04-13 08:43:07.922059+00	OK	11.7	1.77	15.8	0.146	4	365
46	Montrose Beach	2026-04-13 08:43:19.977803+00	OK	11.8	5.57	13.9	0.244	4	365
47	Calumet Beach	2026-04-13 08:43:32.034257+00	OK	11.7	1.64	15.9	0.125	4	365
48	Montrose Beach	2026-04-13 08:43:44.110665+00	OK	11.8	6.49	13.9	0.292	3	365
49	Calumet Beach	2026-04-13 08:43:56.194311+00	OK	11.7	1.75	16	0.129	4	365
50	Montrose Beach	2026-04-13 08:44:08.254528+00	OK	11.8	5.67	14.1	0.277	2	365
51	Calumet Beach	2026-04-13 08:44:20.306996+00	OK	11.7	1.59	16.2	0.141	4	365
52	Montrose Beach	2026-04-13 08:44:32.393761+00	OK	11.8	6.4	14.3	0.286	5	365
53	Montrose Beach	2026-04-13 08:44:44.457577+00	OK	11.8	6.19	14.6	0.301	3	365
54	Calumet Beach	2026-04-13 08:44:56.512207+00	OK	11.7	1.55	16.4	0.144	4	365
55	Montrose Beach	2026-04-13 08:45:08.550846+00	OK	11.8	6.28	14.8	0.282	5	365
56	Calumet Beach	2026-04-13 08:45:20.606088+00	OK	11.7	1.58	16.6	0.154	2	365
57	Calumet Beach	2026-04-13 08:45:32.647975+00	OK	11.7	1.44	16.7	0.159	5	365
58	Montrose Beach	2026-04-13 08:45:44.691697+00	OK	11.8	6.36	14.9	0.319	3	365
59	Montrose Beach	2026-04-13 08:45:56.76382+00	OK	11.8	5.98	15.1	0.296	3	365
60	Calumet Beach	2026-04-13 08:46:08.84464+00	OK	11.7	1.4	16.9	0.164	4	365
61	Calumet Beach	2026-04-13 08:46:20.887162+00	OK	11.7	1.35	16.9	0.17	4	365
62	Montrose Beach	2026-04-13 08:46:32.926448+00	OK	11.8	6.26	15.2	0.313	3	365
63	Montrose Beach	2026-04-13 08:46:44.971391+00	OK	11.8	7.06	15.5	0.288	3	365
64	Calumet Beach	2026-04-13 08:46:57.019504+00	OK	11.7	1.45	16.8	0.168	3	365
65	Montrose Beach	2026-04-13 08:47:09.115322+00	OK	11.8	6.51	15.3	0.298	3	365
66	Calumet Beach	2026-04-13 08:47:21.180721+00	OK	11.7	1.35	16.9	0.179	3	365
67	Calumet Beach	2026-04-13 08:47:33.241692+00	OK	11.7	1.39	16.8	0.175	3	365
68	Montrose Beach	2026-04-13 08:47:45.31093+00	OK	11.8	6.71	15.5	0.287	3	365
69	Calumet Beach	2026-04-13 08:47:57.38367+00	OK	11.7	1.46	16.7	0.182	4	365
70	Montrose Beach	2026-04-13 08:48:09.444296+00	OK	11.8	6.17	15.3	0.298	3	365
90	Montrose Beach	2026-04-13 08:51:51.338314+00	OK	11.8	5.98	15	0.26	3	365
91	Calumet Beach	2026-04-13 08:52:09.973626+00	OK	11.7	1.74	16.4	0.176	4	365
92	Calumet Beach	2026-04-13 08:52:22.038485+00	OK	11.7	1.53	16.4	0.193	4	365
93	Montrose Beach	2026-04-13 08:52:27.47562+00	OK	9.4	1.18	20.3	0.08	3	365
94	Montrose Beach	2026-04-13 08:52:34.088533+00	OK	11.8	5.92	15	0.26	3	365
95	Osterman Beach	2026-04-13 08:52:39.564468+00	OK	9.4	3.51	21.5	0.231	4	365
96	Montrose Beach	2026-04-13 08:52:46.158221+00	OK	11.8	6.51	14.9	0.261	3	365
97	Ohio Street Beach	2026-04-13 08:52:51.634016+00	OK	9.4	4.97	21.9	0.241	7	365
98	Calumet Beach	2026-04-13 08:52:58.233676+00	OK	11.7	1.72	16.3	0.176	4	365
99	Calumet Beach	2026-04-13 08:53:03.68652+00	OK	9.4	3.63	23.2	0.174	6	365
100	Calumet Beach	2026-04-13 08:53:10.328138+00	OK	11.7	1.77	16.2	0.168	3	365
101	63rd Street Beach	2026-04-13 08:53:15.785166+00	OK	11	7.56	18.9	0.14	4	365
102	Montrose Beach	2026-04-13 08:53:22.380027+00	OK	11.8	5.35	14.8	0.266	4	365
103	Rainbow Beach	2026-04-13 08:53:27.83376+00	OK	12.6	0.74	27.1	0.013	10	365
104	Montrose Beach	2026-04-13 08:53:34.442422+00	OK	11.8	5.66	14.8	0.253	4	365
105	Montrose Beach	2026-04-13 08:53:39.897346+00	OK	11.9	3.36	14.4	0.298	4	365
106	Calumet Beach	2026-04-13 08:53:46.517968+00	OK	11.7	1.6	16.2	0.152	3	365
107	Calumet Beach	2026-04-13 08:53:51.951561+00	OK	11.7	1.26	16.2	0.147	4	365
108	Calumet Beach	2026-04-13 08:53:58.579959+00	OK	11.7	1.53	16.1	0.144	3	365
109	Montrose Beach	2026-04-13 08:54:04.003426+00	OK	11.9	2.72	14.5	0.306	3	365
110	Montrose Beach	2026-04-13 08:54:10.633313+00	OK	11.8	5.53	14.7	0.219	3	365
111	Calumet Beach	2026-04-13 08:54:16.087026+00	OK	11.7	1.28	16.3	0.162	4	365
112	Montrose Beach	2026-04-13 08:54:22.735121+00	OK	11.8	5.53	14.7	0.22	4	365
113	Calumet Beach	2026-04-13 08:54:28.15895+00	OK	11.7	1.32	16.5	0.185	4	365
114	Calumet Beach	2026-04-13 08:54:34.799218+00	OK	11.7	1.71	16.1	0.132	3	365
115	Montrose Beach	2026-04-13 08:54:40.219651+00	OK	11.9	2.97	14.8	0.328	3	365
116	Montrose Beach	2026-04-13 08:54:46.867476+00	OK	11.8	5.58	14.8	0.228	3	365
117	Montrose Beach	2026-04-13 08:54:52.276021+00	OK	11.9	4.3	14.5	0.328	3	365
118	Calumet Beach	2026-04-13 08:54:58.932567+00	OK	11.7	1.68	16.2	0.127	3	365
119	Calumet Beach	2026-04-13 08:55:04.374952+00	OK	11.7	1.31	16.8	0.196	4	365
120	Montrose Beach	2026-04-13 08:55:10.997984+00	OK	11.8	5.36	15	0.223	3	365
121	Calumet Beach	2026-04-13 08:55:16.432604+00	OK	11.7	1.37	17.1	0.194	4	365
122	Calumet Beach	2026-04-13 08:55:23.058267+00	OK	11.6	1.59	16.3	0.108	3	365
123	Montrose Beach	2026-04-13 08:55:28.503719+00	OK	11.9	4.87	14.4	0.341	3	365
124	Montrose Beach	2026-04-13 08:55:35.135379+00	OK	11.8	5.03	15.2	0.198	3	365
125	Calumet Beach	2026-04-13 08:55:40.597158+00	OK	11.7	1.48	17.2	0.203	4	365
126	Calumet Beach	2026-04-13 08:55:47.203779+00	OK	11.6	1.52	16.6	0.111	3	365
127	Montrose Beach	2026-04-13 08:55:52.660077+00	OK	11.9	5.06	14.1	0.34	4	365
128	Montrose Beach	2026-04-13 08:55:59.290474+00	OK	11.8	5.28	15.5	0.202	3	365
129	Calumet Beach	2026-04-13 08:56:04.767202+00	OK	11.7	1.8	17.1	0.188	4	365
130	Calumet Beach	2026-04-13 08:56:11.361368+00	OK	11.6	1.45	16.8	0.107	3	365
131	Montrose Beach	2026-04-13 08:56:16.827146+00	OK	11.9	5.76	14.2	0.356	3	365
132	Calumet Beach	2026-04-13 08:56:23.450567+00	OK	11.6	1.46	17.2	0.116	3	365
133	Calumet Beach	2026-04-13 08:56:28.870234+00	OK	11.7	1.82	17	0.194	4	365
134	Montrose Beach	2026-04-13 08:56:35.529182+00	OK	11.8	5.04	15.8	0.193	3	365
135	Montrose Beach	2026-04-13 08:56:40.940352+00	OK	11.9	6.32	14.2	0.346	3	365
136	Calumet Beach	2026-04-13 08:56:47.608697+00	OK	11.6	1.52	17.4	0.108	3	365
137	Montrose Beach	2026-04-13 08:56:53.012172+00	OK	11.9	6.89	14.4	0.38	4	365
138	Montrose Beach	2026-04-13 08:56:59.689223+00	OK	11.8	4.71	16.1	0.199	3	365
139	Calumet Beach	2026-04-13 08:57:05.08413+00	OK	11.7	1.83	17	0.196	4	365
140	Calumet Beach	2026-04-13 08:57:11.742157+00	OK	11.6	1.58	17.5	0.115	3	365
141	Calumet Beach	2026-04-13 08:57:17.153217+00	OK	11.7	1.9	16.8	0.181	4	365
142	Montrose Beach	2026-04-13 08:57:23.808002+00	OK	11.8	4.43	16.4	0.226	2	365
143	Montrose Beach	2026-04-13 08:57:29.205999+00	OK	11.9	7.11	14.5	0.361	5	365
144	Calumet Beach	2026-04-13 08:57:35.875461+00	OK	11.6	1.52	17.8	0.14	2	365
145	Calumet Beach	2026-04-13 08:57:41.263431+00	OK	11.7	1.83	16.7	0.18	4	365
146	Montrose Beach	2026-04-13 08:57:47.93991+00	OK	11.8	4.62	16.7	0.196	2	365
147	Montrose Beach	2026-04-13 08:57:53.31567+00	OK	11.9	6.88	14.5	0.345	4	365
148	Calumet Beach	2026-04-13 08:58:00.002345+00	OK	11.6	1.48	17.7	0.129	3	365
149	Montrose Beach	2026-04-13 08:58:05.379478+00	OK	11.9	7.32	14.3	0.331	4	365
150	Montrose Beach	2026-04-13 08:58:12.058245+00	OK	11.8	4.41	16.8	0.229	2	365
151	Calumet Beach	2026-04-13 08:58:17.456458+00	OK	11.7	1.69	16.5	0.177	4	365
152	Montrose Beach	2026-04-13 08:58:24.106936+00	OK	11.8	4.31	16.8	0.23	3	365
153	Calumet Beach	2026-04-13 08:58:29.53442+00	OK	11.7	1.62	16.3	0.159	4	365
154	Calumet Beach	2026-04-13 08:58:36.160177+00	OK	11.6	1.42	17.6	0.141	2	365
155	Montrose Beach	2026-04-13 08:58:41.612977+00	OK	11.9	7.18	14.2	0.305	4	365
156	Montrose Beach	2026-04-13 08:58:48.237866+00	OK	11.8	4.16	16.7	0.219	2	365
157	Montrose Beach	2026-04-13 08:58:53.66939+00	OK	11.9	6.35	14.2	0.321	3	365
158	Calumet Beach	2026-04-13 08:59:00.325209+00	OK	11.6	1.43	17.7	0.141	3	365
159	Calumet Beach	2026-04-13 08:59:05.733554+00	OK	11.7	1.57	16.2	0.154	4	365
160	Montrose Beach	2026-04-13 08:59:12.392854+00	OK	11.8	4.4	16.8	0.201	2	365
161	Montrose Beach	2026-04-13 08:59:17.809419+00	OK	11.8	6.78	14.1	0.285	4	365
162	Calumet Beach	2026-04-13 08:59:24.451649+00	OK	11.6	1.39	17.7	0.147	2	365
163	Calumet Beach	2026-04-13 08:59:29.864919+00	OK	11.7	1.8	16.1	0.163	4	365
164	Calumet Beach	2026-04-13 08:59:36.548863+00	OK	11.6	1.44	17.6	0.163	3	365
165	Calumet Beach	2026-04-13 08:59:41.927391+00	OK	11.7	1.82	16.1	0.156	4	365
166	Montrose Beach	2026-04-13 08:59:48.620274+00	OK	11.8	4.05	16.7	0.201	2	365
167	Montrose Beach	2026-04-13 08:59:53.992937+00	OK	11.8	6.27	14.1	0.306	3	365
168	Calumet Beach	2026-04-13 09:00:00.680963+00	OK	11.6	1.41	17.8	0.157	3	365
169	Montrose Beach	2026-04-13 09:00:06.056723+00	OK	11.8	5.63	14	0.282	3	365
170	Montrose Beach	2026-04-13 09:00:12.763076+00	OK	11.8	4.17	16.7	0.178	2	365
171	Calumet Beach	2026-04-13 09:00:18.125548+00	OK	11.7	1.73	15.9	0.158	3	365
172	Montrose Beach	2026-04-13 09:00:24.824827+00	OK	11.8	3.83	16.5	0.16	2	365
173	Calumet Beach	2026-04-13 09:00:30.166525+00	OK	11.7	1.73	15.9	0.151	3	365
174	Calumet Beach	2026-04-13 09:00:36.887573+00	OK	11.6	1.45	17.8	0.144	3	365
175	Montrose Beach	2026-04-13 09:00:42.219981+00	OK	11.8	5.05	13.8	0.248	4	365
176	Montrose Beach	2026-04-13 09:00:48.950604+00	OK	11.8	3.94	16.5	0.182	3	365
177	Montrose Beach	2026-04-13 09:00:54.286602+00	OK	11.8	5.73	13.8	0.235	4	365
178	Calumet Beach	2026-04-13 09:01:01.039766+00	OK	11.6	1.44	17.6	0.155	3	365
179	Calumet Beach	2026-04-13 09:01:06.354802+00	OK	11.7	1.74	15.9	0.148	4	365
180	Montrose Beach	2026-04-13 09:01:13.143892+00	OK	11.8	3.63	16.5	0.168	2	365
181	Calumet Beach	2026-04-13 09:01:18.433091+00	OK	11.7	1.77	15.8	0.146	4	365
182	Calumet Beach	2026-04-13 09:01:25.225516+00	OK	11.6	1.58	17.2	0.144	3	365
183	Montrose Beach	2026-04-13 09:01:30.502869+00	OK	11.8	5.57	13.9	0.244	4	365
184	Montrose Beach	2026-04-13 09:01:37.259733+00	OK	11.8	3.68	16.4	0.152	2	365
185	Calumet Beach	2026-04-13 09:01:42.566131+00	OK	11.7	1.64	15.9	0.125	4	365
186	Calumet Beach	2026-04-13 09:01:49.321808+00	OK	11.6	1.43	17.1	0.132	3	365
187	Montrose Beach	2026-04-13 09:01:54.647447+00	OK	11.8	6.49	13.9	0.292	3	365
188	Montrose Beach	2026-04-13 09:02:01.41868+00	OK	11.8	3.56	16.3	0.144	3	365
189	Calumet Beach	2026-04-13 09:02:06.724491+00	OK	11.7	1.75	16	0.129	4	365
190	Calumet Beach	2026-04-13 09:02:13.491359+00	OK	11.6	1.44	17	0.137	3	365
191	Montrose Beach	2026-04-13 09:02:18.780952+00	OK	11.8	5.67	14.1	0.277	2	365
192	Calumet Beach	2026-04-13 09:02:25.557876+00	OK	11.6	1.5	16.8	0.136	3	365
193	Calumet Beach	2026-04-13 09:02:30.85315+00	OK	11.7	1.59	16.2	0.141	4	365
194	Montrose Beach	2026-04-13 09:02:37.644349+00	OK	11.8	3.38	16.2	0.147	3	365
195	Montrose Beach	2026-04-13 09:02:42.918763+00	OK	11.8	6.4	14.3	0.286	5	365
196	Montrose Beach	2026-04-13 09:02:49.721727+00	OK	11.8	3.08	16	0.166	3	365
197	Montrose Beach	2026-04-13 09:02:54.980899+00	OK	11.8	6.19	14.6	0.301	3	365
198	Calumet Beach	2026-04-13 09:03:01.813977+00	OK	11.6	1.71	16.8	0.133	4	365
199	Calumet Beach	2026-04-13 09:03:07.048733+00	OK	11.7	1.55	16.4	0.144	4	365
200	Calumet Beach	2026-04-13 09:03:13.891012+00	OK	11.6	1.58	16.7	0.134	3	365
201	Montrose Beach	2026-04-13 09:03:19.105112+00	OK	11.8	6.28	14.8	0.282	5	365
202	Montrose Beach	2026-04-13 09:03:25.96742+00	OK	11.8	3	16	0.161	2	365
203	Calumet Beach	2026-04-13 09:03:31.148838+00	OK	11.7	1.58	16.6	0.154	2	365
204	Montrose Beach	2026-04-13 09:03:38.046226+00	OK	11.8	3.11	15.9	0.163	3	365
205	Calumet Beach	2026-04-13 09:03:43.20328+00	OK	11.7	1.44	16.7	0.159	5	365
206	Calumet Beach	2026-04-13 09:03:50.112549+00	OK	11.6	2.2	17	0.127	3	365
207	Montrose Beach	2026-04-13 09:03:55.290445+00	OK	11.8	6.36	14.9	0.319	3	365
208	Calumet Beach	2026-04-13 09:04:02.187569+00	OK	11.6	1.68	16.8	0.118	3	365
209	Montrose Beach	2026-04-13 09:04:07.386105+00	OK	11.8	5.98	15.1	0.296	3	365
210	Montrose Beach	2026-04-13 09:04:14.277718+00	OK	11.8	3.16	16	0.147	3	365
211	Calumet Beach	2026-04-13 09:04:19.43738+00	OK	11.7	1.4	16.9	0.164	4	365
212	Calumet Beach	2026-04-13 09:04:26.327683+00	OK	11.6	1.7	17	0.113	3	365
213	Calumet Beach	2026-04-13 09:04:31.505225+00	OK	11.7	1.35	16.9	0.17	4	365
214	Montrose Beach	2026-04-13 09:04:38.379201+00	OK	11.8	3.18	16	0.138	3	365
215	Montrose Beach	2026-04-13 09:04:43.578613+00	OK	11.8	6.26	15.2	0.313	3	365
216	Calumet Beach	2026-04-13 09:04:50.447293+00	OK	11.6	1.62	17.1	0.1	3	365
217	Montrose Beach	2026-04-13 09:04:55.64015+00	OK	11.8	7.06	15.5	0.288	3	365
218	Montrose Beach	2026-04-13 09:05:02.510165+00	OK	11.8	3.07	16.2	0.145	3	365
219	Calumet Beach	2026-04-13 09:05:07.711509+00	OK	11.7	1.45	16.8	0.168	3	365
220	Montrose Beach	2026-04-13 09:05:14.587831+00	OK	11.8	2.88	16.5	0.144	3	365
221	Montrose Beach	2026-04-13 09:05:19.75593+00	OK	11.8	6.51	15.3	0.298	3	365
222	Calumet Beach	2026-04-13 09:05:26.670978+00	OK	11.6	1.66	17.4	0.097	3	365
223	Calumet Beach	2026-04-13 09:05:31.833054+00	OK	11.7	1.35	16.9	0.179	3	365
224	Montrose Beach	2026-04-13 09:05:38.743162+00	OK	11.8	2.91	16.8	0.158	4	365
225	Calumet Beach	2026-04-13 09:05:43.909915+00	OK	11.7	1.39	16.8	0.175	3	365
226	Calumet Beach	2026-04-13 09:05:50.837118+00	OK	11.6	1.76	17.8	0.096	3	365
227	Montrose Beach	2026-04-13 09:05:55.980001+00	OK	11.8	6.71	15.5	0.287	3	365
228	Montrose Beach	2026-04-13 09:06:02.906248+00	OK	11.8	2.49	17.3	0.131	2	365
229	Calumet Beach	2026-04-13 09:06:08.02166+00	OK	11.7	1.46	16.7	0.182	4	365
230	Calumet Beach	2026-04-13 09:06:14.993281+00	OK	11.6	1.31	18	0.109	2	365
231	Montrose Beach	2026-04-13 09:06:20.078691+00	OK	11.8	6.17	15.3	0.298	3	365
232	Montrose Beach	2026-04-13 09:06:27.062081+00	OK	11.8	2.85	17.6	0.15	3	365
233	Montrose Beach	2026-04-13 09:06:32.148319+00	OK	11.8	5.9	15.4	0.286	3	365
234	Calumet Beach	2026-04-13 09:06:39.156449+00	OK	11.6	1.31	18.4	0.106	3	365
235	Calumet Beach	2026-04-13 09:06:44.228807+00	OK	11.7	1.4	16.8	0.189	3	365
236	Montrose Beach	2026-04-13 09:06:51.241684+00	OK	11.8	3.57	19.2	0.156	3	365
237	Montrose Beach	2026-04-13 09:06:56.291811+00	OK	11.8	6.03	15.2	0.266	3	365
238	Calumet Beach	2026-04-13 09:07:03.316654+00	OK	11.6	1.19	19.2	0.115	3	365
239	Calumet Beach	2026-04-13 09:07:08.353263+00	OK	11.7	1.51	16.9	0.177	4	365
240	Calumet Beach	2026-04-13 09:07:15.402193+00	OK	11.6	1.25	19.3	0.11	2	365
241	Montrose Beach	2026-04-13 09:07:20.412372+00	OK	11.8	5.71	15.2	0.262	3	365
242	Montrose Beach	2026-04-13 09:07:27.447153+00	OK	11.7	3.68	19.7	0.158	2	365
243	Calumet Beach	2026-04-13 09:07:32.479921+00	OK	11.7	1.55	16.8	0.194	3	365
244	Montrose Beach	2026-04-13 09:07:39.507023+00	OK	11.8	3.11	20.1	0.215	4	365
245	Calumet Beach	2026-04-13 09:07:44.546263+00	OK	11.7	1.79	16.6	0.21	4	365
246	Calumet Beach	2026-04-13 09:07:51.555767+00	OK	11.6	1.16	19.8	0.166	2	365
247	Montrose Beach	2026-04-13 09:07:56.599492+00	OK	11.8	6.09	15.2	0.234	3	365
248	Calumet Beach	2026-04-13 09:08:03.623238+00	OK	11.6	1.27	20.3	0.158	2	365
249	Montrose Beach	2026-04-13 09:08:08.667857+00	OK	11.8	5.98	15	0.26	3	365
250	Montrose Beach	2026-04-13 09:08:15.701266+00	OK	11.8	2.54	19.4	0.243	2	365
251	Calumet Beach	2026-04-13 09:08:20.735892+00	OK	11.7	1.74	16.4	0.176	4	365
252	Calumet Beach	2026-04-13 09:08:27.763664+00	OK	11.6	1.65	21	0.226	3	365
253	Calumet Beach	2026-04-13 09:08:32.802577+00	OK	11.7	1.53	16.4	0.193	4	365
254	Montrose Beach	2026-04-13 09:08:39.826055+00	OK	11.8	2.64	18.4	0.218	2	365
255	Montrose Beach	2026-04-13 09:08:44.866786+00	OK	11.8	5.92	15	0.26	3	365
256	Montrose Beach	2026-04-13 09:08:51.898452+00	OK	11.8	3.82	19.5	0.205	3	365
257	Montrose Beach	2026-04-13 09:08:56.924857+00	OK	11.8	6.51	14.9	0.261	3	365
258	Calumet Beach	2026-04-13 09:09:03.961111+00	OK	11.6	1.43	20.6	0.18	3	365
259	Calumet Beach	2026-04-13 09:09:08.962575+00	OK	11.7	1.72	16.3	0.176	4	365
260	Calumet Beach	2026-04-13 09:09:16.027613+00	OK	11.6	1.38	20.4	0.156	3	365
261	Calumet Beach	2026-04-13 09:09:21.008787+00	OK	11.7	1.77	16.2	0.168	3	365
262	Montrose Beach	2026-04-13 09:09:28.091258+00	OK	11.8	2.66	18.1	0.211	3	365
263	Montrose Beach	2026-04-13 09:09:33.064559+00	OK	11.8	5.35	14.8	0.266	4	365
264	Calumet Beach	2026-04-13 09:09:40.174323+00	OK	11.6	1.77	20.3	0.178	3	365
265	Montrose Beach	2026-04-13 09:09:45.097557+00	OK	11.8	5.66	14.8	0.253	4	365
266	Montrose Beach	2026-04-13 09:09:52.25994+00	OK	11.8	2.49	17.7	0.22	3	365
267	Calumet Beach	2026-04-13 09:09:57.170129+00	OK	11.7	1.6	16.2	0.152	3	365
268	Calumet Beach	2026-04-13 09:10:04.323096+00	OK	11.6	1.43	19.6	0.177	3	365
269	Calumet Beach	2026-04-13 09:10:09.224309+00	OK	11.7	1.53	16.1	0.144	3	365
270	Montrose Beach	2026-04-13 09:10:16.39317+00	OK	11.8	2.18	17	0.2	3	365
271	Montrose Beach	2026-04-13 09:10:21.279764+00	OK	11.8	5.53	14.7	0.219	3	365
272	Calumet Beach	2026-04-13 09:10:28.464806+00	OK	11.6	1.38	19.2	0.163	3	365
273	Montrose Beach	2026-04-13 09:10:33.359626+00	OK	11.8	5.53	14.7	0.22	4	365
274	Montrose Beach	2026-04-13 09:10:40.535199+00	OK	11.8	2.09	16.7	0.204	3	365
275	Calumet Beach	2026-04-13 09:10:45.407892+00	OK	11.7	1.71	16.1	0.132	3	365
276	Montrose Beach	2026-04-13 09:10:52.594299+00	OK	11.7	2.04	16.3	0.194	2	365
277	Montrose Beach	2026-04-13 09:10:57.465053+00	OK	11.8	5.58	14.8	0.228	3	365
278	Calumet Beach	2026-04-13 09:11:04.674987+00	OK	11.6	1.56	19.3	0.173	3	365
279	Calumet Beach	2026-04-13 09:11:09.535263+00	OK	11.7	1.68	16.2	0.127	3	365
280	Montrose Beach	2026-04-13 09:11:16.740581+00	OK	11.8	1.95	16.2	0.191	3	365
281	Montrose Beach	2026-04-13 09:11:21.578948+00	OK	11.8	5.36	15	0.223	3	365
282	Calumet Beach	2026-04-13 09:11:28.807211+00	OK	11.6	1.43	19.1	0.16	3	365
283	Calumet Beach	2026-04-13 09:11:33.627204+00	OK	11.6	1.59	16.3	0.108	3	365
284	Montrose Beach	2026-04-13 09:11:40.893319+00	OK	11.7	1.7	16	0.192	3	365
285	Montrose Beach	2026-04-13 09:11:45.675908+00	OK	11.8	5.03	15.2	0.198	3	365
286	Calumet Beach	2026-04-13 09:11:52.953968+00	OK	11.6	1.37	18.6	0.17	3	365
287	Calumet Beach	2026-04-13 09:11:57.746903+00	OK	11.6	1.52	16.6	0.111	3	365
288	Montrose Beach	2026-04-13 09:12:05.024548+00	OK	11.7	1.16	15.7	0.186	3	365
289	Montrose Beach	2026-04-13 09:12:09.815387+00	OK	11.8	5.28	15.5	0.202	3	365
290	Calumet Beach	2026-04-13 09:12:17.095644+00	OK	11.6	1.45	18.2	0.183	3	365
291	Calumet Beach	2026-04-13 09:12:21.886013+00	OK	11.6	1.45	16.8	0.107	3	365
292	Calumet Beach	2026-04-13 09:12:29.173346+00	OK	11.6	1.56	17.9	0.17	3	365
293	Calumet Beach	2026-04-13 09:12:33.965261+00	OK	11.6	1.46	17.2	0.116	3	365
294	Montrose Beach	2026-04-13 09:12:41.251167+00	OK	11.7	0.86	15.4	0.176	3	365
295	Montrose Beach	2026-04-13 09:12:46.01251+00	OK	11.8	5.04	15.8	0.193	3	365
296	Montrose Beach	2026-04-13 09:12:53.316481+00	OK	11.7	0.62	15.3	0.162	3	365
297	Calumet Beach	2026-04-13 09:12:58.074423+00	OK	11.6	1.52	17.4	0.108	3	365
298	Calumet Beach	2026-04-13 09:13:05.401459+00	OK	11.6	1.65	17.8	0.174	3	365
299	Montrose Beach	2026-04-13 09:13:10.1496+00	OK	11.8	4.71	16.1	0.199	3	365
300	Montrose Beach	2026-04-13 09:13:17.476042+00	OK	11.7	0.54	15.1	0.154	3	365
301	Calumet Beach	2026-04-13 09:13:22.210465+00	OK	11.6	1.58	17.5	0.115	3	365
302	Calumet Beach	2026-04-13 09:13:29.526132+00	OK	11.6	1.5	17.7	0.172	3	365
303	Montrose Beach	2026-04-13 09:13:34.295647+00	OK	11.8	4.43	16.4	0.226	2	365
304	Calumet Beach	2026-04-13 09:13:41.598609+00	OK	11.6	1.44	17.7	0.169	3	365
305	Calumet Beach	2026-04-13 09:13:46.377417+00	OK	11.6	1.52	17.8	0.14	2	365
306	Montrose Beach	2026-04-13 09:13:53.661459+00	OK	11.7	0.49	15.1	0.152	6	365
307	Montrose Beach	2026-04-13 09:13:58.466323+00	OK	11.8	4.62	16.7	0.196	2	365
308	Calumet Beach	2026-04-13 09:14:05.734298+00	OK	11.6	1.38	17.8	0.168	3	365
309	Calumet Beach	2026-04-13 09:14:10.526179+00	OK	11.6	1.48	17.7	0.129	3	365
310	Montrose Beach	2026-04-13 09:14:17.798699+00	OK	11.7	0.43	15.2	0.151	3	365
311	Montrose Beach	2026-04-13 09:14:22.594057+00	OK	11.8	4.41	16.8	0.229	2	365
312	Montrose Beach	2026-04-13 09:14:29.898557+00	OK	11.7	0.36	15.3	0.16	3	365
313	Montrose Beach	2026-04-13 09:14:34.670986+00	OK	11.8	4.31	16.8	0.23	3	365
314	Calumet Beach	2026-04-13 09:14:41.959735+00	OK	11.6	1.39	18	0.151	3	365
315	Calumet Beach	2026-04-13 09:14:46.746579+00	OK	11.6	1.42	17.6	0.141	2	365
316	Montrose Beach	2026-04-13 09:14:54.026779+00	OK	11.7	0.33	15.6	0.163	3	365
317	Montrose Beach	2026-04-13 09:14:58.803499+00	OK	11.8	4.16	16.7	0.219	2	365
318	Calumet Beach	2026-04-13 09:15:06.104666+00	OK	11.6	1.43	18.2	0.127	3	365
319	Calumet Beach	2026-04-13 09:15:10.855184+00	OK	11.6	1.43	17.7	0.141	3	365
320	Montrose Beach	2026-04-13 09:15:18.16342+00	OK	11.7	0.33	15.8	0.175	3	365
321	Montrose Beach	2026-04-13 09:15:22.933463+00	OK	11.8	4.4	16.8	0.201	2	365
322	Calumet Beach	2026-04-13 09:15:30.261226+00	OK	11.6	1.34	18.2	0.126	3	365
323	Calumet Beach	2026-04-13 09:15:35.021604+00	OK	11.6	1.39	17.7	0.147	2	365
324	Calumet Beach	2026-04-13 09:15:42.346217+00	OK	11.6	1.31	18.5	0.123	2	365
325	Calumet Beach	2026-04-13 09:15:47.103942+00	OK	11.6	1.44	17.6	0.163	3	365
326	Montrose Beach	2026-04-13 09:15:54.411253+00	OK	11.7	0.4	16	0.155	3	365
327	Montrose Beach	2026-04-13 09:15:59.169233+00	OK	11.8	4.05	16.7	0.201	2	365
328	Calumet Beach	2026-04-13 09:16:06.464369+00	OK	11.6	1.29	18.8	0.117	6	365
329	Calumet Beach	2026-04-13 09:16:11.258991+00	OK	11.6	1.41	17.8	0.157	3	365
330	Montrose Beach	2026-04-13 09:16:18.550962+00	OK	11.7	0.35	16.2	0.156	3	365
331	Montrose Beach	2026-04-13 09:16:23.329503+00	OK	11.8	4.17	16.7	0.178	2	365
332	Calumet Beach	2026-04-13 09:16:30.629409+00	OK	11.6	1.27	18.9	0.119	3	365
333	Montrose Beach	2026-04-13 09:16:35.40544+00	OK	11.8	3.83	16.5	0.16	2	365
334	Montrose Beach	2026-04-13 09:16:42.692892+00	OK	11.7	0.32	16.3	0.138	3	365
335	Calumet Beach	2026-04-13 09:16:47.46471+00	OK	11.6	1.45	17.8	0.144	3	365
336	Calumet Beach	2026-04-13 09:16:54.748006+00	OK	11.6	1.19	18.8	0.113	3	365
337	Montrose Beach	2026-04-13 09:16:59.518946+00	OK	11.8	3.94	16.5	0.182	3	365
338	Montrose Beach	2026-04-13 09:17:06.811566+00	OK	11.7	0.36	16.3	0.165	3	365
339	Calumet Beach	2026-04-13 09:17:11.591552+00	OK	11.6	1.44	17.6	0.155	3	365
340	Calumet Beach	2026-04-13 09:17:18.86934+00	OK	11.6	1.31	19.1	0.122	2	365
341	Montrose Beach	2026-04-13 09:17:23.66428+00	OK	11.8	3.63	16.5	0.168	2	365
342	Montrose Beach	2026-04-13 09:17:30.926046+00	OK	11.7	0.43	16.3	0.145	2	365
343	Calumet Beach	2026-04-13 09:17:35.739465+00	OK	11.6	1.58	17.2	0.144	3	365
344	Calumet Beach	2026-04-13 09:17:42.995755+00	OK	11.6	1.44	19.2	0.115	2	365
345	Montrose Beach	2026-04-13 09:17:47.80276+00	OK	11.8	3.68	16.4	0.152	2	365
346	Montrose Beach	2026-04-13 09:17:55.083046+00	OK	11.7	0.49	16.3	0.179	4	365
347	Calumet Beach	2026-04-13 09:17:59.902051+00	OK	11.6	1.43	17.1	0.132	3	365
348	Montrose Beach	2026-04-13 09:18:07.181224+00	OK	11.7	0.5	16.4	0.12	7	365
349	Montrose Beach	2026-04-13 09:18:11.974843+00	OK	11.8	3.56	16.3	0.144	3	365
350	Calumet Beach	2026-04-13 09:18:19.262307+00	OK	11.6	1.25	18.7	0.109	9	365
351	Calumet Beach	2026-04-13 09:18:24.02063+00	OK	11.6	1.44	17	0.137	3	365
352	Montrose Beach	2026-04-13 09:18:31.344162+00	OK	11.7	0.53	16.2	0.123	6	365
353	Calumet Beach	2026-04-13 09:18:36.068093+00	OK	11.6	1.5	16.8	0.136	3	365
354	Calumet Beach	2026-04-13 09:18:43.427118+00	OK	11.6	1.12	18.3	0.139	2	365
355	Montrose Beach	2026-04-13 09:18:48.126544+00	OK	11.8	3.38	16.2	0.147	3	365
356	Montrose Beach	2026-04-13 09:18:55.483377+00	OK	11.7	0.55	16.1	0.106	5	365
357	Montrose Beach	2026-04-13 09:19:00.223199+00	OK	11.8	3.08	16	0.166	3	365
358	Calumet Beach	2026-04-13 09:19:07.569539+00	OK	11.6	1.14	18.3	0.133	2	365
359	Calumet Beach	2026-04-13 09:19:12.296298+00	OK	11.6	1.71	16.8	0.133	4	365
360	Montrose Beach	2026-04-13 09:19:19.616314+00	OK	11.7	0.55	16.2	0.116	3	365
361	Calumet Beach	2026-04-13 09:19:24.379545+00	OK	11.6	1.58	16.7	0.134	3	365
362	Calumet Beach	2026-04-13 09:19:31.686583+00	OK	11.6	1.11	18.3	0.103	2	365
363	Montrose Beach	2026-04-13 09:19:36.472606+00	OK	11.8	3	16	0.161	2	365
364	Montrose Beach	2026-04-13 09:19:43.779475+00	OK	11.7	0.44	16.3	0.111	3	365
365	Montrose Beach	2026-04-13 09:19:48.544333+00	OK	11.8	3.11	15.9	0.163	3	365
366	Calumet Beach	2026-04-13 09:19:55.852534+00	OK	11.6	1.06	18.1	0.095	3	365
367	Calumet Beach	2026-04-13 09:20:00.615633+00	OK	11.6	2.2	17	0.127	3	365
368	Calumet Beach	2026-04-13 09:20:07.923264+00	OK	11.6	1.07	18.1	0.128	2	365
369	Calumet Beach	2026-04-13 09:20:12.665056+00	OK	11.6	1.68	16.8	0.118	3	365
370	Montrose Beach	2026-04-13 09:20:19.99082+00	OK	11.7	0.43	16.4	0.107	9	365
371	Montrose Beach	2026-04-13 09:20:24.743471+00	OK	11.8	3.16	16	0.147	3	365
372	Calumet Beach	2026-04-13 09:20:32.049037+00	OK	11.6	1.07	18.1	0.136	2	365
373	Calumet Beach	2026-04-13 09:20:36.792968+00	OK	11.6	1.7	17	0.113	3	365
374	Montrose Beach	2026-04-13 09:20:44.136198+00	OK	11.7	0.44	16.1	0.11	7	365
375	Montrose Beach	2026-04-13 09:20:48.836891+00	OK	11.8	3.18	16	0.138	3	365
376	Montrose Beach	2026-04-13 09:20:56.179551+00	OK	11.7	0.44	16.2	0.105	3	365
377	Calumet Beach	2026-04-13 09:21:00.880877+00	OK	11.6	1.62	17.1	0.1	3	365
378	Calumet Beach	2026-04-13 09:21:08.210084+00	OK	11.6	1.03	18	0.127	2	365
379	Montrose Beach	2026-04-13 09:21:12.923594+00	OK	11.8	3.07	16.2	0.145	3	365
380	Montrose Beach	2026-04-13 09:21:20.258967+00	OK	11.7	0.43	16.1	0.105	3	365
381	Montrose Beach	2026-04-13 09:21:25.02159+00	OK	11.8	2.88	16.5	0.144	3	365
382	Calumet Beach	2026-04-13 09:21:32.331408+00	OK	11.6	1.04	18	0.111	2	365
383	Calumet Beach	2026-04-13 09:21:37.061211+00	OK	11.6	1.66	17.4	0.097	3	365
384	Calumet Beach	2026-04-13 09:21:44.397972+00	OK	11.6	1.06	18	0.103	2	365
385	Montrose Beach	2026-04-13 09:21:49.143373+00	OK	11.8	2.91	16.8	0.158	4	365
386	Montrose Beach	2026-04-13 09:21:56.475417+00	OK	11.7	0.44	16.2	0.098	3	365
387	Calumet Beach	2026-04-13 09:22:01.234793+00	OK	11.6	1.76	17.8	0.096	3	365
388	Montrose Beach	2026-04-13 09:22:08.548105+00	OK	11.7	0.42	16.3	0.108	4	365
389	Montrose Beach	2026-04-13 09:22:13.28077+00	OK	11.8	2.49	17.3	0.131	2	365
390	Calumet Beach	2026-04-13 09:22:20.602593+00	OK	11.6	1.02	17.9	0.102	2	365
391	Calumet Beach	2026-04-13 09:22:25.360582+00	OK	11.6	1.31	18	0.109	2	365
392	Montrose Beach	2026-04-13 09:22:32.664486+00	OK	11.7	0.48	16.3	0.101	4	365
393	Montrose Beach	2026-04-13 09:22:37.44779+00	OK	11.8	2.85	17.6	0.15	3	365
394	Calumet Beach	2026-04-13 09:22:44.726576+00	OK	11.6	1	17.8	0.098	2	365
395	Calumet Beach	2026-04-13 09:22:49.526502+00	OK	11.6	1.31	18.4	0.106	3	365
396	Calumet Beach	2026-04-13 09:22:56.802219+00	OK	11.6	0.96	17.8	0.111	2	365
397	Montrose Beach	2026-04-13 09:23:01.597696+00	OK	11.8	3.57	19.2	0.156	3	365
398	Montrose Beach	2026-04-13 09:23:08.864239+00	OK	11.7	0.39	16.4	0.099	3	365
399	Calumet Beach	2026-04-13 09:23:13.687309+00	OK	11.6	1.19	19.2	0.115	3	365
400	Calumet Beach	2026-04-13 09:23:20.9477+00	OK	11.6	0.99	18	0.126	2	365
401	Calumet Beach	2026-04-13 09:23:25.757054+00	OK	11.6	1.25	19.3	0.11	2	365
402	Montrose Beach	2026-04-13 09:23:33.026312+00	OK	11.7	0.42	16.4	0.098	3	365
403	Montrose Beach	2026-04-13 09:23:37.827147+00	OK	11.7	3.68	19.7	0.158	2	365
404	Montrose Beach	2026-04-13 09:23:45.090293+00	OK	11.7	0.36	16.1	0.095	4	365
405	Montrose Beach	2026-04-13 09:23:49.886357+00	OK	11.8	3.11	20.1	0.215	4	365
406	Calumet Beach	2026-04-13 09:23:57.141982+00	OK	11.5	0.98	18.1	0.127	2	365
407	Calumet Beach	2026-04-13 09:24:01.958246+00	OK	11.6	1.16	19.8	0.166	2	365
408	Calumet Beach	2026-04-13 09:24:09.206418+00	OK	11.5	1.01	18.2	0.128	3	365
409	Calumet Beach	2026-04-13 09:24:14.026191+00	OK	11.6	1.27	20.3	0.158	2	365
410	Montrose Beach	2026-04-13 09:24:21.26283+00	OK	11.7	0.42	16.2	0.106	3	365
411	Montrose Beach	2026-04-13 09:24:26.096175+00	OK	11.8	2.54	19.4	0.243	2	365
412	Calumet Beach	2026-04-13 09:24:33.335584+00	OK	11.5	0.99	18.2	0.131	3	365
413	Calumet Beach	2026-04-13 09:24:38.164308+00	OK	11.6	1.65	21	0.226	3	365
414	Montrose Beach	2026-04-13 09:24:45.433891+00	OK	11.7	0.39	16.6	0.118	4	365
415	Montrose Beach	2026-04-13 09:24:50.248438+00	OK	11.8	2.64	18.4	0.218	2	365
416	Calumet Beach	2026-04-13 09:24:57.509646+00	OK	11.5	0.97	18.3	0.114	2	365
417	Montrose Beach	2026-04-13 09:25:02.331736+00	OK	11.8	3.82	19.5	0.205	3	365
418	Montrose Beach	2026-04-13 09:25:09.586048+00	OK	11.7	0.37	16.5	0.118	3	365
419	Calumet Beach	2026-04-13 09:25:14.386468+00	OK	11.6	1.43	20.6	0.18	3	365
420	Montrose Beach	2026-04-13 09:25:21.641403+00	OK	11.7	0.36	16.8	0.122	4	365
421	Calumet Beach	2026-04-13 09:25:26.475402+00	OK	11.6	1.38	20.4	0.156	3	365
422	Calumet Beach	2026-04-13 09:25:33.705101+00	OK	11.5	0.96	18.4	0.111	3	365
423	Montrose Beach	2026-04-13 09:25:38.552077+00	OK	11.8	2.66	18.1	0.211	3	365
424	Montrose Beach	2026-04-13 09:25:45.781842+00	OK	11.7	0.39	17.7	0.113	4	365
425	Calumet Beach	2026-04-13 09:25:50.640396+00	OK	11.6	1.77	20.3	0.178	3	365
426	Calumet Beach	2026-04-13 09:25:57.862905+00	OK	11.5	0.92	18.5	0.113	3	365
427	Montrose Beach	2026-04-13 09:26:02.71364+00	OK	11.8	2.49	17.7	0.22	3	365
428	Montrose Beach	2026-04-13 09:26:09.960924+00	OK	11.7	0.6	17.9	0.102	4	365
429	Calumet Beach	2026-04-13 09:26:14.78833+00	OK	11.6	1.43	19.6	0.177	3	365
430	Calumet Beach	2026-04-13 09:26:22.035549+00	OK	11.5	0.94	18.7	0.084	2	365
431	Montrose Beach	2026-04-13 09:26:26.854241+00	OK	11.8	2.18	17	0.2	3	365
432	Calumet Beach	2026-04-13 09:26:34.078682+00	OK	11.5	0.92	18.8	0.081	3	365
433	Calumet Beach	2026-04-13 09:26:38.946378+00	OK	11.6	1.38	19.2	0.163	3	365
434	Montrose Beach	2026-04-13 09:26:46.145982+00	OK	11.7	0.38	17.4	0.106	4	365
435	Montrose Beach	2026-04-13 09:26:51.006019+00	OK	11.8	2.09	16.7	0.204	3	365
436	Calumet Beach	2026-04-13 09:51:58.116835+00	OK	11.5	0.84	18.7	0.092	3	365
437	Montrose Beach	2026-04-13 09:51:58.154704+00	OK	11.7	2.04	16.3	0.194	2	365
438	Montrose Beach	2026-04-13 09:52:10.229835+00	OK	11.7	0.35	17.3	0.103	10	365
439	Calumet Beach	2026-04-13 09:52:10.310912+00	OK	11.6	1.56	19.3	0.173	3	365
440	Calumet Beach	2026-04-13 09:52:22.27976+00	OK	11.5	0.79	18.4	0.102	2	365
441	Montrose Beach	2026-04-13 09:52:22.347235+00	OK	11.8	1.95	16.2	0.191	3	365
442	Montrose Beach	2026-04-13 09:52:34.325104+00	OK	11.7	0.3	17.3	0.101	3	365
443	Calumet Beach	2026-04-13 09:52:34.404737+00	OK	11.6	1.43	19.1	0.16	3	365
444	Calumet Beach	2026-04-13 09:52:46.408691+00	OK	11.5	0.76	18.4	0.091	4	365
445	Montrose Beach	2026-04-13 09:52:46.468896+00	OK	11.7	1.7	16	0.192	3	365
446	Montrose Beach	2026-04-13 09:52:58.470345+00	OK	11.7	0.29	17.2	0.116	7	365
447	Calumet Beach	2026-04-13 09:52:58.546312+00	OK	11.6	1.37	18.6	0.17	3	365
448	Calumet Beach	2026-04-13 09:53:10.542074+00	OK	11.5	0.77	18.5	0.078	3	365
449	Montrose Beach	2026-04-13 09:53:10.59158+00	OK	11.7	1.16	15.7	0.186	3	365
450	Montrose Beach	2026-04-13 09:53:22.609033+00	OK	11.7	0.29	17	0.106	6	365
451	Calumet Beach	2026-04-13 09:53:22.647712+00	OK	11.6	1.45	18.2	0.183	3	365
452	Calumet Beach	2026-04-13 09:53:34.682772+00	OK	11.5	0.75	18.3	0.082	2	365
453	Calumet Beach	2026-04-13 09:53:34.713697+00	OK	11.6	1.56	17.9	0.17	3	365
454	Montrose Beach	2026-04-13 09:53:46.767147+00	OK	11.7	0.86	15.4	0.176	3	365
455	Montrose Beach	2026-04-13 09:53:46.761095+00	OK	11.7	0.31	16.8	0.123	4	365
456	Montrose Beach	2026-04-13 09:53:58.821184+00	OK	11.7	0.62	15.3	0.162	3	365
457	Calumet Beach	2026-04-13 09:53:58.834589+00	OK	11.5	0.92	18.2	0.087	2	365
458	Calumet Beach	2026-04-13 09:54:10.871005+00	OK	11.6	1.65	17.8	0.174	3	365
459	Montrose Beach	2026-04-13 09:54:10.888816+00	OK	11.7	0.33	16.9	0.106	4	365
460	Montrose Beach	2026-04-13 09:54:22.951639+00	OK	11.7	0.54	15.1	0.154	3	365
461	Calumet Beach	2026-04-13 09:54:22.957366+00	OK	11.5	0.87	18.1	0.087	3	365
462	Calumet Beach	2026-04-13 09:54:35.028915+00	OK	11.6	1.5	17.7	0.172	3	365
463	Montrose Beach	2026-04-13 09:54:35.037163+00	OK	11.7	0.34	16.8	0.099	3	365
464	Calumet Beach	2026-04-13 09:54:47.0907+00	OK	11.6	1.44	17.7	0.169	3	365
465	Montrose Beach	2026-04-13 09:54:47.096206+00	OK	11.7	0.3	16.5	0.097	3	365
466	Calumet Beach	2026-04-13 09:54:59.176857+00	OK	11.5	0.81	18	0.073	3	365
467	Montrose Beach	2026-04-13 09:54:59.172277+00	OK	11.7	0.49	15.1	0.152	6	365
468	Calumet Beach	2026-04-13 09:55:11.231196+00	OK	11.6	1.38	17.8	0.168	3	365
469	Calumet Beach	2026-04-13 09:55:11.225779+00	OK	11.5	0.86	17.9	0.065	8	365
470	Montrose Beach	2026-04-13 09:55:23.302817+00	OK	11.7	0.43	15.2	0.151	3	365
471	Montrose Beach	2026-04-13 09:55:23.313421+00	OK	11.7	0.31	16.3	0.096	8	365
472	Montrose Beach	2026-04-13 09:55:35.368397+00	OK	11.7	0.31	16.1	0.092	4	365
473	Montrose Beach	2026-04-13 09:55:35.363933+00	OK	11.7	0.36	15.3	0.16	3	365
474	Calumet Beach	2026-04-13 09:55:47.453267+00	OK	11.6	1.39	18	0.151	3	365
475	Calumet Beach	2026-04-13 09:55:47.448728+00	OK	11.5	1.06	17.8	0.074	3	365
476	Montrose Beach	2026-04-13 09:55:59.512175+00	OK	11.7	0.33	15.6	0.163	3	365
477	Calumet Beach	2026-04-13 09:55:59.517199+00	OK	11.5	0.9	17.7	0.076	2	365
478	Calumet Beach	2026-04-13 09:56:11.584259+00	OK	11.6	1.43	18.2	0.127	3	365
479	Montrose Beach	2026-04-13 09:56:11.58947+00	OK	11.7	0.27	16	0.087	5	365
480	Montrose Beach	2026-04-13 09:56:23.663818+00	OK	11.7	0.33	15.8	0.175	3	365
481	Montrose Beach	2026-04-13 09:56:23.669164+00	OK	11.7	0.29	16.1	0.083	5	365
482	Calumet Beach	2026-04-13 09:56:35.742237+00	OK	11.5	0.86	17.6	0.064	3	365
483	Calumet Beach	2026-04-13 09:56:35.730815+00	OK	11.6	1.34	18.2	0.126	3	365
484	Calumet Beach	2026-04-13 09:56:47.822027+00	OK	11.6	1.31	18.5	0.123	2	365
485	Calumet Beach	2026-04-13 09:56:47.817723+00	OK	11.5	0.89	17.6	0.06	3	365
486	Montrose Beach	2026-04-13 09:56:59.884621+00	OK	11.7	0.4	16	0.155	3	365
487	Montrose Beach	2026-04-13 09:56:59.904789+00	OK	11.7	0.27	15.8	0.082	5	365
488	Calumet Beach	2026-04-13 09:57:11.958509+00	OK	11.6	1.29	18.8	0.117	6	365
489	Calumet Beach	2026-04-13 09:57:11.963646+00	OK	11.5	0.91	17.5	0.062	3	365
490	Montrose Beach	2026-04-13 09:57:24.0188+00	OK	11.7	0.28	15.7	0.079	5	365
491	Montrose Beach	2026-04-13 09:57:24.014247+00	OK	11.7	0.35	16.2	0.156	3	365
492	Calumet Beach	2026-04-13 09:57:36.088603+00	OK	11.6	1.27	18.9	0.119	3	365
493	Montrose Beach	2026-04-13 09:57:36.084254+00	OK	11.7	0.28	15.6	0.086	7	365
494	Montrose Beach	2026-04-13 09:57:48.14313+00	OK	11.7	0.32	16.3	0.138	3	365
495	Calumet Beach	2026-04-13 09:57:48.14803+00	OK	11.5	0.87	17.4	0.052	4	365
496	Montrose Beach	2026-04-13 09:58:00.202353+00	OK	11.7	0.25	15.6	0.088	4	365
497	Calumet Beach	2026-04-13 09:58:00.196988+00	OK	11.6	1.19	18.8	0.113	3	365
498	Calumet Beach	2026-04-13 09:58:12.252652+00	OK	11.5	0.81	17.4	0.073	3	365
499	Montrose Beach	2026-04-13 09:58:12.265639+00	OK	11.7	0.36	16.3	0.165	3	365
500	Calumet Beach	2026-04-13 09:58:24.342418+00	OK	11.5	0.79	17.6	0.071	4	365
501	Calumet Beach	2026-04-13 09:58:24.347253+00	OK	11.6	1.31	19.1	0.122	2	365
502	Montrose Beach	2026-04-13 09:58:36.402283+00	OK	11.7	0.25	15.6	0.117	2	365
503	Montrose Beach	2026-04-13 09:58:36.434214+00	OK	11.7	0.43	16.3	0.145	2	365
504	Calumet Beach	2026-04-13 09:58:48.475858+00	OK	11.5	0.96	17.9	0.094	3	365
505	Calumet Beach	2026-04-13 09:58:48.488683+00	OK	11.6	1.44	19.2	0.115	2	365
506	Montrose Beach	2026-04-13 09:59:00.554005+00	OK	11.7	0.49	16.3	0.179	4	365
507	Montrose Beach	2026-04-13 09:59:00.550525+00	OK	11.7	0.26	15.6	0.168	3	365
508	Montrose Beach	2026-04-13 09:59:12.595135+00	OK	11.7	0.5	16.4	0.12	7	365
509	Calumet Beach	2026-04-13 09:59:12.601566+00	OK	11.5	0.92	18.2	0.096	3	365
510	Calumet Beach	2026-04-13 09:59:24.661918+00	OK	11.6	1.25	18.7	0.109	9	365
511	Montrose Beach	2026-04-13 09:59:24.667123+00	OK	11.6	0.24	15.7	0.181	2	365
512	Montrose Beach	2026-04-13 09:59:36.742781+00	OK	11.7	0.53	16.2	0.123	6	365
513	Calumet Beach	2026-04-13 09:59:36.747683+00	OK	11.5	0.88	18.4	0.115	3	365
514	Calumet Beach	2026-04-13 09:59:48.784499+00	OK	11.6	1.12	18.3	0.139	2	365
515	Montrose Beach	2026-04-13 09:59:48.790444+00	OK	11.7	0.21	15.9	0.192	2	365
516	Montrose Beach	2026-04-13 10:00:00.860298+00	OK	11.7	0.55	16.1	0.106	5	365
517	Calumet Beach	2026-04-13 10:00:00.865639+00	OK	11.5	1.05	18.6	0.119	3	365
518	Calumet Beach	2026-04-13 10:00:12.912509+00	OK	11.6	1.14	18.3	0.133	2	365
519	Montrose Beach	2026-04-13 10:00:12.920515+00	OK	11.6	0.19	16.2	0.21	3	365
520	Montrose Beach	2026-04-13 10:00:24.996628+00	OK	11.7	0.55	16.2	0.116	3	365
521	Montrose Beach	2026-04-13 10:00:25.001471+00	OK	11.6	0.18	16.5	0.17	2	365
522	Calumet Beach	2026-04-13 10:00:37.069458+00	OK	11.5	0.88	18.6	0.124	3	365
523	Calumet Beach	2026-04-13 10:00:37.062739+00	OK	11.6	1.11	18.3	0.103	2	365
524	Montrose Beach	2026-04-13 10:00:49.138514+00	OK	11.6	0.15	17	0.173	3	365
525	Montrose Beach	2026-04-13 10:00:49.143707+00	OK	11.7	0.44	16.3	0.111	3	365
526	Calumet Beach	2026-04-13 10:01:01.175786+00	OK	11.5	0.83	19	0.117	3	365
527	Calumet Beach	2026-04-13 10:01:01.182706+00	OK	11.6	1.06	18.1	0.095	3	365
528	Calumet Beach	2026-04-13 10:01:13.230211+00	OK	11.6	1.07	18.1	0.128	2	365
529	Montrose Beach	2026-04-13 10:01:13.220192+00	OK	11.6	1.41	19.7	0.15	3	365
530	Calumet Beach	2026-04-13 10:01:25.311964+00	OK	11.5	0.79	20.5	0.131	3	365
531	Montrose Beach	2026-04-13 10:01:25.306619+00	OK	11.7	0.43	16.4	0.107	9	365
532	Montrose Beach	2026-04-13 10:01:37.358251+00	OK	11.6	0.43	17.7	0.131	3	365
533	Calumet Beach	2026-04-13 10:01:37.363372+00	OK	11.6	1.07	18.1	0.136	2	365
534	Calumet Beach	2026-04-13 10:01:49.420626+00	OK	11.5	0.84	20.3	0.124	3	365
535	Montrose Beach	2026-04-13 10:01:49.438336+00	OK	11.7	0.44	16.1	0.11	7	365
536	Montrose Beach	2026-04-13 10:02:01.476965+00	OK	11.6	0.25	16.9	0.134	7	365
537	Montrose Beach	2026-04-13 10:02:01.483032+00	OK	11.7	0.44	16.2	0.105	3	365
538	Calumet Beach	2026-04-13 10:02:13.521838+00	OK	11.5	0.77	19.8	0.122	2	365
539	Calumet Beach	2026-04-13 10:02:13.554225+00	OK	11.6	1.03	18	0.127	2	365
540	Montrose Beach	2026-04-13 10:02:25.575475+00	OK	11.6	0.2	16.4	0.136	4	365
541	Montrose Beach	2026-04-13 10:02:25.601241+00	OK	11.7	0.43	16.1	0.105	3	365
542	Calumet Beach	2026-04-13 10:02:37.664313+00	OK	11.5	0.83	20	0.114	3	365
543	Calumet Beach	2026-04-13 10:02:37.676431+00	OK	11.6	1.04	18	0.111	2	365
544	Calumet Beach	2026-04-13 10:02:49.756691+00	OK	11.5	0.89	20.2	0.104	3	365
545	Calumet Beach	2026-04-13 10:02:49.762655+00	OK	11.6	1.06	18	0.103	2	365
546	Montrose Beach	2026-04-13 10:03:01.839865+00	OK	11.7	0.44	16.2	0.098	3	365
547	Montrose Beach	2026-04-13 10:03:01.834508+00	OK	11.6	0.2	16.3	0.17	4	365
548	Calumet Beach	2026-04-13 10:03:13.933762+00	OK	11.5	0.86	20.2	0.117	2	365
549	Montrose Beach	2026-04-13 10:03:13.926748+00	OK	11.7	0.42	16.3	0.108	4	365
550	Montrose Beach	2026-04-13 10:03:25.991087+00	OK	11.6	0.21	16.2	0.106	3	365
551	Calumet Beach	2026-04-13 10:03:25.996106+00	OK	11.6	1.02	17.9	0.102	2	365
552	Montrose Beach	2026-04-13 10:03:38.048155+00	OK	11.7	0.48	16.3	0.101	4	365
553	Calumet Beach	2026-04-13 10:03:38.042316+00	OK	11.5	0.88	20	0.092	3	365
554	Montrose Beach	2026-04-13 10:03:50.1299+00	OK	11.6	0.19	16.1	0.123	4	365
555	Calumet Beach	2026-04-13 10:03:50.125002+00	OK	11.6	1	17.8	0.098	2	365
556	Calumet Beach	2026-04-13 10:04:02.217952+00	OK	11.6	0.96	17.8	0.111	2	365
557	Montrose Beach	2026-04-13 10:04:02.213098+00	OK	11.6	0.24	16	0.093	3	365
558	Calumet Beach	2026-04-13 10:04:14.284907+00	OK	11.5	0.87	19.9	0.103	2	365
559	Montrose Beach	2026-04-13 10:04:14.280084+00	OK	11.7	0.39	16.4	0.099	3	365
560	Montrose Beach	2026-04-13 10:04:26.38408+00	OK	11.6	0.19	16	0.1	8	365
561	Calumet Beach	2026-04-13 10:04:26.391451+00	OK	11.6	0.99	18	0.126	2	365
562	Montrose Beach	2026-04-13 10:04:38.486846+00	OK	11.7	0.42	16.4	0.098	3	365
563	Calumet Beach	2026-04-13 10:04:38.479278+00	OK	11.5	0.89	19.7	0.094	2	365
564	Montrose Beach	2026-04-13 10:04:50.586748+00	OK	11.7	0.36	16.1	0.095	4	365
565	Calumet Beach	2026-04-13 10:04:50.593028+00	OK	11.5	0.76	19.4	0.092	2	365
566	Calumet Beach	2026-04-13 10:05:02.674691+00	OK	11.5	0.98	18.1	0.127	2	365
567	Montrose Beach	2026-04-13 10:05:02.680437+00	OK	11.6	0.27	16	0.097	3	365
568	Calumet Beach	2026-04-13 10:05:14.762258+00	OK	11.5	1.01	18.2	0.128	3	365
569	Calumet Beach	2026-04-13 10:05:14.766154+00	OK	11.5	0.74	19.2	0.107	2	365
570	Montrose Beach	2026-04-13 10:05:26.854316+00	OK	11.7	0.42	16.2	0.106	3	365
571	Montrose Beach	2026-04-13 10:05:26.859432+00	OK	11.6	0.27	16	0.102	5	365
572	Calumet Beach	2026-04-13 10:05:38.940545+00	OK	11.5	0.99	18.2	0.131	3	365
573	Montrose Beach	2026-04-13 10:05:38.948707+00	OK	11.6	0.26	15.9	0.102	4	365
574	Calumet Beach	2026-04-13 10:05:51.033712+00	OK	11.5	0.75	19.1	0.129	2	365
575	Montrose Beach	2026-04-13 10:05:51.029182+00	OK	11.7	0.39	16.6	0.118	4	365
576	Calumet Beach	2026-04-13 10:06:03.083809+00	OK	11.5	0.97	18.3	0.114	2	365
577	Montrose Beach	2026-04-13 10:06:03.076075+00	OK	11.6	0.29	15.8	0.1	4	365
578	Montrose Beach	2026-04-13 10:06:15.139919+00	OK	11.7	0.37	16.5	0.118	3	365
579	Calumet Beach	2026-04-13 10:06:15.167906+00	OK	11.5	0.77	19	0.128	2	365
580	Montrose Beach	2026-04-13 10:06:27.263631+00	OK	11.6	0.3	15.8	0.105	3	365
581	Montrose Beach	2026-04-13 10:06:27.255199+00	OK	11.7	0.36	16.8	0.122	4	365
582	Calumet Beach	2026-04-13 10:06:39.376893+00	OK	11.5	0.83	18.9	0.155	2	365
583	Calumet Beach	2026-04-13 10:06:39.384537+00	OK	11.5	0.96	18.4	0.111	3	365
584	Calumet Beach	2026-04-13 10:06:51.473084+00	OK	11.5	0.9	18.9	0.144	2	365
585	Montrose Beach	2026-04-13 10:06:51.477494+00	OK	11.7	0.39	17.7	0.113	4	365
586	Calumet Beach	2026-04-13 10:07:03.571807+00	OK	11.5	0.92	18.5	0.113	3	365
587	Montrose Beach	2026-04-13 10:07:03.566436+00	OK	11.6	0.22	15.7	0.109	3	365
588	Montrose Beach	2026-04-13 10:07:15.662329+00	OK	11.6	0.21	15.7	0.119	4	365
589	Montrose Beach	2026-04-13 10:07:15.656495+00	OK	11.7	0.6	17.9	0.102	4	365
590	Calumet Beach	2026-04-13 10:07:27.772255+00	OK	11.5	0.92	18.6	0.207	2	365
591	Calumet Beach	2026-04-13 10:07:27.778572+00	OK	11.5	0.94	18.7	0.084	2	365
592	Montrose Beach	2026-04-13 10:07:39.863888+00	OK	11.6	0.21	15.7	0.15	2	365
593	Calumet Beach	2026-04-13 10:07:39.869364+00	OK	11.5	0.92	18.8	0.081	3	365
594	Calumet Beach	2026-04-13 10:07:51.94127+00	OK	11.5	1.37	18.5	0.235	3	365
595	Montrose Beach	2026-04-13 10:07:51.946351+00	OK	11.7	0.38	17.4	0.106	4	365
596	Calumet Beach	2026-04-13 10:08:04.004124+00	OK	11.5	1.52	18.5	0.216	3	365
597	Calumet Beach	2026-04-13 10:08:04.008198+00	OK	11.5	0.84	18.7	0.092	3	365
598	Montrose Beach	2026-04-13 10:08:16.078421+00	OK	11.7	0.35	17.3	0.103	10	365
599	Montrose Beach	2026-04-13 10:08:16.073466+00	OK	11.6	0.17	15.7	0.157	2	365
600	Montrose Beach	2026-04-13 10:08:28.177814+00	OK	11.6	0.19	15.7	0.165	3	365
601	Calumet Beach	2026-04-13 10:08:28.172403+00	OK	11.5	0.79	18.4	0.102	2	365
602	Calumet Beach	2026-04-13 10:08:40.267238+00	OK	11.5	1.83	18.4	0.2	3	365
603	Montrose Beach	2026-04-13 10:08:40.275244+00	OK	11.7	0.3	17.3	0.101	3	365
604	Calumet Beach	2026-04-13 10:08:52.306284+00	OK	11.5	1.96	18.4	0.245	3	365
605	Calumet Beach	2026-04-13 10:08:52.322352+00	OK	11.5	0.76	18.4	0.091	4	365
606	Montrose Beach	2026-04-13 10:09:04.399359+00	OK	11.6	0.22	15.7	0.247	2	365
607	Montrose Beach	2026-04-13 10:09:04.404891+00	OK	11.7	0.29	17.2	0.116	7	365
608	Montrose Beach	2026-04-13 10:09:16.473924+00	OK	11.6	0.63	15.7	0.317	3	365
609	Calumet Beach	2026-04-13 10:09:16.480659+00	OK	11.5	0.77	18.5	0.078	3	365
610	Calumet Beach	2026-04-13 10:09:28.538986+00	OK	11.5	2	18.4	0.262	3	365
611	Montrose Beach	2026-04-13 10:09:28.544217+00	OK	11.7	0.29	17	0.106	6	365
612	Calumet Beach	2026-04-13 10:09:40.638527+00	OK	11.5	2.04	18.4	0.285	4	365
613	Calumet Beach	2026-04-13 10:09:40.647268+00	OK	11.5	0.75	18.3	0.082	2	365
614	Montrose Beach	2026-04-13 10:09:52.714437+00	OK	11.6	2.47	15.8	0.358	3	365
615	Montrose Beach	2026-04-13 10:09:52.721781+00	OK	11.7	0.31	16.8	0.123	4	365
616	Calumet Beach	2026-04-13 10:10:04.811725+00	OK	11.5	0.92	18.2	0.087	2	365
617	Montrose Beach	2026-04-13 10:10:04.806541+00	OK	11.6	2.38	15.8	0.351	3	365
618	Montrose Beach	2026-04-13 10:10:16.891067+00	OK	11.7	0.33	16.9	0.106	4	365
619	Calumet Beach	2026-04-13 10:10:16.896254+00	OK	11.4	2.69	18.4	0.27	4	365
620	Montrose Beach	2026-04-13 10:10:28.995055+00	OK	11.6	3.51	16	0.323	3	365
621	Calumet Beach	2026-04-13 10:10:28.989342+00	OK	11.5	0.87	18.1	0.087	3	365
622	Calumet Beach	2026-04-13 10:10:41.082926+00	OK	11.4	2.62	18.3	0.271	4	365
623	Montrose Beach	2026-04-13 10:10:41.091229+00	OK	11.7	0.34	16.8	0.099	3	365
624	Calumet Beach	2026-04-13 10:10:53.170368+00	OK	11.4	2.9	18.4	0.236	4	365
625	Montrose Beach	2026-04-13 10:10:53.176396+00	OK	11.7	0.3	16.5	0.097	3	365
626	Calumet Beach	2026-04-13 10:11:05.265639+00	OK	11.5	0.81	18	0.073	3	365
627	Montrose Beach	2026-04-13 10:11:05.259477+00	OK	11.6	2.7	16.2	0.315	3	365
628	Calumet Beach	2026-04-13 10:11:17.389191+00	OK	11.5	0.86	17.9	0.065	8	365
629	Montrose Beach	2026-04-13 10:11:17.393999+00	OK	11.6	3.15	16.2	0.294	3	365
630	Montrose Beach	2026-04-13 10:11:29.488035+00	OK	11.7	0.31	16.3	0.096	8	365
631	Calumet Beach	2026-04-13 10:11:29.494413+00	OK	11.4	3.69	18.6	0.234	4	365
632	Montrose Beach	2026-04-13 10:11:41.544873+00	OK	11.6	4.13	16.2	0.317	3	365
633	Montrose Beach	2026-04-13 10:11:41.53253+00	OK	11.7	0.31	16.1	0.092	4	365
634	Calumet Beach	2026-04-13 10:11:53.644641+00	OK	11.5	1.06	17.8	0.074	3	365
635	Calumet Beach	2026-04-13 10:11:53.639833+00	OK	11.4	3.47	18.6	0.22	4	365
636	Calumet Beach	2026-04-13 10:12:05.729613+00	OK	11.5	0.9	17.7	0.076	2	365
637	Montrose Beach	2026-04-13 10:12:05.734272+00	OK	11.6	4.02	16.2	0.31	3	365
638	Montrose Beach	2026-04-13 10:12:17.823176+00	OK	11.7	0.27	16	0.087	5	365
639	Calumet Beach	2026-04-13 10:12:17.827928+00	OK	11.4	4.65	18.6	0.193	4	365
640	Montrose Beach	2026-04-13 10:12:29.915567+00	OK	11.7	0.29	16.1	0.083	5	365
641	Montrose Beach	2026-04-13 10:12:29.926162+00	OK	11.6	3.78	16.1	0.304	3	365
642	Calumet Beach	2026-04-13 10:12:42.014157+00	OK	11.4	4.25	18.4	0.195	3	365
643	Calumet Beach	2026-04-13 10:12:42.009862+00	OK	11.5	0.86	17.6	0.064	3	365
644	Calumet Beach	2026-04-13 10:12:54.1225+00	OK	11.5	0.89	17.6	0.06	3	365
645	Calumet Beach	2026-04-13 10:12:54.117169+00	OK	11.4	4.36	18.3	0.207	4	365
646	Montrose Beach	2026-04-13 10:13:06.221125+00	OK	11.7	0.27	15.8	0.082	5	365
647	Montrose Beach	2026-04-13 10:13:06.226562+00	OK	11.6	3.63	16.1	0.287	3	365
648	Calumet Beach	2026-04-13 10:13:18.30483+00	OK	11.5	0.91	17.5	0.062	3	365
649	Calumet Beach	2026-04-13 10:13:18.309707+00	OK	11.4	3.9	18.2	0.215	4	365
650	Montrose Beach	2026-04-13 10:13:30.417275+00	OK	11.6	3.99	16.1	0.283	3	365
651	Montrose Beach	2026-04-13 10:13:30.409746+00	OK	11.7	0.28	15.7	0.079	5	365
652	Montrose Beach	2026-04-13 10:13:42.509874+00	OK	11.7	0.28	15.6	0.086	7	365
653	Calumet Beach	2026-04-13 10:13:42.50373+00	OK	11.4	3.72	18.1	0.221	4	365
654	Calumet Beach	2026-04-13 10:13:54.597719+00	OK	11.5	0.87	17.4	0.052	4	365
655	Montrose Beach	2026-04-13 10:13:54.607564+00	OK	11.6	2.85	16	0.254	3	365
656	Montrose Beach	2026-04-13 10:14:06.647228+00	OK	11.7	0.25	15.6	0.088	4	365
657	Calumet Beach	2026-04-13 10:14:06.680162+00	OK	11.4	2.41	18	0.204	4	365
658	Calumet Beach	2026-04-13 10:14:18.721747+00	OK	11.5	0.81	17.4	0.073	3	365
659	Montrose Beach	2026-04-13 10:14:18.755071+00	OK	11.6	3.25	16	0.213	3	365
660	Montrose Beach	2026-04-13 10:14:30.847321+00	OK	11.6	3.27	16	0.225	3	365
661	Calumet Beach	2026-04-13 10:14:30.838403+00	OK	11.5	0.79	17.6	0.071	4	365
662	Calumet Beach	2026-04-13 10:14:42.921991+00	OK	11.4	2.6	18	0.205	4	365
663	Montrose Beach	2026-04-13 10:14:42.926784+00	OK	11.7	0.25	15.6	0.117	2	365
664	Calumet Beach	2026-04-13 10:14:55.000031+00	OK	11.5	0.96	17.9	0.094	3	365
665	Montrose Beach	2026-04-13 10:14:54.995501+00	OK	11.6	3.56	15.9	0.235	3	365
666	Montrose Beach	2026-04-13 10:15:07.080406+00	OK	11.7	0.26	15.6	0.168	3	365
667	Calumet Beach	2026-04-13 10:15:07.083536+00	OK	11.4	2.41	17.9	0.192	4	365
668	Calumet Beach	2026-04-13 10:15:19.128031+00	OK	11.5	0.92	18.2	0.096	3	365
669	Montrose Beach	2026-04-13 10:15:19.145079+00	OK	11.5	2.93	15.9	0.23	3	365
670	Calumet Beach	2026-04-13 10:15:31.215411+00	OK	11.4	2.62	17.8	0.176	4	365
671	Montrose Beach	2026-04-13 10:15:31.208747+00	OK	11.6	0.24	15.7	0.181	2	365
672	Calumet Beach	2026-04-13 10:15:43.317361+00	OK	11.4	2.73	17.8	0.169	3	365
673	Calumet Beach	2026-04-13 10:15:43.323522+00	OK	11.5	0.88	18.4	0.115	3	365
674	Montrose Beach	2026-04-13 10:15:55.406159+00	OK	11.7	0.21	15.9	0.192	2	365
675	Montrose Beach	2026-04-13 10:15:55.400279+00	OK	11.5	3.76	15.7	0.272	3	365
676	Montrose Beach	2026-04-13 10:16:07.508862+00	OK	11.5	2.88	15.6	0.259	3	365
677	Calumet Beach	2026-04-13 10:16:07.502399+00	OK	11.5	1.05	18.6	0.119	3	365
678	Calumet Beach	2026-04-13 10:16:19.593511+00	OK	11.4	2.74	17.7	0.155	3	365
679	Montrose Beach	2026-04-13 10:16:19.602833+00	OK	11.6	0.19	16.2	0.21	3	365
680	Montrose Beach	2026-04-13 10:16:31.712294+00	OK	11.6	0.18	16.5	0.17	2	365
681	Calumet Beach	2026-04-13 10:16:31.703821+00	OK	11.4	3.04	17.7	0.164	4	365
682	Calumet Beach	2026-04-13 10:16:43.810883+00	OK	11.5	0.88	18.6	0.124	3	365
683	Montrose Beach	2026-04-13 10:16:43.817293+00	OK	11.5	3.6	15.6	0.272	3	365
684	Montrose Beach	2026-04-13 10:16:55.895372+00	OK	11.6	0.15	17	0.173	3	365
685	Montrose Beach	2026-04-13 10:16:55.901686+00	OK	11.5	3.27	15.7	0.248	3	365
686	Calumet Beach	2026-04-13 10:17:07.943481+00	OK	11.5	0.83	19	0.117	3	365
687	Calumet Beach	2026-04-13 10:17:07.962096+00	OK	11.4	2.92	17.7	0.159	3	365
688	Montrose Beach	2026-04-13 10:17:20.008615+00	OK	11.6	1.41	19.7	0.15	3	365
689	Calumet Beach	2026-04-13 10:17:20.017104+00	OK	11.4	2.82	17.9	0.162	3	365
690	Calumet Beach	2026-04-13 10:17:32.132583+00	OK	11.5	0.79	20.5	0.131	3	365
691	Montrose Beach	2026-04-13 10:17:32.139692+00	OK	11.5	3.11	15.8	0.223	3	365
692	Calumet Beach	2026-04-13 10:17:44.230828+00	OK	11.4	2.69	18	0.155	3	365
693	Montrose Beach	2026-04-13 10:17:44.224467+00	OK	11.6	0.43	17.7	0.131	3	365
694	Montrose Beach	2026-04-13 10:17:56.314814+00	OK	11.5	2.82	16.1	0.226	3	365
695	Calumet Beach	2026-04-13 10:17:56.321159+00	OK	11.5	0.84	20.3	0.124	3	365
696	Montrose Beach	2026-04-13 10:18:08.429094+00	OK	11.6	0.25	16.9	0.134	7	365
697	Calumet Beach	2026-04-13 10:18:08.422869+00	OK	11.4	2.47	18.3	0.159	3	365
698	Montrose Beach	2026-04-13 10:18:20.52449+00	OK	11.5	3.05	16.4	0.237	3	365
699	Calumet Beach	2026-04-13 10:18:20.518708+00	OK	11.5	0.77	19.8	0.122	2	365
700	Ohio Street Beach	2026-04-13 10:18:32.615932+00	OK	12.8	1.6	16.9	0.159	3	365
701	Montrose Beach	2026-04-13 10:18:32.622118+00	OK	11.6	0.2	16.4	0.136	4	365
702	Montrose Beach	2026-04-13 10:18:44.666116+00	OK	11.5	2.61	16.8	0.22	3	365
703	Calumet Beach	2026-04-13 10:18:44.696744+00	OK	11.5	0.83	20	0.114	3	365
704	Calumet Beach	2026-04-13 10:18:56.757415+00	OK	11.4	2.29	18.5	0.156	3	365
705	Calumet Beach	2026-04-13 10:18:56.764252+00	OK	11.5	0.89	20.2	0.104	3	365
706	Montrose Beach	2026-04-13 10:19:08.849786+00	OK	11.6	0.2	16.3	0.17	4	365
707	Montrose Beach	2026-04-13 10:19:08.842879+00	OK	11.5	2.07	17.1	0.198	3	365
708	Calumet Beach	2026-04-13 10:19:20.924073+00	OK	11.5	0.86	20.2	0.117	2	365
709	Calumet Beach	2026-04-13 10:19:20.932046+00	OK	11.4	1.93	18.7	0.144	3	365
710	Montrose Beach	2026-04-13 10:19:33.027968+00	OK	11.5	1.84	17.5	0.194	2	365
711	Montrose Beach	2026-04-13 10:19:33.021465+00	OK	11.6	0.21	16.2	0.106	3	365
712	Calumet Beach	2026-04-13 10:19:45.147793+00	OK	11.5	0.88	20	0.092	3	365
713	Calumet Beach	2026-04-13 10:19:45.14096+00	OK	11.4	2.11	19.2	0.149	3	365
714	Montrose Beach	2026-04-13 10:19:57.237595+00	OK	11.5	1.72	17.9	0.177	3	365
715	Montrose Beach	2026-04-13 10:19:57.232707+00	OK	11.6	0.19	16.1	0.123	4	365
716	Calumet Beach	2026-04-13 10:20:09.272566+00	OK	11.4	2.03	19.5	0.138	3	365
717	Montrose Beach	2026-04-13 10:20:09.286287+00	OK	11.6	0.24	16	0.093	3	365
718	Montrose Beach	2026-04-13 10:20:21.355326+00	OK	11.5	1.76	19.3	0.175	3	365
719	Calumet Beach	2026-04-13 10:20:21.359722+00	OK	11.5	0.87	19.9	0.103	2	365
720	Calumet Beach	2026-04-13 10:20:33.497455+00	OK	11.4	1.87	19.6	0.131	3	365
721	Montrose Beach	2026-04-13 10:20:33.502018+00	OK	11.6	0.19	16	0.1	8	365
722	Calumet Beach	2026-04-13 10:20:45.581875+00	OK	11.5	0.89	19.7	0.094	2	365
723	Montrose Beach	2026-04-13 10:20:45.576047+00	OK	11.5	1.84	19.7	0.167	3	365
724	Calumet Beach	2026-04-13 10:20:57.670866+00	OK	11.4	1.81	19.7	0.129	2	365
725	Calumet Beach	2026-04-13 10:20:57.665846+00	OK	11.5	0.76	19.4	0.092	2	365
726	Montrose Beach	2026-04-13 10:21:09.735442+00	OK	11.5	3.03	20	0.159	3	365
727	Montrose Beach	2026-04-13 10:21:09.742752+00	OK	11.6	0.27	16	0.097	3	365
728	Calumet Beach	2026-04-13 10:21:21.852388+00	OK	11.5	0.74	19.2	0.107	2	365
729	Calumet Beach	2026-04-13 10:21:21.846341+00	OK	11.4	1.77	19.6	0.126	3	365
730	Montrose Beach	2026-04-13 10:21:33.942759+00	OK	11.6	0.27	16	0.102	5	365
731	Montrose Beach	2026-04-13 10:21:33.94699+00	OK	11.5	2.8	19.5	0.17	3	365
732	Calumet Beach	2026-04-13 10:21:45.986451+00	OK	11.4	1.69	19.5	0.142	3	365
733	Montrose Beach	2026-04-13 10:21:45.972929+00	OK	11.6	0.26	15.9	0.102	4	365
734	Montrose Beach	2026-04-13 10:21:58.076796+00	OK	11.5	2.36	18.9	0.163	3	365
735	Calumet Beach	2026-04-13 10:21:58.081905+00	OK	11.5	0.75	19.1	0.129	2	365
736	Montrose Beach	2026-04-13 10:22:10.19205+00	OK	11.6	0.29	15.8	0.1	4	365
737	Calumet Beach	2026-04-13 10:22:10.179901+00	OK	11.4	1.66	19.4	0.127	3	365
738	Calumet Beach	2026-04-13 10:22:22.275812+00	OK	11.5	0.77	19	0.128	2	365
739	Calumet Beach	2026-04-13 10:22:22.288835+00	OK	11.4	1.86	19.3	0.126	3	365
740	Montrose Beach	2026-04-13 10:22:34.335955+00	OK	11.5	2.57	19.1	0.137	3	365
741	Montrose Beach	2026-04-13 10:22:34.328459+00	OK	11.6	0.3	15.8	0.105	3	365
742	Calumet Beach	2026-04-13 10:22:46.438757+00	OK	11.5	0.83	18.9	0.155	2	365
743	Calumet Beach	2026-04-13 10:22:46.43344+00	OK	11.4	1.86	19.6	0.118	3	365
744	Calumet Beach	2026-04-13 10:22:58.525954+00	OK	11.5	0.9	18.9	0.144	2	365
745	Montrose Beach	2026-04-13 10:22:58.531644+00	OK	11.5	1.93	18.9	0.134	3	365
746	Montrose Beach	2026-04-13 10:23:10.62118+00	OK	11.5	1.97	18	0.122	2	365
747	Montrose Beach	2026-04-13 10:23:10.615943+00	OK	11.6	0.22	15.7	0.109	3	365
748	Montrose Beach	2026-04-13 10:23:22.675773+00	OK	11.6	0.21	15.7	0.119	4	365
749	Calumet Beach	2026-04-13 10:23:22.668931+00	OK	11.4	1.88	19.5	0.119	3	365
750	Calumet Beach	2026-04-13 10:23:34.773115+00	OK	11.5	0.92	18.6	0.207	2	365
751	Calumet Beach	2026-04-13 10:23:34.779864+00	OK	11.4	1.78	19.3	0.123	3	365
752	Montrose Beach	2026-04-13 10:23:46.865232+00	OK	11.6	0.21	15.7	0.15	2	365
753	Montrose Beach	2026-04-13 10:23:46.870513+00	OK	11.5	1.54	17.6	0.118	8	365
754	Calumet Beach	2026-04-13 10:23:58.934247+00	OK	11.5	1.37	18.5	0.235	3	365
755	Montrose Beach	2026-04-13 10:23:58.941025+00	OK	11.5	1.43	17.5	0.119	4	365
756	Calumet Beach	2026-04-13 10:24:11.028252+00	OK	11.4	1.61	19	0.113	2	365
757	Calumet Beach	2026-04-13 10:24:11.022431+00	OK	11.5	1.52	18.5	0.216	3	365
758	Montrose Beach	2026-04-13 10:24:23.118409+00	OK	11.6	0.17	15.7	0.157	2	365
759	Montrose Beach	2026-04-13 10:24:23.113967+00	OK	11.5	1.27	17.3	0.125	6	365
760	Montrose Beach	2026-04-13 10:24:35.209092+00	OK	11.6	0.19	15.7	0.165	3	365
761	Calumet Beach	2026-04-13 10:24:35.214114+00	OK	11.4	1.68	18.9	0.101	3	365
762	Calumet Beach	2026-04-13 10:24:47.250075+00	OK	11.5	1.83	18.4	0.2	3	365
763	Montrose Beach	2026-04-13 10:24:47.261047+00	OK	11.5	1.03	16.9	0.103	5	365
764	Calumet Beach	2026-04-13 10:24:59.339071+00	OK	11.5	1.96	18.4	0.245	3	365
765	Calumet Beach	2026-04-13 10:24:59.344569+00	OK	11.4	1.61	18.7	0.094	3	365
766	Montrose Beach	2026-04-13 10:25:11.414148+00	OK	11.6	0.22	15.7	0.247	2	365
767	Montrose Beach	2026-04-13 10:25:11.418992+00	OK	11.5	1.11	16.8	0.104	3	365
768	Montrose Beach	2026-04-13 10:25:23.514029+00	OK	11.6	0.63	15.7	0.317	3	365
769	Calumet Beach	2026-04-13 10:25:23.519379+00	OK	11.4	1.49	18.5	0.089	2	365
770	Montrose Beach	2026-04-13 10:25:35.617379+00	OK	11.5	1.04	16.7	0.094	4	365
771	Calumet Beach	2026-04-13 10:25:35.613623+00	OK	11.5	2	18.4	0.262	3	365
772	Calumet Beach	2026-04-13 10:25:47.717969+00	OK	11.4	1.51	18.4	0.086	3	365
773	Calumet Beach	2026-04-13 10:25:47.721864+00	OK	11.5	2.04	18.4	0.285	4	365
774	Montrose Beach	2026-04-13 10:25:59.801844+00	OK	11.5	0.96	16.7	0.092	2	365
775	Montrose Beach	2026-04-13 10:25:59.81057+00	OK	11.6	2.47	15.8	0.358	3	365
776	Calumet Beach	2026-04-13 10:26:11.862123+00	OK	11.4	1.43	18.3	0.091	2	365
777	Montrose Beach	2026-04-13 10:26:11.877645+00	OK	11.6	2.38	15.8	0.351	3	365
778	Calumet Beach	2026-04-13 10:26:23.948568+00	OK	11.4	1.45	18.4	0.078	3	365
779	Calumet Beach	2026-04-13 10:26:23.954544+00	OK	11.4	2.69	18.4	0.27	4	365
781	Montrose Beach	2026-04-13 10:26:36.066193+00	OK	11.5	0.97	16.7	0.088	4	365
782	Calumet Beach	2026-04-13 10:26:48.154274+00	OK	11.4	2.62	18.3	0.271	4	365
783	Montrose Beach	2026-04-13 10:26:48.159343+00	OK	11.5	0.91	16.8	0.081	2	365
784	Calumet Beach	2026-04-13 10:27:00.235757+00	OK	11.4	2.9	18.4	0.236	4	365
785	Calumet Beach	2026-04-13 10:27:00.250318+00	OK	11.3	1.39	18.5	0.075	3	365
786	Montrose Beach	2026-04-13 10:27:12.284372+00	OK	11.6	2.7	16.2	0.315	3	365
787	Montrose Beach	2026-04-13 10:27:12.294475+00	OK	11.5	0.79	16.9	0.091	3	365
788	Montrose Beach	2026-04-13 10:27:24.378385+00	OK	11.6	3.15	16.2	0.294	3	365
789	Calumet Beach	2026-04-13 10:27:24.385046+00	OK	11.4	1.25	18.7	0.084	2	365
790	Montrose Beach	2026-04-13 10:27:36.453867+00	OK	11.5	0.67	17.1	0.087	4	365
791	Calumet Beach	2026-04-13 10:27:36.448153+00	OK	11.4	3.69	18.6	0.234	4	365
792	Calumet Beach	2026-04-13 10:27:48.539473+00	OK	11.4	1.29	18.9	0.081	5	365
793	Montrose Beach	2026-04-13 10:27:48.545636+00	OK	11.6	4.13	16.2	0.317	3	365
794	Calumet Beach	2026-04-13 10:28:00.621306+00	OK	11.3	1.24	19.2	0.072	2	365
795	Calumet Beach	2026-04-13 10:28:00.627463+00	OK	11.4	3.47	18.6	0.22	4	365
796	Montrose Beach	2026-04-13 10:28:12.715832+00	OK	11.6	4.02	16.2	0.31	3	365
797	Montrose Beach	2026-04-13 10:28:12.709827+00	OK	11.5	0.62	17.4	0.097	3	365
798	Calumet Beach	2026-04-13 10:28:24.789876+00	OK	11.4	4.65	18.6	0.193	4	365
799	Calumet Beach	2026-04-13 10:28:24.797848+00	OK	11.3	1.21	19.6	0.08	3	365
800	Montrose Beach	2026-04-13 10:28:36.888231+00	OK	11.6	3.78	16.1	0.304	3	365
801	Montrose Beach	2026-04-13 10:28:36.894277+00	OK	11.5	0.65	17.6	0.124	6	365
802	Calumet Beach	2026-04-13 10:28:48.989853+00	OK	11.4	1.19	19.7	0.12	2	365
803	Calumet Beach	2026-04-13 10:28:48.984089+00	OK	11.4	4.25	18.4	0.195	3	365
804	Montrose Beach	2026-04-13 10:29:01.064868+00	OK	11.5	0.55	17.8	0.152	3	365
805	Calumet Beach	2026-04-13 10:29:01.069786+00	OK	11.4	4.36	18.3	0.207	4	365
806	Montrose Beach	2026-04-13 10:29:13.127337+00	OK	11.5	0.5	18	0.117	2	365
807	Montrose Beach	2026-04-13 10:29:13.134719+00	OK	11.6	3.63	16.1	0.287	3	365
808	Calumet Beach	2026-04-13 10:29:25.211471+00	OK	11.4	3.9	18.2	0.215	4	365
809	Calumet Beach	2026-04-13 10:29:25.206388+00	OK	11.3	1.19	20.3	0.141	2	365
810	Ohio Street Beach	2026-04-13 10:29:37.338018+00	OK	12.4	0.7	18.8	0.135	2	365
811	Montrose Beach	2026-04-13 10:29:37.33081+00	OK	11.6	3.99	16.1	0.283	3	365
812	Calumet Beach	2026-04-13 10:29:49.424343+00	OK	11.4	1.14	20.6	0.128	2	365
813	Calumet Beach	2026-04-13 10:29:49.428814+00	OK	11.4	3.72	18.1	0.221	4	365
814	Montrose Beach	2026-04-13 10:30:01.483644+00	OK	11.5	0.57	18.9	0.112	2	365
815	Montrose Beach	2026-04-13 10:30:01.49427+00	OK	11.6	2.85	16	0.254	3	365
816	Calumet Beach	2026-04-13 10:30:13.580527+00	OK	11.4	2.41	18	0.204	4	365
817	Calumet Beach	2026-04-13 10:30:13.573287+00	OK	11.3	1.16	21	0.119	2	365
818	Montrose Beach	2026-04-13 10:30:25.659748+00	OK	11.5	0.47	19.3	0.097	5	365
819	Montrose Beach	2026-04-13 10:30:25.653933+00	OK	11.6	3.25	16	0.213	3	365
820	Calumet Beach	2026-04-13 10:30:37.720696+00	OK	11.4	1.15	21	0.11	2	365
821	Montrose Beach	2026-04-13 10:30:37.7249+00	OK	11.6	3.27	16	0.225	3	365
822	Calumet Beach	2026-04-13 10:30:49.817584+00	OK	11.4	2.6	18	0.205	4	365
823	Ohio Street Beach	2026-04-13 10:30:49.809467+00	OK	12.3	0.78	19.8	0.162	3	365
824	Montrose Beach	2026-04-13 10:31:01.907198+00	OK	11.6	3.56	15.9	0.235	3	365
825	Montrose Beach	2026-04-13 10:31:01.914201+00	OK	11.5	0.42	19.4	0.102	8	365
826	Ohio Street Beach	2026-04-13 10:31:13.990854+00	OK	12.3	0.77	19.7	0.13	3	365
827	Calumet Beach	2026-04-13 10:31:13.985663+00	OK	11.4	2.41	17.9	0.192	4	365
828	Calumet Beach	2026-04-13 10:31:26.045262+00	OK	11.3	1.12	21	0.141	2	365
829	Montrose Beach	2026-04-13 10:31:26.051092+00	OK	11.5	2.93	15.9	0.23	3	365
830	Calumet Beach	2026-04-13 10:31:38.134614+00	OK	11.4	2.62	17.8	0.176	4	365
831	Montrose Beach	2026-04-13 10:31:38.129404+00	OK	11.5	0.28	18.8	0.129	7	365
832	Calumet Beach	2026-04-13 10:31:50.211942+00	OK	11.4	2.73	17.8	0.169	3	365
833	Ohio Street Beach	2026-04-13 10:31:50.217338+00	OK	12.3	0.8	19.2	0.137	2	365
834	Montrose Beach	2026-04-13 10:32:02.26147+00	OK	11.5	3.76	15.7	0.272	3	365
835	Calumet Beach	2026-04-13 10:32:02.279543+00	OK	11.3	1.36	21.3	0.142	2	365
836	Montrose Beach	2026-04-13 10:32:14.334353+00	OK	11.5	2.88	15.6	0.259	3	365
837	Montrose Beach	2026-04-13 10:32:14.343422+00	OK	11.5	0.45	19.3	0.155	4	365
838	Calumet Beach	2026-04-13 10:32:26.423941+00	OK	11.4	2.74	17.7	0.155	3	365
839	Montrose Beach	2026-04-13 10:32:26.430799+00	OK	11.5	0.31	18.4	0.166	2	365
840	Ohio Street Beach	2026-04-13 10:32:38.522067+00	OK	12.3	1.03	18.7	0.147	2	365
841	Calumet Beach	2026-04-13 10:32:38.517692+00	OK	11.4	3.04	17.7	0.164	4	365
842	Montrose Beach	2026-04-13 10:32:50.59463+00	OK	11.5	3.6	15.6	0.272	3	365
843	Calumet Beach	2026-04-13 10:32:50.587445+00	OK	11.4	1.43	21.4	0.154	2	365
844	Montrose Beach	2026-04-13 10:33:02.653702+00	OK	11.5	3.27	15.7	0.248	3	365
845	Ohio Street Beach	2026-04-13 10:33:02.672707+00	OK	12.3	0.83	18.1	0.144	2	365
846	Montrose Beach	2026-04-13 10:33:14.77366+00	OK	11.5	0.26	17.9	0.158	2	365
847	Calumet Beach	2026-04-13 10:33:14.763137+00	OK	11.4	2.92	17.7	0.159	3	365
848	Calumet Beach	2026-04-13 10:33:26.818516+00	OK	11.4	2.82	17.9	0.162	3	365
849	Calumet Beach	2026-04-13 10:33:26.802824+00	OK	11.4	1.4	21.2	0.16	2	365
850	Ohio Street Beach	2026-04-13 10:33:38.870889+00	OK	12.3	1	17.3	0.133	2	365
851	Montrose Beach	2026-04-13 10:33:38.864557+00	OK	11.5	3.11	15.8	0.223	3	365
852	Calumet Beach	2026-04-13 10:33:50.970801+00	OK	11.4	2.69	18	0.155	3	365
853	Montrose Beach	2026-04-13 10:33:50.964291+00	OK	11.5	0.27	17.2	0.14	2	365
854	Calumet Beach	2026-04-13 10:34:03.058091+00	OK	11.3	1.37	20.7	0.166	3	365
855	Montrose Beach	2026-04-13 10:34:03.053767+00	OK	11.5	2.82	16.1	0.226	3	365
856	Ohio Street Beach	2026-04-13 10:34:15.123106+00	OK	12.3	1.12	17.1	0.119	3	365
857	Calumet Beach	2026-04-13 10:34:15.12502+00	OK	11.4	2.47	18.3	0.159	3	365
858	Montrose Beach	2026-04-13 10:34:27.188297+00	OK	11.5	0.34	16.8	0.132	2	365
859	Montrose Beach	2026-04-13 10:34:27.194735+00	OK	11.5	3.05	16.4	0.237	3	365
860	Ohio Street Beach	2026-04-13 10:34:39.299302+00	OK	12.8	1.6	16.9	0.159	3	365
861	Calumet Beach	2026-04-13 10:34:39.290665+00	OK	11.4	1.28	20.4	0.153	3	365
862	Ohio Street Beach	2026-04-13 10:34:51.392803+00	OK	12.3	1.21	16.8	0.127	3	365
863	Montrose Beach	2026-04-13 10:34:51.387089+00	OK	11.5	2.61	16.8	0.22	3	365
864	Calumet Beach	2026-04-13 10:35:03.464652+00	OK	11.3	1.71	20.5	0.139	3	365
865	Calumet Beach	2026-04-13 10:35:03.471612+00	OK	11.4	2.29	18.5	0.156	3	365
866	Montrose Beach	2026-04-13 10:35:15.556675+00	OK	11.5	2.07	17.1	0.198	3	365
867	Montrose Beach	2026-04-13 10:35:15.551681+00	OK	11.5	0.22	16.4	0.123	4	365
868	Montrose Beach	2026-04-13 10:35:27.606466+00	OK	11.5	0.38	16.3	0.114	7	365
869	Calumet Beach	2026-04-13 10:35:27.602002+00	OK	11.4	1.93	18.7	0.144	3	365
870	Calumet Beach	2026-04-13 10:35:39.686947+00	OK	11.3	1.51	20.2	0.138	3	365
871	Montrose Beach	2026-04-13 10:35:39.692944+00	OK	11.5	1.84	17.5	0.194	2	365
872	Ohio Street Beach	2026-04-13 10:35:51.7914+00	OK	12.3	0.97	16.6	0.104	2	365
873	Calumet Beach	2026-04-13 10:35:51.795969+00	OK	11.4	2.11	19.2	0.149	3	365
874	Montrose Beach	2026-04-13 10:36:03.870076+00	OK	11.5	0.25	16.2	0.121	4	365
875	Montrose Beach	2026-04-13 10:36:03.875611+00	OK	11.5	1.72	17.9	0.177	3	365
876	Ohio Street Beach	2026-04-13 10:36:15.978843+00	OK	12.3	0.95	16.6	0.089	3	365
877	Calumet Beach	2026-04-13 10:36:15.983904+00	OK	11.4	2.03	19.5	0.138	3	365
878	Calumet Beach	2026-04-13 10:36:28.027194+00	OK	11.3	1.44	19.8	0.111	3	365
879	Montrose Beach	2026-04-13 10:36:28.04246+00	OK	11.5	1.76	19.3	0.175	3	365
880	Calumet Beach	2026-04-13 10:36:40.126273+00	OK	11.4	1.87	19.6	0.131	3	365
881	Montrose Beach	2026-04-13 10:36:40.120447+00	OK	11.5	0.28	16.2	0.104	4	365
882	Calumet Beach	2026-04-13 10:36:52.212507+00	OK	11.3	1.3	19.6	0.109	2	365
883	Montrose Beach	2026-04-13 10:36:52.207996+00	OK	11.5	1.84	19.7	0.167	3	365
884	Ohio Street Beach	2026-04-13 10:37:04.269251+00	OK	12.2	0.97	16.6	0.087	4	365
885	Calumet Beach	2026-04-13 10:37:04.280336+00	OK	11.4	1.81	19.7	0.129	2	365
886	Ohio Street Beach	2026-04-13 10:37:16.357018+00	OK	12.2	1.04	16.6	0.08	2	365
887	Montrose Beach	2026-04-13 10:37:16.361936+00	OK	11.5	3.03	20	0.159	3	365
888	Calumet Beach	2026-04-13 10:37:28.458746+00	OK	11.4	1.77	19.6	0.126	3	365
889	Calumet Beach	2026-04-13 10:37:28.454209+00	OK	11.3	1.15	19.4	0.098	2	365
890	Montrose Beach	2026-04-13 10:37:40.571989+00	OK	11.5	2.8	19.5	0.17	3	365
891	Montrose Beach	2026-04-13 10:37:40.577739+00	OK	11.5	0.25	16.3	0.091	4	365
892	Calumet Beach	2026-04-13 10:37:52.662046+00	OK	11.4	1.69	19.5	0.142	3	365
893	Calumet Beach	2026-04-13 10:37:52.667037+00	OK	11.3	1.19	19.3	0.096	2	365
894	Montrose Beach	2026-04-13 10:38:04.753919+00	OK	11.5	2.36	18.9	0.163	3	365
895	Ohio Street Beach	2026-04-13 10:38:04.758542+00	OK	12.2	0.79	16.5	0.071	2	365
896	Calumet Beach	2026-04-13 10:38:16.832565+00	OK	11.4	1.66	19.4	0.127	3	365
897	Montrose Beach	2026-04-13 10:38:16.839707+00	OK	11.5	0.3	16.2	0.093	4	365
898	Calumet Beach	2026-04-13 10:38:28.906026+00	OK	11.4	1.86	19.3	0.126	3	365
899	Calumet Beach	2026-04-13 10:38:28.911989+00	OK	11.3	1.12	19.2	0.099	2	365
900	Ohio Street Beach	2026-04-13 10:38:41.018066+00	OK	12.2	0.71	16.6	0.068	2	365
901	Montrose Beach	2026-04-13 10:38:41.009708+00	OK	11.5	2.57	19.1	0.137	3	365
902	Montrose Beach	2026-04-13 10:38:53.084772+00	OK	11.5	0.32	16.2	0.083	4	365
903	Calumet Beach	2026-04-13 10:38:53.089837+00	OK	11.4	1.86	19.6	0.118	3	365
904	Montrose Beach	2026-04-13 10:39:05.181279+00	OK	11.5	0.29	16.4	0.086	3	365
905	Montrose Beach	2026-04-13 10:39:05.186188+00	OK	11.5	1.93	18.9	0.134	3	365
906	Ohio Street Beach	2026-04-13 10:39:17.256647+00	OK	12.2	0.73	16.7	0.096	3	365
907	Montrose Beach	2026-04-13 10:39:17.272838+00	OK	11.5	1.97	18	0.122	2	365
908	Calumet Beach	2026-04-13 10:39:29.309071+00	OK	11.3	1	19.2	0.099	2	365
909	Calumet Beach	2026-04-13 10:39:29.32803+00	OK	11.4	1.88	19.5	0.119	3	365
910	Montrose Beach	2026-04-13 10:39:41.399909+00	OK	11.5	0.41	16.4	0.088	4	365
911	Calumet Beach	2026-04-13 10:39:41.404657+00	OK	11.4	1.78	19.3	0.123	3	365
912	Ohio Street Beach	2026-04-13 10:39:53.48526+00	OK	12.2	0.84	16.8	0.103	2	365
913	Montrose Beach	2026-04-13 10:39:53.490109+00	OK	11.5	1.54	17.6	0.118	8	365
914	Calumet Beach	2026-04-13 10:40:05.567023+00	OK	11.3	1.17	19.3	0.092	2	365
915	Montrose Beach	2026-04-13 10:40:05.571642+00	OK	11.5	1.43	17.5	0.119	4	365
916	Montrose Beach	2026-04-13 10:40:17.613743+00	OK	11.5	0.22	16.5	0.084	4	365
917	Calumet Beach	2026-04-13 10:40:17.628704+00	OK	11.4	1.61	19	0.113	2	365
918	Ohio Street Beach	2026-04-13 10:40:29.694564+00	OK	12.2	0.81	17	0.078	3	365
919	Montrose Beach	2026-04-13 10:40:29.70299+00	OK	11.5	1.27	17.3	0.125	6	365
920	Calumet Beach	2026-04-13 10:40:41.79756+00	OK	11.3	1.25	19.4	0.085	2	365
921	Calumet Beach	2026-04-13 10:40:41.803934+00	OK	11.4	1.68	18.9	0.101	3	365
922	Ohio Street Beach	2026-04-13 10:40:53.872388+00	OK	12.1	1.4	17.2	0.089	7	365
923	Montrose Beach	2026-04-13 10:40:53.882533+00	OK	11.5	1.03	16.9	0.103	5	365
924	Calumet Beach	2026-04-13 10:41:05.953403+00	OK	11.3	0.81	19.7	0.1	3	365
925	Calumet Beach	2026-04-13 10:41:05.96022+00	OK	11.4	1.61	18.7	0.094	3	365
926	Montrose Beach	2026-04-13 10:41:18.051538+00	OK	11.5	0.24	16.5	0.081	2	365
927	Montrose Beach	2026-04-13 10:41:18.057231+00	OK	11.5	1.11	16.8	0.104	3	365
928	Montrose Beach	2026-04-13 10:41:30.133166+00	OK	11.5	0.2	16.6	0.095	3	365
929	Calumet Beach	2026-04-13 10:41:30.138792+00	OK	11.4	1.49	18.5	0.089	2	365
930	Calumet Beach	2026-04-13 10:41:42.231286+00	OK	11.3	0.99	20.2	0.082	2	365
931	Montrose Beach	2026-04-13 10:41:42.236676+00	OK	11.5	1.04	16.7	0.094	4	365
932	Ohio Street Beach	2026-04-13 10:41:54.307961+00	OK	12.1	0.86	17.5	0.144	2	365
933	Calumet Beach	2026-04-13 10:41:54.312363+00	OK	11.4	1.51	18.4	0.086	3	365
934	Montrose Beach	2026-04-13 10:42:06.407042+00	OK	11.5	0.12	16.8	0.12	3	365
935	Montrose Beach	2026-04-13 10:42:06.4135+00	OK	11.5	0.96	16.7	0.092	2	365
936	Ohio Street Beach	2026-04-13 10:42:18.501747+00	OK	12.1	1.13	17.7	0.121	3	365
937	Calumet Beach	2026-04-13 10:42:18.507233+00	OK	11.4	1.43	18.3	0.091	2	365
938	Calumet Beach	2026-04-13 10:42:30.574937+00	OK	11.3	1.01	20.5	0.108	2	365
939	Calumet Beach	2026-04-13 10:42:30.582253+00	OK	11.4	1.45	18.4	0.078	3	365
940	Montrose Beach	2026-04-13 10:42:42.675079+00	OK	11.5	0.07	17	0.141	3	365
941	Montrose Beach	2026-04-13 10:42:42.680887+00	OK	11.5	0.97	16.7	0.088	4	365
942	Ohio Street Beach	2026-04-13 10:42:54.770632+00	OK	12.1	1.04	17.6	0.175	6	365
943	Montrose Beach	2026-04-13 10:42:54.77674+00	OK	11.5	0.91	16.8	0.081	2	365
944	Calumet Beach	2026-04-13 10:43:06.858995+00	OK	11.3	1.01	20.6	0.148	2	365
945	Calumet Beach	2026-04-13 10:43:06.90006+00	OK	11.3	1.39	18.5	0.075	3	365
946	Montrose Beach	2026-04-13 10:43:18.94377+00	OK	11.5	0.13	16.6	0.117	6	365
947	Montrose Beach	2026-04-13 10:43:18.968017+00	OK	11.5	0.79	16.9	0.091	3	365
948	Calumet Beach	2026-04-13 10:43:31.036525+00	OK	11.3	1.09	21.2	0.112	2	365
949	Calumet Beach	2026-04-13 10:43:31.045235+00	OK	11.4	1.25	18.7	0.084	2	365
950	Ohio Street Beach	2026-04-13 10:43:43.109072+00	OK	12.1	1.13	18.1	0.178	3	365
951	Montrose Beach	2026-04-13 10:43:43.154144+00	OK	11.5	0.67	17.1	0.087	4	365
952	Ohio Street Beach	2026-04-13 10:43:55.181395+00	OK	12.1	1.15	18.4	0.169	3	365
953	Calumet Beach	2026-04-13 10:43:55.20703+00	OK	11.4	1.29	18.9	0.081	5	365
954	Calumet Beach	2026-04-13 10:44:07.279903+00	OK	11.3	1.24	19.2	0.072	2	365
955	Montrose Beach	2026-04-13 10:44:07.274032+00	OK	11.5	0.16	16.8	0.121	2	365
956	Montrose Beach	2026-04-13 10:44:19.358149+00	OK	11.5	0.62	17.4	0.097	3	365
957	Calumet Beach	2026-04-13 10:44:19.363761+00	OK	11.3	1.1	21.5	0.171	2	365
958	Calumet Beach	2026-04-13 10:44:31.451937+00	OK	11.3	1.21	19.6	0.08	3	365
959	Montrose Beach	2026-04-13 10:44:31.457329+00	OK	11.5	0.18	16.8	0.144	5	365
960	Ohio Street Beach	2026-04-13 10:44:43.575335+00	OK	12.1	0.86	18.4	0.166	2	365
961	Montrose Beach	2026-04-13 10:44:43.570312+00	OK	11.5	0.65	17.6	0.124	6	365
962	Calumet Beach	2026-04-13 10:44:55.662063+00	OK	11.3	1.07	21.2	0.13	2	365
963	Calumet Beach	2026-04-13 10:44:55.667128+00	OK	11.4	1.19	19.7	0.12	2	365
964	Montrose Beach	2026-04-13 10:45:07.744164+00	OK	11.5	0.55	17.8	0.152	3	365
965	Montrose Beach	2026-04-13 10:45:07.738563+00	OK	11.5	0.28	16.5	0.162	4	365
966	Montrose Beach	2026-04-13 10:45:19.78829+00	OK	11.5	0.5	18	0.117	2	365
967	Ohio Street Beach	2026-04-13 10:45:19.803996+00	OK	12.1	0.77	18.5	0.174	2	365
968	Calumet Beach	2026-04-13 10:45:31.881897+00	OK	11.3	1.01	21.1	0.197	2	365
969	Calumet Beach	2026-04-13 10:45:31.879766+00	OK	11.3	1.19	20.3	0.141	2	365
970	Ohio Street Beach	2026-04-13 10:45:43.969741+00	OK	12.1	1.08	18.3	0.167	2	365
971	Ohio Street Beach	2026-04-13 10:45:43.977173+00	OK	12.4	0.7	18.8	0.135	2	365
972	Calumet Beach	2026-04-13 10:45:56.015527+00	OK	11.3	1.2	21.1	0.135	2	365
973	Calumet Beach	2026-04-13 10:45:56.02179+00	OK	11.4	1.14	20.6	0.128	2	365
974	Montrose Beach	2026-04-13 10:46:08.120232+00	OK	11.5	0.57	18.9	0.112	2	365
975	Montrose Beach	2026-04-13 10:46:08.114662+00	OK	11.5	0.33	17.1	0.177	7	365
976	Calumet Beach	2026-04-13 10:46:20.208235+00	OK	11.3	1.43	21.2	0.172	2	365
977	Calumet Beach	2026-04-13 10:46:20.204128+00	OK	11.3	1.16	21	0.119	2	365
978	Montrose Beach	2026-04-13 10:46:32.288385+00	OK	11.5	0.33	17.3	0.185	2	365
979	Montrose Beach	2026-04-13 10:46:32.293536+00	OK	11.5	0.47	19.3	0.097	5	365
980	Ohio Street Beach	2026-04-13 10:46:44.386584+00	OK	12.1	1.14	18.3	0.145	2	365
981	Calumet Beach	2026-04-13 10:46:44.391713+00	OK	11.4	1.15	21	0.11	2	365
982	Ohio Street Beach	2026-04-13 10:46:56.432853+00	OK	12.1	0.99	18	0.149	2	365
983	Ohio Street Beach	2026-04-13 10:46:56.437234+00	OK	12.3	0.78	19.8	0.162	3	365
984	Calumet Beach	2026-04-13 10:47:08.470965+00	OK	11.3	1.81	21.5	0.184	2	365
985	Montrose Beach	2026-04-13 10:47:08.477417+00	OK	11.5	0.42	19.4	0.102	8	365
986	Ohio Street Beach	2026-04-13 10:47:20.55289+00	OK	12.3	0.77	19.7	0.13	3	365
987	Montrose Beach	2026-04-13 10:47:20.546381+00	OK	11.5	0.65	18	0.222	3	365
988	Montrose Beach	2026-04-13 10:47:32.646101+00	OK	11.5	0.51	17.7	0.222	2	365
989	Calumet Beach	2026-04-13 10:47:32.641273+00	OK	11.3	1.12	21	0.141	2	365
990	Ohio Street Beach	2026-04-13 10:47:44.695358+00	OK	12.1	0.92	17.8	0.158	3	365
991	Montrose Beach	2026-04-13 10:47:44.701273+00	OK	11.5	0.28	18.8	0.129	7	365
992	Calumet Beach	2026-04-13 10:47:56.785101+00	OK	11.3	1.96	20.8	0.215	3	365
993	Ohio Street Beach	2026-04-13 10:47:56.790082+00	OK	12.3	0.8	19.2	0.137	2	365
994	Calumet Beach	2026-04-13 10:48:08.817311+00	OK	11.3	1.74	20.4	0.206	3	365
995	Calumet Beach	2026-04-13 10:48:08.84871+00	OK	11.3	1.36	21.3	0.142	2	365
996	Ohio Street Beach	2026-04-13 10:48:20.904134+00	OK	12	0.83	17.7	0.153	3	365
997	Montrose Beach	2026-04-13 10:48:20.909195+00	OK	11.5	0.45	19.3	0.155	4	365
998	Montrose Beach	2026-04-13 10:48:33.009753+00	OK	11.5	0.31	18.4	0.166	2	365
999	Montrose Beach	2026-04-13 10:48:33.003371+00	OK	11.5	0.32	17.1	0.233	3	365
1000	Ohio Street Beach	2026-04-13 10:48:45.084788+00	OK	12.3	1.03	18.7	0.147	2	365
1001	Calumet Beach	2026-04-13 10:48:45.092692+00	OK	11.3	2.19	20.6	0.187	3	365
1002	Montrose Beach	2026-04-13 10:48:57.208505+00	OK	11.5	0.45	16.9	0.243	3	365
1003	Calumet Beach	2026-04-13 10:48:57.210084+00	OK	11.4	1.43	21.4	0.154	2	365
1004	Ohio Street Beach	2026-04-13 10:49:09.303575+00	OK	12	0.8	17.6	0.16	3	365
1005	Montrose Beach	2026-04-13 10:49:14.334205+00	OK	9.4	1.18	20.3	0.08	3	365
1006	Osterman Beach	2026-04-13 10:49:26.4283+00	OK	9.4	3.51	21.5	0.231	4	365
1007	Ohio Street Beach	2026-04-13 10:49:38.512744+00	OK	9.4	4.97	21.9	0.241	7	365
1008	Calumet Beach	2026-04-13 10:49:50.607753+00	OK	9.4	3.63	23.2	0.174	6	365
1009	63rd Street Beach	2026-04-13 10:50:02.687724+00	OK	11	7.56	18.9	0.14	4	365
1010	Rainbow Beach	2026-04-13 10:50:14.788523+00	OK	12.6	0.74	27.1	0.013	10	365
1011	Montrose Beach	2026-04-13 10:50:26.840716+00	OK	11.9	3.36	14.4	0.298	4	365
1012	Calumet Beach	2026-04-13 10:50:38.923876+00	OK	11.7	1.26	16.2	0.147	4	365
1013	Montrose Beach	2026-04-13 10:50:50.997654+00	OK	11.9	2.72	14.5	0.306	3	365
1014	Calumet Beach	2026-04-13 10:51:03.070279+00	OK	11.7	1.28	16.3	0.162	4	365
1015	Calumet Beach	2026-04-13 10:51:15.131213+00	OK	11.7	1.32	16.5	0.185	4	365
1016	Montrose Beach	2026-04-13 10:51:27.193618+00	OK	11.9	2.97	14.8	0.328	3	365
1017	Montrose Beach	2026-04-13 10:51:39.251215+00	OK	11.9	4.3	14.5	0.328	3	365
1018	Calumet Beach	2026-04-13 10:51:51.33292+00	OK	11.7	1.31	16.8	0.196	4	365
1019	Calumet Beach	2026-04-13 10:52:03.363949+00	OK	11.7	1.37	17.1	0.194	4	365
1020	Montrose Beach	2026-04-13 10:52:15.412025+00	OK	11.9	4.87	14.4	0.341	3	365
1021	Calumet Beach	2026-04-13 10:52:27.453799+00	OK	11.7	1.48	17.2	0.203	4	365
1022	Montrose Beach	2026-04-13 10:52:39.500726+00	OK	11.9	5.06	14.1	0.34	4	365
1023	Calumet Beach	2026-04-13 10:52:51.553155+00	OK	11.7	1.8	17.1	0.188	4	365
1024	Montrose Beach	2026-04-13 10:53:03.609475+00	OK	11.9	5.76	14.2	0.356	3	365
1025	Calumet Beach	2026-04-13 10:53:15.646726+00	OK	11.7	1.82	17	0.194	4	365
1026	Montrose Beach	2026-04-13 10:53:27.684718+00	OK	11.9	6.32	14.2	0.346	3	365
1027	Montrose Beach	2026-04-13 10:53:39.743743+00	OK	11.9	6.89	14.4	0.38	4	365
1028	Calumet Beach	2026-04-13 10:53:51.794783+00	OK	11.7	1.83	17	0.196	4	365
1029	Calumet Beach	2026-04-13 10:57:21.950843+00	OK	11.7	1.9	16.8	0.181	4	365
1030	Montrose Beach	2026-04-13 11:03:24.410867+00	OK	11.9	7.11	14.5	0.361	5	365
1031	Calumet Beach	2026-04-13 11:03:36.61341+00	OK	11.7	1.83	16.7	0.18	4	365
1032	Montrose Beach	2026-04-13 11:03:48.671853+00	OK	11.9	6.88	14.5	0.345	4	365
1033	Montrose Beach	2026-04-13 11:04:00.729996+00	OK	11.9	7.32	14.3	0.331	4	365
1034	Calumet Beach	2026-04-13 11:04:12.834788+00	OK	11.7	1.69	16.5	0.177	4	365
1035	Calumet Beach	2026-04-13 11:04:24.904039+00	OK	11.7	1.62	16.3	0.159	4	365
1036	Montrose Beach	2026-04-13 11:04:36.977798+00	OK	11.9	7.18	14.2	0.305	4	365
1037	Montrose Beach	2026-04-13 11:04:49.035414+00	OK	11.9	6.35	14.2	0.321	3	365
1038	Calumet Beach	2026-04-13 11:05:01.12454+00	OK	11.7	1.57	16.2	0.154	4	365
1039	Montrose Beach	2026-04-13 11:05:13.212219+00	OK	11.8	6.78	14.1	0.285	4	365
1040	Calumet Beach	2026-04-13 11:05:25.301638+00	OK	11.7	1.8	16.1	0.163	4	365
1041	Calumet Beach	2026-04-13 11:05:37.387822+00	OK	11.7	1.82	16.1	0.156	4	365
1042	Montrose Beach	2026-04-13 11:05:49.463092+00	OK	11.8	6.27	14.1	0.306	3	365
1043	Montrose Beach	2026-04-13 11:06:01.532462+00	OK	11.8	5.63	14	0.282	3	365
1044	Calumet Beach	2026-04-13 11:06:13.619551+00	OK	11.7	1.73	15.9	0.158	3	365
1045	Calumet Beach	2026-04-13 11:06:25.695522+00	OK	11.7	1.73	15.9	0.151	3	365
1046	Montrose Beach	2026-04-13 11:06:37.75751+00	OK	11.8	5.05	13.8	0.248	4	365
1047	Montrose Beach	2026-04-13 11:06:49.848684+00	OK	11.8	5.73	13.8	0.235	4	365
1048	Calumet Beach	2026-04-13 11:07:01.903995+00	OK	11.7	1.74	15.9	0.148	4	365
1049	Calumet Beach	2026-04-13 11:07:13.969104+00	OK	11.7	1.77	15.8	0.146	4	365
1050	Montrose Beach	2026-04-13 11:07:26.058047+00	OK	11.8	5.57	13.9	0.244	4	365
1051	Calumet Beach	2026-04-13 11:07:38.103429+00	OK	11.7	1.64	15.9	0.125	4	365
1052	Montrose Beach	2026-04-13 11:07:50.155809+00	OK	11.8	6.49	13.9	0.292	3	365
1053	Calumet Beach	2026-04-13 11:08:02.216259+00	OK	11.7	1.75	16	0.129	4	365
1054	Montrose Beach	2026-04-13 11:08:14.299007+00	OK	11.8	5.67	14.1	0.277	2	365
1055	Calumet Beach	2026-04-13 11:08:26.370552+00	OK	11.7	1.59	16.2	0.141	4	365
1056	Montrose Beach	2026-04-13 11:08:38.426917+00	OK	11.8	6.4	14.3	0.286	5	365
1057	Montrose Beach	2026-04-13 11:08:50.494327+00	OK	11.8	6.19	14.6	0.301	3	365
1058	Calumet Beach	2026-04-13 11:09:02.567739+00	OK	11.7	1.55	16.4	0.144	4	365
1059	Montrose Beach	2026-04-13 11:09:14.648122+00	OK	11.8	6.28	14.8	0.282	5	365
1060	Calumet Beach	2026-04-13 11:09:26.70969+00	OK	11.7	1.58	16.6	0.154	2	365
1061	Calumet Beach	2026-04-13 11:09:38.790698+00	OK	11.7	1.44	16.7	0.159	5	365
1062	Montrose Beach	2026-04-13 11:09:50.849828+00	OK	11.8	6.36	14.9	0.319	3	365
1063	Montrose Beach	2026-04-13 11:10:02.938788+00	OK	11.8	5.98	15.1	0.296	3	365
1064	Calumet Beach	2026-04-13 11:10:15.021169+00	OK	11.7	1.4	16.9	0.164	4	365
1065	Calumet Beach	2026-04-13 11:10:27.088595+00	OK	11.7	1.35	16.9	0.17	4	365
1066	Montrose Beach	2026-04-13 11:10:39.146494+00	OK	11.8	6.26	15.2	0.313	3	365
1067	Montrose Beach	2026-04-13 11:10:51.222896+00	OK	11.8	7.06	15.5	0.288	3	365
1068	Calumet Beach	2026-04-13 11:11:03.305723+00	OK	11.7	1.45	16.8	0.168	3	365
1069	Montrose Beach	2026-04-13 11:11:15.352082+00	OK	11.8	6.51	15.3	0.298	3	365
1070	Calumet Beach	2026-04-13 11:11:27.426236+00	OK	11.7	1.35	16.9	0.179	3	365
1071	Calumet Beach	2026-04-13 11:11:39.501823+00	OK	11.7	1.39	16.8	0.175	3	365
1072	Montrose Beach	2026-04-13 11:11:51.572735+00	OK	11.8	6.71	15.5	0.287	3	365
1073	Calumet Beach	2026-04-13 11:12:03.654816+00	OK	11.7	1.46	16.7	0.182	4	365
1074	Montrose Beach	2026-04-13 11:12:15.751849+00	OK	11.8	6.17	15.3	0.298	3	365
1075	Montrose Beach	2026-04-13 11:12:27.809753+00	OK	11.8	5.9	15.4	0.286	3	365
1076	Calumet Beach	2026-04-13 11:12:39.883531+00	OK	11.7	1.4	16.8	0.189	3	365
1077	Montrose Beach	2026-04-13 11:12:51.955052+00	OK	11.8	6.03	15.2	0.266	3	365
1078	Calumet Beach	2026-04-13 11:13:04.029176+00	OK	11.7	1.51	16.9	0.177	4	365
1079	Montrose Beach	2026-04-13 11:13:16.106632+00	OK	11.8	5.71	15.2	0.262	3	365
1080	Calumet Beach	2026-04-13 11:13:28.17148+00	OK	11.7	1.55	16.8	0.194	3	365
1081	Calumet Beach	2026-04-13 11:13:40.214349+00	OK	11.7	1.79	16.6	0.21	4	365
1082	Montrose Beach	2026-04-13 11:13:52.274623+00	OK	11.8	6.09	15.2	0.234	3	365
1083	Montrose Beach	2026-04-13 11:14:04.340043+00	OK	11.8	5.98	15	0.26	3	365
1084	Calumet Beach	2026-04-13 11:14:16.409555+00	OK	11.7	1.74	16.4	0.176	4	365
1085	Calumet Beach	2026-04-13 11:14:28.472737+00	OK	11.7	1.53	16.4	0.193	4	365
1086	Montrose Beach	2026-04-13 11:14:40.534745+00	OK	11.8	5.92	15	0.26	3	365
1087	Montrose Beach	2026-04-13 11:14:52.601841+00	OK	11.8	6.51	14.9	0.261	3	365
1088	Calumet Beach	2026-04-13 11:15:04.668703+00	OK	11.7	1.72	16.3	0.176	4	365
1089	Calumet Beach	2026-04-13 11:15:16.753866+00	OK	11.7	1.77	16.2	0.168	3	365
1090	Montrose Beach	2026-04-13 11:15:28.823878+00	OK	11.8	5.35	14.8	0.266	4	365
1091	Montrose Beach	2026-04-13 11:15:40.901864+00	OK	11.8	5.66	14.8	0.253	4	365
1092	Calumet Beach	2026-04-13 11:15:52.958761+00	OK	11.7	1.6	16.2	0.152	3	365
1093	Calumet Beach	2026-04-13 11:16:05.045333+00	OK	11.7	1.53	16.1	0.144	3	365
1094	Montrose Beach	2026-04-13 11:16:17.099368+00	OK	11.8	5.53	14.7	0.219	3	365
1095	Montrose Beach	2026-04-13 11:16:29.168159+00	OK	11.8	5.53	14.7	0.22	4	365
1096	Calumet Beach	2026-04-13 11:16:41.227157+00	OK	11.7	1.71	16.1	0.132	3	365
1097	Montrose Beach	2026-04-13 11:16:53.301852+00	OK	11.8	5.58	14.8	0.228	3	365
1098	Calumet Beach	2026-04-13 11:17:05.378763+00	OK	11.7	1.68	16.2	0.127	3	365
1099	Montrose Beach	2026-04-13 11:17:17.454527+00	OK	11.8	5.36	15	0.223	3	365
1100	Calumet Beach	2026-04-13 11:17:29.542222+00	OK	11.6	1.59	16.3	0.108	3	365
1101	Montrose Beach	2026-04-13 11:17:41.878256+00	OK	11.8	5.03	15.2	0.198	3	365
1102	Calumet Beach	2026-04-13 11:17:53.956177+00	OK	11.6	1.52	16.6	0.111	3	365
1103	Montrose Beach	2026-04-13 11:18:06.003365+00	OK	11.8	5.28	15.5	0.202	3	365
1104	Calumet Beach	2026-04-13 11:18:18.070114+00	OK	11.6	1.45	16.8	0.107	3	365
1105	Calumet Beach	2026-04-13 11:18:30.155557+00	OK	11.6	1.46	17.2	0.116	3	365
1106	Montrose Beach	2026-04-13 11:18:42.221179+00	OK	11.8	5.04	15.8	0.193	3	365
1107	Calumet Beach	2026-04-13 11:18:54.3102+00	OK	11.6	1.52	17.4	0.108	3	365
1108	Montrose Beach	2026-04-13 11:19:06.389791+00	OK	11.8	4.71	16.1	0.199	3	365
1109	Calumet Beach	2026-04-13 11:19:18.484983+00	OK	11.6	1.58	17.5	0.115	3	365
1110	Montrose Beach	2026-04-13 11:19:30.541596+00	OK	11.8	4.43	16.4	0.226	2	365
1111	Calumet Beach	2026-04-13 11:19:42.603259+00	OK	11.6	1.52	17.8	0.14	2	365
1112	Montrose Beach	2026-04-13 11:19:54.686644+00	OK	11.8	4.62	16.7	0.196	2	365
1113	Calumet Beach	2026-04-13 11:20:06.775305+00	OK	11.6	1.48	17.7	0.129	3	365
1114	Montrose Beach	2026-04-13 11:20:18.845168+00	OK	11.8	4.41	16.8	0.229	2	365
1115	Montrose Beach	2026-04-13 11:20:30.927394+00	OK	11.8	4.31	16.8	0.23	3	365
1116	Calumet Beach	2026-04-13 11:20:42.994887+00	OK	11.6	1.42	17.6	0.141	2	365
1117	Montrose Beach	2026-04-13 11:20:55.054036+00	OK	11.8	4.16	16.7	0.219	2	365
1118	Calumet Beach	2026-04-13 11:21:07.09926+00	OK	11.6	1.43	17.7	0.141	3	365
1119	Montrose Beach	2026-04-13 11:21:19.193014+00	OK	11.8	4.4	16.8	0.201	2	365
1120	Calumet Beach	2026-04-13 11:21:31.285288+00	OK	11.6	1.39	17.7	0.147	2	365
1121	Calumet Beach	2026-04-13 11:21:43.357465+00	OK	11.6	1.44	17.6	0.163	3	365
1122	Montrose Beach	2026-04-13 11:21:55.411805+00	OK	11.8	4.05	16.7	0.201	2	365
1123	Calumet Beach	2026-04-13 11:22:07.47478+00	OK	11.6	1.41	17.8	0.157	3	365
1124	Montrose Beach	2026-04-13 11:22:19.528278+00	OK	11.8	4.17	16.7	0.178	2	365
1125	Montrose Beach	2026-04-13 11:22:31.60461+00	OK	11.8	3.83	16.5	0.16	2	365
1126	Calumet Beach	2026-04-13 11:22:43.679953+00	OK	11.6	1.45	17.8	0.144	3	365
1127	Montrose Beach	2026-04-13 11:22:55.735385+00	OK	11.8	3.94	16.5	0.182	3	365
1128	Calumet Beach	2026-04-13 11:23:07.799709+00	OK	11.6	1.44	17.6	0.155	3	365
1129	Montrose Beach	2026-04-13 11:23:19.868448+00	OK	11.8	3.63	16.5	0.168	2	365
1130	Calumet Beach	2026-04-13 11:23:31.938876+00	OK	11.6	1.58	17.2	0.144	3	365
1131	Montrose Beach	2026-04-13 11:23:43.997296+00	OK	11.8	3.68	16.4	0.152	2	365
1132	Calumet Beach	2026-04-13 11:23:56.052629+00	OK	11.6	1.43	17.1	0.132	3	365
1133	Montrose Beach	2026-04-13 11:24:08.101924+00	OK	11.8	3.56	16.3	0.144	3	365
1134	Calumet Beach	2026-04-13 11:24:20.164945+00	OK	11.6	1.44	17	0.137	3	365
1135	Calumet Beach	2026-04-13 11:24:32.230413+00	OK	11.6	1.5	16.8	0.136	3	365
1136	Montrose Beach	2026-04-13 11:24:44.302363+00	OK	11.8	3.38	16.2	0.147	3	365
1137	Montrose Beach	2026-04-13 11:24:56.35928+00	OK	11.8	3.08	16	0.166	3	365
1138	Calumet Beach	2026-04-13 11:25:08.392183+00	OK	11.6	1.71	16.8	0.133	4	365
1139	Calumet Beach	2026-04-13 11:25:20.465488+00	OK	11.6	1.58	16.7	0.134	3	365
1140	Montrose Beach	2026-04-13 11:25:32.538418+00	OK	11.8	3	16	0.161	2	365
1141	Montrose Beach	2026-04-13 11:25:44.620983+00	OK	11.8	3.11	15.9	0.163	3	365
1142	Calumet Beach	2026-04-13 11:25:56.697057+00	OK	11.6	2.2	17	0.127	3	365
1143	Calumet Beach	2026-04-13 11:26:08.764737+00	OK	11.6	1.68	16.8	0.118	3	365
1144	Montrose Beach	2026-04-13 11:26:20.829336+00	OK	11.8	3.16	16	0.147	3	365
1145	Calumet Beach	2026-04-13 11:26:32.902785+00	OK	11.6	1.7	17	0.113	3	365
1146	Montrose Beach	2026-04-13 11:26:44.967439+00	OK	11.8	3.18	16	0.138	3	365
1147	Calumet Beach	2026-04-13 11:26:57.051698+00	OK	11.6	1.62	17.1	0.1	3	365
1148	Montrose Beach	2026-04-13 11:27:09.121256+00	OK	11.8	3.07	16.2	0.145	3	365
1149	Montrose Beach	2026-04-13 11:27:21.198531+00	OK	11.8	2.88	16.5	0.144	3	365
1150	Calumet Beach	2026-04-13 11:27:33.246795+00	OK	11.6	1.66	17.4	0.097	3	365
1151	Montrose Beach	2026-04-13 11:27:45.28886+00	OK	11.8	2.91	16.8	0.158	4	365
1152	Calumet Beach	2026-04-13 11:27:57.37451+00	OK	11.6	1.76	17.8	0.096	3	365
1153	Montrose Beach	2026-04-13 11:28:09.451339+00	OK	11.8	2.49	17.3	0.131	2	365
1154	Calumet Beach	2026-04-13 11:28:21.544918+00	OK	11.6	1.31	18	0.109	2	365
1155	Montrose Beach	2026-04-13 11:28:33.609153+00	OK	11.8	2.85	17.6	0.15	3	365
1156	Calumet Beach	2026-04-13 11:28:45.667785+00	OK	11.6	1.31	18.4	0.106	3	365
1157	Montrose Beach	2026-04-13 11:28:57.73862+00	OK	11.8	3.57	19.2	0.156	3	365
1158	Calumet Beach	2026-04-13 11:29:09.804464+00	OK	11.6	1.19	19.2	0.115	3	365
1159	Calumet Beach	2026-04-13 11:29:21.879822+00	OK	11.6	1.25	19.3	0.11	2	365
1160	Montrose Beach	2026-04-13 11:29:33.947524+00	OK	11.7	3.68	19.7	0.158	2	365
1161	Montrose Beach	2026-04-13 11:29:46.006586+00	OK	11.8	3.11	20.1	0.215	4	365
1162	Calumet Beach	2026-04-13 11:29:58.05169+00	OK	11.6	1.16	19.8	0.166	2	365
1163	Calumet Beach	2026-04-13 11:30:10.126737+00	OK	11.6	1.27	20.3	0.158	2	365
1164	Montrose Beach	2026-04-13 11:30:22.198193+00	OK	11.8	2.54	19.4	0.243	2	365
1165	Calumet Beach	2026-04-13 11:30:34.254898+00	OK	11.6	1.65	21	0.226	3	365
1166	Montrose Beach	2026-04-13 11:30:46.309135+00	OK	11.8	2.64	18.4	0.218	2	365
1167	Montrose Beach	2026-04-13 11:30:58.354003+00	OK	11.8	3.82	19.5	0.205	3	365
1168	Calumet Beach	2026-04-13 11:31:10.460589+00	OK	11.6	1.43	20.6	0.18	3	365
1169	Calumet Beach	2026-04-13 11:31:22.540487+00	OK	11.6	1.38	20.4	0.156	3	365
1170	Montrose Beach	2026-04-13 11:31:34.591761+00	OK	11.8	2.66	18.1	0.211	3	365
1171	Calumet Beach	2026-04-13 11:31:46.671213+00	OK	11.6	1.77	20.3	0.178	3	365
1172	Montrose Beach	2026-04-13 11:31:58.741621+00	OK	11.8	2.49	17.7	0.22	3	365
1173	Calumet Beach	2026-04-13 11:32:10.810016+00	OK	11.6	1.43	19.6	0.177	3	365
1174	Montrose Beach	2026-04-13 11:32:22.893028+00	OK	11.8	2.18	17	0.2	3	365
1175	Calumet Beach	2026-04-13 11:32:34.965317+00	OK	11.6	1.38	19.2	0.163	3	365
1176	Montrose Beach	2026-04-13 11:32:47.041037+00	OK	11.8	2.09	16.7	0.204	3	365
1177	Montrose Beach	2026-04-13 11:32:59.12367+00	OK	11.7	2.04	16.3	0.194	2	365
1178	Calumet Beach	2026-04-13 11:33:11.17675+00	OK	11.6	1.56	19.3	0.173	3	365
1179	Montrose Beach	2026-04-13 11:33:23.244689+00	OK	11.8	1.95	16.2	0.191	3	365
1180	Calumet Beach	2026-04-13 11:33:35.30218+00	OK	11.6	1.43	19.1	0.16	3	365
1181	Montrose Beach	2026-04-13 11:33:47.365467+00	OK	11.7	1.7	16	0.192	3	365
1182	Calumet Beach	2026-04-13 11:33:59.415622+00	OK	11.6	1.37	18.6	0.17	3	365
1183	Montrose Beach	2026-04-13 11:34:11.489482+00	OK	11.7	1.16	15.7	0.186	3	365
1184	Calumet Beach	2026-04-13 11:34:23.560839+00	OK	11.6	1.45	18.2	0.183	3	365
1185	Calumet Beach	2026-04-13 11:34:35.625496+00	OK	11.6	1.56	17.9	0.17	3	365
1186	Montrose Beach	2026-04-13 11:34:47.697624+00	OK	11.7	0.86	15.4	0.176	3	365
1187	Montrose Beach	2026-04-13 11:34:59.781837+00	OK	11.7	0.62	15.3	0.162	3	365
1188	Calumet Beach	2026-04-13 11:35:11.906164+00	OK	11.6	1.65	17.8	0.174	3	365
1189	Montrose Beach	2026-04-13 11:35:23.973688+00	OK	11.7	0.54	15.1	0.154	3	365
1190	Calumet Beach	2026-04-13 11:35:36.037653+00	OK	11.6	1.5	17.7	0.172	3	365
1191	Calumet Beach	2026-04-13 11:35:48.075253+00	OK	11.6	1.44	17.7	0.169	3	365
1192	Montrose Beach	2026-04-13 11:36:00.133852+00	OK	11.7	0.49	15.1	0.152	6	365
1193	Calumet Beach	2026-04-13 11:36:12.217909+00	OK	11.6	1.38	17.8	0.168	3	365
1194	Montrose Beach	2026-04-13 11:36:24.290432+00	OK	11.7	0.43	15.2	0.151	3	365
1195	Montrose Beach	2026-04-13 11:36:36.379081+00	OK	11.7	0.36	15.3	0.16	3	365
1196	Calumet Beach	2026-04-13 11:36:48.419403+00	OK	11.6	1.39	18	0.151	3	365
1197	Montrose Beach	2026-04-13 11:37:00.491995+00	OK	11.7	0.33	15.6	0.163	3	365
1198	Calumet Beach	2026-04-13 11:37:12.566894+00	OK	11.6	1.43	18.2	0.127	3	365
1199	Montrose Beach	2026-04-13 11:37:24.652543+00	OK	11.7	0.33	15.8	0.175	3	365
1200	Calumet Beach	2026-04-13 11:37:36.693155+00	OK	11.6	1.34	18.2	0.126	3	365
1201	Calumet Beach	2026-04-13 11:37:48.739691+00	OK	11.6	1.31	18.5	0.123	2	365
1202	Montrose Beach	2026-04-13 11:38:00.791858+00	OK	11.7	0.4	16	0.155	3	365
1203	Calumet Beach	2026-04-13 11:38:12.879983+00	OK	11.6	1.29	18.8	0.117	6	365
1204	Montrose Beach	2026-04-13 11:38:24.981549+00	OK	11.7	0.35	16.2	0.156	3	365
1205	Calumet Beach	2026-04-13 11:38:37.045548+00	OK	11.6	1.27	18.9	0.119	3	365
1206	Montrose Beach	2026-04-13 11:38:49.083391+00	OK	11.7	0.32	16.3	0.138	3	365
1207	Calumet Beach	2026-04-13 11:39:01.146585+00	OK	11.6	1.19	18.8	0.113	3	365
1208	Montrose Beach	2026-04-13 11:39:13.214869+00	OK	11.7	0.36	16.3	0.165	3	365
1209	Calumet Beach	2026-04-13 11:39:25.304125+00	OK	11.6	1.31	19.1	0.122	2	365
1210	Montrose Beach	2026-04-13 11:39:37.365903+00	OK	11.7	0.43	16.3	0.145	2	365
1211	Calumet Beach	2026-04-13 11:39:49.437954+00	OK	11.6	1.44	19.2	0.115	2	365
1212	Montrose Beach	2026-04-13 11:40:01.51838+00	OK	11.7	0.49	16.3	0.179	4	365
1213	Montrose Beach	2026-04-13 11:40:13.578819+00	OK	11.7	0.5	16.4	0.12	7	365
1214	Calumet Beach	2026-04-13 11:40:25.648338+00	OK	11.6	1.25	18.7	0.109	9	365
1215	Montrose Beach	2026-04-13 11:40:37.704012+00	OK	11.7	0.53	16.2	0.123	6	365
1216	Calumet Beach	2026-04-13 11:40:49.767552+00	OK	11.6	1.12	18.3	0.139	2	365
1217	Montrose Beach	2026-04-13 11:41:01.861232+00	OK	11.7	0.55	16.1	0.106	5	365
1218	Calumet Beach	2026-04-13 11:41:13.937725+00	OK	11.6	1.14	18.3	0.133	2	365
1219	Montrose Beach	2026-04-13 11:41:26.037192+00	OK	11.7	0.55	16.2	0.116	3	365
1220	Calumet Beach	2026-04-13 11:41:38.089313+00	OK	11.6	1.11	18.3	0.103	2	365
1221	Montrose Beach	2026-04-13 11:41:50.159003+00	OK	11.7	0.44	16.3	0.111	3	365
1222	Calumet Beach	2026-04-13 11:42:02.217547+00	OK	11.6	1.06	18.1	0.095	3	365
1223	Calumet Beach	2026-04-13 11:42:14.291149+00	OK	11.6	1.07	18.1	0.128	2	365
1224	Montrose Beach	2026-04-13 11:42:26.359656+00	OK	11.7	0.43	16.4	0.107	9	365
1225	Calumet Beach	2026-04-13 11:42:38.417834+00	OK	11.6	1.07	18.1	0.136	2	365
1226	Montrose Beach	2026-04-13 11:42:50.48184+00	OK	11.7	0.44	16.1	0.11	7	365
1227	Montrose Beach	2026-04-13 11:43:02.553559+00	OK	11.7	0.44	16.2	0.105	3	365
1228	Calumet Beach	2026-04-13 11:43:14.608865+00	OK	11.6	1.03	18	0.127	2	365
1229	Montrose Beach	2026-04-13 11:43:26.700369+00	OK	11.7	0.43	16.1	0.105	3	365
1230	Calumet Beach	2026-04-13 11:43:38.767359+00	OK	11.6	1.04	18	0.111	2	365
1231	Calumet Beach	2026-04-13 11:43:50.809576+00	OK	11.6	1.06	18	0.103	2	365
1232	Montrose Beach	2026-04-13 11:44:02.867615+00	OK	11.7	0.44	16.2	0.098	3	365
1233	Montrose Beach	2026-04-13 11:44:14.948842+00	OK	11.7	0.42	16.3	0.108	4	365
1234	Calumet Beach	2026-04-13 11:44:27.021555+00	OK	11.6	1.02	17.9	0.102	2	365
1235	Montrose Beach	2026-04-13 11:44:39.067649+00	OK	11.7	0.48	16.3	0.101	4	365
1236	Calumet Beach	2026-04-13 11:44:51.145092+00	OK	11.6	1	17.8	0.098	2	365
1237	Calumet Beach	2026-04-13 11:45:03.194726+00	OK	11.6	0.96	17.8	0.111	2	365
1238	Montrose Beach	2026-04-13 11:45:15.27118+00	OK	11.7	0.39	16.4	0.099	3	365
1239	Calumet Beach	2026-04-13 11:45:27.394997+00	OK	11.6	0.99	18	0.126	2	365
1240	Montrose Beach	2026-04-13 11:45:39.452529+00	OK	11.7	0.42	16.4	0.098	3	365
1241	Montrose Beach	2026-04-13 11:45:51.530702+00	OK	11.7	0.36	16.1	0.095	4	365
1242	Calumet Beach	2026-04-13 11:46:03.61244+00	OK	11.5	0.98	18.1	0.127	2	365
1243	Calumet Beach	2026-04-13 11:46:15.677789+00	OK	11.5	1.01	18.2	0.128	3	365
1244	Montrose Beach	2026-04-13 11:46:27.758297+00	OK	11.7	0.42	16.2	0.106	3	365
1245	Calumet Beach	2026-04-13 11:46:39.831921+00	OK	11.5	0.99	18.2	0.131	3	365
1246	Montrose Beach	2026-04-13 11:46:51.909734+00	OK	11.7	0.39	16.6	0.118	4	365
1247	Calumet Beach	2026-04-13 11:47:03.978558+00	OK	11.5	0.97	18.3	0.114	2	365
1248	Montrose Beach	2026-04-13 11:47:16.04137+00	OK	11.7	0.37	16.5	0.118	3	365
1249	Montrose Beach	2026-04-13 11:47:28.119529+00	OK	11.7	0.36	16.8	0.122	4	365
1250	Calumet Beach	2026-04-13 11:47:40.201644+00	OK	11.5	0.96	18.4	0.111	3	365
1251	Montrose Beach	2026-04-13 11:47:52.283377+00	OK	11.7	0.39	17.7	0.113	4	365
1252	Calumet Beach	2026-04-13 11:48:04.358499+00	OK	11.5	0.92	18.5	0.113	3	365
1253	Montrose Beach	2026-04-13 11:48:16.431798+00	OK	11.7	0.6	17.9	0.102	4	365
1254	Calumet Beach	2026-04-13 11:48:28.514041+00	OK	11.5	0.94	18.7	0.084	2	365
1255	Calumet Beach	2026-04-13 11:48:40.601531+00	OK	11.5	0.92	18.8	0.081	3	365
1256	Montrose Beach	2026-04-13 11:48:52.668762+00	OK	11.7	0.38	17.4	0.106	4	365
1257	Calumet Beach	2026-04-13 11:49:04.733494+00	OK	11.5	0.84	18.7	0.092	3	365
1258	Montrose Beach	2026-04-13 11:49:16.804614+00	OK	11.7	0.35	17.3	0.103	10	365
1259	Calumet Beach	2026-04-13 11:49:28.866383+00	OK	11.5	0.79	18.4	0.102	2	365
1260	Montrose Beach	2026-04-13 11:49:40.915942+00	OK	11.7	0.3	17.3	0.101	3	365
1261	Calumet Beach	2026-04-13 11:49:52.985554+00	OK	11.5	0.76	18.4	0.091	4	365
1262	Montrose Beach	2026-04-13 11:50:05.054715+00	OK	11.7	0.29	17.2	0.116	7	365
1263	Calumet Beach	2026-04-13 11:50:17.127408+00	OK	11.5	0.77	18.5	0.078	3	365
1264	Montrose Beach	2026-04-13 11:50:29.216132+00	OK	11.7	0.29	17	0.106	6	365
1265	Calumet Beach	2026-04-13 11:50:41.292122+00	OK	11.5	0.75	18.3	0.082	2	365
1266	Montrose Beach	2026-04-13 11:50:53.360624+00	OK	11.7	0.31	16.8	0.123	4	365
1267	Calumet Beach	2026-04-13 11:51:05.43364+00	OK	11.5	0.92	18.2	0.087	2	365
1268	Montrose Beach	2026-04-13 11:51:17.472229+00	OK	11.7	0.33	16.9	0.106	4	365
1269	Calumet Beach	2026-04-13 11:51:29.570699+00	OK	11.5	0.87	18.1	0.087	3	365
1270	Montrose Beach	2026-04-13 11:51:41.624402+00	OK	11.7	0.34	16.8	0.099	3	365
1271	Montrose Beach	2026-04-13 11:51:53.695128+00	OK	11.7	0.3	16.5	0.097	3	365
1272	Calumet Beach	2026-04-13 11:52:05.782755+00	OK	11.5	0.81	18	0.073	3	365
1273	Calumet Beach	2026-04-13 11:52:17.862554+00	OK	11.5	0.86	17.9	0.065	8	365
1274	Montrose Beach	2026-04-13 11:52:29.937726+00	OK	11.7	0.31	16.3	0.096	8	365
1275	Montrose Beach	2026-04-13 11:52:41.994044+00	OK	11.7	0.31	16.1	0.092	4	365
1276	Calumet Beach	2026-04-13 11:52:54.029528+00	OK	11.5	1.06	17.8	0.074	3	365
1277	Calumet Beach	2026-04-13 11:53:06.074264+00	OK	11.5	0.9	17.7	0.076	2	365
1278	Montrose Beach	2026-04-13 11:53:18.162546+00	OK	11.7	0.27	16	0.087	5	365
1279	Montrose Beach	2026-04-13 11:53:30.235044+00	OK	11.7	0.29	16.1	0.083	5	365
1280	Calumet Beach	2026-04-13 11:53:42.324095+00	OK	11.5	0.86	17.6	0.064	3	365
1281	Calumet Beach	2026-04-13 11:53:54.393052+00	OK	11.5	0.89	17.6	0.06	3	365
1282	Montrose Beach	2026-04-13 11:54:06.455142+00	OK	11.7	0.27	15.8	0.082	5	365
1283	Calumet Beach	2026-04-13 11:54:18.53913+00	OK	11.5	0.91	17.5	0.062	3	365
1284	Montrose Beach	2026-04-13 11:54:30.619216+00	OK	11.7	0.28	15.7	0.079	5	365
1285	Montrose Beach	2026-04-13 11:54:42.679154+00	OK	11.7	0.28	15.6	0.086	7	365
1286	Calumet Beach	2026-04-13 11:54:54.740274+00	OK	11.5	0.87	17.4	0.052	4	365
1287	Montrose Beach	2026-04-13 11:55:06.777321+00	OK	11.7	0.25	15.6	0.088	4	365
1288	Calumet Beach	2026-04-13 11:55:18.830966+00	OK	11.5	0.81	17.4	0.073	3	365
1289	Calumet Beach	2026-04-13 11:55:30.931627+00	OK	11.5	0.79	17.6	0.071	4	365
1290	Montrose Beach	2026-04-13 11:55:43.000766+00	OK	11.7	0.25	15.6	0.117	2	365
1291	Calumet Beach	2026-04-13 11:55:55.078023+00	OK	11.5	0.96	17.9	0.094	3	365
1292	Montrose Beach	2026-04-13 11:56:07.15304+00	OK	11.7	0.26	15.6	0.168	3	365
1293	Calumet Beach	2026-04-13 11:56:19.236726+00	OK	11.5	0.92	18.2	0.096	3	365
1294	Montrose Beach	2026-04-13 11:56:31.3249+00	OK	11.6	0.24	15.7	0.181	2	365
1295	Calumet Beach	2026-04-13 11:56:43.384485+00	OK	11.5	0.88	18.4	0.115	3	365
1296	Montrose Beach	2026-04-13 11:56:55.462926+00	OK	11.7	0.21	15.9	0.192	2	365
1297	Calumet Beach	2026-04-13 11:57:07.542876+00	OK	11.5	1.05	18.6	0.119	3	365
1298	Montrose Beach	2026-04-13 11:57:19.608115+00	OK	11.6	0.19	16.2	0.21	3	365
1299	Montrose Beach	2026-04-13 11:57:31.670546+00	OK	11.6	0.18	16.5	0.17	2	365
1300	Calumet Beach	2026-04-13 11:57:43.746725+00	OK	11.5	0.88	18.6	0.124	3	365
1301	Montrose Beach	2026-04-13 11:57:55.840529+00	OK	11.6	0.15	17	0.173	3	365
1302	Calumet Beach	2026-04-13 11:58:07.895107+00	OK	11.5	0.83	19	0.117	3	365
1303	Montrose Beach	2026-04-13 11:58:19.961196+00	OK	11.6	1.41	19.7	0.15	3	365
1304	Calumet Beach	2026-04-13 11:58:32.034806+00	OK	11.5	0.79	20.5	0.131	3	365
1305	Montrose Beach	2026-04-13 11:58:44.08525+00	OK	11.6	0.43	17.7	0.131	3	365
1306	Calumet Beach	2026-04-13 11:58:56.137532+00	OK	11.5	0.84	20.3	0.124	3	365
1307	Montrose Beach	2026-04-13 11:59:08.203588+00	OK	11.6	0.25	16.9	0.134	7	365
1308	Calumet Beach	2026-04-13 11:59:20.265672+00	OK	11.5	0.77	19.8	0.122	2	365
1309	Montrose Beach	2026-04-13 11:59:32.32665+00	OK	11.6	0.2	16.4	0.136	4	365
1310	Calumet Beach	2026-04-13 11:59:44.38797+00	OK	11.5	0.83	20	0.114	3	365
1311	Calumet Beach	2026-04-13 11:59:56.437233+00	OK	11.5	0.89	20.2	0.104	3	365
1312	Montrose Beach	2026-04-13 12:00:08.529341+00	OK	11.6	0.2	16.3	0.17	4	365
1313	Calumet Beach	2026-04-13 12:00:20.623606+00	OK	11.5	0.86	20.2	0.117	2	365
1314	Montrose Beach	2026-04-13 12:00:32.683619+00	OK	11.6	0.21	16.2	0.106	3	365
1315	Calumet Beach	2026-04-13 12:00:44.747019+00	OK	11.5	0.88	20	0.092	3	365
1316	Montrose Beach	2026-04-13 12:00:56.798603+00	OK	11.6	0.19	16.1	0.123	4	365
1317	Montrose Beach	2026-04-13 12:01:08.850236+00	OK	11.6	0.24	16	0.093	3	365
1318	Calumet Beach	2026-04-13 12:01:20.909192+00	OK	11.5	0.87	19.9	0.103	2	365
1319	Montrose Beach	2026-04-13 12:01:32.985001+00	OK	11.6	0.19	16	0.1	8	365
1320	Calumet Beach	2026-04-13 12:01:45.049944+00	OK	11.5	0.89	19.7	0.094	2	365
1321	Calumet Beach	2026-04-13 12:01:57.132298+00	OK	11.5	0.76	19.4	0.092	2	365
1322	Montrose Beach	2026-04-13 12:02:09.198205+00	OK	11.6	0.27	16	0.097	3	365
1323	Calumet Beach	2026-04-13 12:02:21.274484+00	OK	11.5	0.74	19.2	0.107	2	365
1324	Montrose Beach	2026-04-13 12:02:33.338498+00	OK	11.6	0.27	16	0.102	5	365
1325	Montrose Beach	2026-04-13 12:02:45.400734+00	OK	11.6	0.26	15.9	0.102	4	365
1326	Calumet Beach	2026-04-13 12:02:57.474154+00	OK	11.5	0.75	19.1	0.129	2	365
1327	Montrose Beach	2026-04-13 12:03:09.575298+00	OK	11.6	0.29	15.8	0.1	4	365
1328	Calumet Beach	2026-04-13 12:03:21.670766+00	OK	11.5	0.77	19	0.128	2	365
1329	Montrose Beach	2026-04-13 12:03:33.760642+00	OK	11.6	0.3	15.8	0.105	3	365
1330	Calumet Beach	2026-04-13 12:03:45.817127+00	OK	11.5	0.83	18.9	0.155	2	365
1331	Calumet Beach	2026-04-13 12:03:57.898539+00	OK	11.5	0.9	18.9	0.144	2	365
1332	Montrose Beach	2026-04-13 12:04:09.972461+00	OK	11.6	0.22	15.7	0.109	3	365
1333	Montrose Beach	2026-04-13 12:04:22.039767+00	OK	11.6	0.21	15.7	0.119	4	365
1334	Calumet Beach	2026-04-13 12:04:34.10833+00	OK	11.5	0.92	18.6	0.207	2	365
1335	Montrose Beach	2026-04-13 12:04:46.191576+00	OK	11.6	0.21	15.7	0.15	2	365
1336	Calumet Beach	2026-04-13 12:04:58.241543+00	OK	11.5	1.37	18.5	0.235	3	365
1337	Calumet Beach	2026-04-13 12:14:47.956376+00	OK	11.5	1.52	18.5	0.216	3	365
1338	Montrose Beach	2026-04-13 12:15:00.117572+00	OK	11.6	0.17	15.7	0.157	2	365
1339	Montrose Beach	2026-04-13 12:15:12.178702+00	OK	11.6	0.19	15.7	0.165	3	365
1340	Calumet Beach	2026-04-13 12:15:24.250019+00	OK	11.5	1.83	18.4	0.2	3	365
1341	Calumet Beach	2026-04-13 12:15:36.292157+00	OK	11.5	1.96	18.4	0.245	3	365
1342	Montrose Beach	2026-04-13 12:15:48.382033+00	OK	11.6	0.22	15.7	0.247	2	365
1343	Montrose Beach	2026-04-13 12:16:00.43505+00	OK	11.6	0.63	15.7	0.317	3	365
1344	Calumet Beach	2026-04-13 12:16:12.52094+00	OK	11.5	2	18.4	0.262	3	365
1345	Calumet Beach	2026-04-13 12:16:24.595744+00	OK	11.5	2.04	18.4	0.285	4	365
1346	Montrose Beach	2026-04-13 12:16:36.671844+00	OK	11.6	2.47	15.8	0.358	3	365
1347	Montrose Beach	2026-04-13 12:16:48.717122+00	OK	11.6	2.38	15.8	0.351	3	365
1348	Calumet Beach	2026-04-13 12:17:00.769001+00	OK	11.4	2.69	18.4	0.27	4	365
1349	Montrose Beach	2026-04-13 12:17:12.834685+00	OK	11.6	3.51	16	0.323	3	365
1350	Calumet Beach	2026-04-13 12:17:24.922825+00	OK	11.4	2.62	18.3	0.271	4	365
1351	Calumet Beach	2026-04-13 12:17:36.974564+00	OK	11.4	2.9	18.4	0.236	4	365
1352	Montrose Beach	2026-04-13 12:17:49.04993+00	OK	11.6	2.7	16.2	0.315	3	365
1353	Montrose Beach	2026-04-13 12:18:01.101979+00	OK	11.6	3.15	16.2	0.294	3	365
1354	Calumet Beach	2026-04-13 12:18:13.174039+00	OK	11.4	3.69	18.6	0.234	4	365
1355	Montrose Beach	2026-04-13 12:18:25.276029+00	OK	11.6	4.13	16.2	0.317	3	365
1356	Calumet Beach	2026-04-13 12:18:37.345538+00	OK	11.4	3.47	18.6	0.22	4	365
1357	Montrose Beach	2026-04-13 12:18:49.397157+00	OK	11.6	4.02	16.2	0.31	3	365
1358	Calumet Beach	2026-04-13 12:19:01.459416+00	OK	11.4	4.65	18.6	0.193	4	365
1359	Montrose Beach	2026-04-13 12:19:13.55773+00	OK	11.6	3.78	16.1	0.304	3	365
1360	Calumet Beach	2026-04-13 12:19:25.625442+00	OK	11.4	4.25	18.4	0.195	3	365
1361	Calumet Beach	2026-04-13 12:19:37.683553+00	OK	11.4	4.36	18.3	0.207	4	365
1362	Montrose Beach	2026-04-13 12:19:49.746341+00	OK	11.6	3.63	16.1	0.287	3	365
1363	Calumet Beach	2026-04-13 12:20:01.838778+00	OK	11.4	3.9	18.2	0.215	4	365
1364	Montrose Beach	2026-04-13 12:20:13.892282+00	OK	11.6	3.99	16.1	0.283	3	365
1365	Calumet Beach	2026-04-13 12:20:25.965024+00	OK	11.4	3.72	18.1	0.221	4	365
1366	Montrose Beach	2026-04-13 12:20:38.026217+00	OK	11.6	2.85	16	0.254	3	365
1367	Calumet Beach	2026-04-13 12:20:50.093072+00	OK	11.4	2.41	18	0.204	4	365
1368	Montrose Beach	2026-04-13 12:21:02.155027+00	OK	11.6	3.25	16	0.213	3	365
1369	Montrose Beach	2026-04-13 12:21:14.215875+00	OK	11.6	3.27	16	0.225	3	365
1370	Calumet Beach	2026-04-13 12:21:26.319589+00	OK	11.4	2.6	18	0.205	4	365
1371	Montrose Beach	2026-04-13 12:21:38.383317+00	OK	11.6	3.56	15.9	0.235	3	365
1372	Calumet Beach	2026-04-13 12:21:50.456488+00	OK	11.4	2.41	17.9	0.192	4	365
1373	Montrose Beach	2026-04-13 12:22:02.511975+00	OK	11.5	2.93	15.9	0.23	3	365
1374	Calumet Beach	2026-04-13 12:22:14.590052+00	OK	11.4	2.62	17.8	0.176	4	365
1375	Calumet Beach	2026-04-13 12:22:26.670088+00	OK	11.4	2.73	17.8	0.169	3	365
1376	Montrose Beach	2026-04-13 12:22:38.752181+00	OK	11.5	3.76	15.7	0.272	3	365
1377	Montrose Beach	2026-04-13 12:22:50.814155+00	OK	11.5	2.88	15.6	0.259	3	365
1378	Calumet Beach	2026-04-13 12:23:02.869644+00	OK	11.4	2.74	17.7	0.155	3	365
1379	Calumet Beach	2026-04-13 12:23:14.948432+00	OK	11.4	3.04	17.7	0.164	4	365
1380	Montrose Beach	2026-04-13 12:23:27.032601+00	OK	11.5	3.6	15.6	0.272	3	365
1381	Montrose Beach	2026-04-13 12:23:39.083457+00	OK	11.5	3.27	15.7	0.248	3	365
1382	Calumet Beach	2026-04-13 12:23:51.156924+00	OK	11.4	2.92	17.7	0.159	3	365
1383	Calumet Beach	2026-04-13 12:24:03.243248+00	OK	11.4	2.82	17.9	0.162	3	365
1384	Montrose Beach	2026-04-13 12:24:15.330473+00	OK	11.5	3.11	15.8	0.223	3	365
1385	Calumet Beach	2026-04-13 12:24:27.413828+00	OK	11.4	2.69	18	0.155	3	365
1386	Montrose Beach	2026-04-13 12:24:39.519341+00	OK	11.5	2.82	16.1	0.226	3	365
1387	Calumet Beach	2026-04-13 12:24:51.604228+00	OK	11.4	2.47	18.3	0.159	3	365
1388	Montrose Beach	2026-04-13 12:25:03.681522+00	OK	11.5	3.05	16.4	0.237	3	365
1389	Ohio Street Beach	2026-04-13 12:25:15.762985+00	OK	12.8	1.6	16.9	0.159	3	365
1390	Montrose Beach	2026-04-13 12:25:27.87755+00	OK	11.5	2.61	16.8	0.22	3	365
1391	Calumet Beach	2026-04-13 12:25:39.945776+00	OK	11.4	2.29	18.5	0.156	3	365
1392	Montrose Beach	2026-04-13 12:25:52.018649+00	OK	11.5	2.07	17.1	0.198	3	365
1393	Calumet Beach	2026-04-13 12:26:04.095828+00	OK	11.4	1.93	18.7	0.144	3	365
1394	Montrose Beach	2026-04-13 12:26:16.171749+00	OK	11.5	1.84	17.5	0.194	2	365
1395	Calumet Beach	2026-04-13 12:26:28.245349+00	OK	11.4	2.11	19.2	0.149	3	365
1396	Montrose Beach	2026-04-13 12:26:40.311657+00	OK	11.5	1.72	17.9	0.177	3	365
1397	Calumet Beach	2026-04-13 12:26:52.379079+00	OK	11.4	2.03	19.5	0.138	3	365
1398	Montrose Beach	2026-04-13 12:27:04.471838+00	OK	11.5	1.76	19.3	0.175	3	365
1399	Calumet Beach	2026-04-13 12:27:16.526206+00	OK	11.4	1.87	19.6	0.131	3	365
1400	Montrose Beach	2026-04-13 12:27:28.611855+00	OK	11.5	1.84	19.7	0.167	3	365
1401	Calumet Beach	2026-04-13 12:27:40.684263+00	OK	11.4	1.81	19.7	0.129	2	365
1402	Montrose Beach	2026-04-13 12:27:52.760919+00	OK	11.5	3.03	20	0.159	3	365
1403	Calumet Beach	2026-04-13 12:28:04.815929+00	OK	11.4	1.77	19.6	0.126	3	365
1404	Montrose Beach	2026-04-13 12:28:16.891958+00	OK	11.5	2.8	19.5	0.17	3	365
1405	Calumet Beach	2026-04-13 12:28:28.958071+00	OK	11.4	1.69	19.5	0.142	3	365
1406	Montrose Beach	2026-04-13 12:28:41.016252+00	OK	11.5	2.36	18.9	0.163	3	365
1407	Calumet Beach	2026-04-13 12:28:53.083175+00	OK	11.4	1.66	19.4	0.127	3	365
1408	Calumet Beach	2026-04-13 12:29:05.165488+00	OK	11.4	1.86	19.3	0.126	3	365
1409	Montrose Beach	2026-04-13 12:29:17.240533+00	OK	11.5	2.57	19.1	0.137	3	365
1410	Calumet Beach	2026-04-13 12:29:29.305921+00	OK	11.4	1.86	19.6	0.118	3	365
1411	Montrose Beach	2026-04-13 12:29:41.378369+00	OK	11.5	1.93	18.9	0.134	3	365
1412	Montrose Beach	2026-04-13 12:29:53.448851+00	OK	11.5	1.97	18	0.122	2	365
1413	Calumet Beach	2026-04-13 12:30:05.522973+00	OK	11.4	1.88	19.5	0.119	3	365
1414	Calumet Beach	2026-04-13 12:30:17.593183+00	OK	11.4	1.78	19.3	0.123	3	365
1415	Montrose Beach	2026-04-13 12:30:29.671675+00	OK	11.5	1.54	17.6	0.118	8	365
1416	Montrose Beach	2026-04-13 12:30:41.759609+00	OK	11.5	1.43	17.5	0.119	4	365
1417	Calumet Beach	2026-04-13 12:30:53.821902+00	OK	11.4	1.61	19	0.113	2	365
1418	Montrose Beach	2026-04-13 12:31:05.886364+00	OK	11.5	1.27	17.3	0.125	6	365
1419	Calumet Beach	2026-04-13 12:31:17.930559+00	OK	11.4	1.68	18.9	0.101	3	365
1420	Montrose Beach	2026-04-13 12:31:30.013007+00	OK	11.5	1.03	16.9	0.103	5	365
1421	Calumet Beach	2026-04-13 12:31:42.058016+00	OK	11.4	1.61	18.7	0.094	3	365
1422	Montrose Beach	2026-04-13 12:31:54.099107+00	OK	11.5	1.11	16.8	0.104	3	365
1423	Calumet Beach	2026-04-13 12:32:06.173647+00	OK	11.4	1.49	18.5	0.089	2	365
1424	Montrose Beach	2026-04-13 12:32:18.250407+00	OK	11.5	1.04	16.7	0.094	4	365
1425	Calumet Beach	2026-04-13 12:32:30.3308+00	OK	11.4	1.51	18.4	0.086	3	365
1426	Montrose Beach	2026-04-13 12:32:42.388071+00	OK	11.5	0.96	16.7	0.092	2	365
1427	Calumet Beach	2026-04-13 12:32:54.465143+00	OK	11.4	1.43	18.3	0.091	2	365
1428	Calumet Beach	2026-04-13 12:33:06.56418+00	OK	11.4	1.45	18.4	0.078	3	365
1429	Montrose Beach	2026-04-13 12:33:18.628032+00	OK	11.5	0.97	16.7	0.088	4	365
1430	Montrose Beach	2026-04-13 12:33:30.693396+00	OK	11.5	0.91	16.8	0.081	2	365
1431	Calumet Beach	2026-04-13 12:33:42.745869+00	OK	11.3	1.39	18.5	0.075	3	365
1432	Montrose Beach	2026-04-13 12:33:54.813493+00	OK	11.5	0.79	16.9	0.091	3	365
1433	Calumet Beach	2026-04-13 12:34:06.908255+00	OK	11.4	1.25	18.7	0.084	2	365
1434	Montrose Beach	2026-04-13 12:34:18.985308+00	OK	11.5	0.67	17.1	0.087	4	365
1435	Calumet Beach	2026-04-13 12:34:31.056476+00	OK	11.4	1.29	18.9	0.081	5	365
1436	Calumet Beach	2026-04-13 12:34:43.147303+00	OK	11.3	1.24	19.2	0.072	2	365
1437	Montrose Beach	2026-04-13 12:34:55.24996+00	OK	11.5	0.62	17.4	0.097	3	365
1438	Calumet Beach	2026-04-13 12:35:07.291213+00	OK	11.3	1.21	19.6	0.08	3	365
1439	Montrose Beach	2026-04-13 12:35:19.344435+00	OK	11.5	0.65	17.6	0.124	6	365
1440	Calumet Beach	2026-04-13 12:35:31.438096+00	OK	11.4	1.19	19.7	0.12	2	365
1441	Montrose Beach	2026-04-13 12:35:43.512563+00	OK	11.5	0.55	17.8	0.152	3	365
1442	Montrose Beach	2026-04-13 12:35:55.601324+00	OK	11.5	0.5	18	0.117	2	365
1443	Calumet Beach	2026-04-13 12:36:07.666719+00	OK	11.3	1.19	20.3	0.141	2	365
1444	Ohio Street Beach	2026-04-13 12:36:19.725172+00	OK	12.4	0.7	18.8	0.135	2	365
1445	Calumet Beach	2026-04-13 12:36:31.79962+00	OK	11.4	1.14	20.6	0.128	2	365
1446	Montrose Beach	2026-04-13 12:36:43.871063+00	OK	11.5	0.57	18.9	0.112	2	365
1447	Calumet Beach	2026-04-13 12:36:55.9603+00	OK	11.3	1.16	21	0.119	2	365
1448	Montrose Beach	2026-04-13 12:37:08.015121+00	OK	11.5	0.47	19.3	0.097	5	365
1449	Calumet Beach	2026-04-13 12:37:20.079883+00	OK	11.4	1.15	21	0.11	2	365
1450	Ohio Street Beach	2026-04-13 12:37:32.141513+00	OK	12.3	0.78	19.8	0.162	3	365
1451	Montrose Beach	2026-04-13 12:37:44.201964+00	OK	11.5	0.42	19.4	0.102	8	365
1452	Ohio Street Beach	2026-04-13 12:37:56.312732+00	OK	12.3	0.77	19.7	0.13	3	365
1453	Calumet Beach	2026-04-13 12:38:08.399325+00	OK	11.3	1.12	21	0.141	2	365
1454	Montrose Beach	2026-04-13 12:38:20.457834+00	OK	11.5	0.28	18.8	0.129	7	365
1455	Ohio Street Beach	2026-04-13 12:38:32.522033+00	OK	12.3	0.8	19.2	0.137	2	365
1456	Calumet Beach	2026-04-13 12:38:44.582654+00	OK	11.3	1.36	21.3	0.142	2	365
1457	Montrose Beach	2026-04-13 12:38:56.695973+00	OK	11.5	0.45	19.3	0.155	4	365
1458	Montrose Beach	2026-04-13 12:39:08.799596+00	OK	11.5	0.31	18.4	0.166	2	365
1459	Ohio Street Beach	2026-04-13 12:39:20.84437+00	OK	12.3	1.03	18.7	0.147	2	365
1460	Calumet Beach	2026-04-13 12:39:32.903246+00	OK	11.4	1.43	21.4	0.154	2	365
1461	Ohio Street Beach	2026-04-13 12:39:44.993841+00	OK	12.3	0.83	18.1	0.144	2	365
1462	Montrose Beach	2026-04-13 12:39:57.066587+00	OK	11.5	0.26	17.9	0.158	2	365
1463	Calumet Beach	2026-04-13 12:40:09.16198+00	OK	11.4	1.4	21.2	0.16	2	365
1464	Ohio Street Beach	2026-04-13 12:40:21.223098+00	OK	12.3	1	17.3	0.133	2	365
1465	Montrose Beach	2026-04-13 12:40:33.278197+00	OK	11.5	0.27	17.2	0.14	2	365
1466	Calumet Beach	2026-04-13 12:40:45.348886+00	OK	11.3	1.37	20.7	0.166	3	365
1467	Ohio Street Beach	2026-04-13 12:40:57.414789+00	OK	12.3	1.12	17.1	0.119	3	365
1468	Montrose Beach	2026-04-13 12:41:09.45801+00	OK	11.5	0.34	16.8	0.132	2	365
1469	Calumet Beach	2026-04-13 12:41:21.506894+00	OK	11.4	1.28	20.4	0.153	3	365
1470	Ohio Street Beach	2026-04-13 12:41:33.585964+00	OK	12.3	1.21	16.8	0.127	3	365
1471	Calumet Beach	2026-04-13 12:41:45.676914+00	OK	11.3	1.71	20.5	0.139	3	365
1472	Montrose Beach	2026-04-13 12:41:57.724338+00	OK	11.5	0.22	16.4	0.123	4	365
1473	Montrose Beach	2026-04-13 12:42:09.784445+00	OK	11.5	0.38	16.3	0.114	7	365
1474	Calumet Beach	2026-04-13 12:42:21.855444+00	OK	11.3	1.51	20.2	0.138	3	365
1475	Ohio Street Beach	2026-04-13 12:42:33.927486+00	OK	12.3	0.97	16.6	0.104	2	365
1476	Montrose Beach	2026-04-13 12:42:45.987883+00	OK	11.5	0.25	16.2	0.121	4	365
1477	Ohio Street Beach	2026-04-13 12:42:58.052651+00	OK	12.3	0.95	16.6	0.089	3	365
1478	Calumet Beach	2026-04-13 12:43:10.126053+00	OK	11.3	1.44	19.8	0.111	3	365
1479	Montrose Beach	2026-04-13 12:43:22.187205+00	OK	11.5	0.28	16.2	0.104	4	365
1480	Calumet Beach	2026-04-13 12:43:34.257262+00	OK	11.3	1.3	19.6	0.109	2	365
1481	Ohio Street Beach	2026-04-13 12:43:46.333258+00	OK	12.2	0.97	16.6	0.087	4	365
1482	Ohio Street Beach	2026-04-13 12:43:58.372817+00	OK	12.2	1.04	16.6	0.08	2	365
1483	Calumet Beach	2026-04-13 12:44:10.448693+00	OK	11.3	1.15	19.4	0.098	2	365
1484	Montrose Beach	2026-04-13 12:44:22.514248+00	OK	11.5	0.25	16.3	0.091	4	365
1485	Calumet Beach	2026-04-13 12:44:34.56502+00	OK	11.3	1.19	19.3	0.096	2	365
1486	Ohio Street Beach	2026-04-13 12:44:46.627897+00	OK	12.2	0.79	16.5	0.071	2	365
1487	Montrose Beach	2026-04-13 12:44:58.669728+00	OK	11.5	0.3	16.2	0.093	4	365
1488	Calumet Beach	2026-04-13 12:45:10.704536+00	OK	11.3	1.12	19.2	0.099	2	365
1489	Ohio Street Beach	2026-04-13 12:45:22.776377+00	OK	12.2	0.71	16.6	0.068	2	365
1490	Montrose Beach	2026-04-13 12:45:34.86332+00	OK	11.5	0.32	16.2	0.083	4	365
1491	Montrose Beach	2026-04-13 12:45:46.945801+00	OK	11.5	0.29	16.4	0.086	3	365
1492	Ohio Street Beach	2026-04-13 12:45:58.995925+00	OK	12.2	0.73	16.7	0.096	3	365
1493	Calumet Beach	2026-04-13 12:46:11.069348+00	OK	11.3	1	19.2	0.099	2	365
1494	Montrose Beach	2026-04-13 12:46:23.150688+00	OK	11.5	0.41	16.4	0.088	4	365
1495	Ohio Street Beach	2026-04-13 12:46:35.226333+00	OK	12.2	0.84	16.8	0.103	2	365
1496	Calumet Beach	2026-04-13 12:46:47.319252+00	OK	11.3	1.17	19.3	0.092	2	365
1497	Montrose Beach	2026-04-13 12:46:59.369733+00	OK	11.5	0.22	16.5	0.084	4	365
1498	Ohio Street Beach	2026-04-13 12:47:11.438271+00	OK	12.2	0.81	17	0.078	3	365
1499	Calumet Beach	2026-04-13 12:47:23.507701+00	OK	11.3	1.25	19.4	0.085	2	365
1500	Ohio Street Beach	2026-04-13 12:47:35.58968+00	OK	12.1	1.4	17.2	0.089	7	365
1501	Calumet Beach	2026-04-13 12:47:47.681195+00	OK	11.3	0.81	19.7	0.1	3	365
1502	Montrose Beach	2026-04-13 12:47:59.716481+00	OK	11.5	0.24	16.5	0.081	2	365
1503	Montrose Beach	2026-04-13 12:48:11.799332+00	OK	11.5	0.2	16.6	0.095	3	365
1504	Calumet Beach	2026-04-13 12:48:23.862549+00	OK	11.3	0.99	20.2	0.082	2	365
1505	Ohio Street Beach	2026-04-13 12:48:35.93541+00	OK	12.1	0.86	17.5	0.144	2	365
1506	Montrose Beach	2026-04-13 12:48:48.011453+00	OK	11.5	0.12	16.8	0.12	3	365
1507	Ohio Street Beach	2026-04-13 12:49:00.047039+00	OK	12.1	1.13	17.7	0.121	3	365
1508	Calumet Beach	2026-04-13 12:49:12.120125+00	OK	11.3	1.01	20.5	0.108	2	365
1509	Montrose Beach	2026-04-13 12:49:24.202029+00	OK	11.5	0.07	17	0.141	3	365
1510	Ohio Street Beach	2026-04-13 12:49:36.270803+00	OK	12.1	1.04	17.6	0.175	6	365
1511	Calumet Beach	2026-04-13 12:49:48.359012+00	OK	11.3	1.01	20.6	0.148	2	365
1512	Montrose Beach	2026-04-13 12:50:00.397544+00	OK	11.5	0.13	16.6	0.117	6	365
1513	Calumet Beach	2026-04-13 12:50:12.45761+00	OK	11.3	1.09	21.2	0.112	2	365
1514	Ohio Street Beach	2026-04-13 12:50:24.509315+00	OK	12.1	1.13	18.1	0.178	3	365
1515	Ohio Street Beach	2026-04-13 12:50:36.573552+00	OK	12.1	1.15	18.4	0.169	3	365
1516	Montrose Beach	2026-04-13 12:50:48.654582+00	OK	11.5	0.16	16.8	0.121	2	365
1517	Calumet Beach	2026-04-13 12:51:00.714367+00	OK	11.3	1.1	21.5	0.171	2	365
1518	Montrose Beach	2026-04-13 12:51:12.807264+00	OK	11.5	0.18	16.8	0.144	5	365
1519	Ohio Street Beach	2026-04-13 12:51:24.855686+00	OK	12.1	0.86	18.4	0.166	2	365
1520	Calumet Beach	2026-04-13 12:51:36.93757+00	OK	11.3	1.07	21.2	0.13	2	365
1521	Montrose Beach	2026-04-13 12:51:48.996362+00	OK	11.5	0.28	16.5	0.162	4	365
1522	Ohio Street Beach	2026-04-13 12:52:01.066746+00	OK	12.1	0.77	18.5	0.174	2	365
1523	Calumet Beach	2026-04-13 12:52:13.13674+00	OK	11.3	1.01	21.1	0.197	2	365
1524	Ohio Street Beach	2026-04-13 12:52:25.184778+00	OK	12.1	1.08	18.3	0.167	2	365
1525	Calumet Beach	2026-04-13 12:52:37.246088+00	OK	11.3	1.2	21.1	0.135	2	365
1526	Montrose Beach	2026-04-13 12:52:49.286572+00	OK	11.5	0.33	17.1	0.177	7	365
1527	Calumet Beach	2026-04-13 12:53:01.3444+00	OK	11.3	1.43	21.2	0.172	2	365
1528	Montrose Beach	2026-04-13 12:53:13.408037+00	OK	11.5	0.33	17.3	0.185	2	365
1529	Ohio Street Beach	2026-04-13 12:53:25.481969+00	OK	12.1	1.14	18.3	0.145	2	365
1530	Ohio Street Beach	2026-04-13 12:53:37.57012+00	OK	12.1	0.99	18	0.149	2	365
1531	Calumet Beach	2026-04-13 12:53:49.629358+00	OK	11.3	1.81	21.5	0.184	2	365
1532	Montrose Beach	2026-04-13 12:54:01.695181+00	OK	11.5	0.65	18	0.222	3	365
1533	Montrose Beach	2026-04-13 12:54:13.742579+00	OK	11.5	0.51	17.7	0.222	2	365
1534	Ohio Street Beach	2026-04-13 12:54:25.815775+00	OK	12.1	0.92	17.8	0.158	3	365
1535	Calumet Beach	2026-04-13 12:54:37.888799+00	OK	11.3	1.96	20.8	0.215	3	365
1536	Calumet Beach	2026-04-13 12:54:50.011257+00	OK	11.3	1.74	20.4	0.206	3	365
1537	Ohio Street Beach	2026-04-13 12:55:02.084779+00	OK	12	0.83	17.7	0.153	3	365
1538	Montrose Beach	2026-04-13 12:55:14.172348+00	OK	11.5	0.32	17.1	0.233	3	365
1539	Calumet Beach	2026-04-13 12:55:26.241393+00	OK	11.3	2.19	20.6	0.187	3	365
1540	Montrose Beach	2026-04-13 12:55:38.294172+00	OK	11.5	0.45	16.9	0.243	3	365
1541	Ohio Street Beach	2026-04-13 12:55:50.365432+00	OK	12	0.8	17.6	0.16	3	365
1542	Montrose Beach	2026-04-13 12:56:02.410581+00	OK	11.4	1.49	17.2	0.294	3	365
1543	Calumet Beach	2026-04-13 12:56:14.460704+00	OK	11.3	2.08	20.8	0.186	3	365
1544	Ohio Street Beach	2026-04-13 12:56:26.52778+00	OK	12	0.9	17.5	0.158	3	365
1545	Ohio Street Beach	2026-04-13 12:56:38.620691+00	OK	12	0.85	17.4	0.211	3	365
1546	Montrose Beach	2026-04-13 12:56:50.684029+00	OK	11.4	1.48	16.9	0.344	3	365
1547	Calumet Beach	2026-04-13 12:57:02.734321+00	OK	11.3	1.44	20.1	0.19	3	365
1548	Calumet Beach	2026-04-13 12:57:14.811852+00	OK	11.3	1.3	20	0.217	4	365
1549	Ohio Street Beach	2026-04-13 12:57:26.891296+00	OK	12	2.3	17.3	0.28	4	365
1550	Montrose Beach	2026-04-13 12:57:38.952124+00	OK	11.4	2.17	16.6	0.352	4	365
1551	Ohio Street Beach	2026-04-13 12:57:51.028181+00	OK	12	3.03	17.1	0.26	4	365
1552	Montrose Beach	2026-04-13 12:58:03.103953+00	OK	11.4	2.13	16.6	0.326	3	365
1553	Calumet Beach	2026-04-13 12:58:15.168017+00	OK	11.3	1.67	20	0.228	4	365
1554	Calumet Beach	2026-04-13 12:58:27.254737+00	OK	11.3	2.01	19.9	0.265	4	365
1555	Ohio Street Beach	2026-04-13 12:58:39.336988+00	OK	12	3.63	16.9	0.293	4	365
1556	Montrose Beach	2026-04-13 12:58:51.425793+00	OK	11.4	2.51	16.1	0.394	4	365
1557	Montrose Beach	2026-04-13 12:59:03.490538+00	OK	11.4	5.2	16.4	0.472	4	365
1558	Ohio Street Beach	2026-04-13 12:59:15.545494+00	OK	12	4.59	16.5	0.331	4	365
1559	Calumet Beach	2026-04-13 12:59:27.584868+00	OK	11.3	3.48	19.9	0.238	4	365
1560	Ohio Street Beach	2026-04-13 12:59:39.70001+00	OK	12	6.32	16.6	0.319	4	365
1561	Calumet Beach	2026-04-13 12:59:51.757869+00	OK	11.3	3.11	19.4	0.237	5	365
1562	Montrose Beach	2026-04-13 13:00:03.872325+00	OK	11.4	8.19	16.3	0.45	5	365
1563	Montrose Beach	2026-04-13 13:00:15.957283+00	Avvikelse	11.4	10.43	16.2	0.473	6	365
1564	Ohio Street Beach	2026-04-13 13:00:28.053286+00	OK	12	6.76	16.5	0.355	5	365
1565	Calumet Beach	2026-04-13 13:00:40.164916+00	OK	11.3	2.52	19.3	0.241	5	365
1566	Calumet Beach	2026-04-13 13:00:52.286992+00	OK	11.3	2.75	19.2	0.246	4	365
1567	Montrose Beach	2026-04-13 13:01:04.38402+00	Avvikelse	11.4	12.28	16.2	0.479	5	365
1568	Ohio Street Beach	2026-04-13 13:01:16.483791+00	OK	12	6.87	16.1	0.32	5	365
1569	Calumet Beach	2026-04-13 13:01:28.583264+00	OK	11.3	2.81	19.2	0.25	6	365
1570	Montrose Beach	2026-04-13 13:01:40.684091+00	Avvikelse	11.4	13.13	16.1	0.473	5	365
1571	Ohio Street Beach	2026-04-13 13:01:52.762772+00	OK	12	6.34	16	0.357	5	365
1572	Calumet Beach	2026-04-13 13:02:04.843407+00	OK	11	2.9	19.2	0.244	5	365
1573	Ohio Street Beach	2026-04-13 13:02:16.963026+00	OK	11.9	6.64	16	0.372	5	365
1574	Montrose Beach	2026-04-13 13:02:29.058737+00	Avvikelse	11.4	14.5	16.3	0.462	6	365
1575	Calumet Beach	2026-04-13 13:06:02.823894+00	OK	11.3	2.66	19.2	0.241	6	365
1576	Montrose Beach	2026-04-13 13:55:18.375906+00	Avvikelse	11.4	21.62	16.3	0.515	6	365
1577	Ohio Street Beach	2026-04-13 13:55:31.118471+00	OK	12	7.23	16.2	0.425	5	365
1578	Montrose Beach	2026-04-13 13:55:43.154216+00	Avvikelse	11.4	21.88	16.6	0.526	6	365
1579	Calumet Beach	2026-04-13 13:55:55.226654+00	OK	11.3	2.99	19.3	0.259	6	365
1580	Ohio Street Beach	2026-04-13 13:56:07.280409+00	OK	11.9	6.74	16.4	0.384	6	365
1581	Montrose Beach	2026-04-13 13:56:19.335671+00	Avvikelse	11.4	22.86	16.6	0.492	6	365
1582	Calumet Beach	2026-04-13 13:56:31.387276+00	OK	11.3	3.17	19.4	0.251	4	365
1583	Ohio Street Beach	2026-04-13 13:56:43.465078+00	OK	11.9	8.66	16.7	0.402	6	365
1584	Ohio Street Beach	2026-04-13 13:56:55.544148+00	OK	11.9	9.15	16.8	0.357	6	365
1585	Montrose Beach	2026-04-13 13:57:07.616242+00	Avvikelse	11.4	25.56	16.8	0.503	6	365
1586	Calumet Beach	2026-04-13 13:57:19.683221+00	OK	11	3.34	19.5	0.263	4	365
1587	Calumet Beach	2026-04-13 13:57:31.756322+00	OK	11.3	3.23	19.6	0.252	6	365
1588	Ohio Street Beach	2026-04-13 13:57:43.795448+00	OK	11.9	8.54	17	0.348	3	365
1589	Montrose Beach	2026-04-13 13:57:55.85894+00	Avvikelse	11.4	23.48	16.3	0.485	6	365
1590	Ohio Street Beach	2026-04-13 13:58:07.92665+00	OK	11.9	8.47	16.9	0.409	4	365
1591	Calumet Beach	2026-04-13 13:58:19.986256+00	OK	11.3	3.22	19.8	0.246	5	365
1592	Montrose Beach	2026-04-13 13:58:32.025285+00	Avvikelse	11.4	25.16	16.2	0.489	6	365
1593	Ohio Street Beach	2026-04-13 13:58:44.063184+00	OK	11.9	8.83	16.9	0.354	4	365
1594	Calumet Beach	2026-04-13 13:58:56.118473+00	OK	11.3	2.84	19.7	0.238	6	365
1595	Montrose Beach	2026-04-13 13:59:08.182872+00	Avvikelse	11.4	27.82	16	0.47	6	365
1596	Montrose Beach	2026-04-13 13:59:20.268622+00	Avvikelse	11.4	25.1	15.5	0.436	6	365
1597	Calumet Beach	2026-04-13 13:59:32.316535+00	OK	10.8	2.73	19.6	0.254	6	365
1598	Ohio Street Beach	2026-04-13 13:59:44.374982+00	OK	11.9	8.21	16.8	0.36	4	365
1599	Montrose Beach	2026-04-13 13:59:56.428473+00	Avvikelse	11.4	27.41	16	0.433	5	365
1600	Ohio Street Beach	2026-04-13 14:00:08.502946+00	OK	11.9	6.65	16.7	0.293	4	365
1601	Calumet Beach	2026-04-13 14:00:20.575343+00	OK	11.3	2.94	19.5	0.237	5	365
1602	Ohio Street Beach	2026-04-13 14:00:32.619923+00	OK	11.9	7.33	16.7	0.321	6	365
1603	Montrose Beach	2026-04-13 14:00:44.6792+00	Avvikelse	11.4	25.96	15.4	0.433	5	365
1604	Calumet Beach	2026-04-13 14:00:56.73372+00	OK	11.3	2.82	19.4	0.206	5	365
1605	Calumet Beach	2026-04-13 14:01:08.783688+00	OK	11.3	2.6	19.2	0.224	4	365
1606	Montrose Beach	2026-04-13 14:01:20.875444+00	Avvikelse	11.4	29.84	15.7	0.435	5	365
1607	Ohio Street Beach	2026-04-13 14:01:32.983904+00	OK	11.9	7	16.3	0.283	4	365
1608	Calumet Beach	2026-04-13 14:01:45.0507+00	OK	11.3	2.5	19.3	0.201	4	365
1609	Montrose Beach	2026-04-13 14:01:57.107002+00	Avvikelse	11.4	22.97	15.6	0.406	5	365
1610	Ohio Street Beach	2026-04-13 14:02:09.158469+00	OK	11.9	7.23	16.3	0.266	4	365
1611	Calumet Beach	2026-04-13 14:02:21.236569+00	OK	11.2	2.45	19.2	0.202	4	365
1612	Montrose Beach	2026-04-13 14:02:33.32115+00	Avvikelse	11.4	24.11	15.5	0.391	5	365
1613	Ohio Street Beach	2026-04-13 14:02:45.368195+00	OK	11.9	6.73	16.2	0.249	4	365
1614	Calumet Beach	2026-04-13 14:02:57.438784+00	OK	11.2	3.16	19	0.182	4	365
1615	Ohio Street Beach	2026-04-13 14:03:09.509689+00	OK	11.9	7.58	16.1	0.239	5	365
1616	Montrose Beach	2026-04-13 14:03:21.571058+00	Avvikelse	11.4	22.93	15.2	0.389	5	365
1617	Montrose Beach	2026-04-13 14:03:33.629921+00	Avvikelse	11.4	22.66	15.1	0.356	5	365
1618	Calumet Beach	2026-04-13 14:03:45.849494+00	OK	11.2	2.66	18.7	0.177	6	365
1619	Ohio Street Beach	2026-04-13 14:03:57.919629+00	OK	11.8	5.63	16	0.223	4	365
1620	Ohio Street Beach	2026-04-13 14:04:09.990445+00	OK	11.8	6.63	15.9	0.249	4	365
1621	Calumet Beach	2026-04-13 14:04:22.067471+00	OK	11.2	2.5	18.4	0.172	6	365
1622	Montrose Beach	2026-04-13 14:04:34.125568+00	Avvikelse	11.4	20.44	15	0.356	5	365
1623	Calumet Beach	2026-04-13 14:04:46.175952+00	OK	11.2	2.61	18.1	0.162	5	365
1624	Ohio Street Beach	2026-04-13 14:04:58.220535+00	OK	11.8	6.71	15.8	0.238	4	365
1625	Montrose Beach	2026-04-13 14:05:10.272228+00	Avvikelse	11.4	22.43	15.1	0.381	5	365
1626	Calumet Beach	2026-04-13 14:05:22.355988+00	OK	11.2	2.79	18	0.166	6	365
1627	Ohio Street Beach	2026-04-13 14:05:34.436954+00	OK	11.8	7.36	15.8	0.228	5	365
1628	Montrose Beach	2026-04-13 14:05:46.503135+00	Avvikelse	11.4	27.43	15.1	0.37	4	365
1629	Calumet Beach	2026-04-13 14:05:58.537083+00	OK	11.2	2.66	17.9	0.172	3	365
1630	Ohio Street Beach	2026-04-13 14:06:10.61466+00	OK	11.8	6.29	15.8	0.222	4	365
1631	Montrose Beach	2026-04-13 14:06:22.683968+00	Avvikelse	11.4	26.85	14.8	0.356	6	365
1632	Calumet Beach	2026-04-13 14:06:34.729094+00	OK	11.2	2.69	17.8	0.169	5	365
1633	Montrose Beach	2026-04-13 14:06:46.795748+00	Avvikelse	11.4	27.56	14.7	0.32	5	365
1634	Ohio Street Beach	2026-04-13 14:06:58.862609+00	OK	11.8	5.72	15.8	0.213	5	365
1635	Calumet Beach	2026-04-13 14:07:10.938985+00	OK	11.2	2.62	17.8	0.174	5	365
1636	Montrose Beach	2026-04-13 14:07:23.015547+00	Avvikelse	11.3	24.67	14.7	0.326	5	365
1637	Ohio Street Beach	2026-04-13 14:07:35.084993+00	OK	11.8	6.04	15.7	0.202	4	365
1638	Calumet Beach	2026-04-13 14:07:47.135255+00	OK	11.2	2.46	17.8	0.154	4	365
1639	Montrose Beach	2026-04-13 14:07:59.228167+00	Avvikelse	11.3	23.8	14.8	0.324	4	365
1640	Ohio Street Beach	2026-04-13 14:08:11.30365+00	OK	11.8	6.15	15.8	0.201	4	365
1641	Calumet Beach	2026-04-13 14:08:23.401675+00	OK	11.2	2.36	18	0.147	5	365
1642	Montrose Beach	2026-04-13 14:08:35.464531+00	Avvikelse	11.3	22.61	15	0.313	4	365
1643	Ohio Street Beach	2026-04-13 14:08:47.528855+00	OK	11.8	6.52	16	0.21	4	365
1644	Ohio Street Beach	2026-04-13 14:08:59.600291+00	OK	11.8	4.62	16.3	0.218	3	365
1645	Montrose Beach	2026-04-13 14:09:11.675034+00	Avvikelse	11.3	20.41	15.1	0.3	4	365
1646	Calumet Beach	2026-04-13 14:09:23.752339+00	OK	11.2	2.41	18.2	0.143	5	365
1647	Calumet Beach	2026-04-13 14:09:35.819322+00	OK	11.2	2.19	18.4	0.143	5	365
1648	Ohio Street Beach	2026-04-13 14:09:47.874775+00	OK	11.8	5.04	16.6	0.199	4	365
1649	Montrose Beach	2026-04-13 14:09:59.941276+00	Avvikelse	11.3	20.43	15.4	0.28	4	365
1650	Montrose Beach	2026-04-13 14:10:12.016718+00	Avvikelse	11.3	23.42	15.6	0.289	3	365
1651	Calumet Beach	2026-04-13 14:10:24.069303+00	OK	11.2	2.12	18.7	0.13	4	365
1652	Ohio Street Beach	2026-04-13 14:10:36.120027+00	OK	11.8	4.67	16.9	0.201	4	365
1653	Ohio Street Beach	2026-04-13 14:10:48.168231+00	OK	11.8	3.17	17.6	0.193	4	365
1654	Calumet Beach	2026-04-13 14:11:00.23778+00	OK	11.2	2.11	18.9	0.128	4	365
1655	Montrose Beach	2026-04-13 14:11:12.298718+00	Avvikelse	11.3	23.26	15.9	0.278	3	365
1656	Montrose Beach	2026-04-13 14:11:24.363826+00	Avvikelse	11.3	22.69	16.1	0.314	3	365
1657	Ohio Street Beach	2026-04-13 14:11:36.422101+00	OK	11.8	3.64	18.1	0.199	3	365
1658	Calumet Beach	2026-04-13 14:11:48.494049+00	OK	11.2	2.04	19.3	0.129	3	365
1659	Ohio Street Beach	2026-04-13 14:12:00.572578+00	OK	11.8	5.17	17.9	0.237	3	365
1660	Calumet Beach	2026-04-13 14:12:12.647606+00	OK	11.2	2.04	19.2	0.134	4	365
1661	Montrose Beach	2026-04-13 14:12:24.763053+00	Avvikelse	11.3	24.59	16.3	0.324	3	365
1662	Calumet Beach	2026-04-13 14:12:36.813058+00	OK	11.2	1.97	19.3	0.133	3	365
1663	Ohio Street Beach	2026-04-13 14:12:48.881072+00	OK	11.8	6.31	17.9	0.213	4	365
1664	Montrose Beach	2026-04-13 14:13:00.949318+00	Avvikelse	11.3	24.59	16.5	0.312	3	365
1665	Calumet Beach	2026-04-13 14:13:13.021044+00	OK	11.2	1.94	19.4	0.15	4	365
1666	Ohio Street Beach	2026-04-13 14:13:25.094629+00	OK	11.8	5.21	18.1	0.219	4	365
1667	Montrose Beach	2026-04-13 14:13:37.172841+00	Avvikelse	11.3	25.45	16.6	0.33	3	365
1668	Montrose Beach	2026-04-13 14:13:49.23901+00	Avvikelse	11.3	26.29	16.5	0.295	3	365
1669	Ohio Street Beach	2026-04-13 14:14:01.30417+00	OK	11.7	5.14	17.9	0.272	4	365
1670	Calumet Beach	2026-04-13 14:14:13.378716+00	OK	11.2	2.02	19.3	0.15	4	365
1671	Ohio Street Beach	2026-04-13 14:14:25.462239+00	OK	11.7	4.67	18.1	0.216	3	365
1672	Montrose Beach	2026-04-13 14:14:37.514638+00	Avvikelse	11.3	26.67	16.4	0.299	3	365
1673	Calumet Beach	2026-04-13 14:14:49.583557+00	OK	11.2	1.86	19.4	0.16	4	365
1674	Calumet Beach	2026-04-13 14:15:01.663549+00	OK	11.2	1.91	19.3	0.167	4	365
1675	Montrose Beach	2026-04-13 14:15:13.716564+00	Avvikelse	11.3	25.89	16.4	0.303	3	365
1676	Ohio Street Beach	2026-04-13 14:15:25.777205+00	OK	11.7	4.33	17.9	0.203	3	365
1677	Calumet Beach	2026-04-13 14:15:37.837755+00	OK	11.2	2.07	19	0.168	3	365
1678	Ohio Street Beach	2026-04-13 14:15:49.911881+00	OK	11.7	6.24	17.9	0.189	3	365
1679	Montrose Beach	2026-04-13 14:16:01.975184+00	Avvikelse	11.3	26.98	16.5	0.303	3	365
1680	Montrose Beach	2026-04-13 14:16:14.038715+00	Avvikelse	11.3	24.35	16.2	0.268	3	365
1681	Ohio Street Beach	2026-04-13 14:16:26.10818+00	OK	11.7	4.83	17.4	0.199	3	365
1682	Calumet Beach	2026-04-13 14:16:38.169538+00	OK	11.2	2.17	18.8	0.161	3	365
1683	Montrose Beach	2026-04-13 14:16:50.237283+00	Avvikelse	11.3	24.91	16.2	0.284	3	365
1684	Ohio Street Beach	2026-04-13 14:17:02.306678+00	OK	11.7	4.42	17.4	0.182	3	365
1685	Calumet Beach	2026-04-13 14:17:14.410542+00	OK	11.2	2.14	18.7	0.15	3	365
1686	Calumet Beach	2026-04-13 14:17:26.4831+00	OK	11.2	2.19	18.6	0.142	3	365
1687	Ohio Street Beach	2026-04-13 14:17:38.553719+00	OK	11.7	4.81	16.7	0.168	3	365
1688	Montrose Beach	2026-04-13 14:17:50.616364+00	Avvikelse	11.3	23.49	16.2	0.271	3	365
1689	Montrose Beach	2026-04-13 14:18:02.703395+00	Avvikelse	11.3	23.45	16.2	0.261	3	365
1690	Calumet Beach	2026-04-13 14:18:14.752524+00	OK	11.2	2.2	18.5	0.15	3	365
1691	Ohio Street Beach	2026-04-13 14:18:26.816241+00	OK	11.7	3.98	17.1	0.173	3	365
1692	Calumet Beach	2026-04-13 14:18:38.880479+00	OK	11.2	2.08	18.4	0.136	3	365
1693	Ohio Street Beach	2026-04-13 14:18:50.957161+00	OK	11.7	3.27	17	0.152	3	365
1694	Montrose Beach	2026-04-13 14:19:03.023034+00	Avvikelse	11.3	24.22	16.1	0.262	3	365
1695	Montrose Beach	2026-04-13 14:19:15.097713+00	Avvikelse	11.3	27.1	16	0.247	4	365
1696	Ohio Street Beach	2026-04-13 14:19:27.174964+00	OK	11.7	3.4	16.9	0.162	3	365
1697	Calumet Beach	2026-04-13 14:19:39.239726+00	OK	11.2	1.98	18.3	0.136	4	365
1698	Ohio Street Beach	2026-04-13 14:19:51.287008+00	OK	11.7	3.41	16.5	0.157	3	365
1699	Calumet Beach	2026-04-13 14:20:03.356523+00	OK	11.2	1.93	18.3	0.134	4	365
1700	Montrose Beach	2026-04-13 14:20:15.437763+00	Avvikelse	11.3	24.79	16	0.264	3	365
1701	Montrose Beach	2026-04-13 14:20:27.52033+00	Avvikelse	11.3	25.78	15.9	0.267	4	365
1702	Ohio Street Beach	2026-04-13 14:20:39.59919+00	OK	11.7	3.6	16.5	0.152	3	365
1703	Calumet Beach	2026-04-13 14:20:51.649836+00	OK	11.2	1.83	18.2	0.136	4	365
1704	Calumet Beach	2026-04-13 14:21:03.72917+00	OK	11.2	1.86	18.2	0.13	4	365
1705	Montrose Beach	2026-04-13 14:21:15.791409+00	Avvikelse	11.3	25.29	15.8	0.293	3	365
1706	Ohio Street Beach	2026-04-13 14:21:27.84509+00	OK	11.7	4.13	16.2	0.159	3	365
1707	Montrose Beach	2026-04-13 14:21:39.896848+00	Avvikelse	11.3	27.6	15.8	0.287	3	365
1708	Ohio Street Beach	2026-04-13 14:21:51.983068+00	OK	11.7	4.2	15.9	0.178	4	365
1709	Calumet Beach	2026-04-13 14:22:04.047956+00	OK	11.2	1.82	18.1	0.124	3	365
1710	Calumet Beach	2026-04-13 14:22:16.114639+00	OK	11.2	1.68	18.1	0.127	3	365
1711	Ohio Street Beach	2026-04-13 14:22:28.162492+00	OK	11.7	4.25	15.7	0.204	3	365
1712	Montrose Beach	2026-04-13 14:22:40.21222+00	Avvikelse	11.3	24.67	15.8	0.284	3	365
1713	Ohio Street Beach	2026-04-13 14:22:52.299117+00	OK	11.7	4.06	15.9	0.188	4	365
1714	Montrose Beach	2026-04-13 14:23:04.366317+00	Avvikelse	11.3	27.8	15.7	0.286	3	365
1715	Calumet Beach	2026-04-13 14:23:16.430094+00	OK	11.2	1.62	18.1	0.132	3	365
1716	Ohio Street Beach	2026-04-13 14:23:28.497367+00	OK	11.7	4.45	16	0.211	3	365
1717	Calumet Beach	2026-04-13 14:23:40.548955+00	OK	11.2	1.67	18.1	0.129	3	365
1718	Montrose Beach	2026-04-13 14:23:52.628467+00	Avvikelse	11.3	25.19	15.8	0.298	3	365
1719	Ohio Street Beach	2026-04-13 14:24:04.68964+00	OK	11.7	4.23	16.1	0.206	3	365
1720	Montrose Beach	2026-04-13 14:24:16.738966+00	Avvikelse	11.3	24.74	15.9	0.274	3	365
1721	Calumet Beach	2026-04-13 14:24:28.793347+00	OK	11.2	1.65	18.1	0.131	3	365
1722	Calumet Beach	2026-04-13 14:24:40.871818+00	OK	11.2	1.64	18.1	0.136	3	365
1723	Montrose Beach	2026-04-13 14:24:52.938509+00	Avvikelse	11.3	23.64	15.9	0.279	3	365
1724	Ohio Street Beach	2026-04-13 14:25:04.991678+00	OK	11.7	4.29	16.2	0.198	3	365
1725	Calumet Beach	2026-04-13 14:25:17.042793+00	OK	11.1	1.64	18.1	0.139	3	365
1726	Montrose Beach	2026-04-13 14:25:29.111982+00	Avvikelse	11.3	25.25	15.9	0.319	3	365
1727	Ohio Street Beach	2026-04-13 14:25:41.16179+00	OK	11.7	4.46	16.2	0.205	3	365
1728	Calumet Beach	2026-04-13 14:25:53.233439+00	OK	11.2	1.7	18.1	0.143	3	365
1729	Ohio Street Beach	2026-04-13 14:26:05.281539+00	OK	11.7	4.76	16.2	0.211	3	365
1730	Montrose Beach	2026-04-13 14:26:17.360805+00	Avvikelse	11.3	22.89	15.9	0.313	3	365
1731	Montrose Beach	2026-04-13 14:26:29.40271+00	Avvikelse	11.3	23.63	15.8	0.319	3	365
1732	Calumet Beach	2026-04-13 14:26:41.45164+00	OK	11.2	1.7	18.1	0.152	3	365
1733	Ohio Street Beach	2026-04-13 14:26:53.544588+00	OK	11.7	4.8	16.2	0.225	3	365
1734	Montrose Beach	2026-04-13 14:27:05.621382+00	Avvikelse	11.3	21.3	15.8	0.336	3	365
1735	Ohio Street Beach	2026-04-13 14:27:17.70855+00	OK	11.7	4.84	16.2	0.217	4	365
1736	Calumet Beach	2026-04-13 14:27:29.777232+00	OK	11.1	1.78	18	0.155	4	365
1737	Montrose Beach	2026-04-13 14:27:41.830204+00	Avvikelse	11.3	22.1	15.8	0.335	3	365
1738	Ohio Street Beach	2026-04-13 14:27:53.895857+00	OK	11.7	5.58	16.1	0.242	3	365
1739	Calumet Beach	2026-04-13 14:28:05.955129+00	OK	11.2	1.75	18	0.174	4	365
1740	Ohio Street Beach	2026-04-13 14:28:18.035705+00	OK	11.7	5.49	16	0.256	4	365
1741	Montrose Beach	2026-04-13 14:28:30.10414+00	Avvikelse	11.3	22.12	15.8	0.355	4	365
1742	Calumet Beach	2026-04-13 14:28:42.180697+00	OK	11.1	1.84	18	0.181	4	365
1743	Ohio Street Beach	2026-04-13 14:28:54.277128+00	OK	11.6	5.5	15.8	0.243	4	365
1744	Montrose Beach	2026-04-13 14:29:06.354807+00	Avvikelse	11.3	21.89	15.7	0.376	4	365
1745	Calumet Beach	2026-04-13 14:29:18.405324+00	OK	11.1	2.08	17.9	0.178	4	365
1746	Ohio Street Beach	2026-04-13 14:29:30.492815+00	OK	11.6	5.64	15.7	0.262	4	365
1747	Montrose Beach	2026-04-13 14:29:42.568763+00	Avvikelse	11.3	17.97	15.6	0.356	4	365
1748	Calumet Beach	2026-04-13 14:29:54.624336+00	OK	11.1	2.23	17.9	0.214	4	365
1749	Calumet Beach	2026-04-13 14:30:06.699648+00	OK	11.1	2.32	17.8	0.258	4	365
1750	Montrose Beach	2026-04-13 14:30:18.758549+00	Avvikelse	11.3	18.58	15.6	0.383	4	365
1751	Ohio Street Beach	2026-04-13 14:30:30.80148+00	OK	11.6	6.35	15.6	0.289	4	365
1752	Calumet Beach	2026-04-13 14:30:42.841175+00	OK	11.1	3.11	17.7	0.25	4	365
1753	Montrose Beach	2026-04-13 14:30:54.909155+00	Avvikelse	11.3	22.51	15.6	0.42	4	365
1754	Ohio Street Beach	2026-04-13 14:31:06.987988+00	OK	11.6	6.79	15.6	0.311	4	365
1755	Ohio Street Beach	2026-04-13 14:31:19.051738+00	OK	11.6	7.62	15.5	0.294	4	365
1756	Montrose Beach	2026-04-13 14:31:31.123751+00	Avvikelse	11.3	23.9	15.5	0.427	4	365
1757	Calumet Beach	2026-04-13 14:31:43.186858+00	OK	11.1	3.14	17.6	0.265	4	365
1758	Calumet Beach	2026-04-13 14:31:55.240357+00	OK	11.1	3.39	17.6	0.259	4	365
1759	Ohio Street Beach	2026-04-13 14:32:07.309641+00	OK	11.6	6.53	15.5	0.308	4	365
1760	Montrose Beach	2026-04-13 14:32:19.378672+00	Avvikelse	11.3	24.98	15.5	0.409	4	365
1761	Ohio Street Beach	2026-04-13 14:32:31.445946+00	OK	11.6	6.13	15.5	0.274	4	365
1762	Montrose Beach	2026-04-13 14:32:43.494619+00	Avvikelse	11.3	22.81	15.4	0.41	4	365
1763	Calumet Beach	2026-04-13 14:32:55.550996+00	OK	11.1	4.33	17.6	0.273	4	365
1764	Calumet Beach	2026-04-13 14:33:07.570937+00	OK	11.1	3.85	17.5	0.274	5	365
1765	Ohio Street Beach	2026-04-13 14:33:19.618308+00	OK	11.6	5.72	15.5	0.247	4	365
1766	Montrose Beach	2026-04-13 14:33:31.690945+00	Avvikelse	11.3	23.43	15.4	0.45	4	365
1767	Ohio Street Beach	2026-04-13 14:33:43.776032+00	OK	11.6	5.4	15.5	0.257	4	365
1768	Calumet Beach	2026-04-13 14:33:55.860964+00	OK	11.1	3.64	17.4	0.238	4	365
1769	Montrose Beach	2026-04-13 14:34:07.917636+00	Avvikelse	11.3	23.19	15.4	0.415	4	365
1770	Montrose Beach	2026-04-13 14:34:20.001297+00	Avvikelse	11.3	22.57	15.3	0.466	5	365
1771	Ohio Street Beach	2026-04-13 14:34:32.073118+00	OK	11.6	5.24	15.5	0.297	4	365
1772	Calumet Beach	2026-04-13 14:34:44.132152+00	OK	11.1	3.28	17.5	0.254	4	365
1773	Calumet Beach	2026-04-13 14:34:56.216386+00	OK	11.1	2.46	17.5	0.209	4	365
1774	Montrose Beach	2026-04-13 14:35:08.303615+00	Avvikelse	11.2	23.97	15.3	0.455	5	365
1775	Ohio Street Beach	2026-04-13 14:35:20.353043+00	OK	11.6	6.31	15.4	0.28	4	365
1776	Montrose Beach	2026-04-13 14:35:32.420787+00	Avvikelse	11.3	24.57	15.2	0.406	4	365
1777	Ohio Street Beach	2026-04-13 14:35:44.481555+00	OK	11.6	7.16	15.4	0.254	4	365
1778	Calumet Beach	2026-04-13 14:35:56.513508+00	OK	11.1	2.39	17.5	0.171	4	365
1779	Montrose Beach	2026-04-13 14:36:08.595592+00	Avvikelse	11.3	23.78	15.2	0.385	5	365
1780	Calumet Beach	2026-04-13 14:36:20.668495+00	OK	11.1	2.62	17.4	0.156	4	365
1781	Ohio Street Beach	2026-04-13 14:36:32.734004+00	OK	11.6	5.61	15.5	0.257	5	365
1782	Calumet Beach	2026-04-13 14:36:44.797831+00	OK	11.1	2.74	17.4	0.161	4	365
1783	Montrose Beach	2026-04-13 14:36:56.889696+00	Avvikelse	11.3	21.88	15.2	0.394	5	365
1784	Ohio Street Beach	2026-04-13 14:37:08.984701+00	OK	11.6	5.67	15.6	0.22	4	365
1785	Montrose Beach	2026-04-13 14:37:21.041562+00	Avvikelse	11.3	18.94	15.3	0.36	4	365
1786	Ohio Street Beach	2026-04-13 14:37:33.08279+00	OK	11.6	5.99	15.6	0.224	5	365
1787	Calumet Beach	2026-04-13 14:37:45.139595+00	OK	11.1	2.71	17.3	0.154	4	365
1788	Ohio Street Beach	2026-04-13 14:37:57.206978+00	OK	11.6	6.24	15.6	0.23	5	365
1789	Montrose Beach	2026-04-13 14:38:09.278568+00	Avvikelse	11.3	17.91	15.3	0.357	4	365
1790	Calumet Beach	2026-04-13 14:38:21.343874+00	OK	11.1	2.71	17.1	0.155	4	365
1791	Calumet Beach	2026-04-13 14:38:33.401074+00	OK	11.1	2.46	17	0.157	4	365
1792	Ohio Street Beach	2026-04-13 14:38:45.478921+00	OK	11.6	7.43	15.7	0.256	5	365
1793	Montrose Beach	2026-04-13 14:38:57.544854+00	Avvikelse	11.2	18.59	15.3	0.348	5	365
1794	Calumet Beach	2026-04-13 14:39:09.605841+00	OK	11.1	2.34	17.2	0.144	5	365
1795	Ohio Street Beach	2026-04-13 14:39:21.662292+00	OK	11.6	7.41	15.7	0.225	4	365
1796	Montrose Beach	2026-04-13 14:39:33.724532+00	Avvikelse	11.2	19.14	15.3	0.339	5	365
1797	Calumet Beach	2026-04-13 14:39:45.779216+00	OK	11.1	2.27	17.2	0.153	4	365
1798	Ohio Street Beach	2026-04-13 14:39:57.826966+00	OK	11.6	7.01	16	0.221	4	365
1799	Montrose Beach	2026-04-13 14:40:09.897322+00	Avvikelse	11.2	18.05	15.6	0.31	4	365
1800	Montrose Beach	2026-04-13 14:40:21.970971+00	Avvikelse	11.2	18.28	15.8	0.289	4	365
1801	Calumet Beach	2026-04-13 14:40:34.056595+00	OK	11.1	2.13	17.5	0.145	4	365
1802	Ohio Street Beach	2026-04-13 14:40:46.145869+00	OK	11.6	6.95	16.3	0.186	4	365
1803	Ohio Street Beach	2026-04-13 14:40:58.191811+00	OK	11.6	6.88	16.5	0.172	4	365
1804	Montrose Beach	2026-04-13 14:41:10.22718+00	Avvikelse	11.2	18.23	16	0.283	3	365
1805	Calumet Beach	2026-04-13 14:41:22.286685+00	OK	11.1	2.13	17.7	0.14	4	365
1806	Ohio Street Beach	2026-04-13 14:41:34.347886+00	OK	11.6	6.68	16.5	0.18	4	365
1807	Calumet Beach	2026-04-13 14:41:46.419012+00	OK	11.1	2.09	17.9	0.125	4	365
1808	Montrose Beach	2026-04-13 14:41:58.479301+00	Avvikelse	11.2	19.3	16	0.282	4	365
1809	Calumet Beach	2026-04-13 14:42:10.531626+00	OK	11.1	1.98	17.8	0.122	3	365
1810	Ohio Street Beach	2026-04-13 14:42:22.59921+00	OK	11.6	6.27	16.5	0.175	4	365
1811	Montrose Beach	2026-04-13 14:42:34.678891+00	Avvikelse	11.2	15.05	15.8	0.275	4	365
1812	Montrose Beach	2026-04-13 14:42:46.751629+00	Avvikelse	11.2	14.7	15.8	0.284	4	365
1813	Calumet Beach	2026-04-13 14:42:58.826976+00	OK	11.1	1.96	17.7	0.124	4	365
1814	Ohio Street Beach	2026-04-13 14:43:10.889182+00	OK	11.6	5.89	16.7	0.185	4	365
1815	Calumet Beach	2026-04-13 14:43:22.94502+00	OK	10.9	1.99	17.8	0.139	4	365
1816	Montrose Beach	2026-04-13 14:43:35.014792+00	Avvikelse	11.2	14.92	15.9	0.267	3	365
1817	Ohio Street Beach	2026-04-13 14:43:47.091718+00	OK	11.6	5.53	16.7	0.197	5	365
1818	Ohio Street Beach	2026-04-13 14:43:59.119074+00	OK	11.6	5.78	16.6	0.174	5	365
1819	Calumet Beach	2026-04-13 14:44:11.185228+00	OK	11.1	2.37	18.2	0.141	4	365
1820	Montrose Beach	2026-04-13 14:44:23.238236+00	Avvikelse	11.2	12.94	15.9	0.25	5	365
1821	Ohio Street Beach	2026-04-13 14:44:35.335341+00	OK	11.6	7.07	16.2	0.176	4	365
1822	Calumet Beach	2026-04-13 14:44:47.39223+00	OK	11.1	2.29	18.1	0.13	5	365
1823	Montrose Beach	2026-04-13 14:44:59.438804+00	Avvikelse	11.2	13.53	15.9	0.242	4	365
1824	Ohio Street Beach	2026-04-13 14:45:11.495924+00	OK	11.5	6.45	15.9	0.177	5	365
1825	Calumet Beach	2026-04-13 14:45:23.544606+00	OK	11.1	2.32	18.1	0.126	4	365
1826	Montrose Beach	2026-04-13 14:45:35.595631+00	Avvikelse	11.2	14.29	15.9	0.234	4	365
1827	Ohio Street Beach	2026-04-13 14:45:47.677454+00	OK	11.5	6.91	15.8	0.156	4	365
1828	Montrose Beach	2026-04-13 14:45:59.746834+00	Avvikelse	11.2	14.3	15.9	0.227	4	365
1829	Montrose Beach	2026-04-13 14:46:12.520282+00	OK	9.4	1.18	20.3	0.08	3	365
1830	Osterman Beach	2026-04-13 14:46:24.589552+00	OK	9.4	3.51	21.5	0.231	4	365
1831	Ohio Street Beach	2026-04-13 14:46:36.658422+00	OK	9.4	4.97	21.9	0.241	7	365
1832	Calumet Beach	2026-04-13 14:46:48.709391+00	OK	9.4	3.63	23.2	0.174	6	365
1833	63rd Street Beach	2026-04-13 14:47:00.792769+00	OK	11	7.56	18.9	0.14	4	365
1834	Rainbow Beach	2026-04-13 14:47:12.864978+00	OK	12.6	0.74	27.1	0.013	10	365
1835	Montrose Beach	2026-04-13 14:47:24.921706+00	OK	11.9	3.36	14.4	0.298	4	365
1836	Calumet Beach	2026-04-13 14:47:37.000528+00	OK	11.7	1.26	16.2	0.147	4	365
1837	Montrose Beach	2026-04-13 14:47:49.075234+00	OK	11.9	2.72	14.5	0.306	3	365
1838	Calumet Beach	2026-04-13 14:48:01.130515+00	OK	11.7	1.28	16.3	0.162	4	365
1839	Calumet Beach	2026-04-13 14:48:13.213491+00	OK	11.7	1.32	16.5	0.185	4	365
1840	Montrose Beach	2026-04-13 14:48:25.255706+00	OK	11.9	2.97	14.8	0.328	3	365
1841	Montrose Beach	2026-04-13 14:48:37.313409+00	OK	11.9	4.3	14.5	0.328	3	365
1842	Calumet Beach	2026-04-13 14:48:49.351924+00	OK	11.7	1.31	16.8	0.196	4	365
1843	Calumet Beach	2026-04-13 14:49:01.437618+00	OK	11.7	1.37	17.1	0.194	4	365
1844	Montrose Beach	2026-04-13 14:49:13.513187+00	OK	11.9	4.87	14.4	0.341	3	365
1845	Calumet Beach	2026-04-13 14:49:25.581638+00	OK	11.7	1.48	17.2	0.203	4	365
1846	Montrose Beach	2026-04-13 14:49:37.74155+00	OK	11.9	5.06	14.1	0.34	4	365
1847	Calumet Beach	2026-04-13 14:49:49.822557+00	OK	11.7	1.8	17.1	0.188	4	365
1848	Montrose Beach	2026-04-13 14:50:01.873038+00	OK	11.9	5.76	14.2	0.356	3	365
1849	Calumet Beach	2026-04-13 14:50:13.917467+00	OK	11.7	1.82	17	0.194	4	365
1850	Montrose Beach	2026-04-13 14:50:25.971781+00	OK	11.9	6.32	14.2	0.346	3	365
1851	Montrose Beach	2026-04-13 14:50:38.042778+00	OK	11.9	6.89	14.4	0.38	4	365
1852	Calumet Beach	2026-04-13 14:50:50.106482+00	OK	11.7	1.83	17	0.196	4	365
1853	Calumet Beach	2026-04-13 14:51:02.151782+00	OK	11.7	1.9	16.8	0.181	4	365
1854	Montrose Beach	2026-04-13 14:51:14.218114+00	OK	11.9	7.11	14.5	0.361	5	365
1855	Calumet Beach	2026-04-13 14:51:26.304988+00	OK	11.7	1.83	16.7	0.18	4	365
1856	Montrose Beach	2026-04-13 14:51:38.374468+00	OK	11.9	6.88	14.5	0.345	4	365
1857	Montrose Beach	2026-04-13 14:51:50.425194+00	OK	11.9	7.32	14.3	0.331	4	365
1858	Calumet Beach	2026-04-13 14:52:02.484008+00	OK	11.7	1.69	16.5	0.177	4	365
1859	Calumet Beach	2026-04-13 14:52:14.547642+00	OK	11.7	1.62	16.3	0.159	4	365
1860	Montrose Beach	2026-04-13 14:52:26.630434+00	OK	11.9	7.18	14.2	0.305	4	365
1861	Montrose Beach	2026-04-13 14:52:38.706675+00	OK	11.9	6.35	14.2	0.321	3	365
1862	Calumet Beach	2026-04-13 14:52:50.786978+00	OK	11.7	1.57	16.2	0.154	4	365
1863	Montrose Beach	2026-04-13 14:53:02.882047+00	OK	11.8	6.78	14.1	0.285	4	365
1864	Calumet Beach	2026-04-13 14:53:14.940757+00	OK	11.7	1.8	16.1	0.163	4	365
1865	Calumet Beach	2026-04-13 14:53:27.005986+00	OK	11.7	1.82	16.1	0.156	4	365
1866	Montrose Beach	2026-04-13 14:53:39.095834+00	OK	11.8	6.27	14.1	0.306	3	365
1867	Montrose Beach	2026-04-13 14:53:51.178963+00	OK	11.8	5.63	14	0.282	3	365
1868	Calumet Beach	2026-04-13 14:54:03.243114+00	OK	11.7	1.73	15.9	0.158	3	365
1869	Calumet Beach	2026-04-13 14:54:15.286881+00	OK	11.7	1.73	15.9	0.151	3	365
1870	Montrose Beach	2026-04-13 14:54:27.362537+00	OK	11.8	5.05	13.8	0.248	4	365
1871	Montrose Beach	2026-04-13 14:54:39.413556+00	OK	11.8	5.73	13.8	0.235	4	365
1872	Calumet Beach	2026-04-13 14:54:51.442053+00	OK	11.7	1.74	15.9	0.148	4	365
1873	Calumet Beach	2026-04-13 14:55:03.479938+00	OK	11.7	1.77	15.8	0.146	4	365
1874	Montrose Beach	2026-04-13 14:55:15.55097+00	OK	11.8	5.57	13.9	0.244	4	365
1875	Calumet Beach	2026-04-13 14:55:27.596723+00	OK	11.7	1.64	15.9	0.125	4	365
1876	Montrose Beach	2026-04-13 14:55:39.659232+00	OK	11.8	6.49	13.9	0.292	3	365
1877	Calumet Beach	2026-04-13 14:55:51.719717+00	OK	11.7	1.75	16	0.129	4	365
1878	Montrose Beach	2026-04-13 14:56:03.767158+00	OK	11.8	5.67	14.1	0.277	2	365
1879	Calumet Beach	2026-04-13 14:56:15.81967+00	OK	11.7	1.59	16.2	0.141	4	365
1880	Montrose Beach	2026-04-13 14:56:27.896757+00	OK	11.8	6.4	14.3	0.286	5	365
1881	Montrose Beach	2026-04-13 14:56:39.966372+00	OK	11.8	6.19	14.6	0.301	3	365
1882	Calumet Beach	2026-04-13 14:56:52.018236+00	OK	11.7	1.55	16.4	0.144	4	365
1883	Montrose Beach	2026-04-13 14:57:04.07438+00	OK	11.8	6.28	14.8	0.282	5	365
1884	Calumet Beach	2026-04-13 14:57:16.156498+00	OK	11.7	1.58	16.6	0.154	2	365
1885	Calumet Beach	2026-04-13 14:57:28.231408+00	OK	11.7	1.44	16.7	0.159	5	365
1886	Montrose Beach	2026-04-13 14:57:40.298798+00	OK	11.8	6.36	14.9	0.319	3	365
1887	Montrose Beach	2026-04-13 14:57:52.366656+00	OK	11.8	5.98	15.1	0.296	3	365
1888	Calumet Beach	2026-04-13 14:58:04.447805+00	OK	11.7	1.4	16.9	0.164	4	365
1889	Calumet Beach	2026-04-13 14:58:16.488811+00	OK	11.7	1.35	16.9	0.17	4	365
1890	Montrose Beach	2026-04-13 14:58:28.530468+00	OK	11.8	6.26	15.2	0.313	3	365
2149	test-sensor	2026-04-21 12:00:00+00	OK	\N	\N	15	\N	\N	365
1891	Montrose Beach	2026-04-13 14:58:40.576865+00	OK	11.8	7.06	15.5	0.288	3	365
1892	Calumet Beach	2026-04-13 14:58:52.649761+00	OK	11.7	1.45	16.8	0.168	3	365
1893	Montrose Beach	2026-04-13 14:59:04.717412+00	OK	11.8	6.51	15.3	0.298	3	365
1894	Calumet Beach	2026-04-13 14:59:16.753778+00	OK	11.7	1.35	16.9	0.179	3	365
1895	Calumet Beach	2026-04-13 14:59:28.808048+00	OK	11.7	1.39	16.8	0.175	3	365
1896	Montrose Beach	2026-04-13 14:59:40.872606+00	OK	11.8	6.71	15.5	0.287	3	365
1897	Calumet Beach	2026-04-13 14:59:52.943922+00	OK	11.7	1.46	16.7	0.182	4	365
1898	Montrose Beach	2026-04-13 15:00:05.023993+00	OK	11.8	6.17	15.3	0.298	3	365
1899	Montrose Beach	2026-04-13 15:00:17.091444+00	OK	11.8	5.9	15.4	0.286	3	365
1900	Calumet Beach	2026-04-13 15:00:29.131989+00	OK	11.7	1.4	16.8	0.189	3	365
1901	Montrose Beach	2026-04-13 15:00:41.178225+00	OK	11.8	6.03	15.2	0.266	3	365
1902	Calumet Beach	2026-04-13 15:00:53.251192+00	OK	11.7	1.51	16.9	0.177	4	365
1903	Montrose Beach	2026-04-13 15:01:05.323476+00	OK	11.8	5.71	15.2	0.262	3	365
1904	Calumet Beach	2026-04-13 15:01:17.376743+00	OK	11.7	1.55	16.8	0.194	3	365
1905	Calumet Beach	2026-04-13 15:01:29.451152+00	OK	11.7	1.79	16.6	0.21	4	365
1906	Montrose Beach	2026-04-13 15:01:41.534844+00	OK	11.8	6.09	15.2	0.234	3	365
1907	Montrose Beach	2026-04-13 15:01:53.610001+00	OK	11.8	5.98	15	0.26	3	365
1908	Calumet Beach	2026-04-13 15:02:05.695364+00	OK	11.7	1.74	16.4	0.176	4	365
1909	Calumet Beach	2026-04-13 15:02:17.769878+00	OK	11.7	1.53	16.4	0.193	4	365
1910	Montrose Beach	2026-04-13 15:02:29.830937+00	OK	11.8	5.92	15	0.26	3	365
1911	Montrose Beach	2026-04-13 15:02:41.903057+00	OK	11.8	6.51	14.9	0.261	3	365
1912	Calumet Beach	2026-04-13 15:02:53.992015+00	OK	11.7	1.72	16.3	0.176	4	365
1913	Calumet Beach	2026-04-13 15:03:06.043369+00	OK	11.7	1.77	16.2	0.168	3	365
1914	Montrose Beach	2026-04-13 15:03:18.121036+00	OK	11.8	5.35	14.8	0.266	4	365
1915	Montrose Beach	2026-04-13 15:03:30.169837+00	OK	11.8	5.66	14.8	0.253	4	365
1916	Calumet Beach	2026-04-13 15:03:42.247412+00	OK	11.7	1.6	16.2	0.152	3	365
1917	Calumet Beach	2026-04-13 15:03:54.328312+00	OK	11.7	1.53	16.1	0.144	3	365
1918	Montrose Beach	2026-04-13 15:04:06.397003+00	OK	11.8	5.53	14.7	0.219	3	365
1919	Montrose Beach	2026-04-13 15:04:18.445777+00	OK	11.8	5.53	14.7	0.22	4	365
1920	Calumet Beach	2026-04-13 15:04:30.552104+00	OK	11.7	1.71	16.1	0.132	3	365
1921	Montrose Beach	2026-04-13 15:04:44.181306+00	OK	11.8	5.58	14.8	0.228	3	365
1922	Calumet Beach	2026-04-13 15:04:56.428232+00	OK	11.7	1.68	16.2	0.127	3	365
1923	Montrose Beach	2026-04-13 15:05:08.505329+00	OK	11.8	5.36	15	0.223	3	365
1924	Calumet Beach	2026-04-13 15:05:20.568817+00	OK	11.6	1.59	16.3	0.108	3	365
1925	Montrose Beach	2026-04-13 15:05:32.629673+00	OK	11.8	5.03	15.2	0.198	3	365
1926	Calumet Beach	2026-04-13 15:05:44.694654+00	OK	11.6	1.52	16.6	0.111	3	365
1927	Montrose Beach	2026-04-13 15:05:56.76556+00	OK	11.8	5.28	15.5	0.202	3	365
1928	Calumet Beach	2026-04-13 15:33:13.435289+00	OK	11.6	1.45	16.8	0.107	3	365
1929	Calumet Beach	2026-04-13 15:33:25.543789+00	OK	11.6	1.46	17.2	0.116	3	365
1930	Montrose Beach	2026-04-13 15:33:37.617224+00	OK	11.8	5.04	15.8	0.193	3	365
1931	Calumet Beach	2026-04-13 15:33:49.667819+00	OK	11.6	1.52	17.4	0.108	3	365
1932	Montrose Beach	2026-04-13 15:34:01.736665+00	OK	11.8	4.71	16.1	0.199	3	365
1933	Calumet Beach	2026-04-13 15:34:13.796393+00	OK	11.6	1.58	17.5	0.115	3	365
1934	Montrose Beach	2026-04-13 15:34:25.878168+00	OK	11.8	4.43	16.4	0.226	2	365
1935	Calumet Beach	2026-04-13 15:34:37.970277+00	OK	11.6	1.52	17.8	0.14	2	365
1936	Montrose Beach	2026-04-13 15:34:50.038344+00	OK	11.8	4.62	16.7	0.196	2	365
1937	Calumet Beach	2026-04-13 15:35:02.098043+00	OK	11.6	1.48	17.7	0.129	3	365
1938	Montrose Beach	2026-04-13 15:35:14.170279+00	OK	11.8	4.41	16.8	0.229	2	365
1939	Montrose Beach	2026-04-13 15:35:26.226949+00	OK	11.8	4.31	16.8	0.23	3	365
1940	Calumet Beach	2026-04-13 15:35:38.275054+00	OK	11.6	1.42	17.6	0.141	2	365
1941	Montrose Beach	2026-04-13 15:35:50.343927+00	OK	11.8	4.16	16.7	0.219	2	365
1942	Calumet Beach	2026-04-13 15:36:02.409934+00	OK	11.6	1.43	17.7	0.141	3	365
1943	Montrose Beach	2026-04-13 15:36:14.546969+00	OK	11.8	4.4	16.8	0.201	2	365
1944	Calumet Beach	2026-04-13 15:36:26.587035+00	OK	11.6	1.39	17.7	0.147	2	365
1945	Calumet Beach	2026-04-13 15:36:38.643286+00	OK	11.6	1.44	17.6	0.163	3	365
1946	Montrose Beach	2026-04-13 15:36:50.690347+00	OK	11.8	4.05	16.7	0.201	2	365
1947	Calumet Beach	2026-04-13 15:37:02.758827+00	OK	11.6	1.41	17.8	0.157	3	365
1948	Montrose Beach	2026-04-13 15:37:14.841342+00	OK	11.8	4.17	16.7	0.178	2	365
1949	Montrose Beach	2026-04-13 15:37:26.901907+00	OK	11.8	3.83	16.5	0.16	2	365
1950	Calumet Beach	2026-04-13 15:37:38.948525+00	OK	11.6	1.45	17.8	0.144	3	365
1951	Montrose Beach	2026-04-13 15:37:51.027142+00	OK	11.8	3.94	16.5	0.182	3	365
1952	Calumet Beach	2026-04-13 15:38:03.078763+00	OK	11.6	1.44	17.6	0.155	3	365
1953	Montrose Beach	2026-04-13 15:38:15.192383+00	OK	11.8	3.63	16.5	0.168	2	365
1954	Calumet Beach	2026-04-13 15:38:27.248047+00	OK	11.6	1.58	17.2	0.144	3	365
1955	Montrose Beach	2026-04-13 15:38:39.314202+00	OK	11.8	3.68	16.4	0.152	2	365
1956	Calumet Beach	2026-04-13 15:38:51.351883+00	OK	11.6	1.43	17.1	0.132	3	365
1957	Montrose Beach	2026-04-13 15:39:03.40806+00	OK	11.8	3.56	16.3	0.144	3	365
1958	Calumet Beach	2026-04-13 15:39:15.447428+00	OK	11.6	1.44	17	0.137	3	365
1959	Calumet Beach	2026-04-13 15:39:27.52443+00	OK	11.6	1.5	16.8	0.136	3	365
1960	Montrose Beach	2026-04-13 15:39:39.559961+00	OK	11.8	3.38	16.2	0.147	3	365
1961	Montrose Beach	2026-04-13 15:39:51.609376+00	OK	11.8	3.08	16	0.166	3	365
1962	Calumet Beach	2026-04-13 15:40:03.646939+00	OK	11.6	1.71	16.8	0.133	4	365
1963	Calumet Beach	2026-04-13 15:40:15.733899+00	OK	11.6	1.58	16.7	0.134	3	365
1964	Montrose Beach	2026-04-13 15:40:27.779053+00	OK	11.8	3	16	0.161	2	365
1965	Montrose Beach	2026-04-13 15:40:39.830281+00	OK	11.8	3.11	15.9	0.163	3	365
1966	Calumet Beach	2026-04-13 15:40:51.90073+00	OK	11.6	2.2	17	0.127	3	365
1967	Calumet Beach	2026-04-13 15:41:03.948037+00	OK	11.6	1.68	16.8	0.118	3	365
1968	Montrose Beach	2026-04-13 15:41:16.013271+00	OK	11.8	3.16	16	0.147	3	365
1969	Calumet Beach	2026-04-13 15:41:28.091226+00	OK	11.6	1.7	17	0.113	3	365
1970	Montrose Beach	2026-04-13 15:41:40.141811+00	OK	11.8	3.18	16	0.138	3	365
1971	Calumet Beach	2026-04-13 15:41:52.200608+00	OK	11.6	1.62	17.1	0.1	3	365
1972	Montrose Beach	2026-04-13 15:42:04.301354+00	OK	11.8	3.07	16.2	0.145	3	365
1973	Montrose Beach	2026-04-13 15:42:16.407044+00	OK	11.8	2.88	16.5	0.144	3	365
1974	Calumet Beach	2026-04-13 15:42:28.508376+00	OK	11.6	1.66	17.4	0.097	3	365
1975	Montrose Beach	2026-04-13 15:42:40.586704+00	OK	11.8	2.91	16.8	0.158	4	365
1976	Calumet Beach	2026-04-13 15:42:52.647859+00	OK	11.6	1.76	17.8	0.096	3	365
1977	Montrose Beach	2026-04-13 15:43:04.690963+00	OK	11.8	2.49	17.3	0.131	2	365
1978	Calumet Beach	2026-04-13 15:43:16.765487+00	OK	11.6	1.31	18	0.109	2	365
1979	Montrose Beach	2026-04-13 15:43:28.817984+00	OK	11.8	2.85	17.6	0.15	3	365
1980	Calumet Beach	2026-04-13 15:43:40.909404+00	OK	11.6	1.31	18.4	0.106	3	365
1981	Montrose Beach	2026-04-13 15:43:52.997836+00	OK	11.8	3.57	19.2	0.156	3	365
1982	Calumet Beach	2026-04-13 15:44:05.102494+00	OK	11.6	1.19	19.2	0.115	3	365
1983	Calumet Beach	2026-04-13 15:44:17.204211+00	OK	11.6	1.25	19.3	0.11	2	365
1984	Montrose Beach	2026-04-13 15:44:29.312619+00	OK	11.7	3.68	19.7	0.158	2	365
1985	Montrose Beach	2026-04-13 15:44:41.46318+00	OK	11.8	3.11	20.1	0.215	4	365
1986	Calumet Beach	2026-04-13 15:44:53.518095+00	OK	11.6	1.16	19.8	0.166	2	365
1987	Calumet Beach	2026-04-13 15:45:05.585042+00	OK	11.6	1.27	20.3	0.158	2	365
1988	Montrose Beach	2026-04-13 15:45:17.67433+00	OK	11.8	2.54	19.4	0.243	2	365
1989	Calumet Beach	2026-04-13 15:45:29.751906+00	OK	11.6	1.65	21	0.226	3	365
1990	Montrose Beach	2026-04-13 15:45:41.850331+00	OK	11.8	2.64	18.4	0.218	2	365
1991	Montrose Beach	2026-04-13 15:56:53.758923+00	OK	11.8	3.82	19.5	0.205	3	365
1992	Calumet Beach	2026-04-13 16:48:19.515662+00	OK	11.6	1.43	20.6	0.18	3	365
1993	Calumet Beach	2026-04-13 17:38:39.695988+00	OK	11.6	1.38	20.4	0.156	3	365
1994	Montrose Beach	2026-04-13 17:38:53.214715+00	OK	11.8	2.66	18.1	0.211	3	365
1995	Montrose Beach	2026-04-13 18:37:28.641673+00	OK	9.4	1.18	20.3	0.08	3	365
1996	Osterman Beach	2026-04-13 18:37:40.720917+00	OK	9.4	3.51	21.5	0.231	4	365
1997	Ohio Street Beach	2026-04-13 18:37:52.769048+00	OK	9.4	4.97	21.9	0.241	7	365
1998	Calumet Beach	2026-04-13 18:38:04.838835+00	OK	9.4	3.63	23.2	0.174	6	365
1999	63rd Street Beach	2026-04-13 18:38:16.900991+00	OK	11	7.56	18.9	0.14	4	365
2000	Rainbow Beach	2026-04-13 18:38:28.960776+00	OK	12.6	0.74	27.1	0.013	10	365
2001	Montrose Beach	2026-04-13 18:38:41.058971+00	OK	11.9	3.36	14.4	0.298	4	365
2002	Calumet Beach	2026-04-13 18:38:53.106394+00	OK	11.7	1.26	16.2	0.147	4	365
2003	Montrose Beach	2026-04-13 18:39:05.166873+00	OK	11.9	2.72	14.5	0.306	3	365
2004	Calumet Beach	2026-04-13 18:39:17.254+00	OK	11.7	1.28	16.3	0.162	4	365
2005	Montrose Beach	2026-04-13 18:41:20.611601+00	OK	9.4	1.18	20.3	0.08	3	365
2006	Osterman Beach	2026-04-13 18:41:32.708809+00	OK	9.4	3.51	21.5	0.231	4	365
2007	Ohio Street Beach	2026-04-13 18:41:44.775008+00	OK	9.4	4.97	21.9	0.241	7	365
2008	Calumet Beach	2026-04-13 18:41:56.822463+00	OK	9.4	3.63	23.2	0.174	6	365
2009	Montrose Beach	2026-04-13 18:49:47.510486+00	OK	9.4	1.18	20.3	0.08	3	365
2010	Osterman Beach	2026-04-13 18:49:59.626907+00	OK	9.4	3.51	21.5	0.231	4	365
2011	Ohio Street Beach	2026-04-13 18:50:11.674828+00	OK	9.4	4.97	21.9	0.241	7	365
2012	Calumet Beach	2026-04-13 18:50:23.720518+00	OK	9.4	3.63	23.2	0.174	6	365
2013	63rd Street Beach	2026-04-13 18:50:35.800781+00	OK	11	7.56	18.9	0.14	4	365
2014	Montrose Beach	2026-04-13 19:02:54.567074+00	OK	9.4	1.18	20.3	0.08	3	365
2015	Osterman Beach	2026-04-13 19:03:06.657645+00	OK	9.4	3.51	21.5	0.231	4	365
2016	Ohio Street Beach	2026-04-13 19:03:18.749676+00	OK	9.4	4.97	21.9	0.241	7	365
2017	Calumet Beach	2026-04-13 19:03:30.807623+00	OK	9.4	3.63	23.2	0.174	6	365
2018	63rd Street Beach	2026-04-13 19:03:42.881055+00	OK	11	7.56	18.9	0.14	4	365
2019	Rainbow Beach	2026-04-13 19:03:54.968023+00	OK	12.6	0.74	27.1	0.013	10	365
2020	Montrose Beach	2026-04-13 19:04:07.045855+00	OK	11.9	3.36	14.4	0.298	4	365
2021	Calumet Beach	2026-04-13 19:04:19.122528+00	OK	11.7	1.26	16.2	0.147	4	365
2022	Montrose Beach	2026-04-13 19:04:31.198731+00	OK	11.9	2.72	14.5	0.306	3	365
2023	Calumet Beach	2026-04-13 19:04:43.294192+00	OK	11.7	1.28	16.3	0.162	4	365
2024	Calumet Beach	2026-04-13 19:04:55.335881+00	OK	11.7	1.32	16.5	0.185	4	365
2025	Montrose Beach	2026-04-13 19:05:07.387789+00	OK	11.9	2.97	14.8	0.328	3	365
2026	env-sensor-01	2026-04-20 19:06:00+00	OK	92	2.3	21.4	0.8	5.2	365
2027	smoke-sensor-01	2026-04-20 19:09:00.900898+00	OK	90	1.9	19.8	0.5	4.4	365
2028	smoke-sensor-01	2026-04-20 19:13:51.82798+00	OK	90	1.9	19.8	0.5	4.4	365
2029	smoke-sensor-01	2026-04-20 19:17:39.323805+00	OK	90	1.9	19.8	0.5	4.4	365
2030	smoke-sensor-01	2026-04-20 19:23:30.378784+00	OK	90	1.9	19.8	0.5	4.4	365
2031	Montrose Beach	2026-04-21 08:00:06.816435+00	OK	9.4	1.18	20.3	0.08	3	365
2032	Osterman Beach	2026-04-21 08:00:18.898354+00	OK	9.4	3.51	21.5	0.231	4	365
2033	Ohio Street Beach	2026-04-21 08:00:30.952303+00	OK	9.4	4.97	21.9	0.241	7	365
2034	Calumet Beach	2026-04-21 08:00:42.999356+00	OK	9.4	3.63	23.2	0.174	6	365
2035	63rd Street Beach	2026-04-21 08:00:55.072446+00	OK	11	7.56	18.9	0.14	4	365
2036	Rainbow Beach	2026-04-21 08:01:07.12786+00	OK	12.6	0.74	27.1	0.013	10	365
2037	Montrose Beach	2026-04-21 08:01:19.175287+00	OK	11.9	3.36	14.4	0.298	4	365
2038	Calumet Beach	2026-04-21 08:01:31.242077+00	OK	11.7	1.26	16.2	0.147	4	365
2039	Montrose Beach	2026-04-21 08:01:43.301596+00	OK	11.9	2.72	14.5	0.306	3	365
2040	Calumet Beach	2026-04-21 08:01:55.353609+00	OK	11.7	1.28	16.3	0.162	4	365
2041	Calumet Beach	2026-04-21 08:02:07.438285+00	OK	11.7	1.32	16.5	0.185	4	365
2042	Montrose Beach	2026-04-21 08:02:19.533398+00	OK	11.9	2.97	14.8	0.328	3	365
2043	Montrose Beach	2026-04-21 08:02:31.586366+00	OK	11.9	4.3	14.5	0.328	3	365
2044	Calumet Beach	2026-04-21 08:02:43.613016+00	OK	11.7	1.31	16.8	0.196	4	365
2045	Calumet Beach	2026-04-21 08:02:55.650124+00	OK	11.7	1.37	17.1	0.194	4	365
2046	Montrose Beach	2026-04-21 08:03:07.749096+00	OK	11.9	4.87	14.4	0.341	3	365
2047	Calumet Beach	2026-04-21 08:03:19.834696+00	OK	11.7	1.48	17.2	0.203	4	365
2048	Montrose Beach	2026-04-21 08:03:31.923579+00	OK	11.9	5.06	14.1	0.34	4	365
2049	Calumet Beach	2026-04-21 08:03:44.003343+00	OK	11.7	1.8	17.1	0.188	4	365
2050	Montrose Beach	2026-04-21 08:03:56.036758+00	OK	11.9	5.76	14.2	0.356	3	365
2051	Calumet Beach	2026-04-21 08:04:08.131564+00	OK	11.7	1.82	17	0.194	4	365
2052	Montrose Beach	2026-04-21 08:04:20.214077+00	OK	11.9	6.32	14.2	0.346	3	365
2053	Montrose Beach	2026-04-21 08:04:32.252473+00	OK	11.9	6.89	14.4	0.38	4	365
2054	Calumet Beach	2026-04-21 08:04:44.287766+00	OK	11.7	1.83	17	0.196	4	365
2055	Calumet Beach	2026-04-21 08:04:56.324195+00	OK	11.7	1.9	16.8	0.181	4	365
2056	Montrose Beach	2026-04-21 08:05:08.434535+00	OK	11.9	7.11	14.5	0.361	5	365
2057	Calumet Beach	2026-04-21 08:05:20.505243+00	OK	11.7	1.83	16.7	0.18	4	365
2058	Montrose Beach	2026-04-21 08:05:32.559609+00	OK	11.9	6.88	14.5	0.345	4	365
2059	Montrose Beach	2026-04-21 08:05:44.583417+00	OK	11.9	7.32	14.3	0.331	4	365
2060	Calumet Beach	2026-04-21 08:05:56.665081+00	OK	11.7	1.69	16.5	0.177	4	365
2061	Calumet Beach	2026-04-21 08:06:08.737713+00	OK	11.7	1.62	16.3	0.159	4	365
2062	Montrose Beach	2026-04-21 08:06:20.801493+00	OK	11.9	7.18	14.2	0.305	4	365
2063	Montrose Beach	2026-04-21 08:06:32.881867+00	OK	11.9	6.35	14.2	0.321	3	365
2064	Calumet Beach	2026-04-21 08:06:44.927701+00	OK	11.7	1.57	16.2	0.154	4	365
2065	Montrose Beach	2026-04-21 08:06:56.980705+00	OK	11.8	6.78	14.1	0.285	4	365
2066	Calumet Beach	2026-04-21 08:07:09.024552+00	OK	11.7	1.8	16.1	0.163	4	365
2067	Calumet Beach	2026-04-21 08:07:21.081799+00	OK	11.7	1.82	16.1	0.156	4	365
2068	Montrose Beach	2026-04-21 08:07:33.154541+00	OK	11.8	6.27	14.1	0.306	3	365
2069	Montrose Beach	2026-04-21 08:07:45.18444+00	OK	11.8	5.63	14	0.282	3	365
2070	Calumet Beach	2026-04-21 08:07:57.236165+00	OK	11.7	1.73	15.9	0.158	3	365
2071	Calumet Beach	2026-04-21 08:08:09.376254+00	OK	11.7	1.73	15.9	0.151	3	365
2072	Montrose Beach	2026-04-21 08:08:21.420985+00	OK	11.8	5.05	13.8	0.248	4	365
2073	Montrose Beach	2026-04-21 08:08:33.48659+00	OK	11.8	5.73	13.8	0.235	4	365
2074	Calumet Beach	2026-04-21 08:08:45.557812+00	OK	11.7	1.74	15.9	0.148	4	365
2075	Calumet Beach	2026-04-21 08:08:57.611737+00	OK	11.7	1.77	15.8	0.146	4	365
2076	Montrose Beach	2026-04-21 08:09:09.674394+00	OK	11.8	5.57	13.9	0.244	4	365
2077	Calumet Beach	2026-04-21 08:09:21.717305+00	OK	11.7	1.64	15.9	0.125	4	365
2078	Montrose Beach	2026-04-21 08:09:33.750134+00	OK	11.8	6.49	13.9	0.292	3	365
2079	Calumet Beach	2026-04-21 08:09:45.796519+00	OK	11.7	1.75	16	0.129	4	365
2080	Montrose Beach	2026-04-21 08:09:57.858943+00	OK	11.8	5.67	14.1	0.277	2	365
2081	Calumet Beach	2026-04-21 08:10:09.912319+00	OK	11.7	1.59	16.2	0.141	4	365
2082	Montrose Beach	2026-04-21 08:10:21.967883+00	OK	11.8	6.4	14.3	0.286	5	365
2083	Montrose Beach	2026-04-21 08:10:34.031454+00	OK	11.8	6.19	14.6	0.301	3	365
2084	Calumet Beach	2026-04-21 08:10:46.056202+00	OK	11.7	1.55	16.4	0.144	4	365
2085	Montrose Beach	2026-04-21 08:10:58.11317+00	OK	11.8	6.28	14.8	0.282	5	365
2086	Calumet Beach	2026-04-21 08:11:10.16756+00	OK	11.7	1.58	16.6	0.154	2	365
2087	Calumet Beach	2026-04-21 08:11:22.216303+00	OK	11.7	1.44	16.7	0.159	5	365
2088	Montrose Beach	2026-04-21 08:11:34.260751+00	OK	11.8	6.36	14.9	0.319	3	365
2089	Montrose Beach	2026-04-21 08:11:46.310519+00	OK	11.8	5.98	15.1	0.296	3	365
2090	Calumet Beach	2026-04-21 08:11:58.362597+00	OK	11.7	1.4	16.9	0.164	4	365
2091	Calumet Beach	2026-04-21 08:12:10.422024+00	OK	11.7	1.35	16.9	0.17	4	365
2092	Montrose Beach	2026-04-21 08:12:22.484381+00	OK	11.8	6.26	15.2	0.313	3	365
2093	Montrose Beach	2026-04-21 08:12:34.560875+00	OK	11.8	7.06	15.5	0.288	3	365
2094	Calumet Beach	2026-04-21 08:12:46.616038+00	OK	11.7	1.45	16.8	0.168	3	365
2095	Montrose Beach	2026-04-21 08:12:58.66638+00	OK	11.8	6.51	15.3	0.298	3	365
2096	Calumet Beach	2026-04-21 08:13:10.735008+00	OK	11.7	1.35	16.9	0.179	3	365
2097	Calumet Beach	2026-04-21 08:13:22.789957+00	OK	11.7	1.39	16.8	0.175	3	365
2098	Montrose Beach	2026-04-21 08:13:34.836919+00	OK	11.8	6.71	15.5	0.287	3	365
2099	Calumet Beach	2026-04-21 08:13:46.90573+00	OK	11.7	1.46	16.7	0.182	4	365
2100	Montrose Beach	2026-04-21 08:13:58.972282+00	OK	11.8	6.17	15.3	0.298	3	365
2101	Montrose Beach	2026-04-21 08:14:11.044156+00	OK	11.8	5.9	15.4	0.286	3	365
2102	Calumet Beach	2026-04-21 08:14:23.080965+00	OK	11.7	1.4	16.8	0.189	3	365
2103	Montrose Beach	2026-04-21 08:14:35.132147+00	OK	11.8	6.03	15.2	0.266	3	365
2104	Calumet Beach	2026-04-21 08:14:47.170404+00	OK	11.7	1.51	16.9	0.177	4	365
2105	Montrose Beach	2026-04-21 08:14:59.205986+00	OK	11.8	5.71	15.2	0.262	3	365
2106	Calumet Beach	2026-04-21 08:15:11.233571+00	OK	11.7	1.55	16.8	0.194	3	365
2107	Calumet Beach	2026-04-21 08:15:23.310281+00	OK	11.7	1.79	16.6	0.21	4	365
2108	Montrose Beach	2026-04-21 08:15:35.344076+00	OK	11.8	6.09	15.2	0.234	3	365
2109	Montrose Beach	2026-04-21 08:15:47.376724+00	OK	11.8	5.98	15	0.26	3	365
2110	Calumet Beach	2026-04-21 08:15:59.429161+00	OK	11.7	1.74	16.4	0.176	4	365
2111	Calumet Beach	2026-04-21 08:16:11.490116+00	OK	11.7	1.53	16.4	0.193	4	365
2112	Montrose Beach	2026-04-21 08:16:23.544387+00	OK	11.8	5.92	15	0.26	3	365
2113	Montrose Beach	2026-04-21 08:16:35.612123+00	OK	11.8	6.51	14.9	0.261	3	365
2114	Calumet Beach	2026-04-21 08:16:47.664764+00	OK	11.7	1.72	16.3	0.176	4	365
2115	Calumet Beach	2026-04-21 08:16:59.715174+00	OK	11.7	1.77	16.2	0.168	3	365
2116	Montrose Beach	2026-04-21 08:17:11.753009+00	OK	11.8	5.35	14.8	0.266	4	365
2117	Montrose Beach	2026-04-21 08:17:23.802137+00	OK	11.8	5.66	14.8	0.253	4	365
2118	Calumet Beach	2026-04-21 08:17:35.861936+00	OK	11.7	1.6	16.2	0.152	3	365
2119	Calumet Beach	2026-04-21 08:17:47.912481+00	OK	11.7	1.53	16.1	0.144	3	365
2120	Montrose Beach	2026-04-21 08:17:59.962127+00	OK	11.8	5.53	14.7	0.219	3	365
2121	Montrose Beach	2026-04-21 08:18:11.997054+00	OK	11.8	5.53	14.7	0.22	4	365
2122	Calumet Beach	2026-04-21 08:18:24.032541+00	OK	11.7	1.71	16.1	0.132	3	365
2123	Montrose Beach	2026-04-21 08:18:36.074212+00	OK	11.8	5.58	14.8	0.228	3	365
2124	Calumet Beach	2026-04-21 08:18:48.124168+00	OK	11.7	1.68	16.2	0.127	3	365
2125	Montrose Beach	2026-04-21 08:19:00.17329+00	OK	11.8	5.36	15	0.223	3	365
2126	Calumet Beach	2026-04-21 08:19:12.250757+00	OK	11.6	1.59	16.3	0.108	3	365
2127	Montrose Beach	2026-04-21 08:19:24.285592+00	OK	11.8	5.03	15.2	0.198	3	365
2128	Calumet Beach	2026-04-21 08:19:36.346421+00	OK	11.6	1.52	16.6	0.111	3	365
2129	Montrose Beach	2026-04-21 08:19:48.39596+00	OK	11.8	5.28	15.5	0.202	3	365
2130	Calumet Beach	2026-04-21 08:20:00.464394+00	OK	11.6	1.45	16.8	0.107	3	365
2131	Calumet Beach	2026-04-21 08:32:12.968463+00	OK	11.6	1.46	17.2	0.116	3	365
2132	Montrose Beach	2026-04-21 08:32:25.034562+00	OK	11.8	5.04	15.8	0.193	3	365
2133	Calumet Beach	2026-04-21 08:32:37.092284+00	OK	11.6	1.52	17.4	0.108	3	365
2134	Montrose Beach	2026-04-21 08:32:49.164204+00	OK	11.8	4.71	16.1	0.199	3	365
2135	Calumet Beach	2026-04-21 08:33:01.215985+00	OK	11.6	1.58	17.5	0.115	3	365
2136	Montrose Beach	2026-04-21 08:33:13.258827+00	OK	11.8	4.43	16.4	0.226	2	365
2137	Calumet Beach	2026-04-21 08:33:25.342465+00	OK	11.6	1.52	17.8	0.14	2	365
2138	Montrose Beach	2026-04-21 08:33:37.408603+00	OK	11.8	4.62	16.7	0.196	2	365
2139	Calumet Beach	2026-04-21 08:33:49.44898+00	OK	11.6	1.48	17.7	0.129	3	365
2140	Montrose Beach	2026-04-21 08:34:01.531334+00	OK	11.8	4.41	16.8	0.229	2	365
2141	Montrose Beach	2026-04-21 08:34:13.575838+00	OK	11.8	4.31	16.8	0.23	3	365
2142	Calumet Beach	2026-04-21 08:34:25.646614+00	OK	11.6	1.42	17.6	0.141	2	365
2143	Montrose Beach	2026-04-21 08:34:37.716837+00	OK	11.8	4.16	16.7	0.219	2	365
2144	Calumet Beach	2026-04-21 08:34:49.756162+00	OK	11.6	1.43	17.7	0.141	3	365
2145	Montrose Beach	2026-04-21 08:35:01.8449+00	OK	11.8	4.4	16.8	0.201	2	365
2146	Calumet Beach	2026-04-21 08:35:13.919601+00	OK	11.6	1.39	17.7	0.147	2	365
2147	idempotency-test-sensor	2026-04-21 09:40:00+00	OK	99	1.2	12.3	0.1	2	365
2148	idempotency-test-sensor-2	2026-04-21 09:45:00+00	OK	99	1.2	12.3	0.1	2	365
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	3	add_permission
6	Can change permission	3	change_permission
7	Can delete permission	3	delete_permission
8	Can view permission	3	view_permission
9	Can add group	2	add_group
10	Can change group	2	change_group
11	Can delete group	2	delete_group
12	Can view group	2	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add sensor reading	9	add_sensorreading
26	Can change sensor reading	9	change_sensorreading
27	Can delete sensor reading	9	delete_sensorreading
28	Can view sensor reading	9	view_sensorreading
29	Can add alert rule	8	add_alertrule
30	Can change alert rule	8	change_alertrule
31	Can delete alert rule	8	delete_alertrule
32	Can view alert rule	8	view_alertrule
33	Can add alert event	7	add_alertevent
34	Can change alert event	7	change_alertevent
35	Can delete alert event	7	delete_alertevent
36	Can view alert event	7	view_alertevent
37	Can add incident report	11	add_incidentreport
38	Can change incident report	11	change_incidentreport
39	Can delete incident report	11	delete_incidentreport
40	Can view incident report	11	view_incidentreport
41	Can add incident audit log	10	add_incidentauditlog
42	Can change incident audit log	10	change_incidentauditlog
43	Can delete incident audit log	10	delete_incidentauditlog
44	Can view incident audit log	10	view_incidentauditlog
45	Can add security audit event	12	add_securityauditevent
46	Can change security audit event	12	change_securityauditevent
47	Can delete security audit event	12	delete_securityauditevent
48	Can view security audit event	12	view_securityauditevent
49	Can add mfa key	13	add_mfakey
50	Can change mfa key	13	change_mfakey
51	Can delete mfa key	13	delete_mfakey
52	Can view mfa key	13	view_mfakey
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$1200000$BgQxR4k1aaH5K6VFCsGCSk$srOqGKVQNamQs/Gw/K9z4H1VofckKCJtdm4H/gvzQOM=	\N	t	admin			komlan.m@mail.com	t	t	2026-04-13 08:33:53.902058+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: dashboard_incidentauditlog; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.dashboard_incidentauditlog (id, action, from_status, to_status, comment, created_at, actor_id, from_assigned_to_id, incident_id, to_assigned_to_id) FROM stdin;
\.


--
-- Data for Name: dashboard_incidentreport; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.dashboard_incidentreport (id, title, beach_name, description, status, created_at, updated_at, created_by_id, assigned_to_id, closed_at, closed_comment) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	group
3	auth	permission
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	api	alertevent
8	api	alertrule
9	api	sensorreading
10	dashboard	incidentauditlog
11	dashboard	incidentreport
12	api	securityauditevent
13	mfa	mfakey
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-04-12 11:13:56.03658+00
2	auth	0001_initial	2026-04-12 11:13:56.13389+00
3	admin	0001_initial	2026-04-12 11:13:56.161474+00
4	admin	0002_logentry_remove_auto_add	2026-04-12 11:13:56.168841+00
5	admin	0003_logentry_add_action_flag_choices	2026-04-12 11:13:56.177447+00
6	api	0001_initial	2026-04-12 11:13:56.194834+00
7	api	0002_alter_sensorreading_options_and_more	2026-04-12 11:13:56.220832+00
8	api	0003_alertrule_alertevent	2026-04-12 11:13:56.276199+00
9	contenttypes	0002_remove_content_type_name	2026-04-12 11:13:56.294596+00
10	auth	0002_alter_permission_name_max_length	2026-04-12 11:13:56.307309+00
11	auth	0003_alter_user_email_max_length	2026-04-12 11:13:56.317701+00
12	auth	0004_alter_user_username_opts	2026-04-12 11:13:56.328325+00
13	auth	0005_alter_user_last_login_null	2026-04-12 11:13:56.340353+00
14	auth	0006_require_contenttypes_0002	2026-04-12 11:13:56.343015+00
15	auth	0007_alter_validators_add_error_messages	2026-04-12 11:13:56.383983+00
16	auth	0008_alter_user_username_max_length	2026-04-12 11:13:56.400788+00
17	auth	0009_alter_user_last_name_max_length	2026-04-12 11:13:56.410935+00
18	auth	0010_alter_group_name_max_length	2026-04-12 11:13:56.424302+00
19	auth	0011_update_proxy_permissions	2026-04-12 11:13:56.433755+00
20	auth	0012_alter_user_first_name_max_length	2026-04-12 11:13:56.444335+00
21	dashboard	0001_initial	2026-04-12 11:13:56.472487+00
22	dashboard	0002_incidentreport_assigned_to_incidentreport_closed_at_and_more	2026-04-12 11:13:56.546104+00
23	sessions	0001_initial	2026-04-12 11:13:56.561524+00
24	api	0004_securityauditevent	2026-04-20 19:23:55.58473+00
25	api	0005_sensorreading_unique_together	2026-04-21 09:45:50.010603+00
26	api	0006_sensorreading_indexes	2026-04-21 09:57:53.086037+00
27	api	0007_sensorreading_retention_days	2026-04-21 11:23:29.780268+00
28	mfa	0001_initial	2026-04-21 11:23:30.099075+00
29	mfa	0002_mfakey_last_code	2026-04-21 11:23:30.159741+00
30	mfa	0003_alter_mfakey_method	2026-04-21 11:23:30.211481+00
31	mfa	0004_alter_mfakey_id	2026-04-21 11:23:30.371657+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: mfa_mfakey; Type: TABLE DATA; Schema: public; Owner: smartenv
--

COPY public.mfa_mfakey (id, method, name, secret, user_id, last_code) FROM stdin;
\.


--
-- Name: api_alertevent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.api_alertevent_id_seq', 1, false);


--
-- Name: api_alertrule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.api_alertrule_id_seq', 1, false);


--
-- Name: api_securityauditevent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.api_securityauditevent_id_seq', 1, false);


--
-- Name: api_sensorreading_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.api_sensorreading_id_seq', 2149, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 52, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: dashboard_incidentauditlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.dashboard_incidentauditlog_id_seq', 1, false);


--
-- Name: dashboard_incidentreport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.dashboard_incidentreport_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 13, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 31, true);


--
-- Name: mfa_mfakey_id_seq; Type: SEQUENCE SET; Schema: public; Owner: smartenv
--

SELECT pg_catalog.setval('public.mfa_mfakey_id_seq', 1, false);


--
-- Name: api_alertevent api_alertevent_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.api_alertevent
    ADD CONSTRAINT api_alertevent_pkey PRIMARY KEY (id);


--
-- Name: api_alertrule api_alertrule_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.api_alertrule
    ADD CONSTRAINT api_alertrule_pkey PRIMARY KEY (id);


--
-- Name: api_securityauditevent api_securityauditevent_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.api_securityauditevent
    ADD CONSTRAINT api_securityauditevent_pkey PRIMARY KEY (id);


--
-- Name: api_sensorreading api_sensorreading_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.api_sensorreading
    ADD CONSTRAINT api_sensorreading_pkey PRIMARY KEY (id);


--
-- Name: api_sensorreading api_sensorreading_sensor_id_timestamp_3bd478e5_uniq; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.api_sensorreading
    ADD CONSTRAINT api_sensorreading_sensor_id_timestamp_3bd478e5_uniq UNIQUE (sensor_id, "timestamp");


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: dashboard_incidentauditlog dashboard_incidentauditlog_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.dashboard_incidentauditlog
    ADD CONSTRAINT dashboard_incidentauditlog_pkey PRIMARY KEY (id);


--
-- Name: dashboard_incidentreport dashboard_incidentreport_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.dashboard_incidentreport
    ADD CONSTRAINT dashboard_incidentreport_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: mfa_mfakey mfa_mfakey_pkey; Type: CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.mfa_mfakey
    ADD CONSTRAINT mfa_mfakey_pkey PRIMARY KEY (id);


--
-- Name: api_alertevent_reading_id_8afe6803; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX api_alertevent_reading_id_8afe6803 ON public.api_alertevent USING btree (reading_id);


--
-- Name: api_alertevent_rule_id_378d3d20; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX api_alertevent_rule_id_378d3d20 ON public.api_alertevent USING btree (rule_id);


--
-- Name: api_alertrule_recipient_user_id_17a04008; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX api_alertrule_recipient_user_id_17a04008 ON public.api_alertrule USING btree (recipient_user_id);


--
-- Name: api_securityauditevent_actor_id_b9437454; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX api_securityauditevent_actor_id_b9437454 ON public.api_securityauditevent USING btree (actor_id);


--
-- Name: api_securityauditevent_created_at_b5bff9e8; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX api_securityauditevent_created_at_b5bff9e8 ON public.api_securityauditevent USING btree (created_at);


--
-- Name: api_securityauditevent_event_type_07657f79; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX api_securityauditevent_event_type_07657f79 ON public.api_securityauditevent USING btree (event_type);


--
-- Name: api_securityauditevent_event_type_07657f79_like; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX api_securityauditevent_event_type_07657f79_like ON public.api_securityauditevent USING btree (event_type varchar_pattern_ops);


--
-- Name: api_sensorr_sensor__9238f9_idx; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX api_sensorr_sensor__9238f9_idx ON public.api_sensorreading USING btree (sensor_id, "timestamp");


--
-- Name: api_sensorr_timesta_7d4e8f_idx; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX api_sensorr_timesta_7d4e8f_idx ON public.api_sensorreading USING btree ("timestamp");


--
-- Name: api_sensorreading_timestamp_5624486f; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX api_sensorreading_timestamp_5624486f ON public.api_sensorreading USING btree ("timestamp");


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: dashboard_incidentauditlog_actor_id_157d053a; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX dashboard_incidentauditlog_actor_id_157d053a ON public.dashboard_incidentauditlog USING btree (actor_id);


--
-- Name: dashboard_incidentauditlog_from_assigned_to_id_9eeb2e68; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX dashboard_incidentauditlog_from_assigned_to_id_9eeb2e68 ON public.dashboard_incidentauditlog USING btree (from_assigned_to_id);


--
-- Name: dashboard_incidentauditlog_incident_id_37cc59d2; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX dashboard_incidentauditlog_incident_id_37cc59d2 ON public.dashboard_incidentauditlog USING btree (incident_id);


--
-- Name: dashboard_incidentauditlog_to_assigned_to_id_41a14441; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX dashboard_incidentauditlog_to_assigned_to_id_41a14441 ON public.dashboard_incidentauditlog USING btree (to_assigned_to_id);


--
-- Name: dashboard_incidentreport_assigned_to_id_79f5ecda; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX dashboard_incidentreport_assigned_to_id_79f5ecda ON public.dashboard_incidentreport USING btree (assigned_to_id);


--
-- Name: dashboard_incidentreport_created_by_id_b04d4f74; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX dashboard_incidentreport_created_by_id_b04d4f74 ON public.dashboard_incidentreport USING btree (created_by_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: mfa_mfakey_user_id_6b721525; Type: INDEX; Schema: public; Owner: smartenv
--

CREATE INDEX mfa_mfakey_user_id_6b721525 ON public.mfa_mfakey USING btree (user_id);


--
-- Name: api_alertevent api_alertevent_reading_id_8afe6803_fk_api_sensorreading_id; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.api_alertevent
    ADD CONSTRAINT api_alertevent_reading_id_8afe6803_fk_api_sensorreading_id FOREIGN KEY (reading_id) REFERENCES public.api_sensorreading(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_alertevent api_alertevent_rule_id_378d3d20_fk_api_alertrule_id; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.api_alertevent
    ADD CONSTRAINT api_alertevent_rule_id_378d3d20_fk_api_alertrule_id FOREIGN KEY (rule_id) REFERENCES public.api_alertrule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_alertrule api_alertrule_recipient_user_id_17a04008_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.api_alertrule
    ADD CONSTRAINT api_alertrule_recipient_user_id_17a04008_fk_auth_user_id FOREIGN KEY (recipient_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_securityauditevent api_securityauditevent_actor_id_b9437454_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.api_securityauditevent
    ADD CONSTRAINT api_securityauditevent_actor_id_b9437454_fk_auth_user_id FOREIGN KEY (actor_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_incidentauditlog dashboard_incidentau_from_assigned_to_id_9eeb2e68_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.dashboard_incidentauditlog
    ADD CONSTRAINT dashboard_incidentau_from_assigned_to_id_9eeb2e68_fk_auth_user FOREIGN KEY (from_assigned_to_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_incidentauditlog dashboard_incidentau_incident_id_37cc59d2_fk_dashboard; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.dashboard_incidentauditlog
    ADD CONSTRAINT dashboard_incidentau_incident_id_37cc59d2_fk_dashboard FOREIGN KEY (incident_id) REFERENCES public.dashboard_incidentreport(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_incidentauditlog dashboard_incidentau_to_assigned_to_id_41a14441_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.dashboard_incidentauditlog
    ADD CONSTRAINT dashboard_incidentau_to_assigned_to_id_41a14441_fk_auth_user FOREIGN KEY (to_assigned_to_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_incidentauditlog dashboard_incidentauditlog_actor_id_157d053a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.dashboard_incidentauditlog
    ADD CONSTRAINT dashboard_incidentauditlog_actor_id_157d053a_fk_auth_user_id FOREIGN KEY (actor_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_incidentreport dashboard_incidentre_assigned_to_id_79f5ecda_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.dashboard_incidentreport
    ADD CONSTRAINT dashboard_incidentre_assigned_to_id_79f5ecda_fk_auth_user FOREIGN KEY (assigned_to_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dashboard_incidentreport dashboard_incidentreport_created_by_id_b04d4f74_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.dashboard_incidentreport
    ADD CONSTRAINT dashboard_incidentreport_created_by_id_b04d4f74_fk_auth_user_id FOREIGN KEY (created_by_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: mfa_mfakey mfa_mfakey_user_id_6b721525_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: smartenv
--

ALTER TABLE ONLY public.mfa_mfakey
    ADD CONSTRAINT mfa_mfakey_user_id_6b721525_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict lAFrOr5xaaklMpovcOHqcFf5IfwT5VZojiYiZlJhuYBgXCl20nHcixDccorVVJy


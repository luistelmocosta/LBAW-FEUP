--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: User; Type: TABLE; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE TABLE "User" (
    userid integer NOT NULL,
    username character varying(100) NOT NULL,
    fullname character varying(250) NOT NULL,
    location character varying(50),
    password character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    website character varying(150),
    about character varying(300),
    signdate date,
    lastlogin timestamp without time zone
);


ALTER TABLE public."User" OWNER TO luiscosta;

--
-- Name: User_userid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE "User_userid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_userid_seq" OWNER TO luiscosta;

--
-- Name: User_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE "User_userid_seq" OWNED BY "User".userid;


--
-- Name: userid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY "User" ALTER COLUMN userid SET DEFAULT nextval('"User_userid_seq"'::regclass);


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY "User" (userid, username, fullname, location, password, email, website, about, signdate, lastlogin) FROM stdin;
1	admin	Admin LBAW	FEUP	123	admin@admin.pt	www.fe.up.pt	Just an admin!	2017-03-17	2017-03-16 09:51:42.606
\.


--
-- Name: User_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('"User_userid_seq"', 1, true);


--
-- Name: User_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta; Tablespace: 
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (userid);


--
-- Name: User_userid_uindex; Type: INDEX; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE UNIQUE INDEX "User_userid_uindex" ON "User" USING btree (userid);


--
-- Name: User_username_uindex; Type: INDEX; Schema: public; Owner: luiscosta; Tablespace: 
--

CREATE UNIQUE INDEX "User_username_uindex" ON "User" USING btree (username);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


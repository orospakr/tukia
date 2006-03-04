--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'Standard public schema';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: committees; Type: TABLE; Schema: public; Owner: tukia; Tablespace: 
--

CREATE TABLE committees (
    id serial NOT NULL,
    name character varying(255),
    parent_id integer
);


--
-- Name: globalize_countries; Type: TABLE; Schema: public; Owner: tukia; Tablespace: 
--

CREATE TABLE globalize_countries (
    id serial NOT NULL,
    code character varying(2),
    english_name character varying(255),
    date_format character varying(255),
    currency_format character varying(255),
    currency_code character varying(3),
    thousands_sep character varying(2),
    decimal_sep character varying(2),
    currency_decimal_sep character varying(2),
    number_grouping_scheme character varying(255)
);


--
-- Name: globalize_languages; Type: TABLE; Schema: public; Owner: tukia; Tablespace: 
--

CREATE TABLE globalize_languages (
    id serial NOT NULL,
    iso_639_1 character varying(2),
    iso_639_2 character varying(3),
    iso_639_3 character varying(3),
    rfc_3066 character varying(255),
    english_name character varying(255),
    english_name_locale character varying(255),
    english_name_modifier character varying(255),
    native_name character varying(255),
    native_name_locale character varying(255),
    native_name_modifier character varying(255),
    macro_language boolean,
    direction character varying(255),
    pluralization character varying(255),
    scope character varying(1)
);


--
-- Name: globalize_translations; Type: TABLE; Schema: public; Owner: tukia; Tablespace: 
--

CREATE TABLE globalize_translations (
    id serial NOT NULL,
    "type" character varying(255),
    tr_key character varying(255),
    table_name character varying(255),
    item_id integer,
    facet character varying(255),
    language_id integer,
    pluralization_index integer,
    text text
);


--
-- Name: nations; Type: TABLE; Schema: public; Owner: tukia; Tablespace: 
--

CREATE TABLE nations (
    id serial NOT NULL,
    code character varying(255),
    name character varying(255)
);


--
-- Name: people; Type: TABLE; Schema: public; Owner: tukia; Tablespace: 
--

CREATE TABLE people (
    id serial NOT NULL,
    name character varying(255),
    "password" character varying(255),
    givenname character varying(255),
    surname character varying(255),
    email character varying(255),
    url character varying(255),
    phone character varying(255),
    organisation character varying(255),
    enabled boolean,
    "admin" boolean,
    created date,
    lastlogin date
);


--
-- Name: schema_info; Type: TABLE; Schema: public; Owner: tukia; Tablespace: 
--

CREATE TABLE schema_info (
    version integer
);


--
-- Name: committees_pkey; Type: CONSTRAINT; Schema: public; Owner: tukia; Tablespace: 
--

ALTER TABLE ONLY committees
    ADD CONSTRAINT committees_pkey PRIMARY KEY (id);


--
-- Name: globalize_countries_pkey; Type: CONSTRAINT; Schema: public; Owner: tukia; Tablespace: 
--

ALTER TABLE ONLY globalize_countries
    ADD CONSTRAINT globalize_countries_pkey PRIMARY KEY (id);


--
-- Name: globalize_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: tukia; Tablespace: 
--

ALTER TABLE ONLY globalize_languages
    ADD CONSTRAINT globalize_languages_pkey PRIMARY KEY (id);


--
-- Name: globalize_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: tukia; Tablespace: 
--

ALTER TABLE ONLY globalize_translations
    ADD CONSTRAINT globalize_translations_pkey PRIMARY KEY (id);


--
-- Name: nations_pkey; Type: CONSTRAINT; Schema: public; Owner: tukia; Tablespace: 
--

ALTER TABLE ONLY nations
    ADD CONSTRAINT nations_pkey PRIMARY KEY (id);


--
-- Name: people_pkey; Type: CONSTRAINT; Schema: public; Owner: tukia; Tablespace: 
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: globalize_countries_code_index; Type: INDEX; Schema: public; Owner: tukia; Tablespace: 
--

CREATE INDEX globalize_countries_code_index ON globalize_countries USING btree (code);


--
-- Name: globalize_languages_iso_639_1_index; Type: INDEX; Schema: public; Owner: tukia; Tablespace: 
--

CREATE INDEX globalize_languages_iso_639_1_index ON globalize_languages USING btree (iso_639_1);


--
-- Name: globalize_languages_iso_639_2_index; Type: INDEX; Schema: public; Owner: tukia; Tablespace: 
--

CREATE INDEX globalize_languages_iso_639_2_index ON globalize_languages USING btree (iso_639_2);


--
-- Name: globalize_languages_iso_639_3_index; Type: INDEX; Schema: public; Owner: tukia; Tablespace: 
--

CREATE INDEX globalize_languages_iso_639_3_index ON globalize_languages USING btree (iso_639_3);


--
-- Name: globalize_languages_rfc_3066_index; Type: INDEX; Schema: public; Owner: tukia; Tablespace: 
--

CREATE INDEX globalize_languages_rfc_3066_index ON globalize_languages USING btree (rfc_3066);


--
-- Name: globalize_translations_table_name_index; Type: INDEX; Schema: public; Owner: tukia; Tablespace: 
--

CREATE INDEX globalize_translations_table_name_index ON globalize_translations USING btree (table_name, item_id, language_id);


--
-- Name: globalize_translations_tr_key_index; Type: INDEX; Schema: public; Owner: tukia; Tablespace: 
--

CREATE INDEX globalize_translations_tr_key_index ON globalize_translations USING btree (tr_key, language_id);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_info (version) VALUES (3)
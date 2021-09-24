
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

--
-- TOC entry 2 (class 3079 OID 16501)
-- Name: pg_trgm; Type: EXTENSION; Schema: -;
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;

--
-- TOC entry 4049 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -;
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 207 (class 1259 OID 17266)
-- Name: commune_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commune_type (
    commune_type_id integer NOT NULL,
    description character varying(256)
);


ALTER TABLE ONLY public.commune_type
    ADD CONSTRAINT commune_type_pk PRIMARY KEY (commune_type_id);

CREATE INDEX commune_type_description_gist_idx ON public.commune_type USING gist (description public.gist_trgm_ops);

--
-- TOC entry 216 (class 1259 OID 16647)
-- Name: spatialunit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spatialunit (
    spatialunit_id integer NOT NULL,
    type_id integer,
    name character varying(256),
    bfs_nr integer,
    name_combined character varying(256),
    district_id integer,
    region_id integer,
    commune_type_id integer,
    zip character varying(256),
    tel character varying(256),
    fax character varying(256),
    homepage character varying(256),
    email character varying(256),
    address character varying(256),
    height integer,
    area integer
);

ALTER TABLE ONLY public.spatialunit
    ADD CONSTRAINT spatialunit_pk PRIMARY KEY (spatialunit_id);

CREATE INDEX spatialunit_address_gist_idx ON public.spatialunit USING gist (address public.gist_trgm_ops);
CREATE INDEX spatialunit_email_gist_idx ON public.spatialunit USING gist (email public.gist_trgm_ops);
CREATE INDEX spatialunit_fax_gist_idx ON public.spatialunit USING gist (fax public.gist_trgm_ops);
CREATE INDEX spatialunit_homepage_gist_idx ON public.spatialunit USING gist (homepage public.gist_trgm_ops);
CREATE INDEX spatialunit_name_combined_gist_idx ON public.spatialunit USING gist (name_combined public.gist_trgm_ops);
CREATE INDEX spatialunit_name_gist_idx ON public.spatialunit USING gist (name public.gist_trgm_ops);
CREATE INDEX spatialunit_tel_gist_idx ON public.spatialunit USING gist (tel public.gist_trgm_ops);
CREATE INDEX spatialunit_zip_gist_idx ON public.spatialunit USING gist (zip public.gist_trgm_ops);

ALTER TABLE ONLY public.spatialunit
    ADD CONSTRAINT spatialunit_fk1 FOREIGN KEY (type_id) REFERENCES public.commune_type(commune_type_id);

--
-- TOC entry 202 (class 1259 OID 16586)
-- Name: indicators; Type: TABLE; Schema: public;
--

CREATE TABLE public.indicators (
    indicator_id integer NOT NULL,
    name character varying(256),
    description character varying(4000),
    source character varying(4000),
    unit_short character varying(256),
    unit_long character varying(256),
    "current_date" character varying(256),
    min_year integer,
    max_year integer
);

ALTER TABLE ONLY public.indicators
    ADD CONSTRAINT indicators_pk PRIMARY KEY (indicator_id);

CREATE INDEX indicators_description_gist_idx ON public.indicators USING gist (description public.gist_trgm_ops);
CREATE INDEX indicators_name_gist_idx ON public.indicators USING gist (name public.gist_trgm_ops);
CREATE INDEX indicators_source_gist_idx ON public.indicators USING gist (source public.gist_trgm_ops);
CREATE INDEX indicators_unit_long_gist_idx ON public.indicators USING gist (unit_long public.gist_trgm_ops);
CREATE INDEX indicators_unit_short_gist_idx ON public.indicators USING gist (unit_short public.gist_trgm_ops);

--
-- TOC entry 201 (class 1259 OID 16580)
-- Name: indicator_values2; Type: TABLE; Schema: public;
--

CREATE TABLE public.indicator_values2 (
    indicator_id integer NOT NULL,
    spatialunit_id integer NOT NULL,
    year integer NOT NULL,
    value numeric(10, 2),
    -- value character varying(256),
    value_addition character varying(256),
    cat character varying(256)
);

ALTER TABLE ONLY public.indicator_values2
    ADD CONSTRAINT indicator_value_pk2 PRIMARY KEY (spatialunit_id, indicator_id, year);

CREATE INDEX indicator_values2_cat_gist_idx ON public.indicator_values2 USING gist (cat public.gist_trgm_ops);
CREATE INDEX indicator_values2_value_addition_gist_idx ON public.indicator_values2 USING gist (value_addition public.gist_trgm_ops);
CREATE INDEX indicator_values2_value_gist_idx ON public.indicator_values2(value);
-- CREATE INDEX indicator_values2_value_gist_idx ON public.indicator_values2 USING gist (value public.gist_trgm_ops);

ALTER TABLE ONLY public.indicator_values2
    ADD CONSTRAINT indicator_values_fk1 FOREIGN KEY (spatialunit_id) REFERENCES public.spatialunit(spatialunit_id);

ALTER TABLE ONLY public.indicator_values2
    ADD CONSTRAINT indicator_values_fk2 FOREIGN KEY (indicator_id) REFERENCES public.indicators(indicator_id);


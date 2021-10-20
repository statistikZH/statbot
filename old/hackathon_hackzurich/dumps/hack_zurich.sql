--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4 (Debian 13.4-1.pgdg100+1)
-- Dumped by pg_dump version 13.4 (Debian 13.4-1.pgdg100+1)

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
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: indicator_values2; Type: TABLE; Schema: public; Owner: hack_zurich
--

CREATE TABLE public.indicator_values2 (
    indicator_id integer NOT NULL,
    spatialunit_id integer NOT NULL,
    year integer NOT NULL,
    value character varying(256),
    value_addition character varying(256),
    cat character varying(256)
);


ALTER TABLE public.indicator_values2 OWNER TO hack_zurich;

--
-- Name: indicators; Type: TABLE; Schema: public; Owner: hack_zurich
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


ALTER TABLE public.indicators OWNER TO hack_zurich;

--
-- Name: accessibility_bus; Type: VIEW; Schema: public; Owner: hack_zurich
--

CREATE VIEW public.accessibility_bus AS
 SELECT v.value AS access_by_bus,
    v.year,
    v.spatialunit_id
   FROM (public.indicators i
     JOIN public.indicator_values2 v ON ((i.indicator_id = v.indicator_id)))
  WHERE (btrim((i.name)::text) = 'Access by bus [% of inhabitants]'::text);


ALTER TABLE public.accessibility_bus OWNER TO hack_zurich;

--
-- Name: accessibility_train; Type: VIEW; Schema: public; Owner: hack_zurich
--

CREATE VIEW public.accessibility_train AS
 SELECT v.value AS access_by_suburban_train,
    v.year,
    v.spatialunit_id
   FROM (public.indicators i
     JOIN public.indicator_values2 v ON ((i.indicator_id = v.indicator_id)))
  WHERE (btrim((i.name)::text) = 'Access by suburban train [% of inhabitants]'::text);


ALTER TABLE public.accessibility_train OWNER TO hack_zurich;

--
-- Name: accessibility_train_and_bus; Type: VIEW; Schema: public; Owner: hack_zurich
--

CREATE VIEW public.accessibility_train_and_bus AS
 SELECT v.value AS access_by_suburban_train_and_bus,
    v.year,
    v.spatialunit_id
   FROM (public.indicators i
     JOIN public.indicator_values2 v ON ((i.indicator_id = v.indicator_id)))
  WHERE (btrim((i.name)::text) = 'Accessibility by suburban train+bus [% of inhabitants]'::text);


ALTER TABLE public.accessibility_train_and_bus OWNER TO hack_zurich;

--
-- Name: amount_new_pw_registrations; Type: VIEW; Schema: public; Owner: hack_zurich
--

CREATE VIEW public.amount_new_pw_registrations AS
 SELECT v.value AS amount_new_pw_registrations_per_1000_inhabitants,
    v.year,
    v.spatialunit_id
   FROM (public.indicators i
     JOIN public.indicator_values2 v ON ((i.indicator_id = v.indicator_id)))
  WHERE (btrim((i.name)::text) = 'PW new registrations per 1000 inhabitants [amount]'::text);


ALTER TABLE public.amount_new_pw_registrations OWNER TO hack_zurich;

--
-- Name: commune_type; Type: TABLE; Schema: public; Owner: hack_zurich
--

CREATE TABLE public.commune_type (
    commune_type_id integer NOT NULL,
    description character varying(256)
);


ALTER TABLE public.commune_type OWNER TO hack_zurich;

--
-- Name: distance_next_stop; Type: VIEW; Schema: public; Owner: hack_zurich
--

CREATE VIEW public.distance_next_stop AS
 SELECT v.value AS distance_to_next_stop,
    v.year,
    v.spatialunit_id
   FROM (public.indicators i
     JOIN public.indicator_values2 v ON ((i.indicator_id = v.indicator_id)))
  WHERE (btrim((i.name)::text) = 'Distance to the next stop [m]'::text);


ALTER TABLE public.distance_next_stop OWNER TO hack_zurich;

--
-- Name: miv_share; Type: VIEW; Schema: public; Owner: hack_zurich
--

CREATE VIEW public.miv_share AS
 SELECT v.value AS miv_share_modal_split,
    v.year,
    v.spatialunit_id
   FROM (public.indicators i
     JOIN public.indicator_values2 v ON ((i.indicator_id = v.indicator_id)))
  WHERE (btrim((i.name)::text) = 'MIV share (modal split) [%]'::text);


ALTER TABLE public.miv_share OWNER TO hack_zurich;

--
-- Name: new_electric_car_registrations; Type: VIEW; Schema: public; Owner: hack_zurich
--

CREATE VIEW public.new_electric_car_registrations AS
 SELECT v.value AS new_electric_car_registrations,
    v.year,
    v.spatialunit_id
   FROM (public.indicators i
     JOIN public.indicator_values2 v ON ((i.indicator_id = v.indicator_id)))
  WHERE (btrim((i.name)::text) = 'New registrations electric motor cars [%]'::text);


ALTER TABLE public.new_electric_car_registrations OWNER TO hack_zurich;

--
-- Name: new_hybrid_car_registrations; Type: VIEW; Schema: public; Owner: hack_zurich
--

CREATE VIEW public.new_hybrid_car_registrations AS
 SELECT v.value AS new_hybrid_car_registrations,
    v.year,
    v.spatialunit_id
   FROM (public.indicators i
     JOIN public.indicator_values2 v ON ((i.indicator_id = v.indicator_id)))
  WHERE (btrim((i.name)::text) = 'New registrations of hybrid motor cars [%]'::text);


ALTER TABLE public.new_hybrid_car_registrations OWNER TO hack_zurich;

--
-- Name: number_of_passenger_cars; Type: VIEW; Schema: public; Owner: hack_zurich
--

CREATE VIEW public.number_of_passenger_cars AS
 SELECT v.value AS passenger_cars_per_1000_inhabitants,
    v.year,
    v.spatialunit_id
   FROM (public.indicators i
     JOIN public.indicator_values2 v ON ((i.indicator_id = v.indicator_id)))
  WHERE (btrim((i.name)::text) = 'Passenger cars per 1000 inhabitants [no.]'::text);


ALTER TABLE public.number_of_passenger_cars OWNER TO hack_zurich;

--
-- Name: public_transport_share; Type: VIEW; Schema: public; Owner: hack_zurich
--

CREATE VIEW public.public_transport_share AS
 SELECT v.value AS public_transport_share_modal_split,
    v.year,
    v.spatialunit_id
   FROM (public.indicators i
     JOIN public.indicator_values2 v ON ((i.indicator_id = v.indicator_id)))
  WHERE (btrim((i.name)::text) = 'public transport share (modal split) [%]'::text);


ALTER TABLE public.public_transport_share OWNER TO hack_zurich;

--
-- Name: share_electric_cars; Type: VIEW; Schema: public; Owner: hack_zurich
--

CREATE VIEW public.share_electric_cars AS
 SELECT v.value AS share_electric_cars,
    v.year,
    v.spatialunit_id
   FROM (public.indicators i
     JOIN public.indicator_values2 v ON ((i.indicator_id = v.indicator_id)))
  WHERE (btrim((i.name)::text) = 'Electric motor cars stock [%]'::text);


ALTER TABLE public.share_electric_cars OWNER TO hack_zurich;

--
-- Name: share_hybrid_cars; Type: VIEW; Schema: public; Owner: hack_zurich
--

CREATE VIEW public.share_hybrid_cars AS
 SELECT v.value AS share_of_hybrid_cars,
    v.year,
    v.spatialunit_id
   FROM (public.indicators i
     JOIN public.indicator_values2 v ON ((i.indicator_id = v.indicator_id)))
  WHERE (btrim((i.name)::text) = 'Hybrid motor cars stock [%]'::text);


ALTER TABLE public.share_hybrid_cars OWNER TO hack_zurich;

--
-- Name: spatialunit; Type: TABLE; Schema: public; Owner: hack_zurich
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


ALTER TABLE public.spatialunit OWNER TO hack_zurich;

--
-- Name: commune_type commune_type_pk; Type: CONSTRAINT; Schema: public; Owner: hack_zurich
--

ALTER TABLE ONLY public.commune_type
    ADD CONSTRAINT commune_type_pk PRIMARY KEY (commune_type_id);


--
-- Name: indicator_values2 indicator_value_pk2; Type: CONSTRAINT; Schema: public; Owner: hack_zurich
--

ALTER TABLE ONLY public.indicator_values2
    ADD CONSTRAINT indicator_value_pk2 PRIMARY KEY (spatialunit_id, indicator_id, year);


--
-- Name: indicators indicators_pk; Type: CONSTRAINT; Schema: public; Owner: hack_zurich
--

ALTER TABLE ONLY public.indicators
    ADD CONSTRAINT indicators_pk PRIMARY KEY (indicator_id);


--
-- Name: spatialunit spatialunit_pk; Type: CONSTRAINT; Schema: public; Owner: hack_zurich
--

ALTER TABLE ONLY public.spatialunit
    ADD CONSTRAINT spatialunit_pk PRIMARY KEY (spatialunit_id);


--
-- Name: commune_type_description_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX commune_type_description_gist_idx ON public.commune_type USING gist (description public.gist_trgm_ops);


--
-- Name: indicator_values2_cat_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX indicator_values2_cat_gist_idx ON public.indicator_values2 USING gist (cat public.gist_trgm_ops);


--
-- Name: indicator_values2_value_addition_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX indicator_values2_value_addition_gist_idx ON public.indicator_values2 USING gist (value_addition public.gist_trgm_ops);


--
-- Name: indicator_values2_value_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX indicator_values2_value_gist_idx ON public.indicator_values2 USING gist (value public.gist_trgm_ops);


--
-- Name: indicators_description_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX indicators_description_gist_idx ON public.indicators USING gist (description public.gist_trgm_ops);


--
-- Name: indicators_name_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX indicators_name_gist_idx ON public.indicators USING gist (name public.gist_trgm_ops);


--
-- Name: indicators_source_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX indicators_source_gist_idx ON public.indicators USING gist (source public.gist_trgm_ops);


--
-- Name: indicators_unit_long_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX indicators_unit_long_gist_idx ON public.indicators USING gist (unit_long public.gist_trgm_ops);


--
-- Name: indicators_unit_short_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX indicators_unit_short_gist_idx ON public.indicators USING gist (unit_short public.gist_trgm_ops);


--
-- Name: spatialunit_address_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX spatialunit_address_gist_idx ON public.spatialunit USING gist (address public.gist_trgm_ops);


--
-- Name: spatialunit_email_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX spatialunit_email_gist_idx ON public.spatialunit USING gist (email public.gist_trgm_ops);


--
-- Name: spatialunit_fax_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX spatialunit_fax_gist_idx ON public.spatialunit USING gist (fax public.gist_trgm_ops);


--
-- Name: spatialunit_homepage_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX spatialunit_homepage_gist_idx ON public.spatialunit USING gist (homepage public.gist_trgm_ops);


--
-- Name: spatialunit_name_combined_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX spatialunit_name_combined_gist_idx ON public.spatialunit USING gist (name_combined public.gist_trgm_ops);


--
-- Name: spatialunit_name_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX spatialunit_name_gist_idx ON public.spatialunit USING gist (name public.gist_trgm_ops);


--
-- Name: spatialunit_tel_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX spatialunit_tel_gist_idx ON public.spatialunit USING gist (tel public.gist_trgm_ops);


--
-- Name: spatialunit_zip_gist_idx; Type: INDEX; Schema: public; Owner: hack_zurich
--

CREATE INDEX spatialunit_zip_gist_idx ON public.spatialunit USING gist (zip public.gist_trgm_ops);


--
-- Name: indicator_values2 indicator_values_fk1; Type: FK CONSTRAINT; Schema: public; Owner: hack_zurich
--

ALTER TABLE ONLY public.indicator_values2
    ADD CONSTRAINT indicator_values_fk1 FOREIGN KEY (spatialunit_id) REFERENCES public.spatialunit(spatialunit_id);


--
-- Name: indicator_values2 indicator_values_fk2; Type: FK CONSTRAINT; Schema: public; Owner: hack_zurich
--

ALTER TABLE ONLY public.indicator_values2
    ADD CONSTRAINT indicator_values_fk2 FOREIGN KEY (indicator_id) REFERENCES public.indicators(indicator_id);


--
-- Name: spatialunit spatialunit_fk1; Type: FK CONSTRAINT; Schema: public; Owner: hack_zurich
--

ALTER TABLE ONLY public.spatialunit
    ADD CONSTRAINT spatialunit_fk1 FOREIGN KEY (type_id) REFERENCES public.commune_type(commune_type_id);


--
-- PostgreSQL database dump complete
--


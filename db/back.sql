--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-02-12 15:38:02

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

DROP DATABASE IF EXISTS "FamilyBudget";
--
-- TOC entry 4865 (class 1262 OID 16489)
-- Name: FamilyBudget; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE "FamilyBudget" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


\connect "FamilyBudget"

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 16510)
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    categories_id integer NOT NULL,
    categories_name text NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 16509)
-- Name: categories_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.categories ALTER COLUMN categories_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.categories_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16549)
-- Name: expence_product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.expence_product (
    expence_product_id integer NOT NULL,
    family_members_id integer NOT NULL,
    products_id integer NOT NULL,
    expence_product_date_purchase date NOT NULL,
    expence_product_quantity integer NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 16548)
-- Name: expence_product_expence_product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.expence_product ALTER COLUMN expence_product_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.expence_product_expence_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16491)
-- Name: family_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.family_members (
    family_members_id integer NOT NULL,
    fio_family_members_id integer NOT NULL,
    date_birth_family_members date NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 16490)
-- Name: family_members_family_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.family_members ALTER COLUMN family_members_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.family_members_family_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16497)
-- Name: fio_family_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fio_family_members (
    fio_family_members_id integer NOT NULL,
    fio_family_members_surname text NOT NULL,
    fio_family_members_name text NOT NULL,
    fio_family_members_patronymic text
);


--
-- TOC entry 219 (class 1259 OID 16496)
-- Name: fio_family_members_fio_family_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.fio_family_members ALTER COLUMN fio_family_members_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.fio_family_members_fio_family_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 16531)
-- Name: jobs_family_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs_family_members (
    jobs_family_members_id integer NOT NULL,
    family_members_id integer NOT NULL,
    post_id integer NOT NULL,
    organization_id integer NOT NULL,
    jobs_family_members_salary integer NOT NULL,
    jobs_family_members_start_date date NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16530)
-- Name: jobs_family_members_jobs_family_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.jobs_family_members ALTER COLUMN jobs_family_members_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.jobs_family_members_jobs_family_members_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 16572)
-- Name: organization; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organization (
    organization_id integer NOT NULL,
    organization_name text NOT NULL
);


--
-- TOC entry 232 (class 1259 OID 16594)
-- Name: organization_organization_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.organization ALTER COLUMN organization_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.organization_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 16565)
-- Name: post; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post (
    post_id integer NOT NULL,
    post_name text NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 16564)
-- Name: post_post_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.post ALTER COLUMN post_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.post_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16518)
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    products_id integer NOT NULL,
    categories_id integer NOT NULL,
    products_name text NOT NULL,
    products_price_unit integer NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 16517)
-- Name: products_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.products ALTER COLUMN products_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.products_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4849 (class 0 OID 16510)
-- Dependencies: 222
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categories (categories_id, categories_name) OVERRIDING SYSTEM VALUE VALUES (1, 'Продукты') ON CONFLICT DO NOTHING;
INSERT INTO public.categories (categories_id, categories_name) OVERRIDING SYSTEM VALUE VALUES (2, 'Транспорт') ON CONFLICT DO NOTHING;
INSERT INTO public.categories (categories_id, categories_name) OVERRIDING SYSTEM VALUE VALUES (3, 'Развлечения') ON CONFLICT DO NOTHING;
INSERT INTO public.categories (categories_id, categories_name) OVERRIDING SYSTEM VALUE VALUES (4, 'Одежда') ON CONFLICT DO NOTHING;
INSERT INTO public.categories (categories_id, categories_name) OVERRIDING SYSTEM VALUE VALUES (5, 'Образование') ON CONFLICT DO NOTHING;
INSERT INTO public.categories (categories_id, categories_name) OVERRIDING SYSTEM VALUE VALUES (6, 'Здоровье') ON CONFLICT DO NOTHING;
INSERT INTO public.categories (categories_id, categories_name) OVERRIDING SYSTEM VALUE VALUES (7, 'Кредиты') ON CONFLICT DO NOTHING;
INSERT INTO public.categories (categories_id, categories_name) OVERRIDING SYSTEM VALUE VALUES (8, 'Подарки') ON CONFLICT DO NOTHING;


--
-- TOC entry 4855 (class 0 OID 16549)
-- Dependencies: 228
-- Data for Name: expence_product; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.expence_product (expence_product_id, family_members_id, products_id, expence_product_date_purchase, expence_product_quantity) OVERRIDING SYSTEM VALUE VALUES (1, 1, 1, '2025-02-01', 2) ON CONFLICT DO NOTHING;
INSERT INTO public.expence_product (expence_product_id, family_members_id, products_id, expence_product_date_purchase, expence_product_quantity) OVERRIDING SYSTEM VALUE VALUES (2, 1, 2, '2025-02-01', 3) ON CONFLICT DO NOTHING;
INSERT INTO public.expence_product (expence_product_id, family_members_id, products_id, expence_product_date_purchase, expence_product_quantity) OVERRIDING SYSTEM VALUE VALUES (3, 1, 2, '2025-02-01', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.expence_product (expence_product_id, family_members_id, products_id, expence_product_date_purchase, expence_product_quantity) OVERRIDING SYSTEM VALUE VALUES (4, 2, 5, '2025-02-06', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.expence_product (expence_product_id, family_members_id, products_id, expence_product_date_purchase, expence_product_quantity) OVERRIDING SYSTEM VALUE VALUES (5, 4, 3, '2025-02-09', 30) ON CONFLICT DO NOTHING;
INSERT INTO public.expence_product (expence_product_id, family_members_id, products_id, expence_product_date_purchase, expence_product_quantity) OVERRIDING SYSTEM VALUE VALUES (6, 3, 7, '2025-02-12', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.expence_product (expence_product_id, family_members_id, products_id, expence_product_date_purchase, expence_product_quantity) OVERRIDING SYSTEM VALUE VALUES (7, 1, 8, '2025-02-18', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.expence_product (expence_product_id, family_members_id, products_id, expence_product_date_purchase, expence_product_quantity) OVERRIDING SYSTEM VALUE VALUES (8, 2, 9, '2025-02-22', 1) ON CONFLICT DO NOTHING;
INSERT INTO public.expence_product (expence_product_id, family_members_id, products_id, expence_product_date_purchase, expence_product_quantity) OVERRIDING SYSTEM VALUE VALUES (9, 5, 4, '2025-02-22', 1) ON CONFLICT DO NOTHING;


--
-- TOC entry 4845 (class 0 OID 16491)
-- Dependencies: 218
-- Data for Name: family_members; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.family_members (family_members_id, fio_family_members_id, date_birth_family_members) OVERRIDING SYSTEM VALUE VALUES (1, 1, '1985-06-15') ON CONFLICT DO NOTHING;
INSERT INTO public.family_members (family_members_id, fio_family_members_id, date_birth_family_members) OVERRIDING SYSTEM VALUE VALUES (2, 2, '1987-09-20') ON CONFLICT DO NOTHING;
INSERT INTO public.family_members (family_members_id, fio_family_members_id, date_birth_family_members) OVERRIDING SYSTEM VALUE VALUES (3, 3, '1959-03-10') ON CONFLICT DO NOTHING;
INSERT INTO public.family_members (family_members_id, fio_family_members_id, date_birth_family_members) OVERRIDING SYSTEM VALUE VALUES (4, 4, '1982-12-05') ON CONFLICT DO NOTHING;
INSERT INTO public.family_members (family_members_id, fio_family_members_id, date_birth_family_members) OVERRIDING SYSTEM VALUE VALUES (5, 5, '2010-02-05') ON CONFLICT DO NOTHING;


--
-- TOC entry 4847 (class 0 OID 16497)
-- Dependencies: 220
-- Data for Name: fio_family_members; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.fio_family_members (fio_family_members_id, fio_family_members_surname, fio_family_members_name, fio_family_members_patronymic) OVERRIDING SYSTEM VALUE VALUES (1, 'Иванов', 'Иван', 'Петрович') ON CONFLICT DO NOTHING;
INSERT INTO public.fio_family_members (fio_family_members_id, fio_family_members_surname, fio_family_members_name, fio_family_members_patronymic) OVERRIDING SYSTEM VALUE VALUES (2, 'Иванова', 'Мария', 'Сергеевна') ON CONFLICT DO NOTHING;
INSERT INTO public.fio_family_members (fio_family_members_id, fio_family_members_surname, fio_family_members_name, fio_family_members_patronymic) OVERRIDING SYSTEM VALUE VALUES (3, 'Иванова', 'Елена', 'Викторовна') ON CONFLICT DO NOTHING;
INSERT INTO public.fio_family_members (fio_family_members_id, fio_family_members_surname, fio_family_members_name, fio_family_members_patronymic) OVERRIDING SYSTEM VALUE VALUES (4, 'Петров', 'Сергей', 'Александрович') ON CONFLICT DO NOTHING;
INSERT INTO public.fio_family_members (fio_family_members_id, fio_family_members_surname, fio_family_members_name, fio_family_members_patronymic) OVERRIDING SYSTEM VALUE VALUES (5, 'Иванов', 'Алексей', 'Иванович') ON CONFLICT DO NOTHING;


--
-- TOC entry 4853 (class 0 OID 16531)
-- Dependencies: 226
-- Data for Name: jobs_family_members; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.jobs_family_members (jobs_family_members_id, family_members_id, post_id, organization_id, jobs_family_members_salary, jobs_family_members_start_date) OVERRIDING SYSTEM VALUE VALUES (1, 1, 1, 1, 85000, '2015-03-01') ON CONFLICT DO NOTHING;
INSERT INTO public.jobs_family_members (jobs_family_members_id, family_members_id, post_id, organization_id, jobs_family_members_salary, jobs_family_members_start_date) OVERRIDING SYSTEM VALUE VALUES (2, 2, 2, 2, 75000, '2012-04-15') ON CONFLICT DO NOTHING;
INSERT INTO public.jobs_family_members (jobs_family_members_id, family_members_id, post_id, organization_id, jobs_family_members_salary, jobs_family_members_start_date) OVERRIDING SYSTEM VALUE VALUES (3, 3, 3, 3, 15000, '2020-01-10') ON CONFLICT DO NOTHING;
INSERT INTO public.jobs_family_members (jobs_family_members_id, family_members_id, post_id, organization_id, jobs_family_members_salary, jobs_family_members_start_date) OVERRIDING SYSTEM VALUE VALUES (4, 4, 4, 4, 30000, '2020-09-01') ON CONFLICT DO NOTHING;


--
-- TOC entry 4858 (class 0 OID 16572)
-- Dependencies: 231
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.organization (organization_id, organization_name) OVERRIDING SYSTEM VALUE VALUES (1, 'ООО "ТехноСервис"') ON CONFLICT DO NOTHING;
INSERT INTO public.organization (organization_id, organization_name) OVERRIDING SYSTEM VALUE VALUES (2, 'АО "ФинансГрупп"') ON CONFLICT DO NOTHING;
INSERT INTO public.organization (organization_id, organization_name) OVERRIDING SYSTEM VALUE VALUES (3, 'Частная практика') ON CONFLICT DO NOTHING;
INSERT INTO public.organization (organization_id, organization_name) OVERRIDING SYSTEM VALUE VALUES (4, 'Индивидуальная работа') ON CONFLICT DO NOTHING;


--
-- TOC entry 4857 (class 0 OID 16565)
-- Dependencies: 230
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.post (post_id, post_name) OVERRIDING SYSTEM VALUE VALUES (1, 'Инженер') ON CONFLICT DO NOTHING;
INSERT INTO public.post (post_id, post_name) OVERRIDING SYSTEM VALUE VALUES (2, 'Бухгалтер') ON CONFLICT DO NOTHING;
INSERT INTO public.post (post_id, post_name) OVERRIDING SYSTEM VALUE VALUES (3, 'Репетитор') ON CONFLICT DO NOTHING;
INSERT INTO public.post (post_id, post_name) OVERRIDING SYSTEM VALUE VALUES (4, 'Таксист') ON CONFLICT DO NOTHING;


--
-- TOC entry 4851 (class 0 OID 16518)
-- Dependencies: 224
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.products (products_id, categories_id, products_name, products_price_unit) OVERRIDING SYSTEM VALUE VALUES (1, 1, 'Хлеб', 50) ON CONFLICT DO NOTHING;
INSERT INTO public.products (products_id, categories_id, products_name, products_price_unit) OVERRIDING SYSTEM VALUE VALUES (2, 1, 'Молоко', 80) ON CONFLICT DO NOTHING;
INSERT INTO public.products (products_id, categories_id, products_name, products_price_unit) OVERRIDING SYSTEM VALUE VALUES (3, 2, 'Бензин', 80) ON CONFLICT DO NOTHING;
INSERT INTO public.products (products_id, categories_id, products_name, products_price_unit) OVERRIDING SYSTEM VALUE VALUES (4, 3, 'Билет в кино', 300) ON CONFLICT DO NOTHING;
INSERT INTO public.products (products_id, categories_id, products_name, products_price_unit) OVERRIDING SYSTEM VALUE VALUES (5, 4, 'Зимнее пальто', 8500) ON CONFLICT DO NOTHING;
INSERT INTO public.products (products_id, categories_id, products_name, products_price_unit) OVERRIDING SYSTEM VALUE VALUES (6, 5, 'Учебники', 400) ON CONFLICT DO NOTHING;
INSERT INTO public.products (products_id, categories_id, products_name, products_price_unit) OVERRIDING SYSTEM VALUE VALUES (7, 6, 'Лекарства', 25000) ON CONFLICT DO NOTHING;
INSERT INTO public.products (products_id, categories_id, products_name, products_price_unit) OVERRIDING SYSTEM VALUE VALUES (8, 7, 'Погашение кредита', 89000) ON CONFLICT DO NOTHING;
INSERT INTO public.products (products_id, categories_id, products_name, products_price_unit) OVERRIDING SYSTEM VALUE VALUES (9, 8, 'Смартфон в подарок', 99900) ON CONFLICT DO NOTHING;


--
-- TOC entry 4866 (class 0 OID 0)
-- Dependencies: 221
-- Name: categories_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_categories_id_seq', 8, true);


--
-- TOC entry 4867 (class 0 OID 0)
-- Dependencies: 227
-- Name: expence_product_expence_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.expence_product_expence_product_id_seq', 9, true);


--
-- TOC entry 4868 (class 0 OID 0)
-- Dependencies: 217
-- Name: family_members_family_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.family_members_family_members_id_seq', 5, true);


--
-- TOC entry 4869 (class 0 OID 0)
-- Dependencies: 219
-- Name: fio_family_members_fio_family_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.fio_family_members_fio_family_members_id_seq', 5, true);


--
-- TOC entry 4870 (class 0 OID 0)
-- Dependencies: 225
-- Name: jobs_family_members_jobs_family_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jobs_family_members_jobs_family_members_id_seq', 4, true);


--
-- TOC entry 4871 (class 0 OID 0)
-- Dependencies: 232
-- Name: organization_organization_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.organization_organization_id_seq', 4, true);


--
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 229
-- Name: post_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.post_post_id_seq', 4, true);


--
-- TOC entry 4873 (class 0 OID 0)
-- Dependencies: 223
-- Name: products_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_products_id_seq', 9, true);


--
-- TOC entry 4681 (class 2606 OID 16516)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (categories_id);


--
-- TOC entry 4687 (class 2606 OID 16553)
-- Name: expence_product expence_product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expence_product
    ADD CONSTRAINT expence_product_pkey PRIMARY KEY (expence_product_id);


--
-- TOC entry 4677 (class 2606 OID 16495)
-- Name: family_members family_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT family_members_pkey PRIMARY KEY (family_members_id);


--
-- TOC entry 4679 (class 2606 OID 16503)
-- Name: fio_family_members fio_family_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fio_family_members
    ADD CONSTRAINT fio_family_members_pkey PRIMARY KEY (fio_family_members_id);


--
-- TOC entry 4685 (class 2606 OID 16535)
-- Name: jobs_family_members jobs_family_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs_family_members
    ADD CONSTRAINT jobs_family_members_pkey PRIMARY KEY (jobs_family_members_id);


--
-- TOC entry 4691 (class 2606 OID 16578)
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (organization_id);


--
-- TOC entry 4689 (class 2606 OID 16571)
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (post_id);


--
-- TOC entry 4683 (class 2606 OID 16524)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (products_id);


--
-- TOC entry 4697 (class 2606 OID 16554)
-- Name: expence_product expence_product_family_members_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expence_product
    ADD CONSTRAINT expence_product_family_members_id_fkey FOREIGN KEY (family_members_id) REFERENCES public.family_members(family_members_id);


--
-- TOC entry 4698 (class 2606 OID 16559)
-- Name: expence_product expence_product_products_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.expence_product
    ADD CONSTRAINT expence_product_products_id_fkey FOREIGN KEY (products_id) REFERENCES public.products(products_id);


--
-- TOC entry 4692 (class 2606 OID 16504)
-- Name: family_members fio_family_members_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.family_members
    ADD CONSTRAINT fio_family_members_id FOREIGN KEY (fio_family_members_id) REFERENCES public.fio_family_members(fio_family_members_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4694 (class 2606 OID 16589)
-- Name: jobs_family_members jobs_family_members_family_members_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs_family_members
    ADD CONSTRAINT jobs_family_members_family_members_id_fkey FOREIGN KEY (family_members_id) REFERENCES public.family_members(family_members_id) NOT VALID;


--
-- TOC entry 4695 (class 2606 OID 16584)
-- Name: jobs_family_members jobs_family_members_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs_family_members
    ADD CONSTRAINT jobs_family_members_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organization(organization_id) NOT VALID;


--
-- TOC entry 4696 (class 2606 OID 16579)
-- Name: jobs_family_members jobs_family_members_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs_family_members
    ADD CONSTRAINT jobs_family_members_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(post_id) NOT VALID;


--
-- TOC entry 4693 (class 2606 OID 16525)
-- Name: products products_categories_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_categories_id_fkey FOREIGN KEY (categories_id) REFERENCES public.categories(categories_id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2025-02-12 15:38:02

--
-- PostgreSQL database dump complete
--


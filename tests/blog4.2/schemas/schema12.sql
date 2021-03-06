CREATE TABLE blog1 (
    id integer NOT NULL,
    col1 character varying
);
CREATE SEQUENCE blog1_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE blog1_id_seq OWNED BY blog1.id;
CREATE TABLE blog2 (
    id integer NOT NULL,
    col1 character varying,
    col2 character varying,
    blog1_id integer
);
CREATE TABLE blog3 (
    id integer NOT NULL,
    col1 character varying,
    blog1_id integer
);
CREATE SEQUENCE blog3_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE blog3_id_seq OWNED BY blog3.id;
CREATE TABLE blog4 (
    id integer NOT NULL,
    col1 character varying
);
CREATE SEQUENCE blog4_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE blog4_id_seq OWNED BY blog4.id;
CREATE SEQUENCE blog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE blog_id_seq OWNED BY blog2.id;
ALTER TABLE ONLY blog1 ALTER COLUMN id SET DEFAULT nextval('blog1_id_seq'::regclass);
ALTER TABLE ONLY blog2 ALTER COLUMN id SET DEFAULT nextval('blog_id_seq'::regclass);
ALTER TABLE ONLY blog3 ALTER COLUMN id SET DEFAULT nextval('blog3_id_seq'::regclass);
ALTER TABLE ONLY blog4 ALTER COLUMN id SET DEFAULT nextval('blog4_id_seq'::regclass);
ALTER TABLE ONLY blog1
    ADD CONSTRAINT blog1_pkey PRIMARY KEY (id);
ALTER TABLE ONLY blog3
    ADD CONSTRAINT blog3_pkey PRIMARY KEY (id);
ALTER TABLE ONLY blog4
    ADD CONSTRAINT blog4_pkey PRIMARY KEY (id);
ALTER TABLE ONLY blog2
    ADD CONSTRAINT blog_pkey PRIMARY KEY (id);
CREATE UNIQUE INDEX index_col1_on_col1 ON blog4 USING btree (col1);
ALTER TABLE ONLY blog2
    ADD CONSTRAINT "fk blog2.blog1_id to blog1.id" FOREIGN KEY (blog1_id) REFERENCES blog1(id) MATCH FULL;
ALTER TABLE ONLY blog3
    ADD CONSTRAINT "fk blog3.blog1_id to blog1.id" FOREIGN KEY (blog1_id) REFERENCES blog1(id) MATCH FULL;
REVOKE ALL ON TABLE blog1 FROM PUBLIC;
GRANT ALL ON TABLE blog1 TO db_evolve_test;
GRANT INSERT,UPDATE ON TABLE blog1 TO db_evolve_test2;
REVOKE ALL ON TABLE blog2 FROM PUBLIC;
GRANT ALL ON TABLE blog2 TO db_evolve_test;
GRANT UPDATE ON TABLE blog2 TO db_evolve_test2;
REVOKE ALL ON TABLE blog3 FROM PUBLIC;
GRANT ALL ON TABLE blog3 TO db_evolve_test;
GRANT SELECT,INSERT,UPDATE ON TABLE blog3 TO db_evolve_test2;
REVOKE ALL ON TABLE blog4 FROM PUBLIC;
GRANT ALL ON TABLE blog4 TO db_evolve_test;
GRANT INSERT,UPDATE ON TABLE blog4 TO db_evolve_test2;

-- public.authority definition

-- Drop table

-- DROP TABLE public.authority;

CREATE TABLE public.authority (
	"name" varchar(50) NOT NULL,
	CONSTRAINT authority_pkey PRIMARY KEY (name)
);


-- public.user_ definition

-- Drop table

-- DROP TABLE public.user_;

CREATE TABLE public.user_ (
	created_date timestamptz(6) NULL,
	id int8 NOT NULL,
	last_modified_date timestamptz(6) NULL,
	last_seen timestamptz(6) NULL,
	public_id uuid NULL,
	email varchar(255) NULL,
	firstname varchar(255) NULL,
	gender varchar(255) NULL,
	image_url varchar(255) NULL,
	lastname varchar(255) NULL,
	CONSTRAINT user__gender_check CHECK (((gender)::text = ANY ((ARRAY['MALE'::character varying, 'FEMALE'::character varying])::text[]))),
	CONSTRAINT user__pkey PRIMARY KEY (id)
);


-- public.user_authority definition

-- Drop table

-- DROP TABLE public.user_authority;

CREATE TABLE public.user_authority (
	user_id int8 NOT NULL,
	authority_name varchar(50) NOT NULL,
	CONSTRAINT user_authority_pkey PRIMARY KEY (user_id, authority_name),
	CONSTRAINT fk6ktglpl5mjosa283rvken2py5 FOREIGN KEY (authority_name) REFERENCES public.authority("name"),
	CONSTRAINT fkio2xcw9ogcqbasp25n5vttxrf FOREIGN KEY (user_id) REFERENCES public.user_(id)
);



-- public.message definition

-- Drop table

-- DROP TABLE public.message;

CREATE TABLE public.message (
	created_date timestamptz(6) NULL,
	id int8 NOT NULL,
	last_modified_date timestamptz(6) NULL,
	CONSTRAINT message_pkey PRIMARY KEY (id)
);

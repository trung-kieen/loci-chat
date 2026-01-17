--
-- PostgreSQL database dump
--

\restrict xDR9FJBr0GsRjfFTdoHvE6khgjJTaBjoWBDqrymMBr89ObMuME0r2xTDzlVXGi3

-- Dumped from database version 18.1 (Debian 18.1-1.pgdg13+2)
-- Dumped by pg_dump version 18.1 (Debian 18.1-1.pgdg13+2)

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO admin;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO admin;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO admin;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO admin;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authenticator_config (
    id character varying(36) CONSTRAINT authenticator_id_not_null NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO admin;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) CONSTRAINT authenticator_config_authenticator_id_not_null NOT NULL,
    value text,
    name character varying(255) CONSTRAINT authenticator_config_name_not_null NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO admin;

--
-- Name: authority; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authority (
    name character varying(50) NOT NULL
);


ALTER TABLE public.authority OWNER TO admin;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO admin;

--
-- Name: client; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO admin;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO admin;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO admin;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO admin;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) CONSTRAINT app_node_registrations_application_id_not_null NOT NULL,
    value integer,
    name character varying(255) CONSTRAINT app_node_registrations_name_not_null NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO admin;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope (
    id character varying(36) CONSTRAINT client_template_id_not_null NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO admin;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) CONSTRAINT client_template_attributes_template_id_not_null NOT NULL,
    value character varying(2048),
    name character varying(255) CONSTRAINT client_template_attributes_name_not_null NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO admin;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO admin;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) CONSTRAINT template_scope_mapping_template_id_not_null NOT NULL,
    role_id character varying(36) CONSTRAINT template_scope_mapping_role_id_not_null NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO admin;

--
-- Name: component; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO admin;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO admin;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO admin;

--
-- Name: contact; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.contact (
    id bigint NOT NULL,
    created_date timestamp(6) with time zone,
    last_modified_date timestamp(6) with time zone,
    blocked_by bigint,
    contact_user_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.contact OWNER TO admin;

--
-- Name: contact_request; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.contact_request (
    id bigint NOT NULL,
    created_date timestamp(6) with time zone,
    last_modified_date timestamp(6) with time zone,
    receiver_user_id bigint NOT NULL,
    request_user_id bigint NOT NULL,
    status character varying(255),
    public_id uuid,
    CONSTRAINT contact_request_status_check CHECK (((status)::text = ANY (ARRAY[('PENDING'::character varying)::text, ('ACCEPTED'::character varying)::text, ('DECLINED'::character varying)::text, ('CANCELED'::character varying)::text])))
);


ALTER TABLE public.contact_request OWNER TO admin;

--
-- Name: contact_request_sequence; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.contact_request_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contact_request_sequence OWNER TO admin;

--
-- Name: contact_sequence; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.contact_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contact_sequence OWNER TO admin;

--
-- Name: conversation; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.conversation (
    id bigint NOT NULL,
    created_date timestamp(6) with time zone,
    last_modified_date timestamp(6) with time zone,
    creator_id bigint NOT NULL,
    deleted boolean NOT NULL,
    last_message_id bigint,
    public_id uuid,
    conversation_type character varying(255) NOT NULL,
    last_message_sent timestamp(6) with time zone,
    CONSTRAINT conversation_conversation_type_check CHECK (((conversation_type)::text = ANY (ARRAY[('ONE_TO_ONE'::character varying)::text, ('GROUP'::character varying)::text])))
);


ALTER TABLE public.conversation OWNER TO admin;

--
-- Name: conversation_participant; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.conversation_participant (
    id bigint NOT NULL,
    created_date timestamp(6) with time zone,
    last_modified_date timestamp(6) with time zone,
    last_read_message_id bigint,
    role character varying(20) NOT NULL,
    conversation_id bigint NOT NULL,
    user_id bigint NOT NULL,
    CONSTRAINT conversation_participant_role_check CHECK (((role)::text = ANY (ARRAY[('MEMBER'::character varying)::text, ('ADMIN'::character varying)::text])))
);


ALTER TABLE public.conversation_participant OWNER TO admin;

--
-- Name: conversation_participant_sequence; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.conversation_participant_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversation_participant_sequence OWNER TO admin;

--
-- Name: conversation_sequence; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.conversation_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversation_sequence OWNER TO admin;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO admin;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO admin;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO admin;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO admin;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO admin;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO admin;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO admin;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO admin;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO admin;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO admin;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO admin;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO admin;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO admin;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO admin;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO admin;

--
-- Name: group_; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.group_ (
    id bigint NOT NULL,
    created_date timestamp(6) with time zone,
    last_modified_date timestamp(6) with time zone,
    group_name character varying(255) NOT NULL,
    group_profile_picture character varying(500),
    last_active timestamp(6) with time zone,
    conversation_id bigint NOT NULL,
    public_id uuid
);


ALTER TABLE public.group_ OWNER TO admin;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO admin;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO admin;

--
-- Name: group_sequence; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.group_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.group_sequence OWNER TO admin;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO admin;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO admin;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO admin;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO admin;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO admin;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false CONSTRAINT keycloak_role_application_role_not_null NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO admin;

--
-- Name: message; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.message (
    id bigint NOT NULL,
    created_date timestamp(6) with time zone,
    last_modified_date timestamp(6) with time zone,
    content text NOT NULL,
    deleted boolean NOT NULL,
    delivered_at timestamp(6) with time zone,
    media_url character varying(500),
    read_at timestamp(6) with time zone,
    sent_at timestamp(6) with time zone,
    status character varying(20) NOT NULL,
    type character varying(20) NOT NULL,
    conversation_id bigint NOT NULL,
    sender_id bigint NOT NULL,
    public_id uuid,
    media_name character varying(100),
    reply_to_message_id bigint,
    CONSTRAINT message_status_check CHECK (((status)::text = ANY (ARRAY[('PREPARE'::character varying)::text, ('SENT'::character varying)::text, ('DELIVERED'::character varying)::text, ('SEEN'::character varying)::text]))),
    CONSTRAINT message_type_check CHECK (((type)::text = ANY (ARRAY[('TEXT'::character varying)::text, ('FILE'::character varying)::text, ('IMAGE'::character varying)::text, ('VIDEO'::character varying)::text])))
);


ALTER TABLE public.message OWNER TO admin;

--
-- Name: message_sequence; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.message_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.message_sequence OWNER TO admin;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO admin;

--
-- Name: notification; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.notification (
    id bigint NOT NULL,
    created_date timestamp(6) with time zone,
    last_modified_date timestamp(6) with time zone,
    content text NOT NULL,
    message_thumbnail character varying(500),
    read_at timestamp(6) with time zone,
    user_id bigint NOT NULL,
    public_id uuid
);


ALTER TABLE public.notification OWNER TO admin;

--
-- Name: notification_sequence; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.notification_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_sequence OWNER TO admin;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO admin;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO admin;

--
-- Name: org; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO admin;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO admin;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO admin;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO admin;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO admin;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO admin;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO admin;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO admin;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO admin;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO admin;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO admin;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO admin;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO admin;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO admin;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO admin;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO admin;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO admin;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO admin;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO admin;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO admin;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server (
    id character varying(36) CONSTRAINT resource_server_client_id_not_null NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO admin;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO admin;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) CONSTRAINT resource_server_policy_resource_server_client_id_not_null NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO admin;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) CONSTRAINT resource_server_resource_resource_server_client_id_not_null NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO admin;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) CONSTRAINT resource_server_scope_resource_server_client_id_not_null NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO admin;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO admin;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO admin;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO admin;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO admin;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO admin;

--
-- Name: user_; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_ (
    profile_visibility boolean,
    created_date timestamp(6) with time zone,
    id bigint NOT NULL,
    last_active timestamp(6) with time zone,
    last_modified_date timestamp(6) with time zone,
    last_seen timestamp(6) with time zone,
    public_id uuid,
    bio character varying(255),
    email character varying(255),
    firstname character varying(255),
    image_url character varying(255),
    lastname character varying(255),
    profile_picture character varying(255),
    username character varying(255)
);


ALTER TABLE public.user_ OWNER TO admin;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO admin;

--
-- Name: user_authority; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_authority (
    user_id bigint NOT NULL,
    authority_name character varying(50) NOT NULL
);


ALTER TABLE public.user_authority OWNER TO admin;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO admin;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO admin;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO admin;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO admin;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO admin;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) CONSTRAINT user_federation_mapper_confi_user_federation_mapper_id_not_null NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO admin;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO admin;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO admin;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO admin;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO admin;

--
-- Name: user_sequence; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.user_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_sequence OWNER TO admin;

--
-- Name: user_settings; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_settings (
    user_id bigint NOT NULL,
    created_date timestamp(6) with time zone,
    last_modified_date timestamp(6) with time zone,
    friend_request_setting character varying(255),
    last_seen_setting character varying(255),
    profile_visibility boolean,
    CONSTRAINT user_settings_friend_request_setting_check CHECK (((friend_request_setting)::text = ANY (ARRAY[('EVERYONE'::character varying)::text, ('FRIENDS_OF_FRIENDS'::character varying)::text, ('NOBODY'::character varying)::text]))),
    CONSTRAINT user_settings_last_seen_setting_check CHECK (((last_seen_setting)::text = ANY (ARRAY[('EVERYONE'::character varying)::text, ('CONTACT_ONLY'::character varying)::text, ('NOBODY'::character varying)::text])))
);


ALTER TABLE public.user_settings OWNER TO admin;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO admin;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO admin;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
f30f31a1-13ad-455a-b079-7d7f59d57d67	\N	auth-cookie	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	bda78048-1390-400a-bda8-e9b89d57a529	2	10	f	\N	\N
edc396d3-26a1-4178-89aa-f0a89e408b53	\N	auth-spnego	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	bda78048-1390-400a-bda8-e9b89d57a529	3	20	f	\N	\N
e9ead245-11d1-415a-a9b7-79fff614dd04	\N	identity-provider-redirector	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	bda78048-1390-400a-bda8-e9b89d57a529	2	25	f	\N	\N
6cd2f731-be49-4e3f-b718-56577b575a39	\N	\N	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	bda78048-1390-400a-bda8-e9b89d57a529	2	30	t	05ece1c6-fb93-49e9-8328-a34e9ded1480	\N
ef3b3b22-ce33-442b-a5d7-25584471b828	\N	auth-username-password-form	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	05ece1c6-fb93-49e9-8328-a34e9ded1480	0	10	f	\N	\N
a7de6235-4887-4fd5-8a1c-d9e556a3b617	\N	\N	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	05ece1c6-fb93-49e9-8328-a34e9ded1480	1	20	t	be0fafd0-af80-4cc1-b12c-481192f2ab07	\N
5a12bae1-4d09-47be-8b9f-c8da6a9da6c4	\N	conditional-user-configured	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	be0fafd0-af80-4cc1-b12c-481192f2ab07	0	10	f	\N	\N
2690fa81-6b72-4a7c-9194-6c528b85c805	\N	auth-otp-form	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	be0fafd0-af80-4cc1-b12c-481192f2ab07	0	20	f	\N	\N
0e05381b-b5bf-452e-941e-a01a27bdde17	\N	direct-grant-validate-username	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	87e21c40-5a38-4ded-aa9a-ee5be3a859a8	0	10	f	\N	\N
c496b972-3c9b-4f6e-8f63-a68b3e592c65	\N	direct-grant-validate-password	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	87e21c40-5a38-4ded-aa9a-ee5be3a859a8	0	20	f	\N	\N
c3939231-bbc2-40a1-af6c-203afcde89b6	\N	\N	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	87e21c40-5a38-4ded-aa9a-ee5be3a859a8	1	30	t	e5e85ba7-e5d7-4c43-9099-e56982eb22ac	\N
9ff67a95-9ee2-4c90-9fd1-42b4e542fe5c	\N	conditional-user-configured	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	e5e85ba7-e5d7-4c43-9099-e56982eb22ac	0	10	f	\N	\N
91597241-6900-43e1-9f0e-665ebf5dc44b	\N	direct-grant-validate-otp	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	e5e85ba7-e5d7-4c43-9099-e56982eb22ac	0	20	f	\N	\N
1e81acb4-3827-4570-bfc5-51e14734c83e	\N	registration-page-form	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	0baf5a45-b260-47aa-bc63-a7b8d55ac82d	0	10	t	d7f2948f-48ef-4f20-9607-c70e3bb498f6	\N
558ba6cf-71ec-4422-89c2-d2e1579e9627	\N	registration-user-creation	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	d7f2948f-48ef-4f20-9607-c70e3bb498f6	0	20	f	\N	\N
4218dfc2-20f3-49a6-aecb-a219197d9d17	\N	registration-password-action	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	d7f2948f-48ef-4f20-9607-c70e3bb498f6	0	50	f	\N	\N
c485cc65-8d07-44a0-a507-0e0a50ea0684	\N	registration-recaptcha-action	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	d7f2948f-48ef-4f20-9607-c70e3bb498f6	3	60	f	\N	\N
1974b79a-a804-4010-8758-5f113ad7c4cf	\N	registration-terms-and-conditions	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	d7f2948f-48ef-4f20-9607-c70e3bb498f6	3	70	f	\N	\N
eb48bd8f-3ba1-4300-aa0a-f5c91ba464a7	\N	reset-credentials-choose-user	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	796c5d7a-3347-40e5-b5a1-a4619d20160a	0	10	f	\N	\N
457e5227-6088-40fa-a29a-e1c8f4295905	\N	reset-credential-email	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	796c5d7a-3347-40e5-b5a1-a4619d20160a	0	20	f	\N	\N
5f780e9d-efd6-4511-98bb-19853b98bcb9	\N	reset-password	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	796c5d7a-3347-40e5-b5a1-a4619d20160a	0	30	f	\N	\N
fc95f4f9-fc9b-490e-9a06-5720b60a0fb3	\N	\N	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	796c5d7a-3347-40e5-b5a1-a4619d20160a	1	40	t	b967df29-2bfc-4a5f-9365-46dae68d626a	\N
5f1809fc-86bb-49af-b039-0a5b2ba6f8b8	\N	conditional-user-configured	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	b967df29-2bfc-4a5f-9365-46dae68d626a	0	10	f	\N	\N
c75cfaab-48f0-4b6c-931d-3986694b2dda	\N	reset-otp	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	b967df29-2bfc-4a5f-9365-46dae68d626a	0	20	f	\N	\N
cf7e146a-087b-4728-b739-9df99abf96a9	\N	client-secret	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	694edd3e-70c6-49df-9727-e7eec3ffccc8	2	10	f	\N	\N
a3ebf452-60d6-4735-86d9-269f0a30cafd	\N	client-jwt	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	694edd3e-70c6-49df-9727-e7eec3ffccc8	2	20	f	\N	\N
52334d64-e201-4e03-a5aa-16c2ca71deb9	\N	client-secret-jwt	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	694edd3e-70c6-49df-9727-e7eec3ffccc8	2	30	f	\N	\N
dd78a436-5125-4775-a956-34d4d04f8782	\N	client-x509	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	694edd3e-70c6-49df-9727-e7eec3ffccc8	2	40	f	\N	\N
5f5b4289-9c6f-41ef-9af3-0999bd3cce26	\N	idp-review-profile	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	ca40da1e-78e1-4f29-90b6-995359635938	0	10	f	\N	e32af835-8b12-4f5d-8305-e6cc41713b7c
466fb089-411c-4744-a18f-d6306ab15744	\N	\N	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	ca40da1e-78e1-4f29-90b6-995359635938	0	20	t	96d48920-7674-4ae0-a8de-5ce7c7e612c8	\N
efae122c-a734-483d-9933-14dfb1fe75c5	\N	idp-create-user-if-unique	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	96d48920-7674-4ae0-a8de-5ce7c7e612c8	2	10	f	\N	09450c0a-3a87-4c50-b952-a74d8b6c2776
25891bea-470a-48cb-ba89-4556eac04fba	\N	\N	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	96d48920-7674-4ae0-a8de-5ce7c7e612c8	2	20	t	7a26e765-0e54-42d0-b567-e2c67f20219a	\N
e4d3d317-6768-46e2-9c97-bcf60d5fa571	\N	idp-confirm-link	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	7a26e765-0e54-42d0-b567-e2c67f20219a	0	10	f	\N	\N
b6eb7042-b780-4dab-963f-6ac85d7deead	\N	\N	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	7a26e765-0e54-42d0-b567-e2c67f20219a	0	20	t	d7469606-5eb0-44bb-a289-77cfa8aeb237	\N
090d740c-36be-489a-a3e2-4994e4190786	\N	idp-email-verification	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	d7469606-5eb0-44bb-a289-77cfa8aeb237	2	10	f	\N	\N
cfb8a3d2-7af4-4a43-81bc-380141daef17	\N	\N	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	d7469606-5eb0-44bb-a289-77cfa8aeb237	2	20	t	31f7aace-7336-4eba-af80-d9ac64a012d9	\N
cfb7c3ff-b7a8-4985-934b-21a5afb372ee	\N	idp-username-password-form	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	31f7aace-7336-4eba-af80-d9ac64a012d9	0	10	f	\N	\N
1e655b80-e83e-499c-920b-6c50ad5a14e3	\N	\N	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	31f7aace-7336-4eba-af80-d9ac64a012d9	1	20	t	b40d0cd4-c9d3-4e78-ac71-7bf69d9619b2	\N
05d565b6-ee1e-4778-b17e-f343d90b3c7e	\N	conditional-user-configured	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	b40d0cd4-c9d3-4e78-ac71-7bf69d9619b2	0	10	f	\N	\N
63ad70ac-148e-4c5d-8a47-24ff3ea1344d	\N	auth-otp-form	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	b40d0cd4-c9d3-4e78-ac71-7bf69d9619b2	0	20	f	\N	\N
7189afa8-22ed-4306-8b3b-a46bcdf3ad1d	\N	http-basic-authenticator	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	fe683a4c-9c7b-487a-8cf2-2da011dde608	0	10	f	\N	\N
8b9125ac-b38d-450d-a146-e379622723f2	\N	docker-http-basic-authenticator	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	0cb2e244-077b-4fd0-b3c0-8cd68b504ba9	0	10	f	\N	\N
2793f1f3-925c-4a50-baf9-347aef9d1625	\N	idp-email-verification	83b6664d-539e-4bed-a376-685d50e40b98	10e5cbf9-6d70-4671-8b7c-25a13f3b30b6	2	10	f	\N	\N
c653345d-e72e-4ca7-8327-74a473a385eb	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	10e5cbf9-6d70-4671-8b7c-25a13f3b30b6	2	20	t	9072b1a2-a2d2-426d-9fe7-bfb40b87cfab	\N
8a1144bd-98ff-4f6a-b71e-3c8838ffdb99	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	936ccde4-b63d-4262-b8a6-af7d521dc3aa	0	10	f	\N	\N
53b8cbae-9355-4974-bd97-de0b5cf6bc4d	\N	auth-otp-form	83b6664d-539e-4bed-a376-685d50e40b98	936ccde4-b63d-4262-b8a6-af7d521dc3aa	0	20	f	\N	\N
a1f61181-75ff-47d1-b001-236a9279507f	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	dc1e8d98-e26a-437c-91a3-f8ca8ed2dd59	0	10	f	\N	\N
a3c2aae6-8b1a-44d3-b3c4-2ab10f1e54bf	\N	organization	83b6664d-539e-4bed-a376-685d50e40b98	dc1e8d98-e26a-437c-91a3-f8ca8ed2dd59	2	20	f	\N	\N
1911f874-0bb3-46ba-b7c5-50220b44026b	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	5b2379d9-11fb-476f-8530-5a91ca18e364	0	10	f	\N	\N
d48d8696-34a9-49aa-946f-ffe4f2be953d	\N	direct-grant-validate-otp	83b6664d-539e-4bed-a376-685d50e40b98	5b2379d9-11fb-476f-8530-5a91ca18e364	0	20	f	\N	\N
628d0c96-1fee-4e05-98c7-9458080d1d5b	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	fcaef89a-b301-4a9d-86b6-f570c43d07ad	0	10	f	\N	\N
346cada6-3382-4818-98c7-a3dc684a9d4f	\N	idp-add-organization-member	83b6664d-539e-4bed-a376-685d50e40b98	fcaef89a-b301-4a9d-86b6-f570c43d07ad	0	20	f	\N	\N
c120a377-708f-43ff-996e-5183ea42be6a	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	ceed43c7-5d3f-4eb1-b878-2314aef46ebf	0	10	f	\N	\N
a673e7fd-a2bf-472b-aaa5-8d4d77a899ed	\N	auth-otp-form	83b6664d-539e-4bed-a376-685d50e40b98	ceed43c7-5d3f-4eb1-b878-2314aef46ebf	0	20	f	\N	\N
6fd18b16-1a16-403d-ad88-c965c621e434	\N	idp-confirm-link	83b6664d-539e-4bed-a376-685d50e40b98	a9376912-6f72-4749-a4e3-6ce74c0ec76a	0	10	f	\N	\N
dd493710-c6af-443d-9b13-291b25b38760	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	a9376912-6f72-4749-a4e3-6ce74c0ec76a	0	20	t	10e5cbf9-6d70-4671-8b7c-25a13f3b30b6	\N
772de298-9613-4c5b-81d4-cbcb23318ee0	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	291b3c02-9178-4997-92a8-2c77b4a762da	1	10	t	dc1e8d98-e26a-437c-91a3-f8ca8ed2dd59	\N
a333c7b9-19f6-4c0e-b84f-02f52117febc	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	510a55f8-b4a5-47e9-ac56-b60fc6ed8676	0	10	f	\N	\N
8854a18c-172d-4b16-8134-bd8999aa4072	\N	reset-otp	83b6664d-539e-4bed-a376-685d50e40b98	510a55f8-b4a5-47e9-ac56-b60fc6ed8676	0	20	f	\N	\N
1970ccc7-461a-4aea-96a1-cf2770ee51f6	\N	idp-create-user-if-unique	83b6664d-539e-4bed-a376-685d50e40b98	677d2578-fe86-4de9-8a18-860f8d89d4f3	2	10	f	\N	7805e560-dd03-4e34-a6ff-1784f53fecad
41f17652-8419-45e3-96de-38fc960f04f6	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	677d2578-fe86-4de9-8a18-860f8d89d4f3	2	20	t	a9376912-6f72-4749-a4e3-6ce74c0ec76a	\N
dab1c259-c309-4ace-84bc-88663f6740ef	\N	idp-username-password-form	83b6664d-539e-4bed-a376-685d50e40b98	9072b1a2-a2d2-426d-9fe7-bfb40b87cfab	0	10	f	\N	\N
477fa475-5739-4e25-a694-f63eaee16e7c	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	9072b1a2-a2d2-426d-9fe7-bfb40b87cfab	1	20	t	ceed43c7-5d3f-4eb1-b878-2314aef46ebf	\N
2386eee8-1f57-4456-8bd5-254cde2bb1df	\N	auth-cookie	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	2	10	f	\N	\N
fed09609-3020-4bc9-be69-9f22a1a278ff	\N	auth-spnego	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	3	20	f	\N	\N
46d3e078-9063-4b1c-aa07-4d353ab00187	\N	identity-provider-redirector	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	2	25	f	\N	\N
1360b913-1d60-49a1-acb8-3d4e4c075ca1	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	2	26	t	291b3c02-9178-4997-92a8-2c77b4a762da	\N
3245654e-e273-467d-8a0c-fded3ac42586	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	2	30	t	4c7e2a97-05a5-4499-99d5-b0fe14711095	\N
1c6e21e7-d297-492c-b183-35d06549cab9	\N	client-secret	83b6664d-539e-4bed-a376-685d50e40b98	05607ab5-8839-424c-b1e7-7f0ccad2063e	2	10	f	\N	\N
e0dbf582-ad6c-43fd-beeb-6aa1b052efb1	\N	client-jwt	83b6664d-539e-4bed-a376-685d50e40b98	05607ab5-8839-424c-b1e7-7f0ccad2063e	2	20	f	\N	\N
8e74ab78-96fb-46a5-b22f-02b6e326ee91	\N	client-secret-jwt	83b6664d-539e-4bed-a376-685d50e40b98	05607ab5-8839-424c-b1e7-7f0ccad2063e	2	30	f	\N	\N
c5e34ac1-040d-4a24-a4cb-122af49a3646	\N	client-x509	83b6664d-539e-4bed-a376-685d50e40b98	05607ab5-8839-424c-b1e7-7f0ccad2063e	2	40	f	\N	\N
1321932e-bb62-4d49-a1f7-3268199ce856	\N	direct-grant-validate-username	83b6664d-539e-4bed-a376-685d50e40b98	d7b8234b-3d04-4263-ac07-79794e3fb8c0	0	10	f	\N	\N
7f18f38f-3ef3-4a22-b7c0-02e19b85a508	\N	direct-grant-validate-password	83b6664d-539e-4bed-a376-685d50e40b98	d7b8234b-3d04-4263-ac07-79794e3fb8c0	0	20	f	\N	\N
442c0412-3f50-4ae8-9a2a-ac9f36d885ad	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	d7b8234b-3d04-4263-ac07-79794e3fb8c0	1	30	t	5b2379d9-11fb-476f-8530-5a91ca18e364	\N
5a431f41-9937-456e-a3ae-7e4ecaa4a4c1	\N	docker-http-basic-authenticator	83b6664d-539e-4bed-a376-685d50e40b98	08caf47c-2dda-42d5-a33d-3df1271e703c	0	10	f	\N	\N
7c1075fa-95f9-4cd2-a051-643d97b2cfce	\N	idp-review-profile	83b6664d-539e-4bed-a376-685d50e40b98	668883be-9b51-42f6-9e35-cb35d7961852	0	10	f	\N	135d8612-fdf4-4acf-abf8-e25c0565ebf6
9847f5c5-2db2-412e-a312-144964961444	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	668883be-9b51-42f6-9e35-cb35d7961852	0	20	t	677d2578-fe86-4de9-8a18-860f8d89d4f3	\N
5e43460a-21ad-417a-ae45-4cb1cf5a5f30	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	668883be-9b51-42f6-9e35-cb35d7961852	1	50	t	fcaef89a-b301-4a9d-86b6-f570c43d07ad	\N
e33a8212-ea35-43b9-899d-ce7fd27877e2	\N	auth-username-password-form	83b6664d-539e-4bed-a376-685d50e40b98	4c7e2a97-05a5-4499-99d5-b0fe14711095	0	10	f	\N	\N
d42b6238-510f-4eaf-aadb-43937e263f2d	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	4c7e2a97-05a5-4499-99d5-b0fe14711095	1	20	t	936ccde4-b63d-4262-b8a6-af7d521dc3aa	\N
86927a63-0998-4ed7-988d-8adfa4ea3845	\N	registration-page-form	83b6664d-539e-4bed-a376-685d50e40b98	8c356fe3-6843-440d-ac93-b4cc6352781f	0	10	t	aa3e186d-9e97-41c0-a7f5-956fb754bdea	\N
8c220aee-a360-4dee-9cce-c57f81258b08	\N	registration-user-creation	83b6664d-539e-4bed-a376-685d50e40b98	aa3e186d-9e97-41c0-a7f5-956fb754bdea	0	20	f	\N	\N
f5246413-4d46-4677-b7de-5483b9c7b9c7	\N	registration-password-action	83b6664d-539e-4bed-a376-685d50e40b98	aa3e186d-9e97-41c0-a7f5-956fb754bdea	0	50	f	\N	\N
66b9f6e8-9bfe-4722-adb6-e1c57c5dfb0a	\N	registration-recaptcha-action	83b6664d-539e-4bed-a376-685d50e40b98	aa3e186d-9e97-41c0-a7f5-956fb754bdea	3	60	f	\N	\N
73473c2e-eac4-4f66-b9cd-c5a36d7a1625	\N	registration-terms-and-conditions	83b6664d-539e-4bed-a376-685d50e40b98	aa3e186d-9e97-41c0-a7f5-956fb754bdea	3	70	f	\N	\N
e4363e77-f7af-40fc-9968-3f033e61dcf0	\N	reset-credentials-choose-user	83b6664d-539e-4bed-a376-685d50e40b98	2ec9ca75-4f99-43e9-816d-708c9a550838	0	10	f	\N	\N
3dd3157a-3dc5-44ab-ae28-77de817e372a	\N	reset-credential-email	83b6664d-539e-4bed-a376-685d50e40b98	2ec9ca75-4f99-43e9-816d-708c9a550838	0	20	f	\N	\N
f015dd5d-bc73-49e3-9d47-003ef8f0b720	\N	reset-password	83b6664d-539e-4bed-a376-685d50e40b98	2ec9ca75-4f99-43e9-816d-708c9a550838	0	30	f	\N	\N
c9aad6eb-eedc-4a42-82ca-923039e9a9a9	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	2ec9ca75-4f99-43e9-816d-708c9a550838	1	40	t	510a55f8-b4a5-47e9-ac56-b60fc6ed8676	\N
d6a50200-faa7-4789-b28d-4181fa9a848f	\N	http-basic-authenticator	83b6664d-539e-4bed-a376-685d50e40b98	626d5f6d-04d2-4f35-8cfc-da5e65715166	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
bda78048-1390-400a-bda8-e9b89d57a529	browser	Browser based authentication	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	t	t
05ece1c6-fb93-49e9-8328-a34e9ded1480	forms	Username, password, otp and other auth forms.	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	f	t
be0fafd0-af80-4cc1-b12c-481192f2ab07	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	f	t
87e21c40-5a38-4ded-aa9a-ee5be3a859a8	direct grant	OpenID Connect Resource Owner Grant	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	t	t
e5e85ba7-e5d7-4c43-9099-e56982eb22ac	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	f	t
0baf5a45-b260-47aa-bc63-a7b8d55ac82d	registration	Registration flow	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	t	t
d7f2948f-48ef-4f20-9607-c70e3bb498f6	registration form	Registration form	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	form-flow	f	t
796c5d7a-3347-40e5-b5a1-a4619d20160a	reset credentials	Reset credentials for a user if they forgot their password or something	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	t	t
b967df29-2bfc-4a5f-9365-46dae68d626a	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	f	t
694edd3e-70c6-49df-9727-e7eec3ffccc8	clients	Base authentication for clients	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	client-flow	t	t
ca40da1e-78e1-4f29-90b6-995359635938	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	t	t
96d48920-7674-4ae0-a8de-5ce7c7e612c8	User creation or linking	Flow for the existing/non-existing user alternatives	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	f	t
7a26e765-0e54-42d0-b567-e2c67f20219a	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	f	t
d7469606-5eb0-44bb-a289-77cfa8aeb237	Account verification options	Method with which to verity the existing account	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	f	t
31f7aace-7336-4eba-af80-d9ac64a012d9	Verify Existing Account by Re-authentication	Reauthentication of existing account	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	f	t
b40d0cd4-c9d3-4e78-ac71-7bf69d9619b2	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	f	t
fe683a4c-9c7b-487a-8cf2-2da011dde608	saml ecp	SAML ECP Profile Authentication Flow	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	t	t
0cb2e244-077b-4fd0-b3c0-8cd68b504ba9	docker auth	Used by Docker clients to authenticate against the IDP	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	basic-flow	t	t
10e5cbf9-6d70-4671-8b7c-25a13f3b30b6	Account verification options	Method with which to verity the existing account	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	f	t
936ccde4-b63d-4262-b8a6-af7d521dc3aa	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	f	t
dc1e8d98-e26a-437c-91a3-f8ca8ed2dd59	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	f	t
5b2379d9-11fb-476f-8530-5a91ca18e364	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	f	t
fcaef89a-b301-4a9d-86b6-f570c43d07ad	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	f	t
ceed43c7-5d3f-4eb1-b878-2314aef46ebf	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	f	t
a9376912-6f72-4749-a4e3-6ce74c0ec76a	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	f	t
291b3c02-9178-4997-92a8-2c77b4a762da	Organization	\N	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	f	t
510a55f8-b4a5-47e9-ac56-b60fc6ed8676	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	f	t
677d2578-fe86-4de9-8a18-860f8d89d4f3	User creation or linking	Flow for the existing/non-existing user alternatives	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	f	t
9072b1a2-a2d2-426d-9fe7-bfb40b87cfab	Verify Existing Account by Re-authentication	Reauthentication of existing account	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	f	t
801e570d-bc15-45e3-9f8e-afe9f8f28dec	browser	Browser based authentication	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	t	t
05607ab5-8839-424c-b1e7-7f0ccad2063e	clients	Base authentication for clients	83b6664d-539e-4bed-a376-685d50e40b98	client-flow	t	t
d7b8234b-3d04-4263-ac07-79794e3fb8c0	direct grant	OpenID Connect Resource Owner Grant	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	t	t
08caf47c-2dda-42d5-a33d-3df1271e703c	docker auth	Used by Docker clients to authenticate against the IDP	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	t	t
668883be-9b51-42f6-9e35-cb35d7961852	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	t	t
4c7e2a97-05a5-4499-99d5-b0fe14711095	forms	Username, password, otp and other auth forms.	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	f	t
8c356fe3-6843-440d-ac93-b4cc6352781f	registration	Registration flow	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	t	t
aa3e186d-9e97-41c0-a7f5-956fb754bdea	registration form	Registration form	83b6664d-539e-4bed-a376-685d50e40b98	form-flow	f	t
2ec9ca75-4f99-43e9-816d-708c9a550838	reset credentials	Reset credentials for a user if they forgot their password or something	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	t	t
626d5f6d-04d2-4f35-8cfc-da5e65715166	saml ecp	SAML ECP Profile Authentication Flow	83b6664d-539e-4bed-a376-685d50e40b98	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
e32af835-8b12-4f5d-8305-e6cc41713b7c	review profile config	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd
09450c0a-3a87-4c50-b952-a74d8b6c2776	create unique user config	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd
7805e560-dd03-4e34-a6ff-1784f53fecad	create unique user config	83b6664d-539e-4bed-a376-685d50e40b98
135d8612-fdf4-4acf-abf8-e25c0565ebf6	review profile config	83b6664d-539e-4bed-a376-685d50e40b98
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
09450c0a-3a87-4c50-b952-a74d8b6c2776	false	require.password.update.after.registration
e32af835-8b12-4f5d-8305-e6cc41713b7c	missing	update.profile.on.first.login
135d8612-fdf4-4acf-abf8-e25c0565ebf6	missing	update.profile.on.first.login
7805e560-dd03-4e34-a6ff-1784f53fecad	false	require.password.update.after.registration
\.


--
-- Data for Name: authority; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authority (name) FROM stdin;
ROLE_default-roles-loci-realm
ROLE_uma_authorization
ROLE_user
ROLE_offline_access
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	f	master-realm	0	f	\N	\N	t	\N	f	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f9df92a9-f77e-4712-b20c-c75d66801f73	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
77c491e0-7e4d-42a6-8be7-24061a97bfd9	t	f	broker	0	f	\N	\N	t	\N	f	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d4163211-b255-4df3-98fb-fd48febf1cfe	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
e989a921-5a92-4801-9922-d54bef7786dc	t	t	admin-cli	0	t	\N	\N	f	\N	f	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	f	loci-realm-realm	0	f	\N	\N	t	\N	f	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	\N	0	f	f	loci-realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	t	f	account	0	t	\N	/realms/loci-realm/account/	f	\N	f	83b6664d-539e-4bed-a376-685d50e40b98	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
1512bb33-3ef4-4dad-af1f-47081a2a75dc	t	f	account-console	0	t	\N	/realms/loci-realm/account/	f	\N	f	83b6664d-539e-4bed-a376-685d50e40b98	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	t	t	admin-cli	0	t	\N	\N	f	\N	f	83b6664d-539e-4bed-a376-685d50e40b98	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	t	t	angular	0	t	\N		f		f	83b6664d-539e-4bed-a376-685d50e40b98	openid-connect	-1	t	f		f	client-secret			\N	t	t	t	f
81fb0324-8f89-4cb7-bc31-8af536e10b7e	t	f	broker	0	f	\N	\N	t	\N	f	83b6664d-539e-4bed-a376-685d50e40b98	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d004af51-9d2e-47d3-9340-a3a411f42029	t	t	migration-service	0	t	\N		f		f	83b6664d-539e-4bed-a376-685d50e40b98	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	f	realm-management	0	f	\N	\N	t	\N	f	83b6664d-539e-4bed-a376-685d50e40b98	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
ba4de397-daf8-404b-ad79-249e4d09a713	t	t	security-admin-console	0	t	\N	/admin/loci-realm/console/	f	\N	f	83b6664d-539e-4bed-a376-685d50e40b98	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
e85deedd-b2fb-47d3-acef-508423a77f22	t	t	spring	0	t	\N		f		f	83b6664d-539e-4bed-a376-685d50e40b98	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	post.logout.redirect.uris	+
f9df92a9-f77e-4712-b20c-c75d66801f73	post.logout.redirect.uris	+
f9df92a9-f77e-4712-b20c-c75d66801f73	pkce.code.challenge.method	S256
d4163211-b255-4df3-98fb-fd48febf1cfe	post.logout.redirect.uris	+
d4163211-b255-4df3-98fb-fd48febf1cfe	pkce.code.challenge.method	S256
d4163211-b255-4df3-98fb-fd48febf1cfe	client.use.lightweight.access.token.enabled	true
e989a921-5a92-4801-9922-d54bef7786dc	client.use.lightweight.access.token.enabled	true
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	realm_client	false
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	post.logout.redirect.uris	+
1512bb33-3ef4-4dad-af1f-47081a2a75dc	realm_client	false
1512bb33-3ef4-4dad-af1f-47081a2a75dc	post.logout.redirect.uris	+
1512bb33-3ef4-4dad-af1f-47081a2a75dc	pkce.code.challenge.method	S256
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	realm_client	false
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	client.use.lightweight.access.token.enabled	true
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	post.logout.redirect.uris	+
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	realm_client	false
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	oidc.ciba.grant.enabled	false
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	backchannel.logout.session.required	true
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	post.logout.redirect.uris	http://localhost:4200/*##http://192.168.1.21:4200/*##http://localhost:4200/##http://192.168.1.21:4200/
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	oauth2.device.authorization.grant.enabled	false
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	backchannel.logout.revoke.offline.tokens	false
81fb0324-8f89-4cb7-bc31-8af536e10b7e	realm_client	true
81fb0324-8f89-4cb7-bc31-8af536e10b7e	post.logout.redirect.uris	+
d004af51-9d2e-47d3-9340-a3a411f42029	realm_client	false
d004af51-9d2e-47d3-9340-a3a411f42029	oidc.ciba.grant.enabled	false
d004af51-9d2e-47d3-9340-a3a411f42029	backchannel.logout.session.required	true
d004af51-9d2e-47d3-9340-a3a411f42029	post.logout.redirect.uris	+
d004af51-9d2e-47d3-9340-a3a411f42029	oauth2.device.authorization.grant.enabled	false
d004af51-9d2e-47d3-9340-a3a411f42029	backchannel.logout.revoke.offline.tokens	false
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	realm_client	true
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	post.logout.redirect.uris	+
ba4de397-daf8-404b-ad79-249e4d09a713	realm_client	false
ba4de397-daf8-404b-ad79-249e4d09a713	client.use.lightweight.access.token.enabled	true
ba4de397-daf8-404b-ad79-249e4d09a713	post.logout.redirect.uris	+
ba4de397-daf8-404b-ad79-249e4d09a713	pkce.code.challenge.method	S256
e85deedd-b2fb-47d3-acef-508423a77f22	realm_client	false
e85deedd-b2fb-47d3-acef-508423a77f22	oidc.ciba.grant.enabled	false
e85deedd-b2fb-47d3-acef-508423a77f22	backchannel.logout.session.required	true
e85deedd-b2fb-47d3-acef-508423a77f22	post.logout.redirect.uris	+
e85deedd-b2fb-47d3-acef-508423a77f22	oauth2.device.authorization.grant.enabled	false
e85deedd-b2fb-47d3-acef-508423a77f22	backchannel.logout.revoke.offline.tokens	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
2c11e02b-7650-4ece-99a1-93b9ca1fac30	offline_access	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	OpenID Connect built-in scope: offline_access	openid-connect
8abd1a94-9718-4c81-a418-a724b97fc0a2	role_list	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	SAML role list	saml
77c881f4-2c08-4ee7-8138-86c3984b6813	saml_organization	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	Organization Membership	saml
b80ae8f9-d07b-4194-a395-2471c0596843	profile	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	OpenID Connect built-in scope: profile	openid-connect
32257e27-3893-4477-a98e-54982bcad77a	email	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	OpenID Connect built-in scope: email	openid-connect
233eb4d3-c179-4ff1-b650-c4cd9d78748d	address	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	OpenID Connect built-in scope: address	openid-connect
89c0c5ba-f7f2-413b-89d4-853a79795a2f	phone	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	OpenID Connect built-in scope: phone	openid-connect
f695e5e3-b0e3-4c69-a937-c771a5a33783	roles	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	OpenID Connect scope for add user roles to the access token	openid-connect
19d59b89-cd56-489f-88a9-cb2a992dff91	web-origins	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	OpenID Connect scope for add allowed web origins to the access token	openid-connect
6b2a2852-0172-4cad-a56c-b8f0d651aa72	microprofile-jwt	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	Microprofile - JWT built-in scope	openid-connect
e8d249a0-3b95-40f9-a229-b0b33e22da52	acr	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
ba2f2273-2ced-4c47-8675-acb7607ea83a	basic	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	OpenID Connect scope for add all basic claims to the token	openid-connect
7c8724fc-ab94-4356-b75c-ded384a704f6	organization	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	Additional claims about the organization a subject belongs to	openid-connect
2753e1d9-77a7-4059-8465-fa23a6b418c4	microprofile-jwt	83b6664d-539e-4bed-a376-685d50e40b98	Microprofile - JWT built-in scope	openid-connect
ac70839b-f142-47ab-93cf-f21d06d1f546	basic	83b6664d-539e-4bed-a376-685d50e40b98	OpenID Connect scope for add all basic claims to the token	openid-connect
1e15434a-7f6c-415b-bb60-f84f0edb53d7	email	83b6664d-539e-4bed-a376-685d50e40b98	OpenID Connect built-in scope: email	openid-connect
1343b2a3-ff3c-4588-a0e3-7372006e3cf9	roles	83b6664d-539e-4bed-a376-685d50e40b98	OpenID Connect scope for add user roles to the access token	openid-connect
9749151c-c4bd-4925-b7f6-2e141385a4eb	phone	83b6664d-539e-4bed-a376-685d50e40b98	OpenID Connect built-in scope: phone	openid-connect
d21bbe72-4cc0-4637-aaab-c6beafce7e57	organization	83b6664d-539e-4bed-a376-685d50e40b98	Additional claims about the organization a subject belongs to	openid-connect
ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	web-origins	83b6664d-539e-4bed-a376-685d50e40b98	OpenID Connect scope for add allowed web origins to the access token	openid-connect
26d881ea-f02a-4da4-a770-096c22dcf2b6	saml_organization	83b6664d-539e-4bed-a376-685d50e40b98	Organization Membership	saml
b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	offline_access	83b6664d-539e-4bed-a376-685d50e40b98	OpenID Connect built-in scope: offline_access	openid-connect
38509398-011e-46eb-9444-8719ee1ccbe9	address	83b6664d-539e-4bed-a376-685d50e40b98	OpenID Connect built-in scope: address	openid-connect
b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	acr	83b6664d-539e-4bed-a376-685d50e40b98	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
2714f410-8ea1-4442-b110-09d56464c942	role_list	83b6664d-539e-4bed-a376-685d50e40b98	SAML role list	saml
424886ac-3b5a-446c-a0f8-2d2cd6474e44	profile	83b6664d-539e-4bed-a376-685d50e40b98	OpenID Connect built-in scope: profile	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
2c11e02b-7650-4ece-99a1-93b9ca1fac30	true	display.on.consent.screen
2c11e02b-7650-4ece-99a1-93b9ca1fac30	${offlineAccessScopeConsentText}	consent.screen.text
8abd1a94-9718-4c81-a418-a724b97fc0a2	true	display.on.consent.screen
8abd1a94-9718-4c81-a418-a724b97fc0a2	${samlRoleListScopeConsentText}	consent.screen.text
77c881f4-2c08-4ee7-8138-86c3984b6813	false	display.on.consent.screen
b80ae8f9-d07b-4194-a395-2471c0596843	true	display.on.consent.screen
b80ae8f9-d07b-4194-a395-2471c0596843	${profileScopeConsentText}	consent.screen.text
b80ae8f9-d07b-4194-a395-2471c0596843	true	include.in.token.scope
32257e27-3893-4477-a98e-54982bcad77a	true	display.on.consent.screen
32257e27-3893-4477-a98e-54982bcad77a	${emailScopeConsentText}	consent.screen.text
32257e27-3893-4477-a98e-54982bcad77a	true	include.in.token.scope
233eb4d3-c179-4ff1-b650-c4cd9d78748d	true	display.on.consent.screen
233eb4d3-c179-4ff1-b650-c4cd9d78748d	${addressScopeConsentText}	consent.screen.text
233eb4d3-c179-4ff1-b650-c4cd9d78748d	true	include.in.token.scope
89c0c5ba-f7f2-413b-89d4-853a79795a2f	true	display.on.consent.screen
89c0c5ba-f7f2-413b-89d4-853a79795a2f	${phoneScopeConsentText}	consent.screen.text
89c0c5ba-f7f2-413b-89d4-853a79795a2f	true	include.in.token.scope
f695e5e3-b0e3-4c69-a937-c771a5a33783	true	display.on.consent.screen
f695e5e3-b0e3-4c69-a937-c771a5a33783	${rolesScopeConsentText}	consent.screen.text
f695e5e3-b0e3-4c69-a937-c771a5a33783	false	include.in.token.scope
19d59b89-cd56-489f-88a9-cb2a992dff91	false	display.on.consent.screen
19d59b89-cd56-489f-88a9-cb2a992dff91		consent.screen.text
19d59b89-cd56-489f-88a9-cb2a992dff91	false	include.in.token.scope
6b2a2852-0172-4cad-a56c-b8f0d651aa72	false	display.on.consent.screen
6b2a2852-0172-4cad-a56c-b8f0d651aa72	true	include.in.token.scope
e8d249a0-3b95-40f9-a229-b0b33e22da52	false	display.on.consent.screen
e8d249a0-3b95-40f9-a229-b0b33e22da52	false	include.in.token.scope
ba2f2273-2ced-4c47-8675-acb7607ea83a	false	display.on.consent.screen
ba2f2273-2ced-4c47-8675-acb7607ea83a	false	include.in.token.scope
7c8724fc-ab94-4356-b75c-ded384a704f6	true	display.on.consent.screen
7c8724fc-ab94-4356-b75c-ded384a704f6	${organizationScopeConsentText}	consent.screen.text
7c8724fc-ab94-4356-b75c-ded384a704f6	true	include.in.token.scope
2753e1d9-77a7-4059-8465-fa23a6b418c4	true	include.in.token.scope
2753e1d9-77a7-4059-8465-fa23a6b418c4	false	display.on.consent.screen
ac70839b-f142-47ab-93cf-f21d06d1f546	false	include.in.token.scope
ac70839b-f142-47ab-93cf-f21d06d1f546	false	display.on.consent.screen
1e15434a-7f6c-415b-bb60-f84f0edb53d7	true	include.in.token.scope
1e15434a-7f6c-415b-bb60-f84f0edb53d7	${emailScopeConsentText}	consent.screen.text
1e15434a-7f6c-415b-bb60-f84f0edb53d7	true	display.on.consent.screen
1343b2a3-ff3c-4588-a0e3-7372006e3cf9	false	include.in.token.scope
1343b2a3-ff3c-4588-a0e3-7372006e3cf9	${rolesScopeConsentText}	consent.screen.text
1343b2a3-ff3c-4588-a0e3-7372006e3cf9	true	display.on.consent.screen
9749151c-c4bd-4925-b7f6-2e141385a4eb	true	include.in.token.scope
9749151c-c4bd-4925-b7f6-2e141385a4eb	${phoneScopeConsentText}	consent.screen.text
9749151c-c4bd-4925-b7f6-2e141385a4eb	true	display.on.consent.screen
d21bbe72-4cc0-4637-aaab-c6beafce7e57	true	include.in.token.scope
d21bbe72-4cc0-4637-aaab-c6beafce7e57	${organizationScopeConsentText}	consent.screen.text
d21bbe72-4cc0-4637-aaab-c6beafce7e57	true	display.on.consent.screen
ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	false	include.in.token.scope
ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee		consent.screen.text
ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	false	display.on.consent.screen
26d881ea-f02a-4da4-a770-096c22dcf2b6	false	display.on.consent.screen
b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	${offlineAccessScopeConsentText}	consent.screen.text
b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	true	display.on.consent.screen
38509398-011e-46eb-9444-8719ee1ccbe9	true	include.in.token.scope
38509398-011e-46eb-9444-8719ee1ccbe9	${addressScopeConsentText}	consent.screen.text
38509398-011e-46eb-9444-8719ee1ccbe9	true	display.on.consent.screen
b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	false	include.in.token.scope
b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	false	display.on.consent.screen
2714f410-8ea1-4442-b110-09d56464c942	${samlRoleListScopeConsentText}	consent.screen.text
2714f410-8ea1-4442-b110-09d56464c942	true	display.on.consent.screen
424886ac-3b5a-446c-a0f8-2d2cd6474e44	true	include.in.token.scope
424886ac-3b5a-446c-a0f8-2d2cd6474e44	${profileScopeConsentText}	consent.screen.text
424886ac-3b5a-446c-a0f8-2d2cd6474e44	true	display.on.consent.screen
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	e8d249a0-3b95-40f9-a229-b0b33e22da52	t
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	b80ae8f9-d07b-4194-a395-2471c0596843	t
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	ba2f2273-2ced-4c47-8675-acb7607ea83a	t
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	32257e27-3893-4477-a98e-54982bcad77a	t
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	f695e5e3-b0e3-4c69-a937-c771a5a33783	t
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	19d59b89-cd56-489f-88a9-cb2a992dff91	t
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	233eb4d3-c179-4ff1-b650-c4cd9d78748d	f
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	2c11e02b-7650-4ece-99a1-93b9ca1fac30	f
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	7c8724fc-ab94-4356-b75c-ded384a704f6	f
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	89c0c5ba-f7f2-413b-89d4-853a79795a2f	f
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	6b2a2852-0172-4cad-a56c-b8f0d651aa72	f
f9df92a9-f77e-4712-b20c-c75d66801f73	e8d249a0-3b95-40f9-a229-b0b33e22da52	t
f9df92a9-f77e-4712-b20c-c75d66801f73	b80ae8f9-d07b-4194-a395-2471c0596843	t
f9df92a9-f77e-4712-b20c-c75d66801f73	ba2f2273-2ced-4c47-8675-acb7607ea83a	t
f9df92a9-f77e-4712-b20c-c75d66801f73	32257e27-3893-4477-a98e-54982bcad77a	t
f9df92a9-f77e-4712-b20c-c75d66801f73	f695e5e3-b0e3-4c69-a937-c771a5a33783	t
f9df92a9-f77e-4712-b20c-c75d66801f73	19d59b89-cd56-489f-88a9-cb2a992dff91	t
f9df92a9-f77e-4712-b20c-c75d66801f73	233eb4d3-c179-4ff1-b650-c4cd9d78748d	f
f9df92a9-f77e-4712-b20c-c75d66801f73	2c11e02b-7650-4ece-99a1-93b9ca1fac30	f
f9df92a9-f77e-4712-b20c-c75d66801f73	7c8724fc-ab94-4356-b75c-ded384a704f6	f
f9df92a9-f77e-4712-b20c-c75d66801f73	89c0c5ba-f7f2-413b-89d4-853a79795a2f	f
f9df92a9-f77e-4712-b20c-c75d66801f73	6b2a2852-0172-4cad-a56c-b8f0d651aa72	f
e989a921-5a92-4801-9922-d54bef7786dc	e8d249a0-3b95-40f9-a229-b0b33e22da52	t
e989a921-5a92-4801-9922-d54bef7786dc	b80ae8f9-d07b-4194-a395-2471c0596843	t
e989a921-5a92-4801-9922-d54bef7786dc	ba2f2273-2ced-4c47-8675-acb7607ea83a	t
e989a921-5a92-4801-9922-d54bef7786dc	32257e27-3893-4477-a98e-54982bcad77a	t
e989a921-5a92-4801-9922-d54bef7786dc	f695e5e3-b0e3-4c69-a937-c771a5a33783	t
e989a921-5a92-4801-9922-d54bef7786dc	19d59b89-cd56-489f-88a9-cb2a992dff91	t
e989a921-5a92-4801-9922-d54bef7786dc	233eb4d3-c179-4ff1-b650-c4cd9d78748d	f
e989a921-5a92-4801-9922-d54bef7786dc	2c11e02b-7650-4ece-99a1-93b9ca1fac30	f
e989a921-5a92-4801-9922-d54bef7786dc	7c8724fc-ab94-4356-b75c-ded384a704f6	f
e989a921-5a92-4801-9922-d54bef7786dc	89c0c5ba-f7f2-413b-89d4-853a79795a2f	f
e989a921-5a92-4801-9922-d54bef7786dc	6b2a2852-0172-4cad-a56c-b8f0d651aa72	f
77c491e0-7e4d-42a6-8be7-24061a97bfd9	e8d249a0-3b95-40f9-a229-b0b33e22da52	t
77c491e0-7e4d-42a6-8be7-24061a97bfd9	b80ae8f9-d07b-4194-a395-2471c0596843	t
77c491e0-7e4d-42a6-8be7-24061a97bfd9	ba2f2273-2ced-4c47-8675-acb7607ea83a	t
77c491e0-7e4d-42a6-8be7-24061a97bfd9	32257e27-3893-4477-a98e-54982bcad77a	t
77c491e0-7e4d-42a6-8be7-24061a97bfd9	f695e5e3-b0e3-4c69-a937-c771a5a33783	t
77c491e0-7e4d-42a6-8be7-24061a97bfd9	19d59b89-cd56-489f-88a9-cb2a992dff91	t
77c491e0-7e4d-42a6-8be7-24061a97bfd9	233eb4d3-c179-4ff1-b650-c4cd9d78748d	f
77c491e0-7e4d-42a6-8be7-24061a97bfd9	2c11e02b-7650-4ece-99a1-93b9ca1fac30	f
77c491e0-7e4d-42a6-8be7-24061a97bfd9	7c8724fc-ab94-4356-b75c-ded384a704f6	f
77c491e0-7e4d-42a6-8be7-24061a97bfd9	89c0c5ba-f7f2-413b-89d4-853a79795a2f	f
77c491e0-7e4d-42a6-8be7-24061a97bfd9	6b2a2852-0172-4cad-a56c-b8f0d651aa72	f
9093a96a-50fe-40b6-bf7c-e1f1aced8156	e8d249a0-3b95-40f9-a229-b0b33e22da52	t
9093a96a-50fe-40b6-bf7c-e1f1aced8156	b80ae8f9-d07b-4194-a395-2471c0596843	t
9093a96a-50fe-40b6-bf7c-e1f1aced8156	ba2f2273-2ced-4c47-8675-acb7607ea83a	t
9093a96a-50fe-40b6-bf7c-e1f1aced8156	32257e27-3893-4477-a98e-54982bcad77a	t
9093a96a-50fe-40b6-bf7c-e1f1aced8156	f695e5e3-b0e3-4c69-a937-c771a5a33783	t
9093a96a-50fe-40b6-bf7c-e1f1aced8156	19d59b89-cd56-489f-88a9-cb2a992dff91	t
9093a96a-50fe-40b6-bf7c-e1f1aced8156	233eb4d3-c179-4ff1-b650-c4cd9d78748d	f
9093a96a-50fe-40b6-bf7c-e1f1aced8156	2c11e02b-7650-4ece-99a1-93b9ca1fac30	f
9093a96a-50fe-40b6-bf7c-e1f1aced8156	7c8724fc-ab94-4356-b75c-ded384a704f6	f
9093a96a-50fe-40b6-bf7c-e1f1aced8156	89c0c5ba-f7f2-413b-89d4-853a79795a2f	f
9093a96a-50fe-40b6-bf7c-e1f1aced8156	6b2a2852-0172-4cad-a56c-b8f0d651aa72	f
d4163211-b255-4df3-98fb-fd48febf1cfe	e8d249a0-3b95-40f9-a229-b0b33e22da52	t
d4163211-b255-4df3-98fb-fd48febf1cfe	b80ae8f9-d07b-4194-a395-2471c0596843	t
d4163211-b255-4df3-98fb-fd48febf1cfe	ba2f2273-2ced-4c47-8675-acb7607ea83a	t
d4163211-b255-4df3-98fb-fd48febf1cfe	32257e27-3893-4477-a98e-54982bcad77a	t
d4163211-b255-4df3-98fb-fd48febf1cfe	f695e5e3-b0e3-4c69-a937-c771a5a33783	t
d4163211-b255-4df3-98fb-fd48febf1cfe	19d59b89-cd56-489f-88a9-cb2a992dff91	t
d4163211-b255-4df3-98fb-fd48febf1cfe	233eb4d3-c179-4ff1-b650-c4cd9d78748d	f
d4163211-b255-4df3-98fb-fd48febf1cfe	2c11e02b-7650-4ece-99a1-93b9ca1fac30	f
d4163211-b255-4df3-98fb-fd48febf1cfe	7c8724fc-ab94-4356-b75c-ded384a704f6	f
d4163211-b255-4df3-98fb-fd48febf1cfe	89c0c5ba-f7f2-413b-89d4-853a79795a2f	f
d4163211-b255-4df3-98fb-fd48febf1cfe	6b2a2852-0172-4cad-a56c-b8f0d651aa72	f
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	t
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	t
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	1343b2a3-ff3c-4588-a0e3-7372006e3cf9	t
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	424886ac-3b5a-446c-a0f8-2d2cd6474e44	t
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	ac70839b-f142-47ab-93cf-f21d06d1f546	t
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	1e15434a-7f6c-415b-bb60-f84f0edb53d7	t
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	38509398-011e-46eb-9444-8719ee1ccbe9	f
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	9749151c-c4bd-4925-b7f6-2e141385a4eb	f
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	d21bbe72-4cc0-4637-aaab-c6beafce7e57	f
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	f
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	2753e1d9-77a7-4059-8465-fa23a6b418c4	f
1512bb33-3ef4-4dad-af1f-47081a2a75dc	ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	t
1512bb33-3ef4-4dad-af1f-47081a2a75dc	b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	t
1512bb33-3ef4-4dad-af1f-47081a2a75dc	1343b2a3-ff3c-4588-a0e3-7372006e3cf9	t
1512bb33-3ef4-4dad-af1f-47081a2a75dc	424886ac-3b5a-446c-a0f8-2d2cd6474e44	t
1512bb33-3ef4-4dad-af1f-47081a2a75dc	ac70839b-f142-47ab-93cf-f21d06d1f546	t
1512bb33-3ef4-4dad-af1f-47081a2a75dc	1e15434a-7f6c-415b-bb60-f84f0edb53d7	t
1512bb33-3ef4-4dad-af1f-47081a2a75dc	38509398-011e-46eb-9444-8719ee1ccbe9	f
1512bb33-3ef4-4dad-af1f-47081a2a75dc	9749151c-c4bd-4925-b7f6-2e141385a4eb	f
1512bb33-3ef4-4dad-af1f-47081a2a75dc	d21bbe72-4cc0-4637-aaab-c6beafce7e57	f
1512bb33-3ef4-4dad-af1f-47081a2a75dc	b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	f
1512bb33-3ef4-4dad-af1f-47081a2a75dc	2753e1d9-77a7-4059-8465-fa23a6b418c4	f
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	t
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	t
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	1343b2a3-ff3c-4588-a0e3-7372006e3cf9	t
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	424886ac-3b5a-446c-a0f8-2d2cd6474e44	t
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	ac70839b-f142-47ab-93cf-f21d06d1f546	t
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	1e15434a-7f6c-415b-bb60-f84f0edb53d7	t
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	38509398-011e-46eb-9444-8719ee1ccbe9	f
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	9749151c-c4bd-4925-b7f6-2e141385a4eb	f
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	d21bbe72-4cc0-4637-aaab-c6beafce7e57	f
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	f
85f5e1a2-8c1d-42ae-97dc-b1c02c6f3188	2753e1d9-77a7-4059-8465-fa23a6b418c4	f
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	t
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	t
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	1343b2a3-ff3c-4588-a0e3-7372006e3cf9	t
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	424886ac-3b5a-446c-a0f8-2d2cd6474e44	t
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	ac70839b-f142-47ab-93cf-f21d06d1f546	t
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	1e15434a-7f6c-415b-bb60-f84f0edb53d7	t
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	38509398-011e-46eb-9444-8719ee1ccbe9	f
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	9749151c-c4bd-4925-b7f6-2e141385a4eb	f
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	d21bbe72-4cc0-4637-aaab-c6beafce7e57	f
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	f
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	2753e1d9-77a7-4059-8465-fa23a6b418c4	f
81fb0324-8f89-4cb7-bc31-8af536e10b7e	ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	t
81fb0324-8f89-4cb7-bc31-8af536e10b7e	b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	t
81fb0324-8f89-4cb7-bc31-8af536e10b7e	1343b2a3-ff3c-4588-a0e3-7372006e3cf9	t
81fb0324-8f89-4cb7-bc31-8af536e10b7e	424886ac-3b5a-446c-a0f8-2d2cd6474e44	t
81fb0324-8f89-4cb7-bc31-8af536e10b7e	ac70839b-f142-47ab-93cf-f21d06d1f546	t
81fb0324-8f89-4cb7-bc31-8af536e10b7e	1e15434a-7f6c-415b-bb60-f84f0edb53d7	t
81fb0324-8f89-4cb7-bc31-8af536e10b7e	38509398-011e-46eb-9444-8719ee1ccbe9	f
81fb0324-8f89-4cb7-bc31-8af536e10b7e	9749151c-c4bd-4925-b7f6-2e141385a4eb	f
81fb0324-8f89-4cb7-bc31-8af536e10b7e	d21bbe72-4cc0-4637-aaab-c6beafce7e57	f
81fb0324-8f89-4cb7-bc31-8af536e10b7e	b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	f
81fb0324-8f89-4cb7-bc31-8af536e10b7e	2753e1d9-77a7-4059-8465-fa23a6b418c4	f
d004af51-9d2e-47d3-9340-a3a411f42029	ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	t
d004af51-9d2e-47d3-9340-a3a411f42029	b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	t
d004af51-9d2e-47d3-9340-a3a411f42029	1343b2a3-ff3c-4588-a0e3-7372006e3cf9	t
d004af51-9d2e-47d3-9340-a3a411f42029	424886ac-3b5a-446c-a0f8-2d2cd6474e44	t
d004af51-9d2e-47d3-9340-a3a411f42029	ac70839b-f142-47ab-93cf-f21d06d1f546	t
d004af51-9d2e-47d3-9340-a3a411f42029	1e15434a-7f6c-415b-bb60-f84f0edb53d7	t
d004af51-9d2e-47d3-9340-a3a411f42029	38509398-011e-46eb-9444-8719ee1ccbe9	f
d004af51-9d2e-47d3-9340-a3a411f42029	9749151c-c4bd-4925-b7f6-2e141385a4eb	f
d004af51-9d2e-47d3-9340-a3a411f42029	d21bbe72-4cc0-4637-aaab-c6beafce7e57	f
d004af51-9d2e-47d3-9340-a3a411f42029	b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	f
d004af51-9d2e-47d3-9340-a3a411f42029	2753e1d9-77a7-4059-8465-fa23a6b418c4	f
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	t
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	t
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	1343b2a3-ff3c-4588-a0e3-7372006e3cf9	t
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	424886ac-3b5a-446c-a0f8-2d2cd6474e44	t
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	ac70839b-f142-47ab-93cf-f21d06d1f546	t
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	1e15434a-7f6c-415b-bb60-f84f0edb53d7	t
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	38509398-011e-46eb-9444-8719ee1ccbe9	f
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	9749151c-c4bd-4925-b7f6-2e141385a4eb	f
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	d21bbe72-4cc0-4637-aaab-c6beafce7e57	f
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	f
1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	2753e1d9-77a7-4059-8465-fa23a6b418c4	f
ba4de397-daf8-404b-ad79-249e4d09a713	ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	t
ba4de397-daf8-404b-ad79-249e4d09a713	b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	t
ba4de397-daf8-404b-ad79-249e4d09a713	1343b2a3-ff3c-4588-a0e3-7372006e3cf9	t
ba4de397-daf8-404b-ad79-249e4d09a713	424886ac-3b5a-446c-a0f8-2d2cd6474e44	t
ba4de397-daf8-404b-ad79-249e4d09a713	ac70839b-f142-47ab-93cf-f21d06d1f546	t
ba4de397-daf8-404b-ad79-249e4d09a713	1e15434a-7f6c-415b-bb60-f84f0edb53d7	t
ba4de397-daf8-404b-ad79-249e4d09a713	38509398-011e-46eb-9444-8719ee1ccbe9	f
ba4de397-daf8-404b-ad79-249e4d09a713	9749151c-c4bd-4925-b7f6-2e141385a4eb	f
ba4de397-daf8-404b-ad79-249e4d09a713	d21bbe72-4cc0-4637-aaab-c6beafce7e57	f
ba4de397-daf8-404b-ad79-249e4d09a713	b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	f
ba4de397-daf8-404b-ad79-249e4d09a713	2753e1d9-77a7-4059-8465-fa23a6b418c4	f
e85deedd-b2fb-47d3-acef-508423a77f22	ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	t
e85deedd-b2fb-47d3-acef-508423a77f22	b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	t
e85deedd-b2fb-47d3-acef-508423a77f22	1343b2a3-ff3c-4588-a0e3-7372006e3cf9	t
e85deedd-b2fb-47d3-acef-508423a77f22	424886ac-3b5a-446c-a0f8-2d2cd6474e44	t
e85deedd-b2fb-47d3-acef-508423a77f22	ac70839b-f142-47ab-93cf-f21d06d1f546	t
e85deedd-b2fb-47d3-acef-508423a77f22	1e15434a-7f6c-415b-bb60-f84f0edb53d7	t
e85deedd-b2fb-47d3-acef-508423a77f22	38509398-011e-46eb-9444-8719ee1ccbe9	f
e85deedd-b2fb-47d3-acef-508423a77f22	9749151c-c4bd-4925-b7f6-2e141385a4eb	f
e85deedd-b2fb-47d3-acef-508423a77f22	d21bbe72-4cc0-4637-aaab-c6beafce7e57	f
e85deedd-b2fb-47d3-acef-508423a77f22	b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	f
e85deedd-b2fb-47d3-acef-508423a77f22	2753e1d9-77a7-4059-8465-fa23a6b418c4	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
2c11e02b-7650-4ece-99a1-93b9ca1fac30	a8c3ceb7-00d3-4a33-ab6a-1ac9d6f7994e
b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	6d7b0d9a-0ac1-481e-aebb-8acd9d5c3e39
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
83a5cfd7-3864-4e0d-b501-f5fb090c209a	Trusted Hosts	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	anonymous
355c8b51-bd52-46a1-aa4f-92586641951b	Consent Required	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	anonymous
8e448437-4227-4f54-8907-84358db8abf4	Full Scope Disabled	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	anonymous
9417be0e-7bb6-430e-a46b-d20ee690ecf3	Max Clients Limit	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	anonymous
57891262-0917-4097-9d49-872664e5278e	Allowed Protocol Mapper Types	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	anonymous
cda5f44d-ebe4-4c85-9ac9-9f658aee8437	Allowed Client Scopes	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	anonymous
22aca628-1772-43eb-bd8c-5f1b6bcf4927	Allowed Protocol Mapper Types	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	authenticated
dde0ccce-5307-42db-b08b-7d3d769bcfe9	Allowed Client Scopes	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	authenticated
b673d4aa-a7a4-4a66-96fe-3b975d65e9e8	rsa-generated	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	rsa-generated	org.keycloak.keys.KeyProvider	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	\N
6d5b3d8d-6210-4035-a963-97ca34f77e21	rsa-enc-generated	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	rsa-enc-generated	org.keycloak.keys.KeyProvider	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	\N
301a2b1c-00fa-44c5-a83c-501050aee726	hmac-generated-hs512	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	hmac-generated	org.keycloak.keys.KeyProvider	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	\N
fd1d2c67-c41d-46ff-916b-25f8d86fc03e	aes-generated	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	aes-generated	org.keycloak.keys.KeyProvider	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	\N
b41a02e2-a8b1-49ff-8489-ccfbed2bd7f1	\N	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	\N
bf7bc4cc-455f-4d74-ac97-b854b8f126e8	Allowed Client Scopes	83b6664d-539e-4bed-a376-685d50e40b98	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	83b6664d-539e-4bed-a376-685d50e40b98	anonymous
4dfd41fa-a9eb-4922-a0cf-d4f7a8ae24c1	Max Clients Limit	83b6664d-539e-4bed-a376-685d50e40b98	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	83b6664d-539e-4bed-a376-685d50e40b98	anonymous
2feec9eb-9647-4299-86f6-bf7d63fe6ff0	Allowed Client Scopes	83b6664d-539e-4bed-a376-685d50e40b98	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	83b6664d-539e-4bed-a376-685d50e40b98	authenticated
740dc5dc-5940-4e77-8ddb-dcfc6530d78c	Full Scope Disabled	83b6664d-539e-4bed-a376-685d50e40b98	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	83b6664d-539e-4bed-a376-685d50e40b98	anonymous
f76d02eb-db36-4cc1-860e-363ac63254ab	Allowed Protocol Mapper Types	83b6664d-539e-4bed-a376-685d50e40b98	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	83b6664d-539e-4bed-a376-685d50e40b98	authenticated
b709991f-e23a-4086-99fc-952d2e499280	Consent Required	83b6664d-539e-4bed-a376-685d50e40b98	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	83b6664d-539e-4bed-a376-685d50e40b98	anonymous
6957a15d-2473-4793-90cf-bf7923e35fe2	Allowed Protocol Mapper Types	83b6664d-539e-4bed-a376-685d50e40b98	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	83b6664d-539e-4bed-a376-685d50e40b98	anonymous
aa39d65d-762c-4690-9154-219710f831f1	Trusted Hosts	83b6664d-539e-4bed-a376-685d50e40b98	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	83b6664d-539e-4bed-a376-685d50e40b98	anonymous
1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	rsa-enc-generated	83b6664d-539e-4bed-a376-685d50e40b98	rsa-enc-generated	org.keycloak.keys.KeyProvider	83b6664d-539e-4bed-a376-685d50e40b98	\N
1f601b2d-3f3c-4ee1-93f5-cd33a0c3c6cc	aes-generated	83b6664d-539e-4bed-a376-685d50e40b98	aes-generated	org.keycloak.keys.KeyProvider	83b6664d-539e-4bed-a376-685d50e40b98	\N
82d74645-ff8e-460e-ab07-a44369c80932	hmac-generated-hs512	83b6664d-539e-4bed-a376-685d50e40b98	hmac-generated	org.keycloak.keys.KeyProvider	83b6664d-539e-4bed-a376-685d50e40b98	\N
501abdae-a433-4e54-985a-a9fdf84bf3b8	rsa-generated	83b6664d-539e-4bed-a376-685d50e40b98	rsa-generated	org.keycloak.keys.KeyProvider	83b6664d-539e-4bed-a376-685d50e40b98	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
1d3ce8f9-aef6-4552-a61b-b7d19776ce52	83a5cfd7-3864-4e0d-b501-f5fb090c209a	client-uris-must-match	true
94a4e45d-ab5e-411f-895a-99cbd66e98dd	83a5cfd7-3864-4e0d-b501-f5fb090c209a	host-sending-registration-request-must-match	true
1869ec96-0b1f-4e5a-8c03-170838e54167	57891262-0917-4097-9d49-872664e5278e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
cddbf2ac-10e2-4800-aadf-4934a2d3a8a6	57891262-0917-4097-9d49-872664e5278e	allowed-protocol-mapper-types	saml-role-list-mapper
f11abbc4-fd7f-473f-9d3a-86468a330b08	57891262-0917-4097-9d49-872664e5278e	allowed-protocol-mapper-types	saml-user-property-mapper
7e8d9d57-e066-4afa-a5a1-ff6955c5ef07	57891262-0917-4097-9d49-872664e5278e	allowed-protocol-mapper-types	oidc-address-mapper
e6cfe68d-a73e-40a7-9ea6-5cc46c834f58	57891262-0917-4097-9d49-872664e5278e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d0669096-ba23-40ae-ae0d-77bf2554dafe	57891262-0917-4097-9d49-872664e5278e	allowed-protocol-mapper-types	oidc-full-name-mapper
38f15196-cc93-485a-85e1-5049d3a63664	57891262-0917-4097-9d49-872664e5278e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
89739be5-a404-4aed-a543-eb51b9361f3d	57891262-0917-4097-9d49-872664e5278e	allowed-protocol-mapper-types	saml-user-attribute-mapper
47044e64-8a21-4beb-9aab-158249b03c09	9417be0e-7bb6-430e-a46b-d20ee690ecf3	max-clients	200
b6c3a615-d921-4710-a31b-0f03847d3416	cda5f44d-ebe4-4c85-9ac9-9f658aee8437	allow-default-scopes	true
edb0c689-9c80-42bf-b033-02e981656868	22aca628-1772-43eb-bd8c-5f1b6bcf4927	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2bb4fc87-4b39-4db8-9bc7-c6da93510bf3	22aca628-1772-43eb-bd8c-5f1b6bcf4927	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0d863b5c-b57a-47a5-b495-26fa8b02d7f0	22aca628-1772-43eb-bd8c-5f1b6bcf4927	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
35fd9550-beac-4f3c-b2ba-4941f5792462	22aca628-1772-43eb-bd8c-5f1b6bcf4927	allowed-protocol-mapper-types	saml-role-list-mapper
a8d87811-df72-4d4a-93f2-fba7c6594e4d	22aca628-1772-43eb-bd8c-5f1b6bcf4927	allowed-protocol-mapper-types	saml-user-property-mapper
c6b9cc01-4c33-423d-88aa-05ae6ceb2d8c	22aca628-1772-43eb-bd8c-5f1b6bcf4927	allowed-protocol-mapper-types	saml-user-attribute-mapper
88f04868-2c4a-4590-ab53-732fdb5b9989	22aca628-1772-43eb-bd8c-5f1b6bcf4927	allowed-protocol-mapper-types	oidc-address-mapper
1127528c-e150-4596-b267-aecfcb860f72	22aca628-1772-43eb-bd8c-5f1b6bcf4927	allowed-protocol-mapper-types	oidc-full-name-mapper
ff6f23e9-e0bd-477e-aa26-893d29c11419	dde0ccce-5307-42db-b08b-7d3d769bcfe9	allow-default-scopes	true
95eadfac-c1bd-40c3-883b-f3cdc78cf5ac	301a2b1c-00fa-44c5-a83c-501050aee726	kid	5b26a29a-4745-41f2-994e-8fb766b154f9
5f193122-e5e4-40a7-9d70-ef6d17f8c6ea	301a2b1c-00fa-44c5-a83c-501050aee726	algorithm	HS512
1718ce6e-29f9-4cc6-8381-c3a937065970	301a2b1c-00fa-44c5-a83c-501050aee726	priority	100
748db3b8-21f0-4fd2-b74c-1d82c1e8e044	301a2b1c-00fa-44c5-a83c-501050aee726	secret	mKFegSB8ShFqBx4BO0oe2lc8I7fnFKuJU9vG1qSKPnP-0duqswmBWMCoq4qE8_GPc0sr6EyFskvuNEQP4wYesmFJSKjQXWvnSLEwk6TqIY2bvDkeG5UUGd4MuGO2BQYW9CADoQoDjo4i0bKtzO3OzaacyPZYizwIjV-JAcM1M7E
67f74b71-470a-4352-8a0d-b2c1a75a181a	fd1d2c67-c41d-46ff-916b-25f8d86fc03e	secret	3oKsLAA5qYP6EfUKy5B-jg
7d66a79f-4fc7-4a9c-962c-e71daaf5172c	fd1d2c67-c41d-46ff-916b-25f8d86fc03e	kid	cf932e47-cdbe-4e00-912d-ec01876da79a
70d81b5a-659a-4168-bff6-26b026b21bc4	fd1d2c67-c41d-46ff-916b-25f8d86fc03e	priority	100
93a5bbc4-2c85-4e73-98b8-1100308b9668	6d5b3d8d-6210-4035-a963-97ca34f77e21	privateKey	MIIEogIBAAKCAQEAkO3k8eMA1629rD61wNOjFCqfEanFYAggnYe4oMbfcb5p2sDkYD6sC+AiRQSiBkDu9DmYHx4AElfHS5BfnkjjOQIxOD5hud97sLgKJ5AYnsant77e0H1XwFvbuYTnKqISV4A2yNkBpE1b/g7CJbjkKylPg4839TWWU6uXHf72GdjtCo3ynRPCUy0U4pmB85pl4RUmVvMI1UEiQRQRK3ANfFGS2PuuhydXJV1EulEOvyHkBoLBE1IZJNcchNGzMcDOP0Dtx8AyC1R/BoG3uwnx9wH9qK+iqoyGCM3zrb1iKa5NtMTCEJqOi8GuAiIUHkqSHp1Zz7AhBLt95/nV8+ZNBwIDAQABAoIBADAJ2phe0RmsajFcu+wFeomlswIsztKM/xqYMReBs/DE19t9knVgcLCjA1jzNy1xeoMTUBwIWqe51sJyQW96424zDtOAwe3VaO9joWIJvk9qs48RQlPDKEIHcKZmqiUUgZXlVsNuQsAOME7e33WXenHgCI4n+7lYoNJtDvMPXs2j/NM9eA8OUvyW+lql3ch2OTRSi8zb5BGG3+kRxq/tAt1j7jehwAZmxt5TBRNt7DZ9j0tEL53vEF03y2CmgNF0xl/dzjNWLaE04v24KYAHvxDUAy77fJvVrA4CcGzYQhx1QBKuyUhhQ4LTRE6NrC73c3Rdx4fq92gmgpv2VWSJVwkCgYEAy4UKAAL8Wy1bUkja5QhO8vV9YeRdWdNDcxT4M3uXb56n3+W36EM/HNKCusgSOMh21vweD+QkJBmtyT1lZpGZnNog5A+OCgvYuM1Be/AOOO0x//wS2B00f6b5ZiYl34yUyTo97otIQQaIy/v6dQio4mBvPDnbcMJuMmWsLrlh5uMCgYEAtk0fOE1wXY5TsAg/XjVordNm1e5vKP+fdcgASuNKRW2sxIbGV3mf1Lnmmgn32UUrRYDcFbHpVMSLnWZY/YnlgbxglQyC5NgOtESxLQxEkzDUsWFAvtKQao5k9T5skS7WXJyTDylSxoZtRr0T66FzOd/Ais9SndCCaWC0qNU09o0CgYBCwDzaaiBI62RzZY/d5M64I0pfbB4uEvuhaDRL9nJh2sCmz9p05HFzy5uzFWHcm+tWcdSOU76C1KVKRsfWT1T5vBVjl7J3mxEW88NRmhegFjP7CLtJhLKuV56fIU30t1Ape9/KOIaXRURi2x93eUKjFQwGzdcqcarg/rXtkUIKDwKBgDucYFcSy2lsPuVS7RWrNT2R4RCXVPX9EHF9IstaI1Esmc/xmi3EcYUn/MXl+IutWIbzqgPWF0xGsLiZXQQa8VdI9/QFEVAvbi94Ps9SMaJH12ThPkCnrd2KDm07KlkXDbVe5Z+RjaWpE1aMQVVNh9Ym2lkJjiRYqCw5GRoUDauJAoGAdjcGx+iti+2eptLhqWjYVilC2ybPHriJExern3948Bv7jzJVmhVMELeoAsB9rINDyKD0BM8ykxkb3HevTtd6fdD1M3BI63Sj75INbA/RygbJ6iEb+zd3jvY9q5vQp4J4lfvYKO9TmtzRRL31zTUWitfHgKKpjp7O+M9+T6VCSgg=
18f636cf-d0f0-4967-b9e6-37852ae086fa	6d5b3d8d-6210-4035-a963-97ca34f77e21	keyUse	ENC
8aca32b1-7e0e-4434-b4c7-c50f951dd911	6d5b3d8d-6210-4035-a963-97ca34f77e21	certificate	MIICmzCCAYMCBgGbvz4GEjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwMTE1MDExOTMxWhcNMzYwMTE1MDEyMTExWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCQ7eTx4wDXrb2sPrXA06MUKp8RqcVgCCCdh7igxt9xvmnawORgPqwL4CJFBKIGQO70OZgfHgASV8dLkF+eSOM5AjE4PmG533uwuAonkBiexqe3vt7QfVfAW9u5hOcqohJXgDbI2QGkTVv+DsIluOQrKU+Djzf1NZZTq5cd/vYZ2O0KjfKdE8JTLRTimYHzmmXhFSZW8wjVQSJBFBErcA18UZLY+66HJ1clXUS6UQ6/IeQGgsETUhkk1xyE0bMxwM4/QO3HwDILVH8Ggbe7CfH3Af2or6KqjIYIzfOtvWIprk20xMIQmo6Lwa4CIhQeSpIenVnPsCEEu33n+dXz5k0HAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGFj5r2H9BVWINe7Ue3wryyWLng5GVXLa/EhVAFUSPgKYCFuIqaoYPmhzOOSbTGPjbTgq1mzmmynilYH+6sod4Nptm0AfiL4q6UUKqrTV0Wx2VnJffA8baP5b2D0DS4dwDmaGDyRD3bbKNHQa2veWzsyfPHVi0wKmdYPiWR9H5gLvFztVvC4S4l/FELfhgJi8tky8VvfZlzGOFaY/whF2rJp/SpBKwinJX0jMnEchWYfhcR8n1pjTeqBSNzONUt0U5m8NLINhIFKuUlS6cAT7XV408sW7sujjan2O+FoUCVyLFmxYhzA9CBOmfAGzNRGgdYIjY/JS93HEUhoCu5SI9s=
13160dff-6c6d-4597-946c-3c37bc507bc7	6d5b3d8d-6210-4035-a963-97ca34f77e21	algorithm	RSA-OAEP
ab2f74f4-2c32-49e9-9514-cc7029f0e99e	6d5b3d8d-6210-4035-a963-97ca34f77e21	priority	100
503cb53f-d1e9-497f-a56a-66f7c9e9950c	b673d4aa-a7a4-4a66-96fe-3b975d65e9e8	keyUse	SIG
f9ed2bc3-826e-4960-a39a-e6ae7e811bef	b673d4aa-a7a4-4a66-96fe-3b975d65e9e8	certificate	MIICmzCCAYMCBgGbvz4DrjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwMTE1MDExOTMxWhcNMzYwMTE1MDEyMTExWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC0xbOSHDgJoIn0HBvL30gkm3I0b8NNadY87bKyvm+KblT08jI8s7evTBNxZi4TIDGiG2XpMtYYDOY4oNok/2WDtnRobUMeGX8atkTCz/5SQteYo4s5agGQlzkG+PCMzaN5aKu+8Gg74+bwsFVNjDGXWG3IASQaK2qFgZ6yXNnM3iX9vKztRyeweM65yWNUQ9xQpHjsWnCl+3DyyDdr9uMCbVuBQ6Iyf6hp6uSD4g3NjLzYbChEvMMkb9dTB+g04KDa/tkz24imV08/Sd/AAqdQ7nF9t9wzMCH/LUjIVdcWKFuJu08UL0jyOm2B6ld6p/tDhZjVLg2UAdBPV3AW7berAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAExlAKvLpRoj2JKbRWuTRtyF0BQAPVx0ag6bYOam2l0tS5Wk1Q2Vk5cJX92UFOc1wFPJm+cESBw08Z8gDjAZ76YNu9FPDnoexrjaWOz4sZ9BZWUT6V3tHcC6hHdTTudGEuqUOF2pwiVg+98enAkM7TILJRWRHz9GCHTnW5tqqmut5iLKzI/a2JnB357kYwWCOeAXXOpMgM5MQiEGzyTMcl4LH3ygc3End/KT6doFccOELA/4ENiv5UxOhXCkdS0sBSxCi8m/HRkMpJx1ayUZsd+q/T07ha9eKs8BbVWeR+/lpfg7K34beN89gTxvp8PSAvWZUvsPcWvoWNkhxcvegTE=
545eb61c-150e-4791-804d-ba08613a764b	b673d4aa-a7a4-4a66-96fe-3b975d65e9e8	privateKey	MIIEpQIBAAKCAQEAtMWzkhw4CaCJ9Bwby99IJJtyNG/DTWnWPO2ysr5vim5U9PIyPLO3r0wTcWYuEyAxohtl6TLWGAzmOKDaJP9lg7Z0aG1DHhl/GrZEws/+UkLXmKOLOWoBkJc5BvjwjM2jeWirvvBoO+Pm8LBVTYwxl1htyAEkGitqhYGeslzZzN4l/bys7UcnsHjOucljVEPcUKR47Fpwpftw8sg3a/bjAm1bgUOiMn+oaerkg+INzYy82GwoRLzDJG/XUwfoNOCg2v7ZM9uIpldPP0nfwAKnUO5xfbfcMzAh/y1IyFXXFihbibtPFC9I8jptgepXeqf7Q4WY1S4NlAHQT1dwFu23qwIDAQABAoIBAAhcSGTOh0zyrs6qaiKwre57ffms3ZR7+5uPxr77jb8SQT2e4fHqwekKlK+e8SyTRZhgugLiBgLQvekKj2w8n55K1vFpdDw1I6rBmUaFRhbZ3ozBq5O5Ml9Ujx+ibcWlURUxYRgQmFGExc6F6TwP6s88GL+yRdAsB94q04MeRjhyTdh9vvEdiLNaYlq6YwBOQd085mcmUL2rcQ6aTADmq5L7wTlRKvxAZc4hlBDvDpxSWp+JWJCDMts2YnzOj1bhGbTYTBcAdxZOjVBS8tTn2r5T1KKmKxTyAA4mpiDD0LJZZB2GJbnl5AUnoFG35SPM4DDeKLcuGPoa5+exrG4N6oECgYEA3puPLvrpNNcFa29C/R+e9v7E2twT/Yd4JylWD4mY4glPX/OtCR+Mec8UTID2XwhyHNYz6O3hQ6sDbKXWFJwAIRJbBH06ror+ASi3urUSiNjzdwSmAcVExbDLQVLEpB5I47YNBamFOaCfwC/Tyfa53Wp0SAYVQX8SYwFhLZFWrGsCgYEAz+ObFdGOXC5pMV2M7PI8fPgcoNi5U0dgWDnVQuUY9ZmmHZWp1FR1f/rsB7Wg+TtvrnXu7VcL3NpdJ5lCB9dXM4U9eF9rCwdctyrnWi5E3NPTM1vc60/YMB7bSnxpzS3rl1Z88NBNf3qDU2ztr5QlL4WXTil8R0rqW8VBgPYP8cECgYEAuI7iTEIMnRl0TdlGAdR4mDErhoSWMklhjZ5Q0rryvNyZKWU+3eSBM/BC1RbKrIm1CkFxcjne3JppUWfAsP+Rf9nXCkbFIzbrVoyqnypGvpyYZeG9vJQP65MjQPpdO/A74EbsTvh4EwofyFge0EA1YuRCmgApGU9AMENRjVUFNhcCgYEAs6AzmYenHUlQxUHTCc1IrKZpfiWlBCsxOSpHdfSkO1pWqUtvIbMUj8+M8CBlBdTwa+sk1liXPG5FfXi0EDhl9XNUKNUxlab32qCspEREZhZ1b/QZEA2+e929lz+m342k+e/WJvGldNez73q4aTR1aPliQjwgUS2PEFqBfd+e6UECgYEAyaKLRz8W3MhVf9tbJ2gDbZgGWgMYLqPetDdbGiaHNmMalSG/banPnc4N6yPNmBDPCwjLKdTvWksTA4zDArpdi49CYCIOLMX3QtD612CqiNj66U20ugF4KrEPKVsf4nQBIpV4OGbIKe/SKjG/X59HUwYklrMklM7tfVnpiFziPKI=
e1b01b20-6e0f-4967-b585-228ad86030df	b673d4aa-a7a4-4a66-96fe-3b975d65e9e8	priority	100
e13d0ca2-1338-4411-971e-adc60581c139	b41a02e2-a8b1-49ff-8489-ccfbed2bd7f1	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
b8aeed6c-9a67-4119-ab93-1847b86e0789	1f601b2d-3f3c-4ee1-93f5-cd33a0c3c6cc	priority	100
c5cf76d8-ec79-4a6f-aac2-036b20fdb9fe	1f601b2d-3f3c-4ee1-93f5-cd33a0c3c6cc	secret	jGKBzJa7FSua3xfWVN9caQ
d78663ed-2936-4411-b603-8d406d59effa	1f601b2d-3f3c-4ee1-93f5-cd33a0c3c6cc	kid	3ed0052c-1007-4708-82c0-3497b75085c8
36bbfb35-4f21-4654-b928-166504cd0e8f	bf7bc4cc-455f-4d74-ac97-b854b8f126e8	allow-default-scopes	true
571f4b9a-9d63-4857-addc-bc0ad9984fb7	82d74645-ff8e-460e-ab07-a44369c80932	kid	ebb575e0-6a98-447c-97e1-37c876a2e327
5253d60c-26e6-4777-92d1-1c08e10b1d78	82d74645-ff8e-460e-ab07-a44369c80932	algorithm	HS512
6b95d3e2-87e4-4d53-8d4f-4c68dd44e19b	82d74645-ff8e-460e-ab07-a44369c80932	priority	100
00c5b0b8-3b60-4f17-9acf-a41bb95238ea	82d74645-ff8e-460e-ab07-a44369c80932	secret	mKtc1ZS1Zure5wtquXmZDQJiuhiDEWLpBWY2phgKVV27UO-Oga5WRLy8sRhbO_zKE7UHVZDOwZRroPWvhZD2lsJ1YSaSrZb0yf_9hRKthz4JcGYdOqDVI7w76zdxtHhq9dkkCqgAmOdj7iYiYu7oBBcwd6eWuaHtnIi_q_3j8fw
e6993776-07e5-4c90-ac72-5ccdd4507950	4dfd41fa-a9eb-4922-a0cf-d4f7a8ae24c1	max-clients	200
0d266a39-25fc-49eb-b3a6-5768f68f2c68	2feec9eb-9647-4299-86f6-bf7d63fe6ff0	allow-default-scopes	true
88dd87fe-956c-43c7-9815-106a80a9dd36	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	certificate	MIICozCCAYsCBgGaaGXlZzANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDApsb2NpLXJlYWxtMB4XDTI1MTEwOTExMzMxOVoXDTM1MTEwOTExMzQ1OVowFTETMBEGA1UEAwwKbG9jaS1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANQKCIs2FpAGF4Nv3iZZT3nktpgcqcNnMdS6z7pG6wBazB7ypfgLCih6+eaDz+J/WR1jItDWZvaSHQV+o5ujmLJu+nAdRz1I2MsVPYsH9q4+ZBzgFUaJ/9QQQF/r92oF0KDEDOErJIvrZhc4WGVMjCS+OJ2W/VaOrdv6azofbkLiUrGjTEaYJgnFfD8DYyr+RvKZvXb1uCkgv7Ay8fVWGHvoKkw4S87vg4d4DKA/HzFZyMOXOGUslinG5MMIfMHFFUX2SfRrAvmXcOOKNcjYB0EhTiLyI5MMltcixTmziX+YOeXN6fZaruJ5U8HLqR5HRopldVoF9lz5zMbiuCzv9lMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAkYztEr6baQvXYMCHk+ERJKvcAcPC+vJem/CbgAPvkVafToIUxnGOJbLU/MjZMqt2qLxwwfYtcucylE8PoqfjKhW7rImCJPQjezrPtoWoDPzEJ7JCxWoWTlpjSvlprf6zBTt+0YQ1by8OpMK+6WRvJtoNOqzzodpQ9DaqXWYxJegfU5F7bK9pVTyT3J46SIydmnX8Lfwsu+4j5W0kl91DuN1kxLb1294TogP0ERfTtCI+r8KFHGc+1SbizF1bCbpeT9VBWcfSBhyGh1UhgCsSPl9R+9xIRKPoIMmaGZ77pjJ/P7AFvu4LXa5DKgMcAsE0K84fIvC2Xa9phDjNN3zXiQ==
edc447e2-a2a6-45ed-9bec-c6112d2f2063	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	keyUse	ENC
c5e3c7dc-1cfd-45b2-b0f4-e1790b4585cf	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	algorithm	RSA-OAEP
071f1d0a-f70a-4575-a20f-eb89a62243bf	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	priority	100
c5aa6c3b-87c6-4376-a3fc-80181299c02a	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	privateKey	MIIEpAIBAAKCAQEA1AoIizYWkAYXg2/eJllPeeS2mBypw2cx1LrPukbrAFrMHvKl+AsKKHr55oPP4n9ZHWMi0NZm9pIdBX6jm6OYsm76cB1HPUjYyxU9iwf2rj5kHOAVRon/1BBAX+v3agXQoMQM4Sski+tmFzhYZUyMJL44nZb9Vo6t2/prOh9uQuJSsaNMRpgmCcV8PwNjKv5G8pm9dvW4KSC/sDLx9VYYe+gqTDhLzu+Dh3gMoD8fMVnIw5c4ZSyWKcbkwwh8wcUVRfZJ9GsC+Zdw44o1yNgHQSFOIvIjkwyW1yLFObOJf5g55c3p9lqu4nlTwcupHkdGimV1WgX2XPnMxuK4LO/2UwIDAQABAoIBAGAzOyQZwovOT72ws9u3OmElnJgPrQ+70nZe2R78zOLIzwIdeaI7M/0gqh9k3xy2RVKZZzLTizxEF0mmZokW5JDT2+igx/Dsi3s75EOfNdJg+R/GpLBvrLNkOiiq0IH4KGq/983yum6Gurc/N4+h9pU2/k21MrQiIIwEpcBlgStzWd3TMlWmSy965bHkF/wET9RrIMR/SWIfgg7nm7lK+VGxVyJay15639EHd7x/rdp6LiBG2uIipZD+NA6WLuOZG86toDUcPas9Di9mkGm2EW3GAxaSz9T47CdJr5hcX7F5CqBn6tnbY5ssJnwi0HUF203Bc/6Z3wh7NGAyGxzMXxECgYEA/3WJ+vIU9K4JWgNFzfbz46rtCOlRgepCeYtoopfHBfkO/cxyK3/SBB1SUt5yWzp/sr6sADXl67932wuxtZozFBC+UKEUCDPK/Qs1TctG/KjS7mdgQvxXt6TpT9C+kTvyo8L9g+rdMrQ8Cs5qtajWaVv/ohMhqfWFk6Apn1p9kTECgYEA1Hz13YrVwyrkBGb0fjW2b09qS9FuLX6WDaR9WZ3GA9APTz4K+zYWtNFfUHwufhO4Z0zxxSlyaiwClRSuJFhFk4DgxB1mUv0wHtPppY8f0jKcnwS3JDL7K4DQ9T5suA21Zt9zUemrMwA+WM/TghTvXplHHtuUhv/fHYglx8QIvsMCgYEApwrOzN8bQNvEla1qKcH/vLF6Cce3WoI6MYwtQZSJuaggW2kihrswMyyRNkrq8CiSc+kmQ4T68WrkDsHY1G0eVVKVf9e0Z6CmbUy08EeqBXDHbMkAMw0atqUJQv22fvV6Ngc9CtO7DHq6gD51nI/olEBqKirkamR3kg666M6dKSECgYEAybvJgQeqYpx51mQYgypjhdITzN+MhszDkTg1ebt8n2oM3uK8cjur2wdcQoFjcncuf4RhlRoAciROX1M+8WqMw7l7qzVuTCPsZ5gxHul/AITkhWRoq4lrRKYLvIoDlcoOCxjh10bNLqJwjsjguYM+rsU+7GDz5idOoC7+D2ZiFxkCgYAns+C2iIbw4M1w3NSFeeVwVDzwSW0c45CNq8BqA1fKqjzS11zmrI5162e+zJI91uF32k1hbWAgrxZV0KuBS+NIhX0hf2nmiTMm3KrGSvx0MLwxX41qPHD9OMW35rzXdXV8scMHkFanJnqDzfTijvCRO3CTqxhnxr36ZEIsdJ7uAg==
04454d41-88d8-4882-9efe-6aaeeeba9c59	501abdae-a433-4e54-985a-a9fdf84bf3b8	priority	100
379e5e3c-5687-4c8c-af75-5c5ec09b3680	501abdae-a433-4e54-985a-a9fdf84bf3b8	keyUse	SIG
571e552b-0653-4321-a98e-4d57808fd38a	501abdae-a433-4e54-985a-a9fdf84bf3b8	privateKey	MIIEoAIBAAKCAQEAurT5Qp6fpzYk5s0r5rvsltqBiyMI1fI5ag2XO6Un6gnbuhJMt84ylKEU0QlT844Wmp2+iWwwklGHz6j1NSsqFYXUyTDLXukpsLfFR5fzcetWJ3FNiwQGRuodRRHFh9pvh85gPkFSRvSI6iSqSrYNSjDClEpEjH5S9Mn8UgETFlsHrqsBQCLFGOxUzuUNEe7txAT7dkSGGxZKd+qyxZGFLxnn4PT6Pc82qN8f5ZS6zkKHjCk+zea6IcdLbpmnNnoThRrMdmDfZDHLiRKrX/wHbhy+dm+K5Z+qj+/+d6+G29PgXb7z8i06YEFyYllDlzUt8pW2+eCmzZjywJcmALwbJQIDAQABAoH/MTI09Wqj60VjL2N9sbFtbgt+FuwVI3/sradl2WC/kKw9jSzVtpFcrkvnACD45KjQZ9Pzp8OEC29R04v9nos6yu/EvvKdxMxm3rov0eA/pcJLOsW+ioodA/Vn5HykSOhkLuh7x0l0EPI1tG/be+2JI2jMiPzvbk1hR39jl5rjkqxWbxwtZw0W9zY37rR2GXwmHdFbYQgDXf73MeE6/K6bbQa6sxvSftyf/W0nTDpVPWtLtdbWb2R1zLWbwslz3rhgdkWGJ/1HakIqunHW6O5eoiG/x345aqp9zo7HuJVG5+tsLfG0zQcxvRxgWSuiMZ5MLz6gdqMBga9wQPDL9WWNAoGBAO8qyXzb136/Elncs8knoIQgdMREoAw0YIZWvQB3m3swN2G9WE2oZJm/ObEAlLlIuu/ngPna/N6MYcePqt5jL4I2sMts5SGF2nP68Ta0TQ+Lldk8jklqnO5OEKNmoQklRWcIa9yBrgWn0lE6y8cYm5fMqXN8P2+/Y5HoKUPtGL5DAoGBAMfY+wpH4mAZ9OYu53BIOQdjqVw/YxKFxNky+YGfuAB+Jy+qoivGVgPnwq+YBsfVmpoB+HEl+Chyj0DHwFueXkJ+8Wcoo39/1DZ2zhnSIRNQfDNOfcfamuz2wsmlChoy+TfqHvUftCrvHOQ7Hu7+fUTBt/X9xoy/KEj9xKQVnA53AoGAMYhWBHLvdYOTBGNuJLn9R4AFTuS7lOuAFjJ+oEslO2UoAykY0bSPaTwucZciNiF2/dqfXp/ZASpn0dHSXI6EN16mTOs3pTK4pI6TSHYdA5wwI7aj7VaUO9KVJZJKxb8fWZBn7lo5NVileUdJDunsx4qOialw5e7oaz5+1V+UYUsCgYBAnEHtPPhPIZUvphJlFrR5Uxs6G7QoFN9jaTuJUN3oKuD4ZC4yANlmQdOLeZcXnFNzXxe3XRMx4He39dyWwkivLuNU+qqBWg593UMczfari+XboJDBwEc+PTkUgCsX9UrlbOe9UBarmsq4bvS9R8GwLQEQoo9Cibq4fnLIqcPeWQKBgAfVN/KUA2Fmh3Sjv8T1vdbkVo5Qsgbe9TeLbduBNqL3GunExhuLVg5tgsIkDDbSA8RuWoHrSqbIsYiRcIH9yPn5X13NM/uir0UrLu963opWpN0b9lftUbeByyY2gAUq6l9bGWb0RWSCXIPeB6F4HAa8vM2h5WadRv+SWQ2Gu/YR
99df4534-22be-4656-bbcb-58b3902e8f4f	501abdae-a433-4e54-985a-a9fdf84bf3b8	certificate	MIICozCCAYsCBgGaaGXjJjANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDApsb2NpLXJlYWxtMB4XDTI1MTEwOTExMzMxOVoXDTM1MTEwOTExMzQ1OVowFTETMBEGA1UEAwwKbG9jaS1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALq0+UKen6c2JObNK+a77JbagYsjCNXyOWoNlzulJ+oJ27oSTLfOMpShFNEJU/OOFpqdvolsMJJRh8+o9TUrKhWF1Mkwy17pKbC3xUeX83HrVidxTYsEBkbqHUURxYfab4fOYD5BUkb0iOokqkq2DUowwpRKRIx+UvTJ/FIBExZbB66rAUAixRjsVM7lDRHu7cQE+3ZEhhsWSnfqssWRhS8Z5+D0+j3PNqjfH+WUus5Ch4wpPs3muiHHS26ZpzZ6E4UazHZg32Qxy4kSq1/8B24cvnZviuWfqo/v/nevhtvT4F2+8/ItOmBBcmJZQ5c1LfKVtvngps2Y8sCXJgC8GyUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAjNmlykEGuC6D4Gd90FsdRSFnxyKHMfRv7mjBXhjm6uH3RnVx0IiXlb80n2mWJBfXaEV+z6OcmOii1dlSR3+QvsfxnmKUTu6OMD8hqKmAvcBrK87XWPU3VrU+1clnG/AvuhzTMfx+SyptkeyH9nGfbxec2Pk86dc4qJTr6y5qkv6kP9K5wHZPSo0qVxhnk81N+dLl+h9sxgZSY2LkH+WwcQXN36YUWxG7RUZYm9JCxw5utJCPILspDxqKLI4R6gxJ9uV/UBhhqAkaEP0qR2oKmOwxJVwCr4O2WPbU15P2L9h/69za69ipgxRDiSerDoNOvLq4C3O4hJ607ktYIHLzIw==
b3198d2b-defc-49ab-9c01-8594502c0824	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-full-name-mapper
dafd5248-a184-40a2-989f-8439aca35300	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f86c204e-2214-4903-aa8d-714140c0e549	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	saml-user-property-mapper
819caad4-918d-49e9-851a-7331194da19d	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-address-mapper
edbad999-04b2-4b96-b7ca-aacc5b15ca0c	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	saml-role-list-mapper
111a404a-0e60-4ac6-bc69-23649a0dc294	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	saml-user-attribute-mapper
9ff88119-0d39-4e83-b1a2-afeb5fb7ade0	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
df932e03-84ab-4d1b-a6a3-fb0cdc33c176	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
7f0fd5ee-447d-4322-bf76-fcc9dbc3da94	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
ed14a704-8ceb-45fb-a9f4-99ee4a2d49d2	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-address-mapper
1ed42883-b348-4a7d-9367-0cb7e66672eb	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f1191cd3-3cf1-4d32-944d-d1685de533eb	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1a21d07c-5bb1-440b-a520-55594377e463	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	saml-user-attribute-mapper
d27be936-979e-462b-8067-28677940b646	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-full-name-mapper
2df7fcf5-06e8-4bb7-b2ba-5c16dd7966b5	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	saml-role-list-mapper
03406319-9030-4ede-b198-31e0416234de	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	saml-user-property-mapper
46b3f68e-29e1-4fde-97db-b175b3420909	aa39d65d-762c-4690-9154-219710f831f1	host-sending-registration-request-must-match	true
1580c11a-7b5a-4f38-9f7b-f17bdc1d2f61	aa39d65d-762c-4690-9154-219710f831f1	client-uris-must-match	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.composite_role (composite, child_role) FROM stdin;
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	5f5f8502-a19f-4f40-97e4-bf7c0dfb178b
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	eb37c1b3-eac2-4536-b370-b8ee1562ed69
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	4f51b825-45ee-4b16-b714-dfcdca2b9da1
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	084e8340-4f8d-45e4-9cb6-c93bfb85dc47
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	ff703863-a1b5-4ffc-81cc-14b4222b2b82
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	fc022640-30f7-4fcc-9f3f-2cf83bcf46cf
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	8bbd5cf5-5324-45b0-a295-2639de132c2e
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	11d16cf1-7d2a-485b-bdf6-381e940cc0a8
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	7c513fcc-bb17-4c69-84f1-3f6cadac1d8a
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	0033b382-dac8-4686-80be-d81a56165697
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	78b73522-b25b-42b7-9059-75f30f3a88ce
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	bfdba175-612e-418c-a6ee-90de9407183c
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	a78b927d-2949-44ff-82c6-01945599a76d
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	173b1ba1-b3c2-4e7e-a646-e587041601f4
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	50b85b76-5ea0-4457-8218-167e7e482498
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	40c380e7-8dfc-4ce5-ae5f-9b56bd9dbac4
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	3ee51e00-afd1-4274-a18a-3969a5e14ca0
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	38374784-37f3-4c03-b3d8-7114c0d1430f
084e8340-4f8d-45e4-9cb6-c93bfb85dc47	38374784-37f3-4c03-b3d8-7114c0d1430f
084e8340-4f8d-45e4-9cb6-c93bfb85dc47	50b85b76-5ea0-4457-8218-167e7e482498
364fc902-cac0-422a-b35b-6118125dd0a2	f5df779e-e1db-441c-bdda-8422cd069442
ff703863-a1b5-4ffc-81cc-14b4222b2b82	40c380e7-8dfc-4ce5-ae5f-9b56bd9dbac4
364fc902-cac0-422a-b35b-6118125dd0a2	c87dc21b-1a54-4193-901b-4c533c2e531c
c87dc21b-1a54-4193-901b-4c533c2e531c	fac6bfa7-f1e0-40a9-a0a5-ed9f84691575
ab779578-02bc-47f6-84cd-d4b34905904c	f7e05263-9fa3-4103-bea2-00fc887e024d
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	8b02cbb8-af99-4db2-8910-f569cc6dc896
364fc902-cac0-422a-b35b-6118125dd0a2	a8c3ceb7-00d3-4a33-ab6a-1ac9d6f7994e
364fc902-cac0-422a-b35b-6118125dd0a2	31b5b8b7-6047-4db5-a1c7-ebd0ccc9239d
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	d67481b6-be3c-42b1-9731-c3bd89bf5944
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	6516fc70-d950-4abe-a395-4270844dab78
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	64e58440-12ea-471d-91c8-391ef312c668
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	908432ec-ac3f-41a3-8933-b54458214d97
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	a763ed91-e817-4720-9af3-84f5557e2b78
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	268a5b97-42e2-4d11-9850-3a44b349f17c
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	bee838ca-84cd-4361-b837-b1728fba9d6d
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	30e9401d-42c8-4cb4-ab0f-327b0933c963
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	611419cc-e037-490e-b6fa-b52bf2ae705b
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	0104f6a4-a938-4165-b74b-d0979a1fbabd
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	5366456a-b152-47a2-8e4a-d869aad68810
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	ec25d93c-d6b4-46ca-a5c0-6438bfedd128
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	f78bcf7d-9956-4734-babf-651c0428a3de
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	066855c4-82d9-43ea-aed3-88b30d43d46b
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	9e366230-72db-46b8-b2bc-75e192b1bc5e
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	be427f10-3ebb-432a-a367-8b6f4ec2c3c3
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	1b88d344-e5a0-49ff-8faf-52e50386201e
64e58440-12ea-471d-91c8-391ef312c668	066855c4-82d9-43ea-aed3-88b30d43d46b
64e58440-12ea-471d-91c8-391ef312c668	1b88d344-e5a0-49ff-8faf-52e50386201e
908432ec-ac3f-41a3-8933-b54458214d97	9e366230-72db-46b8-b2bc-75e192b1bc5e
221f3b69-a59e-4a34-a95a-71f10cef4e0a	0cf5be44-ba63-47c2-b752-662ef0a5885b
2e0714ed-6fbf-47eb-ae88-59ce44d6ed3b	b39c73a7-84b1-40ff-9fd9-6f314c9ede7a
4009714e-eefe-46d4-9b37-639a6edfa501	7d52ab89-86c3-4b57-bab0-02bbe460212e
4009714e-eefe-46d4-9b37-639a6edfa501	38244948-f337-4b8b-9c15-fdc672bc80f9
710ed846-759e-45bc-afa4-bb5ef183d08c	4862f2b4-4e36-42cd-a524-6dddbb43e551
929392ee-0474-4ed0-a64e-9b0132025c91	eb9be962-f203-49c6-9075-ce80642bf363
929392ee-0474-4ed0-a64e-9b0132025c91	5df2f1e3-7508-4fbb-889f-c8b70f84ec3b
929392ee-0474-4ed0-a64e-9b0132025c91	f24cb736-a373-4bd6-a34a-ab059b81f98f
929392ee-0474-4ed0-a64e-9b0132025c91	710ed846-759e-45bc-afa4-bb5ef183d08c
929392ee-0474-4ed0-a64e-9b0132025c91	6d7b0d9a-0ac1-481e-aebb-8acd9d5c3e39
fd6368e9-9e26-469e-8d79-707f3c20354a	5160c2df-3ab3-465b-b113-a61e60faf3bf
fd6368e9-9e26-469e-8d79-707f3c20354a	7d52ab89-86c3-4b57-bab0-02bbe460212e
fd6368e9-9e26-469e-8d79-707f3c20354a	995efc57-65a8-4262-9f91-7b9d83580c90
fd6368e9-9e26-469e-8d79-707f3c20354a	b1939686-0827-4787-a141-9e7dd5fc1b82
fd6368e9-9e26-469e-8d79-707f3c20354a	8f94747b-5e4b-4d79-bf0c-cd4923506035
fd6368e9-9e26-469e-8d79-707f3c20354a	a7120f7b-a46b-4f6a-9e97-0eea0f64174a
fd6368e9-9e26-469e-8d79-707f3c20354a	808637e3-7023-4d84-a56a-4f51c7ec23c4
fd6368e9-9e26-469e-8d79-707f3c20354a	221f3b69-a59e-4a34-a95a-71f10cef4e0a
fd6368e9-9e26-469e-8d79-707f3c20354a	ae3061fa-e4e7-4bf4-a3af-ca8d12cdb57d
fd6368e9-9e26-469e-8d79-707f3c20354a	4009714e-eefe-46d4-9b37-639a6edfa501
fd6368e9-9e26-469e-8d79-707f3c20354a	fdf28825-1691-44e5-88c3-2c8c9a0aa41e
fd6368e9-9e26-469e-8d79-707f3c20354a	4e989ddd-8be8-4533-bfde-cad630193577
fd6368e9-9e26-469e-8d79-707f3c20354a	ffb45a5a-3d46-434b-910a-2894fae5d4d9
fd6368e9-9e26-469e-8d79-707f3c20354a	dd7c767b-2b46-4089-a64a-97fd1456b645
fd6368e9-9e26-469e-8d79-707f3c20354a	38244948-f337-4b8b-9c15-fdc672bc80f9
fd6368e9-9e26-469e-8d79-707f3c20354a	abfd79ad-9ca7-4f0b-b54b-78a9c1e9f28e
fd6368e9-9e26-469e-8d79-707f3c20354a	6bf59d64-e73b-44b6-93cc-75d66c644214
fd6368e9-9e26-469e-8d79-707f3c20354a	0cf5be44-ba63-47c2-b752-662ef0a5885b
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	01847a85-8e88-48ea-a298-acc82a541d4f
\.


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.contact (id, created_date, last_modified_date, blocked_by, contact_user_id, user_id) FROM stdin;
1	2026-01-14 08:32:44.965955+00	2026-01-14 08:32:44.965955+00	\N	121	131
3	2026-01-15 03:19:20.642324+00	2026-01-15 03:19:20.642324+00	\N	121	124
4	2026-01-17 08:50:01.058608+00	2026-01-17 08:50:01.058608+00	\N	126	121
5	2026-01-17 08:53:04.505749+00	2026-01-17 08:53:04.505749+00	\N	129	121
\.


--
-- Data for Name: contact_request; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.contact_request (id, created_date, last_modified_date, receiver_user_id, request_user_id, status, public_id) FROM stdin;
1	2026-01-14 01:06:03.619861+00	2026-01-14 01:06:03.619861+00	138	121	PENDING	c71233a2-b7f5-4b93-a6f9-5d459b1966d7
2	2026-01-14 02:41:56.1466+00	2026-01-14 02:41:56.1466+00	123	138	PENDING	106ac84b-d6a9-4b7b-b732-0503e4f5d1e8
3	2026-01-14 08:32:21.546028+00	2026-01-14 08:32:44.979142+00	131	121	ACCEPTED	ae672bb9-4251-49c9-af7d-68bf5764f96f
5	2026-01-15 03:18:37.681661+00	2026-01-15 03:19:20.645035+00	124	121	ACCEPTED	083cf3b7-4f10-41c9-8055-3fd15837f230
6	2026-01-17 08:49:32.579267+00	2026-01-17 08:50:01.074645+00	121	126	ACCEPTED	3228c223-bd35-4050-9704-679beac15310
7	2026-01-17 08:50:38.488695+00	2026-01-17 08:53:04.508344+00	121	129	ACCEPTED	6f7a91c0-95c7-4ae4-8539-1980ecb60089
\.


--
-- Data for Name: conversation; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.conversation (id, created_date, last_modified_date, creator_id, deleted, last_message_id, public_id, conversation_type, last_message_sent) FROM stdin;
1	2026-01-15 03:11:59.964041+00	2026-01-15 03:11:59.964041+00	121	f	\N	e6708187-60c1-452d-944e-c958bd3035f7	ONE_TO_ONE	\N
2	2026-01-17 09:34:57.094032+00	2026-01-17 09:34:57.094032+00	121	f	\N	550797ef-5b9f-4efc-bc79-33f2ff3d7741	GROUP	\N
3	2026-01-17 09:55:25.159092+00	2026-01-17 09:55:25.159092+00	121	f	\N	9803ca71-7356-4393-9d3c-ce5cb57f05ff	GROUP	\N
\.


--
-- Data for Name: conversation_participant; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.conversation_participant (id, created_date, last_modified_date, last_read_message_id, role, conversation_id, user_id) FROM stdin;
1	2026-01-15 03:11:59.97646+00	2026-01-15 03:11:59.97646+00	\N	MEMBER	1	124
2	2026-01-15 03:11:59.979838+00	2026-01-15 03:11:59.979838+00	\N	ADMIN	1	121
7	2026-01-17 09:34:58.600753+00	2026-01-17 09:34:58.600753+00	\N	MEMBER	2	126
8	2026-01-17 09:34:58.93681+00	2026-01-17 09:34:58.93681+00	\N	ADMIN	2	121
9	2026-01-17 09:34:58.960423+00	2026-01-17 09:34:58.960423+00	\N	MEMBER	2	124
10	2026-01-17 09:34:58.983505+00	2026-01-17 09:34:58.983505+00	\N	MEMBER	2	129
11	2026-01-17 09:55:25.181073+00	2026-01-17 09:55:25.181073+00	\N	MEMBER	3	124
12	2026-01-17 09:55:25.186436+00	2026-01-17 09:55:25.186436+00	\N	MEMBER	3	129
13	2026-01-17 09:55:25.18802+00	2026-01-17 09:55:25.18802+00	\N	ADMIN	3	121
14	2026-01-17 09:55:25.189319+00	2026-01-17 09:55:25.189319+00	\N	MEMBER	3	126
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
84251835-7dc3-4b30-95db-345a3da58d94	\N	password	8a98e8b9-37ff-4a89-b8d8-a7e4d45d4f1e	1764321071664	\N	{"value":"HSBCnNrDksQosQ9OSswzK1ihQ5+YsYwW+RXbRD6i6E4=","salt":"nEc2eDIJ1SDA2KsKs4sxuw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
ca42242d-7a5b-49fb-a726-94cc3ebbad5e	\N	password	09ef75b6-5d8f-443f-ab88-1e6e4fdd09a0	1764321071175	\N	{"value":"xELDHXIMz2SB3rXkQ9aRP0ky2HavG5+lGfuLk8vB8q4=","salt":"7Ak1Kjz9Vh5UlzpakgGGvw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
1a698437-2d1c-4633-aa48-7824fb01bffd	\N	password	e0f4cddc-281e-48f7-8ca7-6dbbd0c0a96a	1764321074286	\N	{"value":"1AiInpBNiM8kVffXZWKn5FxFbaJt1jZYVBa3rZ+Hjuw=","salt":"jqXSLrwVYr3qS5pjRREuxg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
e6fb331b-3839-4365-aeb7-49463902c2e0	\N	password	a03e7f08-f0c7-4c40-97d6-e3bff7d00057	1764321071424	\N	{"value":"23lKH6jBKcSgS9ngaONFjmCN1AtRUsYPawB+y0btWDc=","salt":"5hcE9Xn4MCo3O6HLcXc5uQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
2bce277c-62c4-4a90-a0a3-3c7eba2df287	\N	password	8c2bd715-2950-4ad6-a43b-7d75874ed33d	1764321071894	\N	{"value":"O1/tL0gpgjuBrndqc3NhzmsKVoeZ9LWMMcqx+7a/NqE=","salt":"sH32CKT3qFstawP5ljgOMw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
dd9c6a0f-5989-458b-947a-b00d67e40935	\N	password	9d478593-8658-473d-9f6a-cfb8530385b3	1764321070942	\N	{"value":"GL2Jf7f+Qsy8jUAqzsXVzKVyUn8+Ov4eHfO5qhokPlA=","salt":"qAH6H0f0uYLE8mgsA35MSA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
ecffde03-f274-463d-aeb9-0cbbdf6237b1	\N	password	b1e6055e-734d-4367-8330-975869b72a10	1764321074516	\N	{"value":"V93AmiwkAjRQ0hUBK8fTKK4ZbNqvCs++gA60k2ry/yk=","salt":"dBOmvoA3icAQUo5Dn+V6sA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
2aae5d40-ac84-4976-b6c2-de271c11c289	\N	password	75729648-21f9-4808-aaeb-0a9f2aaed554	1764321073333	\N	{"value":"OeM5+0sG9IHLWwFGGMVOF//cxrsfJ14Kb787tpGhHv4=","salt":"touTgAkenl9dH97+MuLsLw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
60014adf-0511-4848-91dd-9c0dc54b445a	\N	password	a8973d47-25d6-4904-ab93-4b30aac43dba	1764321072122	\N	{"value":"SpuRAjEWVzSgVnfyPK7/LAfFhaNCZlKxVS2uvlE2NV0=","salt":"hnvmAplYDuS31+1bx6EeDw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
a12c2a7c-cc6a-49cd-93dd-37face8619d8	\N	password	a50fc325-a397-4f18-bb31-75cc1191ffa8	1764321074037	\N	{"value":"mPShEwnhZHUzjX4hnT2EH06FPhj5tDVyOl8ICiNzvvE=","salt":"ubVxJlMg1hOGPrX7H51RpQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
af521363-eeb7-44c5-b0df-c7f06bd3063b	\N	password	32ca4097-7490-4a9a-aecf-8c948a2a0e41	1764321074733	\N	{"value":"WytbL6FbgPljOJ3Z88KJGsShNNc9U1Ds54f4GKXwOhY=","salt":"lacJGokwOTTeu6gz/zA4Vg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
1abd804d-e12f-44fa-9073-05248bbb9428	\N	password	cf8665b4-ef04-45b5-9b90-b3864e58e0ff	1764321072838	\N	{"value":"/V37bwJtBFGQI2a8nv11KasC+3gLe0HJOGItVZw8mus=","salt":"9ZgIncL3z2ahYC7CNDe0Tw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
5bc3ff1a-0c3f-4e0c-9312-1334199de184	\N	password	8ad53006-5ab5-45fb-84c0-497a6424d782	1764321073783	\N	{"value":"SjGHGunTShrJuxLdLbXRmnqyW3rZkKKOePQ/t6t+72c=","salt":"mxaMInqv4IlSCExB5NHsdQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
147a4356-bb0f-4fca-8293-8d39531077c4	\N	password	7b0afce6-4207-467a-9e67-e013d8f70566	1764321073106	\N	{"value":"Z2E58jlq1BK34atKpw0BtDsH6oMaXOsGre38c/KXlDI=","salt":"tymRwj1+PeBUDnliL6Zq4Q==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
b24742f4-f524-4c5f-a2cb-98f992714fe9	\N	password	3a050261-b704-426e-a7c2-68b69ebeb90b	1764321070430	\N	{"value":"JxkiwhaTHUg77fh6TH4QzcSZHvK31bcVxF5+pnrfk7g=","salt":"J9JHVM7TY5eiWvf8jON4rQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
d0c88ba4-a03e-4fe4-804a-e5ca8a4b7b5a	\N	password	7d756359-1b87-442d-a2e8-e4785dd5aaa4	1764321070703	\N	{"value":"gcwiPHWI5UUEFlxFRoJgMVIbf97kUlT2ZCqrP3fCzKg=","salt":"KxJS2Vkz9guXN599Diu3zQ==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
a6225f6e-0efc-4d1e-a00b-52929d810950	\N	password	4eb678c6-f977-46ba-baaf-c9bf4bec62ef	1764321070121	\N	{"value":"g3fcVviQ2lIbgrhAU/qjgdwNsi8gVRKv4CndowVnguU=","salt":"BQvBN98UnJ9oCC2vYy1ERw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
832e1af3-beab-40c0-8ea8-bc7f477b65b8	\N	password	ce35d0b0-2a72-4a57-8fac-dcb8348f4c41	1764321073558	\N	{"value":"sTjKrblaIrO9vh1s9tZtbK21mIGYv7Anz4Hyym3YcTs=","salt":"xoQVH9oG+rahwfySGjZZPA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
a2d7b307-c5be-43ea-bca2-a1035251e98f	\N	password	27e24793-eb80-4ba8-9ace-95f432ca5199	1764321072576	\N	{"value":"T8o5lVvOctKiCgpnaSyGfcoOGq4TGwv1p1m3uNSg7m8=","salt":"mmTZOXP7m0bQTM2dOIYSjA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
5a47f8f5-1782-46cd-bfa8-b87c75719c52	\N	password	cd2e474a-f099-4cce-ac9f-4d047fd00a01	1764321439165	\N	{"value":"IKJRKUvzKfSkDymzwH+Wb6k2vbmM/4N6sryVOeZZg9k=","salt":"mv6VCQF/bx8mg9Fa23XrHA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
0c6686be-24f0-4813-97bd-7bb0c89ec71d	\N	password	4c8aa205-60a4-4caf-8b62-34777a9784dc	1764321072346	\N	{"value":"hqExNklwPtrhWNdYn5nCL/oQtOzOG57r8TKjRsQhpkg=","salt":"F0M3feF5WSzYGB3tvU5r+A==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
002a9748-d37f-4369-9f81-445518bb29a4	\N	password	acfe4112-d87d-4f95-86eb-d817c80a1666	1768440076425	\N	{"value":"H7qsIaoL+VzFMZ1JokmdlLobCF0yrGtIncAODDmUzKg=","salt":"/L5fZN0DH9E8yYVElPVaTA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2026-01-15 01:20:59.489325	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	8440058804
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2026-01-15 01:20:59.526228	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	8440058804
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2026-01-15 01:20:59.593526	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	8440058804
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2026-01-15 01:20:59.601129	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8440058804
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2026-01-15 01:20:59.735929	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	8440058804
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2026-01-15 01:20:59.748246	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	8440058804
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2026-01-15 01:20:59.885429	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	8440058804
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2026-01-15 01:20:59.89689	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	8440058804
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2026-01-15 01:20:59.909913	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	8440058804
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2026-01-15 01:21:00.036139	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	8440058804
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2026-01-15 01:21:00.16334	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8440058804
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2026-01-15 01:21:00.173888	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8440058804
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2026-01-15 01:21:00.214155	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8440058804
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-15 01:21:00.240425	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	8440058804
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-15 01:21:00.243336	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8440058804
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-15 01:21:00.248225	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	8440058804
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-15 01:21:00.25297	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	8440058804
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2026-01-15 01:21:00.310839	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	8440058804
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2026-01-15 01:21:00.366881	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	8440058804
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2026-01-15 01:21:00.374365	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	8440058804
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-15 01:21:08.099463	144	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	8440058804
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2026-01-15 01:21:00.380277	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	8440058804
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2026-01-15 01:21:00.3856	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	8440058804
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2026-01-15 01:21:00.506202	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	8440058804
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2026-01-15 01:21:00.513282	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	8440058804
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2026-01-15 01:21:00.515397	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	8440058804
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2026-01-15 01:21:01.238856	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	8440058804
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2026-01-15 01:21:01.31442	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	8440058804
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2026-01-15 01:21:01.319778	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	8440058804
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2026-01-15 01:21:01.374664	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	8440058804
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2026-01-15 01:21:01.391113	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	8440058804
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2026-01-15 01:21:01.414804	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	8440058804
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2026-01-15 01:21:01.421134	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	8440058804
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-15 01:21:01.432143	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8440058804
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-15 01:21:01.436016	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	8440058804
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-15 01:21:01.472804	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	8440058804
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2026-01-15 01:21:01.482504	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	8440058804
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-15 01:21:01.488325	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8440058804
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2026-01-15 01:21:01.494403	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	8440058804
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2026-01-15 01:21:01.500169	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	8440058804
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-01-15 01:21:01.502572	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	8440058804
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-01-15 01:21:01.50579	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	8440058804
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2026-01-15 01:21:01.512448	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	8440058804
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-01-15 01:21:03.665367	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	8440058804
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2026-01-15 01:21:03.670745	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	8440058804
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-15 01:21:03.676637	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	8440058804
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-15 01:21:03.681835	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	8440058804
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-15 01:21:03.683743	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	8440058804
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-15 01:21:03.831924	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	8440058804
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-15 01:21:03.837366	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	8440058804
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2026-01-15 01:21:03.86202	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	8440058804
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2026-01-15 01:21:04.292279	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	8440058804
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2026-01-15 01:21:04.301666	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8440058804
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2026-01-15 01:21:04.30708	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	8440058804
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2026-01-15 01:21:04.310986	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	8440058804
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-15 01:21:04.319764	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	8440058804
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-15 01:21:04.328605	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	8440058804
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-15 01:21:04.391868	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	8440058804
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-15 01:21:05.084438	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	8440058804
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2026-01-15 01:21:05.119097	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	8440058804
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2026-01-15 01:21:05.132247	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	8440058804
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-01-15 01:21:05.148144	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	8440058804
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-01-15 01:21:05.155816	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	8440058804
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2026-01-15 01:21:05.165745	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	8440058804
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2026-01-15 01:21:05.171966	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	8440058804
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2026-01-15 01:21:05.180404	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	8440058804
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2026-01-15 01:21:05.283159	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	8440058804
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2026-01-15 01:21:05.373839	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	8440058804
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2026-01-15 01:21:05.384214	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	8440058804
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2026-01-15 01:21:05.459884	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	8440058804
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2026-01-15 01:21:05.470158	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	8440058804
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2026-01-15 01:21:05.475897	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	8440058804
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-15 01:21:05.485792	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8440058804
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-15 01:21:05.494278	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8440058804
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-15 01:21:05.499056	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8440058804
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-15 01:21:05.525217	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	8440058804
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-15 01:21:05.575015	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	8440058804
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-15 01:21:05.581762	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	8440058804
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-15 01:21:05.585311	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	8440058804
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-15 01:21:05.605462	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	8440058804
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-15 01:21:05.609513	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	8440058804
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-15 01:21:05.656739	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	8440058804
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-15 01:21:05.65886	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8440058804
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-15 01:21:05.669401	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8440058804
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-15 01:21:05.673077	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8440058804
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-15 01:21:05.717509	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8440058804
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2026-01-15 01:21:05.726673	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	8440058804
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-01-15 01:21:05.73612	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	8440058804
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-01-15 01:21:05.745135	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	8440058804
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-15 01:21:05.754316	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	8440058804
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-15 01:21:05.765776	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	8440058804
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-15 01:21:05.844529	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8440058804
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-15 01:21:05.86284	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	8440058804
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-15 01:21:05.865846	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	8440058804
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-15 01:21:05.883827	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	8440058804
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-15 01:21:05.887322	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	8440058804
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-15 01:21:05.901392	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	8440058804
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-15 01:21:06.137959	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8440058804
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-15 01:21:06.141712	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8440058804
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-15 01:21:06.163855	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8440058804
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-15 01:21:06.260924	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8440058804
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-15 01:21:06.266943	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8440058804
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-15 01:21:06.366237	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	8440058804
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-15 01:21:06.376133	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	8440058804
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2026-01-15 01:21:06.389918	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	8440058804
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2026-01-15 01:21:06.47186	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	8440058804
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2026-01-15 01:21:06.529377	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	8440058804
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2026-01-15 01:21:06.605664	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	8440058804
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2026-01-15 01:21:06.61299	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	8440058804
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-01-15 01:21:06.678958	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	8440058804
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-01-15 01:21:06.681378	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	8440058804
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-01-15 01:21:06.692416	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8440058804
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2026-01-15 01:21:06.701065	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	8440058804
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-01-15 01:21:06.721647	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	8440058804
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-01-15 01:21:06.72765	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	8440058804
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-01-15 01:21:06.738704	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	8440058804
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-01-15 01:21:06.743161	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	8440058804
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-01-15 01:21:06.753394	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	8440058804
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-01-15 01:21:06.759525	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8440058804
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-01-15 01:21:06.989363	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	8440058804
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-01-15 01:21:06.998552	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	8440058804
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-01-15 01:21:07.009918	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8440058804
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-01-15 01:21:07.097414	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8440058804
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-01-15 01:21:07.105192	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	8440058804
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-01-15 01:21:07.108357	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8440058804
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-01-15 01:21:07.112137	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8440058804
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-15 01:21:07.122818	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8440058804
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-15 01:21:07.205038	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8440058804
25.0.0-28265-index-cleanup	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-15 01:21:07.217498	128	EXECUTED	9:8c0cfa341a0474385b324f5c4b2dfcc1	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...		\N	4.29.1	\N	\N	8440058804
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-15 01:21:07.221101	129	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8440058804
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-15 01:21:07.402919	130	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8440058804
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-15 01:21:07.429224	131	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	8440058804
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-15 01:21:07.45039	132	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	8440058804
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-15 01:21:07.454847	133	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	8440058804
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-15 01:21:07.63617	134	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	8440058804
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-15 01:21:07.65097	135	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	8440058804
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-15 01:21:07.666387	136	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	8440058804
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-15 01:21:07.755948	137	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	8440058804
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-15 01:21:07.769454	138	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	8440058804
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-15 01:21:07.78172	139	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	8440058804
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-15 01:21:07.869974	140	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	8440058804
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-15 01:21:08.048649	141	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	8440058804
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-15 01:21:08.056818	142	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8440058804
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-15 01:21:08.086994	143	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	8440058804
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2026-01-13 06:37:44.245209	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	8286263493
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2026-01-13 06:37:44.293012	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	8286263493
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2026-01-13 06:37:44.373522	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	8286263493
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2026-01-13 06:37:44.38214	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8286263493
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2026-01-13 06:37:44.526466	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	8286263493
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2026-01-13 06:37:44.536783	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	8286263493
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2026-01-13 06:37:44.678187	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	8286263493
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2026-01-13 06:37:44.686727	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	8286263493
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2026-01-13 06:37:44.699539	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	8286263493
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2026-01-13 06:37:44.898269	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	8286263493
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2026-01-13 06:37:45.016066	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8286263493
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2026-01-13 06:37:45.032374	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8286263493
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2026-01-13 06:37:45.080996	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8286263493
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-13 06:37:45.113413	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	8286263493
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-13 06:37:45.117133	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8286263493
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-13 06:37:45.12477	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	8286263493
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-13 06:37:45.131435	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	8286263493
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2026-01-13 06:37:45.207223	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	8286263493
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2026-01-13 06:37:45.275238	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	8286263493
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2026-01-13 06:37:45.285497	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	8286263493
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-13 06:37:54.657686	144	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	8286263493
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2026-01-13 06:37:45.293599	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	8286263493
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2026-01-13 06:37:45.300066	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	8286263493
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2026-01-13 06:37:45.494434	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	8286263493
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2026-01-13 06:37:45.505305	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	8286263493
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2026-01-13 06:37:45.508444	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	8286263493
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2026-01-13 06:37:46.398998	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	8286263493
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2026-01-13 06:37:46.490913	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	8286263493
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2026-01-13 06:37:46.496295	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	8286263493
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2026-01-13 06:37:46.569735	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	8286263493
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2026-01-13 06:37:46.590139	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	8286263493
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2026-01-13 06:37:46.616706	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	8286263493
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2026-01-13 06:37:46.62488	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	8286263493
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-13 06:37:46.636509	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8286263493
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-13 06:37:46.641219	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	8286263493
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-13 06:37:46.673573	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	8286263493
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2026-01-13 06:37:46.683111	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	8286263493
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-13 06:37:46.689391	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8286263493
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2026-01-13 06:37:46.695424	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	8286263493
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2026-01-13 06:37:46.700945	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	8286263493
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-01-13 06:37:46.703065	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	8286263493
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-01-13 06:37:46.706864	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	8286263493
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2026-01-13 06:37:46.714495	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	8286263493
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-01-13 06:37:49.300716	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	8286263493
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2026-01-13 06:37:49.305984	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	8286263493
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-13 06:37:49.312223	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	8286263493
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-13 06:37:49.317762	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	8286263493
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-13 06:37:49.319878	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	8286263493
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-13 06:37:49.512976	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	8286263493
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-13 06:37:49.519509	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	8286263493
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2026-01-13 06:37:49.55807	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	8286263493
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2026-01-13 06:37:50.191475	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	8286263493
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2026-01-13 06:37:50.196729	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8286263493
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2026-01-13 06:37:50.201598	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	8286263493
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2026-01-13 06:37:50.207033	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	8286263493
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-13 06:37:50.217435	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	8286263493
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-13 06:37:50.225336	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	8286263493
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-13 06:37:50.341991	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	8286263493
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-13 06:37:51.085518	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	8286263493
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2026-01-13 06:37:51.125332	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	8286263493
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2026-01-13 06:37:51.136723	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	8286263493
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-01-13 06:37:51.154194	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	8286263493
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-01-13 06:37:51.162423	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	8286263493
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2026-01-13 06:37:51.169486	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	8286263493
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2026-01-13 06:37:51.175927	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	8286263493
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2026-01-13 06:37:51.183364	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	8286263493
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2026-01-13 06:37:51.260604	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	8286263493
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2026-01-13 06:37:51.32805	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	8286263493
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2026-01-13 06:37:51.336732	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	8286263493
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2026-01-13 06:37:51.405275	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	8286263493
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2026-01-13 06:37:51.415586	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	8286263493
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2026-01-13 06:37:51.422692	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	8286263493
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-13 06:37:51.43471	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8286263493
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-13 06:37:51.449703	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8286263493
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-13 06:37:51.454168	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8286263493
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-13 06:37:51.493377	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	8286263493
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-13 06:37:51.563177	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	8286263493
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-13 06:37:51.574049	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	8286263493
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-13 06:37:51.577505	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	8286263493
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-13 06:37:51.610391	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	8286263493
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-13 06:37:51.614109	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	8286263493
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-13 06:37:51.690734	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	8286263493
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-13 06:37:51.69311	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8286263493
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-13 06:37:51.703115	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8286263493
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-13 06:37:51.707564	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8286263493
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-13 06:37:51.771869	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8286263493
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2026-01-13 06:37:51.784154	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	8286263493
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-01-13 06:37:51.799355	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	8286263493
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-01-13 06:37:51.811726	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	8286263493
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-13 06:37:51.821415	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	8286263493
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-13 06:37:51.831938	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	8286263493
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-13 06:37:51.905971	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8286263493
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-13 06:37:51.917849	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	8286263493
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-13 06:37:51.921808	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	8286263493
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-13 06:37:51.932121	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	8286263493
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-13 06:37:51.934921	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	8286263493
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-13 06:37:51.944379	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	8286263493
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-13 06:37:52.134107	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8286263493
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-13 06:37:52.13837	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8286263493
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-13 06:37:52.154437	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8286263493
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-13 06:37:52.220269	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8286263493
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-13 06:37:52.224387	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8286263493
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-13 06:37:52.301134	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	8286263493
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-13 06:37:52.309662	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	8286263493
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2026-01-13 06:37:52.324675	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	8286263493
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2026-01-13 06:37:52.411693	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	8286263493
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2026-01-13 06:37:52.480557	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	8286263493
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2026-01-13 06:37:52.589902	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	8286263493
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2026-01-13 06:37:52.600515	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	8286263493
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-01-13 06:37:52.692012	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	8286263493
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-01-13 06:37:52.698164	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	8286263493
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-01-13 06:37:52.715898	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8286263493
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2026-01-13 06:37:52.723056	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	8286263493
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-01-13 06:37:52.74997	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	8286263493
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-01-13 06:37:52.757362	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	8286263493
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-01-13 06:37:52.771399	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	8286263493
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-01-13 06:37:52.776143	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	8286263493
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-01-13 06:37:52.787353	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	8286263493
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-01-13 06:37:52.79583	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8286263493
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-01-13 06:37:53.27707	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	8286263493
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-01-13 06:37:53.289507	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	8286263493
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-01-13 06:37:53.311279	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8286263493
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-01-13 06:37:53.423198	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8286263493
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-01-13 06:37:53.434375	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	8286263493
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-01-13 06:37:53.437413	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8286263493
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-01-13 06:37:53.44244	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8286263493
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-13 06:37:53.456887	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8286263493
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-13 06:37:53.542704	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8286263493
25.0.0-28265-index-cleanup	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-13 06:37:53.559126	128	EXECUTED	9:8c0cfa341a0474385b324f5c4b2dfcc1	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...		\N	4.29.1	\N	\N	8286263493
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-13 06:37:53.563958	129	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8286263493
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-13 06:37:53.686119	130	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8286263493
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-13 06:37:53.721507	131	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	8286263493
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-13 06:37:53.750906	132	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	8286263493
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-13 06:37:53.756428	133	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	8286263493
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-13 06:37:54.000345	134	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	8286263493
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-13 06:37:54.0132	135	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	8286263493
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-13 06:37:54.024088	136	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	8286263493
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-13 06:37:54.131469	137	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	8286263493
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-13 06:37:54.146855	138	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	8286263493
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-13 06:37:54.162249	139	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	8286263493
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-13 06:37:54.292252	140	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	8286263493
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-13 06:37:54.588822	141	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	8286263493
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-13 06:37:54.598336	142	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8286263493
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-13 06:37:54.646935	143	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	8286263493
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	2c11e02b-7650-4ece-99a1-93b9ca1fac30	f
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	8abd1a94-9718-4c81-a418-a724b97fc0a2	t
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	77c881f4-2c08-4ee7-8138-86c3984b6813	t
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	b80ae8f9-d07b-4194-a395-2471c0596843	t
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	32257e27-3893-4477-a98e-54982bcad77a	t
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	233eb4d3-c179-4ff1-b650-c4cd9d78748d	f
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	89c0c5ba-f7f2-413b-89d4-853a79795a2f	f
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	f695e5e3-b0e3-4c69-a937-c771a5a33783	t
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	19d59b89-cd56-489f-88a9-cb2a992dff91	t
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	6b2a2852-0172-4cad-a56c-b8f0d651aa72	f
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	e8d249a0-3b95-40f9-a229-b0b33e22da52	t
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	ba2f2273-2ced-4c47-8675-acb7607ea83a	t
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	7c8724fc-ab94-4356-b75c-ded384a704f6	f
83b6664d-539e-4bed-a376-685d50e40b98	2714f410-8ea1-4442-b110-09d56464c942	t
83b6664d-539e-4bed-a376-685d50e40b98	26d881ea-f02a-4da4-a770-096c22dcf2b6	t
83b6664d-539e-4bed-a376-685d50e40b98	424886ac-3b5a-446c-a0f8-2d2cd6474e44	t
83b6664d-539e-4bed-a376-685d50e40b98	1e15434a-7f6c-415b-bb60-f84f0edb53d7	t
83b6664d-539e-4bed-a376-685d50e40b98	1343b2a3-ff3c-4588-a0e3-7372006e3cf9	t
83b6664d-539e-4bed-a376-685d50e40b98	ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee	t
83b6664d-539e-4bed-a376-685d50e40b98	b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc	t
83b6664d-539e-4bed-a376-685d50e40b98	ac70839b-f142-47ab-93cf-f21d06d1f546	t
83b6664d-539e-4bed-a376-685d50e40b98	b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	f
83b6664d-539e-4bed-a376-685d50e40b98	38509398-011e-46eb-9444-8719ee1ccbe9	f
83b6664d-539e-4bed-a376-685d50e40b98	9749151c-c4bd-4925-b7f6-2e141385a4eb	f
83b6664d-539e-4bed-a376-685d50e40b98	2753e1d9-77a7-4059-8465-fa23a6b418c4	f
83b6664d-539e-4bed-a376-685d50e40b98	d21bbe72-4cc0-4637-aaab-c6beafce7e57	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	<< Flyway Baseline >>	BASELINE	<< Flyway Baseline >>	\N	admin	2026-01-13 13:39:25.629021	0	t
2	2.0	add username and image profile field	SQL	V2.0__add_username_and_image_profile_field.sql	763788717	admin	2026-01-13 13:39:25.703062	6	t
3	3.0	messaging feature	SQL	V3.0__messaging_feature.sql	674340835	admin	2026-01-13 13:47:45.076521	46	t
4	3.1	add status for contact request	SQL	V3.1__add_status_for_contact_request.sql	1343561749	admin	2026-01-13 13:47:45.164142	3	t
5	3.2	add security database sequence	SQL	V3.2__add_security_database_sequence.sql	495872483	admin	2026-01-13 13:47:45.18056	13	t
6	4.0	enforce naming consistency	SQL	V4.0__enforce_naming_consistency.sql	-480777284	admin	2026-01-13 13:47:45.210403	14	t
7	4.1	allow null contact blocked by field	SQL	V4.1__allow_null_contact_blocked_by_field.sql	-1796235846	admin	2026-01-13 13:47:45.237908	3	t
8	4.2	move user settings to separate relation	SQL	V4.2__move_user_settings_to_separate_relation.sql	316081564	admin	2026-01-13 13:48:51.41878	10	t
9	4.3	add conversation type	SQL	V4.3__add_conversation_type.sql	1305435443	admin	2026-01-13 13:48:51.46484	6	t
10	4.4	remove participant duplicate join at	SQL	V4.4__remove_participant_duplicate_join_at.sql	-1915951463	admin	2026-01-13 13:48:51.486869	7	t
11	4.5	add message attachment filename	SQL	V4.5__add_message_attachment_filename.sql	-2121602319	admin	2026-01-13 13:48:51.519168	6	t
12	4.6	message add reply fk	SQL	V4.6__message_add_reply_fk.sql	1828234334	admin	2026-01-13 13:48:51.548097	12	t
13	4.7	add message fk	SQL	V4.7__add_message_fk.sql	-743521739	admin	2026-01-13 13:48:51.582665	8	t
14	4.8	user peference and setting fk	SQL	V4.8__user_peference_and_setting_fk.sql	1235592301	admin	2026-01-13 14:29:37.937518	20	t
15	4.10	add user unqiue contraint	SQL	V4.10__add_user_unqiue_contraint.sql	-142113802	admin	2026-01-13 18:16:41.222277	11	t
16	4.11	add usersettings fk check	SQL	V4.11__add_usersettings_fk_check.sql	116064090	admin	2026-01-13 20:59:15.740251	21	t
\.


--
-- Data for Name: group_; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.group_ (id, created_date, last_modified_date, group_name, group_profile_picture, last_active, conversation_id, public_id) FROM stdin;
1	2026-01-17 09:35:07.025235+00	2026-01-17 09:35:07.025235+00	Padora		2026-01-17 09:35:02.709675+00	2	3b11358d-0412-4f53-9c14-2a1042739121
2	2026-01-17 09:55:25.25885+00	2026-01-17 09:55:25.25885+00	Padora		2026-01-17 09:55:25.228153+00	3	0784ce65-4c88-4f72-81d7-dcb386e5e1bd
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
364fc902-cac0-422a-b35b-6118125dd0a2	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	f	${role_default-roles}	default-roles-master	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	\N	\N
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	f	${role_admin}	admin	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	\N	\N
5f5f8502-a19f-4f40-97e4-bf7c0dfb178b	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	f	${role_create-realm}	create-realm	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	\N	\N
eb37c1b3-eac2-4536-b370-b8ee1562ed69	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_create-client}	create-client	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
4f51b825-45ee-4b16-b714-dfcdca2b9da1	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_view-realm}	view-realm	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
084e8340-4f8d-45e4-9cb6-c93bfb85dc47	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_view-users}	view-users	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
ff703863-a1b5-4ffc-81cc-14b4222b2b82	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_view-clients}	view-clients	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
fc022640-30f7-4fcc-9f3f-2cf83bcf46cf	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_view-events}	view-events	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
8bbd5cf5-5324-45b0-a295-2639de132c2e	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_view-identity-providers}	view-identity-providers	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
11d16cf1-7d2a-485b-bdf6-381e940cc0a8	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_view-authorization}	view-authorization	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
7c513fcc-bb17-4c69-84f1-3f6cadac1d8a	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_manage-realm}	manage-realm	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
0033b382-dac8-4686-80be-d81a56165697	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_manage-users}	manage-users	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
78b73522-b25b-42b7-9059-75f30f3a88ce	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_manage-clients}	manage-clients	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
bfdba175-612e-418c-a6ee-90de9407183c	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_manage-events}	manage-events	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
a78b927d-2949-44ff-82c6-01945599a76d	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_manage-identity-providers}	manage-identity-providers	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
173b1ba1-b3c2-4e7e-a646-e587041601f4	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_manage-authorization}	manage-authorization	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
50b85b76-5ea0-4457-8218-167e7e482498	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_query-users}	query-users	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
40c380e7-8dfc-4ce5-ae5f-9b56bd9dbac4	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_query-clients}	query-clients	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
3ee51e00-afd1-4274-a18a-3969a5e14ca0	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_query-realms}	query-realms	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
38374784-37f3-4c03-b3d8-7114c0d1430f	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_query-groups}	query-groups	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
f5df779e-e1db-441c-bdda-8422cd069442	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	t	${role_view-profile}	view-profile	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	\N
c87dc21b-1a54-4193-901b-4c533c2e531c	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	t	${role_manage-account}	manage-account	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	\N
fac6bfa7-f1e0-40a9-a0a5-ed9f84691575	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	t	${role_manage-account-links}	manage-account-links	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	\N
fd908fba-c363-4159-bda9-9225bb1a48ce	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	t	${role_view-applications}	view-applications	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	\N
f7e05263-9fa3-4103-bea2-00fc887e024d	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	t	${role_view-consent}	view-consent	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	\N
ab779578-02bc-47f6-84cd-d4b34905904c	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	t	${role_manage-consent}	manage-consent	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	\N
2b26d843-e9e3-4b8c-859f-a9d62d8c48fb	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	t	${role_view-groups}	view-groups	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	\N
f9c65694-fa56-4271-b418-343614e6a5cb	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	t	${role_delete-account}	delete-account	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	\N
bb5535d2-d3a4-458e-85b7-5706a469dfe2	77c491e0-7e4d-42a6-8be7-24061a97bfd9	t	${role_read-token}	read-token	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	77c491e0-7e4d-42a6-8be7-24061a97bfd9	\N
8b02cbb8-af99-4db2-8910-f569cc6dc896	9093a96a-50fe-40b6-bf7c-e1f1aced8156	t	${role_impersonation}	impersonation	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	9093a96a-50fe-40b6-bf7c-e1f1aced8156	\N
a8c3ceb7-00d3-4a33-ab6a-1ac9d6f7994e	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	f	${role_offline-access}	offline_access	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	\N	\N
31b5b8b7-6047-4db5-a1c7-ebd0ccc9239d	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	f	${role_uma_authorization}	uma_authorization	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	\N	\N
929392ee-0474-4ed0-a64e-9b0132025c91	83b6664d-539e-4bed-a376-685d50e40b98	f	${role_default-roles}	default-roles-loci-realm	83b6664d-539e-4bed-a376-685d50e40b98	\N	\N
d67481b6-be3c-42b1-9731-c3bd89bf5944	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_create-client}	create-client	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
6516fc70-d950-4abe-a395-4270844dab78	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_view-realm}	view-realm	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
64e58440-12ea-471d-91c8-391ef312c668	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_view-users}	view-users	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
908432ec-ac3f-41a3-8933-b54458214d97	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_view-clients}	view-clients	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
a763ed91-e817-4720-9af3-84f5557e2b78	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_view-events}	view-events	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
268a5b97-42e2-4d11-9850-3a44b349f17c	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_view-identity-providers}	view-identity-providers	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
bee838ca-84cd-4361-b837-b1728fba9d6d	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_view-authorization}	view-authorization	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
30e9401d-42c8-4cb4-ab0f-327b0933c963	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_manage-realm}	manage-realm	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
611419cc-e037-490e-b6fa-b52bf2ae705b	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_manage-users}	manage-users	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
0104f6a4-a938-4165-b74b-d0979a1fbabd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_manage-clients}	manage-clients	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
5366456a-b152-47a2-8e4a-d869aad68810	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_manage-events}	manage-events	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
ec25d93c-d6b4-46ca-a5c0-6438bfedd128	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_manage-identity-providers}	manage-identity-providers	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
f78bcf7d-9956-4734-babf-651c0428a3de	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_manage-authorization}	manage-authorization	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
066855c4-82d9-43ea-aed3-88b30d43d46b	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_query-users}	query-users	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
9e366230-72db-46b8-b2bc-75e192b1bc5e	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_query-clients}	query-clients	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
be427f10-3ebb-432a-a367-8b6f4ec2c3c3	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_query-realms}	query-realms	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
1b88d344-e5a0-49ff-8faf-52e50386201e	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_query-groups}	query-groups	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
eb9be962-f203-49c6-9075-ce80642bf363	83b6664d-539e-4bed-a376-685d50e40b98	f	${role_uma_authorization}	uma_authorization	83b6664d-539e-4bed-a376-685d50e40b98	\N	\N
5df2f1e3-7508-4fbb-889f-c8b70f84ec3b	83b6664d-539e-4bed-a376-685d50e40b98	f		user	83b6664d-539e-4bed-a376-685d50e40b98	\N	\N
6d7b0d9a-0ac1-481e-aebb-8acd9d5c3e39	83b6664d-539e-4bed-a376-685d50e40b98	f	${role_offline-access}	offline_access	83b6664d-539e-4bed-a376-685d50e40b98	\N	\N
5160c2df-3ab3-465b-b113-a61e60faf3bf	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_view-events}	view-events	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
7d52ab89-86c3-4b57-bab0-02bbe460212e	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_query-groups}	query-groups	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
995efc57-65a8-4262-9f91-7b9d83580c90	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_query-realms}	query-realms	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
b1939686-0827-4787-a141-9e7dd5fc1b82	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_manage-clients}	manage-clients	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
8f94747b-5e4b-4d79-bf0c-cd4923506035	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_view-realm}	view-realm	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
a7120f7b-a46b-4f6a-9e97-0eea0f64174a	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_impersonation}	impersonation	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
808637e3-7023-4d84-a56a-4f51c7ec23c4	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_manage-users}	manage-users	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
221f3b69-a59e-4a34-a95a-71f10cef4e0a	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_view-clients}	view-clients	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
ae3061fa-e4e7-4bf4-a3af-ca8d12cdb57d	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_view-identity-providers}	view-identity-providers	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
4009714e-eefe-46d4-9b37-639a6edfa501	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_view-users}	view-users	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
fdf28825-1691-44e5-88c3-2c8c9a0aa41e	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_manage-identity-providers}	manage-identity-providers	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
4e989ddd-8be8-4533-bfde-cad630193577	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_view-authorization}	view-authorization	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
ffb45a5a-3d46-434b-910a-2894fae5d4d9	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_manage-realm}	manage-realm	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
dd7c767b-2b46-4089-a64a-97fd1456b645	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_manage-authorization}	manage-authorization	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
38244948-f337-4b8b-9c15-fdc672bc80f9	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_query-users}	query-users	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
fd6368e9-9e26-469e-8d79-707f3c20354a	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_realm-admin}	realm-admin	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
abfd79ad-9ca7-4f0b-b54b-78a9c1e9f28e	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_create-client}	create-client	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
6bf59d64-e73b-44b6-93cc-75d66c644214	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_manage-events}	manage-events	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
0cf5be44-ba63-47c2-b752-662ef0a5885b	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	t	${role_query-clients}	query-clients	83b6664d-539e-4bed-a376-685d50e40b98	1b01f7e0-ad45-4cd7-8adb-119a1d9316bb	\N
ab8a75b3-f452-4310-9885-40c2c6c74704	81fb0324-8f89-4cb7-bc31-8af536e10b7e	t	${role_read-token}	read-token	83b6664d-539e-4bed-a376-685d50e40b98	81fb0324-8f89-4cb7-bc31-8af536e10b7e	\N
50118dde-4418-4aad-aceb-8c7b45903b0b	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	t	${role_delete-account}	delete-account	83b6664d-539e-4bed-a376-685d50e40b98	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	\N
cd9c2212-1347-472e-8e9f-20be2bfc2ec2	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	t	${role_view-groups}	view-groups	83b6664d-539e-4bed-a376-685d50e40b98	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	\N
43ca2f26-9aa7-47d7-8773-c808b2435278	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	t	${role_view-applications}	view-applications	83b6664d-539e-4bed-a376-685d50e40b98	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	\N
2e0714ed-6fbf-47eb-ae88-59ce44d6ed3b	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	t	${role_manage-consent}	manage-consent	83b6664d-539e-4bed-a376-685d50e40b98	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	\N
4862f2b4-4e36-42cd-a524-6dddbb43e551	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	t	${role_manage-account-links}	manage-account-links	83b6664d-539e-4bed-a376-685d50e40b98	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	\N
f24cb736-a373-4bd6-a34a-ab059b81f98f	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	t	${role_view-profile}	view-profile	83b6664d-539e-4bed-a376-685d50e40b98	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	\N
710ed846-759e-45bc-afa4-bb5ef183d08c	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	t	${role_manage-account}	manage-account	83b6664d-539e-4bed-a376-685d50e40b98	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	\N
b39c73a7-84b1-40ff-9fd9-6f314c9ede7a	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	t	${role_view-consent}	view-consent	83b6664d-539e-4bed-a376-685d50e40b98	cb847cf7-5d97-441b-b7dd-a6f1a47689a2	\N
01847a85-8e88-48ea-a298-acc82a541d4f	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	t	${role_impersonation}	impersonation	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	\N
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.message (id, created_date, last_modified_date, content, deleted, delivered_at, media_url, read_at, sent_at, status, type, conversation_id, sender_id, public_id, media_name, reply_to_message_id) FROM stdin;
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.migration_model (id, version, update_time) FROM stdin;
2j8x7	26.0.0	1768440068
9zybz	26.0.0	1768286275
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.notification (id, created_date, last_modified_date, content, message_thumbnail, read_at, user_id, public_id) FROM stdin;
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
37b54fa8-7109-4f07-9f04-2ac4177ca28b	e85deedd-b2fb-47d3-acef-508423a77f22	0	1768642460	{"authMethod":"openid-connect","notes":{"clientId":"e85deedd-b2fb-47d3-acef-508423a77f22","userSessionStartedAt":"1768642460","iss":"http://localhost:9090/realms/loci-realm","startedAt":"1768642460","level-of-authentication":"-1"}}	local	local	0
3ecf96b0-6d79-46aa-be25-1717fe88e2e5	e85deedd-b2fb-47d3-acef-508423a77f22	0	1768643684	{"authMethod":"openid-connect","notes":{"clientId":"e85deedd-b2fb-47d3-acef-508423a77f22","userSessionStartedAt":"1768643684","iss":"http://localhost:9090/realms/loci-realm","startedAt":"1768643684","level-of-authentication":"-1"}}	local	local	0
88e0d1bf-74e3-4d7e-9157-7b9df077aad0	e85deedd-b2fb-47d3-acef-508423a77f22	0	1768643787	{"authMethod":"openid-connect","notes":{"clientId":"e85deedd-b2fb-47d3-acef-508423a77f22","userSessionStartedAt":"1768643787","iss":"http://localhost:9090/realms/loci-realm","startedAt":"1768643787","level-of-authentication":"-1"}}	local	local	0
d28668f1-c46f-4433-ad8d-32f727f92871	e85deedd-b2fb-47d3-acef-508423a77f22	0	1768643987	{"authMethod":"openid-connect","notes":{"clientId":"e85deedd-b2fb-47d3-acef-508423a77f22","userSessionStartedAt":"1768643987","iss":"http://localhost:9090/realms/loci-realm","startedAt":"1768643987","level-of-authentication":"-1"}}	local	local	0
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
37b54fa8-7109-4f07-9f04-2ac4177ca28b	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768642460	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","authenticators-completed":"{\\"1321932e-bb62-4d49-a1f7-3268199ce856\\":1768642460,\\"7f18f38f-3ef3-4a22-b7c0-02e19b85a508\\":1768642460}"},"state":"LOGGED_IN"}	1768642460	\N	0
3ecf96b0-6d79-46aa-be25-1717fe88e2e5	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768643684	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","authenticators-completed":"{\\"1321932e-bb62-4d49-a1f7-3268199ce856\\":1768643684,\\"7f18f38f-3ef3-4a22-b7c0-02e19b85a508\\":1768643684}"},"state":"LOGGED_IN"}	1768643684	\N	0
88e0d1bf-74e3-4d7e-9157-7b9df077aad0	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768643787	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","authenticators-completed":"{\\"1321932e-bb62-4d49-a1f7-3268199ce856\\":1768643787,\\"7f18f38f-3ef3-4a22-b7c0-02e19b85a508\\":1768643787}"},"state":"LOGGED_IN"}	1768643787	\N	0
d28668f1-c46f-4433-ad8d-32f727f92871	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768643987	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","authenticators-completed":"{\\"1321932e-bb62-4d49-a1f7-3268199ce856\\":1768643987,\\"7f18f38f-3ef3-4a22-b7c0-02e19b85a508\\":1768643987}"},"state":"LOGGED_IN"}	1768643987	\N	0
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
e95f74fa-8717-4c6f-bb23-149039a34b0d	audience resolve	openid-connect	oidc-audience-resolve-mapper	f9df92a9-f77e-4712-b20c-c75d66801f73	\N
e2e8760d-6696-45f5-9686-35f9dcd0b437	locale	openid-connect	oidc-usermodel-attribute-mapper	d4163211-b255-4df3-98fb-fd48febf1cfe	\N
01114f82-3c66-4c71-82e7-223a463fc863	role list	saml	saml-role-list-mapper	\N	8abd1a94-9718-4c81-a418-a724b97fc0a2
c1eaaedc-b39b-4c5a-aa4f-306505148e7c	organization	saml	saml-organization-membership-mapper	\N	77c881f4-2c08-4ee7-8138-86c3984b6813
b0aecf93-ade5-4d19-9be1-02c336782bbc	full name	openid-connect	oidc-full-name-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
036efecf-98ce-41f9-9179-20141d5a4458	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
2105b735-e832-4151-b4f8-15a1b1b1f825	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
e43f3be9-01e3-48ee-bb20-fe13729133c9	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
2a2f4798-4de8-4d49-967c-56a76eb2f67c	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
0d6b9ce6-c814-41dd-9455-32685a7269e2	username	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
7fc7e5a9-5b14-4e03-8ab2-daaf4ba610d3	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
aa333910-14f1-41db-840f-803247e44a85	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
cdbd9f7c-d33e-4070-a3d3-1e0b4dfc5b6a	website	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
cdb9723f-e75f-4f77-9cdb-f0c2107e9fbe	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
7703eed9-d825-47c6-9b08-a3f2ecd9cbfe	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
15215401-80de-408e-a5af-b027f67119b6	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
ec6b688a-1e1c-43fd-8b15-4c655580392d	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
740ee28c-a91e-46db-9d92-d13750ca0e51	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	b80ae8f9-d07b-4194-a395-2471c0596843
cbf918b6-463e-4fbd-9b76-e4cc084c85b1	email	openid-connect	oidc-usermodel-attribute-mapper	\N	32257e27-3893-4477-a98e-54982bcad77a
cdaf3792-fda2-49e0-af2d-aca0e0702444	email verified	openid-connect	oidc-usermodel-property-mapper	\N	32257e27-3893-4477-a98e-54982bcad77a
b66c5627-6d44-4118-83c1-62fb3fb1440e	address	openid-connect	oidc-address-mapper	\N	233eb4d3-c179-4ff1-b650-c4cd9d78748d
a3183658-7dd3-492e-a4fa-da5eece0f99e	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	89c0c5ba-f7f2-413b-89d4-853a79795a2f
a780c3cf-5d4d-431f-ace3-3899e3707826	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	89c0c5ba-f7f2-413b-89d4-853a79795a2f
9ab82265-867b-44c9-8035-563305e94ae9	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	f695e5e3-b0e3-4c69-a937-c771a5a33783
85aca6e2-7fee-4576-91fe-63940bc26d44	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	f695e5e3-b0e3-4c69-a937-c771a5a33783
00bcf51f-5ccf-4409-adc7-9941cea77ee2	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	f695e5e3-b0e3-4c69-a937-c771a5a33783
d9395d89-8d50-4319-a4c1-d9f9dee37150	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	19d59b89-cd56-489f-88a9-cb2a992dff91
6f525d75-ec87-4657-9d69-58b16c42434b	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	6b2a2852-0172-4cad-a56c-b8f0d651aa72
ad22045f-a128-4679-9db2-4c2e2b4686cb	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	6b2a2852-0172-4cad-a56c-b8f0d651aa72
56527ec9-7505-402c-bb0b-62f427383522	acr loa level	openid-connect	oidc-acr-mapper	\N	e8d249a0-3b95-40f9-a229-b0b33e22da52
f045166f-596e-41a7-b142-d7d58044bc50	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	ba2f2273-2ced-4c47-8675-acb7607ea83a
e3d76689-d4f0-4441-8cc5-c1e2a9122c8f	sub	openid-connect	oidc-sub-mapper	\N	ba2f2273-2ced-4c47-8675-acb7607ea83a
7e2e6bd5-c664-44ca-877d-f0d03cbdd674	organization	openid-connect	oidc-organization-membership-mapper	\N	7c8724fc-ab94-4356-b75c-ded384a704f6
a5f42024-b607-4292-b1d6-a9d4191bb4e8	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	2753e1d9-77a7-4059-8465-fa23a6b418c4
e136e954-04d6-4224-bdb0-336990f7b794	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	2753e1d9-77a7-4059-8465-fa23a6b418c4
2caf2e3b-868c-48c5-a684-532529b920ed	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	ac70839b-f142-47ab-93cf-f21d06d1f546
f01993e4-4569-476a-927b-c5586ca133e4	sub	openid-connect	oidc-sub-mapper	\N	ac70839b-f142-47ab-93cf-f21d06d1f546
ae9358a3-2b41-4860-87e3-d24dd15d5d71	email	openid-connect	oidc-usermodel-attribute-mapper	\N	1e15434a-7f6c-415b-bb60-f84f0edb53d7
8813051b-d5db-4a74-82e3-440d85bd6d1f	email verified	openid-connect	oidc-usermodel-property-mapper	\N	1e15434a-7f6c-415b-bb60-f84f0edb53d7
8e4d50f6-3d11-45c7-bd5e-99bcc95ea419	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	1343b2a3-ff3c-4588-a0e3-7372006e3cf9
6330cb1c-d510-4162-aa76-14fee2a149b9	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	1343b2a3-ff3c-4588-a0e3-7372006e3cf9
f57565ee-061d-45dd-ae51-83f3a62959ab	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	1343b2a3-ff3c-4588-a0e3-7372006e3cf9
0a7b1fe6-0cd1-4df4-8651-5157a202e9e8	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	9749151c-c4bd-4925-b7f6-2e141385a4eb
435c261a-73d4-47e1-a692-0ebd814c2127	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	9749151c-c4bd-4925-b7f6-2e141385a4eb
99eee510-c44b-4d69-90d8-66de184021af	organization	openid-connect	oidc-organization-membership-mapper	\N	d21bbe72-4cc0-4637-aaab-c6beafce7e57
acd8cbcc-451d-435a-8c40-dc45ea11930f	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	ea76ec75-71a8-42a6-bdfd-dfcca0fc7aee
153fa251-cd25-48f4-9bcf-c6909d808765	organization	saml	saml-organization-membership-mapper	\N	26d881ea-f02a-4da4-a770-096c22dcf2b6
889dd164-8ceb-4f81-ba6e-c407504a095b	address	openid-connect	oidc-address-mapper	\N	38509398-011e-46eb-9444-8719ee1ccbe9
24baf309-3ddf-4d72-bbb9-6cf1b5f23312	acr loa level	openid-connect	oidc-acr-mapper	\N	b1cd614d-0091-4d4e-a2fa-28b3d76ae2bc
58e945c2-28cf-4f53-8add-aed444f92a27	role list	saml	saml-role-list-mapper	\N	2714f410-8ea1-4442-b110-09d56464c942
80592ea1-cf85-4beb-9021-ed452c7bd293	full name	openid-connect	oidc-full-name-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
258a5ec2-f843-4c10-906d-a6503d3980fb	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
7e7a6a27-bcf1-4cdc-8668-149916b2169b	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
b1d9a82a-d1c2-4200-b351-e53021527707	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
3d6eeab9-d603-4896-9ed4-69b41a007b4e	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
46ece9ad-d834-417f-b776-c57aeab5cd07	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
5dde0842-f155-4f2b-9e61-b3967ae0a857	username	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
92baff2a-9f19-4614-a5a8-5dd0c4e24c39	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
a51f9041-9d8d-498a-b62b-a5c4e24141b6	website	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
deb37ced-49bd-4237-b3ab-65fc416ad14f	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
afc27d87-0a4a-4d6c-b8cb-59b80d0aca7d	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
b605f71d-5400-4282-a700-b288d5d7eb14	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
391d2d4b-263f-4a6b-9a3d-593c2aee3556	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
b8ca6d7d-1b82-4ae5-b158-3b61a3874813	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	424886ac-3b5a-446c-a0f8-2d2cd6474e44
b122ad6e-56bc-4dd3-b59a-22bd944e8cb0	audience resolve	openid-connect	oidc-audience-resolve-mapper	1512bb33-3ef4-4dad-af1f-47081a2a75dc	\N
fede70dd-d1c5-4408-a082-a5f0364195d6	locale	openid-connect	oidc-usermodel-attribute-mapper	ba4de397-daf8-404b-ad79-249e4d09a713	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
e2e8760d-6696-45f5-9686-35f9dcd0b437	true	introspection.token.claim
e2e8760d-6696-45f5-9686-35f9dcd0b437	true	userinfo.token.claim
e2e8760d-6696-45f5-9686-35f9dcd0b437	locale	user.attribute
e2e8760d-6696-45f5-9686-35f9dcd0b437	true	id.token.claim
e2e8760d-6696-45f5-9686-35f9dcd0b437	true	access.token.claim
e2e8760d-6696-45f5-9686-35f9dcd0b437	locale	claim.name
e2e8760d-6696-45f5-9686-35f9dcd0b437	String	jsonType.label
01114f82-3c66-4c71-82e7-223a463fc863	false	single
01114f82-3c66-4c71-82e7-223a463fc863	Basic	attribute.nameformat
01114f82-3c66-4c71-82e7-223a463fc863	Role	attribute.name
036efecf-98ce-41f9-9179-20141d5a4458	true	introspection.token.claim
036efecf-98ce-41f9-9179-20141d5a4458	true	userinfo.token.claim
036efecf-98ce-41f9-9179-20141d5a4458	lastName	user.attribute
036efecf-98ce-41f9-9179-20141d5a4458	true	id.token.claim
036efecf-98ce-41f9-9179-20141d5a4458	true	access.token.claim
036efecf-98ce-41f9-9179-20141d5a4458	family_name	claim.name
036efecf-98ce-41f9-9179-20141d5a4458	String	jsonType.label
0d6b9ce6-c814-41dd-9455-32685a7269e2	true	introspection.token.claim
0d6b9ce6-c814-41dd-9455-32685a7269e2	true	userinfo.token.claim
0d6b9ce6-c814-41dd-9455-32685a7269e2	username	user.attribute
0d6b9ce6-c814-41dd-9455-32685a7269e2	true	id.token.claim
0d6b9ce6-c814-41dd-9455-32685a7269e2	true	access.token.claim
0d6b9ce6-c814-41dd-9455-32685a7269e2	preferred_username	claim.name
0d6b9ce6-c814-41dd-9455-32685a7269e2	String	jsonType.label
15215401-80de-408e-a5af-b027f67119b6	true	introspection.token.claim
15215401-80de-408e-a5af-b027f67119b6	true	userinfo.token.claim
15215401-80de-408e-a5af-b027f67119b6	zoneinfo	user.attribute
15215401-80de-408e-a5af-b027f67119b6	true	id.token.claim
15215401-80de-408e-a5af-b027f67119b6	true	access.token.claim
15215401-80de-408e-a5af-b027f67119b6	zoneinfo	claim.name
15215401-80de-408e-a5af-b027f67119b6	String	jsonType.label
2105b735-e832-4151-b4f8-15a1b1b1f825	true	introspection.token.claim
2105b735-e832-4151-b4f8-15a1b1b1f825	true	userinfo.token.claim
2105b735-e832-4151-b4f8-15a1b1b1f825	firstName	user.attribute
2105b735-e832-4151-b4f8-15a1b1b1f825	true	id.token.claim
2105b735-e832-4151-b4f8-15a1b1b1f825	true	access.token.claim
2105b735-e832-4151-b4f8-15a1b1b1f825	given_name	claim.name
2105b735-e832-4151-b4f8-15a1b1b1f825	String	jsonType.label
2a2f4798-4de8-4d49-967c-56a76eb2f67c	true	introspection.token.claim
2a2f4798-4de8-4d49-967c-56a76eb2f67c	true	userinfo.token.claim
2a2f4798-4de8-4d49-967c-56a76eb2f67c	nickname	user.attribute
2a2f4798-4de8-4d49-967c-56a76eb2f67c	true	id.token.claim
2a2f4798-4de8-4d49-967c-56a76eb2f67c	true	access.token.claim
2a2f4798-4de8-4d49-967c-56a76eb2f67c	nickname	claim.name
2a2f4798-4de8-4d49-967c-56a76eb2f67c	String	jsonType.label
740ee28c-a91e-46db-9d92-d13750ca0e51	true	introspection.token.claim
740ee28c-a91e-46db-9d92-d13750ca0e51	true	userinfo.token.claim
740ee28c-a91e-46db-9d92-d13750ca0e51	updatedAt	user.attribute
740ee28c-a91e-46db-9d92-d13750ca0e51	true	id.token.claim
740ee28c-a91e-46db-9d92-d13750ca0e51	true	access.token.claim
740ee28c-a91e-46db-9d92-d13750ca0e51	updated_at	claim.name
740ee28c-a91e-46db-9d92-d13750ca0e51	long	jsonType.label
7703eed9-d825-47c6-9b08-a3f2ecd9cbfe	true	introspection.token.claim
7703eed9-d825-47c6-9b08-a3f2ecd9cbfe	true	userinfo.token.claim
7703eed9-d825-47c6-9b08-a3f2ecd9cbfe	birthdate	user.attribute
7703eed9-d825-47c6-9b08-a3f2ecd9cbfe	true	id.token.claim
7703eed9-d825-47c6-9b08-a3f2ecd9cbfe	true	access.token.claim
7703eed9-d825-47c6-9b08-a3f2ecd9cbfe	birthdate	claim.name
7703eed9-d825-47c6-9b08-a3f2ecd9cbfe	String	jsonType.label
7fc7e5a9-5b14-4e03-8ab2-daaf4ba610d3	true	introspection.token.claim
7fc7e5a9-5b14-4e03-8ab2-daaf4ba610d3	true	userinfo.token.claim
7fc7e5a9-5b14-4e03-8ab2-daaf4ba610d3	profile	user.attribute
7fc7e5a9-5b14-4e03-8ab2-daaf4ba610d3	true	id.token.claim
7fc7e5a9-5b14-4e03-8ab2-daaf4ba610d3	true	access.token.claim
7fc7e5a9-5b14-4e03-8ab2-daaf4ba610d3	profile	claim.name
7fc7e5a9-5b14-4e03-8ab2-daaf4ba610d3	String	jsonType.label
aa333910-14f1-41db-840f-803247e44a85	true	introspection.token.claim
aa333910-14f1-41db-840f-803247e44a85	true	userinfo.token.claim
aa333910-14f1-41db-840f-803247e44a85	picture	user.attribute
aa333910-14f1-41db-840f-803247e44a85	true	id.token.claim
aa333910-14f1-41db-840f-803247e44a85	true	access.token.claim
aa333910-14f1-41db-840f-803247e44a85	picture	claim.name
aa333910-14f1-41db-840f-803247e44a85	String	jsonType.label
b0aecf93-ade5-4d19-9be1-02c336782bbc	true	introspection.token.claim
b0aecf93-ade5-4d19-9be1-02c336782bbc	true	userinfo.token.claim
b0aecf93-ade5-4d19-9be1-02c336782bbc	true	id.token.claim
b0aecf93-ade5-4d19-9be1-02c336782bbc	true	access.token.claim
cdb9723f-e75f-4f77-9cdb-f0c2107e9fbe	true	introspection.token.claim
cdb9723f-e75f-4f77-9cdb-f0c2107e9fbe	true	userinfo.token.claim
cdb9723f-e75f-4f77-9cdb-f0c2107e9fbe	gender	user.attribute
cdb9723f-e75f-4f77-9cdb-f0c2107e9fbe	true	id.token.claim
cdb9723f-e75f-4f77-9cdb-f0c2107e9fbe	true	access.token.claim
cdb9723f-e75f-4f77-9cdb-f0c2107e9fbe	gender	claim.name
cdb9723f-e75f-4f77-9cdb-f0c2107e9fbe	String	jsonType.label
cdbd9f7c-d33e-4070-a3d3-1e0b4dfc5b6a	true	introspection.token.claim
cdbd9f7c-d33e-4070-a3d3-1e0b4dfc5b6a	true	userinfo.token.claim
cdbd9f7c-d33e-4070-a3d3-1e0b4dfc5b6a	website	user.attribute
cdbd9f7c-d33e-4070-a3d3-1e0b4dfc5b6a	true	id.token.claim
cdbd9f7c-d33e-4070-a3d3-1e0b4dfc5b6a	true	access.token.claim
cdbd9f7c-d33e-4070-a3d3-1e0b4dfc5b6a	website	claim.name
cdbd9f7c-d33e-4070-a3d3-1e0b4dfc5b6a	String	jsonType.label
e43f3be9-01e3-48ee-bb20-fe13729133c9	true	introspection.token.claim
e43f3be9-01e3-48ee-bb20-fe13729133c9	true	userinfo.token.claim
e43f3be9-01e3-48ee-bb20-fe13729133c9	middleName	user.attribute
e43f3be9-01e3-48ee-bb20-fe13729133c9	true	id.token.claim
e43f3be9-01e3-48ee-bb20-fe13729133c9	true	access.token.claim
e43f3be9-01e3-48ee-bb20-fe13729133c9	middle_name	claim.name
e43f3be9-01e3-48ee-bb20-fe13729133c9	String	jsonType.label
ec6b688a-1e1c-43fd-8b15-4c655580392d	true	introspection.token.claim
ec6b688a-1e1c-43fd-8b15-4c655580392d	true	userinfo.token.claim
ec6b688a-1e1c-43fd-8b15-4c655580392d	locale	user.attribute
ec6b688a-1e1c-43fd-8b15-4c655580392d	true	id.token.claim
ec6b688a-1e1c-43fd-8b15-4c655580392d	true	access.token.claim
ec6b688a-1e1c-43fd-8b15-4c655580392d	locale	claim.name
ec6b688a-1e1c-43fd-8b15-4c655580392d	String	jsonType.label
cbf918b6-463e-4fbd-9b76-e4cc084c85b1	true	introspection.token.claim
cbf918b6-463e-4fbd-9b76-e4cc084c85b1	true	userinfo.token.claim
cbf918b6-463e-4fbd-9b76-e4cc084c85b1	email	user.attribute
cbf918b6-463e-4fbd-9b76-e4cc084c85b1	true	id.token.claim
cbf918b6-463e-4fbd-9b76-e4cc084c85b1	true	access.token.claim
cbf918b6-463e-4fbd-9b76-e4cc084c85b1	email	claim.name
cbf918b6-463e-4fbd-9b76-e4cc084c85b1	String	jsonType.label
cdaf3792-fda2-49e0-af2d-aca0e0702444	true	introspection.token.claim
cdaf3792-fda2-49e0-af2d-aca0e0702444	true	userinfo.token.claim
cdaf3792-fda2-49e0-af2d-aca0e0702444	emailVerified	user.attribute
cdaf3792-fda2-49e0-af2d-aca0e0702444	true	id.token.claim
cdaf3792-fda2-49e0-af2d-aca0e0702444	true	access.token.claim
cdaf3792-fda2-49e0-af2d-aca0e0702444	email_verified	claim.name
cdaf3792-fda2-49e0-af2d-aca0e0702444	boolean	jsonType.label
b66c5627-6d44-4118-83c1-62fb3fb1440e	formatted	user.attribute.formatted
b66c5627-6d44-4118-83c1-62fb3fb1440e	country	user.attribute.country
b66c5627-6d44-4118-83c1-62fb3fb1440e	true	introspection.token.claim
b66c5627-6d44-4118-83c1-62fb3fb1440e	postal_code	user.attribute.postal_code
b66c5627-6d44-4118-83c1-62fb3fb1440e	true	userinfo.token.claim
b66c5627-6d44-4118-83c1-62fb3fb1440e	street	user.attribute.street
b66c5627-6d44-4118-83c1-62fb3fb1440e	true	id.token.claim
b66c5627-6d44-4118-83c1-62fb3fb1440e	region	user.attribute.region
b66c5627-6d44-4118-83c1-62fb3fb1440e	true	access.token.claim
b66c5627-6d44-4118-83c1-62fb3fb1440e	locality	user.attribute.locality
a3183658-7dd3-492e-a4fa-da5eece0f99e	true	introspection.token.claim
a3183658-7dd3-492e-a4fa-da5eece0f99e	true	userinfo.token.claim
a3183658-7dd3-492e-a4fa-da5eece0f99e	phoneNumber	user.attribute
a3183658-7dd3-492e-a4fa-da5eece0f99e	true	id.token.claim
a3183658-7dd3-492e-a4fa-da5eece0f99e	true	access.token.claim
a3183658-7dd3-492e-a4fa-da5eece0f99e	phone_number	claim.name
a3183658-7dd3-492e-a4fa-da5eece0f99e	String	jsonType.label
a780c3cf-5d4d-431f-ace3-3899e3707826	true	introspection.token.claim
a780c3cf-5d4d-431f-ace3-3899e3707826	true	userinfo.token.claim
a780c3cf-5d4d-431f-ace3-3899e3707826	phoneNumberVerified	user.attribute
a780c3cf-5d4d-431f-ace3-3899e3707826	true	id.token.claim
a780c3cf-5d4d-431f-ace3-3899e3707826	true	access.token.claim
a780c3cf-5d4d-431f-ace3-3899e3707826	phone_number_verified	claim.name
a780c3cf-5d4d-431f-ace3-3899e3707826	boolean	jsonType.label
00bcf51f-5ccf-4409-adc7-9941cea77ee2	true	introspection.token.claim
00bcf51f-5ccf-4409-adc7-9941cea77ee2	true	access.token.claim
85aca6e2-7fee-4576-91fe-63940bc26d44	true	introspection.token.claim
85aca6e2-7fee-4576-91fe-63940bc26d44	true	multivalued
85aca6e2-7fee-4576-91fe-63940bc26d44	foo	user.attribute
85aca6e2-7fee-4576-91fe-63940bc26d44	true	access.token.claim
85aca6e2-7fee-4576-91fe-63940bc26d44	resource_access.${client_id}.roles	claim.name
85aca6e2-7fee-4576-91fe-63940bc26d44	String	jsonType.label
9ab82265-867b-44c9-8035-563305e94ae9	true	introspection.token.claim
9ab82265-867b-44c9-8035-563305e94ae9	true	multivalued
9ab82265-867b-44c9-8035-563305e94ae9	foo	user.attribute
9ab82265-867b-44c9-8035-563305e94ae9	true	access.token.claim
9ab82265-867b-44c9-8035-563305e94ae9	realm_access.roles	claim.name
9ab82265-867b-44c9-8035-563305e94ae9	String	jsonType.label
d9395d89-8d50-4319-a4c1-d9f9dee37150	true	introspection.token.claim
d9395d89-8d50-4319-a4c1-d9f9dee37150	true	access.token.claim
6f525d75-ec87-4657-9d69-58b16c42434b	true	introspection.token.claim
6f525d75-ec87-4657-9d69-58b16c42434b	true	userinfo.token.claim
6f525d75-ec87-4657-9d69-58b16c42434b	username	user.attribute
6f525d75-ec87-4657-9d69-58b16c42434b	true	id.token.claim
6f525d75-ec87-4657-9d69-58b16c42434b	true	access.token.claim
6f525d75-ec87-4657-9d69-58b16c42434b	upn	claim.name
6f525d75-ec87-4657-9d69-58b16c42434b	String	jsonType.label
ad22045f-a128-4679-9db2-4c2e2b4686cb	true	introspection.token.claim
ad22045f-a128-4679-9db2-4c2e2b4686cb	true	multivalued
ad22045f-a128-4679-9db2-4c2e2b4686cb	foo	user.attribute
ad22045f-a128-4679-9db2-4c2e2b4686cb	true	id.token.claim
ad22045f-a128-4679-9db2-4c2e2b4686cb	true	access.token.claim
ad22045f-a128-4679-9db2-4c2e2b4686cb	groups	claim.name
ad22045f-a128-4679-9db2-4c2e2b4686cb	String	jsonType.label
56527ec9-7505-402c-bb0b-62f427383522	true	introspection.token.claim
56527ec9-7505-402c-bb0b-62f427383522	true	id.token.claim
56527ec9-7505-402c-bb0b-62f427383522	true	access.token.claim
e3d76689-d4f0-4441-8cc5-c1e2a9122c8f	true	introspection.token.claim
e3d76689-d4f0-4441-8cc5-c1e2a9122c8f	true	access.token.claim
f045166f-596e-41a7-b142-d7d58044bc50	AUTH_TIME	user.session.note
f045166f-596e-41a7-b142-d7d58044bc50	true	introspection.token.claim
f045166f-596e-41a7-b142-d7d58044bc50	true	id.token.claim
f045166f-596e-41a7-b142-d7d58044bc50	true	access.token.claim
f045166f-596e-41a7-b142-d7d58044bc50	auth_time	claim.name
f045166f-596e-41a7-b142-d7d58044bc50	long	jsonType.label
7e2e6bd5-c664-44ca-877d-f0d03cbdd674	true	introspection.token.claim
7e2e6bd5-c664-44ca-877d-f0d03cbdd674	true	multivalued
7e2e6bd5-c664-44ca-877d-f0d03cbdd674	true	id.token.claim
7e2e6bd5-c664-44ca-877d-f0d03cbdd674	true	access.token.claim
7e2e6bd5-c664-44ca-877d-f0d03cbdd674	organization	claim.name
7e2e6bd5-c664-44ca-877d-f0d03cbdd674	String	jsonType.label
a5f42024-b607-4292-b1d6-a9d4191bb4e8	true	introspection.token.claim
a5f42024-b607-4292-b1d6-a9d4191bb4e8	true	multivalued
a5f42024-b607-4292-b1d6-a9d4191bb4e8	true	userinfo.token.claim
a5f42024-b607-4292-b1d6-a9d4191bb4e8	foo	user.attribute
a5f42024-b607-4292-b1d6-a9d4191bb4e8	true	id.token.claim
a5f42024-b607-4292-b1d6-a9d4191bb4e8	true	access.token.claim
a5f42024-b607-4292-b1d6-a9d4191bb4e8	groups	claim.name
a5f42024-b607-4292-b1d6-a9d4191bb4e8	String	jsonType.label
e136e954-04d6-4224-bdb0-336990f7b794	true	introspection.token.claim
e136e954-04d6-4224-bdb0-336990f7b794	true	userinfo.token.claim
e136e954-04d6-4224-bdb0-336990f7b794	username	user.attribute
e136e954-04d6-4224-bdb0-336990f7b794	true	id.token.claim
e136e954-04d6-4224-bdb0-336990f7b794	true	access.token.claim
e136e954-04d6-4224-bdb0-336990f7b794	upn	claim.name
e136e954-04d6-4224-bdb0-336990f7b794	String	jsonType.label
2caf2e3b-868c-48c5-a684-532529b920ed	AUTH_TIME	user.session.note
2caf2e3b-868c-48c5-a684-532529b920ed	true	introspection.token.claim
2caf2e3b-868c-48c5-a684-532529b920ed	true	userinfo.token.claim
2caf2e3b-868c-48c5-a684-532529b920ed	true	id.token.claim
2caf2e3b-868c-48c5-a684-532529b920ed	true	access.token.claim
2caf2e3b-868c-48c5-a684-532529b920ed	auth_time	claim.name
2caf2e3b-868c-48c5-a684-532529b920ed	long	jsonType.label
f01993e4-4569-476a-927b-c5586ca133e4	true	introspection.token.claim
f01993e4-4569-476a-927b-c5586ca133e4	true	access.token.claim
8813051b-d5db-4a74-82e3-440d85bd6d1f	true	introspection.token.claim
8813051b-d5db-4a74-82e3-440d85bd6d1f	true	userinfo.token.claim
8813051b-d5db-4a74-82e3-440d85bd6d1f	emailVerified	user.attribute
8813051b-d5db-4a74-82e3-440d85bd6d1f	true	id.token.claim
8813051b-d5db-4a74-82e3-440d85bd6d1f	true	access.token.claim
8813051b-d5db-4a74-82e3-440d85bd6d1f	email_verified	claim.name
8813051b-d5db-4a74-82e3-440d85bd6d1f	boolean	jsonType.label
ae9358a3-2b41-4860-87e3-d24dd15d5d71	true	introspection.token.claim
ae9358a3-2b41-4860-87e3-d24dd15d5d71	true	userinfo.token.claim
ae9358a3-2b41-4860-87e3-d24dd15d5d71	email	user.attribute
ae9358a3-2b41-4860-87e3-d24dd15d5d71	true	id.token.claim
ae9358a3-2b41-4860-87e3-d24dd15d5d71	true	access.token.claim
ae9358a3-2b41-4860-87e3-d24dd15d5d71	email	claim.name
ae9358a3-2b41-4860-87e3-d24dd15d5d71	String	jsonType.label
6330cb1c-d510-4162-aa76-14fee2a149b9	foo	user.attribute
6330cb1c-d510-4162-aa76-14fee2a149b9	true	introspection.token.claim
6330cb1c-d510-4162-aa76-14fee2a149b9	true	access.token.claim
6330cb1c-d510-4162-aa76-14fee2a149b9	resource_access.${client_id}.roles	claim.name
6330cb1c-d510-4162-aa76-14fee2a149b9	String	jsonType.label
6330cb1c-d510-4162-aa76-14fee2a149b9	true	multivalued
8e4d50f6-3d11-45c7-bd5e-99bcc95ea419	foo	user.attribute
8e4d50f6-3d11-45c7-bd5e-99bcc95ea419	true	introspection.token.claim
8e4d50f6-3d11-45c7-bd5e-99bcc95ea419	true	access.token.claim
8e4d50f6-3d11-45c7-bd5e-99bcc95ea419	realm_access.roles	claim.name
8e4d50f6-3d11-45c7-bd5e-99bcc95ea419	String	jsonType.label
8e4d50f6-3d11-45c7-bd5e-99bcc95ea419	true	multivalued
f57565ee-061d-45dd-ae51-83f3a62959ab	true	introspection.token.claim
f57565ee-061d-45dd-ae51-83f3a62959ab	true	access.token.claim
0a7b1fe6-0cd1-4df4-8651-5157a202e9e8	true	introspection.token.claim
0a7b1fe6-0cd1-4df4-8651-5157a202e9e8	true	userinfo.token.claim
0a7b1fe6-0cd1-4df4-8651-5157a202e9e8	phoneNumberVerified	user.attribute
0a7b1fe6-0cd1-4df4-8651-5157a202e9e8	true	id.token.claim
0a7b1fe6-0cd1-4df4-8651-5157a202e9e8	true	access.token.claim
0a7b1fe6-0cd1-4df4-8651-5157a202e9e8	phone_number_verified	claim.name
0a7b1fe6-0cd1-4df4-8651-5157a202e9e8	boolean	jsonType.label
435c261a-73d4-47e1-a692-0ebd814c2127	true	introspection.token.claim
435c261a-73d4-47e1-a692-0ebd814c2127	true	userinfo.token.claim
435c261a-73d4-47e1-a692-0ebd814c2127	phoneNumber	user.attribute
435c261a-73d4-47e1-a692-0ebd814c2127	true	id.token.claim
435c261a-73d4-47e1-a692-0ebd814c2127	true	access.token.claim
435c261a-73d4-47e1-a692-0ebd814c2127	phone_number	claim.name
435c261a-73d4-47e1-a692-0ebd814c2127	String	jsonType.label
99eee510-c44b-4d69-90d8-66de184021af	true	introspection.token.claim
99eee510-c44b-4d69-90d8-66de184021af	true	multivalued
99eee510-c44b-4d69-90d8-66de184021af	true	userinfo.token.claim
99eee510-c44b-4d69-90d8-66de184021af	true	id.token.claim
99eee510-c44b-4d69-90d8-66de184021af	true	access.token.claim
99eee510-c44b-4d69-90d8-66de184021af	organization	claim.name
99eee510-c44b-4d69-90d8-66de184021af	String	jsonType.label
acd8cbcc-451d-435a-8c40-dc45ea11930f	true	introspection.token.claim
acd8cbcc-451d-435a-8c40-dc45ea11930f	true	access.token.claim
889dd164-8ceb-4f81-ba6e-c407504a095b	formatted	user.attribute.formatted
889dd164-8ceb-4f81-ba6e-c407504a095b	country	user.attribute.country
889dd164-8ceb-4f81-ba6e-c407504a095b	true	introspection.token.claim
889dd164-8ceb-4f81-ba6e-c407504a095b	postal_code	user.attribute.postal_code
889dd164-8ceb-4f81-ba6e-c407504a095b	true	userinfo.token.claim
889dd164-8ceb-4f81-ba6e-c407504a095b	street	user.attribute.street
889dd164-8ceb-4f81-ba6e-c407504a095b	true	id.token.claim
889dd164-8ceb-4f81-ba6e-c407504a095b	region	user.attribute.region
889dd164-8ceb-4f81-ba6e-c407504a095b	true	access.token.claim
889dd164-8ceb-4f81-ba6e-c407504a095b	locality	user.attribute.locality
24baf309-3ddf-4d72-bbb9-6cf1b5f23312	true	id.token.claim
24baf309-3ddf-4d72-bbb9-6cf1b5f23312	true	introspection.token.claim
24baf309-3ddf-4d72-bbb9-6cf1b5f23312	true	access.token.claim
24baf309-3ddf-4d72-bbb9-6cf1b5f23312	true	userinfo.token.claim
58e945c2-28cf-4f53-8add-aed444f92a27	false	single
58e945c2-28cf-4f53-8add-aed444f92a27	Basic	attribute.nameformat
58e945c2-28cf-4f53-8add-aed444f92a27	Role	attribute.name
258a5ec2-f843-4c10-906d-a6503d3980fb	true	introspection.token.claim
258a5ec2-f843-4c10-906d-a6503d3980fb	true	userinfo.token.claim
258a5ec2-f843-4c10-906d-a6503d3980fb	profile	user.attribute
258a5ec2-f843-4c10-906d-a6503d3980fb	true	id.token.claim
258a5ec2-f843-4c10-906d-a6503d3980fb	true	access.token.claim
258a5ec2-f843-4c10-906d-a6503d3980fb	profile	claim.name
258a5ec2-f843-4c10-906d-a6503d3980fb	String	jsonType.label
391d2d4b-263f-4a6b-9a3d-593c2aee3556	true	introspection.token.claim
391d2d4b-263f-4a6b-9a3d-593c2aee3556	true	userinfo.token.claim
391d2d4b-263f-4a6b-9a3d-593c2aee3556	gender	user.attribute
391d2d4b-263f-4a6b-9a3d-593c2aee3556	true	id.token.claim
391d2d4b-263f-4a6b-9a3d-593c2aee3556	true	access.token.claim
391d2d4b-263f-4a6b-9a3d-593c2aee3556	gender	claim.name
391d2d4b-263f-4a6b-9a3d-593c2aee3556	String	jsonType.label
3d6eeab9-d603-4896-9ed4-69b41a007b4e	true	introspection.token.claim
3d6eeab9-d603-4896-9ed4-69b41a007b4e	true	userinfo.token.claim
3d6eeab9-d603-4896-9ed4-69b41a007b4e	birthdate	user.attribute
3d6eeab9-d603-4896-9ed4-69b41a007b4e	true	id.token.claim
3d6eeab9-d603-4896-9ed4-69b41a007b4e	true	access.token.claim
3d6eeab9-d603-4896-9ed4-69b41a007b4e	birthdate	claim.name
3d6eeab9-d603-4896-9ed4-69b41a007b4e	String	jsonType.label
46ece9ad-d834-417f-b776-c57aeab5cd07	true	introspection.token.claim
46ece9ad-d834-417f-b776-c57aeab5cd07	true	userinfo.token.claim
46ece9ad-d834-417f-b776-c57aeab5cd07	lastName	user.attribute
46ece9ad-d834-417f-b776-c57aeab5cd07	true	id.token.claim
46ece9ad-d834-417f-b776-c57aeab5cd07	true	access.token.claim
46ece9ad-d834-417f-b776-c57aeab5cd07	family_name	claim.name
46ece9ad-d834-417f-b776-c57aeab5cd07	String	jsonType.label
5dde0842-f155-4f2b-9e61-b3967ae0a857	true	introspection.token.claim
5dde0842-f155-4f2b-9e61-b3967ae0a857	true	userinfo.token.claim
5dde0842-f155-4f2b-9e61-b3967ae0a857	username	user.attribute
5dde0842-f155-4f2b-9e61-b3967ae0a857	true	id.token.claim
5dde0842-f155-4f2b-9e61-b3967ae0a857	true	access.token.claim
5dde0842-f155-4f2b-9e61-b3967ae0a857	preferred_username	claim.name
5dde0842-f155-4f2b-9e61-b3967ae0a857	String	jsonType.label
7e7a6a27-bcf1-4cdc-8668-149916b2169b	true	introspection.token.claim
7e7a6a27-bcf1-4cdc-8668-149916b2169b	true	userinfo.token.claim
7e7a6a27-bcf1-4cdc-8668-149916b2169b	middleName	user.attribute
7e7a6a27-bcf1-4cdc-8668-149916b2169b	true	id.token.claim
7e7a6a27-bcf1-4cdc-8668-149916b2169b	true	access.token.claim
7e7a6a27-bcf1-4cdc-8668-149916b2169b	middle_name	claim.name
7e7a6a27-bcf1-4cdc-8668-149916b2169b	String	jsonType.label
80592ea1-cf85-4beb-9021-ed452c7bd293	true	id.token.claim
80592ea1-cf85-4beb-9021-ed452c7bd293	true	introspection.token.claim
80592ea1-cf85-4beb-9021-ed452c7bd293	true	access.token.claim
80592ea1-cf85-4beb-9021-ed452c7bd293	true	userinfo.token.claim
92baff2a-9f19-4614-a5a8-5dd0c4e24c39	true	introspection.token.claim
92baff2a-9f19-4614-a5a8-5dd0c4e24c39	true	userinfo.token.claim
92baff2a-9f19-4614-a5a8-5dd0c4e24c39	picture	user.attribute
92baff2a-9f19-4614-a5a8-5dd0c4e24c39	true	id.token.claim
92baff2a-9f19-4614-a5a8-5dd0c4e24c39	true	access.token.claim
92baff2a-9f19-4614-a5a8-5dd0c4e24c39	picture	claim.name
92baff2a-9f19-4614-a5a8-5dd0c4e24c39	String	jsonType.label
a51f9041-9d8d-498a-b62b-a5c4e24141b6	true	introspection.token.claim
a51f9041-9d8d-498a-b62b-a5c4e24141b6	true	userinfo.token.claim
a51f9041-9d8d-498a-b62b-a5c4e24141b6	website	user.attribute
a51f9041-9d8d-498a-b62b-a5c4e24141b6	true	id.token.claim
a51f9041-9d8d-498a-b62b-a5c4e24141b6	true	access.token.claim
a51f9041-9d8d-498a-b62b-a5c4e24141b6	website	claim.name
a51f9041-9d8d-498a-b62b-a5c4e24141b6	String	jsonType.label
afc27d87-0a4a-4d6c-b8cb-59b80d0aca7d	true	introspection.token.claim
afc27d87-0a4a-4d6c-b8cb-59b80d0aca7d	true	userinfo.token.claim
afc27d87-0a4a-4d6c-b8cb-59b80d0aca7d	zoneinfo	user.attribute
afc27d87-0a4a-4d6c-b8cb-59b80d0aca7d	true	id.token.claim
afc27d87-0a4a-4d6c-b8cb-59b80d0aca7d	true	access.token.claim
afc27d87-0a4a-4d6c-b8cb-59b80d0aca7d	zoneinfo	claim.name
afc27d87-0a4a-4d6c-b8cb-59b80d0aca7d	String	jsonType.label
b1d9a82a-d1c2-4200-b351-e53021527707	true	introspection.token.claim
b1d9a82a-d1c2-4200-b351-e53021527707	true	userinfo.token.claim
b1d9a82a-d1c2-4200-b351-e53021527707	firstName	user.attribute
b1d9a82a-d1c2-4200-b351-e53021527707	true	id.token.claim
b1d9a82a-d1c2-4200-b351-e53021527707	true	access.token.claim
b1d9a82a-d1c2-4200-b351-e53021527707	given_name	claim.name
b1d9a82a-d1c2-4200-b351-e53021527707	String	jsonType.label
b605f71d-5400-4282-a700-b288d5d7eb14	true	introspection.token.claim
b605f71d-5400-4282-a700-b288d5d7eb14	true	userinfo.token.claim
b605f71d-5400-4282-a700-b288d5d7eb14	updatedAt	user.attribute
b605f71d-5400-4282-a700-b288d5d7eb14	true	id.token.claim
b605f71d-5400-4282-a700-b288d5d7eb14	true	access.token.claim
b605f71d-5400-4282-a700-b288d5d7eb14	updated_at	claim.name
b605f71d-5400-4282-a700-b288d5d7eb14	long	jsonType.label
b8ca6d7d-1b82-4ae5-b158-3b61a3874813	true	introspection.token.claim
b8ca6d7d-1b82-4ae5-b158-3b61a3874813	true	userinfo.token.claim
b8ca6d7d-1b82-4ae5-b158-3b61a3874813	locale	user.attribute
b8ca6d7d-1b82-4ae5-b158-3b61a3874813	true	id.token.claim
b8ca6d7d-1b82-4ae5-b158-3b61a3874813	true	access.token.claim
b8ca6d7d-1b82-4ae5-b158-3b61a3874813	locale	claim.name
b8ca6d7d-1b82-4ae5-b158-3b61a3874813	String	jsonType.label
deb37ced-49bd-4237-b3ab-65fc416ad14f	true	introspection.token.claim
deb37ced-49bd-4237-b3ab-65fc416ad14f	true	userinfo.token.claim
deb37ced-49bd-4237-b3ab-65fc416ad14f	nickname	user.attribute
deb37ced-49bd-4237-b3ab-65fc416ad14f	true	id.token.claim
deb37ced-49bd-4237-b3ab-65fc416ad14f	true	access.token.claim
deb37ced-49bd-4237-b3ab-65fc416ad14f	nickname	claim.name
deb37ced-49bd-4237-b3ab-65fc416ad14f	String	jsonType.label
fede70dd-d1c5-4408-a082-a5f0364195d6	true	introspection.token.claim
fede70dd-d1c5-4408-a082-a5f0364195d6	true	userinfo.token.claim
fede70dd-d1c5-4408-a082-a5f0364195d6	locale	user.attribute
fede70dd-d1c5-4408-a082-a5f0364195d6	true	id.token.claim
fede70dd-d1c5-4408-a082-a5f0364195d6	true	access.token.claim
fede70dd-d1c5-4408-a082-a5f0364195d6	locale	claim.name
fede70dd-d1c5-4408-a082-a5f0364195d6	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	9093a96a-50fe-40b6-bf7c-e1f1aced8156	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	bda78048-1390-400a-bda8-e9b89d57a529	0baf5a45-b260-47aa-bc63-a7b8d55ac82d	87e21c40-5a38-4ded-aa9a-ee5be3a859a8	796c5d7a-3347-40e5-b5a1-a4619d20160a	694edd3e-70c6-49df-9727-e7eec3ffccc8	2592000	f	900	t	f	0cb2e244-077b-4fd0-b3c0-8cd68b504ba9	0	f	0	0	364fc902-cac0-422a-b35b-6118125dd0a2
83b6664d-539e-4bed-a376-685d50e40b98	60	300	300	\N	\N	\N	t	f	0	\N	loci-realm	0	\N	t	t	t	f	EXTERNAL	1800	36000	f	f	08e86e5c-c7f2-470c-9425-b13f68d7f1bb	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	801e570d-bc15-45e3-9f8e-afe9f8f28dec	8c356fe3-6843-440d-ac93-b4cc6352781f	d7b8234b-3d04-4263-ac07-79794e3fb8c0	2ec9ca75-4f99-43e9-816d-708c9a550838	05607ab5-8839-424c-b1e7-7f0ccad2063e	2592000	f	900	t	f	08caf47c-2dda-42d5-a33d-3df1271e703c	0	f	0	0	929392ee-0474-4ed0-a64e-9b0132025c91
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	
_browser_header.xContentTypeOptions	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	nosniff
_browser_header.referrerPolicy	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	no-referrer
_browser_header.xRobotsTag	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	none
_browser_header.xFrameOptions	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	SAMEORIGIN
_browser_header.contentSecurityPolicy	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	1; mode=block
_browser_header.strictTransportSecurity	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	max-age=31536000; includeSubDomains
bruteForceProtected	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	false
permanentLockout	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	false
maxTemporaryLockouts	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	0
maxFailureWaitSeconds	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	900
minimumQuickLoginWaitSeconds	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	60
waitIncrementSeconds	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	60
quickLoginCheckMilliSeconds	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	1000
maxDeltaTimeSeconds	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	43200
failureFactor	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	30
realmReusableOtpCode	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	false
firstBrokerLoginFlowId	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	ca40da1e-78e1-4f29-90b6-995359635938
displayName	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	Keycloak
displayNameHtml	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	RS256
offlineSessionMaxLifespanEnabled	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	false
offlineSessionMaxLifespan	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	5184000
_browser_header.contentSecurityPolicyReportOnly	83b6664d-539e-4bed-a376-685d50e40b98	
_browser_header.xContentTypeOptions	83b6664d-539e-4bed-a376-685d50e40b98	nosniff
_browser_header.referrerPolicy	83b6664d-539e-4bed-a376-685d50e40b98	no-referrer
_browser_header.xRobotsTag	83b6664d-539e-4bed-a376-685d50e40b98	none
_browser_header.xFrameOptions	83b6664d-539e-4bed-a376-685d50e40b98	SAMEORIGIN
_browser_header.contentSecurityPolicy	83b6664d-539e-4bed-a376-685d50e40b98	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	83b6664d-539e-4bed-a376-685d50e40b98	1; mode=block
_browser_header.strictTransportSecurity	83b6664d-539e-4bed-a376-685d50e40b98	max-age=31536000; includeSubDomains
bruteForceProtected	83b6664d-539e-4bed-a376-685d50e40b98	false
permanentLockout	83b6664d-539e-4bed-a376-685d50e40b98	false
maxTemporaryLockouts	83b6664d-539e-4bed-a376-685d50e40b98	0
maxFailureWaitSeconds	83b6664d-539e-4bed-a376-685d50e40b98	900
minimumQuickLoginWaitSeconds	83b6664d-539e-4bed-a376-685d50e40b98	60
waitIncrementSeconds	83b6664d-539e-4bed-a376-685d50e40b98	60
quickLoginCheckMilliSeconds	83b6664d-539e-4bed-a376-685d50e40b98	1000
maxDeltaTimeSeconds	83b6664d-539e-4bed-a376-685d50e40b98	43200
failureFactor	83b6664d-539e-4bed-a376-685d50e40b98	30
realmReusableOtpCode	83b6664d-539e-4bed-a376-685d50e40b98	false
defaultSignatureAlgorithm	83b6664d-539e-4bed-a376-685d50e40b98	RS256
offlineSessionMaxLifespanEnabled	83b6664d-539e-4bed-a376-685d50e40b98	false
offlineSessionMaxLifespan	83b6664d-539e-4bed-a376-685d50e40b98	5184000
clientSessionIdleTimeout	83b6664d-539e-4bed-a376-685d50e40b98	0
clientSessionMaxLifespan	83b6664d-539e-4bed-a376-685d50e40b98	0
clientOfflineSessionIdleTimeout	83b6664d-539e-4bed-a376-685d50e40b98	0
clientOfflineSessionMaxLifespan	83b6664d-539e-4bed-a376-685d50e40b98	0
actionTokenGeneratedByAdminLifespan	83b6664d-539e-4bed-a376-685d50e40b98	43200
actionTokenGeneratedByUserLifespan	83b6664d-539e-4bed-a376-685d50e40b98	300
oauth2DeviceCodeLifespan	83b6664d-539e-4bed-a376-685d50e40b98	600
oauth2DevicePollingInterval	83b6664d-539e-4bed-a376-685d50e40b98	5
organizationsEnabled	83b6664d-539e-4bed-a376-685d50e40b98	false
webAuthnPolicyRpEntityName	83b6664d-539e-4bed-a376-685d50e40b98	keycloak
webAuthnPolicySignatureAlgorithms	83b6664d-539e-4bed-a376-685d50e40b98	ES256,RS256
webAuthnPolicyRpId	83b6664d-539e-4bed-a376-685d50e40b98	
webAuthnPolicyAttestationConveyancePreference	83b6664d-539e-4bed-a376-685d50e40b98	not specified
webAuthnPolicyAuthenticatorAttachment	83b6664d-539e-4bed-a376-685d50e40b98	not specified
webAuthnPolicyRequireResidentKey	83b6664d-539e-4bed-a376-685d50e40b98	not specified
webAuthnPolicyUserVerificationRequirement	83b6664d-539e-4bed-a376-685d50e40b98	not specified
webAuthnPolicyCreateTimeout	83b6664d-539e-4bed-a376-685d50e40b98	0
webAuthnPolicyAvoidSameAuthenticatorRegister	83b6664d-539e-4bed-a376-685d50e40b98	false
webAuthnPolicyRpEntityNamePasswordless	83b6664d-539e-4bed-a376-685d50e40b98	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	83b6664d-539e-4bed-a376-685d50e40b98	ES256,RS256
webAuthnPolicyRpIdPasswordless	83b6664d-539e-4bed-a376-685d50e40b98	
webAuthnPolicyAttestationConveyancePreferencePasswordless	83b6664d-539e-4bed-a376-685d50e40b98	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	83b6664d-539e-4bed-a376-685d50e40b98	not specified
webAuthnPolicyRequireResidentKeyPasswordless	83b6664d-539e-4bed-a376-685d50e40b98	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	83b6664d-539e-4bed-a376-685d50e40b98	not specified
webAuthnPolicyCreateTimeoutPasswordless	83b6664d-539e-4bed-a376-685d50e40b98	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	83b6664d-539e-4bed-a376-685d50e40b98	false
cibaBackchannelTokenDeliveryMode	83b6664d-539e-4bed-a376-685d50e40b98	poll
cibaExpiresIn	83b6664d-539e-4bed-a376-685d50e40b98	120
cibaInterval	83b6664d-539e-4bed-a376-685d50e40b98	5
cibaAuthRequestedUserHint	83b6664d-539e-4bed-a376-685d50e40b98	login_hint
parRequestUriLifespan	83b6664d-539e-4bed-a376-685d50e40b98	60
firstBrokerLoginFlowId	83b6664d-539e-4bed-a376-685d50e40b98	668883be-9b51-42f6-9e35-cb35d7961852
client-policies.profiles	83b6664d-539e-4bed-a376-685d50e40b98	{"profiles":[]}
client-policies.policies	83b6664d-539e-4bed-a376-685d50e40b98	{"policies":[]}
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	jboss-logging
83b6664d-539e-4bed-a376-685d50e40b98	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd
password	password	t	t	83b6664d-539e-4bed-a376-685d50e40b98
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.redirect_uris (client_id, value) FROM stdin;
06b5aa2a-ec1a-4e4e-8c3b-e3c2ed910a57	/realms/master/account/*
f9df92a9-f77e-4712-b20c-c75d66801f73	/realms/master/account/*
d4163211-b255-4df3-98fb-fd48febf1cfe	/admin/master/console/*
cb847cf7-5d97-441b-b7dd-a6f1a47689a2	/realms/loci-realm/account/*
1512bb33-3ef4-4dad-af1f-47081a2a75dc	/realms/loci-realm/account/*
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	http://192.168.1.21:4200/*
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	http://localhost:4200/*
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	http://192.168.1.21:4200/
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	http://localhost:4200/
d004af51-9d2e-47d3-9340-a3a411f42029	http://localhost:8080/*
ba4de397-daf8-404b-ad79-249e4d09a713	/admin/loci-realm/console/*
e85deedd-b2fb-47d3-acef-508423a77f22	http://localhost:8080/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
f4af2fd8-5998-4f79-979a-d835e892d624	VERIFY_EMAIL	Verify Email	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	t	f	VERIFY_EMAIL	50
0745736b-a80c-4b56-a398-4fdb4b6a742a	UPDATE_PROFILE	Update Profile	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	t	f	UPDATE_PROFILE	40
6ac45712-381f-4df6-bd47-a72ed422b377	CONFIGURE_TOTP	Configure OTP	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	t	f	CONFIGURE_TOTP	10
bc9167d3-a32c-42b4-89dc-1cacf9ce65ec	UPDATE_PASSWORD	Update Password	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	t	f	UPDATE_PASSWORD	30
3192f618-1864-4307-b0c5-708d6cfe5e97	TERMS_AND_CONDITIONS	Terms and Conditions	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	f	f	TERMS_AND_CONDITIONS	20
64088e80-1ca5-49bc-9f82-0c3d1fd5a7b8	delete_account	Delete Account	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	f	f	delete_account	60
d390e4fd-995e-4260-abfe-f48d3edfa81f	delete_credential	Delete Credential	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	t	f	delete_credential	100
8064a9a6-30df-4dd1-936b-74409d19f751	update_user_locale	Update User Locale	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	t	f	update_user_locale	1000
24b21f7b-b862-4391-bd47-457e7c19ecc0	webauthn-register	Webauthn Register	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	t	f	webauthn-register	70
ed96b36b-b08b-4e39-8c1b-d5352df5dc23	webauthn-register-passwordless	Webauthn Register Passwordless	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	t	f	webauthn-register-passwordless	80
e557f01a-700b-46cf-ae7e-619a2b58dddc	VERIFY_PROFILE	Verify Profile	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	t	f	VERIFY_PROFILE	90
cd8e1747-4cf4-4baa-a824-035c6f8bb839	CONFIGURE_TOTP	Configure OTP	83b6664d-539e-4bed-a376-685d50e40b98	t	f	CONFIGURE_TOTP	10
2fd68220-1c81-4256-aea7-a10ebe27483d	TERMS_AND_CONDITIONS	Terms and Conditions	83b6664d-539e-4bed-a376-685d50e40b98	f	f	TERMS_AND_CONDITIONS	20
aaca67d8-b127-495d-a269-ac52c1f60f3c	UPDATE_PASSWORD	Update Password	83b6664d-539e-4bed-a376-685d50e40b98	t	f	UPDATE_PASSWORD	30
f107838a-bcc9-48f5-bc1b-493bfe71f49c	UPDATE_PROFILE	Update Profile	83b6664d-539e-4bed-a376-685d50e40b98	t	f	UPDATE_PROFILE	40
535ba0a0-1d05-42e7-b40f-d2017a06b3d9	VERIFY_EMAIL	Verify Email	83b6664d-539e-4bed-a376-685d50e40b98	t	f	VERIFY_EMAIL	50
6633df2e-f770-48c8-a1ce-e195867a55ad	delete_account	Delete Account	83b6664d-539e-4bed-a376-685d50e40b98	f	f	delete_account	60
28bc1116-eb5d-41fe-9131-2dbcd1ad25be	webauthn-register	Webauthn Register	83b6664d-539e-4bed-a376-685d50e40b98	t	f	webauthn-register	70
1136241b-a441-4736-9762-819d19696ff9	webauthn-register-passwordless	Webauthn Register Passwordless	83b6664d-539e-4bed-a376-685d50e40b98	t	f	webauthn-register-passwordless	80
4cf7b74f-95cc-494b-8ca2-f322a7a96527	VERIFY_PROFILE	Verify Profile	83b6664d-539e-4bed-a376-685d50e40b98	t	f	VERIFY_PROFILE	90
ad156c91-939c-4430-a798-02b2f92502b8	delete_credential	Delete Credential	83b6664d-539e-4bed-a376-685d50e40b98	t	f	delete_credential	100
0eeef5e6-7731-4a1b-b146-64d1dabcb1c3	update_user_locale	Update User Locale	83b6664d-539e-4bed-a376-685d50e40b98	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
f9df92a9-f77e-4712-b20c-c75d66801f73	c87dc21b-1a54-4193-901b-4c533c2e531c
f9df92a9-f77e-4712-b20c-c75d66801f73	2b26d843-e9e3-4b8c-859f-a9d62d8c48fb
1512bb33-3ef4-4dad-af1f-47081a2a75dc	cd9c2212-1347-472e-8e9f-20be2bfc2ec2
1512bb33-3ef4-4dad-af1f-47081a2a75dc	710ed846-759e-45bc-afa4-bb5ef183d08c
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_ (profile_visibility, created_date, id, last_active, last_modified_date, last_seen, public_id, bio, email, firstname, image_url, lastname, profile_picture, username) FROM stdin;
\N	2026-01-13 13:50:59.520853+00	121	2026-01-13 13:50:59.224275+00	2026-01-13 13:50:59.520853+00	\N	6e52f7d5-e6cc-4684-9a3d-315fa0f4d88a	\N	testuser1@gmail.com	kien	\N	trung	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=650	testuser1
\N	2026-01-14 00:55:45.345015+00	123	2026-01-14 00:55:44.716283+00	2026-01-14 00:55:45.345015+00	\N	811fb141-3b20-46ff-a70d-893ad57bc2b7	\N	corazon.quigley@gmail.com	Brekke	\N	Dorene	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=383	corazon.quigley@gmail.com
\N	2026-01-14 00:56:10.720957+00	124	2026-01-14 00:56:10.633729+00	2026-01-14 00:56:10.720957+00	\N	0f2d5e36-cd9f-4304-9225-f59a0a9bb41b	\N	alaina.goyette@gmail.com	Schamberger	\N	Janean	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=299	alaina.goyette@gmail.com
\N	2026-01-14 00:56:33.814905+00	126	2026-01-14 00:56:33.741585+00	2026-01-14 00:56:33.814905+00	\N	84677ef2-efb5-4b26-a873-576fbf07cc01	\N	bryon.reilly@yahoo.com	Goldner	\N	Junita	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=165	bryon.reilly@yahoo.com
\N	2026-01-14 00:56:46.298017+00	129	2026-01-14 00:56:46.278178+00	2026-01-14 00:56:46.298017+00	\N	e7edb997-a98e-4c69-8df4-4816ea07cc02	\N	cedric.rau@yahoo.com	Hammes	\N	Hong	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=834	cedric.rau@yahoo.com
\N	2026-01-14 00:57:01.695365+00	131	2026-01-14 00:57:01.637543+00	2026-01-14 00:57:01.695365+00	\N	ce705ccf-7992-4b59-894c-c545e974a6ff	\N	earle.wilderman@yahoo.com	Bradtke	\N	Tory	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=254	earle.wilderman@yahoo.com
\N	2026-01-14 00:57:13.997977+00	132	2026-01-14 00:57:13.970179+00	2026-01-14 00:57:13.997977+00	\N	b6117c65-322b-44dd-a6ed-d4c10c3f6570	\N	eugenie.goldner@gmail.com	Weimann	\N	Davida	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=59	eugenie.goldner@gmail.com
\N	2026-01-14 00:57:26.226411+00	134	2026-01-14 00:57:26.199232+00	2026-01-14 00:57:26.226411+00	\N	66290bea-3de1-4374-ae97-3539c03c1d00	\N	fanny.jakubowski@gmail.com	Wilkinson	\N	Viola	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=106	fanny.jakubowski@gmail.com
\N	2026-01-14 00:57:37.975727+00	136	2026-01-14 00:57:37.947636+00	2026-01-14 00:57:37.975727+00	\N	62487fbb-adfb-4ce3-9ed6-a8ffb3fa275c	\N	gidget.bergstrom@yahoo.com	Doyle	\N	Kaylee	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=944	gidget.bergstrom@yahoo.com
\N	2026-01-14 00:57:49.470342+00	138	2026-01-14 00:57:49.449599+00	2026-01-14 00:57:49.470342+00	\N	0f763627-0fc4-4ff1-b356-d71858522e57	\N	glady.conn@yahoo.com	Hessel	\N	Fatima	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=524	glady.conn@yahoo.com
\N	2026-01-14 00:58:47.327198+00	140	2026-01-14 00:58:47.310849+00	2026-01-14 00:58:47.327198+00	\N	ad320cf1-5f0c-417e-a18a-3cb9aa7b87bc	\N	halley.balistreri@gmail.com	Collier	\N	Jaquelyn	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=355	halley.balistreri@gmail.com
\N	2026-01-14 00:59:13.64748+00	142	2026-01-14 00:59:13.634406+00	2026-01-14 00:59:13.64748+00	\N	3bc7c82c-4b9c-4ae0-bc65-29ef003a255a	\N	jae.koch@yahoo.com	Graham	\N	Sage	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=954	jae.koch@yahoo.com
\N	2026-01-14 01:00:57.07399+00	144	2026-01-14 01:00:57.060142+00	2026-01-14 01:00:57.07399+00	\N	ced8277f-b014-4e7c-86b9-5628b0e2a330	\N	jung.heidenreich@gmail.com	Beier	\N	Galen	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=842	jung.heidenreich@gmail.com
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	acfe4112-d87d-4f95-86eb-d817c80a1666	fd696fdc-5f40-4a13-a532-6d11586dfa8c	\N	\N	\N
\.


--
-- Data for Name: user_authority; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_authority (user_id, authority_name) FROM stdin;
121	ROLE_default-roles-loci-realm
121	ROLE_uma_authorization
121	ROLE_user
121	ROLE_offline_access
123	ROLE_default-roles-loci-realm
123	ROLE_uma_authorization
123	ROLE_user
123	ROLE_offline_access
124	ROLE_default-roles-loci-realm
124	ROLE_uma_authorization
124	ROLE_user
124	ROLE_offline_access
126	ROLE_default-roles-loci-realm
126	ROLE_uma_authorization
126	ROLE_user
126	ROLE_offline_access
129	ROLE_default-roles-loci-realm
129	ROLE_uma_authorization
129	ROLE_user
129	ROLE_offline_access
131	ROLE_default-roles-loci-realm
131	ROLE_uma_authorization
131	ROLE_user
131	ROLE_offline_access
132	ROLE_default-roles-loci-realm
132	ROLE_uma_authorization
132	ROLE_user
132	ROLE_offline_access
134	ROLE_default-roles-loci-realm
134	ROLE_uma_authorization
134	ROLE_user
134	ROLE_offline_access
136	ROLE_default-roles-loci-realm
136	ROLE_uma_authorization
136	ROLE_user
136	ROLE_offline_access
138	ROLE_default-roles-loci-realm
138	ROLE_uma_authorization
138	ROLE_user
138	ROLE_offline_access
140	ROLE_default-roles-loci-realm
140	ROLE_uma_authorization
140	ROLE_user
140	ROLE_offline_access
142	ROLE_default-roles-loci-realm
142	ROLE_uma_authorization
142	ROLE_user
142	ROLE_offline_access
144	ROLE_default-roles-loci-realm
144	ROLE_uma_authorization
144	ROLE_user
144	ROLE_offline_access
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
8a98e8b9-37ff-4a89-b8d8-a7e4d45d4f1e	alaina.goyette@gmail.com	alaina.goyette@gmail.com	t	t	\N	Janean	Schamberger	83b6664d-539e-4bed-a376-685d50e40b98	alaina.goyette@gmail.com	1764321071537	\N	0
09ef75b6-5d8f-443f-ab88-1e6e4fdd09a0	bryon.reilly@yahoo.com	bryon.reilly@yahoo.com	t	t	\N	Junita	Goldner	83b6664d-539e-4bed-a376-685d50e40b98	bryon.reilly@yahoo.com	1764321071055	\N	0
e0f4cddc-281e-48f7-8ca7-6dbbd0c0a96a	cedric.rau@yahoo.com	cedric.rau@yahoo.com	t	t	\N	Hong	Hammes	83b6664d-539e-4bed-a376-685d50e40b98	cedric.rau@yahoo.com	1764321074165	\N	0
a03e7f08-f0c7-4c40-97d6-e3bff7d00057	corazon.quigley@gmail.com	corazon.quigley@gmail.com	t	t	\N	Dorene	Brekke	83b6664d-539e-4bed-a376-685d50e40b98	corazon.quigley@gmail.com	1764321071300	\N	0
8c2bd715-2950-4ad6-a43b-7d75874ed33d	earle.wilderman@yahoo.com	earle.wilderman@yahoo.com	t	t	\N	Tory	Bradtke	83b6664d-539e-4bed-a376-685d50e40b98	earle.wilderman@yahoo.com	1764321071770	\N	0
9d478593-8658-473d-9f6a-cfb8530385b3	eugenie.goldner@gmail.com	eugenie.goldner@gmail.com	t	t	\N	Davida	Weimann	83b6664d-539e-4bed-a376-685d50e40b98	eugenie.goldner@gmail.com	1764321070817	\N	0
b1e6055e-734d-4367-8330-975869b72a10	fanny.jakubowski@gmail.com	fanny.jakubowski@gmail.com	t	t	\N	Viola	Wilkinson	83b6664d-539e-4bed-a376-685d50e40b98	fanny.jakubowski@gmail.com	1764321074391	\N	0
75729648-21f9-4808-aaeb-0a9f2aaed554	gidget.bergstrom@yahoo.com	gidget.bergstrom@yahoo.com	t	t	\N	Kaylee	Doyle	83b6664d-539e-4bed-a376-685d50e40b98	gidget.bergstrom@yahoo.com	1764321073209	\N	0
a8973d47-25d6-4904-ab93-4b30aac43dba	glady.conn@yahoo.com	glady.conn@yahoo.com	t	t	\N	Fatima	Hessel	83b6664d-539e-4bed-a376-685d50e40b98	glady.conn@yahoo.com	1764321072001	\N	0
a50fc325-a397-4f18-bb31-75cc1191ffa8	halley.balistreri@gmail.com	halley.balistreri@gmail.com	t	t	\N	Jaquelyn	Collier	83b6664d-539e-4bed-a376-685d50e40b98	halley.balistreri@gmail.com	1764321073905	\N	0
32ca4097-7490-4a9a-aecf-8c948a2a0e41	jae.koch@yahoo.com	jae.koch@yahoo.com	t	t	\N	Sage	Graham	83b6664d-539e-4bed-a376-685d50e40b98	jae.koch@yahoo.com	1764321074615	\N	0
cf8665b4-ef04-45b5-9b90-b3864e58e0ff	jung.heidenreich@gmail.com	jung.heidenreich@gmail.com	t	t	\N	Galen	Beier	83b6664d-539e-4bed-a376-685d50e40b98	jung.heidenreich@gmail.com	1764321072681	\N	0
8ad53006-5ab5-45fb-84c0-497a6424d782	kittie.hackett@yahoo.com	kittie.hackett@yahoo.com	t	t	\N	Caroline	Doyle	83b6664d-539e-4bed-a376-685d50e40b98	kittie.hackett@yahoo.com	1764321073662	\N	0
7b0afce6-4207-467a-9e67-e013d8f70566	kourtney.ohara@yahoo.com	kourtney.ohara@yahoo.com	t	t	\N	Missy	Purdy	83b6664d-539e-4bed-a376-685d50e40b98	kourtney.ohara@yahoo.com	1764321072951	\N	0
3a050261-b704-426e-a7c2-68b69ebeb90b	lisette.feil@yahoo.com	lisette.feil@yahoo.com	t	t	\N	Vernon	Cremin	83b6664d-539e-4bed-a376-685d50e40b98	lisette.feil@yahoo.com	1764321070303	\N	0
7d756359-1b87-442d-a2e8-e4785dd5aaa4	max.sipes@yahoo.com	max.sipes@yahoo.com	t	t	\N	Shannon	Beier	83b6664d-539e-4bed-a376-685d50e40b98	max.sipes@yahoo.com	1764321070543	\N	0
4eb678c6-f977-46ba-baaf-c9bf4bec62ef	mohammad.walter@gmail.com	mohammad.walter@gmail.com	t	t	\N	Corrinne	Senger	83b6664d-539e-4bed-a376-685d50e40b98	mohammad.walter@gmail.com	1764321069899	\N	0
ce35d0b0-2a72-4a57-8fac-dcb8348f4c41	nestor.cartwright@yahoo.com	nestor.cartwright@yahoo.com	t	t	\N	Timika	Metz	83b6664d-539e-4bed-a376-685d50e40b98	nestor.cartwright@yahoo.com	1764321073436	\N	0
27e24793-eb80-4ba8-9ace-95f432ca5199	sydney.mclaughlin@hotmail.com	sydney.mclaughlin@hotmail.com	t	t	\N	Ricky	Skiles	83b6664d-539e-4bed-a376-685d50e40b98	sydney.mclaughlin@hotmail.com	1764321072456	\N	0
cd2e474a-f099-4cce-ac9f-4d047fd00a01	testuser1@gmail.com	testuser1@gmail.com	f	t	\N	trung	kien	83b6664d-539e-4bed-a376-685d50e40b98	testuser1	1764321439014	\N	0
4c8aa205-60a4-4caf-8b62-34777a9784dc	ulysses.barrows@gmail.com	ulysses.barrows@gmail.com	t	t	\N	Loreta	Beer	83b6664d-539e-4bed-a376-685d50e40b98	ulysses.barrows@gmail.com	1764321072228	\N	0
acfe4112-d87d-4f95-86eb-d817c80a1666	\N	c8f47a90-54c4-463b-ad72-8761126d8b12	f	t	\N	\N	\N	47e9ad4c-2ca4-4dfb-97f1-5c411469edfd	admin	1768440076287	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
929392ee-0474-4ed0-a64e-9b0132025c91	8a98e8b9-37ff-4a89-b8d8-a7e4d45d4f1e
929392ee-0474-4ed0-a64e-9b0132025c91	09ef75b6-5d8f-443f-ab88-1e6e4fdd09a0
929392ee-0474-4ed0-a64e-9b0132025c91	e0f4cddc-281e-48f7-8ca7-6dbbd0c0a96a
929392ee-0474-4ed0-a64e-9b0132025c91	a03e7f08-f0c7-4c40-97d6-e3bff7d00057
929392ee-0474-4ed0-a64e-9b0132025c91	8c2bd715-2950-4ad6-a43b-7d75874ed33d
929392ee-0474-4ed0-a64e-9b0132025c91	9d478593-8658-473d-9f6a-cfb8530385b3
929392ee-0474-4ed0-a64e-9b0132025c91	b1e6055e-734d-4367-8330-975869b72a10
929392ee-0474-4ed0-a64e-9b0132025c91	75729648-21f9-4808-aaeb-0a9f2aaed554
929392ee-0474-4ed0-a64e-9b0132025c91	a8973d47-25d6-4904-ab93-4b30aac43dba
929392ee-0474-4ed0-a64e-9b0132025c91	a50fc325-a397-4f18-bb31-75cc1191ffa8
929392ee-0474-4ed0-a64e-9b0132025c91	32ca4097-7490-4a9a-aecf-8c948a2a0e41
929392ee-0474-4ed0-a64e-9b0132025c91	cf8665b4-ef04-45b5-9b90-b3864e58e0ff
929392ee-0474-4ed0-a64e-9b0132025c91	8ad53006-5ab5-45fb-84c0-497a6424d782
929392ee-0474-4ed0-a64e-9b0132025c91	7b0afce6-4207-467a-9e67-e013d8f70566
929392ee-0474-4ed0-a64e-9b0132025c91	3a050261-b704-426e-a7c2-68b69ebeb90b
929392ee-0474-4ed0-a64e-9b0132025c91	7d756359-1b87-442d-a2e8-e4785dd5aaa4
929392ee-0474-4ed0-a64e-9b0132025c91	4eb678c6-f977-46ba-baaf-c9bf4bec62ef
929392ee-0474-4ed0-a64e-9b0132025c91	ce35d0b0-2a72-4a57-8fac-dcb8348f4c41
929392ee-0474-4ed0-a64e-9b0132025c91	27e24793-eb80-4ba8-9ace-95f432ca5199
929392ee-0474-4ed0-a64e-9b0132025c91	cd2e474a-f099-4cce-ac9f-4d047fd00a01
929392ee-0474-4ed0-a64e-9b0132025c91	4c8aa205-60a4-4caf-8b62-34777a9784dc
364fc902-cac0-422a-b35b-6118125dd0a2	acfe4112-d87d-4f95-86eb-d817c80a1666
1f8cc3fe-de8f-48f3-930d-8c58f93e0fa4	acfe4112-d87d-4f95-86eb-d817c80a1666
\.


--
-- Data for Name: user_settings; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_settings (user_id, created_date, last_modified_date, friend_request_setting, last_seen_setting, profile_visibility) FROM stdin;
121	2026-01-13 13:50:59.590614+00	2026-01-13 13:50:59.590614+00	EVERYONE	EVERYONE	t
123	2026-01-14 00:55:45.560404+00	2026-01-14 00:55:45.560404+00	EVERYONE	EVERYONE	t
124	2026-01-14 00:56:10.793126+00	2026-01-14 00:56:10.793126+00	EVERYONE	EVERYONE	t
126	2026-01-14 00:56:33.864693+00	2026-01-14 00:56:33.864693+00	EVERYONE	EVERYONE	t
129	2026-01-14 00:56:46.319038+00	2026-01-14 00:56:46.319038+00	EVERYONE	EVERYONE	t
131	2026-01-14 00:57:01.736191+00	2026-01-14 00:57:01.736191+00	EVERYONE	EVERYONE	t
132	2026-01-14 00:57:14.012695+00	2026-01-14 00:57:14.012695+00	EVERYONE	EVERYONE	t
134	2026-01-14 00:57:26.252157+00	2026-01-14 00:57:26.252157+00	EVERYONE	EVERYONE	t
136	2026-01-14 00:57:38.01467+00	2026-01-14 00:57:38.01467+00	EVERYONE	EVERYONE	t
138	2026-01-14 00:57:49.487758+00	2026-01-14 00:57:49.487758+00	EVERYONE	EVERYONE	t
140	2026-01-14 00:58:47.339518+00	2026-01-14 00:58:47.339518+00	EVERYONE	EVERYONE	t
142	2026-01-14 00:59:13.654892+00	2026-01-14 00:59:13.654892+00	EVERYONE	EVERYONE	t
144	2026-01-14 01:00:57.082974+00	2026-01-14 01:00:57.082974+00	EVERYONE	EVERYONE	t
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.web_origins (client_id, value) FROM stdin;
d4163211-b255-4df3-98fb-fd48febf1cfe	+
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	*
d004af51-9d2e-47d3-9340-a3a411f42029	
d004af51-9d2e-47d3-9340-a3a411f42029	http://localhost:8080/
ba4de397-daf8-404b-ad79-249e4d09a713	+
e85deedd-b2fb-47d3-acef-508423a77f22	http://localhost:8080
\.


--
-- Name: contact_request_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.contact_request_sequence', 7, true);


--
-- Name: contact_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.contact_sequence', 5, true);


--
-- Name: conversation_participant_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.conversation_participant_sequence', 14, true);


--
-- Name: conversation_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.conversation_sequence', 3, true);


--
-- Name: group_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.group_sequence', 2, true);


--
-- Name: message_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.message_sequence', 1, false);


--
-- Name: notification_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.notification_sequence', 1, false);


--
-- Name: user_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_sequence', 145, true);


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: authority authority_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authority
    ADD CONSTRAINT authority_pkey PRIMARY KEY (name);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- Name: contact_request contact_request_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contact_request
    ADD CONSTRAINT contact_request_pkey PRIMARY KEY (id);


--
-- Name: conversation_participant conversation_participant_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conversation_participant
    ADD CONSTRAINT conversation_participant_pkey PRIMARY KEY (id);


--
-- Name: conversation conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (id);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: group_ group__pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_
    ADD CONSTRAINT group__pkey PRIMARY KEY (id);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: notification uk580xwhvqivevh4eucrgwqypnd; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT uk580xwhvqivevh4eucrgwqypnd UNIQUE (public_id);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: contact_request ukdxcpfb5ytd3nbpn5uo1hp7t6e; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contact_request
    ADD CONSTRAINT ukdxcpfb5ytd3nbpn5uo1hp7t6e UNIQUE (public_id);


--
-- Name: conversation ukgafcthea67ee76r7f01clcw81; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT ukgafcthea67ee76r7f01clcw81 UNIQUE (public_id);


--
-- Name: group_ ukgdlqdiqvcgqbe1fspoysdsjpw; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_
    ADD CONSTRAINT ukgdlqdiqvcgqbe1fspoysdsjpw UNIQUE (conversation_id);


--
-- Name: message ukiv3kt17dk5u1v4n8bpqkyhqvd; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT ukiv3kt17dk5u1v4n8bpqkyhqvd UNIQUE (public_id);


--
-- Name: group_ ukoqiok65unlg3ujawpiwdoy9nd; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_
    ADD CONSTRAINT ukoqiok65unlg3ujawpiwdoy9nd UNIQUE (public_id);


--
-- Name: user_ unique_email; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- Name: user_ unique_username; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_
    ADD CONSTRAINT unique_username UNIQUE (username);


--
-- Name: user_ user__pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_
    ADD CONSTRAINT user__pkey PRIMARY KEY (id);


--
-- Name: user_authority user_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_authority
    ADD CONSTRAINT user_authority_pkey PRIMARY KEY (user_id, authority_name);


--
-- Name: user_settings user_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT user_settings_pkey PRIMARY KEY (user_id);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: group_ fk1q8ojqw7oymq1axfw8ovbul5x; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_
    ADD CONSTRAINT fk1q8ojqw7oymq1axfw8ovbul5x FOREIGN KEY (conversation_id) REFERENCES public.conversation(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: message fk2c48vm73iafadi7iqjj6wp2g; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT fk2c48vm73iafadi7iqjj6wp2g FOREIGN KEY (sender_id) REFERENCES public.user_(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: contact fk56fuy74fokpcs1mamr88g3jbw; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT fk56fuy74fokpcs1mamr88g3jbw FOREIGN KEY (user_id) REFERENCES public.user_(id);


--
-- Name: user_authority fk6ktglpl5mjosa283rvken2py5; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_authority
    ADD CONSTRAINT fk6ktglpl5mjosa283rvken2py5 FOREIGN KEY (authority_name) REFERENCES public.authority(name);


--
-- Name: message fk6yskk3hxw5sklwgi25y6d5u1l; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT fk6yskk3hxw5sklwgi25y6d5u1l FOREIGN KEY (conversation_id) REFERENCES public.conversation(id);


--
-- Name: contact fk7rlqroy8v218wadpf5do3el2e; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT fk7rlqroy8v218wadpf5do3el2e FOREIGN KEY (contact_user_id) REFERENCES public.user_(id);


--
-- Name: conversation_participant fk93dv599s56uqs8xslhdp3arya; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conversation_participant
    ADD CONSTRAINT fk93dv599s56uqs8xslhdp3arya FOREIGN KEY (conversation_id) REFERENCES public.conversation(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_settings fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.user_(id);


--
-- Name: contact fkcgt5xpclo1jvlvy763u6m3w26; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT fkcgt5xpclo1jvlvy763u6m3w26 FOREIGN KEY (blocked_by) REFERENCES public.user_(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- Name: notification fkg9wcclio3v5xftqnc4q7lr7hd; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT fkg9wcclio3v5xftqnc4q7lr7hd FOREIGN KEY (user_id) REFERENCES public.user_(id);


--
-- Name: conversation_participant fkhf6gkkuops56saeu2gqrj9pp9; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conversation_participant
    ADD CONSTRAINT fkhf6gkkuops56saeu2gqrj9pp9 FOREIGN KEY (user_id) REFERENCES public.user_(id);


--
-- Name: user_authority fkio2xcw9ogcqbasp25n5vttxrf; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_authority
    ADD CONSTRAINT fkio2xcw9ogcqbasp25n5vttxrf FOREIGN KEY (user_id) REFERENCES public.user_(id);


--
-- Name: conversation fkk4ff054uhh47bajpq2ioterxo; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT fkk4ff054uhh47bajpq2ioterxo FOREIGN KEY (creator_id) REFERENCES public.user_(id);


--
-- Name: message fkm83oxlnewy7ev6dc1pxjwr4rn; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT fkm83oxlnewy7ev6dc1pxjwr4rn FOREIGN KEY (reply_to_message_id) REFERENCES public.message(id);


--
-- Name: contact_request fkn2g1ehilahjakmnnbncklfbog; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contact_request
    ADD CONSTRAINT fkn2g1ehilahjakmnnbncklfbog FOREIGN KEY (receiver_user_id) REFERENCES public.user_(id);


--
-- Name: user_settings fkp3nomjf43s475m64i9q73arb0; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT fkp3nomjf43s475m64i9q73arb0 FOREIGN KEY (user_id) REFERENCES public.user_(id);


--
-- Name: conversation fksm3966podppo987o2etdjci1r; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT fksm3966podppo987o2etdjci1r FOREIGN KEY (last_message_id) REFERENCES public.message(id);


--
-- Name: contact_request fkt6jacf36093nt67xmxnuunyau; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contact_request
    ADD CONSTRAINT fkt6jacf36093nt67xmxnuunyau FOREIGN KEY (request_user_id) REFERENCES public.user_(id);


--
-- PostgreSQL database dump complete
--

\unrestrict xDR9FJBr0GsRjfFTdoHvE6khgjJTaBjoWBDqrymMBr89ObMuME0r2xTDzlVXGi3


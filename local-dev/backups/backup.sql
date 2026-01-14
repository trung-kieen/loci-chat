--
-- PostgreSQL database dump
--

\restrict eUcA9Zy5dxBM4jyrSnXiGoWx2zTaK4yfNwcA8kzSjbpRRL63jq2wI7BOhrPgJIp

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
    CONSTRAINT contact_request_status_check CHECK (((status)::text = ANY ((ARRAY['PENDING'::character varying, 'ACCEPTED'::character varying, 'DECLINED'::character varying, 'CANCELED'::character varying])::text[])))
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
    CONSTRAINT conversation_conversation_type_check CHECK (((conversation_type)::text = ANY ((ARRAY['ONE_TO_ONE'::character varying, 'GROUP'::character varying])::text[])))
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
    CONSTRAINT conversation_participant_role_check CHECK (((role)::text = ANY ((ARRAY['MEMBER'::character varying, 'ADMIN'::character varying])::text[])))
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
    CONSTRAINT message_status_check CHECK (((status)::text = ANY ((ARRAY['PREPARE'::character varying, 'SENT'::character varying, 'DELIVERED'::character varying, 'SEEN'::character varying])::text[]))),
    CONSTRAINT message_type_check CHECK (((type)::text = ANY ((ARRAY['TEXT'::character varying, 'FILE'::character varying, 'IMAGE'::character varying, 'VIDEO'::character varying])::text[])))
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
    CONSTRAINT user_settings_friend_request_setting_check CHECK (((friend_request_setting)::text = ANY ((ARRAY['EVERYONE'::character varying, 'FRIENDS_OF_FRIENDS'::character varying, 'NOBODY'::character varying])::text[]))),
    CONSTRAINT user_settings_last_seen_setting_check CHECK (((last_seen_setting)::text = ANY ((ARRAY['EVERYONE'::character varying, 'CONTACT_ONLY'::character varying, 'NOBODY'::character varying])::text[])))
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
0db9b0d9-da99-4289-bd33-681e4a2eb2f4	\N	auth-cookie	6bee13ee-c458-477d-a219-83a4deb1977a	1d2f4bba-7f25-49b8-b705-2c3962d4f881	2	10	f	\N	\N
6a7a6c2a-9a9b-43d5-86b7-d23ebd4fb450	\N	auth-spnego	6bee13ee-c458-477d-a219-83a4deb1977a	1d2f4bba-7f25-49b8-b705-2c3962d4f881	3	20	f	\N	\N
dc3ce950-a3c3-4b84-ab33-a1aa4f6297ad	\N	identity-provider-redirector	6bee13ee-c458-477d-a219-83a4deb1977a	1d2f4bba-7f25-49b8-b705-2c3962d4f881	2	25	f	\N	\N
edc8584e-f0e7-4f4d-b046-10f9a8327f38	\N	\N	6bee13ee-c458-477d-a219-83a4deb1977a	1d2f4bba-7f25-49b8-b705-2c3962d4f881	2	30	t	a140562f-dcee-477c-aca6-409c12a68a85	\N
29843d89-3c05-4d45-993f-eec0868d32ab	\N	auth-username-password-form	6bee13ee-c458-477d-a219-83a4deb1977a	a140562f-dcee-477c-aca6-409c12a68a85	0	10	f	\N	\N
d2dccf4e-7a9f-4ae1-bc54-07c83a97fe32	\N	\N	6bee13ee-c458-477d-a219-83a4deb1977a	a140562f-dcee-477c-aca6-409c12a68a85	1	20	t	0b3249bd-c0cc-4ebf-a031-434d4851a037	\N
2cc47b4b-cc1c-47b6-9980-e4fdca39d844	\N	conditional-user-configured	6bee13ee-c458-477d-a219-83a4deb1977a	0b3249bd-c0cc-4ebf-a031-434d4851a037	0	10	f	\N	\N
e5b71b53-f202-4429-aebc-e24109c7ba6a	\N	auth-otp-form	6bee13ee-c458-477d-a219-83a4deb1977a	0b3249bd-c0cc-4ebf-a031-434d4851a037	0	20	f	\N	\N
a543cb93-5629-4407-b783-da76f41fef66	\N	direct-grant-validate-username	6bee13ee-c458-477d-a219-83a4deb1977a	7dfcd6a2-2ab6-475b-8150-674ded235a29	0	10	f	\N	\N
0721c06d-677f-4691-b066-234cec0a351d	\N	direct-grant-validate-password	6bee13ee-c458-477d-a219-83a4deb1977a	7dfcd6a2-2ab6-475b-8150-674ded235a29	0	20	f	\N	\N
09d6a0da-1671-43e4-a03f-7e2cfdb11deb	\N	\N	6bee13ee-c458-477d-a219-83a4deb1977a	7dfcd6a2-2ab6-475b-8150-674ded235a29	1	30	t	7c6f257f-2be7-4fba-bddc-62cdb60eea46	\N
ba0f9f1c-de44-4440-b59b-a87481a498cb	\N	conditional-user-configured	6bee13ee-c458-477d-a219-83a4deb1977a	7c6f257f-2be7-4fba-bddc-62cdb60eea46	0	10	f	\N	\N
8b535794-c826-46ce-b913-52890099902a	\N	direct-grant-validate-otp	6bee13ee-c458-477d-a219-83a4deb1977a	7c6f257f-2be7-4fba-bddc-62cdb60eea46	0	20	f	\N	\N
c505d903-2646-4e06-8f66-7cb62b04ea57	\N	registration-page-form	6bee13ee-c458-477d-a219-83a4deb1977a	0545e99a-acf8-4617-b0fd-df56c0318ea6	0	10	t	80bfe23b-2918-4771-b276-c400271dced1	\N
bd7e5681-353a-46b5-8149-f87c5375f7a9	\N	registration-user-creation	6bee13ee-c458-477d-a219-83a4deb1977a	80bfe23b-2918-4771-b276-c400271dced1	0	20	f	\N	\N
07eb6172-c0bf-4193-9100-b4d4b282ff0f	\N	registration-password-action	6bee13ee-c458-477d-a219-83a4deb1977a	80bfe23b-2918-4771-b276-c400271dced1	0	50	f	\N	\N
c547e329-cca5-41b7-aa4b-536bfb6f3c00	\N	registration-recaptcha-action	6bee13ee-c458-477d-a219-83a4deb1977a	80bfe23b-2918-4771-b276-c400271dced1	3	60	f	\N	\N
4aeb8cfd-2fb8-466d-846c-a54781cbf9e3	\N	registration-terms-and-conditions	6bee13ee-c458-477d-a219-83a4deb1977a	80bfe23b-2918-4771-b276-c400271dced1	3	70	f	\N	\N
c2e9f197-8192-480f-9dcb-0a8d5a32a4f1	\N	reset-credentials-choose-user	6bee13ee-c458-477d-a219-83a4deb1977a	6dce498b-9d8a-47d3-938d-f32a83702206	0	10	f	\N	\N
434c105f-518c-4a27-9122-39f559384ff8	\N	reset-credential-email	6bee13ee-c458-477d-a219-83a4deb1977a	6dce498b-9d8a-47d3-938d-f32a83702206	0	20	f	\N	\N
3df05d44-0e81-43d7-94a2-8b187754acdd	\N	reset-password	6bee13ee-c458-477d-a219-83a4deb1977a	6dce498b-9d8a-47d3-938d-f32a83702206	0	30	f	\N	\N
481e1c63-77b2-445d-8b66-b6fb37369913	\N	\N	6bee13ee-c458-477d-a219-83a4deb1977a	6dce498b-9d8a-47d3-938d-f32a83702206	1	40	t	9d726b14-9989-4967-8cb8-082752bc1d68	\N
ff56e7f9-b98e-484b-9b40-65baf8d804ad	\N	conditional-user-configured	6bee13ee-c458-477d-a219-83a4deb1977a	9d726b14-9989-4967-8cb8-082752bc1d68	0	10	f	\N	\N
6e28ce6d-5974-451b-a22b-19ccb2849bb0	\N	reset-otp	6bee13ee-c458-477d-a219-83a4deb1977a	9d726b14-9989-4967-8cb8-082752bc1d68	0	20	f	\N	\N
46f9969f-e096-4c24-91da-ff20227dba5a	\N	client-secret	6bee13ee-c458-477d-a219-83a4deb1977a	71de4015-079f-4aef-94a4-3fe3675468a9	2	10	f	\N	\N
0101ef0b-2994-47cd-a14b-9bc0531f852c	\N	client-jwt	6bee13ee-c458-477d-a219-83a4deb1977a	71de4015-079f-4aef-94a4-3fe3675468a9	2	20	f	\N	\N
868aaaeb-c182-4461-98cf-70a61832fd6a	\N	client-secret-jwt	6bee13ee-c458-477d-a219-83a4deb1977a	71de4015-079f-4aef-94a4-3fe3675468a9	2	30	f	\N	\N
c9424b05-8d21-415d-9b41-e08c97737db3	\N	client-x509	6bee13ee-c458-477d-a219-83a4deb1977a	71de4015-079f-4aef-94a4-3fe3675468a9	2	40	f	\N	\N
99ed4f53-f2e6-4cda-9d55-dd9ee26d1687	\N	idp-review-profile	6bee13ee-c458-477d-a219-83a4deb1977a	4c055f4a-e753-4b55-8423-cf1ca8678f66	0	10	f	\N	b906ecca-b12a-4990-bbbf-a5ca11b12f45
77262856-baa1-4ba9-a7cd-e6a51c4a773f	\N	\N	6bee13ee-c458-477d-a219-83a4deb1977a	4c055f4a-e753-4b55-8423-cf1ca8678f66	0	20	t	ff77eda6-9cc0-4e94-a772-1cd10ebacfb7	\N
2e95f31d-b4cf-4685-b074-e7ec51d1ec35	\N	idp-create-user-if-unique	6bee13ee-c458-477d-a219-83a4deb1977a	ff77eda6-9cc0-4e94-a772-1cd10ebacfb7	2	10	f	\N	e5a870ae-b35a-49cf-a2a1-3a9b10f865c5
c6a19b6a-4b76-434b-b6f3-8ec6083b9156	\N	\N	6bee13ee-c458-477d-a219-83a4deb1977a	ff77eda6-9cc0-4e94-a772-1cd10ebacfb7	2	20	t	4f6fc4d8-e1a6-46ea-b6c6-d95e2eed2571	\N
7e3f7e72-e787-461a-bae7-a1a4bc20bc6b	\N	idp-confirm-link	6bee13ee-c458-477d-a219-83a4deb1977a	4f6fc4d8-e1a6-46ea-b6c6-d95e2eed2571	0	10	f	\N	\N
d17e85be-e116-4ce1-8ed9-d119508856e1	\N	\N	6bee13ee-c458-477d-a219-83a4deb1977a	4f6fc4d8-e1a6-46ea-b6c6-d95e2eed2571	0	20	t	44f04ddf-48e9-42ba-8e53-0233e0dbad5c	\N
1321a9e2-9eac-415c-922a-0bc3298373da	\N	idp-email-verification	6bee13ee-c458-477d-a219-83a4deb1977a	44f04ddf-48e9-42ba-8e53-0233e0dbad5c	2	10	f	\N	\N
b73e8635-d258-40bd-9337-059bb5411f05	\N	\N	6bee13ee-c458-477d-a219-83a4deb1977a	44f04ddf-48e9-42ba-8e53-0233e0dbad5c	2	20	t	1d14aba6-02ce-44d2-b9f6-c5e12e42cbc3	\N
37472735-6d5f-4e53-af7f-1c74de86c0d0	\N	idp-username-password-form	6bee13ee-c458-477d-a219-83a4deb1977a	1d14aba6-02ce-44d2-b9f6-c5e12e42cbc3	0	10	f	\N	\N
c15efbab-539a-46cc-9714-629e1ebc80fa	\N	\N	6bee13ee-c458-477d-a219-83a4deb1977a	1d14aba6-02ce-44d2-b9f6-c5e12e42cbc3	1	20	t	ed74c7da-538f-4f7b-9e47-e9fb196b39dc	\N
1e854dd2-ab44-4ce1-8f22-a367db16c13b	\N	conditional-user-configured	6bee13ee-c458-477d-a219-83a4deb1977a	ed74c7da-538f-4f7b-9e47-e9fb196b39dc	0	10	f	\N	\N
604af337-a47f-4e41-a44f-4dba9628ae84	\N	auth-otp-form	6bee13ee-c458-477d-a219-83a4deb1977a	ed74c7da-538f-4f7b-9e47-e9fb196b39dc	0	20	f	\N	\N
b5ddbf7a-4609-4a8d-95a5-3c779ff62df2	\N	http-basic-authenticator	6bee13ee-c458-477d-a219-83a4deb1977a	4f5d0c3e-44eb-4d13-afd4-dc0217073c1a	0	10	f	\N	\N
57b14963-923a-4cdb-b214-fe71fe2cb313	\N	docker-http-basic-authenticator	6bee13ee-c458-477d-a219-83a4deb1977a	0799a6a7-c965-4527-8f36-416fbd05df4b	0	10	f	\N	\N
f8d57d4d-3c5a-4124-944d-d29018486769	\N	idp-email-verification	83b6664d-539e-4bed-a376-685d50e40b98	10e5cbf9-6d70-4671-8b7c-25a13f3b30b6	2	10	f	\N	\N
50257aa5-0f05-406e-afd8-d6dd8da14adf	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	10e5cbf9-6d70-4671-8b7c-25a13f3b30b6	2	20	t	9072b1a2-a2d2-426d-9fe7-bfb40b87cfab	\N
1a6ce7dc-50b5-4b1c-a7cf-64b5c7dcb899	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	936ccde4-b63d-4262-b8a6-af7d521dc3aa	0	10	f	\N	\N
a9f8fbd0-dae6-4a3a-ab28-8cb102eaa2e1	\N	auth-otp-form	83b6664d-539e-4bed-a376-685d50e40b98	936ccde4-b63d-4262-b8a6-af7d521dc3aa	0	20	f	\N	\N
6c938c0e-6733-4c88-9330-12c7ad058b02	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	dc1e8d98-e26a-437c-91a3-f8ca8ed2dd59	0	10	f	\N	\N
022e9140-adb9-4278-816d-c3d9b1faa881	\N	organization	83b6664d-539e-4bed-a376-685d50e40b98	dc1e8d98-e26a-437c-91a3-f8ca8ed2dd59	2	20	f	\N	\N
de2f20a9-aa98-4805-b05f-a7d4300f1ffa	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	5b2379d9-11fb-476f-8530-5a91ca18e364	0	10	f	\N	\N
555639af-5c5b-4b93-b319-025c8f24b95b	\N	direct-grant-validate-otp	83b6664d-539e-4bed-a376-685d50e40b98	5b2379d9-11fb-476f-8530-5a91ca18e364	0	20	f	\N	\N
995bc985-4c33-41fd-9507-0eba2d398463	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	fcaef89a-b301-4a9d-86b6-f570c43d07ad	0	10	f	\N	\N
d0db08e3-91ea-4142-9077-8d3162c35a4e	\N	idp-add-organization-member	83b6664d-539e-4bed-a376-685d50e40b98	fcaef89a-b301-4a9d-86b6-f570c43d07ad	0	20	f	\N	\N
8f85497b-49c3-4f58-9b19-3968fd22f4a0	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	ceed43c7-5d3f-4eb1-b878-2314aef46ebf	0	10	f	\N	\N
6a11d6a2-dae2-4abf-ae10-65b025c604b2	\N	auth-otp-form	83b6664d-539e-4bed-a376-685d50e40b98	ceed43c7-5d3f-4eb1-b878-2314aef46ebf	0	20	f	\N	\N
a8a9679d-bbed-4e0e-a542-b77da8865730	\N	idp-confirm-link	83b6664d-539e-4bed-a376-685d50e40b98	a9376912-6f72-4749-a4e3-6ce74c0ec76a	0	10	f	\N	\N
5d5ca083-038c-4e57-b0d2-dca68b8b039d	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	a9376912-6f72-4749-a4e3-6ce74c0ec76a	0	20	t	10e5cbf9-6d70-4671-8b7c-25a13f3b30b6	\N
ca3783c3-f3e3-4dde-8e90-dc7a333276b6	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	291b3c02-9178-4997-92a8-2c77b4a762da	1	10	t	dc1e8d98-e26a-437c-91a3-f8ca8ed2dd59	\N
93f0cda1-f918-4ac3-9750-70d102c9126f	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	510a55f8-b4a5-47e9-ac56-b60fc6ed8676	0	10	f	\N	\N
abdf6c06-2dd7-44eb-87aa-6bf362e53df2	\N	reset-otp	83b6664d-539e-4bed-a376-685d50e40b98	510a55f8-b4a5-47e9-ac56-b60fc6ed8676	0	20	f	\N	\N
8155bb74-a4ab-457c-a6f7-da42596f0d9b	\N	idp-create-user-if-unique	83b6664d-539e-4bed-a376-685d50e40b98	677d2578-fe86-4de9-8a18-860f8d89d4f3	2	10	f	\N	7805e560-dd03-4e34-a6ff-1784f53fecad
4c1c2b00-ae63-4652-93ae-ee52dda75f13	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	677d2578-fe86-4de9-8a18-860f8d89d4f3	2	20	t	a9376912-6f72-4749-a4e3-6ce74c0ec76a	\N
17c54286-cd3e-4ae9-8edd-de5cf5a2853e	\N	idp-username-password-form	83b6664d-539e-4bed-a376-685d50e40b98	9072b1a2-a2d2-426d-9fe7-bfb40b87cfab	0	10	f	\N	\N
548ea886-4ebf-4074-b3d6-b3b0236c5250	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	9072b1a2-a2d2-426d-9fe7-bfb40b87cfab	1	20	t	ceed43c7-5d3f-4eb1-b878-2314aef46ebf	\N
5f6ef5dc-4ecc-4cf3-bf3a-89c48049ac56	\N	auth-cookie	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	2	10	f	\N	\N
7a3ae6df-559c-428b-bdf3-a98276143002	\N	auth-spnego	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	3	20	f	\N	\N
b39aa139-c58a-41e7-9759-de8c94e6586c	\N	identity-provider-redirector	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	2	25	f	\N	\N
ddce3604-01cc-464d-84e5-34695aba844e	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	2	26	t	291b3c02-9178-4997-92a8-2c77b4a762da	\N
17a674c0-5125-4275-89b6-3d92acb48d79	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	2	30	t	4c7e2a97-05a5-4499-99d5-b0fe14711095	\N
a6950959-88d5-48f7-b748-1b2ac187d0cf	\N	client-secret	83b6664d-539e-4bed-a376-685d50e40b98	05607ab5-8839-424c-b1e7-7f0ccad2063e	2	10	f	\N	\N
70d10ca9-0e5b-4f68-9018-1fecb9274a2b	\N	client-jwt	83b6664d-539e-4bed-a376-685d50e40b98	05607ab5-8839-424c-b1e7-7f0ccad2063e	2	20	f	\N	\N
c2ec18e4-ba56-4955-8a8d-96a306c53817	\N	client-secret-jwt	83b6664d-539e-4bed-a376-685d50e40b98	05607ab5-8839-424c-b1e7-7f0ccad2063e	2	30	f	\N	\N
2223400f-c7e7-4f89-9474-ecebcbdb3bb0	\N	client-x509	83b6664d-539e-4bed-a376-685d50e40b98	05607ab5-8839-424c-b1e7-7f0ccad2063e	2	40	f	\N	\N
8327d414-0879-420f-bbc6-8c6b71688bcc	\N	direct-grant-validate-username	83b6664d-539e-4bed-a376-685d50e40b98	d7b8234b-3d04-4263-ac07-79794e3fb8c0	0	10	f	\N	\N
ba25ab36-8cbc-470a-a5b4-efa3bc0b107d	\N	direct-grant-validate-password	83b6664d-539e-4bed-a376-685d50e40b98	d7b8234b-3d04-4263-ac07-79794e3fb8c0	0	20	f	\N	\N
9feef42f-99ca-4b1a-9351-a219367a7edb	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	d7b8234b-3d04-4263-ac07-79794e3fb8c0	1	30	t	5b2379d9-11fb-476f-8530-5a91ca18e364	\N
a9a7e67f-ea05-4e97-8b84-8fd6a3faee72	\N	docker-http-basic-authenticator	83b6664d-539e-4bed-a376-685d50e40b98	08caf47c-2dda-42d5-a33d-3df1271e703c	0	10	f	\N	\N
2ec0cdc5-2eee-48dd-809e-b330d390734c	\N	idp-review-profile	83b6664d-539e-4bed-a376-685d50e40b98	668883be-9b51-42f6-9e35-cb35d7961852	0	10	f	\N	135d8612-fdf4-4acf-abf8-e25c0565ebf6
a6be7322-d081-44b1-b7e4-324b60151dd2	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	668883be-9b51-42f6-9e35-cb35d7961852	0	20	t	677d2578-fe86-4de9-8a18-860f8d89d4f3	\N
244c07e1-fb78-40bc-9ba8-5caf4e2896ef	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	668883be-9b51-42f6-9e35-cb35d7961852	1	50	t	fcaef89a-b301-4a9d-86b6-f570c43d07ad	\N
e63c5312-4fda-408f-bc0a-d49c4d698efb	\N	auth-username-password-form	83b6664d-539e-4bed-a376-685d50e40b98	4c7e2a97-05a5-4499-99d5-b0fe14711095	0	10	f	\N	\N
358e4480-b6d3-4f34-90b5-8d16115231a6	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	4c7e2a97-05a5-4499-99d5-b0fe14711095	1	20	t	936ccde4-b63d-4262-b8a6-af7d521dc3aa	\N
02393f02-183d-4799-9562-58aa7ee023fb	\N	registration-page-form	83b6664d-539e-4bed-a376-685d50e40b98	8c356fe3-6843-440d-ac93-b4cc6352781f	0	10	t	aa3e186d-9e97-41c0-a7f5-956fb754bdea	\N
219ee94a-554f-473e-b976-d0fb43ccc7a4	\N	registration-user-creation	83b6664d-539e-4bed-a376-685d50e40b98	aa3e186d-9e97-41c0-a7f5-956fb754bdea	0	20	f	\N	\N
725794eb-e132-4bcb-8a8c-11b0b16a444c	\N	registration-password-action	83b6664d-539e-4bed-a376-685d50e40b98	aa3e186d-9e97-41c0-a7f5-956fb754bdea	0	50	f	\N	\N
11394a10-8b1c-4f52-827c-33bcb43f12d4	\N	registration-recaptcha-action	83b6664d-539e-4bed-a376-685d50e40b98	aa3e186d-9e97-41c0-a7f5-956fb754bdea	3	60	f	\N	\N
95a90ec4-2731-4e21-ac5c-2b6e105eb673	\N	registration-terms-and-conditions	83b6664d-539e-4bed-a376-685d50e40b98	aa3e186d-9e97-41c0-a7f5-956fb754bdea	3	70	f	\N	\N
dcefeb3d-6329-4003-9316-fd42bd51d607	\N	reset-credentials-choose-user	83b6664d-539e-4bed-a376-685d50e40b98	2ec9ca75-4f99-43e9-816d-708c9a550838	0	10	f	\N	\N
b3bc3288-7f5a-4621-926d-02a456a3a96d	\N	reset-credential-email	83b6664d-539e-4bed-a376-685d50e40b98	2ec9ca75-4f99-43e9-816d-708c9a550838	0	20	f	\N	\N
404a5145-cf48-4e1a-b8cd-3fdcd63c0f03	\N	reset-password	83b6664d-539e-4bed-a376-685d50e40b98	2ec9ca75-4f99-43e9-816d-708c9a550838	0	30	f	\N	\N
b696788d-2dea-4b1a-a631-89e4726f6919	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	2ec9ca75-4f99-43e9-816d-708c9a550838	1	40	t	510a55f8-b4a5-47e9-ac56-b60fc6ed8676	\N
f88a3370-090a-431d-920d-e23287c3c50d	\N	http-basic-authenticator	83b6664d-539e-4bed-a376-685d50e40b98	626d5f6d-04d2-4f35-8cfc-da5e65715166	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
1d2f4bba-7f25-49b8-b705-2c3962d4f881	browser	Browser based authentication	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	t	t
a140562f-dcee-477c-aca6-409c12a68a85	forms	Username, password, otp and other auth forms.	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	f	t
0b3249bd-c0cc-4ebf-a031-434d4851a037	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	f	t
7dfcd6a2-2ab6-475b-8150-674ded235a29	direct grant	OpenID Connect Resource Owner Grant	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	t	t
7c6f257f-2be7-4fba-bddc-62cdb60eea46	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	f	t
0545e99a-acf8-4617-b0fd-df56c0318ea6	registration	Registration flow	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	t	t
80bfe23b-2918-4771-b276-c400271dced1	registration form	Registration form	6bee13ee-c458-477d-a219-83a4deb1977a	form-flow	f	t
6dce498b-9d8a-47d3-938d-f32a83702206	reset credentials	Reset credentials for a user if they forgot their password or something	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	t	t
9d726b14-9989-4967-8cb8-082752bc1d68	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	f	t
71de4015-079f-4aef-94a4-3fe3675468a9	clients	Base authentication for clients	6bee13ee-c458-477d-a219-83a4deb1977a	client-flow	t	t
4c055f4a-e753-4b55-8423-cf1ca8678f66	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	t	t
ff77eda6-9cc0-4e94-a772-1cd10ebacfb7	User creation or linking	Flow for the existing/non-existing user alternatives	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	f	t
4f6fc4d8-e1a6-46ea-b6c6-d95e2eed2571	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	f	t
44f04ddf-48e9-42ba-8e53-0233e0dbad5c	Account verification options	Method with which to verity the existing account	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	f	t
1d14aba6-02ce-44d2-b9f6-c5e12e42cbc3	Verify Existing Account by Re-authentication	Reauthentication of existing account	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	f	t
ed74c7da-538f-4f7b-9e47-e9fb196b39dc	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	f	t
4f5d0c3e-44eb-4d13-afd4-dc0217073c1a	saml ecp	SAML ECP Profile Authentication Flow	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	t	t
0799a6a7-c965-4527-8f36-416fbd05df4b	docker auth	Used by Docker clients to authenticate against the IDP	6bee13ee-c458-477d-a219-83a4deb1977a	basic-flow	t	t
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
b906ecca-b12a-4990-bbbf-a5ca11b12f45	review profile config	6bee13ee-c458-477d-a219-83a4deb1977a
e5a870ae-b35a-49cf-a2a1-3a9b10f865c5	create unique user config	6bee13ee-c458-477d-a219-83a4deb1977a
7805e560-dd03-4e34-a6ff-1784f53fecad	create unique user config	83b6664d-539e-4bed-a376-685d50e40b98
135d8612-fdf4-4acf-abf8-e25c0565ebf6	review profile config	83b6664d-539e-4bed-a376-685d50e40b98
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
b906ecca-b12a-4990-bbbf-a5ca11b12f45	missing	update.profile.on.first.login
e5a870ae-b35a-49cf-a2a1-3a9b10f865c5	false	require.password.update.after.registration
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
a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	f	master-realm	0	f	\N	\N	t	\N	f	6bee13ee-c458-477d-a219-83a4deb1977a	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	6bee13ee-c458-477d-a219-83a4deb1977a	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	6bee13ee-c458-477d-a219-83a4deb1977a	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4a4c2929-7f3c-4971-a025-52e23c09e357	t	f	broker	0	f	\N	\N	t	\N	f	6bee13ee-c458-477d-a219-83a4deb1977a	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	6bee13ee-c458-477d-a219-83a4deb1977a	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	t	t	admin-cli	0	t	\N	\N	f	\N	f	6bee13ee-c458-477d-a219-83a4deb1977a	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	f	loci-realm-realm	0	f	\N	\N	t	\N	f	6bee13ee-c458-477d-a219-83a4deb1977a	\N	0	f	f	loci-realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
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
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	post.logout.redirect.uris	+
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	post.logout.redirect.uris	+
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	pkce.code.challenge.method	S256
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	post.logout.redirect.uris	+
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	pkce.code.challenge.method	S256
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	client.use.lightweight.access.token.enabled	true
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	client.use.lightweight.access.token.enabled	true
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
d004af51-9d2e-47d3-9340-a3a411f42029	oauth2.device.authorization.grant.enabled	false
d004af51-9d2e-47d3-9340-a3a411f42029	backchannel.logout.revoke.offline.tokens	false
d004af51-9d2e-47d3-9340-a3a411f42029	post.logout.redirect.uris	+
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
b2380bdf-aa21-4971-b6a7-b54c82fdfdb0	offline_access	6bee13ee-c458-477d-a219-83a4deb1977a	OpenID Connect built-in scope: offline_access	openid-connect
92bb12df-b3cf-4b58-a22a-58927f4ef055	role_list	6bee13ee-c458-477d-a219-83a4deb1977a	SAML role list	saml
a8e5bb25-05b4-431e-b8a1-2416e612fa43	saml_organization	6bee13ee-c458-477d-a219-83a4deb1977a	Organization Membership	saml
2f80d67d-f8eb-44f3-afd8-2cdb8c002321	profile	6bee13ee-c458-477d-a219-83a4deb1977a	OpenID Connect built-in scope: profile	openid-connect
4f73b510-48b8-4e1c-8e79-e1c02fce31c5	email	6bee13ee-c458-477d-a219-83a4deb1977a	OpenID Connect built-in scope: email	openid-connect
4ed58e53-b7d1-4480-80e4-b2958fd448c1	address	6bee13ee-c458-477d-a219-83a4deb1977a	OpenID Connect built-in scope: address	openid-connect
87fec71d-7177-489f-af5e-a8514ea517d1	phone	6bee13ee-c458-477d-a219-83a4deb1977a	OpenID Connect built-in scope: phone	openid-connect
2daa6801-b039-4d7e-9e9d-fb6892ebf37d	roles	6bee13ee-c458-477d-a219-83a4deb1977a	OpenID Connect scope for add user roles to the access token	openid-connect
b46fa1d5-bd31-4375-8ac1-880a313bbe47	web-origins	6bee13ee-c458-477d-a219-83a4deb1977a	OpenID Connect scope for add allowed web origins to the access token	openid-connect
196cae10-a248-472e-bb43-c27def2cf829	microprofile-jwt	6bee13ee-c458-477d-a219-83a4deb1977a	Microprofile - JWT built-in scope	openid-connect
117c9415-9629-4d47-9d8b-ac41aa986328	acr	6bee13ee-c458-477d-a219-83a4deb1977a	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
ffd5390e-5248-41f8-bf25-d266258ade63	basic	6bee13ee-c458-477d-a219-83a4deb1977a	OpenID Connect scope for add all basic claims to the token	openid-connect
e0928e6c-b0a1-4229-9738-587dfe498bbb	organization	6bee13ee-c458-477d-a219-83a4deb1977a	Additional claims about the organization a subject belongs to	openid-connect
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
b2380bdf-aa21-4971-b6a7-b54c82fdfdb0	true	display.on.consent.screen
b2380bdf-aa21-4971-b6a7-b54c82fdfdb0	${offlineAccessScopeConsentText}	consent.screen.text
92bb12df-b3cf-4b58-a22a-58927f4ef055	true	display.on.consent.screen
92bb12df-b3cf-4b58-a22a-58927f4ef055	${samlRoleListScopeConsentText}	consent.screen.text
a8e5bb25-05b4-431e-b8a1-2416e612fa43	false	display.on.consent.screen
2f80d67d-f8eb-44f3-afd8-2cdb8c002321	true	display.on.consent.screen
2f80d67d-f8eb-44f3-afd8-2cdb8c002321	${profileScopeConsentText}	consent.screen.text
2f80d67d-f8eb-44f3-afd8-2cdb8c002321	true	include.in.token.scope
4f73b510-48b8-4e1c-8e79-e1c02fce31c5	true	display.on.consent.screen
4f73b510-48b8-4e1c-8e79-e1c02fce31c5	${emailScopeConsentText}	consent.screen.text
4f73b510-48b8-4e1c-8e79-e1c02fce31c5	true	include.in.token.scope
4ed58e53-b7d1-4480-80e4-b2958fd448c1	true	display.on.consent.screen
4ed58e53-b7d1-4480-80e4-b2958fd448c1	${addressScopeConsentText}	consent.screen.text
4ed58e53-b7d1-4480-80e4-b2958fd448c1	true	include.in.token.scope
87fec71d-7177-489f-af5e-a8514ea517d1	true	display.on.consent.screen
87fec71d-7177-489f-af5e-a8514ea517d1	${phoneScopeConsentText}	consent.screen.text
87fec71d-7177-489f-af5e-a8514ea517d1	true	include.in.token.scope
2daa6801-b039-4d7e-9e9d-fb6892ebf37d	true	display.on.consent.screen
2daa6801-b039-4d7e-9e9d-fb6892ebf37d	${rolesScopeConsentText}	consent.screen.text
2daa6801-b039-4d7e-9e9d-fb6892ebf37d	false	include.in.token.scope
b46fa1d5-bd31-4375-8ac1-880a313bbe47	false	display.on.consent.screen
b46fa1d5-bd31-4375-8ac1-880a313bbe47		consent.screen.text
b46fa1d5-bd31-4375-8ac1-880a313bbe47	false	include.in.token.scope
196cae10-a248-472e-bb43-c27def2cf829	false	display.on.consent.screen
196cae10-a248-472e-bb43-c27def2cf829	true	include.in.token.scope
117c9415-9629-4d47-9d8b-ac41aa986328	false	display.on.consent.screen
117c9415-9629-4d47-9d8b-ac41aa986328	false	include.in.token.scope
ffd5390e-5248-41f8-bf25-d266258ade63	false	display.on.consent.screen
ffd5390e-5248-41f8-bf25-d266258ade63	false	include.in.token.scope
e0928e6c-b0a1-4229-9738-587dfe498bbb	true	display.on.consent.screen
e0928e6c-b0a1-4229-9738-587dfe498bbb	${organizationScopeConsentText}	consent.screen.text
e0928e6c-b0a1-4229-9738-587dfe498bbb	true	include.in.token.scope
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
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	4f73b510-48b8-4e1c-8e79-e1c02fce31c5	t
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	b46fa1d5-bd31-4375-8ac1-880a313bbe47	t
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	117c9415-9629-4d47-9d8b-ac41aa986328	t
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	ffd5390e-5248-41f8-bf25-d266258ade63	t
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	2f80d67d-f8eb-44f3-afd8-2cdb8c002321	t
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	2daa6801-b039-4d7e-9e9d-fb6892ebf37d	t
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	b2380bdf-aa21-4971-b6a7-b54c82fdfdb0	f
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	e0928e6c-b0a1-4229-9738-587dfe498bbb	f
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	196cae10-a248-472e-bb43-c27def2cf829	f
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	4ed58e53-b7d1-4480-80e4-b2958fd448c1	f
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	87fec71d-7177-489f-af5e-a8514ea517d1	f
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	4f73b510-48b8-4e1c-8e79-e1c02fce31c5	t
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	b46fa1d5-bd31-4375-8ac1-880a313bbe47	t
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	117c9415-9629-4d47-9d8b-ac41aa986328	t
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	ffd5390e-5248-41f8-bf25-d266258ade63	t
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	2f80d67d-f8eb-44f3-afd8-2cdb8c002321	t
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	2daa6801-b039-4d7e-9e9d-fb6892ebf37d	t
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	b2380bdf-aa21-4971-b6a7-b54c82fdfdb0	f
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	e0928e6c-b0a1-4229-9738-587dfe498bbb	f
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	196cae10-a248-472e-bb43-c27def2cf829	f
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	4ed58e53-b7d1-4480-80e4-b2958fd448c1	f
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	87fec71d-7177-489f-af5e-a8514ea517d1	f
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	4f73b510-48b8-4e1c-8e79-e1c02fce31c5	t
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	b46fa1d5-bd31-4375-8ac1-880a313bbe47	t
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	117c9415-9629-4d47-9d8b-ac41aa986328	t
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	ffd5390e-5248-41f8-bf25-d266258ade63	t
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	2f80d67d-f8eb-44f3-afd8-2cdb8c002321	t
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	2daa6801-b039-4d7e-9e9d-fb6892ebf37d	t
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	b2380bdf-aa21-4971-b6a7-b54c82fdfdb0	f
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	e0928e6c-b0a1-4229-9738-587dfe498bbb	f
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	196cae10-a248-472e-bb43-c27def2cf829	f
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	4ed58e53-b7d1-4480-80e4-b2958fd448c1	f
6e68b3b3-63af-4adb-8e2f-0c8db30c3af6	87fec71d-7177-489f-af5e-a8514ea517d1	f
4a4c2929-7f3c-4971-a025-52e23c09e357	4f73b510-48b8-4e1c-8e79-e1c02fce31c5	t
4a4c2929-7f3c-4971-a025-52e23c09e357	b46fa1d5-bd31-4375-8ac1-880a313bbe47	t
4a4c2929-7f3c-4971-a025-52e23c09e357	117c9415-9629-4d47-9d8b-ac41aa986328	t
4a4c2929-7f3c-4971-a025-52e23c09e357	ffd5390e-5248-41f8-bf25-d266258ade63	t
4a4c2929-7f3c-4971-a025-52e23c09e357	2f80d67d-f8eb-44f3-afd8-2cdb8c002321	t
4a4c2929-7f3c-4971-a025-52e23c09e357	2daa6801-b039-4d7e-9e9d-fb6892ebf37d	t
4a4c2929-7f3c-4971-a025-52e23c09e357	b2380bdf-aa21-4971-b6a7-b54c82fdfdb0	f
4a4c2929-7f3c-4971-a025-52e23c09e357	e0928e6c-b0a1-4229-9738-587dfe498bbb	f
4a4c2929-7f3c-4971-a025-52e23c09e357	196cae10-a248-472e-bb43-c27def2cf829	f
4a4c2929-7f3c-4971-a025-52e23c09e357	4ed58e53-b7d1-4480-80e4-b2958fd448c1	f
4a4c2929-7f3c-4971-a025-52e23c09e357	87fec71d-7177-489f-af5e-a8514ea517d1	f
a3597a64-7ed1-4de5-ac8a-ea91b7261f36	4f73b510-48b8-4e1c-8e79-e1c02fce31c5	t
a3597a64-7ed1-4de5-ac8a-ea91b7261f36	b46fa1d5-bd31-4375-8ac1-880a313bbe47	t
a3597a64-7ed1-4de5-ac8a-ea91b7261f36	117c9415-9629-4d47-9d8b-ac41aa986328	t
a3597a64-7ed1-4de5-ac8a-ea91b7261f36	ffd5390e-5248-41f8-bf25-d266258ade63	t
a3597a64-7ed1-4de5-ac8a-ea91b7261f36	2f80d67d-f8eb-44f3-afd8-2cdb8c002321	t
a3597a64-7ed1-4de5-ac8a-ea91b7261f36	2daa6801-b039-4d7e-9e9d-fb6892ebf37d	t
a3597a64-7ed1-4de5-ac8a-ea91b7261f36	b2380bdf-aa21-4971-b6a7-b54c82fdfdb0	f
a3597a64-7ed1-4de5-ac8a-ea91b7261f36	e0928e6c-b0a1-4229-9738-587dfe498bbb	f
a3597a64-7ed1-4de5-ac8a-ea91b7261f36	196cae10-a248-472e-bb43-c27def2cf829	f
a3597a64-7ed1-4de5-ac8a-ea91b7261f36	4ed58e53-b7d1-4480-80e4-b2958fd448c1	f
a3597a64-7ed1-4de5-ac8a-ea91b7261f36	87fec71d-7177-489f-af5e-a8514ea517d1	f
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	4f73b510-48b8-4e1c-8e79-e1c02fce31c5	t
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	b46fa1d5-bd31-4375-8ac1-880a313bbe47	t
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	117c9415-9629-4d47-9d8b-ac41aa986328	t
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	ffd5390e-5248-41f8-bf25-d266258ade63	t
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	2f80d67d-f8eb-44f3-afd8-2cdb8c002321	t
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	2daa6801-b039-4d7e-9e9d-fb6892ebf37d	t
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	b2380bdf-aa21-4971-b6a7-b54c82fdfdb0	f
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	e0928e6c-b0a1-4229-9738-587dfe498bbb	f
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	196cae10-a248-472e-bb43-c27def2cf829	f
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	4ed58e53-b7d1-4480-80e4-b2958fd448c1	f
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	87fec71d-7177-489f-af5e-a8514ea517d1	f
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
b2380bdf-aa21-4971-b6a7-b54c82fdfdb0	b0de270c-6595-4103-830d-f1ec025efa89
b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	6d7b0d9a-0ac1-481e-aebb-8acd9d5c3e39
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
e577905c-a479-4b07-8868-9e49644b1dc2	Trusted Hosts	6bee13ee-c458-477d-a219-83a4deb1977a	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6bee13ee-c458-477d-a219-83a4deb1977a	anonymous
8046d4b8-e8f8-4a99-bed5-1b3bc273dc9a	Consent Required	6bee13ee-c458-477d-a219-83a4deb1977a	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6bee13ee-c458-477d-a219-83a4deb1977a	anonymous
34af3100-4ae0-4ad9-86c4-2ceb33a14db1	Full Scope Disabled	6bee13ee-c458-477d-a219-83a4deb1977a	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6bee13ee-c458-477d-a219-83a4deb1977a	anonymous
8bddc832-1a0b-4529-b46b-1ac70931191f	Max Clients Limit	6bee13ee-c458-477d-a219-83a4deb1977a	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6bee13ee-c458-477d-a219-83a4deb1977a	anonymous
89878b20-1b16-48aa-b107-4759f9ac06fe	Allowed Protocol Mapper Types	6bee13ee-c458-477d-a219-83a4deb1977a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6bee13ee-c458-477d-a219-83a4deb1977a	anonymous
8a409183-b1d8-4e02-a3f8-f4efdc3cac82	Allowed Client Scopes	6bee13ee-c458-477d-a219-83a4deb1977a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6bee13ee-c458-477d-a219-83a4deb1977a	anonymous
0c308c58-3a3e-4cdc-8c4f-c76e6f91b5f5	Allowed Protocol Mapper Types	6bee13ee-c458-477d-a219-83a4deb1977a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6bee13ee-c458-477d-a219-83a4deb1977a	authenticated
6dcbecd3-c9ed-4e79-8daf-35fe547fc7e1	Allowed Client Scopes	6bee13ee-c458-477d-a219-83a4deb1977a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6bee13ee-c458-477d-a219-83a4deb1977a	authenticated
855ebfaf-d1e4-4e1e-becb-0d740bd9b814	rsa-generated	6bee13ee-c458-477d-a219-83a4deb1977a	rsa-generated	org.keycloak.keys.KeyProvider	6bee13ee-c458-477d-a219-83a4deb1977a	\N
fcdf59c2-f31e-4959-9aed-2fef3a2f8dc9	rsa-enc-generated	6bee13ee-c458-477d-a219-83a4deb1977a	rsa-enc-generated	org.keycloak.keys.KeyProvider	6bee13ee-c458-477d-a219-83a4deb1977a	\N
2891f481-5b84-4c72-b4ea-10d31c28de0a	hmac-generated-hs512	6bee13ee-c458-477d-a219-83a4deb1977a	hmac-generated	org.keycloak.keys.KeyProvider	6bee13ee-c458-477d-a219-83a4deb1977a	\N
5bf5e39b-ce7b-4eff-ae49-7b6f434cf33b	aes-generated	6bee13ee-c458-477d-a219-83a4deb1977a	aes-generated	org.keycloak.keys.KeyProvider	6bee13ee-c458-477d-a219-83a4deb1977a	\N
e7b1682d-aa83-48a3-931e-1ba936d3a63c	\N	6bee13ee-c458-477d-a219-83a4deb1977a	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	6bee13ee-c458-477d-a219-83a4deb1977a	\N
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
f28328b7-1dc4-46e8-a0bf-b2bfd39b6105	e577905c-a479-4b07-8868-9e49644b1dc2	host-sending-registration-request-must-match	true
305a6a5e-4518-46fd-ba1d-47eba4e5e587	e577905c-a479-4b07-8868-9e49644b1dc2	client-uris-must-match	true
5cac5e4b-398f-4902-82b7-fdd99af7b4e8	8bddc832-1a0b-4529-b46b-1ac70931191f	max-clients	200
da07e118-4cd6-4cc5-9b4d-10808a7b2a35	0c308c58-3a3e-4cdc-8c4f-c76e6f91b5f5	allowed-protocol-mapper-types	oidc-full-name-mapper
4a7c4464-5023-4515-b375-8a4d82200f59	0c308c58-3a3e-4cdc-8c4f-c76e6f91b5f5	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
f192f27b-163a-42ce-8e82-88f53d7c188d	0c308c58-3a3e-4cdc-8c4f-c76e6f91b5f5	allowed-protocol-mapper-types	saml-role-list-mapper
286497ad-8a36-453d-9e69-6a33850ec2d8	0c308c58-3a3e-4cdc-8c4f-c76e6f91b5f5	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
df3023b4-c310-435c-9129-d73e21b80f6b	0c308c58-3a3e-4cdc-8c4f-c76e6f91b5f5	allowed-protocol-mapper-types	saml-user-attribute-mapper
0b211bc6-3005-4915-92fe-d638233f7b8b	0c308c58-3a3e-4cdc-8c4f-c76e6f91b5f5	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
53cea7cd-c34e-415e-ab9b-6ce0facd0102	0c308c58-3a3e-4cdc-8c4f-c76e6f91b5f5	allowed-protocol-mapper-types	oidc-address-mapper
cd832ee5-4dc2-4baf-8ca3-2ebccaa0a80e	0c308c58-3a3e-4cdc-8c4f-c76e6f91b5f5	allowed-protocol-mapper-types	saml-user-property-mapper
f1199d48-0fdb-4b90-ab79-1268f505f017	6dcbecd3-c9ed-4e79-8daf-35fe547fc7e1	allow-default-scopes	true
8ed41828-d13a-473d-bbee-adf28b0f6b93	89878b20-1b16-48aa-b107-4759f9ac06fe	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b47f89a0-eb45-463d-a77c-41a00080d948	89878b20-1b16-48aa-b107-4759f9ac06fe	allowed-protocol-mapper-types	oidc-address-mapper
a29af4ab-8e30-40c5-8941-1860c2fc29aa	89878b20-1b16-48aa-b107-4759f9ac06fe	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c8f4be63-463f-4887-803f-676ba581b16b	89878b20-1b16-48aa-b107-4759f9ac06fe	allowed-protocol-mapper-types	saml-user-property-mapper
a5f9b72f-9d38-4bea-9e55-5e671a2c2a67	89878b20-1b16-48aa-b107-4759f9ac06fe	allowed-protocol-mapper-types	saml-role-list-mapper
3f88b58a-6d11-4912-b010-7961921893e8	89878b20-1b16-48aa-b107-4759f9ac06fe	allowed-protocol-mapper-types	oidc-full-name-mapper
7f4a2576-4cf2-49f2-8a18-3ac35a1bf55e	89878b20-1b16-48aa-b107-4759f9ac06fe	allowed-protocol-mapper-types	saml-user-attribute-mapper
30453538-c57f-4a80-8b9c-e794e51a3a62	89878b20-1b16-48aa-b107-4759f9ac06fe	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5c8755f0-c709-4b9e-8ff9-b2387825b500	8a409183-b1d8-4e02-a3f8-f4efdc3cac82	allow-default-scopes	true
f5478c33-a7d0-4d30-8ddb-906ade06901e	e7b1682d-aa83-48a3-931e-1ba936d3a63c	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
f1eceee6-36bc-4dfe-834b-8ff8591eaa8b	5bf5e39b-ce7b-4eff-ae49-7b6f434cf33b	kid	ed72f92e-c749-4455-8bbf-f7a948b67081
e11745b6-27af-41e9-9b6b-abae0c731ea0	5bf5e39b-ce7b-4eff-ae49-7b6f434cf33b	priority	100
75ede784-5837-4140-90c1-91db0333026f	5bf5e39b-ce7b-4eff-ae49-7b6f434cf33b	secret	ME0CBK4M4E_F8NEmfBkJGg
ad4cc794-3338-40f1-a767-6dd389fec4c1	2891f481-5b84-4c72-b4ea-10d31c28de0a	algorithm	HS512
bab5db4c-b2a6-478a-8491-db7cf14799b1	2891f481-5b84-4c72-b4ea-10d31c28de0a	priority	100
6cd4a5f0-053d-4019-95d2-a6f97d7b4b12	2891f481-5b84-4c72-b4ea-10d31c28de0a	secret	WLsuhZBY2ES0hA2BkPtrjPc_5tNv5ol0DEBOEL2qLNwqVDMR7mDFA8t50Ol2GYHuxAxsqX0nsZpFmkj5zi6_c5z56Ec7ETxTbpDLVBZczWgtJGXImY2usBq9SahZxNHiIqO5Hes7QjHifuRe0NCgVgtqTFY1HCGI5DyZXqArmfo
6be9e20a-69cc-4cea-9569-ebc42c411889	2891f481-5b84-4c72-b4ea-10d31c28de0a	kid	0e7823b4-471c-4ade-af3c-c1d8f17e1852
bfd66df3-cb8a-4049-8bdf-d1cca03abeac	855ebfaf-d1e4-4e1e-becb-0d740bd9b814	privateKey	MIIEowIBAAKCAQEAvh9FV+b+6SuPxJP6MqT3llxhg+sJffZF6+Cks6eSjVvfaLsqJq2lHiiYVz2RW+ngA0R7d9xWUv9u2YiEH/ArBwEENSuigwXQ6xmdSARnV5sARxaSUbjy22o/KFDYhg/85X63O2/06J78Xefs0bDDfiqQJuVwI31bxl/kHtOfW0wOrGIF7cHRuaL9sKrpRl6oJFmXXK4X9dlo7+iAi3HmpMZHFaCenyl+qqMloW3MMsmnPV2eK6EqrJYu3uYiehi+RZ/mQShRL+Ogza7pG7OjqE1iUYgJ+vITu4QPpv7rxaQ/SFSdG0y5w7z6OFDKNofo4SJlO1aCqgNyx0TxuBFnJwIDAQABAoIBAAc1H0dcUfib9qjQpVELMPmpyeaa3/K/BdqR2xyWczdZrsgFJG1v8s0IY/IWuu59mMj27SlXmIwv889aXgvp6m+rCbJMU65c55UqFOzYgeRv01xejjB77vUDe553JiY67+7xVVfzABlbgZy7wJ4YcejUCz/2PcCSrYqBMyA6DJYE5NZNjo7Y0IMwhAz6hY1c5yGw4HqIVaxeBl1ycwDSDbUK8YVO+3S1HWqwfV5yAaq7WuvhTeBz76Z9QyjtXwH60Vx5AGoyR1j68z4gpM+fCfU2FTghuC9qAjRbwvVVEirWy6t1NIqSEcplrNohP8dfwqpjDAiwR3P2V+supCLbe1kCgYEA7+MKHPNvAxkx847y9JIl4JMa4yD5mnO2Vd8nnMEY+GHYXzu6BsYUpAYj//JmGh0Cbw064GyX4X4dFKQ9v/kRrUWCJOam8OgCb0/3XZV7C3nRJ8u0TRgrCRSw2JNF+bvBbd5MDFhdyxj/GNtrJldwtTObzicEemJpDPpHMSmBKKkCgYEAyuSBS2PL/swGKd5FrsCkgdoXr7V29HIlRBA0tekMD5Wna6nVNDCbDKL18enTmRLW3Ze3z9rF40inZy37FITbpuRchH0bQpQzZTVlOStA1FSa/ivhaMraPwJTuTSWvJIbb9ygIr00CL09n3AnpVpSMAE5D8Pdyjm2vuAMF+Ho408CgYBNd5hQeRykd4J2EPfMm1W4DElmh8OTaUK8wG/eY01ZCOADARq2DUmlHoaJpRHr5OpgSnl0+BykKUHi5Jc8Y4ad2hCJMiM/MO14XO6ZPiiaMCCnJVV4gBGFwTTK++RhHYz9mggdBHxllhDrShB0NVCkc6IhFOCRVS5vjnNnIOwg4QKBgQCyi/5AIvWdJ1xxMdpum7bpUsyvYujo2x5yVDSetRRZDqDDvTQTdoaryyjWl6gPOCX/4YjvkJ2+kuxGf49KElTd/G5yZUo9AABum1uVwLuPX1j6PhFiT8lZ06lr/Zx9G7KrcSM3DvugiTCWg3NQLzjOZ/UYK4ydbsakGLRru/FfPwKBgCzuZJFqxKuYBf1bCxBNaGkDuDKtofazVVuPD9aNc5r+dGdRqHKtFW1876JGb7a90zcAr2kQomXRovGro51vvFhqWmy8Mzq0CTR/+vz9bla/c0Xf+yV3gfbQU3rrcKgbqBE9I9AzFJja5FT59qm7/zH8p73hezydvZ+lxQQ1lypB
b6079a80-75ea-4427-9d75-0516af8f7913	855ebfaf-d1e4-4e1e-becb-0d740bd9b814	certificate	MIICmzCCAYMCBgGbthNSvTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwMTEzMDYzNjE4WhcNMzYwMTEzMDYzNzU4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC+H0VX5v7pK4/Ek/oypPeWXGGD6wl99kXr4KSzp5KNW99ouyomraUeKJhXPZFb6eADRHt33FZS/27ZiIQf8CsHAQQ1K6KDBdDrGZ1IBGdXmwBHFpJRuPLbaj8oUNiGD/zlfrc7b/Tonvxd5+zRsMN+KpAm5XAjfVvGX+Qe059bTA6sYgXtwdG5ov2wqulGXqgkWZdcrhf12Wjv6ICLceakxkcVoJ6fKX6qoyWhbcwyyac9XZ4roSqsli7e5iJ6GL5Fn+ZBKFEv46DNrukbs6OoTWJRiAn68hO7hA+m/uvFpD9IVJ0bTLnDvPo4UMo2h+jhImU7VoKqA3LHRPG4EWcnAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGJd1KEcpSfV9y50qftCKzgSnp17zk3+B/2QPmU3jbinD0SNrTJiCq+QOesj3JDpDk5NfhoAKpyvYX8eV1ydKz8t2cbeR/Q9h6oGpR/I7RzMZHdLZoT0lbTNWTDh+E7F3ZQxd3AAv4KqRBTaczYBTjGmMSHzAXDKHUdsdJwjJ6UabdjX8yx7ri3oHqSgCAroW54E9JXzqs9UMC8EdyHmFJyhFeEHkLqgnyPgAas2d6DrlJVmwHtrdObpuhsPPsBb3zSqbAsHxRLYqCjj7Sa7wTLRGq2HcdCKCEwQZ/URLP5arXvFNXhRZivcNPJZmoHQ0kcjkp6U3+yVXbQNoJzHld0=
4682ccc5-b732-42a4-a7dd-ab22e247b9d0	855ebfaf-d1e4-4e1e-becb-0d740bd9b814	priority	100
7e587220-5837-4c74-82f8-84f1b03299e7	855ebfaf-d1e4-4e1e-becb-0d740bd9b814	keyUse	SIG
6f2914e4-f941-4eb4-aa70-c3a717744d60	fcdf59c2-f31e-4959-9aed-2fef3a2f8dc9	keyUse	ENC
50c0902e-1740-4af1-86da-3a1f16272b66	fcdf59c2-f31e-4959-9aed-2fef3a2f8dc9	certificate	MIICmzCCAYMCBgGbthNVkDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwMTEzMDYzNjE5WhcNMzYwMTEzMDYzNzU5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDp2B7uDXZn5FkRoei9Nw4AB9sGbqm6IkAepbAC0RGyiNzCmipc7B+VMiKQW7JbyeHGNK+s4Qyn+vQYT/gq8xqNc6dAeuPmKRsxTjYdHby2gy63kklLQFq6eX0GnPE4uMVTVwRYpA9R+u4zi9hMKVdwIlQ4YaGckNT88EvvvcgY2gyNn02SgZRkIlMV8hyrUIKHr9qC5XS6WiyvO+dXAId3pwc0TYcaf4qK0qrlGRQ4h2fdNaQAG2nyIR09yFhUX9FK++OsiWezIlesfjueBmGa2PgBe1K4ja0N9i+WC/6dy0IvKavam/6wbAbfv8MsJ+NEC/U/zZWObnYvsMxtmKcJAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEWt06QHTb8ItqgiB+50fz0bpoezw24vp/rl14HoFwcIDMbVZNr+ZwR9CDz5wBXqqklyZZ5eowin5NJ11YjpihVOz3jRcr2yXYjmMlWogwWq/HXpG/S4obTDXbelFgDcR+0n3cXPeAvC5Lw8xpPmhoFbEni/RgAERzpoDMt5pVTgg8yUjA8WjcRZ6I6rXX8UI+DmDYSGHj8lp5b/9glUh3Dso/9DLXruHnBBwdHwW04APAcV7StMO/FV0xhRSRFQa8/pRZfkrDh1nO9OdNrnd0iM9Pw+We8Dt48PKWHXtRnxYHY/edeVFHbFkN1anWPek+AVnkPl2ZyP72XLMEjBVY8=
861eeaf1-c37e-475b-be64-9f0154871a39	fcdf59c2-f31e-4959-9aed-2fef3a2f8dc9	algorithm	RSA-OAEP
9688ea93-9a77-4c3c-8a50-e4fca128d550	fcdf59c2-f31e-4959-9aed-2fef3a2f8dc9	priority	100
77e25a13-e150-4d4d-ab1f-2c1e34ec5d46	fcdf59c2-f31e-4959-9aed-2fef3a2f8dc9	privateKey	MIIEpAIBAAKCAQEA6dge7g12Z+RZEaHovTcOAAfbBm6puiJAHqWwAtERsojcwpoqXOwflTIikFuyW8nhxjSvrOEMp/r0GE/4KvMajXOnQHrj5ikbMU42HR28toMut5JJS0Baunl9BpzxOLjFU1cEWKQPUfruM4vYTClXcCJUOGGhnJDU/PBL773IGNoMjZ9NkoGUZCJTFfIcq1CCh6/aguV0ulosrzvnVwCHd6cHNE2HGn+KitKq5RkUOIdn3TWkABtp8iEdPchYVF/RSvvjrIlnsyJXrH47ngZhmtj4AXtSuI2tDfYvlgv+nctCLymr2pv+sGwG37/DLCfjRAv1P82Vjm52L7DMbZinCQIDAQABAoIBAACwb58UK5y5WoBADCJ9pyM4tTHLTZ0dI05w+Q+m7kVxxNekY0FxQW1UY0DkJ9nLzhUIn1dOCC/fcgImYUyZawDtaZ+gLt/b2gA4n4BiYM7xE9wJq34qLJ0gQvusDQ3def3O7yLVhcBZFOTHJ34W8zyIv4A4MfpdfIM3T5opdrhEjxPSpub63FhyqjFpHZCkVyqf6eJUx6JDwI28QYXA/2ZHretIEIDI60XL//CPhoU6CkP1OuPUNB2zTRAjW6CYOzQ9Lpk5rhnpVOhyuWASoDzh+3oHGgIauvlHi+LHNq3R/Mn96MGGA3VzJ/D6tNVduFLPKHgocviij9RIt8jBQEECgYEA+MuXYg4Yz+o9msYkDkPIeoQ5Bm5buQwFCmRTZucu7fdeRAzn3k+39xwP062fX4/AdncU9fsUwPRO0Hw6hL3AtxpgUN3cNBu1VAjQcnzqep9MQxU2PCyHERlSkuYmCnNBL3yEyYdqHuMBrZZBqchF5DCozE77MzCB1PKZun86X60CgYEA8J2xIn3zBwMoQkjUAi3e/jFzccwWvRCxS6zLj8xB/iATmh6kYkbVSI7x5rtOZEI/MVAtR+OXZzRQsu7xGOxWrj3/XgTaY/apIVMdDhxlHx8/p3qzbYqTYFS67OXArf7F/w0Udb/qH05eI0TOKcmVp6qijhpejbKZqm0FMLrtYE0CgYEA3tzwxENAcq6vdH9dOPH7GdRriJk+zKo5sa9hDmK0pTHbXTX6Vigu8MpQWxvCEcYhb30IZ7f8RUQTfapqeRHJGbwk3wt9/6d6bMZggs3m9OTRWZ4csRZp/yUh1LkZBm9ryu/NuwD0TKqojCh2tXHTOa9k5W8ykg43ntuaXXcugRkCgYB3A4i6JtIuhcFECAHVkhraYFtZzjjxC3CmnbGSTtXVfMg1UzK76Y1Vdl7wYXVE4f+fxKihBlG9GoNP/iAC0+OMC95kAsKC7154vUOB10mtOyehD2/wnrqGy2IqCvpjFcGZhj64f1SuZ3TovP+8a5k6dYwx/ZkHPXAEfCg1EkCXgQKBgQDyGPh1FMgOdhzlWR+ufaf4HIAjG0aUYg3QD6uHQHB5CpUF7Rl5ApFa4tSLMLmc75hpul9PEeUfpREGSEibn1XgtM1bKgWSrDAjh0K9hyPmlu8qOwV/oGDmscBkWWe4PIqL9AXwRgzusA94CFAdArRJZQK626bP0ahYT/RCDLJnOA==
197e187b-7e84-45ab-bbb5-68954023bf9a	1f601b2d-3f3c-4ee1-93f5-cd33a0c3c6cc	kid	3ed0052c-1007-4708-82c0-3497b75085c8
bc46ef0f-82ab-4135-9de1-eb4058f64887	1f601b2d-3f3c-4ee1-93f5-cd33a0c3c6cc	secret	jGKBzJa7FSua3xfWVN9caQ
6a7703e1-e297-4b29-a9c4-0350fa17f618	1f601b2d-3f3c-4ee1-93f5-cd33a0c3c6cc	priority	100
a872ca37-9b47-425a-8e81-a925425d0334	bf7bc4cc-455f-4d74-ac97-b854b8f126e8	allow-default-scopes	true
e2a17a40-d875-4ba3-a938-dba02dba3332	82d74645-ff8e-460e-ab07-a44369c80932	priority	100
65beb258-f288-4999-b54c-4ebe0e7c7eec	82d74645-ff8e-460e-ab07-a44369c80932	secret	mKtc1ZS1Zure5wtquXmZDQJiuhiDEWLpBWY2phgKVV27UO-Oga5WRLy8sRhbO_zKE7UHVZDOwZRroPWvhZD2lsJ1YSaSrZb0yf_9hRKthz4JcGYdOqDVI7w76zdxtHhq9dkkCqgAmOdj7iYiYu7oBBcwd6eWuaHtnIi_q_3j8fw
9af41426-5281-4abd-ac01-bd76ec7457ba	82d74645-ff8e-460e-ab07-a44369c80932	algorithm	HS512
e82a4e8c-3509-4266-8733-d6c2686e5c7e	82d74645-ff8e-460e-ab07-a44369c80932	kid	ebb575e0-6a98-447c-97e1-37c876a2e327
4eb2c912-de12-4b5a-aabd-9c42b2730309	4dfd41fa-a9eb-4922-a0cf-d4f7a8ae24c1	max-clients	200
a759d280-2275-47a0-ad64-22f2e203e2a2	2feec9eb-9647-4299-86f6-bf7d63fe6ff0	allow-default-scopes	true
af53d988-106a-4db2-a2f8-f5f66f5dd797	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	privateKey	MIIEpAIBAAKCAQEA1AoIizYWkAYXg2/eJllPeeS2mBypw2cx1LrPukbrAFrMHvKl+AsKKHr55oPP4n9ZHWMi0NZm9pIdBX6jm6OYsm76cB1HPUjYyxU9iwf2rj5kHOAVRon/1BBAX+v3agXQoMQM4Sski+tmFzhYZUyMJL44nZb9Vo6t2/prOh9uQuJSsaNMRpgmCcV8PwNjKv5G8pm9dvW4KSC/sDLx9VYYe+gqTDhLzu+Dh3gMoD8fMVnIw5c4ZSyWKcbkwwh8wcUVRfZJ9GsC+Zdw44o1yNgHQSFOIvIjkwyW1yLFObOJf5g55c3p9lqu4nlTwcupHkdGimV1WgX2XPnMxuK4LO/2UwIDAQABAoIBAGAzOyQZwovOT72ws9u3OmElnJgPrQ+70nZe2R78zOLIzwIdeaI7M/0gqh9k3xy2RVKZZzLTizxEF0mmZokW5JDT2+igx/Dsi3s75EOfNdJg+R/GpLBvrLNkOiiq0IH4KGq/983yum6Gurc/N4+h9pU2/k21MrQiIIwEpcBlgStzWd3TMlWmSy965bHkF/wET9RrIMR/SWIfgg7nm7lK+VGxVyJay15639EHd7x/rdp6LiBG2uIipZD+NA6WLuOZG86toDUcPas9Di9mkGm2EW3GAxaSz9T47CdJr5hcX7F5CqBn6tnbY5ssJnwi0HUF203Bc/6Z3wh7NGAyGxzMXxECgYEA/3WJ+vIU9K4JWgNFzfbz46rtCOlRgepCeYtoopfHBfkO/cxyK3/SBB1SUt5yWzp/sr6sADXl67932wuxtZozFBC+UKEUCDPK/Qs1TctG/KjS7mdgQvxXt6TpT9C+kTvyo8L9g+rdMrQ8Cs5qtajWaVv/ohMhqfWFk6Apn1p9kTECgYEA1Hz13YrVwyrkBGb0fjW2b09qS9FuLX6WDaR9WZ3GA9APTz4K+zYWtNFfUHwufhO4Z0zxxSlyaiwClRSuJFhFk4DgxB1mUv0wHtPppY8f0jKcnwS3JDL7K4DQ9T5suA21Zt9zUemrMwA+WM/TghTvXplHHtuUhv/fHYglx8QIvsMCgYEApwrOzN8bQNvEla1qKcH/vLF6Cce3WoI6MYwtQZSJuaggW2kihrswMyyRNkrq8CiSc+kmQ4T68WrkDsHY1G0eVVKVf9e0Z6CmbUy08EeqBXDHbMkAMw0atqUJQv22fvV6Ngc9CtO7DHq6gD51nI/olEBqKirkamR3kg666M6dKSECgYEAybvJgQeqYpx51mQYgypjhdITzN+MhszDkTg1ebt8n2oM3uK8cjur2wdcQoFjcncuf4RhlRoAciROX1M+8WqMw7l7qzVuTCPsZ5gxHul/AITkhWRoq4lrRKYLvIoDlcoOCxjh10bNLqJwjsjguYM+rsU+7GDz5idOoC7+D2ZiFxkCgYAns+C2iIbw4M1w3NSFeeVwVDzwSW0c45CNq8BqA1fKqjzS11zmrI5162e+zJI91uF32k1hbWAgrxZV0KuBS+NIhX0hf2nmiTMm3KrGSvx0MLwxX41qPHD9OMW35rzXdXV8scMHkFanJnqDzfTijvCRO3CTqxhnxr36ZEIsdJ7uAg==
f000c6dc-fc4a-4750-9c30-b75f3e15cfb7	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	algorithm	RSA-OAEP
ebe4ca56-4955-4687-bfe4-79e047671fec	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	priority	100
fbb9ded5-72ea-4e2c-9bc8-ee765d275e0a	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	keyUse	ENC
6e4674fc-e53f-474a-b1db-f28c2d0dc93c	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	certificate	MIICozCCAYsCBgGaaGXlZzANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDApsb2NpLXJlYWxtMB4XDTI1MTEwOTExMzMxOVoXDTM1MTEwOTExMzQ1OVowFTETMBEGA1UEAwwKbG9jaS1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANQKCIs2FpAGF4Nv3iZZT3nktpgcqcNnMdS6z7pG6wBazB7ypfgLCih6+eaDz+J/WR1jItDWZvaSHQV+o5ujmLJu+nAdRz1I2MsVPYsH9q4+ZBzgFUaJ/9QQQF/r92oF0KDEDOErJIvrZhc4WGVMjCS+OJ2W/VaOrdv6azofbkLiUrGjTEaYJgnFfD8DYyr+RvKZvXb1uCkgv7Ay8fVWGHvoKkw4S87vg4d4DKA/HzFZyMOXOGUslinG5MMIfMHFFUX2SfRrAvmXcOOKNcjYB0EhTiLyI5MMltcixTmziX+YOeXN6fZaruJ5U8HLqR5HRopldVoF9lz5zMbiuCzv9lMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAkYztEr6baQvXYMCHk+ERJKvcAcPC+vJem/CbgAPvkVafToIUxnGOJbLU/MjZMqt2qLxwwfYtcucylE8PoqfjKhW7rImCJPQjezrPtoWoDPzEJ7JCxWoWTlpjSvlprf6zBTt+0YQ1by8OpMK+6WRvJtoNOqzzodpQ9DaqXWYxJegfU5F7bK9pVTyT3J46SIydmnX8Lfwsu+4j5W0kl91DuN1kxLb1294TogP0ERfTtCI+r8KFHGc+1SbizF1bCbpeT9VBWcfSBhyGh1UhgCsSPl9R+9xIRKPoIMmaGZ77pjJ/P7AFvu4LXa5DKgMcAsE0K84fIvC2Xa9phDjNN3zXiQ==
a19c9db2-8138-43cf-b5b0-de67bd0ea6b6	501abdae-a433-4e54-985a-a9fdf84bf3b8	certificate	MIICozCCAYsCBgGaaGXjJjANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDApsb2NpLXJlYWxtMB4XDTI1MTEwOTExMzMxOVoXDTM1MTEwOTExMzQ1OVowFTETMBEGA1UEAwwKbG9jaS1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALq0+UKen6c2JObNK+a77JbagYsjCNXyOWoNlzulJ+oJ27oSTLfOMpShFNEJU/OOFpqdvolsMJJRh8+o9TUrKhWF1Mkwy17pKbC3xUeX83HrVidxTYsEBkbqHUURxYfab4fOYD5BUkb0iOokqkq2DUowwpRKRIx+UvTJ/FIBExZbB66rAUAixRjsVM7lDRHu7cQE+3ZEhhsWSnfqssWRhS8Z5+D0+j3PNqjfH+WUus5Ch4wpPs3muiHHS26ZpzZ6E4UazHZg32Qxy4kSq1/8B24cvnZviuWfqo/v/nevhtvT4F2+8/ItOmBBcmJZQ5c1LfKVtvngps2Y8sCXJgC8GyUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAjNmlykEGuC6D4Gd90FsdRSFnxyKHMfRv7mjBXhjm6uH3RnVx0IiXlb80n2mWJBfXaEV+z6OcmOii1dlSR3+QvsfxnmKUTu6OMD8hqKmAvcBrK87XWPU3VrU+1clnG/AvuhzTMfx+SyptkeyH9nGfbxec2Pk86dc4qJTr6y5qkv6kP9K5wHZPSo0qVxhnk81N+dLl+h9sxgZSY2LkH+WwcQXN36YUWxG7RUZYm9JCxw5utJCPILspDxqKLI4R6gxJ9uV/UBhhqAkaEP0qR2oKmOwxJVwCr4O2WPbU15P2L9h/69za69ipgxRDiSerDoNOvLq4C3O4hJ607ktYIHLzIw==
d5474a3c-7966-46c7-8653-fdbb0c38effe	501abdae-a433-4e54-985a-a9fdf84bf3b8	keyUse	SIG
887c25dc-f455-4ded-a3aa-e5a87ab3a6a5	501abdae-a433-4e54-985a-a9fdf84bf3b8	privateKey	MIIEoAIBAAKCAQEAurT5Qp6fpzYk5s0r5rvsltqBiyMI1fI5ag2XO6Un6gnbuhJMt84ylKEU0QlT844Wmp2+iWwwklGHz6j1NSsqFYXUyTDLXukpsLfFR5fzcetWJ3FNiwQGRuodRRHFh9pvh85gPkFSRvSI6iSqSrYNSjDClEpEjH5S9Mn8UgETFlsHrqsBQCLFGOxUzuUNEe7txAT7dkSGGxZKd+qyxZGFLxnn4PT6Pc82qN8f5ZS6zkKHjCk+zea6IcdLbpmnNnoThRrMdmDfZDHLiRKrX/wHbhy+dm+K5Z+qj+/+d6+G29PgXb7z8i06YEFyYllDlzUt8pW2+eCmzZjywJcmALwbJQIDAQABAoH/MTI09Wqj60VjL2N9sbFtbgt+FuwVI3/sradl2WC/kKw9jSzVtpFcrkvnACD45KjQZ9Pzp8OEC29R04v9nos6yu/EvvKdxMxm3rov0eA/pcJLOsW+ioodA/Vn5HykSOhkLuh7x0l0EPI1tG/be+2JI2jMiPzvbk1hR39jl5rjkqxWbxwtZw0W9zY37rR2GXwmHdFbYQgDXf73MeE6/K6bbQa6sxvSftyf/W0nTDpVPWtLtdbWb2R1zLWbwslz3rhgdkWGJ/1HakIqunHW6O5eoiG/x345aqp9zo7HuJVG5+tsLfG0zQcxvRxgWSuiMZ5MLz6gdqMBga9wQPDL9WWNAoGBAO8qyXzb136/Elncs8knoIQgdMREoAw0YIZWvQB3m3swN2G9WE2oZJm/ObEAlLlIuu/ngPna/N6MYcePqt5jL4I2sMts5SGF2nP68Ta0TQ+Lldk8jklqnO5OEKNmoQklRWcIa9yBrgWn0lE6y8cYm5fMqXN8P2+/Y5HoKUPtGL5DAoGBAMfY+wpH4mAZ9OYu53BIOQdjqVw/YxKFxNky+YGfuAB+Jy+qoivGVgPnwq+YBsfVmpoB+HEl+Chyj0DHwFueXkJ+8Wcoo39/1DZ2zhnSIRNQfDNOfcfamuz2wsmlChoy+TfqHvUftCrvHOQ7Hu7+fUTBt/X9xoy/KEj9xKQVnA53AoGAMYhWBHLvdYOTBGNuJLn9R4AFTuS7lOuAFjJ+oEslO2UoAykY0bSPaTwucZciNiF2/dqfXp/ZASpn0dHSXI6EN16mTOs3pTK4pI6TSHYdA5wwI7aj7VaUO9KVJZJKxb8fWZBn7lo5NVileUdJDunsx4qOialw5e7oaz5+1V+UYUsCgYBAnEHtPPhPIZUvphJlFrR5Uxs6G7QoFN9jaTuJUN3oKuD4ZC4yANlmQdOLeZcXnFNzXxe3XRMx4He39dyWwkivLuNU+qqBWg593UMczfari+XboJDBwEc+PTkUgCsX9UrlbOe9UBarmsq4bvS9R8GwLQEQoo9Cibq4fnLIqcPeWQKBgAfVN/KUA2Fmh3Sjv8T1vdbkVo5Qsgbe9TeLbduBNqL3GunExhuLVg5tgsIkDDbSA8RuWoHrSqbIsYiRcIH9yPn5X13NM/uir0UrLu963opWpN0b9lftUbeByyY2gAUq6l9bGWb0RWSCXIPeB6F4HAa8vM2h5WadRv+SWQ2Gu/YR
aead8597-c7a3-4859-bc75-d515208a4f15	501abdae-a433-4e54-985a-a9fdf84bf3b8	priority	100
5f345e41-02c2-4b41-9b7f-b47331313b1c	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	saml-user-property-mapper
1d7155f9-9ca6-41fc-a765-cb76b3b8c08a	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-address-mapper
9e122a3c-3431-4884-9b18-423547da6279	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
90c6675e-0376-4caa-875c-219bdbf18413	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	saml-role-list-mapper
38a73e2c-6eb7-4d8a-b0b3-626020957ca0	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	saml-user-attribute-mapper
2b6b6126-f444-4a15-8cf7-6d7c78fbdabd	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
9d8a89f6-ac92-41a6-8e38-5d4c051fc485	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-full-name-mapper
6517d0f2-2cd2-4d71-bec5-51506735dec6	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
6f07f4f0-b8f8-4060-abe6-4131e1e3eda9	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
31fadd4c-1766-4410-9aa9-544e4bcd9ea0	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	saml-role-list-mapper
17aa4099-90af-4633-89c1-843fe82a0a46	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f882a04b-72dd-40ab-b89b-4974640e1f80	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	saml-user-property-mapper
504031ed-2e96-4ef3-bb12-f3d2decb47e9	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-address-mapper
6a99a55c-b0f5-48a3-8945-b0f0bcc26e47	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9683a3f2-dcad-4e36-8ae7-54efd876a4cb	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	saml-user-attribute-mapper
338f319d-400f-49e7-b69b-00c380ed51dd	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-full-name-mapper
7402f7f2-0970-44c8-aee0-915da7dfbbc4	aa39d65d-762c-4690-9154-219710f831f1	host-sending-registration-request-must-match	true
eb23fac7-5593-4dc5-b908-24110475639a	aa39d65d-762c-4690-9154-219710f831f1	client-uris-must-match	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.composite_role (composite, child_role) FROM stdin;
59adf05e-cef6-426b-8356-8ce8d5f88a54	9331ef2d-b3b6-46ef-98ed-36e9d828b3cb
59adf05e-cef6-426b-8356-8ce8d5f88a54	54aa25eb-bcec-4b53-97f8-d6181fef8663
59adf05e-cef6-426b-8356-8ce8d5f88a54	5e1645d2-9960-41ce-9dc7-c55eb76bafff
59adf05e-cef6-426b-8356-8ce8d5f88a54	cf29bf7e-e2d4-4a17-9851-5b49dc8bd7b0
59adf05e-cef6-426b-8356-8ce8d5f88a54	7752ee95-d00d-4bad-90b6-cea91220e3f3
59adf05e-cef6-426b-8356-8ce8d5f88a54	684eee5a-61b5-441f-8146-1b5f67807144
59adf05e-cef6-426b-8356-8ce8d5f88a54	ff31f777-a881-4f32-a1f0-14492f40d809
59adf05e-cef6-426b-8356-8ce8d5f88a54	42ea6ed4-c754-471a-88f2-988ab4f977f1
59adf05e-cef6-426b-8356-8ce8d5f88a54	fb009ddf-e273-45f3-bfe8-c74f339bbb5a
59adf05e-cef6-426b-8356-8ce8d5f88a54	c6b72ade-79c7-4402-8d91-fcfed6e96add
59adf05e-cef6-426b-8356-8ce8d5f88a54	18adf4d6-e41e-41c9-b582-bd6720554d8f
59adf05e-cef6-426b-8356-8ce8d5f88a54	0a1cb8c7-4430-47a9-af86-e9ad8c0e4246
59adf05e-cef6-426b-8356-8ce8d5f88a54	9cfa9708-674f-42fc-9c7d-6a9eb8f98873
59adf05e-cef6-426b-8356-8ce8d5f88a54	361f2fda-25f9-4fb3-814a-bc78049e70e6
59adf05e-cef6-426b-8356-8ce8d5f88a54	5c221f26-e9ef-4e91-92f2-46df36800ac2
59adf05e-cef6-426b-8356-8ce8d5f88a54	5bd4136b-b311-41b3-9b1a-35724567c5ab
59adf05e-cef6-426b-8356-8ce8d5f88a54	875e3248-0a77-44a2-99e6-e543ba1eeff7
59adf05e-cef6-426b-8356-8ce8d5f88a54	9f0818b0-4c75-4fc8-9944-ab23535649a3
7752ee95-d00d-4bad-90b6-cea91220e3f3	5bd4136b-b311-41b3-9b1a-35724567c5ab
cf29bf7e-e2d4-4a17-9851-5b49dc8bd7b0	5c221f26-e9ef-4e91-92f2-46df36800ac2
cf29bf7e-e2d4-4a17-9851-5b49dc8bd7b0	9f0818b0-4c75-4fc8-9944-ab23535649a3
e09e10aa-cc18-4d57-a6c1-6141c546281e	2bcd8b49-e9e7-4031-b2b1-a5cb27fe6ff6
e09e10aa-cc18-4d57-a6c1-6141c546281e	56b95d40-a993-4b87-8b27-e49dc611fefb
56b95d40-a993-4b87-8b27-e49dc611fefb	3902bc4e-39b6-43e5-b19a-8241d653e959
13b4299a-bee8-45ff-be9d-024fa8613258	43d1cb94-df10-4e3c-b86b-b384a39ee2c8
59adf05e-cef6-426b-8356-8ce8d5f88a54	fb1598ce-e235-4447-b58b-8aadea8a9804
e09e10aa-cc18-4d57-a6c1-6141c546281e	b0de270c-6595-4103-830d-f1ec025efa89
e09e10aa-cc18-4d57-a6c1-6141c546281e	efb2fd70-ac9e-4fcc-9089-3e8296d690d8
59adf05e-cef6-426b-8356-8ce8d5f88a54	ceb04091-d5fe-4459-9ccf-58e3ebe016ee
59adf05e-cef6-426b-8356-8ce8d5f88a54	b79d42ee-247a-4356-b7d3-a0bc9b64c7ae
59adf05e-cef6-426b-8356-8ce8d5f88a54	818cabf1-e388-4481-8d4d-e11077b05964
59adf05e-cef6-426b-8356-8ce8d5f88a54	9a234e5b-65be-4cb8-a9b9-88f48e23ccf5
59adf05e-cef6-426b-8356-8ce8d5f88a54	99e6721d-440b-454f-a40a-747617b229df
59adf05e-cef6-426b-8356-8ce8d5f88a54	60a59170-3577-4019-a916-00866a7b1fec
59adf05e-cef6-426b-8356-8ce8d5f88a54	b844a00f-eb06-4829-ba5d-2bcd63cb916d
59adf05e-cef6-426b-8356-8ce8d5f88a54	8b6edea6-c4c5-402e-8cde-2e2ee7b33b7b
59adf05e-cef6-426b-8356-8ce8d5f88a54	717df245-2b92-4bd9-84cf-0afba0159c16
59adf05e-cef6-426b-8356-8ce8d5f88a54	361a9d0f-54e4-43cd-8bff-afb9e5bf760d
59adf05e-cef6-426b-8356-8ce8d5f88a54	13863c49-b985-464e-b84d-5c8789680b8e
59adf05e-cef6-426b-8356-8ce8d5f88a54	8a3957c7-426a-4cde-b90f-e545f4af3ee0
59adf05e-cef6-426b-8356-8ce8d5f88a54	7bce38da-66c1-4688-9271-e4139df05986
59adf05e-cef6-426b-8356-8ce8d5f88a54	b0de6771-fbae-4d4e-bfad-c01e6090651f
59adf05e-cef6-426b-8356-8ce8d5f88a54	cd63c65c-204c-4a7b-8cb1-987602caee13
59adf05e-cef6-426b-8356-8ce8d5f88a54	8293c647-0b78-44cd-a157-bc2956bc3349
59adf05e-cef6-426b-8356-8ce8d5f88a54	bfe1f19e-592d-448e-8dd4-5b7e87065164
818cabf1-e388-4481-8d4d-e11077b05964	b0de6771-fbae-4d4e-bfad-c01e6090651f
818cabf1-e388-4481-8d4d-e11077b05964	bfe1f19e-592d-448e-8dd4-5b7e87065164
9a234e5b-65be-4cb8-a9b9-88f48e23ccf5	cd63c65c-204c-4a7b-8cb1-987602caee13
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
59adf05e-cef6-426b-8356-8ce8d5f88a54	4495760f-b97d-4f4f-a733-7c9cf23cdddb
\.


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.contact (id, created_date, last_modified_date, blocked_by, contact_user_id, user_id) FROM stdin;
1	2026-01-14 08:32:44.965955+00	2026-01-14 08:32:44.965955+00	\N	121	131
\.


--
-- Data for Name: contact_request; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.contact_request (id, created_date, last_modified_date, receiver_user_id, request_user_id, status, public_id) FROM stdin;
1	2026-01-14 01:06:03.619861+00	2026-01-14 01:06:03.619861+00	138	121	PENDING	c71233a2-b7f5-4b93-a6f9-5d459b1966d7
2	2026-01-14 02:41:56.1466+00	2026-01-14 02:41:56.1466+00	123	138	PENDING	106ac84b-d6a9-4b7b-b732-0503e4f5d1e8
3	2026-01-14 08:32:21.546028+00	2026-01-14 08:32:44.979142+00	131	121	ACCEPTED	ae672bb9-4251-49c9-af7d-68bf5764f96f
\.


--
-- Data for Name: conversation; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.conversation (id, created_date, last_modified_date, creator_id, deleted, last_message_id, public_id, conversation_type, last_message_sent) FROM stdin;
\.


--
-- Data for Name: conversation_participant; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.conversation_participant (id, created_date, last_modified_date, last_read_message_id, role, conversation_id, user_id) FROM stdin;
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
e1fea50f-b41e-48c1-b009-724ca883d529	\N	password	1f79fdf8-2aaa-4963-b2a7-997434938f73	1768286285232	\N	{"value":"v5AC6HOKT9ekn7ooFx2Lg8Fad9+W7I3rf2+2r+LqqXU=","salt":"BkP3cS2j6/KwNEV1WWO9Ew==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
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
6bee13ee-c458-477d-a219-83a4deb1977a	b2380bdf-aa21-4971-b6a7-b54c82fdfdb0	f
6bee13ee-c458-477d-a219-83a4deb1977a	92bb12df-b3cf-4b58-a22a-58927f4ef055	t
6bee13ee-c458-477d-a219-83a4deb1977a	a8e5bb25-05b4-431e-b8a1-2416e612fa43	t
6bee13ee-c458-477d-a219-83a4deb1977a	2f80d67d-f8eb-44f3-afd8-2cdb8c002321	t
6bee13ee-c458-477d-a219-83a4deb1977a	4f73b510-48b8-4e1c-8e79-e1c02fce31c5	t
6bee13ee-c458-477d-a219-83a4deb1977a	4ed58e53-b7d1-4480-80e4-b2958fd448c1	f
6bee13ee-c458-477d-a219-83a4deb1977a	87fec71d-7177-489f-af5e-a8514ea517d1	f
6bee13ee-c458-477d-a219-83a4deb1977a	2daa6801-b039-4d7e-9e9d-fb6892ebf37d	t
6bee13ee-c458-477d-a219-83a4deb1977a	b46fa1d5-bd31-4375-8ac1-880a313bbe47	t
6bee13ee-c458-477d-a219-83a4deb1977a	196cae10-a248-472e-bb43-c27def2cf829	f
6bee13ee-c458-477d-a219-83a4deb1977a	117c9415-9629-4d47-9d8b-ac41aa986328	t
6bee13ee-c458-477d-a219-83a4deb1977a	ffd5390e-5248-41f8-bf25-d266258ade63	t
6bee13ee-c458-477d-a219-83a4deb1977a	e0928e6c-b0a1-4229-9738-587dfe498bbb	f
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
e09e10aa-cc18-4d57-a6c1-6141c546281e	6bee13ee-c458-477d-a219-83a4deb1977a	f	${role_default-roles}	default-roles-master	6bee13ee-c458-477d-a219-83a4deb1977a	\N	\N
59adf05e-cef6-426b-8356-8ce8d5f88a54	6bee13ee-c458-477d-a219-83a4deb1977a	f	${role_admin}	admin	6bee13ee-c458-477d-a219-83a4deb1977a	\N	\N
9331ef2d-b3b6-46ef-98ed-36e9d828b3cb	6bee13ee-c458-477d-a219-83a4deb1977a	f	${role_create-realm}	create-realm	6bee13ee-c458-477d-a219-83a4deb1977a	\N	\N
54aa25eb-bcec-4b53-97f8-d6181fef8663	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_create-client}	create-client	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
5e1645d2-9960-41ce-9dc7-c55eb76bafff	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_view-realm}	view-realm	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
cf29bf7e-e2d4-4a17-9851-5b49dc8bd7b0	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_view-users}	view-users	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
7752ee95-d00d-4bad-90b6-cea91220e3f3	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_view-clients}	view-clients	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
684eee5a-61b5-441f-8146-1b5f67807144	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_view-events}	view-events	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
ff31f777-a881-4f32-a1f0-14492f40d809	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_view-identity-providers}	view-identity-providers	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
42ea6ed4-c754-471a-88f2-988ab4f977f1	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_view-authorization}	view-authorization	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
fb009ddf-e273-45f3-bfe8-c74f339bbb5a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_manage-realm}	manage-realm	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
c6b72ade-79c7-4402-8d91-fcfed6e96add	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_manage-users}	manage-users	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
18adf4d6-e41e-41c9-b582-bd6720554d8f	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_manage-clients}	manage-clients	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
0a1cb8c7-4430-47a9-af86-e9ad8c0e4246	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_manage-events}	manage-events	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
9cfa9708-674f-42fc-9c7d-6a9eb8f98873	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_manage-identity-providers}	manage-identity-providers	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
361f2fda-25f9-4fb3-814a-bc78049e70e6	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_manage-authorization}	manage-authorization	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
5c221f26-e9ef-4e91-92f2-46df36800ac2	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_query-users}	query-users	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
5bd4136b-b311-41b3-9b1a-35724567c5ab	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_query-clients}	query-clients	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
875e3248-0a77-44a2-99e6-e543ba1eeff7	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_query-realms}	query-realms	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
9f0818b0-4c75-4fc8-9944-ab23535649a3	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_query-groups}	query-groups	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
2bcd8b49-e9e7-4031-b2b1-a5cb27fe6ff6	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	t	${role_view-profile}	view-profile	6bee13ee-c458-477d-a219-83a4deb1977a	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	\N
56b95d40-a993-4b87-8b27-e49dc611fefb	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	t	${role_manage-account}	manage-account	6bee13ee-c458-477d-a219-83a4deb1977a	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	\N
3902bc4e-39b6-43e5-b19a-8241d653e959	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	t	${role_manage-account-links}	manage-account-links	6bee13ee-c458-477d-a219-83a4deb1977a	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	\N
7d135b06-f7a2-47f3-b746-b8de960dbe43	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	t	${role_view-applications}	view-applications	6bee13ee-c458-477d-a219-83a4deb1977a	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	\N
43d1cb94-df10-4e3c-b86b-b384a39ee2c8	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	t	${role_view-consent}	view-consent	6bee13ee-c458-477d-a219-83a4deb1977a	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	\N
13b4299a-bee8-45ff-be9d-024fa8613258	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	t	${role_manage-consent}	manage-consent	6bee13ee-c458-477d-a219-83a4deb1977a	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	\N
7bfa5c31-e20f-4afd-93bf-c7cdba81d1ab	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	t	${role_view-groups}	view-groups	6bee13ee-c458-477d-a219-83a4deb1977a	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	\N
7652102e-5036-4a53-bf48-ab636b486999	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	t	${role_delete-account}	delete-account	6bee13ee-c458-477d-a219-83a4deb1977a	bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	\N
abd18789-209c-407d-ac8a-619f1ce7f0a7	4a4c2929-7f3c-4971-a025-52e23c09e357	t	${role_read-token}	read-token	6bee13ee-c458-477d-a219-83a4deb1977a	4a4c2929-7f3c-4971-a025-52e23c09e357	\N
fb1598ce-e235-4447-b58b-8aadea8a9804	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	t	${role_impersonation}	impersonation	6bee13ee-c458-477d-a219-83a4deb1977a	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	\N
b0de270c-6595-4103-830d-f1ec025efa89	6bee13ee-c458-477d-a219-83a4deb1977a	f	${role_offline-access}	offline_access	6bee13ee-c458-477d-a219-83a4deb1977a	\N	\N
efb2fd70-ac9e-4fcc-9089-3e8296d690d8	6bee13ee-c458-477d-a219-83a4deb1977a	f	${role_uma_authorization}	uma_authorization	6bee13ee-c458-477d-a219-83a4deb1977a	\N	\N
929392ee-0474-4ed0-a64e-9b0132025c91	83b6664d-539e-4bed-a376-685d50e40b98	f	${role_default-roles}	default-roles-loci-realm	83b6664d-539e-4bed-a376-685d50e40b98	\N	\N
ceb04091-d5fe-4459-9ccf-58e3ebe016ee	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_create-client}	create-client	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
b79d42ee-247a-4356-b7d3-a0bc9b64c7ae	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_view-realm}	view-realm	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
818cabf1-e388-4481-8d4d-e11077b05964	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_view-users}	view-users	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
9a234e5b-65be-4cb8-a9b9-88f48e23ccf5	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_view-clients}	view-clients	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
99e6721d-440b-454f-a40a-747617b229df	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_view-events}	view-events	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
60a59170-3577-4019-a916-00866a7b1fec	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_view-identity-providers}	view-identity-providers	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
b844a00f-eb06-4829-ba5d-2bcd63cb916d	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_view-authorization}	view-authorization	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
8b6edea6-c4c5-402e-8cde-2e2ee7b33b7b	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_manage-realm}	manage-realm	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
717df245-2b92-4bd9-84cf-0afba0159c16	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_manage-users}	manage-users	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
361a9d0f-54e4-43cd-8bff-afb9e5bf760d	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_manage-clients}	manage-clients	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
13863c49-b985-464e-b84d-5c8789680b8e	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_manage-events}	manage-events	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
8a3957c7-426a-4cde-b90f-e545f4af3ee0	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_manage-identity-providers}	manage-identity-providers	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
7bce38da-66c1-4688-9271-e4139df05986	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_manage-authorization}	manage-authorization	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
b0de6771-fbae-4d4e-bfad-c01e6090651f	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_query-users}	query-users	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
cd63c65c-204c-4a7b-8cb1-987602caee13	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_query-clients}	query-clients	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
8293c647-0b78-44cd-a157-bc2956bc3349	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_query-realms}	query-realms	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
bfe1f19e-592d-448e-8dd4-5b7e87065164	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_query-groups}	query-groups	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
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
4495760f-b97d-4f4f-a733-7c9cf23cdddb	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	t	${role_impersonation}	impersonation	6bee13ee-c458-477d-a219-83a4deb1977a	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	\N
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
b70db1c3-81ad-404e-a48c-66e0bc27d068	e85deedd-b2fb-47d3-acef-508423a77f22	0	1768377987	{"authMethod":"openid-connect","notes":{"clientId":"e85deedd-b2fb-47d3-acef-508423a77f22","userSessionStartedAt":"1768377987","iss":"http://127.0.0.1:9090/realms/loci-realm","startedAt":"1768377987","level-of-authentication":"-1"}}	local	local	0
af30711d-7954-4cb8-9888-ebbf31ccb299	e85deedd-b2fb-47d3-acef-508423a77f22	0	1768378087	{"authMethod":"openid-connect","notes":{"clientId":"e85deedd-b2fb-47d3-acef-508423a77f22","userSessionStartedAt":"1768378087","iss":"http://127.0.0.1:9090/realms/loci-realm","startedAt":"1768378087","level-of-authentication":"-1"}}	local	local	0
54d7dd8f-ab1f-4cc2-b9d2-39fd5683a8d3	e85deedd-b2fb-47d3-acef-508423a77f22	0	1768378377	{"authMethod":"openid-connect","notes":{"clientId":"e85deedd-b2fb-47d3-acef-508423a77f22","userSessionStartedAt":"1768378377","iss":"http://127.0.0.1:9090/realms/loci-realm","startedAt":"1768378377","level-of-authentication":"-1"}}	local	local	0
46ce8274-3ed5-4299-81e4-ce31533d3e10	e85deedd-b2fb-47d3-acef-508423a77f22	0	1768378546	{"authMethod":"openid-connect","notes":{"clientId":"e85deedd-b2fb-47d3-acef-508423a77f22","userSessionStartedAt":"1768378546","iss":"http://127.0.0.1:9090/realms/loci-realm","startedAt":"1768378546","level-of-authentication":"-1"}}	local	local	0
b1738abf-192b-4ff3-a0b7-7b90c2c06cbd	e85deedd-b2fb-47d3-acef-508423a77f22	0	1768378969	{"authMethod":"openid-connect","notes":{"clientId":"e85deedd-b2fb-47d3-acef-508423a77f22","userSessionStartedAt":"1768378969","iss":"http://localhost:9090/realms/loci-realm","startedAt":"1768378969","level-of-authentication":"-1"}}	local	local	0
79227f67-6d5c-4eaf-b3e1-358b3b8174f9	e85deedd-b2fb-47d3-acef-508423a77f22	0	1768379029	{"authMethod":"openid-connect","notes":{"clientId":"e85deedd-b2fb-47d3-acef-508423a77f22","userSessionStartedAt":"1768379029","iss":"http://localhost:9090/realms/loci-realm","startedAt":"1768379029","level-of-authentication":"-1"}}	local	local	0
d973c717-ed1f-454f-8d48-7a6730235824	e85deedd-b2fb-47d3-acef-508423a77f22	0	1768379494	{"authMethod":"openid-connect","notes":{"clientId":"e85deedd-b2fb-47d3-acef-508423a77f22","userSessionStartedAt":"1768379494","iss":"http://localhost:9090/realms/loci-realm","startedAt":"1768379494","level-of-authentication":"-1"}}	local	local	0
25a72ee2-5bac-467d-a65d-ce03e3f0b993	1946f9ea-72fe-4697-bf83-3dec92a8f8ee	0	1768379522	{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/","notes":{"clientId":"1946f9ea-72fe-4697-bf83-3dec92a8f8ee","iss":"http://localhost:9090/realms/loci-realm","startedAt":"1768379521","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ed994d7f-03c5-4e65-b00b-d48a322e588f","response_mode":"fragment","scope":"openid","userSessionStartedAt":"1768379521","redirect_uri":"http://localhost:4200/","state":"23aa60c4-0fe8-42b7-aaa6-7defb2149621","code_challenge":"0QWcZOlqoU9TogCw17q9nGsXzBF6qQu2VaN4yenr92I"}}	local	local	1
c03fea3d-6be2-46a6-9a38-25a83a38a793	1946f9ea-72fe-4697-bf83-3dec92a8f8ee	0	1768379577	{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/user/6e52f7d5-e6cc-4684-9a3d-315fa0f4d88a","notes":{"clientId":"1946f9ea-72fe-4697-bf83-3dec92a8f8ee","iss":"http://localhost:9090/realms/loci-realm","startedAt":"1768379558","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"53389a95-6d66-41c1-b53b-f357d2b6a205","response_mode":"fragment","scope":"openid","userSessionStartedAt":"1768379558","redirect_uri":"http://localhost:4200/user/6e52f7d5-e6cc-4684-9a3d-315fa0f4d88a","state":"43d781c3-cfe0-4f98-86b0-71fcb6be8a04","code_challenge":"7goHam_pGpmwkvA4QB1ZAnjStSSySiHiA1xCSeOp5jg","SSO_AUTH":"true"}}	local	local	3
81b9dddc-f5cc-4b03-b003-92d197fd54aa	e85deedd-b2fb-47d3-acef-508423a77f22	0	1768379651	{"authMethod":"openid-connect","notes":{"clientId":"e85deedd-b2fb-47d3-acef-508423a77f22","userSessionStartedAt":"1768379651","iss":"http://localhost:9090/realms/loci-realm","startedAt":"1768379651","level-of-authentication":"-1"}}	local	local	0
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
b70db1c3-81ad-404e-a48c-66e0bc27d068	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768377987	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","authenticators-completed":"{\\"8327d414-0879-420f-bbc6-8c6b71688bcc\\":1768377987,\\"ba25ab36-8cbc-470a-a5b4-efa3bc0b107d\\":1768377987}"},"state":"LOGGED_IN"}	1768377987	\N	0
af30711d-7954-4cb8-9888-ebbf31ccb299	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768378087	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","authenticators-completed":"{\\"8327d414-0879-420f-bbc6-8c6b71688bcc\\":1768378086,\\"ba25ab36-8cbc-470a-a5b4-efa3bc0b107d\\":1768378087}"},"state":"LOGGED_IN"}	1768378087	\N	0
54d7dd8f-ab1f-4cc2-b9d2-39fd5683a8d3	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768378377	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","authenticators-completed":"{\\"8327d414-0879-420f-bbc6-8c6b71688bcc\\":1768378377,\\"ba25ab36-8cbc-470a-a5b4-efa3bc0b107d\\":1768378377}"},"state":"LOGGED_IN"}	1768378377	\N	0
46ce8274-3ed5-4299-81e4-ce31533d3e10	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768378546	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","authenticators-completed":"{\\"8327d414-0879-420f-bbc6-8c6b71688bcc\\":1768378546,\\"ba25ab36-8cbc-470a-a5b4-efa3bc0b107d\\":1768378546}"},"state":"LOGGED_IN"}	1768378546	\N	0
b1738abf-192b-4ff3-a0b7-7b90c2c06cbd	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768378969	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","authenticators-completed":"{\\"8327d414-0879-420f-bbc6-8c6b71688bcc\\":1768378969,\\"ba25ab36-8cbc-470a-a5b4-efa3bc0b107d\\":1768378969}"},"state":"LOGGED_IN"}	1768378969	\N	0
79227f67-6d5c-4eaf-b3e1-358b3b8174f9	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768379029	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","authenticators-completed":"{\\"8327d414-0879-420f-bbc6-8c6b71688bcc\\":1768379029,\\"ba25ab36-8cbc-470a-a5b4-efa3bc0b107d\\":1768379029}"},"state":"LOGGED_IN"}	1768379029	\N	0
d973c717-ed1f-454f-8d48-7a6730235824	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768379494	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","authenticators-completed":"{\\"8327d414-0879-420f-bbc6-8c6b71688bcc\\":1768379494,\\"ba25ab36-8cbc-470a-a5b4-efa3bc0b107d\\":1768379494}"},"state":"LOGGED_IN"}	1768379494	\N	0
25a72ee2-5bac-467d-a65d-ce03e3f0b993	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768379521	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xNDYuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1768379521","authenticators-completed":"{\\"e63c5312-4fda-408f-bc0a-d49c4d698efb\\":1768379521}"},"state":"LOGGED_IN"}	1768379522	\N	1
c03fea3d-6be2-46a6-9a38-25a83a38a793	8c2bd715-2950-4ad6-a43b-7d75874ed33d	83b6664d-539e-4bed-a376-685d50e40b98	1768379558	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xNDYuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1768379558","authenticators-completed":"{\\"e63c5312-4fda-408f-bc0a-d49c4d698efb\\":1768379558,\\"5f6ef5dc-4ecc-4cf3-bf3a-89c48049ac56\\":1768379576}"},"state":"LOGGED_IN"}	1768379577	\N	3
81b9dddc-f5cc-4b03-b003-92d197fd54aa	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1768379651	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJPdGhlciIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiT3RoZXIvVW5rbm93biIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","authenticators-completed":"{\\"8327d414-0879-420f-bbc6-8c6b71688bcc\\":1768379651,\\"ba25ab36-8cbc-470a-a5b4-efa3bc0b107d\\":1768379651}"},"state":"LOGGED_IN"}	1768379651	\N	0
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
bb3eeeb6-2398-4ad4-a1d8-bada96c6f7bc	audience resolve	openid-connect	oidc-audience-resolve-mapper	5c16c9aa-73f5-47ec-a926-c72d8c97b0df	\N
03d74634-3292-4d4b-8ff2-0f4c8c24b91f	locale	openid-connect	oidc-usermodel-attribute-mapper	cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	\N
d52b3f4b-0c7c-419c-9f59-dea0528f748e	role list	saml	saml-role-list-mapper	\N	92bb12df-b3cf-4b58-a22a-58927f4ef055
7603395e-8b3f-40c2-bc88-be291e543e61	organization	saml	saml-organization-membership-mapper	\N	a8e5bb25-05b4-431e-b8a1-2416e612fa43
7b5d22c8-85f0-44f9-a999-a6b6e97d8cb2	full name	openid-connect	oidc-full-name-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
f7e7f76c-c6c8-41ba-8378-0017e05fcef3	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
62774e65-42da-4d01-8af8-8df4a6985ac6	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
278f6778-1f4b-4862-90c7-86ebb3fcb73b	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
2c50c1f4-d1f6-4101-a1d8-1b267e3cd3f2	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
82ca80e4-ecc8-4b90-a3d1-b95db201a034	username	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
b3b0780b-2f8a-48ee-acb3-3c3bd38ab0ff	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
84353234-df7f-4060-a1c3-2e268e4b0c73	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
cad96e13-27cd-4fee-ac35-86ac7aa61e0a	website	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
68dfe53b-bde0-4731-a7d0-18a8d1fa528c	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
7973480f-60a2-43da-8739-9694340d2f35	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
509f282c-5781-4dd0-adb1-42763a1f4eff	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
5721e0f5-ef15-4794-9d3a-9dfc03c4d725	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
d4d0ae45-03a6-47ea-9d75-96acd4d613f3	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	2f80d67d-f8eb-44f3-afd8-2cdb8c002321
c4c5516f-608d-4c11-a63b-049955f65af8	email	openid-connect	oidc-usermodel-attribute-mapper	\N	4f73b510-48b8-4e1c-8e79-e1c02fce31c5
27b59ac1-b373-4d63-91de-4dadc397d6b8	email verified	openid-connect	oidc-usermodel-property-mapper	\N	4f73b510-48b8-4e1c-8e79-e1c02fce31c5
92492ea6-01e1-4816-b921-3018c53b15dd	address	openid-connect	oidc-address-mapper	\N	4ed58e53-b7d1-4480-80e4-b2958fd448c1
1c484293-024c-4d3c-b48d-e0650d4d3873	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	87fec71d-7177-489f-af5e-a8514ea517d1
fa08c629-1df6-4e83-b6ff-efed16eab17e	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	87fec71d-7177-489f-af5e-a8514ea517d1
855f8b75-8aa2-4d49-a244-4ead09b35af3	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	2daa6801-b039-4d7e-9e9d-fb6892ebf37d
7f0228dc-d663-4508-8282-e7e599e38583	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	2daa6801-b039-4d7e-9e9d-fb6892ebf37d
5ba8efb5-4a34-4f02-8edb-cce96dba0c3c	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	2daa6801-b039-4d7e-9e9d-fb6892ebf37d
088df99f-c126-42fe-9a8f-139afedcbe6b	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	b46fa1d5-bd31-4375-8ac1-880a313bbe47
7f2afd3c-4df3-4660-9123-20c4b0f6b761	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	196cae10-a248-472e-bb43-c27def2cf829
0045ff34-5820-4b7a-bce0-12579ab378e4	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	196cae10-a248-472e-bb43-c27def2cf829
2bbf4b09-277a-4073-a661-1e7cd6dadab1	acr loa level	openid-connect	oidc-acr-mapper	\N	117c9415-9629-4d47-9d8b-ac41aa986328
3588406e-63ff-4579-88e2-5b97b5afc35a	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	ffd5390e-5248-41f8-bf25-d266258ade63
52bf5e72-9c91-4d66-a9ef-569ebefe265e	sub	openid-connect	oidc-sub-mapper	\N	ffd5390e-5248-41f8-bf25-d266258ade63
46f6aa7c-9149-4353-90e3-47429ec7668f	organization	openid-connect	oidc-organization-membership-mapper	\N	e0928e6c-b0a1-4229-9738-587dfe498bbb
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
03d74634-3292-4d4b-8ff2-0f4c8c24b91f	true	introspection.token.claim
03d74634-3292-4d4b-8ff2-0f4c8c24b91f	true	userinfo.token.claim
03d74634-3292-4d4b-8ff2-0f4c8c24b91f	locale	user.attribute
03d74634-3292-4d4b-8ff2-0f4c8c24b91f	true	id.token.claim
03d74634-3292-4d4b-8ff2-0f4c8c24b91f	true	access.token.claim
03d74634-3292-4d4b-8ff2-0f4c8c24b91f	locale	claim.name
03d74634-3292-4d4b-8ff2-0f4c8c24b91f	String	jsonType.label
d52b3f4b-0c7c-419c-9f59-dea0528f748e	false	single
d52b3f4b-0c7c-419c-9f59-dea0528f748e	Basic	attribute.nameformat
d52b3f4b-0c7c-419c-9f59-dea0528f748e	Role	attribute.name
278f6778-1f4b-4862-90c7-86ebb3fcb73b	true	introspection.token.claim
278f6778-1f4b-4862-90c7-86ebb3fcb73b	true	userinfo.token.claim
278f6778-1f4b-4862-90c7-86ebb3fcb73b	middleName	user.attribute
278f6778-1f4b-4862-90c7-86ebb3fcb73b	true	id.token.claim
278f6778-1f4b-4862-90c7-86ebb3fcb73b	true	access.token.claim
278f6778-1f4b-4862-90c7-86ebb3fcb73b	middle_name	claim.name
278f6778-1f4b-4862-90c7-86ebb3fcb73b	String	jsonType.label
2c50c1f4-d1f6-4101-a1d8-1b267e3cd3f2	true	introspection.token.claim
2c50c1f4-d1f6-4101-a1d8-1b267e3cd3f2	true	userinfo.token.claim
2c50c1f4-d1f6-4101-a1d8-1b267e3cd3f2	nickname	user.attribute
2c50c1f4-d1f6-4101-a1d8-1b267e3cd3f2	true	id.token.claim
2c50c1f4-d1f6-4101-a1d8-1b267e3cd3f2	true	access.token.claim
2c50c1f4-d1f6-4101-a1d8-1b267e3cd3f2	nickname	claim.name
2c50c1f4-d1f6-4101-a1d8-1b267e3cd3f2	String	jsonType.label
509f282c-5781-4dd0-adb1-42763a1f4eff	true	introspection.token.claim
509f282c-5781-4dd0-adb1-42763a1f4eff	true	userinfo.token.claim
509f282c-5781-4dd0-adb1-42763a1f4eff	zoneinfo	user.attribute
509f282c-5781-4dd0-adb1-42763a1f4eff	true	id.token.claim
509f282c-5781-4dd0-adb1-42763a1f4eff	true	access.token.claim
509f282c-5781-4dd0-adb1-42763a1f4eff	zoneinfo	claim.name
509f282c-5781-4dd0-adb1-42763a1f4eff	String	jsonType.label
5721e0f5-ef15-4794-9d3a-9dfc03c4d725	true	introspection.token.claim
5721e0f5-ef15-4794-9d3a-9dfc03c4d725	true	userinfo.token.claim
5721e0f5-ef15-4794-9d3a-9dfc03c4d725	locale	user.attribute
5721e0f5-ef15-4794-9d3a-9dfc03c4d725	true	id.token.claim
5721e0f5-ef15-4794-9d3a-9dfc03c4d725	true	access.token.claim
5721e0f5-ef15-4794-9d3a-9dfc03c4d725	locale	claim.name
5721e0f5-ef15-4794-9d3a-9dfc03c4d725	String	jsonType.label
62774e65-42da-4d01-8af8-8df4a6985ac6	true	introspection.token.claim
62774e65-42da-4d01-8af8-8df4a6985ac6	true	userinfo.token.claim
62774e65-42da-4d01-8af8-8df4a6985ac6	firstName	user.attribute
62774e65-42da-4d01-8af8-8df4a6985ac6	true	id.token.claim
62774e65-42da-4d01-8af8-8df4a6985ac6	true	access.token.claim
62774e65-42da-4d01-8af8-8df4a6985ac6	given_name	claim.name
62774e65-42da-4d01-8af8-8df4a6985ac6	String	jsonType.label
68dfe53b-bde0-4731-a7d0-18a8d1fa528c	true	introspection.token.claim
68dfe53b-bde0-4731-a7d0-18a8d1fa528c	true	userinfo.token.claim
68dfe53b-bde0-4731-a7d0-18a8d1fa528c	gender	user.attribute
68dfe53b-bde0-4731-a7d0-18a8d1fa528c	true	id.token.claim
68dfe53b-bde0-4731-a7d0-18a8d1fa528c	true	access.token.claim
68dfe53b-bde0-4731-a7d0-18a8d1fa528c	gender	claim.name
68dfe53b-bde0-4731-a7d0-18a8d1fa528c	String	jsonType.label
7973480f-60a2-43da-8739-9694340d2f35	true	introspection.token.claim
7973480f-60a2-43da-8739-9694340d2f35	true	userinfo.token.claim
7973480f-60a2-43da-8739-9694340d2f35	birthdate	user.attribute
7973480f-60a2-43da-8739-9694340d2f35	true	id.token.claim
7973480f-60a2-43da-8739-9694340d2f35	true	access.token.claim
7973480f-60a2-43da-8739-9694340d2f35	birthdate	claim.name
7973480f-60a2-43da-8739-9694340d2f35	String	jsonType.label
7b5d22c8-85f0-44f9-a999-a6b6e97d8cb2	true	introspection.token.claim
7b5d22c8-85f0-44f9-a999-a6b6e97d8cb2	true	userinfo.token.claim
7b5d22c8-85f0-44f9-a999-a6b6e97d8cb2	true	id.token.claim
7b5d22c8-85f0-44f9-a999-a6b6e97d8cb2	true	access.token.claim
82ca80e4-ecc8-4b90-a3d1-b95db201a034	true	introspection.token.claim
82ca80e4-ecc8-4b90-a3d1-b95db201a034	true	userinfo.token.claim
82ca80e4-ecc8-4b90-a3d1-b95db201a034	username	user.attribute
82ca80e4-ecc8-4b90-a3d1-b95db201a034	true	id.token.claim
82ca80e4-ecc8-4b90-a3d1-b95db201a034	true	access.token.claim
82ca80e4-ecc8-4b90-a3d1-b95db201a034	preferred_username	claim.name
82ca80e4-ecc8-4b90-a3d1-b95db201a034	String	jsonType.label
84353234-df7f-4060-a1c3-2e268e4b0c73	true	introspection.token.claim
84353234-df7f-4060-a1c3-2e268e4b0c73	true	userinfo.token.claim
84353234-df7f-4060-a1c3-2e268e4b0c73	picture	user.attribute
84353234-df7f-4060-a1c3-2e268e4b0c73	true	id.token.claim
84353234-df7f-4060-a1c3-2e268e4b0c73	true	access.token.claim
84353234-df7f-4060-a1c3-2e268e4b0c73	picture	claim.name
84353234-df7f-4060-a1c3-2e268e4b0c73	String	jsonType.label
b3b0780b-2f8a-48ee-acb3-3c3bd38ab0ff	true	introspection.token.claim
b3b0780b-2f8a-48ee-acb3-3c3bd38ab0ff	true	userinfo.token.claim
b3b0780b-2f8a-48ee-acb3-3c3bd38ab0ff	profile	user.attribute
b3b0780b-2f8a-48ee-acb3-3c3bd38ab0ff	true	id.token.claim
b3b0780b-2f8a-48ee-acb3-3c3bd38ab0ff	true	access.token.claim
b3b0780b-2f8a-48ee-acb3-3c3bd38ab0ff	profile	claim.name
b3b0780b-2f8a-48ee-acb3-3c3bd38ab0ff	String	jsonType.label
cad96e13-27cd-4fee-ac35-86ac7aa61e0a	true	introspection.token.claim
cad96e13-27cd-4fee-ac35-86ac7aa61e0a	true	userinfo.token.claim
cad96e13-27cd-4fee-ac35-86ac7aa61e0a	website	user.attribute
cad96e13-27cd-4fee-ac35-86ac7aa61e0a	true	id.token.claim
cad96e13-27cd-4fee-ac35-86ac7aa61e0a	true	access.token.claim
cad96e13-27cd-4fee-ac35-86ac7aa61e0a	website	claim.name
cad96e13-27cd-4fee-ac35-86ac7aa61e0a	String	jsonType.label
d4d0ae45-03a6-47ea-9d75-96acd4d613f3	true	introspection.token.claim
d4d0ae45-03a6-47ea-9d75-96acd4d613f3	true	userinfo.token.claim
d4d0ae45-03a6-47ea-9d75-96acd4d613f3	updatedAt	user.attribute
d4d0ae45-03a6-47ea-9d75-96acd4d613f3	true	id.token.claim
d4d0ae45-03a6-47ea-9d75-96acd4d613f3	true	access.token.claim
d4d0ae45-03a6-47ea-9d75-96acd4d613f3	updated_at	claim.name
d4d0ae45-03a6-47ea-9d75-96acd4d613f3	long	jsonType.label
f7e7f76c-c6c8-41ba-8378-0017e05fcef3	true	introspection.token.claim
f7e7f76c-c6c8-41ba-8378-0017e05fcef3	true	userinfo.token.claim
f7e7f76c-c6c8-41ba-8378-0017e05fcef3	lastName	user.attribute
f7e7f76c-c6c8-41ba-8378-0017e05fcef3	true	id.token.claim
f7e7f76c-c6c8-41ba-8378-0017e05fcef3	true	access.token.claim
f7e7f76c-c6c8-41ba-8378-0017e05fcef3	family_name	claim.name
f7e7f76c-c6c8-41ba-8378-0017e05fcef3	String	jsonType.label
27b59ac1-b373-4d63-91de-4dadc397d6b8	true	introspection.token.claim
27b59ac1-b373-4d63-91de-4dadc397d6b8	true	userinfo.token.claim
27b59ac1-b373-4d63-91de-4dadc397d6b8	emailVerified	user.attribute
27b59ac1-b373-4d63-91de-4dadc397d6b8	true	id.token.claim
27b59ac1-b373-4d63-91de-4dadc397d6b8	true	access.token.claim
27b59ac1-b373-4d63-91de-4dadc397d6b8	email_verified	claim.name
27b59ac1-b373-4d63-91de-4dadc397d6b8	boolean	jsonType.label
c4c5516f-608d-4c11-a63b-049955f65af8	true	introspection.token.claim
c4c5516f-608d-4c11-a63b-049955f65af8	true	userinfo.token.claim
c4c5516f-608d-4c11-a63b-049955f65af8	email	user.attribute
c4c5516f-608d-4c11-a63b-049955f65af8	true	id.token.claim
c4c5516f-608d-4c11-a63b-049955f65af8	true	access.token.claim
c4c5516f-608d-4c11-a63b-049955f65af8	email	claim.name
c4c5516f-608d-4c11-a63b-049955f65af8	String	jsonType.label
92492ea6-01e1-4816-b921-3018c53b15dd	formatted	user.attribute.formatted
92492ea6-01e1-4816-b921-3018c53b15dd	country	user.attribute.country
92492ea6-01e1-4816-b921-3018c53b15dd	true	introspection.token.claim
92492ea6-01e1-4816-b921-3018c53b15dd	postal_code	user.attribute.postal_code
92492ea6-01e1-4816-b921-3018c53b15dd	true	userinfo.token.claim
92492ea6-01e1-4816-b921-3018c53b15dd	street	user.attribute.street
92492ea6-01e1-4816-b921-3018c53b15dd	true	id.token.claim
92492ea6-01e1-4816-b921-3018c53b15dd	region	user.attribute.region
92492ea6-01e1-4816-b921-3018c53b15dd	true	access.token.claim
92492ea6-01e1-4816-b921-3018c53b15dd	locality	user.attribute.locality
1c484293-024c-4d3c-b48d-e0650d4d3873	true	introspection.token.claim
1c484293-024c-4d3c-b48d-e0650d4d3873	true	userinfo.token.claim
1c484293-024c-4d3c-b48d-e0650d4d3873	phoneNumber	user.attribute
1c484293-024c-4d3c-b48d-e0650d4d3873	true	id.token.claim
1c484293-024c-4d3c-b48d-e0650d4d3873	true	access.token.claim
1c484293-024c-4d3c-b48d-e0650d4d3873	phone_number	claim.name
1c484293-024c-4d3c-b48d-e0650d4d3873	String	jsonType.label
fa08c629-1df6-4e83-b6ff-efed16eab17e	true	introspection.token.claim
fa08c629-1df6-4e83-b6ff-efed16eab17e	true	userinfo.token.claim
fa08c629-1df6-4e83-b6ff-efed16eab17e	phoneNumberVerified	user.attribute
fa08c629-1df6-4e83-b6ff-efed16eab17e	true	id.token.claim
fa08c629-1df6-4e83-b6ff-efed16eab17e	true	access.token.claim
fa08c629-1df6-4e83-b6ff-efed16eab17e	phone_number_verified	claim.name
fa08c629-1df6-4e83-b6ff-efed16eab17e	boolean	jsonType.label
5ba8efb5-4a34-4f02-8edb-cce96dba0c3c	true	introspection.token.claim
5ba8efb5-4a34-4f02-8edb-cce96dba0c3c	true	access.token.claim
7f0228dc-d663-4508-8282-e7e599e38583	true	introspection.token.claim
7f0228dc-d663-4508-8282-e7e599e38583	true	multivalued
7f0228dc-d663-4508-8282-e7e599e38583	foo	user.attribute
7f0228dc-d663-4508-8282-e7e599e38583	true	access.token.claim
7f0228dc-d663-4508-8282-e7e599e38583	resource_access.${client_id}.roles	claim.name
7f0228dc-d663-4508-8282-e7e599e38583	String	jsonType.label
855f8b75-8aa2-4d49-a244-4ead09b35af3	true	introspection.token.claim
855f8b75-8aa2-4d49-a244-4ead09b35af3	true	multivalued
855f8b75-8aa2-4d49-a244-4ead09b35af3	foo	user.attribute
855f8b75-8aa2-4d49-a244-4ead09b35af3	true	access.token.claim
855f8b75-8aa2-4d49-a244-4ead09b35af3	realm_access.roles	claim.name
855f8b75-8aa2-4d49-a244-4ead09b35af3	String	jsonType.label
088df99f-c126-42fe-9a8f-139afedcbe6b	true	introspection.token.claim
088df99f-c126-42fe-9a8f-139afedcbe6b	true	access.token.claim
0045ff34-5820-4b7a-bce0-12579ab378e4	true	introspection.token.claim
0045ff34-5820-4b7a-bce0-12579ab378e4	true	multivalued
0045ff34-5820-4b7a-bce0-12579ab378e4	foo	user.attribute
0045ff34-5820-4b7a-bce0-12579ab378e4	true	id.token.claim
0045ff34-5820-4b7a-bce0-12579ab378e4	true	access.token.claim
0045ff34-5820-4b7a-bce0-12579ab378e4	groups	claim.name
0045ff34-5820-4b7a-bce0-12579ab378e4	String	jsonType.label
7f2afd3c-4df3-4660-9123-20c4b0f6b761	true	introspection.token.claim
7f2afd3c-4df3-4660-9123-20c4b0f6b761	true	userinfo.token.claim
7f2afd3c-4df3-4660-9123-20c4b0f6b761	username	user.attribute
7f2afd3c-4df3-4660-9123-20c4b0f6b761	true	id.token.claim
7f2afd3c-4df3-4660-9123-20c4b0f6b761	true	access.token.claim
7f2afd3c-4df3-4660-9123-20c4b0f6b761	upn	claim.name
7f2afd3c-4df3-4660-9123-20c4b0f6b761	String	jsonType.label
2bbf4b09-277a-4073-a661-1e7cd6dadab1	true	introspection.token.claim
2bbf4b09-277a-4073-a661-1e7cd6dadab1	true	id.token.claim
2bbf4b09-277a-4073-a661-1e7cd6dadab1	true	access.token.claim
3588406e-63ff-4579-88e2-5b97b5afc35a	AUTH_TIME	user.session.note
3588406e-63ff-4579-88e2-5b97b5afc35a	true	introspection.token.claim
3588406e-63ff-4579-88e2-5b97b5afc35a	true	id.token.claim
3588406e-63ff-4579-88e2-5b97b5afc35a	true	access.token.claim
3588406e-63ff-4579-88e2-5b97b5afc35a	auth_time	claim.name
3588406e-63ff-4579-88e2-5b97b5afc35a	long	jsonType.label
52bf5e72-9c91-4d66-a9ef-569ebefe265e	true	introspection.token.claim
52bf5e72-9c91-4d66-a9ef-569ebefe265e	true	access.token.claim
46f6aa7c-9149-4353-90e3-47429ec7668f	true	introspection.token.claim
46f6aa7c-9149-4353-90e3-47429ec7668f	true	multivalued
46f6aa7c-9149-4353-90e3-47429ec7668f	true	id.token.claim
46f6aa7c-9149-4353-90e3-47429ec7668f	true	access.token.claim
46f6aa7c-9149-4353-90e3-47429ec7668f	organization	claim.name
46f6aa7c-9149-4353-90e3-47429ec7668f	String	jsonType.label
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
6bee13ee-c458-477d-a219-83a4deb1977a	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	a3597a64-7ed1-4de5-ac8a-ea91b7261f36	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	1d2f4bba-7f25-49b8-b705-2c3962d4f881	0545e99a-acf8-4617-b0fd-df56c0318ea6	7dfcd6a2-2ab6-475b-8150-674ded235a29	6dce498b-9d8a-47d3-938d-f32a83702206	71de4015-079f-4aef-94a4-3fe3675468a9	2592000	f	900	t	f	0799a6a7-c965-4527-8f36-416fbd05df4b	0	f	0	0	e09e10aa-cc18-4d57-a6c1-6141c546281e
83b6664d-539e-4bed-a376-685d50e40b98	60	300	300	\N	\N	\N	t	f	0	\N	loci-realm	0	\N	t	t	t	f	EXTERNAL	1800	36000	f	f	d1ee2cd9-7c24-40ea-9702-fa9ca59d306a	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	801e570d-bc15-45e3-9f8e-afe9f8f28dec	8c356fe3-6843-440d-ac93-b4cc6352781f	d7b8234b-3d04-4263-ac07-79794e3fb8c0	2ec9ca75-4f99-43e9-816d-708c9a550838	05607ab5-8839-424c-b1e7-7f0ccad2063e	2592000	f	900	t	f	08caf47c-2dda-42d5-a33d-3df1271e703c	0	f	0	0	929392ee-0474-4ed0-a64e-9b0132025c91
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	6bee13ee-c458-477d-a219-83a4deb1977a
_browser_header.xContentTypeOptions	6bee13ee-c458-477d-a219-83a4deb1977a	nosniff
_browser_header.referrerPolicy	6bee13ee-c458-477d-a219-83a4deb1977a	no-referrer
_browser_header.xRobotsTag	6bee13ee-c458-477d-a219-83a4deb1977a	none
_browser_header.xFrameOptions	6bee13ee-c458-477d-a219-83a4deb1977a	SAMEORIGIN
_browser_header.contentSecurityPolicy	6bee13ee-c458-477d-a219-83a4deb1977a	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	6bee13ee-c458-477d-a219-83a4deb1977a	1; mode=block
_browser_header.strictTransportSecurity	6bee13ee-c458-477d-a219-83a4deb1977a	max-age=31536000; includeSubDomains
bruteForceProtected	6bee13ee-c458-477d-a219-83a4deb1977a	false
permanentLockout	6bee13ee-c458-477d-a219-83a4deb1977a	false
maxTemporaryLockouts	6bee13ee-c458-477d-a219-83a4deb1977a	0
maxFailureWaitSeconds	6bee13ee-c458-477d-a219-83a4deb1977a	900
minimumQuickLoginWaitSeconds	6bee13ee-c458-477d-a219-83a4deb1977a	60
waitIncrementSeconds	6bee13ee-c458-477d-a219-83a4deb1977a	60
quickLoginCheckMilliSeconds	6bee13ee-c458-477d-a219-83a4deb1977a	1000
maxDeltaTimeSeconds	6bee13ee-c458-477d-a219-83a4deb1977a	43200
failureFactor	6bee13ee-c458-477d-a219-83a4deb1977a	30
realmReusableOtpCode	6bee13ee-c458-477d-a219-83a4deb1977a	false
firstBrokerLoginFlowId	6bee13ee-c458-477d-a219-83a4deb1977a	4c055f4a-e753-4b55-8423-cf1ca8678f66
displayName	6bee13ee-c458-477d-a219-83a4deb1977a	Keycloak
displayNameHtml	6bee13ee-c458-477d-a219-83a4deb1977a	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	6bee13ee-c458-477d-a219-83a4deb1977a	RS256
offlineSessionMaxLifespanEnabled	6bee13ee-c458-477d-a219-83a4deb1977a	false
offlineSessionMaxLifespan	6bee13ee-c458-477d-a219-83a4deb1977a	5184000
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
6bee13ee-c458-477d-a219-83a4deb1977a	jboss-logging
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
password	password	t	t	6bee13ee-c458-477d-a219-83a4deb1977a
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
bb98ec6a-fb25-4fa7-b5d8-d6e61c8a2005	/realms/master/account/*
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	/realms/master/account/*
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	/admin/master/console/*
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
1f44b10b-ff65-4eb5-af59-e5598cd7c6cf	VERIFY_EMAIL	Verify Email	6bee13ee-c458-477d-a219-83a4deb1977a	t	f	VERIFY_EMAIL	50
572439ae-661c-43c5-9e58-3f9009029e41	UPDATE_PROFILE	Update Profile	6bee13ee-c458-477d-a219-83a4deb1977a	t	f	UPDATE_PROFILE	40
ddb78981-c10a-48d4-98fe-f0725eead491	CONFIGURE_TOTP	Configure OTP	6bee13ee-c458-477d-a219-83a4deb1977a	t	f	CONFIGURE_TOTP	10
fd5c3ae0-6236-4dcc-a47b-c2bfdb4ed9d6	UPDATE_PASSWORD	Update Password	6bee13ee-c458-477d-a219-83a4deb1977a	t	f	UPDATE_PASSWORD	30
5bf04abf-f3bf-441c-9018-ec27b7f3e290	TERMS_AND_CONDITIONS	Terms and Conditions	6bee13ee-c458-477d-a219-83a4deb1977a	f	f	TERMS_AND_CONDITIONS	20
14339c97-27e1-414e-8c8d-4f5cb30e8638	delete_account	Delete Account	6bee13ee-c458-477d-a219-83a4deb1977a	f	f	delete_account	60
9754e55c-2210-40c3-8cbd-d7ea96133ae9	delete_credential	Delete Credential	6bee13ee-c458-477d-a219-83a4deb1977a	t	f	delete_credential	100
d62c32f2-8ef4-48fb-8f3f-b026eba8f333	update_user_locale	Update User Locale	6bee13ee-c458-477d-a219-83a4deb1977a	t	f	update_user_locale	1000
b6af0845-5045-4cec-90f5-a5b287ddbe7b	webauthn-register	Webauthn Register	6bee13ee-c458-477d-a219-83a4deb1977a	t	f	webauthn-register	70
3218fb83-f171-44b6-a6a0-d7901620ff5d	webauthn-register-passwordless	Webauthn Register Passwordless	6bee13ee-c458-477d-a219-83a4deb1977a	t	f	webauthn-register-passwordless	80
80399655-56f6-4632-bfb8-8be507e572e8	VERIFY_PROFILE	Verify Profile	6bee13ee-c458-477d-a219-83a4deb1977a	t	f	VERIFY_PROFILE	90
16631868-2c0b-4e43-ac98-8d1b6b928def	CONFIGURE_TOTP	Configure OTP	83b6664d-539e-4bed-a376-685d50e40b98	t	f	CONFIGURE_TOTP	10
1d1f266c-4aa4-4064-a33e-3d2550123e16	TERMS_AND_CONDITIONS	Terms and Conditions	83b6664d-539e-4bed-a376-685d50e40b98	f	f	TERMS_AND_CONDITIONS	20
55c6f890-1cb8-4bed-8b7a-1092326dbdb2	UPDATE_PASSWORD	Update Password	83b6664d-539e-4bed-a376-685d50e40b98	t	f	UPDATE_PASSWORD	30
b2991b9a-c92d-4062-90e9-d89df6e59b99	UPDATE_PROFILE	Update Profile	83b6664d-539e-4bed-a376-685d50e40b98	t	f	UPDATE_PROFILE	40
300d26d9-3193-40b6-919a-9d0c050bc84c	VERIFY_EMAIL	Verify Email	83b6664d-539e-4bed-a376-685d50e40b98	t	f	VERIFY_EMAIL	50
0d6bbf23-12fb-4e28-ba9c-e38983aefe2a	delete_account	Delete Account	83b6664d-539e-4bed-a376-685d50e40b98	f	f	delete_account	60
1d21683e-bf0b-4387-8841-d15f9e941167	webauthn-register	Webauthn Register	83b6664d-539e-4bed-a376-685d50e40b98	t	f	webauthn-register	70
65cf004f-f16a-4f1b-b956-1eb873b9f3f9	webauthn-register-passwordless	Webauthn Register Passwordless	83b6664d-539e-4bed-a376-685d50e40b98	t	f	webauthn-register-passwordless	80
c0b629b7-c755-4a62-84da-dd6925cbb05a	VERIFY_PROFILE	Verify Profile	83b6664d-539e-4bed-a376-685d50e40b98	t	f	VERIFY_PROFILE	90
c3b9926b-8bfc-4a13-a34d-2cea527fa7b6	delete_credential	Delete Credential	83b6664d-539e-4bed-a376-685d50e40b98	t	f	delete_credential	100
9cc7dd98-daee-418d-b633-9cc7ebb7614d	update_user_locale	Update User Locale	83b6664d-539e-4bed-a376-685d50e40b98	t	f	update_user_locale	1000
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
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	56b95d40-a993-4b87-8b27-e49dc611fefb
5c16c9aa-73f5-47ec-a926-c72d8c97b0df	7bfa5c31-e20f-4afd-93bf-c7cdba81d1ab
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
is_temporary_admin	true	1f79fdf8-2aaa-4963-b2a7-997434938f73	db15ce90-3c1f-42c2-bc4f-5d361702d90a	\N	\N	\N
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
1f79fdf8-2aaa-4963-b2a7-997434938f73	\N	6a448ce9-04c0-4875-a1f0-d1cb971b39bb	f	t	\N	\N	\N	6bee13ee-c458-477d-a219-83a4deb1977a	admin	1768286285067	\N	0
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
e09e10aa-cc18-4d57-a6c1-6141c546281e	1f79fdf8-2aaa-4963-b2a7-997434938f73
59adf05e-cef6-426b-8356-8ce8d5f88a54	1f79fdf8-2aaa-4963-b2a7-997434938f73
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
cfb7ff9b-b18d-4b45-ba26-7568f6a52b87	+
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	*
d004af51-9d2e-47d3-9340-a3a411f42029
d004af51-9d2e-47d3-9340-a3a411f42029	http://localhost:8080/
ba4de397-daf8-404b-ad79-249e4d09a713	+
e85deedd-b2fb-47d3-acef-508423a77f22	http://localhost:8080
\.


--
-- Name: contact_request_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.contact_request_sequence', 3, true);


--
-- Name: contact_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.contact_sequence', 1, true);


--
-- Name: conversation_participant_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.conversation_participant_sequence', 1, false);


--
-- Name: conversation_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.conversation_sequence', 1, false);


--
-- Name: group_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.group_sequence', 1, false);


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

\unrestrict eUcA9Zy5dxBM4jyrSnXiGoWx2zTaK4yfNwcA8kzSjbpRRL63jq2wI7BOhrPgJIp

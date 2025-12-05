--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

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
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO admin;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
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
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO admin;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
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
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
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
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
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
    blocked_by bigint NOT NULL,
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
    request_user_id bigint NOT NULL
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
-- Name: conversation_participant; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.conversation_participant (
    id bigint NOT NULL,
    created_date timestamp(6) with time zone,
    last_modified_date timestamp(6) with time zone,
    joined_at timestamp(6) with time zone NOT NULL,
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
-- Name: conversations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.conversations (
    id bigint NOT NULL,
    created_date timestamp(6) with time zone,
    last_modified_date timestamp(6) with time zone,
    creator_id bigint NOT NULL,
    deleted boolean NOT NULL,
    group_name character varying(255),
    group_profile_picture character varying(500),
    last_message_id bigint,
    updated_at timestamp(6) with time zone
);


ALTER TABLE public.conversations OWNER TO admin;

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
    conversation_id bigint NOT NULL
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
    client_role boolean DEFAULT false NOT NULL,
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
    reply_to_message_id uuid,
    sent_at timestamp(6) with time zone,
    status character varying(20) NOT NULL,
    type character varying(20) NOT NULL,
    conversation_id bigint NOT NULL,
    sender_id bigint NOT NULL,
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
    user_id bigint NOT NULL
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
    id character varying(36) NOT NULL,
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
    resource_server_id character varying(36) NOT NULL,
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
    resource_server_id character varying(36) NOT NULL,
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
    resource_server_id character varying(36) NOT NULL,
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
    friend_request_setting smallint,
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
    gender character varying(255),
    image_url character varying(255),
    last_seen_setting character varying(255),
    lastname character varying(255),
    profile_picture character varying(255),
    username character varying(255) NOT NULL,
    CONSTRAINT user__friend_request_setting_check CHECK (((friend_request_setting >= 0) AND (friend_request_setting <= 2))),
    CONSTRAINT user__gender_check CHECK (((gender)::text = ANY ((ARRAY['MALE'::character varying, 'FEMALE'::character varying])::text[]))),
    CONSTRAINT user__last_seen_setting_check CHECK (((last_seen_setting)::text = ANY ((ARRAY['EVERYONE'::character varying, 'CONTACT_ONLY'::character varying, 'NOBODY'::character varying])::text[])))
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
    user_federation_mapper_id character varying(36) NOT NULL,
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
450fbbc6-4f00-44be-8158-9ff6957dd767	\N	auth-cookie	04091393-f3f9-4303-ba2b-e7530a9d7711	fcff186b-b4c8-429e-867b-3dcc940bcc54	2	10	f	\N	\N
f6f69bdd-16fc-4094-bdfe-f0b0b1697767	\N	auth-spnego	04091393-f3f9-4303-ba2b-e7530a9d7711	fcff186b-b4c8-429e-867b-3dcc940bcc54	3	20	f	\N	\N
652cb483-b71b-4623-9dff-f52b0af8a291	\N	identity-provider-redirector	04091393-f3f9-4303-ba2b-e7530a9d7711	fcff186b-b4c8-429e-867b-3dcc940bcc54	2	25	f	\N	\N
31ca19a0-e478-4fbb-9755-7ddbe425fcd9	\N	\N	04091393-f3f9-4303-ba2b-e7530a9d7711	fcff186b-b4c8-429e-867b-3dcc940bcc54	2	30	t	968ec1a2-7436-4341-9f80-4495f607cd2e	\N
f6bb70bb-e600-429b-a19f-718a66ba8048	\N	auth-username-password-form	04091393-f3f9-4303-ba2b-e7530a9d7711	968ec1a2-7436-4341-9f80-4495f607cd2e	0	10	f	\N	\N
774ee21a-82cf-4ac3-ac97-cbdf27315372	\N	\N	04091393-f3f9-4303-ba2b-e7530a9d7711	968ec1a2-7436-4341-9f80-4495f607cd2e	1	20	t	cdc251ab-876a-4d33-8a59-1e0bdf016310	\N
39653542-e112-4204-9669-e9f12234c849	\N	conditional-user-configured	04091393-f3f9-4303-ba2b-e7530a9d7711	cdc251ab-876a-4d33-8a59-1e0bdf016310	0	10	f	\N	\N
6e9f68c5-440e-43c0-a6f3-c70ea9f54e70	\N	auth-otp-form	04091393-f3f9-4303-ba2b-e7530a9d7711	cdc251ab-876a-4d33-8a59-1e0bdf016310	0	20	f	\N	\N
c4cb4b40-2c25-4df5-b46d-61949714a6b4	\N	direct-grant-validate-username	04091393-f3f9-4303-ba2b-e7530a9d7711	c9b028e0-a6a0-41a3-a45f-be303c9fcbe3	0	10	f	\N	\N
edd7e5a3-1fd3-4b9d-8038-6a04d8e485b9	\N	direct-grant-validate-password	04091393-f3f9-4303-ba2b-e7530a9d7711	c9b028e0-a6a0-41a3-a45f-be303c9fcbe3	0	20	f	\N	\N
ce8d88ec-a434-4a42-8abf-cf14775bc301	\N	\N	04091393-f3f9-4303-ba2b-e7530a9d7711	c9b028e0-a6a0-41a3-a45f-be303c9fcbe3	1	30	t	e01884d7-5bb5-4d3a-ac2c-8d78ec5fa82a	\N
0068953d-c614-46f7-8c9a-60d7a95142ee	\N	conditional-user-configured	04091393-f3f9-4303-ba2b-e7530a9d7711	e01884d7-5bb5-4d3a-ac2c-8d78ec5fa82a	0	10	f	\N	\N
36e8446c-dfc7-4fa0-b212-5e1ceb31984c	\N	direct-grant-validate-otp	04091393-f3f9-4303-ba2b-e7530a9d7711	e01884d7-5bb5-4d3a-ac2c-8d78ec5fa82a	0	20	f	\N	\N
2d7db6d1-7eb4-4175-bdb6-dc04c665730a	\N	registration-page-form	04091393-f3f9-4303-ba2b-e7530a9d7711	943be564-f760-4242-87e4-31bc14d5be41	0	10	t	f38c49f3-df83-4418-9f4d-465869eb0b1a	\N
195a974c-620e-4aaa-96c9-fc4449481114	\N	registration-user-creation	04091393-f3f9-4303-ba2b-e7530a9d7711	f38c49f3-df83-4418-9f4d-465869eb0b1a	0	20	f	\N	\N
6c2eee7e-a40a-4881-9649-351a70fb5783	\N	registration-password-action	04091393-f3f9-4303-ba2b-e7530a9d7711	f38c49f3-df83-4418-9f4d-465869eb0b1a	0	50	f	\N	\N
c7716a6e-abf2-4ae5-b2d2-4560671c8c2e	\N	registration-recaptcha-action	04091393-f3f9-4303-ba2b-e7530a9d7711	f38c49f3-df83-4418-9f4d-465869eb0b1a	3	60	f	\N	\N
13c26f4a-9c93-4d95-acfe-ea9cc80f8013	\N	registration-terms-and-conditions	04091393-f3f9-4303-ba2b-e7530a9d7711	f38c49f3-df83-4418-9f4d-465869eb0b1a	3	70	f	\N	\N
9f48815b-6314-4680-bbe1-46ec9b58e16d	\N	reset-credentials-choose-user	04091393-f3f9-4303-ba2b-e7530a9d7711	65610f20-65d0-4589-980e-0660936234ff	0	10	f	\N	\N
c85ab157-ca32-4893-8dd2-9230aaa247a4	\N	reset-credential-email	04091393-f3f9-4303-ba2b-e7530a9d7711	65610f20-65d0-4589-980e-0660936234ff	0	20	f	\N	\N
429c182e-953b-41c1-9b02-bbb1f7ce2910	\N	reset-password	04091393-f3f9-4303-ba2b-e7530a9d7711	65610f20-65d0-4589-980e-0660936234ff	0	30	f	\N	\N
cb289480-d86b-4e9b-a738-5d1d714fbbbc	\N	\N	04091393-f3f9-4303-ba2b-e7530a9d7711	65610f20-65d0-4589-980e-0660936234ff	1	40	t	062807ac-81e5-4078-b5b4-5c58b8f61f0b	\N
41d7c011-e488-43b7-a081-d0fea4bb4ff2	\N	conditional-user-configured	04091393-f3f9-4303-ba2b-e7530a9d7711	062807ac-81e5-4078-b5b4-5c58b8f61f0b	0	10	f	\N	\N
a975ea07-b115-46ea-a0fd-f4b31e9c722d	\N	reset-otp	04091393-f3f9-4303-ba2b-e7530a9d7711	062807ac-81e5-4078-b5b4-5c58b8f61f0b	0	20	f	\N	\N
0608770c-577a-4815-819c-f9e4238ff251	\N	client-secret	04091393-f3f9-4303-ba2b-e7530a9d7711	290141e8-96a6-43f5-b46b-d0b233daf717	2	10	f	\N	\N
68e98541-e21c-4ff4-8d46-aee02b6d4d26	\N	client-jwt	04091393-f3f9-4303-ba2b-e7530a9d7711	290141e8-96a6-43f5-b46b-d0b233daf717	2	20	f	\N	\N
98479694-b0a4-4c26-a5b3-261dd5c32846	\N	client-secret-jwt	04091393-f3f9-4303-ba2b-e7530a9d7711	290141e8-96a6-43f5-b46b-d0b233daf717	2	30	f	\N	\N
ae8b79b4-1b4f-4572-b63a-f78f05dfeeba	\N	client-x509	04091393-f3f9-4303-ba2b-e7530a9d7711	290141e8-96a6-43f5-b46b-d0b233daf717	2	40	f	\N	\N
7865edcd-696f-4e66-b151-a6097b03f2fe	\N	idp-review-profile	04091393-f3f9-4303-ba2b-e7530a9d7711	2d672118-c7c4-46cf-b4d7-0bfab7a28e22	0	10	f	\N	1196da19-23fa-409b-81a6-6d01957171f3
61f11af5-7bf4-43fd-a1c9-0b8a0e02889f	\N	\N	04091393-f3f9-4303-ba2b-e7530a9d7711	2d672118-c7c4-46cf-b4d7-0bfab7a28e22	0	20	t	bb2a8a59-cbae-4513-88e5-bf98b81799d1	\N
52c32666-1c74-4385-a8bd-b0547366309e	\N	idp-create-user-if-unique	04091393-f3f9-4303-ba2b-e7530a9d7711	bb2a8a59-cbae-4513-88e5-bf98b81799d1	2	10	f	\N	e884ea95-fff9-4cfe-a025-c3fa7690be6f
906e0995-1e0f-4da2-b66d-848ec611d267	\N	\N	04091393-f3f9-4303-ba2b-e7530a9d7711	bb2a8a59-cbae-4513-88e5-bf98b81799d1	2	20	t	692bbb35-ac7a-4753-98de-955e4bf550f8	\N
08bb1ab6-e838-4c00-99b0-595e779ce852	\N	idp-confirm-link	04091393-f3f9-4303-ba2b-e7530a9d7711	692bbb35-ac7a-4753-98de-955e4bf550f8	0	10	f	\N	\N
40177f95-b8c5-4baa-bfd3-9fa3b62ee7f9	\N	\N	04091393-f3f9-4303-ba2b-e7530a9d7711	692bbb35-ac7a-4753-98de-955e4bf550f8	0	20	t	a65a8e98-9b60-4895-85a9-613e551d7e32	\N
93355cf8-8e74-41f2-9ad4-8b9703ed027e	\N	idp-email-verification	04091393-f3f9-4303-ba2b-e7530a9d7711	a65a8e98-9b60-4895-85a9-613e551d7e32	2	10	f	\N	\N
470d5b25-799d-40fc-9bae-71774c6af4d3	\N	\N	04091393-f3f9-4303-ba2b-e7530a9d7711	a65a8e98-9b60-4895-85a9-613e551d7e32	2	20	t	518fb9e4-ff70-46e4-a2ff-aeb0de47e5df	\N
6ef93032-97f9-4d75-bcd0-52a40270a1e3	\N	idp-username-password-form	04091393-f3f9-4303-ba2b-e7530a9d7711	518fb9e4-ff70-46e4-a2ff-aeb0de47e5df	0	10	f	\N	\N
a7977892-2c1b-49cb-ba84-4312653a56f0	\N	\N	04091393-f3f9-4303-ba2b-e7530a9d7711	518fb9e4-ff70-46e4-a2ff-aeb0de47e5df	1	20	t	3f3133fd-641a-4a83-8791-eda341d714e7	\N
c935a3bc-d863-4c4a-8ffa-c4e9a4c3944d	\N	conditional-user-configured	04091393-f3f9-4303-ba2b-e7530a9d7711	3f3133fd-641a-4a83-8791-eda341d714e7	0	10	f	\N	\N
219453c8-a259-4864-bb03-c9372ffa7ed0	\N	auth-otp-form	04091393-f3f9-4303-ba2b-e7530a9d7711	3f3133fd-641a-4a83-8791-eda341d714e7	0	20	f	\N	\N
3139458b-7e9b-4cdb-92e8-8fbc90a925f7	\N	http-basic-authenticator	04091393-f3f9-4303-ba2b-e7530a9d7711	cd63883a-f5b3-4bab-b4da-3e34cd8cf706	0	10	f	\N	\N
99472298-aafb-4a3f-843d-ed77bc3f7354	\N	docker-http-basic-authenticator	04091393-f3f9-4303-ba2b-e7530a9d7711	10c5a001-548e-4a26-93c2-8cb5eb97d4f5	0	10	f	\N	\N
e00ca0f5-a0c7-49a3-a6b5-9cfb2bf04884	\N	idp-email-verification	83b6664d-539e-4bed-a376-685d50e40b98	10e5cbf9-6d70-4671-8b7c-25a13f3b30b6	2	10	f	\N	\N
b0266769-14f9-456f-a7a0-f1288e588b32	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	10e5cbf9-6d70-4671-8b7c-25a13f3b30b6	2	20	t	9072b1a2-a2d2-426d-9fe7-bfb40b87cfab	\N
f43ca563-249c-49da-89a4-a772993b509e	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	936ccde4-b63d-4262-b8a6-af7d521dc3aa	0	10	f	\N	\N
b093e192-e5cc-4065-bca0-67ab32522acb	\N	auth-otp-form	83b6664d-539e-4bed-a376-685d50e40b98	936ccde4-b63d-4262-b8a6-af7d521dc3aa	0	20	f	\N	\N
dbd4e5f2-4922-4b7d-ba5f-6e34cf3c340d	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	dc1e8d98-e26a-437c-91a3-f8ca8ed2dd59	0	10	f	\N	\N
97158821-cedd-43be-b523-f71c1e812574	\N	organization	83b6664d-539e-4bed-a376-685d50e40b98	dc1e8d98-e26a-437c-91a3-f8ca8ed2dd59	2	20	f	\N	\N
f6828205-fba5-471a-b520-fdf4438e31b7	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	5b2379d9-11fb-476f-8530-5a91ca18e364	0	10	f	\N	\N
a096bfa9-a023-4981-9d91-de74ebd52d3f	\N	direct-grant-validate-otp	83b6664d-539e-4bed-a376-685d50e40b98	5b2379d9-11fb-476f-8530-5a91ca18e364	0	20	f	\N	\N
16496b3b-ec89-446f-ae16-d2756d058b57	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	fcaef89a-b301-4a9d-86b6-f570c43d07ad	0	10	f	\N	\N
8f8764a2-f2b8-42a3-91ec-444a40a540f5	\N	idp-add-organization-member	83b6664d-539e-4bed-a376-685d50e40b98	fcaef89a-b301-4a9d-86b6-f570c43d07ad	0	20	f	\N	\N
9871f3c0-f5a1-4566-a557-fe56074bf2a8	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	ceed43c7-5d3f-4eb1-b878-2314aef46ebf	0	10	f	\N	\N
03f63ac6-efbb-4ee4-974c-e56c453d7f9b	\N	auth-otp-form	83b6664d-539e-4bed-a376-685d50e40b98	ceed43c7-5d3f-4eb1-b878-2314aef46ebf	0	20	f	\N	\N
e491eb9d-d8d2-4f16-ae7a-691189309a1c	\N	idp-confirm-link	83b6664d-539e-4bed-a376-685d50e40b98	a9376912-6f72-4749-a4e3-6ce74c0ec76a	0	10	f	\N	\N
906fcbbe-c7ed-4541-bb7d-2cee75391a3c	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	a9376912-6f72-4749-a4e3-6ce74c0ec76a	0	20	t	10e5cbf9-6d70-4671-8b7c-25a13f3b30b6	\N
e9c2c1f8-427e-4bd8-903d-a7ff7182cd12	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	291b3c02-9178-4997-92a8-2c77b4a762da	1	10	t	dc1e8d98-e26a-437c-91a3-f8ca8ed2dd59	\N
c7b515e0-b29f-483d-afa5-33ad807b951e	\N	conditional-user-configured	83b6664d-539e-4bed-a376-685d50e40b98	510a55f8-b4a5-47e9-ac56-b60fc6ed8676	0	10	f	\N	\N
9a60cc9b-29ce-48ce-b169-3a909e8d5b5f	\N	reset-otp	83b6664d-539e-4bed-a376-685d50e40b98	510a55f8-b4a5-47e9-ac56-b60fc6ed8676	0	20	f	\N	\N
364e90d4-a01a-4f93-8bde-ac94e9602c77	\N	idp-create-user-if-unique	83b6664d-539e-4bed-a376-685d50e40b98	677d2578-fe86-4de9-8a18-860f8d89d4f3	2	10	f	\N	7805e560-dd03-4e34-a6ff-1784f53fecad
43185735-f0bd-4f6c-887c-f7d92fcbaf76	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	677d2578-fe86-4de9-8a18-860f8d89d4f3	2	20	t	a9376912-6f72-4749-a4e3-6ce74c0ec76a	\N
519aee6b-199b-4cc3-94a8-3cfffb718dbb	\N	idp-username-password-form	83b6664d-539e-4bed-a376-685d50e40b98	9072b1a2-a2d2-426d-9fe7-bfb40b87cfab	0	10	f	\N	\N
8ea4f210-db72-4017-8f32-182d8672cde9	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	9072b1a2-a2d2-426d-9fe7-bfb40b87cfab	1	20	t	ceed43c7-5d3f-4eb1-b878-2314aef46ebf	\N
44b87570-c4f3-4195-9c9a-50c5b1c8ac9e	\N	auth-cookie	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	2	10	f	\N	\N
a4a48d4b-3820-41bd-979f-ee898842baf4	\N	auth-spnego	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	3	20	f	\N	\N
862bbf3f-1ee6-4a59-8948-a6126d3c4826	\N	identity-provider-redirector	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	2	25	f	\N	\N
fe26cc85-5963-4f6c-a789-03cc331a0c6e	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	2	26	t	291b3c02-9178-4997-92a8-2c77b4a762da	\N
dc44b083-ea9c-4cfa-836b-58eed7fbdc4e	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	801e570d-bc15-45e3-9f8e-afe9f8f28dec	2	30	t	4c7e2a97-05a5-4499-99d5-b0fe14711095	\N
62874105-0fab-4947-a33b-a48bd983be06	\N	client-secret	83b6664d-539e-4bed-a376-685d50e40b98	05607ab5-8839-424c-b1e7-7f0ccad2063e	2	10	f	\N	\N
d7f218ff-a445-4217-a37c-2cf5acd4d0e5	\N	client-jwt	83b6664d-539e-4bed-a376-685d50e40b98	05607ab5-8839-424c-b1e7-7f0ccad2063e	2	20	f	\N	\N
42e7259e-d535-405b-899d-74996d1e2444	\N	client-secret-jwt	83b6664d-539e-4bed-a376-685d50e40b98	05607ab5-8839-424c-b1e7-7f0ccad2063e	2	30	f	\N	\N
168017ff-69ec-452b-b91c-486277908a7f	\N	client-x509	83b6664d-539e-4bed-a376-685d50e40b98	05607ab5-8839-424c-b1e7-7f0ccad2063e	2	40	f	\N	\N
96cb62bb-dd1a-4b9a-b567-dab8b6039024	\N	direct-grant-validate-username	83b6664d-539e-4bed-a376-685d50e40b98	d7b8234b-3d04-4263-ac07-79794e3fb8c0	0	10	f	\N	\N
663a5a2d-2cfd-4c60-a331-a5b4edf42ca9	\N	direct-grant-validate-password	83b6664d-539e-4bed-a376-685d50e40b98	d7b8234b-3d04-4263-ac07-79794e3fb8c0	0	20	f	\N	\N
1636e7de-d951-494a-9314-c4d070c32c6a	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	d7b8234b-3d04-4263-ac07-79794e3fb8c0	1	30	t	5b2379d9-11fb-476f-8530-5a91ca18e364	\N
170c96df-7ed8-4109-a70a-5daa541e3047	\N	docker-http-basic-authenticator	83b6664d-539e-4bed-a376-685d50e40b98	08caf47c-2dda-42d5-a33d-3df1271e703c	0	10	f	\N	\N
f347c9a1-6270-455a-9797-6d893b265b33	\N	idp-review-profile	83b6664d-539e-4bed-a376-685d50e40b98	668883be-9b51-42f6-9e35-cb35d7961852	0	10	f	\N	135d8612-fdf4-4acf-abf8-e25c0565ebf6
1f459a15-5fb3-4736-b926-47fb23e0f599	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	668883be-9b51-42f6-9e35-cb35d7961852	0	20	t	677d2578-fe86-4de9-8a18-860f8d89d4f3	\N
d2e0c637-7707-496a-860b-180b40ed8899	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	668883be-9b51-42f6-9e35-cb35d7961852	1	50	t	fcaef89a-b301-4a9d-86b6-f570c43d07ad	\N
bb55b438-dd9d-4f0d-ada3-8a7e8e608f0e	\N	auth-username-password-form	83b6664d-539e-4bed-a376-685d50e40b98	4c7e2a97-05a5-4499-99d5-b0fe14711095	0	10	f	\N	\N
f007802a-c16a-4ccd-9ed7-eac7468a3f19	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	4c7e2a97-05a5-4499-99d5-b0fe14711095	1	20	t	936ccde4-b63d-4262-b8a6-af7d521dc3aa	\N
2f427f82-9709-44cf-9ab0-e30817b47739	\N	registration-page-form	83b6664d-539e-4bed-a376-685d50e40b98	8c356fe3-6843-440d-ac93-b4cc6352781f	0	10	t	aa3e186d-9e97-41c0-a7f5-956fb754bdea	\N
d8edd147-7fd1-4359-aebd-16a580056369	\N	registration-user-creation	83b6664d-539e-4bed-a376-685d50e40b98	aa3e186d-9e97-41c0-a7f5-956fb754bdea	0	20	f	\N	\N
b1992cfc-a9bf-46fd-8e90-367d8a4539f4	\N	registration-password-action	83b6664d-539e-4bed-a376-685d50e40b98	aa3e186d-9e97-41c0-a7f5-956fb754bdea	0	50	f	\N	\N
4e04c62c-e799-4748-b826-cea44597ce58	\N	registration-recaptcha-action	83b6664d-539e-4bed-a376-685d50e40b98	aa3e186d-9e97-41c0-a7f5-956fb754bdea	3	60	f	\N	\N
93380e46-9da0-4b03-b771-dff9147f43d2	\N	registration-terms-and-conditions	83b6664d-539e-4bed-a376-685d50e40b98	aa3e186d-9e97-41c0-a7f5-956fb754bdea	3	70	f	\N	\N
7681ff4f-e8fb-49fe-a2ad-77cb742eafd4	\N	reset-credentials-choose-user	83b6664d-539e-4bed-a376-685d50e40b98	2ec9ca75-4f99-43e9-816d-708c9a550838	0	10	f	\N	\N
e45e1ca6-d529-450d-945a-2cd4376b39b3	\N	reset-credential-email	83b6664d-539e-4bed-a376-685d50e40b98	2ec9ca75-4f99-43e9-816d-708c9a550838	0	20	f	\N	\N
4e501bef-7b4b-40f5-8d68-01686e8521c7	\N	reset-password	83b6664d-539e-4bed-a376-685d50e40b98	2ec9ca75-4f99-43e9-816d-708c9a550838	0	30	f	\N	\N
b776929f-63cb-40ec-bf0d-f00bd3592915	\N	\N	83b6664d-539e-4bed-a376-685d50e40b98	2ec9ca75-4f99-43e9-816d-708c9a550838	1	40	t	510a55f8-b4a5-47e9-ac56-b60fc6ed8676	\N
95740a31-cab3-45fc-a67e-e70689799e08	\N	http-basic-authenticator	83b6664d-539e-4bed-a376-685d50e40b98	626d5f6d-04d2-4f35-8cfc-da5e65715166	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
fcff186b-b4c8-429e-867b-3dcc940bcc54	browser	Browser based authentication	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	t	t
968ec1a2-7436-4341-9f80-4495f607cd2e	forms	Username, password, otp and other auth forms.	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	f	t
cdc251ab-876a-4d33-8a59-1e0bdf016310	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	f	t
c9b028e0-a6a0-41a3-a45f-be303c9fcbe3	direct grant	OpenID Connect Resource Owner Grant	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	t	t
e01884d7-5bb5-4d3a-ac2c-8d78ec5fa82a	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	f	t
943be564-f760-4242-87e4-31bc14d5be41	registration	Registration flow	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	t	t
f38c49f3-df83-4418-9f4d-465869eb0b1a	registration form	Registration form	04091393-f3f9-4303-ba2b-e7530a9d7711	form-flow	f	t
65610f20-65d0-4589-980e-0660936234ff	reset credentials	Reset credentials for a user if they forgot their password or something	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	t	t
062807ac-81e5-4078-b5b4-5c58b8f61f0b	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	f	t
290141e8-96a6-43f5-b46b-d0b233daf717	clients	Base authentication for clients	04091393-f3f9-4303-ba2b-e7530a9d7711	client-flow	t	t
2d672118-c7c4-46cf-b4d7-0bfab7a28e22	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	t	t
bb2a8a59-cbae-4513-88e5-bf98b81799d1	User creation or linking	Flow for the existing/non-existing user alternatives	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	f	t
692bbb35-ac7a-4753-98de-955e4bf550f8	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	f	t
a65a8e98-9b60-4895-85a9-613e551d7e32	Account verification options	Method with which to verity the existing account	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	f	t
518fb9e4-ff70-46e4-a2ff-aeb0de47e5df	Verify Existing Account by Re-authentication	Reauthentication of existing account	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	f	t
3f3133fd-641a-4a83-8791-eda341d714e7	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	f	t
cd63883a-f5b3-4bab-b4da-3e34cd8cf706	saml ecp	SAML ECP Profile Authentication Flow	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	t	t
10c5a001-548e-4a26-93c2-8cb5eb97d4f5	docker auth	Used by Docker clients to authenticate against the IDP	04091393-f3f9-4303-ba2b-e7530a9d7711	basic-flow	t	t
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
1196da19-23fa-409b-81a6-6d01957171f3	review profile config	04091393-f3f9-4303-ba2b-e7530a9d7711
e884ea95-fff9-4cfe-a025-c3fa7690be6f	create unique user config	04091393-f3f9-4303-ba2b-e7530a9d7711
7805e560-dd03-4e34-a6ff-1784f53fecad	create unique user config	83b6664d-539e-4bed-a376-685d50e40b98
135d8612-fdf4-4acf-abf8-e25c0565ebf6	review profile config	83b6664d-539e-4bed-a376-685d50e40b98
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
1196da19-23fa-409b-81a6-6d01957171f3	missing	update.profile.on.first.login
e884ea95-fff9-4cfe-a025-c3fa7690be6f	false	require.password.update.after.registration
135d8612-fdf4-4acf-abf8-e25c0565ebf6	missing	update.profile.on.first.login
7805e560-dd03-4e34-a6ff-1784f53fecad	false	require.password.update.after.registration
\.


--
-- Data for Name: authority; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.authority (name) FROM stdin;
ROLE_UMA_AUTHORIZATION
ROLE_OFFLINE_ACCESS
ROLE_DEFAULT-ROLES-LOCI-REALM
ROLE_USER
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
778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	f	master-realm	0	f	\N	\N	t	\N	f	04091393-f3f9-4303-ba2b-e7530a9d7711	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	04091393-f3f9-4303-ba2b-e7530a9d7711	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	04091393-f3f9-4303-ba2b-e7530a9d7711	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9e099ae8-44d5-466e-ab9b-a04e86231b9c	t	f	broker	0	f	\N	\N	t	\N	f	04091393-f3f9-4303-ba2b-e7530a9d7711	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
190691f2-8063-4df4-a638-478d961bda4f	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	04091393-f3f9-4303-ba2b-e7530a9d7711	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
927b6cff-e422-443c-8b50-8f4d8d0468cd	t	t	admin-cli	0	t	\N	\N	f	\N	f	04091393-f3f9-4303-ba2b-e7530a9d7711	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
cf811709-122d-4121-97ba-0faecd4dd786	t	f	loci-realm-realm	0	f	\N	\N	t	\N	f	04091393-f3f9-4303-ba2b-e7530a9d7711	\N	0	f	f	loci-realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
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
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	post.logout.redirect.uris	+
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	post.logout.redirect.uris	+
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	pkce.code.challenge.method	S256
190691f2-8063-4df4-a638-478d961bda4f	post.logout.redirect.uris	+
190691f2-8063-4df4-a638-478d961bda4f	pkce.code.challenge.method	S256
190691f2-8063-4df4-a638-478d961bda4f	client.use.lightweight.access.token.enabled	true
927b6cff-e422-443c-8b50-8f4d8d0468cd	client.use.lightweight.access.token.enabled	true
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
3f91aa0b-03fc-4f80-a2ea-f1b18e99d7ee	offline_access	04091393-f3f9-4303-ba2b-e7530a9d7711	OpenID Connect built-in scope: offline_access	openid-connect
d21970ae-3d0a-46fd-bc59-6dffee6c6e73	role_list	04091393-f3f9-4303-ba2b-e7530a9d7711	SAML role list	saml
c01a79bf-5a56-41db-88fd-a9234216adde	saml_organization	04091393-f3f9-4303-ba2b-e7530a9d7711	Organization Membership	saml
dbf413af-a311-4102-9b8a-98c05dc655b7	profile	04091393-f3f9-4303-ba2b-e7530a9d7711	OpenID Connect built-in scope: profile	openid-connect
dcd07cb6-ef1d-48b2-8747-88ad3946ee0e	email	04091393-f3f9-4303-ba2b-e7530a9d7711	OpenID Connect built-in scope: email	openid-connect
24a82def-b835-4f28-977c-aa2a3d1a7b88	address	04091393-f3f9-4303-ba2b-e7530a9d7711	OpenID Connect built-in scope: address	openid-connect
76ec706b-d4ab-4f9b-8156-47ea9af0e318	phone	04091393-f3f9-4303-ba2b-e7530a9d7711	OpenID Connect built-in scope: phone	openid-connect
5a5f5802-cb3f-4af0-a317-92f38e7434d6	roles	04091393-f3f9-4303-ba2b-e7530a9d7711	OpenID Connect scope for add user roles to the access token	openid-connect
5ae7e88a-bf7d-4f78-93ea-1958d6ee8ddd	web-origins	04091393-f3f9-4303-ba2b-e7530a9d7711	OpenID Connect scope for add allowed web origins to the access token	openid-connect
d672ef9a-bcca-49ec-998e-d46dbddd2672	microprofile-jwt	04091393-f3f9-4303-ba2b-e7530a9d7711	Microprofile - JWT built-in scope	openid-connect
e6fa5c3d-7a27-4adf-a573-07831135026f	acr	04091393-f3f9-4303-ba2b-e7530a9d7711	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
63e8ae03-b467-4422-8cb6-322ea262065f	basic	04091393-f3f9-4303-ba2b-e7530a9d7711	OpenID Connect scope for add all basic claims to the token	openid-connect
2e5b32a3-cde4-49f5-9337-13443b4ba420	organization	04091393-f3f9-4303-ba2b-e7530a9d7711	Additional claims about the organization a subject belongs to	openid-connect
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
3f91aa0b-03fc-4f80-a2ea-f1b18e99d7ee	true	display.on.consent.screen
3f91aa0b-03fc-4f80-a2ea-f1b18e99d7ee	${offlineAccessScopeConsentText}	consent.screen.text
d21970ae-3d0a-46fd-bc59-6dffee6c6e73	true	display.on.consent.screen
d21970ae-3d0a-46fd-bc59-6dffee6c6e73	${samlRoleListScopeConsentText}	consent.screen.text
c01a79bf-5a56-41db-88fd-a9234216adde	false	display.on.consent.screen
dbf413af-a311-4102-9b8a-98c05dc655b7	true	display.on.consent.screen
dbf413af-a311-4102-9b8a-98c05dc655b7	${profileScopeConsentText}	consent.screen.text
dbf413af-a311-4102-9b8a-98c05dc655b7	true	include.in.token.scope
dcd07cb6-ef1d-48b2-8747-88ad3946ee0e	true	display.on.consent.screen
dcd07cb6-ef1d-48b2-8747-88ad3946ee0e	${emailScopeConsentText}	consent.screen.text
dcd07cb6-ef1d-48b2-8747-88ad3946ee0e	true	include.in.token.scope
24a82def-b835-4f28-977c-aa2a3d1a7b88	true	display.on.consent.screen
24a82def-b835-4f28-977c-aa2a3d1a7b88	${addressScopeConsentText}	consent.screen.text
24a82def-b835-4f28-977c-aa2a3d1a7b88	true	include.in.token.scope
76ec706b-d4ab-4f9b-8156-47ea9af0e318	true	display.on.consent.screen
76ec706b-d4ab-4f9b-8156-47ea9af0e318	${phoneScopeConsentText}	consent.screen.text
76ec706b-d4ab-4f9b-8156-47ea9af0e318	true	include.in.token.scope
5a5f5802-cb3f-4af0-a317-92f38e7434d6	true	display.on.consent.screen
5a5f5802-cb3f-4af0-a317-92f38e7434d6	${rolesScopeConsentText}	consent.screen.text
5a5f5802-cb3f-4af0-a317-92f38e7434d6	false	include.in.token.scope
5ae7e88a-bf7d-4f78-93ea-1958d6ee8ddd	false	display.on.consent.screen
5ae7e88a-bf7d-4f78-93ea-1958d6ee8ddd		consent.screen.text
5ae7e88a-bf7d-4f78-93ea-1958d6ee8ddd	false	include.in.token.scope
d672ef9a-bcca-49ec-998e-d46dbddd2672	false	display.on.consent.screen
d672ef9a-bcca-49ec-998e-d46dbddd2672	true	include.in.token.scope
e6fa5c3d-7a27-4adf-a573-07831135026f	false	display.on.consent.screen
e6fa5c3d-7a27-4adf-a573-07831135026f	false	include.in.token.scope
63e8ae03-b467-4422-8cb6-322ea262065f	false	display.on.consent.screen
63e8ae03-b467-4422-8cb6-322ea262065f	false	include.in.token.scope
2e5b32a3-cde4-49f5-9337-13443b4ba420	true	display.on.consent.screen
2e5b32a3-cde4-49f5-9337-13443b4ba420	${organizationScopeConsentText}	consent.screen.text
2e5b32a3-cde4-49f5-9337-13443b4ba420	true	include.in.token.scope
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
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	5a5f5802-cb3f-4af0-a317-92f38e7434d6	t
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	5ae7e88a-bf7d-4f78-93ea-1958d6ee8ddd	t
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	dcd07cb6-ef1d-48b2-8747-88ad3946ee0e	t
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	dbf413af-a311-4102-9b8a-98c05dc655b7	t
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	63e8ae03-b467-4422-8cb6-322ea262065f	t
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	e6fa5c3d-7a27-4adf-a573-07831135026f	t
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	76ec706b-d4ab-4f9b-8156-47ea9af0e318	f
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	24a82def-b835-4f28-977c-aa2a3d1a7b88	f
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	d672ef9a-bcca-49ec-998e-d46dbddd2672	f
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	3f91aa0b-03fc-4f80-a2ea-f1b18e99d7ee	f
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	2e5b32a3-cde4-49f5-9337-13443b4ba420	f
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	5a5f5802-cb3f-4af0-a317-92f38e7434d6	t
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	5ae7e88a-bf7d-4f78-93ea-1958d6ee8ddd	t
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	dcd07cb6-ef1d-48b2-8747-88ad3946ee0e	t
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	dbf413af-a311-4102-9b8a-98c05dc655b7	t
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	63e8ae03-b467-4422-8cb6-322ea262065f	t
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	e6fa5c3d-7a27-4adf-a573-07831135026f	t
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	76ec706b-d4ab-4f9b-8156-47ea9af0e318	f
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	24a82def-b835-4f28-977c-aa2a3d1a7b88	f
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	d672ef9a-bcca-49ec-998e-d46dbddd2672	f
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	3f91aa0b-03fc-4f80-a2ea-f1b18e99d7ee	f
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	2e5b32a3-cde4-49f5-9337-13443b4ba420	f
927b6cff-e422-443c-8b50-8f4d8d0468cd	5a5f5802-cb3f-4af0-a317-92f38e7434d6	t
927b6cff-e422-443c-8b50-8f4d8d0468cd	5ae7e88a-bf7d-4f78-93ea-1958d6ee8ddd	t
927b6cff-e422-443c-8b50-8f4d8d0468cd	dcd07cb6-ef1d-48b2-8747-88ad3946ee0e	t
927b6cff-e422-443c-8b50-8f4d8d0468cd	dbf413af-a311-4102-9b8a-98c05dc655b7	t
927b6cff-e422-443c-8b50-8f4d8d0468cd	63e8ae03-b467-4422-8cb6-322ea262065f	t
927b6cff-e422-443c-8b50-8f4d8d0468cd	e6fa5c3d-7a27-4adf-a573-07831135026f	t
927b6cff-e422-443c-8b50-8f4d8d0468cd	76ec706b-d4ab-4f9b-8156-47ea9af0e318	f
927b6cff-e422-443c-8b50-8f4d8d0468cd	24a82def-b835-4f28-977c-aa2a3d1a7b88	f
927b6cff-e422-443c-8b50-8f4d8d0468cd	d672ef9a-bcca-49ec-998e-d46dbddd2672	f
927b6cff-e422-443c-8b50-8f4d8d0468cd	3f91aa0b-03fc-4f80-a2ea-f1b18e99d7ee	f
927b6cff-e422-443c-8b50-8f4d8d0468cd	2e5b32a3-cde4-49f5-9337-13443b4ba420	f
9e099ae8-44d5-466e-ab9b-a04e86231b9c	5a5f5802-cb3f-4af0-a317-92f38e7434d6	t
9e099ae8-44d5-466e-ab9b-a04e86231b9c	5ae7e88a-bf7d-4f78-93ea-1958d6ee8ddd	t
9e099ae8-44d5-466e-ab9b-a04e86231b9c	dcd07cb6-ef1d-48b2-8747-88ad3946ee0e	t
9e099ae8-44d5-466e-ab9b-a04e86231b9c	dbf413af-a311-4102-9b8a-98c05dc655b7	t
9e099ae8-44d5-466e-ab9b-a04e86231b9c	63e8ae03-b467-4422-8cb6-322ea262065f	t
9e099ae8-44d5-466e-ab9b-a04e86231b9c	e6fa5c3d-7a27-4adf-a573-07831135026f	t
9e099ae8-44d5-466e-ab9b-a04e86231b9c	76ec706b-d4ab-4f9b-8156-47ea9af0e318	f
9e099ae8-44d5-466e-ab9b-a04e86231b9c	24a82def-b835-4f28-977c-aa2a3d1a7b88	f
9e099ae8-44d5-466e-ab9b-a04e86231b9c	d672ef9a-bcca-49ec-998e-d46dbddd2672	f
9e099ae8-44d5-466e-ab9b-a04e86231b9c	3f91aa0b-03fc-4f80-a2ea-f1b18e99d7ee	f
9e099ae8-44d5-466e-ab9b-a04e86231b9c	2e5b32a3-cde4-49f5-9337-13443b4ba420	f
778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	5a5f5802-cb3f-4af0-a317-92f38e7434d6	t
778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	5ae7e88a-bf7d-4f78-93ea-1958d6ee8ddd	t
778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	dcd07cb6-ef1d-48b2-8747-88ad3946ee0e	t
778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	dbf413af-a311-4102-9b8a-98c05dc655b7	t
778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	63e8ae03-b467-4422-8cb6-322ea262065f	t
778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	e6fa5c3d-7a27-4adf-a573-07831135026f	t
778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	76ec706b-d4ab-4f9b-8156-47ea9af0e318	f
778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	24a82def-b835-4f28-977c-aa2a3d1a7b88	f
778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	d672ef9a-bcca-49ec-998e-d46dbddd2672	f
778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	3f91aa0b-03fc-4f80-a2ea-f1b18e99d7ee	f
778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	2e5b32a3-cde4-49f5-9337-13443b4ba420	f
190691f2-8063-4df4-a638-478d961bda4f	5a5f5802-cb3f-4af0-a317-92f38e7434d6	t
190691f2-8063-4df4-a638-478d961bda4f	5ae7e88a-bf7d-4f78-93ea-1958d6ee8ddd	t
190691f2-8063-4df4-a638-478d961bda4f	dcd07cb6-ef1d-48b2-8747-88ad3946ee0e	t
190691f2-8063-4df4-a638-478d961bda4f	dbf413af-a311-4102-9b8a-98c05dc655b7	t
190691f2-8063-4df4-a638-478d961bda4f	63e8ae03-b467-4422-8cb6-322ea262065f	t
190691f2-8063-4df4-a638-478d961bda4f	e6fa5c3d-7a27-4adf-a573-07831135026f	t
190691f2-8063-4df4-a638-478d961bda4f	76ec706b-d4ab-4f9b-8156-47ea9af0e318	f
190691f2-8063-4df4-a638-478d961bda4f	24a82def-b835-4f28-977c-aa2a3d1a7b88	f
190691f2-8063-4df4-a638-478d961bda4f	d672ef9a-bcca-49ec-998e-d46dbddd2672	f
190691f2-8063-4df4-a638-478d961bda4f	3f91aa0b-03fc-4f80-a2ea-f1b18e99d7ee	f
190691f2-8063-4df4-a638-478d961bda4f	2e5b32a3-cde4-49f5-9337-13443b4ba420	f
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
3f91aa0b-03fc-4f80-a2ea-f1b18e99d7ee	ee52eca1-05c8-48a7-9dd0-ac1e0a637b0c
b7f3f02b-6bcb-4ed0-8d23-9fcf556e2243	6d7b0d9a-0ac1-481e-aebb-8acd9d5c3e39
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
dbad224d-7579-4fbb-8143-0e4caf097e5f	Trusted Hosts	04091393-f3f9-4303-ba2b-e7530a9d7711	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04091393-f3f9-4303-ba2b-e7530a9d7711	anonymous
d83def2e-fef1-4852-89c8-144489b1b29d	Consent Required	04091393-f3f9-4303-ba2b-e7530a9d7711	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04091393-f3f9-4303-ba2b-e7530a9d7711	anonymous
49cdf3ed-2fcc-49f3-8d34-f5d379fde4f3	Full Scope Disabled	04091393-f3f9-4303-ba2b-e7530a9d7711	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04091393-f3f9-4303-ba2b-e7530a9d7711	anonymous
c87d148e-c843-4b23-a71c-e03b75dd1a29	Max Clients Limit	04091393-f3f9-4303-ba2b-e7530a9d7711	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04091393-f3f9-4303-ba2b-e7530a9d7711	anonymous
2404863c-93d5-40ff-8e3c-e57626b7a8fd	Allowed Protocol Mapper Types	04091393-f3f9-4303-ba2b-e7530a9d7711	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04091393-f3f9-4303-ba2b-e7530a9d7711	anonymous
09647936-336b-44c3-9a4a-d07742987ee5	Allowed Client Scopes	04091393-f3f9-4303-ba2b-e7530a9d7711	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04091393-f3f9-4303-ba2b-e7530a9d7711	anonymous
5f2c6d15-7ae5-4efe-84c5-2cedce11ccb8	Allowed Protocol Mapper Types	04091393-f3f9-4303-ba2b-e7530a9d7711	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04091393-f3f9-4303-ba2b-e7530a9d7711	authenticated
9841e7a8-66c5-4fbe-9ddc-85ad71ba4781	Allowed Client Scopes	04091393-f3f9-4303-ba2b-e7530a9d7711	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04091393-f3f9-4303-ba2b-e7530a9d7711	authenticated
376a26d4-ed62-471e-9863-df8109835a7e	rsa-generated	04091393-f3f9-4303-ba2b-e7530a9d7711	rsa-generated	org.keycloak.keys.KeyProvider	04091393-f3f9-4303-ba2b-e7530a9d7711	\N
bddb4837-b989-4c42-bdec-6ae8663fc25c	rsa-enc-generated	04091393-f3f9-4303-ba2b-e7530a9d7711	rsa-enc-generated	org.keycloak.keys.KeyProvider	04091393-f3f9-4303-ba2b-e7530a9d7711	\N
9c80f8e9-1a65-4bb2-a216-b52210f9f2bf	hmac-generated-hs512	04091393-f3f9-4303-ba2b-e7530a9d7711	hmac-generated	org.keycloak.keys.KeyProvider	04091393-f3f9-4303-ba2b-e7530a9d7711	\N
39c6cbe9-ce64-4740-8d93-6056f2355b33	aes-generated	04091393-f3f9-4303-ba2b-e7530a9d7711	aes-generated	org.keycloak.keys.KeyProvider	04091393-f3f9-4303-ba2b-e7530a9d7711	\N
6725f8f8-2d3c-49ea-b9b1-a11442df468c	\N	04091393-f3f9-4303-ba2b-e7530a9d7711	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	04091393-f3f9-4303-ba2b-e7530a9d7711	\N
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
39deadf8-bdef-4a47-9c54-5c8ce14e7e4f	09647936-336b-44c3-9a4a-d07742987ee5	allow-default-scopes	true
feeb1c48-3701-4d8f-8ea3-cadd9ca86583	5f2c6d15-7ae5-4efe-84c5-2cedce11ccb8	allowed-protocol-mapper-types	oidc-address-mapper
ff7e75c3-bb67-4f40-98e8-3057374a20a7	5f2c6d15-7ae5-4efe-84c5-2cedce11ccb8	allowed-protocol-mapper-types	saml-user-property-mapper
85e663ea-0773-40be-919b-e5f4dd5fa431	5f2c6d15-7ae5-4efe-84c5-2cedce11ccb8	allowed-protocol-mapper-types	saml-user-attribute-mapper
50ab3b32-c219-4308-953c-4413bd565a37	5f2c6d15-7ae5-4efe-84c5-2cedce11ccb8	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
45585bda-7ca0-4f0c-ac94-4f2d1bfcf6a5	5f2c6d15-7ae5-4efe-84c5-2cedce11ccb8	allowed-protocol-mapper-types	saml-role-list-mapper
9252dc62-8a08-4980-ba7a-81f007c30311	5f2c6d15-7ae5-4efe-84c5-2cedce11ccb8	allowed-protocol-mapper-types	oidc-full-name-mapper
1535bc00-6539-4ceb-8076-525efef9e20a	5f2c6d15-7ae5-4efe-84c5-2cedce11ccb8	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
bd0d367e-83b0-4c26-a4e2-a5e720a7f586	5f2c6d15-7ae5-4efe-84c5-2cedce11ccb8	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
218366c9-ff6a-4f9c-a339-a2e368c5de71	dbad224d-7579-4fbb-8143-0e4caf097e5f	client-uris-must-match	true
d9ffe450-f446-496d-bd95-1eb626c9e180	dbad224d-7579-4fbb-8143-0e4caf097e5f	host-sending-registration-request-must-match	true
63a07021-f9da-4307-846a-73e6467262ae	9841e7a8-66c5-4fbe-9ddc-85ad71ba4781	allow-default-scopes	true
0db86c7e-c517-49ea-8a14-8a3c184ab279	c87d148e-c843-4b23-a71c-e03b75dd1a29	max-clients	200
0e04ef8f-f70b-47a5-a505-21aaab6a4b83	2404863c-93d5-40ff-8e3c-e57626b7a8fd	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
f43e769e-6a25-48ff-8c2c-3338bfd82692	2404863c-93d5-40ff-8e3c-e57626b7a8fd	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
eeb7a02a-04bd-493a-9b86-415a8d9b8f5d	2404863c-93d5-40ff-8e3c-e57626b7a8fd	allowed-protocol-mapper-types	oidc-address-mapper
2877d61c-9c18-465d-b925-01384995ed82	2404863c-93d5-40ff-8e3c-e57626b7a8fd	allowed-protocol-mapper-types	saml-user-property-mapper
6eff1158-8d27-40cd-8ea2-0c2a0cee4f35	2404863c-93d5-40ff-8e3c-e57626b7a8fd	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
7bc933a5-35d3-4cf3-a612-aca08d475e5f	2404863c-93d5-40ff-8e3c-e57626b7a8fd	allowed-protocol-mapper-types	saml-user-attribute-mapper
77565f6c-e81e-4c96-894d-bd51320f253d	2404863c-93d5-40ff-8e3c-e57626b7a8fd	allowed-protocol-mapper-types	oidc-full-name-mapper
cca12cde-1666-48ca-995e-0a724b80cb7c	2404863c-93d5-40ff-8e3c-e57626b7a8fd	allowed-protocol-mapper-types	saml-role-list-mapper
257f0730-87fd-4071-b788-82aba20f3985	376a26d4-ed62-471e-9863-df8109835a7e	privateKey	MIIEpQIBAAKCAQEAyYxenTRhmzcRfBcDuCOeGj5bJ0nu3w0qUTUH/S8ROOx3EUegV0ftYvCHhAoaFo50eZU9ncxWOJOpF9lLCojQVKG2zT+F3U9RrgkhFVcZDFHxWMph9d92P+9eoGp6tc11ShszPz6Fcw1cHDCCneClQl3i+LvVtvYFIAphnnKM4yHrHUVRI/K/6q4qp473fWMLaW0Gogz2JOG7k/UyJGnIhWti3xAw4FjZcQ25l7jX2iWBiYs4s1jUzDAsqnnEYkriPYBmdpSLCl5zySUa73Bl2hqM9B6CegVxCjhk+e4JXaV7xN1axmGZrHkwWYjonnON8C6HdO2htMzW8IGuJ3eMiwIDAQABAoIBABpfHA18ykgJa2fDCSZhvrECDLeg1GO/cL83GFMCrWxh1cM0jeCDFabBqzGrMrZV2xwCMObsqDF3R1j1V9If4bEuhwvnGRMX6wDsdTWPc8Rpamdq9RNmCFkdmdI/7HYiVTZQ8HfWLJbyc2VwMX8Kja/CjM1tTRhHVkIBfxFrkqSwqBu37s0/YQ6ApKpt4so+hLxwbsd50x5qohjmL/9OQllygdslCEcRbQjIQysy4HVavpu/Aqv6PQ6PrVtYJyu9N4TWNqSF/weU3ukAYGZSXjtS+1mqaVMOGSkjHnXn5GTkKxzjD9pQ/z0C/Mad8dSHQN1BDvIDM0adZTmMoPO4zEkCgYEA715E8clR1JB1mZ1Yjwh/W0gTs1/11vkQVPSPhohXexaU6vW8ZSrSmWEKDptxCT5Z4iNFRc8OdGsDhgSaYiY2OBpPXsyWHHdY/bsZDmqLnYxV+bT7kGLMY/33s+AJ6B3mUmZUnpWIIb/34d+KNMlLxZEQPsptNOLXcJFoFebr6EkCgYEA141iKt2s/G6noIbcI5SR4TDnEZzbc5H2840A95ZfKn9+0u+GeYEKZPSYR+R1/a5Nt0wxSZyrWZ0fngjWTsnLWzKmFjIY9I9kYY3gdebLsuSaHjsZNCch1ppLANl02K+tFw6wt4hFOoEzCqaibSo1/wnQVcJ8FnL5XsfFb/ByFjMCgYEAqJDybHMhtVel+W/dFZ0eUuIHPaKuNZ1f6vPuvwb01DGq3WwAKB5oAKtdsbu1dpT6J04/UlHmFAXojVBgiA3w0MF2c4QPkixZ9xTzKDvP5jsVsKvLHHr3BNOsxHdZgqTLtetqW+Nh4qKVpfMOGO5I9fCaSB21mjDFFvjPG91q9EECgYEAp7J0XFsoWSARw98H55qPv/4W12oMhaZa1XKu/PB9S4fzeFInceJF3vM4gj4o2dtA1Uku01FTMh3+2imP6a4vSt1lv8DsD2B7vTXvGmsbsSsPCFP8MMn9FoPltFx5/pb2eAjSzYb0LScVOcUYewurBKdy8TWk6qY6glWzsnoDmGcCgYEAmu07xCH2v73KIeM9DMzMi6D10qS/QwXuTvhEPpJu9iI9l/PP4xyR1n+QdAMr/AyXC0WrD0qUHMZASzwYY+Jy5Vlj51r4t2czCffFXoty0e3+XOHz92T/Z6KtZYzJRrR96OK+gGw3Qhpn02i0Y6d38zMnhZ/eXQWExAN0L9CA3JM=
183d1bf6-9897-4834-ab9f-1ba03439b309	376a26d4-ed62-471e-9863-df8109835a7e	keyUse	SIG
03343a53-42d4-4646-a638-d8a6a684fcbd	376a26d4-ed62-471e-9863-df8109835a7e	certificate	MIICmzCCAYMCBgGa6M3eFTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUxMjA0MDk1ODE3WhcNMzUxMjA0MDk1OTU3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDJjF6dNGGbNxF8FwO4I54aPlsnSe7fDSpRNQf9LxE47HcRR6BXR+1i8IeEChoWjnR5lT2dzFY4k6kX2UsKiNBUobbNP4XdT1GuCSEVVxkMUfFYymH133Y/716ganq1zXVKGzM/PoVzDVwcMIKd4KVCXeL4u9W29gUgCmGecozjIesdRVEj8r/qriqnjvd9YwtpbQaiDPYk4buT9TIkaciFa2LfEDDgWNlxDbmXuNfaJYGJizizWNTMMCyqecRiSuI9gGZ2lIsKXnPJJRrvcGXaGoz0HoJ6BXEKOGT57gldpXvE3VrGYZmseTBZiOiec43wLod07aG0zNbwga4nd4yLAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJwIClQMKvWvlwln+TqaB3j7ZKUZg5rVCFKgC4S+dSa21y+RquWxptBANBsPZdyq857nOyy/DuPotADEygWjpaWGdvRiZbb2BVgRJwUWcKZxV/JJ1oZA+3OUt4n4d/KPsUCS9gRCkTF2WE81CXErrtdxAMV7VFuFKevb90G5Ey5HS7ogNxEgksbThZqKm+MwAg6GqWCTfImBJA3rI3SMDFK2atBucKJ63pAjRjRG4wQkzoXpMAfl6ybC27HXEUbo9RMLleJGvmCihKcGD0jkWJSHzYy+G0O8YmKjKFWL5/gLxkUaqpDQW7bPend+c65ezx1LA4tsk65zPcdALyLiV5o=
07e6445e-18ec-4844-ae14-d91702d28212	376a26d4-ed62-471e-9863-df8109835a7e	priority	100
076b5caf-baa1-4af7-abc3-60d93787f6be	bddb4837-b989-4c42-bdec-6ae8663fc25c	algorithm	RSA-OAEP
c3a3ffda-d8f3-4ed1-98b3-aa52bfe9c81d	bddb4837-b989-4c42-bdec-6ae8663fc25c	privateKey	MIIEowIBAAKCAQEAy1EdQHrerIE5CBFGzf+raN69ckqmp7df1vvpYXZtQSSgmyNs54Nlzr+Md5k52WLkAAzpmmLf8cuzBwA7khzXHr0SxCw3vlqV1A0acHv6Fbqb/igxeAfbKKeI7wuudJHnj3kR4Qd+h0Eht+w8PuU70NLRhYHggJZzzfnOFetjsKs7sOfpBptIK2njjCwucDWpV1qByrIStGd6VJltYdGwarhhyfJ+n16DCPBEO/8aBAWWUq1KxztN2+dsTnexxpSitlHgY0TpfGqxoxcagEwiZ0yqJmv6VIdwFbzdMm99FycChv+2UKp+4MUBUhTGUZ2te/oRfUUBwqjJmnohTHy9wQIDAQABAoIBAFmw89WRHpA9BVrAvFp90jEWKb60neZY58egI6liI/pb3RnzO8S523ykVaQhDTsP/ALlr1vzCFXThaut95mSbXfa8t9lnkW0EmqUSTicCIvzYYNyWbhYxt6dYbQKlDBKeTt6rl91/eRO4EARz9XzLDsH9XQPAmnXdUjFTZuv1q+FYSltRR85Eb3e5AOg9yNwdxecu2ESBp1+gVxY9MoRgIvgVvDkB50uqeiPlskt2K54HD0bFgL0zmpXBdouYrCP2T7+8tcicA0WZ6puPfD5DP9qZz69ZdJXF3Kj6ULgSTfYPG3mtIgcnvnCBCS2SifpSsRsznd6H2uipkqoxCvY8+0CgYEA5c3Fbx1Z8VrjU59IaRW+gU6ojUBWzccaSbWaLOliU/ZLbnP4WHnq4j/KPlYoBkXIv5arvEJDjTkLapVSxmm5N0T4xrazZunTIXz4cOhCVtHs0xTL7gAnNy0dLNHNdi616T+NzdSjJ69yDzolWXhXu0oprwhQks4+rOSymZhCdqMCgYEA4n5j5jEQznXrCcesYKmNA5rTqlbczKp0s37p2UJWtDzPUdc2b8WR4kzVBoULDATbMOsQ9oSo06MfBJKY6vuAyvytDcE95tkgAh63z6ZWucW+j//QBK5wO8w265mZf79sKgo40VJyA1x9tMkY9IdIdG7Tu49PasA5UrQkCYt31EsCgYBE4nqlRRoZ9BGilmOBRIhXgHmb5cZfZqhloe82OTtFSdXwpQizlNAow9BfATp8LtzvOT3/b6mKIqheaaZnXXesrpsYDdoXJk4ogqqCRczk84ZW+6vpitg2fOp67eT14SicY3WhVnUVx0ycbeSWPjGmLaPzGL32U6aL8v3qdq6tmwKBgGdGUFD3EH3DwN9dv5j31sfNAjTKlLVyB/KMrR6WpChdDf94TWcbxFBWzk/BvG7HjBa7KKnvhXezCoKwQa/r7CcindoGwi4P1QuCbDfv1d2xcBoDABwSWjS6AlTdXeOlKjHlJVE08a3cr6kOhSWCxiPpIPyF9SVs7vZqE4CSqpoPAoGBANjf35eIRYZYiABoxhpV50n/tIiiD62TCifgaqDso8b8geDd0O6fraEgesK+fjGLPhGDb5OMjRbCTz1ajZkir0tnssptMpvTwE0CSupscOiy/K3ozUjz9zXZJM6Za3OAgyPidRt8wqrJlMaiC4C0WDPJs1ySYW8mB4K1v3FOyPfS
e44ba8e3-3042-4ee4-9c39-01e54314e431	bddb4837-b989-4c42-bdec-6ae8663fc25c	certificate	MIICmzCCAYMCBgGa6M3idjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUxMjA0MDk1ODE4WhcNMzUxMjA0MDk1OTU4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDLUR1Aet6sgTkIEUbN/6to3r1ySqant1/W++lhdm1BJKCbI2zng2XOv4x3mTnZYuQADOmaYt/xy7MHADuSHNcevRLELDe+WpXUDRpwe/oVupv+KDF4B9sop4jvC650keePeRHhB36HQSG37Dw+5TvQ0tGFgeCAlnPN+c4V62Owqzuw5+kGm0graeOMLC5wNalXWoHKshK0Z3pUmW1h0bBquGHJ8n6fXoMI8EQ7/xoEBZZSrUrHO03b52xOd7HGlKK2UeBjROl8arGjFxqATCJnTKoma/pUh3AVvN0yb30XJwKG/7ZQqn7gxQFSFMZRna17+hF9RQHCqMmaeiFMfL3BAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADu+UBYzNdYOxmA25ki580OlM/LlFUwccJsPOEy8BxraULZcyP/u3sKbkXzjkHHl9irrf0H74P1oQDsTUKNQYuh+8cv8NK55ALsa6x+Pb9XRCFSjRnGsZD5VmjITvYSsx44/zLO8IE7dV40cUThE+0fuMkAVa81Us3Zgo9IWBpfQyXmBINL4e/xyRIOCcHdAC770KKTPREEg/Ql4y8B+ltxSGVF5n1t7lkHmgFtbB9o+SoQYSj5DQNymROGjs6IJ5EoEM+VRfNLMEp/wRCr1DBLROzGLKk9GE5Vjk/ozQJ28j7EXl2pcDuqQkfFejdgU/q3L0bNfrhGGoSO8Onr0npw=
19dcb9ba-f41a-498f-a84f-045714449ad0	bddb4837-b989-4c42-bdec-6ae8663fc25c	priority	100
98386366-68b1-4a08-a5ac-9314d5a2c4b0	bddb4837-b989-4c42-bdec-6ae8663fc25c	keyUse	ENC
36b88b54-38ac-4184-9213-69a94bd02004	39c6cbe9-ce64-4740-8d93-6056f2355b33	kid	2d38dafb-a20b-4307-89e5-93d9d979246b
07c74466-0ac6-464f-9f50-6c0dc9165802	39c6cbe9-ce64-4740-8d93-6056f2355b33	secret	n6qNfbnCcBkrcuh6bQl97g
13d398fe-f168-4cef-a959-31ee04daab09	39c6cbe9-ce64-4740-8d93-6056f2355b33	priority	100
4a7eef96-845d-4fe2-9d54-36d6c21e6403	6725f8f8-2d3c-49ea-b9b1-a11442df468c	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
a9436e40-defa-4360-9801-3b1b232610f3	9c80f8e9-1a65-4bb2-a216-b52210f9f2bf	kid	53121dd3-39d5-41e9-b21b-b52460386063
b1e0aa98-3873-46fa-8006-d29b89fd8fee	9c80f8e9-1a65-4bb2-a216-b52210f9f2bf	priority	100
8484ab38-c74b-421f-aac2-ebdc750ca46e	9c80f8e9-1a65-4bb2-a216-b52210f9f2bf	secret	puH-imPOSWaVv5MmoW9e3VoYVefiw76zctvw5E_uJjvQAhW1i1V0h9icOA6BJk4d0AjeeMpLmMd6E--jMmbA2cIejUiJHNNp_h5Y_KThMl_duXJXcoSttcI_ShJlYTInM20EWjkYIUKKzezv_yimIPv0ACQkRheqqBYV-Zx4ARs
a6285248-00ea-4a57-b007-3a61c3c3047d	9c80f8e9-1a65-4bb2-a216-b52210f9f2bf	algorithm	HS512
6e6c12eb-904f-4f97-b95d-38b14dbccc2a	1f601b2d-3f3c-4ee1-93f5-cd33a0c3c6cc	kid	3ed0052c-1007-4708-82c0-3497b75085c8
59ab45f4-971c-4e4b-8012-bbc61ab47f70	1f601b2d-3f3c-4ee1-93f5-cd33a0c3c6cc	secret	jGKBzJa7FSua3xfWVN9caQ
5282d50c-9fc7-45d1-b27b-ebeb37448dc3	1f601b2d-3f3c-4ee1-93f5-cd33a0c3c6cc	priority	100
9ceb5cb1-c9fc-40a4-ae5a-67a9bd146d0e	bf7bc4cc-455f-4d74-ac97-b854b8f126e8	allow-default-scopes	true
dbc4c4e4-aad6-438d-8a18-52933bdf8f55	82d74645-ff8e-460e-ab07-a44369c80932	priority	100
d57b3544-9b68-4bcb-8e94-2b033dc22b42	82d74645-ff8e-460e-ab07-a44369c80932	algorithm	HS512
1af25402-3f99-4a45-9d7e-34dcc196fbfc	82d74645-ff8e-460e-ab07-a44369c80932	kid	ebb575e0-6a98-447c-97e1-37c876a2e327
71c1e2de-78a9-4ec4-9707-8495c90f996d	82d74645-ff8e-460e-ab07-a44369c80932	secret	mKtc1ZS1Zure5wtquXmZDQJiuhiDEWLpBWY2phgKVV27UO-Oga5WRLy8sRhbO_zKE7UHVZDOwZRroPWvhZD2lsJ1YSaSrZb0yf_9hRKthz4JcGYdOqDVI7w76zdxtHhq9dkkCqgAmOdj7iYiYu7oBBcwd6eWuaHtnIi_q_3j8fw
48f19bdf-9fee-48f9-882a-dbd47e4721d6	4dfd41fa-a9eb-4922-a0cf-d4f7a8ae24c1	max-clients	200
2a94fae9-5e2f-486e-a845-6a95f9cd3460	2feec9eb-9647-4299-86f6-bf7d63fe6ff0	allow-default-scopes	true
66559ffa-d9bb-4b02-aa2b-2c7567ceff25	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	privateKey	MIIEpAIBAAKCAQEA1AoIizYWkAYXg2/eJllPeeS2mBypw2cx1LrPukbrAFrMHvKl+AsKKHr55oPP4n9ZHWMi0NZm9pIdBX6jm6OYsm76cB1HPUjYyxU9iwf2rj5kHOAVRon/1BBAX+v3agXQoMQM4Sski+tmFzhYZUyMJL44nZb9Vo6t2/prOh9uQuJSsaNMRpgmCcV8PwNjKv5G8pm9dvW4KSC/sDLx9VYYe+gqTDhLzu+Dh3gMoD8fMVnIw5c4ZSyWKcbkwwh8wcUVRfZJ9GsC+Zdw44o1yNgHQSFOIvIjkwyW1yLFObOJf5g55c3p9lqu4nlTwcupHkdGimV1WgX2XPnMxuK4LO/2UwIDAQABAoIBAGAzOyQZwovOT72ws9u3OmElnJgPrQ+70nZe2R78zOLIzwIdeaI7M/0gqh9k3xy2RVKZZzLTizxEF0mmZokW5JDT2+igx/Dsi3s75EOfNdJg+R/GpLBvrLNkOiiq0IH4KGq/983yum6Gurc/N4+h9pU2/k21MrQiIIwEpcBlgStzWd3TMlWmSy965bHkF/wET9RrIMR/SWIfgg7nm7lK+VGxVyJay15639EHd7x/rdp6LiBG2uIipZD+NA6WLuOZG86toDUcPas9Di9mkGm2EW3GAxaSz9T47CdJr5hcX7F5CqBn6tnbY5ssJnwi0HUF203Bc/6Z3wh7NGAyGxzMXxECgYEA/3WJ+vIU9K4JWgNFzfbz46rtCOlRgepCeYtoopfHBfkO/cxyK3/SBB1SUt5yWzp/sr6sADXl67932wuxtZozFBC+UKEUCDPK/Qs1TctG/KjS7mdgQvxXt6TpT9C+kTvyo8L9g+rdMrQ8Cs5qtajWaVv/ohMhqfWFk6Apn1p9kTECgYEA1Hz13YrVwyrkBGb0fjW2b09qS9FuLX6WDaR9WZ3GA9APTz4K+zYWtNFfUHwufhO4Z0zxxSlyaiwClRSuJFhFk4DgxB1mUv0wHtPppY8f0jKcnwS3JDL7K4DQ9T5suA21Zt9zUemrMwA+WM/TghTvXplHHtuUhv/fHYglx8QIvsMCgYEApwrOzN8bQNvEla1qKcH/vLF6Cce3WoI6MYwtQZSJuaggW2kihrswMyyRNkrq8CiSc+kmQ4T68WrkDsHY1G0eVVKVf9e0Z6CmbUy08EeqBXDHbMkAMw0atqUJQv22fvV6Ngc9CtO7DHq6gD51nI/olEBqKirkamR3kg666M6dKSECgYEAybvJgQeqYpx51mQYgypjhdITzN+MhszDkTg1ebt8n2oM3uK8cjur2wdcQoFjcncuf4RhlRoAciROX1M+8WqMw7l7qzVuTCPsZ5gxHul/AITkhWRoq4lrRKYLvIoDlcoOCxjh10bNLqJwjsjguYM+rsU+7GDz5idOoC7+D2ZiFxkCgYAns+C2iIbw4M1w3NSFeeVwVDzwSW0c45CNq8BqA1fKqjzS11zmrI5162e+zJI91uF32k1hbWAgrxZV0KuBS+NIhX0hf2nmiTMm3KrGSvx0MLwxX41qPHD9OMW35rzXdXV8scMHkFanJnqDzfTijvCRO3CTqxhnxr36ZEIsdJ7uAg==
e230754b-37fb-4433-8551-ad2b7de47eac	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	priority	100
b4af4c35-e1ab-4417-bed4-ae59264ffeab	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	certificate	MIICozCCAYsCBgGaaGXlZzANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDApsb2NpLXJlYWxtMB4XDTI1MTEwOTExMzMxOVoXDTM1MTEwOTExMzQ1OVowFTETMBEGA1UEAwwKbG9jaS1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANQKCIs2FpAGF4Nv3iZZT3nktpgcqcNnMdS6z7pG6wBazB7ypfgLCih6+eaDz+J/WR1jItDWZvaSHQV+o5ujmLJu+nAdRz1I2MsVPYsH9q4+ZBzgFUaJ/9QQQF/r92oF0KDEDOErJIvrZhc4WGVMjCS+OJ2W/VaOrdv6azofbkLiUrGjTEaYJgnFfD8DYyr+RvKZvXb1uCkgv7Ay8fVWGHvoKkw4S87vg4d4DKA/HzFZyMOXOGUslinG5MMIfMHFFUX2SfRrAvmXcOOKNcjYB0EhTiLyI5MMltcixTmziX+YOeXN6fZaruJ5U8HLqR5HRopldVoF9lz5zMbiuCzv9lMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAkYztEr6baQvXYMCHk+ERJKvcAcPC+vJem/CbgAPvkVafToIUxnGOJbLU/MjZMqt2qLxwwfYtcucylE8PoqfjKhW7rImCJPQjezrPtoWoDPzEJ7JCxWoWTlpjSvlprf6zBTt+0YQ1by8OpMK+6WRvJtoNOqzzodpQ9DaqXWYxJegfU5F7bK9pVTyT3J46SIydmnX8Lfwsu+4j5W0kl91DuN1kxLb1294TogP0ERfTtCI+r8KFHGc+1SbizF1bCbpeT9VBWcfSBhyGh1UhgCsSPl9R+9xIRKPoIMmaGZ77pjJ/P7AFvu4LXa5DKgMcAsE0K84fIvC2Xa9phDjNN3zXiQ==
817d6ec9-06e2-4b50-9210-9d171dea6b2e	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	algorithm	RSA-OAEP
61f4cac5-f743-47c9-8f88-076f49ead32c	1d42272d-82a4-4f7b-aa8a-02e0a91d8c71	keyUse	ENC
16ada788-68cd-442d-90e5-a23c4186e245	501abdae-a433-4e54-985a-a9fdf84bf3b8	privateKey	MIIEoAIBAAKCAQEAurT5Qp6fpzYk5s0r5rvsltqBiyMI1fI5ag2XO6Un6gnbuhJMt84ylKEU0QlT844Wmp2+iWwwklGHz6j1NSsqFYXUyTDLXukpsLfFR5fzcetWJ3FNiwQGRuodRRHFh9pvh85gPkFSRvSI6iSqSrYNSjDClEpEjH5S9Mn8UgETFlsHrqsBQCLFGOxUzuUNEe7txAT7dkSGGxZKd+qyxZGFLxnn4PT6Pc82qN8f5ZS6zkKHjCk+zea6IcdLbpmnNnoThRrMdmDfZDHLiRKrX/wHbhy+dm+K5Z+qj+/+d6+G29PgXb7z8i06YEFyYllDlzUt8pW2+eCmzZjywJcmALwbJQIDAQABAoH/MTI09Wqj60VjL2N9sbFtbgt+FuwVI3/sradl2WC/kKw9jSzVtpFcrkvnACD45KjQZ9Pzp8OEC29R04v9nos6yu/EvvKdxMxm3rov0eA/pcJLOsW+ioodA/Vn5HykSOhkLuh7x0l0EPI1tG/be+2JI2jMiPzvbk1hR39jl5rjkqxWbxwtZw0W9zY37rR2GXwmHdFbYQgDXf73MeE6/K6bbQa6sxvSftyf/W0nTDpVPWtLtdbWb2R1zLWbwslz3rhgdkWGJ/1HakIqunHW6O5eoiG/x345aqp9zo7HuJVG5+tsLfG0zQcxvRxgWSuiMZ5MLz6gdqMBga9wQPDL9WWNAoGBAO8qyXzb136/Elncs8knoIQgdMREoAw0YIZWvQB3m3swN2G9WE2oZJm/ObEAlLlIuu/ngPna/N6MYcePqt5jL4I2sMts5SGF2nP68Ta0TQ+Lldk8jklqnO5OEKNmoQklRWcIa9yBrgWn0lE6y8cYm5fMqXN8P2+/Y5HoKUPtGL5DAoGBAMfY+wpH4mAZ9OYu53BIOQdjqVw/YxKFxNky+YGfuAB+Jy+qoivGVgPnwq+YBsfVmpoB+HEl+Chyj0DHwFueXkJ+8Wcoo39/1DZ2zhnSIRNQfDNOfcfamuz2wsmlChoy+TfqHvUftCrvHOQ7Hu7+fUTBt/X9xoy/KEj9xKQVnA53AoGAMYhWBHLvdYOTBGNuJLn9R4AFTuS7lOuAFjJ+oEslO2UoAykY0bSPaTwucZciNiF2/dqfXp/ZASpn0dHSXI6EN16mTOs3pTK4pI6TSHYdA5wwI7aj7VaUO9KVJZJKxb8fWZBn7lo5NVileUdJDunsx4qOialw5e7oaz5+1V+UYUsCgYBAnEHtPPhPIZUvphJlFrR5Uxs6G7QoFN9jaTuJUN3oKuD4ZC4yANlmQdOLeZcXnFNzXxe3XRMx4He39dyWwkivLuNU+qqBWg593UMczfari+XboJDBwEc+PTkUgCsX9UrlbOe9UBarmsq4bvS9R8GwLQEQoo9Cibq4fnLIqcPeWQKBgAfVN/KUA2Fmh3Sjv8T1vdbkVo5Qsgbe9TeLbduBNqL3GunExhuLVg5tgsIkDDbSA8RuWoHrSqbIsYiRcIH9yPn5X13NM/uir0UrLu963opWpN0b9lftUbeByyY2gAUq6l9bGWb0RWSCXIPeB6F4HAa8vM2h5WadRv+SWQ2Gu/YR
829d2abb-39de-4c24-b0cc-2fb0cd70ee90	501abdae-a433-4e54-985a-a9fdf84bf3b8	keyUse	SIG
6303b92f-814f-4a10-b7c8-aeccfee2d97a	501abdae-a433-4e54-985a-a9fdf84bf3b8	certificate	MIICozCCAYsCBgGaaGXjJjANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDApsb2NpLXJlYWxtMB4XDTI1MTEwOTExMzMxOVoXDTM1MTEwOTExMzQ1OVowFTETMBEGA1UEAwwKbG9jaS1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALq0+UKen6c2JObNK+a77JbagYsjCNXyOWoNlzulJ+oJ27oSTLfOMpShFNEJU/OOFpqdvolsMJJRh8+o9TUrKhWF1Mkwy17pKbC3xUeX83HrVidxTYsEBkbqHUURxYfab4fOYD5BUkb0iOokqkq2DUowwpRKRIx+UvTJ/FIBExZbB66rAUAixRjsVM7lDRHu7cQE+3ZEhhsWSnfqssWRhS8Z5+D0+j3PNqjfH+WUus5Ch4wpPs3muiHHS26ZpzZ6E4UazHZg32Qxy4kSq1/8B24cvnZviuWfqo/v/nevhtvT4F2+8/ItOmBBcmJZQ5c1LfKVtvngps2Y8sCXJgC8GyUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAjNmlykEGuC6D4Gd90FsdRSFnxyKHMfRv7mjBXhjm6uH3RnVx0IiXlb80n2mWJBfXaEV+z6OcmOii1dlSR3+QvsfxnmKUTu6OMD8hqKmAvcBrK87XWPU3VrU+1clnG/AvuhzTMfx+SyptkeyH9nGfbxec2Pk86dc4qJTr6y5qkv6kP9K5wHZPSo0qVxhnk81N+dLl+h9sxgZSY2LkH+WwcQXN36YUWxG7RUZYm9JCxw5utJCPILspDxqKLI4R6gxJ9uV/UBhhqAkaEP0qR2oKmOwxJVwCr4O2WPbU15P2L9h/69za69ipgxRDiSerDoNOvLq4C3O4hJ607ktYIHLzIw==
0361941a-16a4-4a83-9a03-73eef805aef5	501abdae-a433-4e54-985a-a9fdf84bf3b8	priority	100
233652b6-f780-48f2-8ae1-e53cbb0b7e0d	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-full-name-mapper
44da4cf7-d507-4316-bf1b-562062f4132c	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
28c03b82-22e3-4d40-8e08-99e62dea7b19	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	saml-user-attribute-mapper
8cbd8d90-7e1a-490a-9721-c6cd9ebe1f92	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
91002348-c042-4dad-957a-130bd1703a65	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	saml-role-list-mapper
88aea40f-711c-4c3b-a99c-206c3402b74f	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a0560eac-9fab-4128-8978-e22b33a8346f	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	oidc-address-mapper
ec85450e-5e09-4519-a272-bea25c23e698	f76d02eb-db36-4cc1-860e-363ac63254ab	allowed-protocol-mapper-types	saml-user-property-mapper
8c008cfa-1b0f-4de8-ad9b-e6a767741e35	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	saml-user-property-mapper
5d076f5e-8b49-4862-9a87-8eea11e4718c	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
58fc8bb4-32ea-453f-8899-6d005f663d4d	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-address-mapper
c4b8225b-a6f1-4df5-93c7-b5f1f8b92d4f	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
16df2d85-b774-4dab-a610-bd838dfc3480	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-full-name-mapper
f9e50d4e-ac60-4960-ad0b-11a49bedaf31	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2e7545fc-a7b2-4ef1-8097-9382b7919f86	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	saml-user-attribute-mapper
c7222031-3cb8-44ee-815c-15088f3b6ced	6957a15d-2473-4793-90cf-bf7923e35fe2	allowed-protocol-mapper-types	saml-role-list-mapper
612f4d75-a5c3-4313-a9a3-9d803859bbe5	aa39d65d-762c-4690-9154-219710f831f1	host-sending-registration-request-must-match	true
f301944a-ae1e-43cc-89da-f1f26376e043	aa39d65d-762c-4690-9154-219710f831f1	client-uris-must-match	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.composite_role (composite, child_role) FROM stdin;
279f5398-070e-4796-ae4a-003fb8a1388f	b1c77e06-0a57-49a2-bb98-09e509c55b8a
279f5398-070e-4796-ae4a-003fb8a1388f	36803ff9-78af-4de1-bfb8-f5a6af8ad0bd
279f5398-070e-4796-ae4a-003fb8a1388f	6420d8c9-6379-42ce-8df4-eb8c62dea0b6
279f5398-070e-4796-ae4a-003fb8a1388f	79be8124-e03b-457b-9951-2b02767d01e8
279f5398-070e-4796-ae4a-003fb8a1388f	1c7185c7-e707-4ce4-94dd-2169107741e1
279f5398-070e-4796-ae4a-003fb8a1388f	a7642d23-295d-4897-aed3-6f4afff34f69
279f5398-070e-4796-ae4a-003fb8a1388f	aa90475a-9047-4de4-bd22-080f56b9e27b
279f5398-070e-4796-ae4a-003fb8a1388f	948e7f75-63f1-4467-8f8e-8a1bf77d9de7
279f5398-070e-4796-ae4a-003fb8a1388f	d8668181-20a2-46d6-93a9-2fac24601b99
279f5398-070e-4796-ae4a-003fb8a1388f	feda68d9-57d7-40b7-a248-d640bdc822b6
279f5398-070e-4796-ae4a-003fb8a1388f	485360eb-14f0-4740-8d7f-50a76f702d6b
279f5398-070e-4796-ae4a-003fb8a1388f	2d5b47bc-db88-4ffd-8c9f-07aa420d6438
279f5398-070e-4796-ae4a-003fb8a1388f	44fc6853-7bd4-42f6-a809-b17ad804d2c4
279f5398-070e-4796-ae4a-003fb8a1388f	f53ac2f6-169f-4f88-a811-747b393f8e1d
279f5398-070e-4796-ae4a-003fb8a1388f	2820ae94-4972-4931-86a3-f8fa529692df
279f5398-070e-4796-ae4a-003fb8a1388f	71dffbb7-1b66-4efe-ad9b-ac9f2b015980
279f5398-070e-4796-ae4a-003fb8a1388f	72ed3b63-52e6-4314-a975-2b428610b21f
279f5398-070e-4796-ae4a-003fb8a1388f	7cac1614-5fb6-4295-a536-d8049d0ec17d
1c7185c7-e707-4ce4-94dd-2169107741e1	71dffbb7-1b66-4efe-ad9b-ac9f2b015980
79be8124-e03b-457b-9951-2b02767d01e8	7cac1614-5fb6-4295-a536-d8049d0ec17d
79be8124-e03b-457b-9951-2b02767d01e8	2820ae94-4972-4931-86a3-f8fa529692df
950def63-2e92-4028-8412-21e2800e4066	b98253a5-80b1-40f9-b5e9-a1f9321b205c
950def63-2e92-4028-8412-21e2800e4066	bb3d5d86-39aa-40de-b44a-8efb2e2fb85a
bb3d5d86-39aa-40de-b44a-8efb2e2fb85a	af2ddb6c-378a-4900-ad3c-320f5362f091
d61be6e8-338b-4b34-b93f-2c4a9cc7c004	24d011c0-561f-497b-bd3d-fe56b7d57eb6
279f5398-070e-4796-ae4a-003fb8a1388f	314a1a84-b1dc-4df2-8dfd-c2e514b49c25
950def63-2e92-4028-8412-21e2800e4066	ee52eca1-05c8-48a7-9dd0-ac1e0a637b0c
950def63-2e92-4028-8412-21e2800e4066	d7ecb069-c37d-42a8-a928-e08dace56256
279f5398-070e-4796-ae4a-003fb8a1388f	54f5ec0a-e52c-457a-9f2b-f8da99c0a49e
279f5398-070e-4796-ae4a-003fb8a1388f	9dcd6a87-4600-417e-9ab2-b9bdd2acf2cb
279f5398-070e-4796-ae4a-003fb8a1388f	ba4d99ee-e74f-4bed-b2e9-b200bdb95251
279f5398-070e-4796-ae4a-003fb8a1388f	723b6214-08e8-4c66-af60-6f2a6990417f
279f5398-070e-4796-ae4a-003fb8a1388f	350c9c33-fe1c-4f17-a224-387d870c958d
279f5398-070e-4796-ae4a-003fb8a1388f	0c8c2455-3163-431c-818c-199ede720382
279f5398-070e-4796-ae4a-003fb8a1388f	8d2b3dad-05ea-4933-ba67-fab56ce083a6
279f5398-070e-4796-ae4a-003fb8a1388f	e5e7fa93-da6a-4584-a270-6690cf9a3102
279f5398-070e-4796-ae4a-003fb8a1388f	7dc5809e-4b0e-4d2f-b298-b8b856e31877
279f5398-070e-4796-ae4a-003fb8a1388f	5e06dfb6-4e10-4bc5-b626-02aee37397b5
279f5398-070e-4796-ae4a-003fb8a1388f	87727843-0612-4a32-835e-8786a8578dc8
279f5398-070e-4796-ae4a-003fb8a1388f	00d8e0da-df6b-42e3-932b-5446c6505a14
279f5398-070e-4796-ae4a-003fb8a1388f	2274c69d-0757-4150-bb21-0ebc5fdc0db0
279f5398-070e-4796-ae4a-003fb8a1388f	058bf77b-07fa-4c07-818d-1e4e49fca3c8
279f5398-070e-4796-ae4a-003fb8a1388f	3809a34e-770a-4aaf-b562-9722bb4e57c4
279f5398-070e-4796-ae4a-003fb8a1388f	2ae77a1f-f5fe-41cc-b65c-72af82c9143a
279f5398-070e-4796-ae4a-003fb8a1388f	1de75c32-1f49-4e4f-b467-8abf14381018
723b6214-08e8-4c66-af60-6f2a6990417f	3809a34e-770a-4aaf-b562-9722bb4e57c4
ba4d99ee-e74f-4bed-b2e9-b200bdb95251	1de75c32-1f49-4e4f-b467-8abf14381018
ba4d99ee-e74f-4bed-b2e9-b200bdb95251	058bf77b-07fa-4c07-818d-1e4e49fca3c8
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
279f5398-070e-4796-ae4a-003fb8a1388f	d42796dd-ce6d-466e-b473-086f6878e2ed
\.


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.contact (id, created_date, last_modified_date, blocked_by, contact_user_id, user_id) FROM stdin;
\.


--
-- Data for Name: contact_request; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.contact_request (id, created_date, last_modified_date, receiver_user_id, request_user_id) FROM stdin;
\.


--
-- Data for Name: conversation_participant; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.conversation_participant (id, created_date, last_modified_date, joined_at, last_read_message_id, role, conversation_id, user_id) FROM stdin;
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.conversations (id, created_date, last_modified_date, creator_id, deleted, group_name, group_profile_picture, last_message_id, updated_at) FROM stdin;
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
3f41a20d-1245-48cc-acc0-8b2461e6e3a9	\N	password	709bb742-5f72-4760-a72d-25123640703e	1764842413755	\N	{"value":"HbleKdMf4qqR4UL8pctoY5oxE18xi5C6V5azQVmLjL4=","salt":"6LDxd00L5uVTutBFx/vSxg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-12-04 09:59:15.513917	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	4842351890
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-12-04 09:59:15.709454	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	4842351890
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-12-04 09:59:16.050212	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	4842351890
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-12-04 09:59:16.0751	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	4842351890
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-12-04 09:59:16.661695	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	4842351890
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-12-04 09:59:16.724906	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	4842351890
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-12-04 09:59:17.520293	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	4842351890
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-12-04 09:59:17.573667	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	4842351890
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-12-04 09:59:17.651	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	4842351890
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-12-04 09:59:18.356632	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	4842351890
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-12-04 09:59:18.767639	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	4842351890
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-12-04 09:59:18.827933	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	4842351890
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-12-04 09:59:18.986493	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	4842351890
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-12-04 09:59:19.089444	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	4842351890
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-12-04 09:59:19.098811	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	4842351890
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-12-04 09:59:19.118328	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	4842351890
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-12-04 09:59:19.14993	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	4842351890
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-12-04 09:59:19.645296	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	4842351890
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-12-04 09:59:19.914784	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	4842351890
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-12-04 09:59:19.950285	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	4842351890
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-12-04 09:59:47.73316	144	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	4842351890
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-12-04 09:59:20.004992	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	4842351890
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-12-04 09:59:20.029335	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	4842351890
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-12-04 09:59:20.98973	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	4842351890
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-12-04 09:59:21.028201	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	4842351890
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-12-04 09:59:21.035187	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	4842351890
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-12-04 09:59:24.715212	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	4842351890
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-12-04 09:59:25.072274	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	4842351890
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-12-04 09:59:25.092302	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	4842351890
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-12-04 09:59:25.346782	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	4842351890
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-12-04 09:59:25.458922	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	4842351890
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-12-04 09:59:25.582787	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	4842351890
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-12-04 09:59:25.604231	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	4842351890
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-12-04 09:59:25.657817	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	4842351890
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-12-04 09:59:25.754213	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	4842351890
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-12-04 09:59:25.999121	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	4842351890
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-12-04 09:59:26.044991	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	4842351890
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-12-04 09:59:26.069159	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	4842351890
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-12-04 09:59:26.120828	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	4842351890
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-12-04 09:59:26.15627	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	4842351890
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-12-04 09:59:26.166412	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	4842351890
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-12-04 09:59:26.190555	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	4842351890
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-12-04 09:59:26.223011	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	4842351890
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-12-04 09:59:37.428489	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	4842351890
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-12-04 09:59:37.446706	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	4842351890
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-12-04 09:59:37.468397	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	4842351890
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-12-04 09:59:37.489842	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	4842351890
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-12-04 09:59:37.496999	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	4842351890
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-12-04 09:59:38.010374	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	4842351890
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-12-04 09:59:38.026135	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	4842351890
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-12-04 09:59:38.11229	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	4842351890
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-12-04 09:59:39.945226	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	4842351890
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-12-04 09:59:39.961346	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	4842351890
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-12-04 09:59:39.971385	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	4842351890
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-12-04 09:59:39.981019	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	4842351890
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-12-04 09:59:39.99914	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	4842351890
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-12-04 09:59:40.013332	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	4842351890
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-12-04 09:59:40.231395	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	4842351890
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-12-04 09:59:41.804235	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	4842351890
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-12-04 09:59:41.860107	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	4842351890
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-12-04 09:59:41.876415	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	4842351890
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-12-04 09:59:41.901677	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	4842351890
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-12-04 09:59:41.914056	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	4842351890
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-12-04 09:59:41.926898	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	4842351890
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-12-04 09:59:41.936627	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	4842351890
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-12-04 09:59:41.948241	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	4842351890
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-12-04 09:59:42.093878	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	4842351890
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-12-04 09:59:42.268884	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	4842351890
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-12-04 09:59:42.286664	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	4842351890
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-12-04 09:59:42.526645	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	4842351890
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-12-04 09:59:42.555956	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	4842351890
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-12-04 09:59:42.574124	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	4842351890
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-12-04 09:59:42.608355	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	4842351890
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-12-04 09:59:42.642375	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	4842351890
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-12-04 09:59:42.662137	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	4842351890
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-12-04 09:59:42.758169	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	4842351890
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-12-04 09:59:43.012814	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	4842351890
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-12-04 09:59:43.025104	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	4842351890
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-12-04 09:59:43.029748	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	4842351890
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-12-04 09:59:43.088751	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	4842351890
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-12-04 09:59:43.094232	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	4842351890
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-12-04 09:59:43.263596	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	4842351890
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-12-04 09:59:43.267823	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	4842351890
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-12-04 09:59:43.285147	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	4842351890
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-12-04 09:59:43.289672	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	4842351890
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-12-04 09:59:43.491341	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	4842351890
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-12-04 09:59:43.51275	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	4842351890
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-12-04 09:59:43.544681	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	4842351890
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-12-04 09:59:43.56706	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	4842351890
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-12-04 09:59:43.591008	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	4842351890
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-12-04 09:59:43.619905	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	4842351890
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-12-04 09:59:43.798639	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	4842351890
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-12-04 09:59:43.82956	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	4842351890
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-12-04 09:59:43.834511	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	4842351890
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-12-04 09:59:43.859782	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	4842351890
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-12-04 09:59:43.865366	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	4842351890
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-12-04 09:59:43.885756	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	4842351890
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-12-04 09:59:44.300193	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	4842351890
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-12-04 09:59:44.305036	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	4842351890
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-12-04 09:59:44.33994	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	4842351890
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-12-04 09:59:44.563301	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	4842351890
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-12-04 09:59:44.568509	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	4842351890
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-12-04 09:59:44.808548	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	4842351890
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-12-04 09:59:44.825214	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	4842351890
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-12-04 09:59:44.849298	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	4842351890
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-12-04 09:59:45.017754	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	4842351890
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-12-04 09:59:45.28161	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	4842351890
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-12-04 09:59:45.454682	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	4842351890
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-12-04 09:59:45.4693	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	4842351890
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-12-04 09:59:45.650778	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	4842351890
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-12-04 09:59:45.656095	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	4842351890
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-12-04 09:59:45.679192	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	4842351890
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-12-04 09:59:45.695016	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	4842351890
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-12-04 09:59:45.728372	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	4842351890
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-12-04 09:59:45.736923	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	4842351890
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-12-04 09:59:45.752976	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	4842351890
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-12-04 09:59:45.758479	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	4842351890
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-12-04 09:59:45.779478	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	4842351890
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-12-04 09:59:45.789022	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	4842351890
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-12-04 09:59:46.254512	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	4842351890
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-12-04 09:59:46.265372	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	4842351890
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-12-04 09:59:46.282818	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	4842351890
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-12-04 09:59:46.416371	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	4842351890
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-12-04 09:59:46.427789	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	4842351890
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-12-04 09:59:46.432554	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	4842351890
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-12-04 09:59:46.437883	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	4842351890
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-12-04 09:59:46.453683	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	4842351890
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-12-04 09:59:46.592489	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	4842351890
25.0.0-28265-index-cleanup	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-12-04 09:59:46.610477	128	EXECUTED	9:8c0cfa341a0474385b324f5c4b2dfcc1	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...		\N	4.29.1	\N	\N	4842351890
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-12-04 09:59:46.616624	129	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	4842351890
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-12-04 09:59:46.755745	130	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	4842351890
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-12-04 09:59:46.786708	131	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	4842351890
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-12-04 09:59:46.81198	132	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	4842351890
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-12-04 09:59:46.818938	133	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	4842351890
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-12-04 09:59:47.12225	134	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	4842351890
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-12-04 09:59:47.138919	135	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	4842351890
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-12-04 09:59:47.159575	136	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	4842351890
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-12-04 09:59:47.282103	137	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	4842351890
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-12-04 09:59:47.297653	138	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	4842351890
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-12-04 09:59:47.312332	139	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	4842351890
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-12-04 09:59:47.439744	140	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	4842351890
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-12-04 09:59:47.664763	141	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	4842351890
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-12-04 09:59:47.676978	142	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	4842351890
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-12-04 09:59:47.723249	143	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	4842351890
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
04091393-f3f9-4303-ba2b-e7530a9d7711	3f91aa0b-03fc-4f80-a2ea-f1b18e99d7ee	f
04091393-f3f9-4303-ba2b-e7530a9d7711	d21970ae-3d0a-46fd-bc59-6dffee6c6e73	t
04091393-f3f9-4303-ba2b-e7530a9d7711	c01a79bf-5a56-41db-88fd-a9234216adde	t
04091393-f3f9-4303-ba2b-e7530a9d7711	dbf413af-a311-4102-9b8a-98c05dc655b7	t
04091393-f3f9-4303-ba2b-e7530a9d7711	dcd07cb6-ef1d-48b2-8747-88ad3946ee0e	t
04091393-f3f9-4303-ba2b-e7530a9d7711	24a82def-b835-4f28-977c-aa2a3d1a7b88	f
04091393-f3f9-4303-ba2b-e7530a9d7711	76ec706b-d4ab-4f9b-8156-47ea9af0e318	f
04091393-f3f9-4303-ba2b-e7530a9d7711	5a5f5802-cb3f-4af0-a317-92f38e7434d6	t
04091393-f3f9-4303-ba2b-e7530a9d7711	5ae7e88a-bf7d-4f78-93ea-1958d6ee8ddd	t
04091393-f3f9-4303-ba2b-e7530a9d7711	d672ef9a-bcca-49ec-998e-d46dbddd2672	f
04091393-f3f9-4303-ba2b-e7530a9d7711	e6fa5c3d-7a27-4adf-a573-07831135026f	t
04091393-f3f9-4303-ba2b-e7530a9d7711	63e8ae03-b467-4422-8cb6-322ea262065f	t
04091393-f3f9-4303-ba2b-e7530a9d7711	2e5b32a3-cde4-49f5-9337-13443b4ba420	f
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
1	1	baseline	SQL	V1__baseline.sql	1424966011	admin	2025-12-04 16:41:15.271228	49	t
2	2	add username and image profile field	SQL	V2__add_username_and_image_profile_field.sql	763788717	admin	2025-12-04 16:41:15.355387	8	t
3	3	messaging feature	SQL	V3__messaging_feature.sql	-1176925429	admin	2025-12-04 16:51:30.498467	108	t
\.


--
-- Data for Name: group_; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.group_ (id, created_date, last_modified_date, group_name, group_profile_picture, last_active, conversation_id) FROM stdin;
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
950def63-2e92-4028-8412-21e2800e4066	04091393-f3f9-4303-ba2b-e7530a9d7711	f	${role_default-roles}	default-roles-master	04091393-f3f9-4303-ba2b-e7530a9d7711	\N	\N
279f5398-070e-4796-ae4a-003fb8a1388f	04091393-f3f9-4303-ba2b-e7530a9d7711	f	${role_admin}	admin	04091393-f3f9-4303-ba2b-e7530a9d7711	\N	\N
b1c77e06-0a57-49a2-bb98-09e509c55b8a	04091393-f3f9-4303-ba2b-e7530a9d7711	f	${role_create-realm}	create-realm	04091393-f3f9-4303-ba2b-e7530a9d7711	\N	\N
36803ff9-78af-4de1-bfb8-f5a6af8ad0bd	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_create-client}	create-client	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
6420d8c9-6379-42ce-8df4-eb8c62dea0b6	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_view-realm}	view-realm	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
79be8124-e03b-457b-9951-2b02767d01e8	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_view-users}	view-users	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
1c7185c7-e707-4ce4-94dd-2169107741e1	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_view-clients}	view-clients	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
a7642d23-295d-4897-aed3-6f4afff34f69	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_view-events}	view-events	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
aa90475a-9047-4de4-bd22-080f56b9e27b	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_view-identity-providers}	view-identity-providers	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
948e7f75-63f1-4467-8f8e-8a1bf77d9de7	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_view-authorization}	view-authorization	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
d8668181-20a2-46d6-93a9-2fac24601b99	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_manage-realm}	manage-realm	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
feda68d9-57d7-40b7-a248-d640bdc822b6	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_manage-users}	manage-users	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
485360eb-14f0-4740-8d7f-50a76f702d6b	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_manage-clients}	manage-clients	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
2d5b47bc-db88-4ffd-8c9f-07aa420d6438	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_manage-events}	manage-events	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
44fc6853-7bd4-42f6-a809-b17ad804d2c4	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_manage-identity-providers}	manage-identity-providers	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
f53ac2f6-169f-4f88-a811-747b393f8e1d	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_manage-authorization}	manage-authorization	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
2820ae94-4972-4931-86a3-f8fa529692df	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_query-users}	query-users	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
71dffbb7-1b66-4efe-ad9b-ac9f2b015980	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_query-clients}	query-clients	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
72ed3b63-52e6-4314-a975-2b428610b21f	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_query-realms}	query-realms	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
7cac1614-5fb6-4295-a536-d8049d0ec17d	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_query-groups}	query-groups	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
b98253a5-80b1-40f9-b5e9-a1f9321b205c	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	t	${role_view-profile}	view-profile	04091393-f3f9-4303-ba2b-e7530a9d7711	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	\N
bb3d5d86-39aa-40de-b44a-8efb2e2fb85a	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	t	${role_manage-account}	manage-account	04091393-f3f9-4303-ba2b-e7530a9d7711	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	\N
af2ddb6c-378a-4900-ad3c-320f5362f091	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	t	${role_manage-account-links}	manage-account-links	04091393-f3f9-4303-ba2b-e7530a9d7711	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	\N
f9a7c502-f611-4c65-9ff5-186b2780f43d	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	t	${role_view-applications}	view-applications	04091393-f3f9-4303-ba2b-e7530a9d7711	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	\N
24d011c0-561f-497b-bd3d-fe56b7d57eb6	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	t	${role_view-consent}	view-consent	04091393-f3f9-4303-ba2b-e7530a9d7711	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	\N
d61be6e8-338b-4b34-b93f-2c4a9cc7c004	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	t	${role_manage-consent}	manage-consent	04091393-f3f9-4303-ba2b-e7530a9d7711	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	\N
54d1d08d-1825-4ad2-9da8-1f748a78ad70	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	t	${role_view-groups}	view-groups	04091393-f3f9-4303-ba2b-e7530a9d7711	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	\N
7d1c29ec-266b-4eeb-9143-9c74522a67fb	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	t	${role_delete-account}	delete-account	04091393-f3f9-4303-ba2b-e7530a9d7711	74791b5a-ba3c-44a7-b0d3-87e327bda6a8	\N
89d7925b-b6e4-4eb5-819c-cac005871179	9e099ae8-44d5-466e-ab9b-a04e86231b9c	t	${role_read-token}	read-token	04091393-f3f9-4303-ba2b-e7530a9d7711	9e099ae8-44d5-466e-ab9b-a04e86231b9c	\N
314a1a84-b1dc-4df2-8dfd-c2e514b49c25	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	t	${role_impersonation}	impersonation	04091393-f3f9-4303-ba2b-e7530a9d7711	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	\N
ee52eca1-05c8-48a7-9dd0-ac1e0a637b0c	04091393-f3f9-4303-ba2b-e7530a9d7711	f	${role_offline-access}	offline_access	04091393-f3f9-4303-ba2b-e7530a9d7711	\N	\N
d7ecb069-c37d-42a8-a928-e08dace56256	04091393-f3f9-4303-ba2b-e7530a9d7711	f	${role_uma_authorization}	uma_authorization	04091393-f3f9-4303-ba2b-e7530a9d7711	\N	\N
929392ee-0474-4ed0-a64e-9b0132025c91	83b6664d-539e-4bed-a376-685d50e40b98	f	${role_default-roles}	default-roles-loci-realm	83b6664d-539e-4bed-a376-685d50e40b98	\N	\N
54f5ec0a-e52c-457a-9f2b-f8da99c0a49e	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_create-client}	create-client	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
9dcd6a87-4600-417e-9ab2-b9bdd2acf2cb	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_view-realm}	view-realm	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
ba4d99ee-e74f-4bed-b2e9-b200bdb95251	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_view-users}	view-users	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
723b6214-08e8-4c66-af60-6f2a6990417f	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_view-clients}	view-clients	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
350c9c33-fe1c-4f17-a224-387d870c958d	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_view-events}	view-events	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
0c8c2455-3163-431c-818c-199ede720382	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_view-identity-providers}	view-identity-providers	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
8d2b3dad-05ea-4933-ba67-fab56ce083a6	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_view-authorization}	view-authorization	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
e5e7fa93-da6a-4584-a270-6690cf9a3102	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_manage-realm}	manage-realm	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
7dc5809e-4b0e-4d2f-b298-b8b856e31877	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_manage-users}	manage-users	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
5e06dfb6-4e10-4bc5-b626-02aee37397b5	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_manage-clients}	manage-clients	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
87727843-0612-4a32-835e-8786a8578dc8	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_manage-events}	manage-events	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
00d8e0da-df6b-42e3-932b-5446c6505a14	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_manage-identity-providers}	manage-identity-providers	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
2274c69d-0757-4150-bb21-0ebc5fdc0db0	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_manage-authorization}	manage-authorization	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
058bf77b-07fa-4c07-818d-1e4e49fca3c8	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_query-users}	query-users	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
3809a34e-770a-4aaf-b562-9722bb4e57c4	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_query-clients}	query-clients	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
2ae77a1f-f5fe-41cc-b65c-72af82c9143a	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_query-realms}	query-realms	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
1de75c32-1f49-4e4f-b467-8abf14381018	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_query-groups}	query-groups	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
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
d42796dd-ce6d-466e-b473-086f6878e2ed	cf811709-122d-4121-97ba-0faecd4dd786	t	${role_impersonation}	impersonation	04091393-f3f9-4303-ba2b-e7530a9d7711	cf811709-122d-4121-97ba-0faecd4dd786	\N
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.message (id, created_date, last_modified_date, content, deleted, delivered_at, media_url, read_at, reply_to_message_id, sent_at, status, type, conversation_id, sender_id) FROM stdin;
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.migration_model (id, version, update_time) FROM stdin;
bv0l1	26.0.0	1764842389
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.notification (id, created_date, last_modified_date, content, message_thumbnail, read_at, user_id) FROM stdin;
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
c2fab68a-2f9e-4fe3-b1be-1aa67f53a4b0	1946f9ea-72fe-4697-bf83-3dec92a8f8ee	0	1764900866	{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/","notes":{"clientId":"1946f9ea-72fe-4697-bf83-3dec92a8f8ee","iss":"http://localhost:9090/realms/loci-realm","startedAt":"1764898073","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"701f2f70-0ddd-4096-afe8-c7493c070fb6","response_mode":"fragment","scope":"openid","userSessionStartedAt":"1764898072","redirect_uri":"http://localhost:4200/","state":"e86b5025-e27f-4c08-aec9-7467e894af65","code_challenge":"WvnJ7nbh4X2mT05G0ImVVp214Cc9ygUQeEWNpcfba2Q","SSO_AUTH":"true"}}	local	local	21
b60b038e-225e-4f80-8841-c183f420dad2	1946f9ea-72fe-4697-bf83-3dec92a8f8ee	0	1764901130	{"authMethod":"openid-connect","redirectUri":"http://localhost:4200/","notes":{"clientId":"1946f9ea-72fe-4697-bf83-3dec92a8f8ee","iss":"http://localhost:9090/realms/loci-realm","startedAt":"1764901130","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"ff54aa27-49ed-4ddf-b4f9-20a8b4c0e9a4","response_mode":"fragment","scope":"openid","userSessionStartedAt":"1764901130","redirect_uri":"http://localhost:4200/","state":"5991453d-c630-43e6-ba04-ee7df85dcdb0","code_challenge":"m1oAMQ2c7eIrxJEBhRId5pRq8uq4JpXCvmthFBic1kM"}}	local	local	0
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
b60b038e-225e-4f80-8841-c183f420dad2	7b0afce6-4207-467a-9e67-e013d8f70566	83b6664d-539e-4bed-a376-685d50e40b98	1764901130	0	{"ipAddress":"172.24.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjQuMC4xIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiQ2hyb21lLzE0MS4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1764901130","authenticators-completed":"{\\"bb55b438-dd9d-4f0d-ada3-8a7e8e608f0e\\":1764901130}"},"state":"LOGGED_IN"}	1764901130	\N	0
c2fab68a-2f9e-4fe3-b1be-1aa67f53a4b0	cd2e474a-f099-4cce-ac9f-4d047fd00a01	83b6664d-539e-4bed-a376-685d50e40b98	1764898072	0	{"ipAddress":"172.24.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMjQuMC4xIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiRmlyZWZveC8xNDMuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1764898073","authenticators-completed":"{\\"bb55b438-dd9d-4f0d-ada3-8a7e8e608f0e\\":1764898072,\\"44b87570-c4f3-4195-9c9a-50c5b1c8ac9e\\":1764900863}"},"state":"LOGGED_IN"}	1764900866	\N	21
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
b896281e-0bc4-4eb1-8059-4f391ff82a54	audience resolve	openid-connect	oidc-audience-resolve-mapper	c1a49c59-3bc3-4393-8b8e-71b7ea921d98	\N
b66bcc08-4a90-45ec-99c4-e8dd17606bb2	locale	openid-connect	oidc-usermodel-attribute-mapper	190691f2-8063-4df4-a638-478d961bda4f	\N
835cd101-30a3-498c-a587-8f1d1a23ae3f	role list	saml	saml-role-list-mapper	\N	d21970ae-3d0a-46fd-bc59-6dffee6c6e73
05080593-1a44-447f-a373-e4328bc1b044	organization	saml	saml-organization-membership-mapper	\N	c01a79bf-5a56-41db-88fd-a9234216adde
cf5a5fac-4d45-4782-84cf-b1e2b77de640	full name	openid-connect	oidc-full-name-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
693404c6-d637-4314-80c1-2d5d49b0ba66	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
f1122d5a-cafb-4ee2-a4cf-84abc3229909	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
06fd0961-6b05-4695-b7d2-cf105bc372f4	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
be539f3e-7887-46e2-ae99-932777432c69	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
eeca826a-30de-4f95-8ccd-62cbc3002cf5	username	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
4bfdd841-86b8-4721-98e1-39bd9e133486	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
20253e13-2eaf-4efa-8d66-1d680fbbae8b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
f0695ac3-dd10-4a32-9c14-6f20ddb7ea08	website	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
a00d2413-9943-49d7-b5eb-1ac2cbe1f67d	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
19f8c6f7-79ba-4697-9b7d-c6eea76f56a4	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
e936bef8-8480-4b26-97d4-e1af648706cb	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
761990e2-f363-4319-bf4c-904f4bdd090a	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
945447d7-3a71-4a72-92fe-00b52d6deec8	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	dbf413af-a311-4102-9b8a-98c05dc655b7
f19703e1-7819-4b33-b3d8-6e7a55f51b4c	email	openid-connect	oidc-usermodel-attribute-mapper	\N	dcd07cb6-ef1d-48b2-8747-88ad3946ee0e
6196f07e-d646-42c4-a437-8dff1cd0fd5d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	dcd07cb6-ef1d-48b2-8747-88ad3946ee0e
738b417f-599f-485b-9dac-c523e3808367	address	openid-connect	oidc-address-mapper	\N	24a82def-b835-4f28-977c-aa2a3d1a7b88
3b962f1d-4905-490b-b42d-70b32058306f	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	76ec706b-d4ab-4f9b-8156-47ea9af0e318
4d42a2c0-17ac-4a84-8e81-77457d111952	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	76ec706b-d4ab-4f9b-8156-47ea9af0e318
3b0aa1f1-aa0d-474e-a9c0-d97a760bd874	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	5a5f5802-cb3f-4af0-a317-92f38e7434d6
63440816-63f8-472e-b939-79b87ef524de	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	5a5f5802-cb3f-4af0-a317-92f38e7434d6
acd33e42-a19e-4f2b-a9ab-530b51d4e4d0	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	5a5f5802-cb3f-4af0-a317-92f38e7434d6
8a994629-9468-43c7-933d-403d82791dfd	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	5ae7e88a-bf7d-4f78-93ea-1958d6ee8ddd
596ae5da-4c3e-4b0c-9a42-bdf8d254005d	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	d672ef9a-bcca-49ec-998e-d46dbddd2672
a27389c0-315f-4765-b792-e865d74d76bf	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	d672ef9a-bcca-49ec-998e-d46dbddd2672
96bd4abd-9d4b-4697-a38b-53fa746351c6	acr loa level	openid-connect	oidc-acr-mapper	\N	e6fa5c3d-7a27-4adf-a573-07831135026f
66cec84f-987a-41ee-bf3c-f4de8233a71e	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	63e8ae03-b467-4422-8cb6-322ea262065f
74bd41a1-f29c-4acf-a792-be1862fc29ab	sub	openid-connect	oidc-sub-mapper	\N	63e8ae03-b467-4422-8cb6-322ea262065f
55a1f94f-e34e-48ee-b5d2-61eeafad3c9e	organization	openid-connect	oidc-organization-membership-mapper	\N	2e5b32a3-cde4-49f5-9337-13443b4ba420
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
b66bcc08-4a90-45ec-99c4-e8dd17606bb2	true	introspection.token.claim
b66bcc08-4a90-45ec-99c4-e8dd17606bb2	true	userinfo.token.claim
b66bcc08-4a90-45ec-99c4-e8dd17606bb2	locale	user.attribute
b66bcc08-4a90-45ec-99c4-e8dd17606bb2	true	id.token.claim
b66bcc08-4a90-45ec-99c4-e8dd17606bb2	true	access.token.claim
b66bcc08-4a90-45ec-99c4-e8dd17606bb2	locale	claim.name
b66bcc08-4a90-45ec-99c4-e8dd17606bb2	String	jsonType.label
835cd101-30a3-498c-a587-8f1d1a23ae3f	false	single
835cd101-30a3-498c-a587-8f1d1a23ae3f	Basic	attribute.nameformat
835cd101-30a3-498c-a587-8f1d1a23ae3f	Role	attribute.name
06fd0961-6b05-4695-b7d2-cf105bc372f4	true	introspection.token.claim
06fd0961-6b05-4695-b7d2-cf105bc372f4	true	userinfo.token.claim
06fd0961-6b05-4695-b7d2-cf105bc372f4	middleName	user.attribute
06fd0961-6b05-4695-b7d2-cf105bc372f4	true	id.token.claim
06fd0961-6b05-4695-b7d2-cf105bc372f4	true	access.token.claim
06fd0961-6b05-4695-b7d2-cf105bc372f4	middle_name	claim.name
06fd0961-6b05-4695-b7d2-cf105bc372f4	String	jsonType.label
19f8c6f7-79ba-4697-9b7d-c6eea76f56a4	true	introspection.token.claim
19f8c6f7-79ba-4697-9b7d-c6eea76f56a4	true	userinfo.token.claim
19f8c6f7-79ba-4697-9b7d-c6eea76f56a4	birthdate	user.attribute
19f8c6f7-79ba-4697-9b7d-c6eea76f56a4	true	id.token.claim
19f8c6f7-79ba-4697-9b7d-c6eea76f56a4	true	access.token.claim
19f8c6f7-79ba-4697-9b7d-c6eea76f56a4	birthdate	claim.name
19f8c6f7-79ba-4697-9b7d-c6eea76f56a4	String	jsonType.label
20253e13-2eaf-4efa-8d66-1d680fbbae8b	true	introspection.token.claim
20253e13-2eaf-4efa-8d66-1d680fbbae8b	true	userinfo.token.claim
20253e13-2eaf-4efa-8d66-1d680fbbae8b	picture	user.attribute
20253e13-2eaf-4efa-8d66-1d680fbbae8b	true	id.token.claim
20253e13-2eaf-4efa-8d66-1d680fbbae8b	true	access.token.claim
20253e13-2eaf-4efa-8d66-1d680fbbae8b	picture	claim.name
20253e13-2eaf-4efa-8d66-1d680fbbae8b	String	jsonType.label
4bfdd841-86b8-4721-98e1-39bd9e133486	true	introspection.token.claim
4bfdd841-86b8-4721-98e1-39bd9e133486	true	userinfo.token.claim
4bfdd841-86b8-4721-98e1-39bd9e133486	profile	user.attribute
4bfdd841-86b8-4721-98e1-39bd9e133486	true	id.token.claim
4bfdd841-86b8-4721-98e1-39bd9e133486	true	access.token.claim
4bfdd841-86b8-4721-98e1-39bd9e133486	profile	claim.name
4bfdd841-86b8-4721-98e1-39bd9e133486	String	jsonType.label
693404c6-d637-4314-80c1-2d5d49b0ba66	true	introspection.token.claim
693404c6-d637-4314-80c1-2d5d49b0ba66	true	userinfo.token.claim
693404c6-d637-4314-80c1-2d5d49b0ba66	lastName	user.attribute
693404c6-d637-4314-80c1-2d5d49b0ba66	true	id.token.claim
693404c6-d637-4314-80c1-2d5d49b0ba66	true	access.token.claim
693404c6-d637-4314-80c1-2d5d49b0ba66	family_name	claim.name
693404c6-d637-4314-80c1-2d5d49b0ba66	String	jsonType.label
761990e2-f363-4319-bf4c-904f4bdd090a	true	introspection.token.claim
761990e2-f363-4319-bf4c-904f4bdd090a	true	userinfo.token.claim
761990e2-f363-4319-bf4c-904f4bdd090a	locale	user.attribute
761990e2-f363-4319-bf4c-904f4bdd090a	true	id.token.claim
761990e2-f363-4319-bf4c-904f4bdd090a	true	access.token.claim
761990e2-f363-4319-bf4c-904f4bdd090a	locale	claim.name
761990e2-f363-4319-bf4c-904f4bdd090a	String	jsonType.label
945447d7-3a71-4a72-92fe-00b52d6deec8	true	introspection.token.claim
945447d7-3a71-4a72-92fe-00b52d6deec8	true	userinfo.token.claim
945447d7-3a71-4a72-92fe-00b52d6deec8	updatedAt	user.attribute
945447d7-3a71-4a72-92fe-00b52d6deec8	true	id.token.claim
945447d7-3a71-4a72-92fe-00b52d6deec8	true	access.token.claim
945447d7-3a71-4a72-92fe-00b52d6deec8	updated_at	claim.name
945447d7-3a71-4a72-92fe-00b52d6deec8	long	jsonType.label
a00d2413-9943-49d7-b5eb-1ac2cbe1f67d	true	introspection.token.claim
a00d2413-9943-49d7-b5eb-1ac2cbe1f67d	true	userinfo.token.claim
a00d2413-9943-49d7-b5eb-1ac2cbe1f67d	gender	user.attribute
a00d2413-9943-49d7-b5eb-1ac2cbe1f67d	true	id.token.claim
a00d2413-9943-49d7-b5eb-1ac2cbe1f67d	true	access.token.claim
a00d2413-9943-49d7-b5eb-1ac2cbe1f67d	gender	claim.name
a00d2413-9943-49d7-b5eb-1ac2cbe1f67d	String	jsonType.label
be539f3e-7887-46e2-ae99-932777432c69	true	introspection.token.claim
be539f3e-7887-46e2-ae99-932777432c69	true	userinfo.token.claim
be539f3e-7887-46e2-ae99-932777432c69	nickname	user.attribute
be539f3e-7887-46e2-ae99-932777432c69	true	id.token.claim
be539f3e-7887-46e2-ae99-932777432c69	true	access.token.claim
be539f3e-7887-46e2-ae99-932777432c69	nickname	claim.name
be539f3e-7887-46e2-ae99-932777432c69	String	jsonType.label
cf5a5fac-4d45-4782-84cf-b1e2b77de640	true	introspection.token.claim
cf5a5fac-4d45-4782-84cf-b1e2b77de640	true	userinfo.token.claim
cf5a5fac-4d45-4782-84cf-b1e2b77de640	true	id.token.claim
cf5a5fac-4d45-4782-84cf-b1e2b77de640	true	access.token.claim
e936bef8-8480-4b26-97d4-e1af648706cb	true	introspection.token.claim
e936bef8-8480-4b26-97d4-e1af648706cb	true	userinfo.token.claim
e936bef8-8480-4b26-97d4-e1af648706cb	zoneinfo	user.attribute
e936bef8-8480-4b26-97d4-e1af648706cb	true	id.token.claim
e936bef8-8480-4b26-97d4-e1af648706cb	true	access.token.claim
e936bef8-8480-4b26-97d4-e1af648706cb	zoneinfo	claim.name
e936bef8-8480-4b26-97d4-e1af648706cb	String	jsonType.label
eeca826a-30de-4f95-8ccd-62cbc3002cf5	true	introspection.token.claim
eeca826a-30de-4f95-8ccd-62cbc3002cf5	true	userinfo.token.claim
eeca826a-30de-4f95-8ccd-62cbc3002cf5	username	user.attribute
eeca826a-30de-4f95-8ccd-62cbc3002cf5	true	id.token.claim
eeca826a-30de-4f95-8ccd-62cbc3002cf5	true	access.token.claim
eeca826a-30de-4f95-8ccd-62cbc3002cf5	preferred_username	claim.name
eeca826a-30de-4f95-8ccd-62cbc3002cf5	String	jsonType.label
f0695ac3-dd10-4a32-9c14-6f20ddb7ea08	true	introspection.token.claim
f0695ac3-dd10-4a32-9c14-6f20ddb7ea08	true	userinfo.token.claim
f0695ac3-dd10-4a32-9c14-6f20ddb7ea08	website	user.attribute
f0695ac3-dd10-4a32-9c14-6f20ddb7ea08	true	id.token.claim
f0695ac3-dd10-4a32-9c14-6f20ddb7ea08	true	access.token.claim
f0695ac3-dd10-4a32-9c14-6f20ddb7ea08	website	claim.name
f0695ac3-dd10-4a32-9c14-6f20ddb7ea08	String	jsonType.label
f1122d5a-cafb-4ee2-a4cf-84abc3229909	true	introspection.token.claim
f1122d5a-cafb-4ee2-a4cf-84abc3229909	true	userinfo.token.claim
f1122d5a-cafb-4ee2-a4cf-84abc3229909	firstName	user.attribute
f1122d5a-cafb-4ee2-a4cf-84abc3229909	true	id.token.claim
f1122d5a-cafb-4ee2-a4cf-84abc3229909	true	access.token.claim
f1122d5a-cafb-4ee2-a4cf-84abc3229909	given_name	claim.name
f1122d5a-cafb-4ee2-a4cf-84abc3229909	String	jsonType.label
6196f07e-d646-42c4-a437-8dff1cd0fd5d	true	introspection.token.claim
6196f07e-d646-42c4-a437-8dff1cd0fd5d	true	userinfo.token.claim
6196f07e-d646-42c4-a437-8dff1cd0fd5d	emailVerified	user.attribute
6196f07e-d646-42c4-a437-8dff1cd0fd5d	true	id.token.claim
6196f07e-d646-42c4-a437-8dff1cd0fd5d	true	access.token.claim
6196f07e-d646-42c4-a437-8dff1cd0fd5d	email_verified	claim.name
6196f07e-d646-42c4-a437-8dff1cd0fd5d	boolean	jsonType.label
f19703e1-7819-4b33-b3d8-6e7a55f51b4c	true	introspection.token.claim
f19703e1-7819-4b33-b3d8-6e7a55f51b4c	true	userinfo.token.claim
f19703e1-7819-4b33-b3d8-6e7a55f51b4c	email	user.attribute
f19703e1-7819-4b33-b3d8-6e7a55f51b4c	true	id.token.claim
f19703e1-7819-4b33-b3d8-6e7a55f51b4c	true	access.token.claim
f19703e1-7819-4b33-b3d8-6e7a55f51b4c	email	claim.name
f19703e1-7819-4b33-b3d8-6e7a55f51b4c	String	jsonType.label
738b417f-599f-485b-9dac-c523e3808367	formatted	user.attribute.formatted
738b417f-599f-485b-9dac-c523e3808367	country	user.attribute.country
738b417f-599f-485b-9dac-c523e3808367	true	introspection.token.claim
738b417f-599f-485b-9dac-c523e3808367	postal_code	user.attribute.postal_code
738b417f-599f-485b-9dac-c523e3808367	true	userinfo.token.claim
738b417f-599f-485b-9dac-c523e3808367	street	user.attribute.street
738b417f-599f-485b-9dac-c523e3808367	true	id.token.claim
738b417f-599f-485b-9dac-c523e3808367	region	user.attribute.region
738b417f-599f-485b-9dac-c523e3808367	true	access.token.claim
738b417f-599f-485b-9dac-c523e3808367	locality	user.attribute.locality
3b962f1d-4905-490b-b42d-70b32058306f	true	introspection.token.claim
3b962f1d-4905-490b-b42d-70b32058306f	true	userinfo.token.claim
3b962f1d-4905-490b-b42d-70b32058306f	phoneNumber	user.attribute
3b962f1d-4905-490b-b42d-70b32058306f	true	id.token.claim
3b962f1d-4905-490b-b42d-70b32058306f	true	access.token.claim
3b962f1d-4905-490b-b42d-70b32058306f	phone_number	claim.name
3b962f1d-4905-490b-b42d-70b32058306f	String	jsonType.label
4d42a2c0-17ac-4a84-8e81-77457d111952	true	introspection.token.claim
4d42a2c0-17ac-4a84-8e81-77457d111952	true	userinfo.token.claim
4d42a2c0-17ac-4a84-8e81-77457d111952	phoneNumberVerified	user.attribute
4d42a2c0-17ac-4a84-8e81-77457d111952	true	id.token.claim
4d42a2c0-17ac-4a84-8e81-77457d111952	true	access.token.claim
4d42a2c0-17ac-4a84-8e81-77457d111952	phone_number_verified	claim.name
4d42a2c0-17ac-4a84-8e81-77457d111952	boolean	jsonType.label
3b0aa1f1-aa0d-474e-a9c0-d97a760bd874	true	introspection.token.claim
3b0aa1f1-aa0d-474e-a9c0-d97a760bd874	true	multivalued
3b0aa1f1-aa0d-474e-a9c0-d97a760bd874	foo	user.attribute
3b0aa1f1-aa0d-474e-a9c0-d97a760bd874	true	access.token.claim
3b0aa1f1-aa0d-474e-a9c0-d97a760bd874	realm_access.roles	claim.name
3b0aa1f1-aa0d-474e-a9c0-d97a760bd874	String	jsonType.label
63440816-63f8-472e-b939-79b87ef524de	true	introspection.token.claim
63440816-63f8-472e-b939-79b87ef524de	true	multivalued
63440816-63f8-472e-b939-79b87ef524de	foo	user.attribute
63440816-63f8-472e-b939-79b87ef524de	true	access.token.claim
63440816-63f8-472e-b939-79b87ef524de	resource_access.${client_id}.roles	claim.name
63440816-63f8-472e-b939-79b87ef524de	String	jsonType.label
acd33e42-a19e-4f2b-a9ab-530b51d4e4d0	true	introspection.token.claim
acd33e42-a19e-4f2b-a9ab-530b51d4e4d0	true	access.token.claim
8a994629-9468-43c7-933d-403d82791dfd	true	introspection.token.claim
8a994629-9468-43c7-933d-403d82791dfd	true	access.token.claim
596ae5da-4c3e-4b0c-9a42-bdf8d254005d	true	introspection.token.claim
596ae5da-4c3e-4b0c-9a42-bdf8d254005d	true	userinfo.token.claim
596ae5da-4c3e-4b0c-9a42-bdf8d254005d	username	user.attribute
596ae5da-4c3e-4b0c-9a42-bdf8d254005d	true	id.token.claim
596ae5da-4c3e-4b0c-9a42-bdf8d254005d	true	access.token.claim
596ae5da-4c3e-4b0c-9a42-bdf8d254005d	upn	claim.name
596ae5da-4c3e-4b0c-9a42-bdf8d254005d	String	jsonType.label
a27389c0-315f-4765-b792-e865d74d76bf	true	introspection.token.claim
a27389c0-315f-4765-b792-e865d74d76bf	true	multivalued
a27389c0-315f-4765-b792-e865d74d76bf	foo	user.attribute
a27389c0-315f-4765-b792-e865d74d76bf	true	id.token.claim
a27389c0-315f-4765-b792-e865d74d76bf	true	access.token.claim
a27389c0-315f-4765-b792-e865d74d76bf	groups	claim.name
a27389c0-315f-4765-b792-e865d74d76bf	String	jsonType.label
96bd4abd-9d4b-4697-a38b-53fa746351c6	true	introspection.token.claim
96bd4abd-9d4b-4697-a38b-53fa746351c6	true	id.token.claim
96bd4abd-9d4b-4697-a38b-53fa746351c6	true	access.token.claim
66cec84f-987a-41ee-bf3c-f4de8233a71e	AUTH_TIME	user.session.note
66cec84f-987a-41ee-bf3c-f4de8233a71e	true	introspection.token.claim
66cec84f-987a-41ee-bf3c-f4de8233a71e	true	id.token.claim
66cec84f-987a-41ee-bf3c-f4de8233a71e	true	access.token.claim
66cec84f-987a-41ee-bf3c-f4de8233a71e	auth_time	claim.name
66cec84f-987a-41ee-bf3c-f4de8233a71e	long	jsonType.label
74bd41a1-f29c-4acf-a792-be1862fc29ab	true	introspection.token.claim
74bd41a1-f29c-4acf-a792-be1862fc29ab	true	access.token.claim
55a1f94f-e34e-48ee-b5d2-61eeafad3c9e	true	introspection.token.claim
55a1f94f-e34e-48ee-b5d2-61eeafad3c9e	true	multivalued
55a1f94f-e34e-48ee-b5d2-61eeafad3c9e	true	id.token.claim
55a1f94f-e34e-48ee-b5d2-61eeafad3c9e	true	access.token.claim
55a1f94f-e34e-48ee-b5d2-61eeafad3c9e	organization	claim.name
55a1f94f-e34e-48ee-b5d2-61eeafad3c9e	String	jsonType.label
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
04091393-f3f9-4303-ba2b-e7530a9d7711	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	778e33bf-3bc1-44d6-aebf-e8b6f89b0b60	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	fcff186b-b4c8-429e-867b-3dcc940bcc54	943be564-f760-4242-87e4-31bc14d5be41	c9b028e0-a6a0-41a3-a45f-be303c9fcbe3	65610f20-65d0-4589-980e-0660936234ff	290141e8-96a6-43f5-b46b-d0b233daf717	2592000	f	900	t	f	10c5a001-548e-4a26-93c2-8cb5eb97d4f5	0	f	0	0	950def63-2e92-4028-8412-21e2800e4066
83b6664d-539e-4bed-a376-685d50e40b98	60	300	300	\N	\N	\N	t	f	0	\N	loci-realm	0	\N	t	t	t	f	EXTERNAL	1800	36000	f	f	cf811709-122d-4121-97ba-0faecd4dd786	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	801e570d-bc15-45e3-9f8e-afe9f8f28dec	8c356fe3-6843-440d-ac93-b4cc6352781f	d7b8234b-3d04-4263-ac07-79794e3fb8c0	2ec9ca75-4f99-43e9-816d-708c9a550838	05607ab5-8839-424c-b1e7-7f0ccad2063e	2592000	f	900	t	f	08caf47c-2dda-42d5-a33d-3df1271e703c	0	f	0	0	929392ee-0474-4ed0-a64e-9b0132025c91
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	04091393-f3f9-4303-ba2b-e7530a9d7711	
_browser_header.xContentTypeOptions	04091393-f3f9-4303-ba2b-e7530a9d7711	nosniff
_browser_header.referrerPolicy	04091393-f3f9-4303-ba2b-e7530a9d7711	no-referrer
_browser_header.xRobotsTag	04091393-f3f9-4303-ba2b-e7530a9d7711	none
_browser_header.xFrameOptions	04091393-f3f9-4303-ba2b-e7530a9d7711	SAMEORIGIN
_browser_header.contentSecurityPolicy	04091393-f3f9-4303-ba2b-e7530a9d7711	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	04091393-f3f9-4303-ba2b-e7530a9d7711	1; mode=block
_browser_header.strictTransportSecurity	04091393-f3f9-4303-ba2b-e7530a9d7711	max-age=31536000; includeSubDomains
bruteForceProtected	04091393-f3f9-4303-ba2b-e7530a9d7711	false
permanentLockout	04091393-f3f9-4303-ba2b-e7530a9d7711	false
maxTemporaryLockouts	04091393-f3f9-4303-ba2b-e7530a9d7711	0
maxFailureWaitSeconds	04091393-f3f9-4303-ba2b-e7530a9d7711	900
minimumQuickLoginWaitSeconds	04091393-f3f9-4303-ba2b-e7530a9d7711	60
waitIncrementSeconds	04091393-f3f9-4303-ba2b-e7530a9d7711	60
quickLoginCheckMilliSeconds	04091393-f3f9-4303-ba2b-e7530a9d7711	1000
maxDeltaTimeSeconds	04091393-f3f9-4303-ba2b-e7530a9d7711	43200
failureFactor	04091393-f3f9-4303-ba2b-e7530a9d7711	30
realmReusableOtpCode	04091393-f3f9-4303-ba2b-e7530a9d7711	false
firstBrokerLoginFlowId	04091393-f3f9-4303-ba2b-e7530a9d7711	2d672118-c7c4-46cf-b4d7-0bfab7a28e22
displayName	04091393-f3f9-4303-ba2b-e7530a9d7711	Keycloak
displayNameHtml	04091393-f3f9-4303-ba2b-e7530a9d7711	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	04091393-f3f9-4303-ba2b-e7530a9d7711	RS256
offlineSessionMaxLifespanEnabled	04091393-f3f9-4303-ba2b-e7530a9d7711	false
offlineSessionMaxLifespan	04091393-f3f9-4303-ba2b-e7530a9d7711	5184000
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
04091393-f3f9-4303-ba2b-e7530a9d7711	jboss-logging
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
password	password	t	t	04091393-f3f9-4303-ba2b-e7530a9d7711
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
74791b5a-ba3c-44a7-b0d3-87e327bda6a8	/realms/master/account/*
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	/realms/master/account/*
190691f2-8063-4df4-a638-478d961bda4f	/admin/master/console/*
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
ff781829-07bf-4e21-9cd7-bdaa6ab1761a	VERIFY_EMAIL	Verify Email	04091393-f3f9-4303-ba2b-e7530a9d7711	t	f	VERIFY_EMAIL	50
65081b51-d390-41fc-8a06-0ccaa1bb070b	UPDATE_PROFILE	Update Profile	04091393-f3f9-4303-ba2b-e7530a9d7711	t	f	UPDATE_PROFILE	40
d5c4bcce-94e6-45e0-be6f-4ef237a4c48d	CONFIGURE_TOTP	Configure OTP	04091393-f3f9-4303-ba2b-e7530a9d7711	t	f	CONFIGURE_TOTP	10
217344b6-6316-4444-b037-297abe96d249	UPDATE_PASSWORD	Update Password	04091393-f3f9-4303-ba2b-e7530a9d7711	t	f	UPDATE_PASSWORD	30
15258cd5-e450-425c-b87c-6aa744d34f57	TERMS_AND_CONDITIONS	Terms and Conditions	04091393-f3f9-4303-ba2b-e7530a9d7711	f	f	TERMS_AND_CONDITIONS	20
0e94ca62-e8a2-4637-96a5-7325044274e7	delete_account	Delete Account	04091393-f3f9-4303-ba2b-e7530a9d7711	f	f	delete_account	60
a4333b78-2ccb-4147-8029-3613a0ace5d6	delete_credential	Delete Credential	04091393-f3f9-4303-ba2b-e7530a9d7711	t	f	delete_credential	100
5e7c1c7c-bf7b-40aa-82eb-5c21fec2a287	update_user_locale	Update User Locale	04091393-f3f9-4303-ba2b-e7530a9d7711	t	f	update_user_locale	1000
c89c3a50-6be7-46c6-94b2-da7f6a274691	webauthn-register	Webauthn Register	04091393-f3f9-4303-ba2b-e7530a9d7711	t	f	webauthn-register	70
74ddeb11-829a-4a35-8d04-169034973ea0	webauthn-register-passwordless	Webauthn Register Passwordless	04091393-f3f9-4303-ba2b-e7530a9d7711	t	f	webauthn-register-passwordless	80
43846f82-c598-4a0a-aa4b-dc635f7e388d	VERIFY_PROFILE	Verify Profile	04091393-f3f9-4303-ba2b-e7530a9d7711	t	f	VERIFY_PROFILE	90
8beb9ae3-e25a-4a13-8a02-5fb962ef621f	CONFIGURE_TOTP	Configure OTP	83b6664d-539e-4bed-a376-685d50e40b98	t	f	CONFIGURE_TOTP	10
198da2b6-ee74-4d01-9496-b87e307071b1	TERMS_AND_CONDITIONS	Terms and Conditions	83b6664d-539e-4bed-a376-685d50e40b98	f	f	TERMS_AND_CONDITIONS	20
d384f9ac-57d6-4d7f-9721-ef6709760a68	UPDATE_PASSWORD	Update Password	83b6664d-539e-4bed-a376-685d50e40b98	t	f	UPDATE_PASSWORD	30
8225fa42-f321-41b6-8f20-999676f58f37	UPDATE_PROFILE	Update Profile	83b6664d-539e-4bed-a376-685d50e40b98	t	f	UPDATE_PROFILE	40
3bab16aa-dd38-4dca-b6e5-15660f61b30f	VERIFY_EMAIL	Verify Email	83b6664d-539e-4bed-a376-685d50e40b98	t	f	VERIFY_EMAIL	50
9a731f00-7164-48fb-873c-53e790fc0289	delete_account	Delete Account	83b6664d-539e-4bed-a376-685d50e40b98	f	f	delete_account	60
80fc0136-5162-44db-a071-9c9e725d7b0f	webauthn-register	Webauthn Register	83b6664d-539e-4bed-a376-685d50e40b98	t	f	webauthn-register	70
be6f6f5c-94ca-4e3a-a617-cad34acd265d	webauthn-register-passwordless	Webauthn Register Passwordless	83b6664d-539e-4bed-a376-685d50e40b98	t	f	webauthn-register-passwordless	80
15ec6355-743f-4551-827c-f55af7659c78	VERIFY_PROFILE	Verify Profile	83b6664d-539e-4bed-a376-685d50e40b98	t	f	VERIFY_PROFILE	90
e6505c5f-9079-41c5-af42-8e0b2007a29f	delete_credential	Delete Credential	83b6664d-539e-4bed-a376-685d50e40b98	t	f	delete_credential	100
a90836c5-bd51-4216-84b2-cfd5bccfacc0	update_user_locale	Update User Locale	83b6664d-539e-4bed-a376-685d50e40b98	t	f	update_user_locale	1000
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
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	54d1d08d-1825-4ad2-9da8-1f748a78ad70
c1a49c59-3bc3-4393-8b8e-71b7ea921d98	bb3d5d86-39aa-40de-b44a-8efb2e2fb85a
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

COPY public.user_ (friend_request_setting, profile_visibility, created_date, id, last_active, last_modified_date, last_seen, public_id, bio, email, firstname, gender, image_url, last_seen_setting, lastname, profile_picture, username) FROM stdin;
0	t	2025-12-05 01:50:01.294513+00	4	\N	2025-12-05 02:02:41.72921+00	\N	fe0be6db-904c-4fb3-8b5c-0fd64b625dd2	\N	bryon.reilly@yahoo.com	Goldner	\N	\N	EVERYONE	Junita	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=461	bryon.reilly@yahoo.com
0	t	2025-12-05 02:08:19.92988+00	5	\N	2025-12-05 02:08:19.92988+00	\N	e3d9eb14-e39e-4c63-8438-8d6a4bed216c	\N	cedric.rau@yahoo.com	Hammes	\N	\N	EVERYONE	Hong	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=780	cedric.rau@yahoo.com
0	t	2025-12-04 14:50:58.551434+00	2	\N	2025-12-05 02:14:27.081271+00	\N	ca4311c1-904a-473e-9af5-1c8d522ec981	\N	testuser1@gmail.com	kien	\N	\N	EVERYONE	trung	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=290	testuser1
0	t	2025-12-05 02:14:48.147167+00	6	\N	2025-12-05 02:14:48.147167+00	\N	165c081a-a05c-4a75-a365-ce8e6954ca98	\N	corazon.quigley@gmail.com	Brekke	\N	\N	EVERYONE	Dorene	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=585	corazon.quigley@gmail.com
0	t	2025-12-05 02:15:11.950151+00	7	\N	2025-12-05 02:15:11.950151+00	\N	c4338c6b-8480-4864-920a-2112d2dfe73a	\N	earle.wilderman@yahoo.com	Bradtke	\N	\N	EVERYONE	Tory	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=897	earle.wilderman@yahoo.com
0	t	2025-12-05 02:15:42.537048+00	8	\N	2025-12-05 02:16:11.340527+00	\N	f5b575c6-031c-4d6e-bdaa-5b77d8ec2318	\N	eugenie.goldner@gmail.com	Weimann	\N	\N	EVERYONE	Davida	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=936	eugenie.goldner@gmail.com
0	t	2025-12-05 02:16:32.46083+00	9	\N	2025-12-05 02:16:32.46083+00	\N	e56c826c-4d57-44a0-b22d-db72fe963ee2	\N	fanny.jakubowski@gmail.com	Wilkinson	\N	\N	EVERYONE	Viola	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=946	fanny.jakubowski@gmail.com
0	t	2025-12-05 02:17:01.626503+00	10	\N	2025-12-05 02:17:01.626503+00	\N	c7df8822-b69b-4f5e-92de-48a07c458ee6	\N	gidget.bergstrom@yahoo.com	Doyle	\N	\N	EVERYONE	Kaylee	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=659	gidget.bergstrom@yahoo.com
0	t	2025-12-05 02:17:21.670557+00	11	\N	2025-12-05 02:17:21.670557+00	\N	aa9c53f3-467c-4a1e-ae22-0b1ee0063ff6	\N	glady.conn@yahoo.com	Hessel	\N	\N	EVERYONE	Fatima	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=600	glady.conn@yahoo.com
0	t	2025-12-05 02:17:37.137455+00	12	\N	2025-12-05 02:17:37.137455+00	\N	6f567894-ff58-4ac3-8405-2429f85b7e2f	\N	halley.balistreri@gmail.com	Collier	\N	\N	EVERYONE	Jaquelyn	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=339	halley.balistreri@gmail.com
0	t	2025-12-05 02:18:00.04301+00	13	\N	2025-12-05 02:18:00.04301+00	\N	fb76374a-cd77-43a2-9f16-4f991a5087bb	\N	jae.koch@yahoo.com	Graham	\N	\N	EVERYONE	Sage	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=1	jae.koch@yahoo.com
0	t	2025-12-05 02:18:21.395825+00	14	\N	2025-12-05 02:18:21.395825+00	\N	e06268d2-bca0-4a0d-a521-a0ffd10582f1	\N	jung.heidenreich@gmail.com	Beier	\N	\N	EVERYONE	Galen	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=721	jung.heidenreich@gmail.com
0	t	2025-12-05 02:18:38.484872+00	15	\N	2025-12-05 02:18:38.484872+00	\N	666813d9-e4d6-48c7-9410-b12d16479cc2	\N	kittie.hackett@yahoo.com	Doyle	\N	\N	EVERYONE	Caroline	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=318	kittie.hackett@yahoo.com
0	t	2025-12-05 02:18:50.986851+00	16	\N	2025-12-05 02:18:50.986851+00	\N	b98d41c5-7492-4df7-88ea-fa1a07622782	\N	kourtney.ohara@yahoo.com	Purdy	\N	\N	EVERYONE	Missy	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=926	kourtney.ohara@yahoo.com
0	t	2025-12-05 01:43:20.4205+00	3	\N	2025-12-05 01:48:01.749375+00	\N	3826dcd7-5e18-430d-96d4-92cc3533e60b	\N	alaina.goyette@gmail.com	Schamberger	\N	\N	EVERYONE	Janean	https://api.dicebear.com/7.x/notionists/svg?scale=200&seed=145	alaina.goyette@gmail.com
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	709bb742-5f72-4760-a72d-25123640703e	8afd4945-e23e-4446-9528-0f477033c30c	\N	\N	\N
\.


--
-- Data for Name: user_authority; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_authority (user_id, authority_name) FROM stdin;
2	ROLE_UMA_AUTHORIZATION
2	ROLE_OFFLINE_ACCESS
2	ROLE_DEFAULT-ROLES-LOCI-REALM
2	ROLE_USER
3	ROLE_UMA_AUTHORIZATION
3	ROLE_OFFLINE_ACCESS
3	ROLE_DEFAULT-ROLES-LOCI-REALM
3	ROLE_USER
4	ROLE_UMA_AUTHORIZATION
4	ROLE_OFFLINE_ACCESS
4	ROLE_DEFAULT-ROLES-LOCI-REALM
4	ROLE_USER
5	ROLE_UMA_AUTHORIZATION
5	ROLE_OFFLINE_ACCESS
5	ROLE_DEFAULT-ROLES-LOCI-REALM
5	ROLE_USER
6	ROLE_UMA_AUTHORIZATION
6	ROLE_OFFLINE_ACCESS
6	ROLE_DEFAULT-ROLES-LOCI-REALM
6	ROLE_USER
7	ROLE_UMA_AUTHORIZATION
7	ROLE_OFFLINE_ACCESS
7	ROLE_DEFAULT-ROLES-LOCI-REALM
7	ROLE_USER
8	ROLE_UMA_AUTHORIZATION
8	ROLE_OFFLINE_ACCESS
8	ROLE_DEFAULT-ROLES-LOCI-REALM
8	ROLE_USER
9	ROLE_UMA_AUTHORIZATION
9	ROLE_OFFLINE_ACCESS
9	ROLE_DEFAULT-ROLES-LOCI-REALM
9	ROLE_USER
10	ROLE_UMA_AUTHORIZATION
10	ROLE_OFFLINE_ACCESS
10	ROLE_DEFAULT-ROLES-LOCI-REALM
10	ROLE_USER
11	ROLE_UMA_AUTHORIZATION
11	ROLE_OFFLINE_ACCESS
11	ROLE_DEFAULT-ROLES-LOCI-REALM
11	ROLE_USER
12	ROLE_UMA_AUTHORIZATION
12	ROLE_OFFLINE_ACCESS
12	ROLE_DEFAULT-ROLES-LOCI-REALM
12	ROLE_USER
13	ROLE_UMA_AUTHORIZATION
13	ROLE_OFFLINE_ACCESS
13	ROLE_DEFAULT-ROLES-LOCI-REALM
13	ROLE_USER
14	ROLE_UMA_AUTHORIZATION
14	ROLE_OFFLINE_ACCESS
14	ROLE_DEFAULT-ROLES-LOCI-REALM
14	ROLE_USER
15	ROLE_UMA_AUTHORIZATION
15	ROLE_OFFLINE_ACCESS
15	ROLE_DEFAULT-ROLES-LOCI-REALM
15	ROLE_USER
16	ROLE_UMA_AUTHORIZATION
16	ROLE_OFFLINE_ACCESS
16	ROLE_DEFAULT-ROLES-LOCI-REALM
16	ROLE_USER
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
709bb742-5f72-4760-a72d-25123640703e	\N	ccf61d5d-097e-4aee-a791-14304d34c697	f	t	\N	\N	\N	04091393-f3f9-4303-ba2b-e7530a9d7711	admin	1764842413284	\N	0
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
950def63-2e92-4028-8412-21e2800e4066	709bb742-5f72-4760-a72d-25123640703e
279f5398-070e-4796-ae4a-003fb8a1388f	709bb742-5f72-4760-a72d-25123640703e
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
190691f2-8063-4df4-a638-478d961bda4f	+
1946f9ea-72fe-4697-bf83-3dec92a8f8ee	*
d004af51-9d2e-47d3-9340-a3a411f42029	
d004af51-9d2e-47d3-9340-a3a411f42029	http://localhost:8080/
ba4de397-daf8-404b-ad79-249e4d09a713	+
e85deedd-b2fb-47d3-acef-508423a77f22	http://localhost:8080
\.


--
-- Name: contact_request_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.contact_request_sequence', 1, false);


--
-- Name: contact_sequence; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.contact_sequence', 1, false);


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

SELECT pg_catalog.setval('public.user_sequence', 16, true);


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
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


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
-- Name: group_ ukgdlqdiqvcgqbe1fspoysdsjpw; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_
    ADD CONSTRAINT ukgdlqdiqvcgqbe1fspoysdsjpw UNIQUE (conversation_id);


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
-- Name: group_ fk1s9ggxi7i7i7gq3869dlyws5e; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.group_
    ADD CONSTRAINT fk1s9ggxi7i7i7gq3869dlyws5e FOREIGN KEY (conversation_id) REFERENCES public.conversations(id);


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
-- Name: contact fk7rlqroy8v218wadpf5do3el2e; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT fk7rlqroy8v218wadpf5do3el2e FOREIGN KEY (contact_user_id) REFERENCES public.user_(id);


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
-- Name: conversations fkec5vwoskn10x76g5ks833b8nk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT fkec5vwoskn10x76g5ks833b8nk FOREIGN KEY (creator_id) REFERENCES public.user_(id);


--
-- Name: notification fkg9wcclio3v5xftqnc4q7lr7hd; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT fkg9wcclio3v5xftqnc4q7lr7hd FOREIGN KEY (user_id) REFERENCES public.user_(id);


--
-- Name: message fkgn1by50g9ur1g9veuroqmugin; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT fkgn1by50g9ur1g9veuroqmugin FOREIGN KEY (conversation_id) REFERENCES public.conversations(id);


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
-- Name: conversation_participant fkj6b2ggxpac5meuh02olopl9d9; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.conversation_participant
    ADD CONSTRAINT fkj6b2ggxpac5meuh02olopl9d9 FOREIGN KEY (conversation_id) REFERENCES public.conversations(id);


--
-- Name: contact_request fkn2g1ehilahjakmnnbncklfbog; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contact_request
    ADD CONSTRAINT fkn2g1ehilahjakmnnbncklfbog FOREIGN KEY (receiver_user_id) REFERENCES public.user_(id);


--
-- Name: contact_request fkt6jacf36093nt67xmxnuunyau; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.contact_request
    ADD CONSTRAINT fkt6jacf36093nt67xmxnuunyau FOREIGN KEY (request_user_id) REFERENCES public.user_(id);


--
-- PostgreSQL database dump complete
--


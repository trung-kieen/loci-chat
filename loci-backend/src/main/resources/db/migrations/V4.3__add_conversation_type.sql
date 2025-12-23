    alter table if exists conversation
       add column conversation_type varchar(255) not null check (conversation_type in ('ONE_TO_ONE','GROUP'));
    alter table if exists conversation
      drop column group_profile_picture;
    alter table if exists conversation
      drop column group_name;
    alter table if exists conversation
      drop column updated_at;
    alter table if exists conversation
       add column last_message_sent timestamp(6) with time zone;

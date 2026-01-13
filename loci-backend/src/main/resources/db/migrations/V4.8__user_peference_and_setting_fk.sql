    create table authority (
        name varchar(50) not null,
        primary key (name)
    );

    alter table if exists user_
       add column profile_picture varchar(255);

    alter table if exists user_
       add column username varchar(255);

    create table user_authority (
        user_id bigint not null,
        authority_name varchar(50) not null,
        primary key (user_id, authority_name)
    );

    create sequence user_sequence start with 1 increment by 1;

    alter table if exists user_authority
       add constraint FK6ktglpl5mjosa283rvken2py5
       foreign key (authority_name)
       references authority;

    alter table if exists user_authority
       add constraint FKio2xcw9ogcqbasp25n5vttxrf
       foreign key (user_id)
       references user_;

    alter table if exists user_settings
       add constraint FKp3nomjf43s475m64i9q73arb0
       foreign key (user_id)
       references user_;

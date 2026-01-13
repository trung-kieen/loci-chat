ALTER TABLE user_settings
   add constraint FK_user_id
   foreign key (user_id)
   references user_;

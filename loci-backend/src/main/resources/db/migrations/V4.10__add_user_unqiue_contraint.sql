ALTER TABLE user_
  ADD CONSTRAINT unique_email UNIQUE(email);


ALTER TABLE user_
  ADD CONSTRAINT unique_username UNIQUE(username);

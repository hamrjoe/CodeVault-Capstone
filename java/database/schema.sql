BEGIN TRANSACTION;

DROP TABLE IF EXISTS examples;
DROP TABLE IF EXISTS users;
DROP SEQUENCE IF EXISTS seq_examples_id;
DROP SEQUENCE IF EXISTS seq_user_id;

CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_example_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;


CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE examples (
    example_id int DEFAULT nextval('seq_example_id'::regclass) NOT NULL,
    title varchar(50) NOT NULL,
--    user_id int NOT NULL,
    language_id int NOT NULL,
    code_example text NOT NULL,
    is_private boolean NOT NULL,
    attribution varchar(200),
    is_default boolean,

    CONSTRAINT PK_examples PRIMARY KEY (example_id)
--    CONSTRAINT FK_examples_languages FOREIGN KEY (language_id),
--    CONSTRAINT FK_examples_users FOREIGN KEY (user_id) REFERENCES users (user_id)
);

INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default) VALUES ('for loop', 1, '102,111,114,32,40,105,59,32,105,60,108,101,110,103,116,104,59,32,105,43,43,41,32,123,10,32,32,32,32,47,47,100,111,115,116,117,102,102,59,10,125', true, 'bob', true);
INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default) VALUES ('if else statement', 1, '105,102,32,40,116,114,117,101,41,32,123,10,32,32,47,47,100,111,32,115,116,117,102,102,59,10,125,10,101,108,115,101,32,123,10,32,32,47,47,100,111,32,111,116,104,101,114,32,115,116,117,102,102,59,10,125', true, 'bob', true);
INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default) VALUES ('if else statement', 2, '105,102,32,40,116,114,117,101,41,32,123,10,32,32,47,47,100,111,32,115,116,117,102,102,59,10,125,10,101,108,115,101,32,123,10,32,32,47,47,100,111,32,111,116,104,101,114,32,115,116,117,102,102,59,10,125', true, 'bob', true);
INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default) VALUES ('console log', 2, '99,111,110,115,111,108,101,46,108,111,103,40,39,112,114,105,110,116,32,116,104,105,110,103,115,32,104,101,114,101,39,41', true, 'bob', true);
INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default) VALUES ('System Out Print Line', 1, '83,121,115,116,101,109,46,111,117,116,46,112,114,105,110,116,108,110,40,39,115,97,121,32,116,104,105,110,103,115,32,104,101,114,101,39,41', true, 'bob', true);


INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');


COMMIT TRANSACTION;

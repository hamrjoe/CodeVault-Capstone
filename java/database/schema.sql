BEGIN TRANSACTION;

DROP TABLE IF EXISTS examples_tags;
DROP TABLE IF EXISTS examples;
DROP TABLE IF EXISTS languages;
DROP TABLE IF EXISTS tags;

DROP TABLE IF EXISTS users;


DROP SEQUENCE IF EXISTS seq_tag_id;
DROP SEQUENCE IF EXISTS seq_language_id;
DROP SEQUENCE IF EXISTS seq_example_id;
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
  
CREATE SEQUENCE seq_language_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;
  
 CREATE SEQUENCE seq_tag_id
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

CREATE TABLE languages (
    language_id int DEFAULT nextval('seq_language_id'::regclass) NOT NULL,
    language_name varchar(50) NOT NULL,
    
    CONSTRAINT PK_languages PRIMARY KEY (language_id)    
    
);

CREATE TABLE tags (
    tag_id int DEFAULT nextval('seq_tag_id'::regclass) NOT NULL,
    tag_name varchar(50) NOT NULL,
    
    CONSTRAINT PK_tags PRIMARY KEY (tag_id)
);




CREATE TABLE examples (
    example_id int DEFAULT nextval('seq_example_id'::regclass) NOT NULL,
    title varchar(50) NOT NULL,
    description varchar (500),
    user_id int NOT NULL,
    language_id int NOT NULL,
    code_example text NOT NULL,
    is_private boolean NOT NULL,
    attribution varchar(200),
    is_default boolean,

    CONSTRAINT PK_examples PRIMARY KEY (example_id),
    CONSTRAINT FK_examples_languages FOREIGN KEY (language_id) REFERENCES languages(language_id),
    CONSTRAINT FK_examples_users FOREIGN KEY (user_id) REFERENCES users (user_id)
);



CREATE TABLE examples_tags (
    example_id int NOT NULL,
    tag_id int NOT NULL,
    
    CONSTRAINT FK_examples_tags FOREIGN KEY (example_id) REFERENCES examples(example_id),
    CONSTRAINT FK_tags_examples FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
);


INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');

INSERT INTO tags (tag_name) VALUES ('If Statement'); --tag 1
INSERT INTO tags (tag_name) VALUES ('Loop'); -- tag 2
INSERT INTO tags (tag_name) VALUES ('Console'); -- tag 3
INSERT INTO tags (tag_name) VALUES ('Array'); -- tag 4

INSERT INTO languages (language_name) VALUES ('Java'); -- laguage 1
INSERT INTO languages (language_name) VALUES ('JavaScript'); -- laguage 2
INSERT INTO languages (language_name) VALUES ('Python');  --language 3

INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default, user_id) VALUES ('For Loop', 1, '102,111,114,32,40,105,59,32,105,60,108,101,110,103,116,104,59,32,105,43,43,41,32,123,10,32,32,32,32,47,47,100,111,115,116,117,102,102,59,10,125', true, 'bob', true, 1);
INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default, user_id) VALUES ('If else statement', 1, '105,102,32,40,116,114,117,101,41,32,123,10,32,32,47,47,100,111,32,115,116,117,102,102,59,10,125,10,101,108,115,101,32,123,10,32,32,47,47,100,111,32,111,116,104,101,114,32,115,116,117,102,102,59,10,125', true, 'bob', true, 1);
INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default, user_id) VALUES ('If else statement', 2, '105,102,32,40,116,114,117,101,41,32,123,10,32,32,47,47,100,111,32,115,116,117,102,102,59,10,125,10,101,108,115,101,32,123,10,32,32,47,47,100,111,32,111,116,104,101,114,32,115,116,117,102,102,59,10,125', true, 'bob', true, 1);
INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default, user_id) VALUES ('Console log', 2, '99,111,110,115,111,108,101,46,108,111,103,40,39,112,114,105,110,116,32,116,104,105,110,103,115,32,104,101,114,101,39,41', true, 'bob', true, 1);
INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default, user_id) VALUES ('System Out Print Line', 1, '83,121,115,116,101,109,46,111,117,116,46,112,114,105,110,116,108,110,40,39,115,97,121,32,116,104,105,110,103,115,32,104,101,114,101,39,41', true, 'bob', true, 1);
INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default, user_id) VALUES ('Array with Loop Output', 3, '102,114,117,105,116,115,32,61,32,91,34,97,112,112,108,101,34,44,32,34,98,97,110,97,110,97,34,44,32,34,99,104,101,114,114,121,34,93,10,102,111,114,32,120,32,105,110,32,102,114,117,105,116,115,58,10,32,32,112,114,105,110,116,40,120,41,10', true, 'bob', true, 1);
INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default, user_id) VALUES ('If Else Statement', 3, '97,32,61,32,51,51,10,98,32,61,32,50,48,48,10,105,102,32,98,32,62,32,97,58,10,32,32,112,114,105,110,116,40,34,98,32,105,115,32,103,114,101,97,116,101,114,32,116,104,97,110,32,97,34,41,10', true, 'bob', true, 1);

INSERT INTO examples_tags (example_id, tag_id) VALUES (1, 2);
INSERT INTO examples_tags (example_id, tag_id) VALUES (2, 1);
INSERT INTO examples_tags (example_id, tag_id) VALUES (3, 1);
INSERT INTO examples_tags (example_id, tag_id) VALUES (4, 3);
INSERT INTO examples_tags (example_id, tag_id) VALUES (5, 3);
INSERT INTO examples_tags (example_id, tag_id) VALUES (1, 1);
INSERT INTO examples_tags (example_id, tag_id) VALUES (6, 2);
INSERT INTO examples_tags (example_id, tag_id) VALUES (6, 4);
INSERT INTO examples_tags (example_id, tag_id) VALUES (7, 1);
INSERT INTO examples_tags (example_id, tag_id) VALUES (7, 3);

COMMIT TRANSACTION;



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
    is_favorite boolean,

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
INSERT INTO tags (tag_name) VALUES ('Print'); -- tag 3
INSERT INTO tags (tag_name) VALUES ('Array'); -- tag 4
INSERT INTO tags (tag_name) VALUES ('Insert'); -- tag 5
INSERT INTO tags (tag_name) VALUES ('Error Handling'); -- tag 6

INSERT INTO languages (language_name) VALUES ('Java'); -- laguage 1
INSERT INTO languages (language_name) VALUES ('JavaScript'); -- laguage 2
INSERT INTO languages (language_name) VALUES ('Python');  --language 3
INSERT INTO languages (language_name) VALUES ('SQL');  --language 4
INSERT INTO languages (language_name) VALUES ('C#');  --language 5
INSERT INTO languages (language_name) VALUES ('C++');  --language 6
INSERT INTO languages (language_name) VALUES ('Ruby');  --language 7
INSERT INTO languages (language_name) VALUES ('Elixir');  --language 8
INSERT INTO languages (language_name) VALUES ('Other');  --language 9

INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('For Loop', 'A simple Java for loop.', 1, '102,111,114,32,40,105,59,32,105,60,108,101,110,103,116,104,59,32,105,43,43,41,32,123,10,32,32,32,32,47,47,100,111,32,115,116,117,102,102,59,10,125', false, 'Code Vault', true, 1, false);
INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('If Else Statement', 'A simple Java if statement.', 1, '105,102,32,40,116,114,117,101,41,32,123,10,32,32,47,47,100,111,32,115,116,117,102,102,59,10,125,10,101,108,115,101,32,123,10,32,32,47,47,100,111,32,111,116,104,101,114,32,115,116,117,102,102,59,10,125', false, 'Code Vault', true, 1, false);
INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('If Else Statement', 'A simple JavaScript if statement.', 2, '105,102,32,40,116,114,117,101,41,32,123,10,32,32,47,47,100,111,32,115,116,117,102,102,59,10,125,10,101,108,115,101,32,123,10,32,32,47,47,100,111,32,111,116,104,101,114,32,115,116,117,102,102,59,10,125', false, 'Code Vault', true, 1, false);
INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('Console log', 'A print to the console in JavaScript.', 2, '99,111,110,115,111,108,101,46,108,111,103,40,39,112,114,105,110,116,32,116,104,105,110,103,115,32,104,101,114,101,39,41', false, 'Code Vault', true, 1, false);
INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('System Out Print Line', 'A print to the command line in Java.', 1, '83,121,115,116,101,109,46,111,117,116,46,112,114,105,110,116,108,110,40,39,115,97,121,32,116,104,105,110,103,115,32,104,101,114,101,39,41', false, 'Code Vault', true, 1, false);
INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('Array with Loop Output', 'Creates an array and then loops through it, printing each line.', 3, '102,114,117,105,116,115,32,61,32,91,34,97,112,112,108,101,34,44,32,34,98,97,110,97,110,97,34,44,32,34,99,104,101,114,114,121,34,93,10,102,111,114,32,120,32,105,110,32,102,114,117,105,116,115,58,10,32,32,112,114,105,110,116,40,120,41,10', false, 'Code Vault', true, 1, false);
INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('If Else Statement', 'A simple Python if statement.', 3, '97,32,61,32,51,51,10,98,32,61,32,50,48,48,10,105,102,32,98,32,62,32,97,58,10,32,32,112,114,105,110,116,40,34,98,32,105,115,32,103,114,101,97,116,101,114,32,116,104,97,110,32,97,34,41,10', false, 'Code Vault', true, 1, false);
INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('Change Converter', 'Converts change from a remaining amount.', 1, '112,117,98,108,105,99,32,83,116,114,105,110,103,32,109,97,107,101,67,104,97,110,103,101,40,41,32,123,10,32,32,32,32,32,32,32,32,105,102,32,40,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,61,61,32,48,41,32,123,10,32,32,32,32,32,32,32,32,32,32,32,32,114,101,116,117,114,110,32,34,78,111,32,99,104,97,110,103,101,32,110,101,101,100,101,100,46,34,59,10,32,32,32,32,32,32,32,32,125,10,10,32,32,32,32,32,32,32,32,83,116,114,105,110,103,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,61,32,34,34,59,10,10,32,32,32,32,32,32,32,32,47,47,32,118,97,114,105,97,98,108,101,115,32,102,111,114,32,100,101,110,111,109,105,110,97,116,105,111,110,115,10,32,32,32,32,32,32,32,32,105,110,116,32,116,119,101,110,116,105,101,115,32,61,32,40,105,110,116,41,40,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,47,32,50,48,41,59,10,32,32,32,32,32,32,32,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,61,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,37,32,50,48,59,10,32,32,32,32,32,32,32,32,105,110,116,32,116,101,110,115,32,61,32,40,105,110,116,41,40,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,47,32,49,48,41,59,10,32,32,32,32,32,32,32,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,61,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,37,32,49,48,59,10,32,32,32,32,32,32,32,32,105,110,116,32,102,105,118,101,115,32,61,32,40,105,110,116,41,40,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,47,32,53,41,59,10,32,32,32,32,32,32,32,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,61,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,37,32,53,59,10,32,32,32,32,32,32,32,32,105,110,116,32,111,110,101,115,32,61,32,40,105,110,116,41,40,97,99,99,111,117,110,116,66,97,108,97,110,99,101,41,59,10,32,32,32,32,32,32,32,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,61,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,37,32,49,59,10,32,32,32,32,32,32,32,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,61,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,42,32,49,48,48,59,32,32,47,47,116,117,114,110,32,100,111,108,108,97,114,115,32,116,111,32,112,101,110,110,105,101,115,10,32,32,32,32,32,32,32,32,105,110,116,32,113,117,97,114,116,101,114,115,32,61,32,40,105,110,116,41,40,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,47,32,50,53,41,59,10,32,32,32,32,32,32,32,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,61,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,37,32,50,53,59,10,32,32,32,32,32,32,32,32,105,110,116,32,100,105,109,101,115,32,61,32,40,105,110,116,41,40,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,47,32,49,48,41,59,10,32,32,32,32,32,32,32,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,61,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,37,32,49,48,59,10,32,32,32,32,32,32,32,32,105,110,116,32,110,105,99,107,101,108,115,32,61,32,40,105,110,116,41,40,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,47,32,53,41,59,10,32,32,32,32,32,32,32,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,61,32,97,99,99,111,117,110,116,66,97,108,97,110,99,101,32,37,32,53,59,10,10,32,32,32,32,32,32,32,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,61,32,34,92,110,89,111,117,32,114,101,99,101,105,118,101,100,32,34,59,10,32,32,32,32,32,32,32,32,105,102,32,40,116,119,101,110,116,105,101,115,32,62,32,48,32,41,32,123,10,32,32,32,32,32,32,32,32,32,32,32,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,61,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,43,32,34,40,34,32,43,32,116,119,101,110,116,105,101,115,32,43,32,34,41,32,84,119,101,110,116,105,101,115,44,32,34,59,10,32,32,32,32,32,32,32,32,125,10,32,32,32,32,32,32,32,32,105,102,32,40,116,101,110,115,32,62,32,48,41,32,123,10,32,32,32,32,32,32,32,32,32,32,32,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,61,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,43,32,34,40,34,32,43,32,116,101,110,115,32,43,32,34,41,32,84,101,110,115,44,32,34,59,10,32,32,32,32,32,32,32,32,125,10,32,32,32,32,32,32,32,32,105,102,32,40,102,105,118,101,115,32,62,32,48,41,32,123,10,32,32,32,32,32,32,32,32,32,32,32,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,61,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,43,32,34,40,34,32,43,32,102,105,118,101,115,32,43,32,34,41,32,70,105,118,101,115,44,32,34,59,10,32,32,32,32,32,32,32,32,125,10,32,32,32,32,32,32,32,32,105,102,32,40,111,110,101,115,32,62,32,48,41,32,123,10,32,32,32,32,32,32,32,32,32,32,32,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,61,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,43,32,34,40,34,32,43,32,111,110,101,115,32,43,32,34,41,32,79,110,101,115,44,32,34,59,10,32,32,32,32,32,32,32,32,125,10,32,32,32,32,32,32,32,32,105,102,32,40,113,117,97,114,116,101,114,115,32,62,32,48,41,32,123,10,32,32,32,32,32,32,32,32,32,32,32,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,61,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,43,32,34,40,34,32,43,32,113,117,97,114,116,101,114,115,32,43,32,34,41,32,81,117,97,114,116,101,114,115,44,32,34,59,10,32,32,32,32,32,32,32,32,125,10,32,32,32,32,32,32,32,32,105,102,32,40,100,105,109,101,115,32,62,32,48,41,32,123,10,32,32,32,32,32,32,32,32,32,32,32,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,61,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,43,32,34,40,34,32,43,32,100,105,109,101,115,32,43,32,34,41,32,68,105,109,101,115,44,32,34,59,10,32,32,32,32,32,32,32,32,125,10,32,32,32,32,32,32,32,32,105,102,32,40,110,105,99,107,101,108,115,32,62,32,48,41,32,123,10,32,32,32,32,32,32,32,32,32,32,32,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,61,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,43,32,34,40,34,32,43,32,110,105,99,107,101,108,115,32,43,32,34,41,32,78,105,99,107,101,108,115,44,32,34,59,10,32,32,32,32,32,32,32,32,125,10,32,32,32,32,32,32,32,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,61,32,99,104,97,110,103,101,65,109,111,117,110,116,115,32,43,32,34,105,110,32,99,104,97,110,103,101,46,92,110,34,59,10,10,32,32,32,32,32,32,32,32,114,101,116,117,114,110,32,99,104,97,110,103,101,65,109,111,117,110,116,115,59,10,32,32,32,32,125', false, 'Code Vault', true, 1, false);
INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('Insert Into Table', 'An insert for SQL', 4, '73,78,83,69,82,84,32,73,78,84,79,32,116,97,98,108,101,32,40,110,97,109,101,44,32,118,97,108,117,101,41,10,86,65,76,85,69,83,32,40,39,74,111,104,110,32,68,111,101,39,44,32,49,50,51,52,53,41', false, 'Code Vault', true, 1, false);
INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('Hello World', 'A print to the command line in C#.', 5, '83,121,115,116,101,109,46,67,111,110,115,111,108,101,46,87,114,105,116,101,76,105,110,101,40,34,72,101,108,108,111,32,87,111,114,108,100,33,34,41,59', false, 'Code Vault', true, 1, false);
INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('While Loop', 'A while loop in Ruby.', 7, '97,32,61,32,53,10,119,104,105,108,101,32,97,32,62,32,49,10,32,32,112,117,116,115,32,34,67,111,100,101,32,86,97,117,108,116,34,10,32,32,97,32,61,32,97,32,45,32,49,10,101,110,100', false, 'Code Vault', true, 1, false);
INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('Loop Through to Print', 'Looping through an array and printing the names out.', 6, '115,116,114,105,110,103,32,99,97,114,115,91,52,93,32,61,32,123,34,86,111,108,118,111,34,44,32,34,66,77,87,34,44,32,34,70,111,114,100,34,44,32,34,77,97,122,100,97,34,125,59,10,102,111,114,40,105,110,116,32,105,32,61,32,48,59,32,105,32,60,32,52,59,32,105,43,43,41,32,123,10,32,32,99,111,117,116,32,60,60,32,99,97,114,115,91,105,93,32,60,60,32,34,92,110,34,59,10,125,10', false, 'Code Vault', true, 1, false);
INSERT INTO examples (title, description, language_id, code_example, is_private, attribution, is_default, user_id, is_favorite) VALUES ('Teapot Error', 'I am a teapot.', 9, '52,49,56', false, 'Code Vault', true, 1, false);

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
INSERT INTO examples_tags (example_id, tag_id) VALUES (8, 1);
INSERT INTO examples_tags (example_id, tag_id) VALUES (9, 5);
INSERT INTO examples_tags (example_id, tag_id) VALUES (10, 3);
INSERT INTO examples_tags (example_id, tag_id) VALUES (11, 2);
INSERT INTO examples_tags (example_id, tag_id) VALUES (12, 2);
INSERT INTO examples_tags (example_id, tag_id) VALUES (12, 3);
INSERT INTO examples_tags (example_id, tag_id) VALUES (12, 4);
INSERT INTO examples_tags (example_id, tag_id) VALUES (13, 6);

COMMIT TRANSACTION;




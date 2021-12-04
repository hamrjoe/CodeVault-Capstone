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

INSERT INTO examples (title, language_id, code_example, is_private, attribution, is_default) VALUES ('loop', 1, 'for (int i = 0; i < 5; i++) {\n    System.out.println(i);\n}', true, 'bob', true);


INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');


COMMIT TRANSACTION;

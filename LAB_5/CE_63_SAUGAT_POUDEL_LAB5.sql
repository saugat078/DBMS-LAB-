CREATE TABLE USERS (
	ID int,
	username varchar(20),
	email varchar(50),
	first_name varchar(20),
	last_name varchar(20),
	dob DATE,
	age int
);
alter table users 
add column fullname varchar(20);
select * from users

CREATE TABLE user_logs(
	id int,
	old_value varchar(20),
	new_value varchar(20),
	description varchar(20),
	log_time timestamp
);
INSERT INTO USERS(ID,username,email,first_name,last_name,dob)
VALUES('1','saugat','saugat.poudel@gmail.com','saugat','poudel','01-02-2000'),
	  ('2','Ronaldo','ronaldo@gmail.com','cristiano','Ronaldo','05-02-1986'),
	  ('3','Lionel','lionel@gmail.com','lionel','messi','07-03-1988');
SELECT * FROM USERS;
DROP TABLE USERS;
	  
--1) function that returns full name of user with the given id	  
CREATE OR REPLACE FUNCTION fullname(uid integer)
	RETURNS character varying
	AS
	$$
	DECLARE 
		fname CHARACTER VARYING;
		lname CHARACTER VARYING;
	BEGIN
		SELECT first_name, last_name INTO fname,lname FROM users WHERE ID=Uid;
		RETURN fname || ' '||lname;
	END;
	$$ LANGUAGE plpgsql;
	
SELECT * FROM fullname(2);

--2) function that returns the number of users
CREATE OR REPLACE FUNCTION count_users()
	RETURNS INTEGER 
	AS
	$$
	BEGIN
		RETURN(
		 SELECT COUNT(ID) FROM USERS
		);
	END;
	$$ LANGUAGE plpgsql;
SELECT * FROM count_users();

--3 Function that returns the age of the user with the given ID
CREATE OR REPLACE FUNCTION user_age_id(uid integer)
	RETURNS INTEGER 
	AS
	$$
	DECLARE user_age int;
			dob_user date;
	BEGIN
		SELECT dob INTO dob_user FROM USERS WHERE ID=uid;
		user_age = DATE_PART('year', now()) - DATE_PART('year', dob_user);
		UPDATE USERS SET age = user_age WHERE ID = uid;
		RETURN user_age;
	END;
	$$ LANGUAGE plpgsql;
SELECT user_age_id(1);
SELECT * FROM USERS;

--4 STORED PROCEDURE
--1 SP to update the full name of the user with the given ID
CREATE OR REPLACE PROCEDURE populate_fullname(uid integer)
	AS
	$$
	BEGIN 
		UPDATE USERS SET fullname= first_name||' '|| last_name WHERE ID=uid;
	end;
	$$ language plpgsql;
CALL populate_fullname(2);
SELECT * FROM USERS;

--4.2 SP to update the age of the user with the given ID
CREATE PROCEDURE age_update(uid INTEGER)
	AS
	$$
	DECLARE user_age INTEGER;
	DECLARE user_dob DATE;
	BEGIN
		SELECT dob into user_dob FROM USERS WHERE ID = uid;
		user_age = DATE_PART('year', now()) - DATE_PART('year', user_dob);
		UPDATE USERS SET age = user_age WHERE ID = uid;
	END;
	$$ LANGUAGE plpgsql;
	
CALL age_update(2);
SELECT * FROM Users;

--5)create the following triggers
--5.1) Trigger that populates full name on adding a new user

CREATE OR REPLACE FUNCTION compute_fullname() RETURNS TRIGGER
	AS
	$$
	DECLARE fullname character varying;
	BEGIN
		fullname= NEW.first_name || ' '|| NEW.last_name;
		NEW.fullname = fullname;
		RETURN NEW;
	END;
	$$
	LANGUAGE plpgsql;

CREATE TRIGGER full_name 
BEFORE INSERT
ON USERS FOR EACH ROW
EXECUTE FUNCTION compute_fullname();
DROP TRIGGER full_name
ON USERS

INSERT INTO USERS(ID,username, email, first_name, last_name, dob)
VALUES
(4,'Suman32','suman@gmail.com', 'Suman', 'Upreti', '2001-01-26');
SELECT * FROM Users;


--5.2)Trigger that populates age on adding a new user
CREATE OR REPLACE FUNCTION populate_age()
	RETURNS trigger
	AS
	$$
	DECLARE
	user_age INTEGER;
	user_dob DATE;
	BEGIN
		SELECT dob INTO user_dob FROM Users WHERE ID = NEW.id;
		user_age = DATE_PART('year', now()) - DATE_PART('year', user_dob);
		UPDATE USERS SET age = user_age WHERE ID = NEW.id;
		RETURN NEW;
	END;
	$$ LANGUAGE plpgsql;

CREATE TRIGGER age_populater 
AFTER INSERT
ON USERS FOR EACH ROW
EXECUTE FUNCTION populate_age();


INSERT INTO USERS(ID,username, email, first_name, last_name, dob)
VALUES(5,'Sagar', 'Sagar@gmail.com', 'Sagar', 'Paudel', '2000-01-21');
SELECT * FROM USERS;

--5.3)Trigger that inserts a new row in user_logs if any value is updated in users table. 
--If last name of a user is updated, the following values must be inserted into the user_logs table:
--<old last name>, <new last name>, 'Last name updated', current time


CREATE OR REPLACE FUNCTION user_log()
RETURNS TRIGGER 
AS $$
BEGIN
	IF NEW.last_name <> OLD.last_name THEN
		INSERT INTO user_logs(old_value,new_value,description,log_time)
			Values(OLD.last_name,NEW.last_name,'updated last_name',now());
	END IF;
	IF NEW.first_name <> OLD.first_name THEN
		INSERT INTO user_logs(old_value,new_value,description,log_time)
			Values(OLD.first_name,NEW.first_name,'updated first_name',now());
	END IF;
	
	IF NEW.dob <> OLD.dob THEN
		INSERT INTO user_logs(old_value,new_value,description,log_time)
			Values(OLD.dob,NEW.dob,'updated dob',now());
	END IF;
	IF NEW.username <> OLD.username THEN
		INSERT INTO user_logs(old_value,new_value,description,log_time)
			Values(OLD.username,NEW.username,'updated username',now());
	END IF;
	
	RETURN NEW;
END 
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER logs
	AFTER UPDATE
	ON USERS
	FOR EACH ROW
	EXECUTE PROCEDURE user_log();
DROP TRIGGER LOGS 
ON USERS;
	
UPDATE USERS SET last_name ='Poudel' WHERE id =1;
UPDATE USERS SET first_name ='Harry' where id =3;
UPDATE USERS SET username ='sam321' where id =2;

SELECT * FROM user_logs;
SELECT * FROM users;

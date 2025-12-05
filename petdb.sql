CREATE DATABASE PETDB;
USE PETDB;

DROP TABLE IF EXISTS VISIT CASCADE;
DROP TABLE IF EXISTS VET CASCADE;
DROP TABLE IF EXISTS PET CASCADE;
DROP TABLE IF EXISTS OWNER CASCADE;

CREATE TABLE OWNER(
	ID INT PRIMARY KEY,
	NAME TEXT NOT NULL,
    PHONE TEXT NOT NULL);

CREATE TABLE pet (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  species TEXT NOT NULL,
  breed TEXT,
  age INTEGER,
  owner_id INTEGER,
  CONSTRAINT pet_owner_id FOREIGN KEY (owner_id) REFERENCES owner (id)
);


CREATE TABLE vet (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  license TEXT NOT NULL
);

CREATE TABLE visit (
  id INTEGER PRIMARY KEY,
  pet_id INTEGER NOT NULL,
  vet_id INTEGER NOT NULL,
  visit_date DATE NOT NULL,
  diagnosis TEXT NOT NULL,
  CONSTRAINT visit_pet_id FOREIGN KEY (pet_id) REFERENCES pet (id),
  CONSTRAINT visit_vet_id FOREIGN KEY (vet_id) REFERENCES vet (id)
);

-- Insert data into the tables
INSERT INTO owner (id, name, phone) VALUES (1, 'Amal', '800-555-0100');
INSERT INTO owner (id, name, phone) VALUES (2, 'Cruz', '800-555-0123');
INSERT INTO owner (id, name, phone) VALUES (3, 'Jie', '800-555-0150');

INSERT INTO pet (id, name, species, breed, age, owner_id) VALUES (1, 'Mewmew', 'cat', 'Tabby', 10, 1);
INSERT INTO pet (id, name, species, breed, age, owner_id) VALUES (2, 'Whiskers', 'cat', 'Calico', 1, 2);
INSERT INTO pet (id, name, species, breed, age, owner_id) VALUES (3, 'Lil'' Bub', 'cat', 'American Shorthair', 5, 2);
INSERT INTO pet (id, name, species, breed, age, owner_id) VALUES (4, 'Snuggles', 'dog', 'Bichon', 5, 3);
INSERT INTO pet (id, name, species, breed, age, owner_id) VALUES (5, 'Honey', 'dog', 'Pug', 1, 3);

INSERT INTO vet (id, name, license) VALUES (1, 'Dr. Furry', 'OH1234');
INSERT INTO vet (id, name, license) VALUES (2, 'Dr. Bones', 'NY9999');

INSERT INTO visit (id, pet_id, vet_id, visit_date, diagnosis) VALUES (1, 1, 2, '2022-01-20', 'fleas');
INSERT INTO visit (id, pet_id, vet_id, visit_date, diagnosis) VALUES (2, 1, 2, '2022-03-18', 'hairball');
INSERT INTO visit (id, pet_id, vet_id, visit_date, diagnosis) VALUES (3, 4, 1, '2022-01-28', 'ear infection');
INSERT INTO visit (id, pet_id, vet_id, visit_date, diagnosis) VALUES (4, 3, 2, '2022-09-01', 'sore paw');

SELECT * FROM PET;

-- SEE THE QUERY PLAN WITHOUT INDEX(PERFORMS FULL TABLE SCAN)
EXPLAIN SELECT * FROM PET WHERE NAME = 'SNUGGLES';

-- CREATE AN INDEX ON THE PET NAME COLUMN FOR FASTER LOOKUPS
CREATE INDEX idx_pet_name ON pet(name(100));

-- SEE THE QUERY PLAN AGAIN WITH THE INDEX (NOW USES THE INDEX)
EXPLAIN SELECT * FROM PET WHERE NAME = 'SNUGGLES';

-- FIND ALL PETS OWNED BY 'CRUZ' USING in
SELECT NAME, SPECIES FROM PET
WHERE OWNER_ID IN (SELECT ID FROM OWNER WHERE NAME = 'CRUZ');

-- FIND PETS THAT HAVE A RECORD IN VISIT TABLE USING EXISTS
SELECT NAME FROM PET
WHERE EXISTS (SELECT 1 FROM VISIT WHERE VISIT.PET_ID = PET.ID);

-- INNER JOIN: GET PETS & THEIR OWNER NAME
SELECT P.NAME AS PET_NAME, O.NAME AS OWNER_NAME FROM PET p
INNER JOIN OWNER O ON P.OWNER_ID = O.ID;

-- LEFT JOIN: LIST ALL OWNERS AND THEIR PETS IF ANY
-- FIRST ADD AN OWNER WITHOUT PET FOR EXM
INSERT INTO OWNER (ID, NAME, PHONE) VALUES (4, 'DANA', '800-555-0199');

SELECT O.NAME AS OWNER_NAME, P.NAME AS PET_NAME FROM OWNER o
LEFT JOIN PET p ON o.id = p.owner_id;

-- RIGHT JOIN: LIST ALL PETS & THEIR OWNERS, IF ANY
-- FIRST, ADD A PER WITHOUT AN OWNER FOR EXM
INSERT INTO PET (ID, NAME, SPECIES, BREED, AGE, OWNER_ID)
VALUES (6, 'STRAY', 'CAT', 'UNKNOWN', 2, NULL);

SELECT p.name AS PET_NAME, o.name AS OWNER_NAME FROM OWNER o
RIGHT JOIN PET p ON o.id = p.owner_id;

-- UNION (IF WANT TO INCLUDE DUPLICATE VALUES USE UNION ALL)
SELECT NAME FROM PET 
UNION
SELECT NAME FROM VET;


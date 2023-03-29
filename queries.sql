/*Queries that provide answers to the questions from all projects.*/

SELECT * 
FROM animals 
WHERE name LIKE '%mon';

SELECT * 
FROM animals 
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT * 
FROM animals 
WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth 
FROM animals 
WHERE name = 'Agumon' OR name= 'Pikachu';

SELECT name, escape_attempts
FROM animals 
WHERE weight_kg > 10.5;

SELECT * 
FROM animals 
WHERE neutered = true;

SELECT * 
FROM animals 
WHERE name != 'Gabumon';

SELECT *
FROM animals 
WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- 1st transaction
BEGIN;

UPDATE animals
SET species = 'unspecified';

SELECT *
FROM animals;

ROLLBACK;

SELECT *
FROM animals;

-- 2nd transaction
BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT *
FROM animals;

COMMIT;

SELECT *
FROM animals;

-- 3rd transaction
BEGIN;

DELETE FROM animals;

SELECT *
FROM animals;

ROLLBACK;

SELECT *
FROM animals;

-- 4th transaction
BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP1;

UPDATE animals
SET weight_kg = weight_kg * -1;

SELECT *
FROM animals;

ROLLBACK TO SP1;

SELECT *
FROM animals;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

SELECT *
FROM animals;

COMMIT;

SELECT *
FROM animals;

-- More queries
SELECT COUNT(*) AS animals
FROM animals;

SELECT COUNT(*) AS animals_never_tried_to_escape
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS average_weight_of_animals
FROM animals;

SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered
ORDER BY SUM(escape_attempts) DESC
LIMIT 1;

SELECT species AS type_of_animal, MIN(weight_kg) AS min_weight_kg, MAX(weight_kg) AS max_weight_kg
FROM animals
GROUP BY type_of_animal;

SELECT species AS type_of_animal, AVG(escape_attempts) AS average_of_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY type_of_animal;





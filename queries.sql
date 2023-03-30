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

-- Queries using JOIN
SELECT name AS animal_name, full_name AS owner_full_name 
FROM animals
JOIN owners
  ON animals.owner_id = owners.id
  WHERE full_name = 'Melody Pond';

SELECT animals.name AS pokemon_animals 
FROM animals
JOIN species
  ON animals.species_id = species.id
  WHERE species.name = 'Pokemon';

SELECT full_name AS owner_full_name, name AS animal_name
FROM owners
LEFT JOIN animals
  ON animals.owner_id = owners.id;

SELECT species.name AS species_name, COUNT(species_id) AS total
FROM species
JOIN animals
  ON animals.species_id = species.id
  GROUP BY species.name;

SELECT name AS Digimons, full_name AS owner_full_name 
FROM animals
JOIN owners
  ON animals.owner_id = owners.id
  WHERE full_name = 'Jennifer Orwell' AND name LIKE '%mon';

SELECT name AS animal_name, full_name AS owner_full_name 
FROM animals
JOIN owners
  ON animals.owner_id = owners.id
  WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT full_name AS owner_full_name, COUNT(owner_id) AS number_of_animals
FROM animals
JOIN owners
  ON animals.owner_id = owners.id
  GROUP BY full_name
  ORDER BY number_of_animals DESC
  LIMIT 1;

-- More queries

SELECT animals.name AS "last animal seen by William Tatcher"
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_the_visit DESC
LIMIT 1;

SELECT COUNT(animals.name) AS "number of different animals Stephanie Mendez saw"
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name AS vet_name, species.name AS specialties
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON species.id = specializations.species_id;
WHERE vets.name = 'Stephanie Mendez';

SELECT animals.name AS animals, vets.name AS vet_name
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' 
  AND date_of_the_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name AS animals, COUNT(visits.animal_id) AS "number of visits to vet"
FROM animals
JOIN visits
ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY "number of visits to vet" DESC
LIMIT 1;

SELECT animals.name AS "Maisy Smith's first visit"
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_the_visit ASC
LIMIT 1;

SELECT animals.name AS animal_name, vets.name AS vet_name, date_of_the_visit
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON vets.id = visits.vet_id
ORDER BY date_of_the_visit DESC
LIMIT 1;

SELECT COUNT(visits.animal_id) AS "number of visits"
FROM visits
LEFT JOIN specializations
ON visits.vet_id = specializations.vet_id
GROUP BY specializations.vet_id
HAVING specializations.vet_id IS NULL;

SELECT species.name AS "specialty Maisie Smith should consider getting"
FROM animals
JOIN species
ON animals.species_id = species.id
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.id
ORDER BY COUNT(species.id) DESC
LIMIT 1;


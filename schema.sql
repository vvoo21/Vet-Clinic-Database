/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INT GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(100),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

ALTER TABLE animals
ADD PRIMARY KEY (id);

ALTER TABLE animals
ADD species VARCHAR(100);

CREATE TABLE owners (
  id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  full_name VARCHAR(100),
  age INT
);

CREATE TABLE species (
  id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  name VARCHAR(100)
);

-- Modify animals table
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species (id)
ON DELETE CASCADE;

ALTER TABLE animals ADD owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owners
FOREIGN KEY (owner_id)
REFERENCES owners (id)
ON DELETE CASCADE;

CREATE TABLE vets (
  id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  name VARCHAR(100),
  age INT,
  date_of_graduation DATE
);

CREATE TABLE specializations (
  species_id INT REFERENCES species (id) ON DELETE CASCADE,
  vet_id INT REFERENCES vets (id) ON DELETE CASCADE,
  PRIMARY KEY (species_id, vet_id)
);

CREATE TABLE visits (
  id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  animal_id INT REFERENCES animals (id) ON DELETE CASCADE,
  vet_id INT REFERENCES vets (id) ON DELETE CASCADE,
  date_of_the_visit DATE
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX animal_id_index ON visits(animal_id);
CREATE INDEX vet_id_index ON visits(vet_id) include(animal_id, date_of_the_visit);
CREATE INDEX email_index ON owners(email);

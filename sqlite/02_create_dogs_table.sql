CREATE TABLE dogs (
  id INTEGER PRIMARY KEY,
    name TEXT,
    age INTEGER,
    weight INTEGER,
    breed TEXT
);

ALTER TABLE dogs ADD COLUMN height INTEGER;
INSERT INTO dogs (name, age, weight, breed) VALUES ('Fido', 2, 2.34, 'Dashund');
INSERT INTO dogs (name, age, weight, breed) VALUES ('Max', 4, 4.34, 'Beagle');
INSERT INTO dogs (name, age, weight, breed) VALUES ('Spot', 7, 34.4, 'Great Dane');
INSERT INTO dogs (name, age, weight, breed) VALUES ('Oliver', 6, 25.3, 'Collie');

CREATE TABLE dogs (
  id INTEGER PRIMARY KEY,
    name TEXT,
    age INTEGER,
    weight INTEGER,
    breed TEXT
);

ALTER TABLE dogs ADD COLUMN owner_id INTEGER;
ALTER TABLE dogs ADD COLUMN net_worth INTEGER;
INSERT INTO dogs (name, age, weight, breed, owner_id, net_worth) VALUES ('Fido', 2, 2.34, 'Dashund', 2, 100);
INSERT INTO dogs (name, age, weight, breed, owner_id, net_worth) VALUES ('Max', 4, 4.34, 'Beagle', 4, 1000);
INSERT INTO dogs (name, age, weight, breed, owner_id, net_worth) VALUES ('Spot', 7, 34.4, 'Great Dane', 1, 24);
INSERT INTO dogs (name, age, weight, breed, owner_id, net_worth) VALUES ('Oliver', 6, 25.3, 'Collie', 1, 35);
INSERT INTO dogs (name, age, weight, breed, owner_id, net_worth) VALUES ('Roger', 3, 5.3, 'Pit Bull', 3, 150);
INSERT INTO dogs (name, age, weight, breed, owner_id, net_worth) VALUES ('Rex', 10, 35.8, 'Alsatian', 5, 1100);
INSERT INTO dogs (name, age, weight, breed, owner_id, net_worth) VALUES ('Mike', 2, 5.3, 'Corgi', 5, 1200);

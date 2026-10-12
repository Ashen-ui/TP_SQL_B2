CREATE TYPE userClass AS ENUM (
    'Warrior',
    'Mage',
    'Archer'
);


CREATE TABLE players(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY(1,1),
    username VARCHAR(25) NOT NULL UNIQUE,
    email VARCHAR(200) NOT NULL UNIQUE,
    password_hash varchar(255) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE CharacterClass(
    id INT PRIMARY KEY AUTOINCREMENT,
    name userClass,
    description TEXT,
    base_health int,
    base_attack int,
    base_defense int
);

CREATE TABLE Character(
    id INT PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    class_id INT REFERENCES CharacterClass(id),
    level int DEFAULT 1,
    health int,
    attack int,
    defense int
);

CREATE TABLE CharacterList(
    id INT PRIMARY KEY AUTOINCREMENT,
    player_id INT REFERENCES players(id),
    1_character_id INT REFERENCES Character(id),
    2_character_id INT REFERENCES Character(id),
    3_character_id INT REFERENCES Character(id),
    4_character_id INT REFERENCES Character(id),
    5_character_id INT REFERENCES Character(id)
);
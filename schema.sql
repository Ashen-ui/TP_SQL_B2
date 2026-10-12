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

CREATE TABLE GameReplay(
    id INT PRIMARY KEY AUTOINCREMENT,
    1_1player_id INT REFERENCES players(id),
    2_1player_id INT REFERENCES players(id),
    3_1player_id INT REFERENCES players(id),
    4_1player_id INT REFERENCES players(id),
    5_1player_id INT REFERENCES players(id),

    1_2player_id INT REFERENCES players(id),
    2_2player_id INT REFERENCES players(id),
    3_2player_id INT REFERENCES players(id),
    4_2player_id INT REFERENCES players(id),
    5_2player_id INT REFERENCES players(id),

    date_game TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    time_duration TIMESTAMP,
)
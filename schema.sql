CREATE TYPE userClass AS ENUM (
    'Warrior',
    'Mage',
    'Archer'
);


CREATE TABLE players(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR(25) NOT NULL UNIQUE,
    email VARCHAR(200) NOT NULL UNIQUE,
    password_hash varchar(255) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    character_id INT REFERENCES Character(id)
);

CREATE TABLE Party(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nameParty VARCHAR(25) NOT NULL UNIQUE
);

CREATE TABLE MembreParty(
    players_id INT ,
    party_id INT,

    chef_players_id INT,
    chef_party_id INT,

    PRIMARY KEY(players_id, party_id),

    FOREIGN KEY (players_id) REFERENCES players(id),
    FOREIGN KEY (Party_id) REFERENCES Party(id),
    FOREIGN KEY (chef_players_id, chef_party_id) REFERENCES MembreParty(players_id, party_id)
);

CREATE TABLE CharacterClass(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name userClass,
    description TEXT,
    base_health int,
    base_attack int,
    base_defense int
);

CREATE TABLE Character(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    class_id INT REFERENCES CharacterClass(id),
    level int DEFAULT 1,
    health int,
    attack int,
    defense int
);

CREATE TABLE GameReplay(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    team1_player1_id INT REFERENCES players(id),
    team1_player2_id INT REFERENCES players(id),
    team1_player3_id INT REFERENCES players(id),
    team1_player4_id INT REFERENCES players(id),
    team1_player5_id INT REFERENCES players(id),

    team2_player1_id INT REFERENCES players(id),
    team2_player2_id INT REFERENCES players(id),
    team2_player3_id INT REFERENCES players(id),
    team2_player4_id INT REFERENCES players(id),
    team2_player5_id INT REFERENCES players(id),

    date_game TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    time_duration TIMESTAMP
);
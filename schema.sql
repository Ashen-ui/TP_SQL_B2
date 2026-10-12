CREATE TYPE userClass AS ENUM(
    'Warrior',
    'Mage',
    'Archer'
);

CREATE TABLE CharacterClass(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name userClass NOT NULL UNIQUE,
    base_health INT NOT NULL CHECK (base_health  > 0),
    base_attack INT NOT NULL CHECK (base_attack  > 0),
    base_defense INT NOT NULL CHECK (base_defense > 0)
);

CREATE TABLE Party(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    parent_party_id INT REFERENCES Party(id),
    CHECK (parent_party_id <> id)
);

CREATE TABLE players(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR(25)  NOT NULL UNIQUE,
    email VARCHAR(200) NOT NULL UNIQUE,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
    class_id INT NOT NULL REFERENCES CharacterClass(id),
    party_id INT NOT NULL REFERENCES Party(id)
);

CREATE TABLE GameCharacter(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player_id INT NOT NULL REFERENCES players(id),
    name VARCHAR(100) NOT NULL,
    class_id INT NOT NULL REFERENCES CharacterClass(id),
    level INT NOT NULL DEFAULT 1 CHECK (level >= 1),
    health INT CHECK (health  >= 0),
    attack INT CHECK (attack  >= 0),
    defense INT CHECK (defense >= 0)
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
    time_duration INTERVAL
);

CREATE TABLE MemberParty(
    players_id INT NOT NULL REFERENCES players(id),
    party_id INT NOT NULL REFERENCES Party(id),
    leader_id INT NOT REFERENCES players(id),
    PRIMARY KEY (players_id, party_id)
);

CREATE TABLE gameScore(
    game_id INT NOT NULL REFERENCES GameReplay(id),
    player_id INT NOT NULL REFERENCES players(id),
    score INT NOT NULL CHECK (score >= 0),
    PRIMARY KEY (game_id, player_id)
);
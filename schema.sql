CREATE TYPE userClass AS ENUM(
    'Warrior',
    'Mage',
    'Archer'
);

CREATE TABLE character_class(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name userClass NOT NULL,
    base_health  INT NOT NULL,
    base_attack  INT NOT NULL,
    base_defense INT NOT NULL
);

CREATE TABLE Party(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    parent_party_id INT REFERENCES Party(id)
);

CREATE TABLE players(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR(25)  NOT NULL UNIQUE,
    email VARCHAR(200) NOT NULL UNIQUE,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
    class_id INT NOT NULL REFERENCES character_class(id),
    party_id INT NOT NULL REFERENCES Party(id)
);

CREATE TABLE Character(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player_id INT NOT NULL REFERENCES players(id),
    name VARCHAR(100) NOT NULL,
    class_id INT NOT NULL REFERENCES character_class(id),
    level INT DEFAULT 1,
    health INT,
    attack INT,
    defense INT
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
    players_id INT ,
    party_id INT,

    leader_player_id INT,
    leader_party_id INT,

    PRIMARY KEY(players_id, party_id),

    FOREIGN KEY (players_id) REFERENCES players(id),
    FOREIGN KEY (Party_id) REFERENCES Party(id),
    FOREIGN KEY (leader_player_id, leader_party_id) REFERENCES MemberParty(players_id, party_id)
);

CREATE TABLE gameScore(
    game_id INT NOT NULL REFERENCES GameReplay(id),
    player_id INT NOT NULL REFERENCES players(id),
    score INT NOT NULL CHECK (score >= 0),
    PRIMARY KEY (game_id, player_id)
);
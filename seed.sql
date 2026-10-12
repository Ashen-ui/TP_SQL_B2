INSERT INTO players (username, email, password_hash) VALUES
    ('Alice', 'alice@example.com', 'hashed_password_1'),
    ('Bob', 'bob@example.com', 'hashed_password_2'),
    ('Charlie', 'charlie@example.com', 'hashed_password_3'),
    ('David', 'david@example.com', 'hashed_password_4'),
    ('Eve', 'eve@example.com', 'hashed_password_5'),
    ('Frank', 'frank@example.com', 'hashed_password_6'),
    ('Grace', 'grace@example.com', 'hashed_password_7'),
    ('Heidi', 'heidi@example.com', 'hashed_password_8'),
    ('Ivan', 'ivan@example.com', 'hashed_password_9'),
    ('Jane', 'jane@example.com', 'hashed_password_10'),
    ('Kate', 'kate@example.com', 'hashed_password_11'),
    ('John', 'john@example.com', 'hashed_password_12'),
    ('Julia', 'julia@example.com', 'hashed_password_13'),
    ('Jacob', 'jacob@example.com', 'hashed_password_14'),
    ('Liam', 'liam@example.com', 'hashed_password_15');

INSERT INTO CharacterClass (name, description, base_health, base_attack, base_defense) VALUES
    ('Warrior', 'Warrior class variant 1.', 150, 20, 15),
    ('Mage', 'Mage class variant 1.', 80, 30, 5),
    ('Archer', 'Archer class variant 1.', 110, 22, 8),
    ('Warrior', 'Warrior class variant 2.', 155, 21, 15),
    ('Mage', 'Mage class variant 2.', 82, 31, 5),
    ('Archer', 'Archer class variant 2.', 112, 23, 8),
    ('Warrior', 'Warrior class variant 3.', 160, 22, 16),
    ('Mage', 'Mage class variant 3.', 84, 32, 6),
    ('Archer', 'Archer class variant 3.', 114, 24, 9),
    ('Warrior', 'Warrior class variant 4.', 165, 23, 16),
    ('Mage', 'Mage class variant 4.', 86, 33, 6),
    ('Archer', 'Archer class variant 4.', 116, 25, 9),
    ('Warrior', 'Warrior class variant 5.', 170, 24, 17),
    ('Mage', 'Mage class variant 5.', 88, 34, 7),
    ('Archer', 'Archer class variant 5.', 118, 26, 10);

INSERT INTO Party (nameParty) VALUES
    ('The Brave'),
    ('Mystic'),
    ('Shadow'),
    ('Divine Force'),
    ('The Forest'),
    ('Storm'),
    ('Phoenix'),
    ('Guardians'),
    ('Nightfall'),
    ('Ironclad'),
    ('Starlight'),
    ('Wild Hunt'),
    ('Eclipse'),
    ('Silver Moon'),
    ('Red Comets');

INSERT INTO MembreParty (players_id, Party_id, chef_party_id) VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 6),
    (7, 7, 7),
    (8, 8, 8),
    (9, 9, 9),
    (10, 10, 10),
    (11, 11, 11),
    (12, 12, 12),
    (13, 13, 13),
    (14, 14, 14),
    (15, 15, 15);

INSERT INTO Character (player_id, name, class_id, level, health, attack, defense) VALUES
    (1, 'Alice', 1, 1, 150, 20, 15),
    (2, 'Bob', 2, 1, 80, 30, 5),
    (3, 'Charlie', 3, 1, 110, 22, 8),
    (4, 'David', 4, 1, 155, 21, 15),
    (5, 'Eve', 5, 1, 82, 31, 5),
    (6, 'Frank', 6, 1, 112, 23, 8),
    (7, 'Grace', 7, 2, 160, 22, 16),
    (8, 'Heidi', 8, 2, 84, 32, 6),
    (9, 'Ivan', 9, 2, 114, 24, 9),
    (10, 'Jane', 10, 2, 165, 23, 16),
    (11, 'Kate', 11, 2, 86, 33, 6),
    (12, 'John', 12, 2, 116, 25, 9),
    (13, 'Julia', 13, 2, 170, 24, 17),
    (14, 'Jacob', 14, 2, 88, 34, 7),
    (15, 'Liam', 15, 2, 118, 26, 10);

SELECT setseed(0.42);

INSERT INTO GameReplay (
    "1_1player_id", "2_1player_id", "3_1player_id", "4_1player_id", "5_1player_id",
    "1_2player_id", "2_2player_id", "3_2player_id", "4_2player_id", "5_2player_id",
    date_game, time_duration
)
SELECT participants.player_ids[1],
       participants.player_ids[2],
       participants.player_ids[3],
       participants.player_ids[4],
       participants.player_ids[5],
       participants.player_ids[6],
       participants.player_ids[7],
       participants.player_ids[8],
       participants.player_ids[9],
       participants.player_ids[10],
       DATE '2026-07-01' + ((replay_number - 1) % 92),
       5 + floor(random() * 100)::int
FROM generate_series(1, 150) AS replay(replay_number)
CROSS JOIN LATERAL (
    SELECT array_agg(player_id ORDER BY random() * replay.replay_number) AS player_ids
    FROM generate_series(1, 15) AS available_players(player_id)
) AS participants;

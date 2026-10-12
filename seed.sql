INSERT INTO CharacterClass (name, base_health, base_attack, base_defense, health_per_level, attack_per_level, defense_per_level) VALUES
    ('Warrior', 150, 20, 15, 10, 2, 5),
    ('Mage', 80, 30, 5, 4, 10, 1),
    ('Archer', 110, 22, 8, 6, 6, 3),

INSERT INTO Party (name, parent_party_id) VALUES
    ('Grand Alliance', NULL),
    ('Northern Legion', 1),
    ('Southern Pact', 1),
    ('Frost Guard', 2),
    ('Iron Wolves', 2),
    ('Sand Riders', 3),
    ('Sun Wardens', 3),
    ('Free Companies', NULL),
    ('Mercenary Band', 8),
    ('Wandering Blades', 8),
    ('Night Market', 10),
    ('Silver Hand', 4),
    ('Storm Brigade', 2),
    ('Dawn Seekers', 7),
    ('Lone Wolves', NULL);

INSERT INTO players (username, email, class_id, party_id) VALUES
    ('Alice', 'alice@example.com', 1, 2),
    ('Bob', 'bob@example.com', 2, 4),
    ('Charlie', 'charlie@example.com', 3, 4),
    ('David', 'david@example.com', 1, 5),
    ('Eve', 'eve@example.com', 2, 3),
    ('Frank', 'frank@example.com', 3, 6),
    ('Grace', 'grace@example.com', 1, 7),
    ('Heidi', 'heidi@example.com', 2, 7),
    ('Ivan', 'ivan@example.com', 3, 9),
    ('Jane', 'jane@example.com', 1, 10),
    ('Kate', 'kate@example.com', 2, 11),
    ('John', 'john@example.com', 3, 12),
    ('Julia', 'julia@example.com', 1, 1),
    ('Jacob', 'jacob@example.com', 2, 8),
    ('Liam', 'liam@example.com', 3, 15);

INSERT INTO MemberParty (players_id, party_id, leader_id) VALUES
    (13, 1, NULL),
    (1, 2, NULL),
    (5, 3, NULL),
    (2, 4, NULL),
    (3, 4, 2),
    (4, 5, NULL),
    (6, 1, 13),
    (7, 7, NULL),
    (8, 7, 7),
    (9, 9, NULL),
    (10, 10, NULL),
    (11, 11, NULL),
    (12, 1, 13),
    (14, 8, NULL),
    (15, 15, NULL);

INSERT INTO GameCharacter (player_id, name, class_id, level) VALUES
    (1, 'Alice', 1, 1),
    (2, 'Bob', 2, 1),
    (3, 'Charlie', 3, 1),
    (4, 'David', 1, 1),
    (5, 'Eve', 2, 1),
    (6, 'Frank', 3, 1),
    (7, 'Grace', 1, 2),
    (8, 'Heidi', 2, 2),
    (9, 'Ivan', 3, 2),
    (10, 'Jane', 1, 2),
    (11, 'Kate', 2, 2),
    (12, 'John', 3, 2),
    (13, 'Julia', 1, 2),
    (14, 'Jacob', 2, 2),
    (15, 'Liam', 3, 2);

SELECT setseed(0.42);

INSERT INTO GameReplay (
    team1_player1_id, team1_player2_id, team1_player3_id, team1_player4_id, team1_player5_id,
    team2_player1_id, team2_player2_id, team2_player3_id, team2_player4_id, team2_player5_id,
    date_game, time_duration
)

SELECT 
    participants.player_ids[1],
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
    (5 + floor(random() * 100)::int) * INTERVAL '1 minute'

FROM generate_series(1, 150) AS replay(replay_number)
CROSS JOIN LATERAL (
    SELECT array_agg(player_id ORDER BY random()) AS player_ids
    FROM generate_series(1, 15) AS available_players(player_id)
) AS participants;

INSERT INTO GameScore (game_id, player_id, score) SELECT 
    g.id,
    slot.player_id,
    floor(random() * 1000)::int

FROM GameReplay g
CROSS JOIN LATERAL (VALUES
    (g.team1_player1_id), (g.team1_player2_id), (g.team1_player3_id),
    (g.team1_player4_id), (g.team1_player5_id),
    (g.team2_player1_id), (g.team2_player2_id), (g.team2_player3_id),
    (g.team2_player4_id), (g.team2_player5_id)
) AS slot(player_id);
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username TEXT, 
    password TEXT 
);

CREATE TABLE players (
    id INTEGER PRIMARY KEY,
    first_name TEXT,
    surname TEXT,
    gender TEXT,
    date_of_birth TEXT,
    country TEXT
);
-- P1 TABLE CREATION FOR BOOK MY SHOW

CREATE DATABASE IF NOT EXISTS book_my_show;
USE book_my_show;

--    USER TABLE CREATION
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255), -- OPTIONAL DATA
    mobile INT NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP
);

--   GENRE TABLE CREATION
CREATE TABLE IF NOT EXISTS genres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS certificates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

--   MOVIE TABLE CREATION
CREATE TABLE IF NOT EXISTS movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_date DATE,
    duration INT,  -- IN MINUTES
    imdb_rating DECIMAL(2,1),
    certificate_id INT DEFAULT 1,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP,
    FOREIGN KEY (certificate_id) REFERENCES certificates(id)
);

--  GENRES MOVIES TABLE CREATION
CREATE TABLE IF NOT EXISTS genres_movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    genre_id INT NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

--  THEATRES TABLE CREATION
CREATE TABLE IF NOT EXISTS theatres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP
);

--  SCREENS TABLE CREATION
CREATE TABLE IF NOT EXISTS screens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    theatre_id INT NOT NULL,
    capacity INT NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP,
    FOREIGN KEY (theatre_id) REFERENCES theatres(id)
);

-- SEAT TYPE CREATION
CREATE TABLE IF NOT EXISTS seat_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    theatre_id INT NOT NULL,
    type_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP,
    FOREIGN KEY (theatre_id) REFERENCES theatres(id)
);

--  SCREEN SEATS TABLE CREATION
CREATE TABLE IF NOT EXISTS screens_seats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    screen_id INT NOT NULL,
    seat_number INT NOT NULL,
    seat_type_id INT NOT NULL,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP,
    FOREIGN KEY (screen_id) REFERENCES screens(id),
    FOREIGN KEY (seat_type_id) REFERENCES seat_types(id)
);

-- LANGUAGES TABLE CREATION
CREATE TABLE IF NOT EXISTS languages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- SHOW TECH TABLE CREATION (2D, 3D, DOLBY ATMOS, IMAX, ETC.)
CREATE TABLE IF NOT EXISTS show_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- SHOWS TABLE CREATION
CREATE TABLE IF NOT EXISTS shows (
    id INT AUTO_INCREMENT PRIMARY KEY,
    screen_id INT NOT NULL,
    movie_id INT NOT NULL,
    language_id INT NOT NULL,
    show_tech_id INT NOT NULL,
    show_time DATETIME NOT NULL,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP,
    FOREIGN KEY (screen_id) REFERENCES screens(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (language_id) REFERENCES languages(id),
    FOREIGN KEY (show_tech_id) REFERENCES show_types(id)
);

-- BOOKINGS TABLE CREATION
CREATE TABLE IF NOT EXISTS bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    show_id INT NOT NULL,
    booking_count INT DEFAULT 1,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (show_id) REFERENCES shows(id)
);

-- BOOKINGS SEATS TABLE CREATION
CREATE TABLE IF NOT EXISTS bookings_seats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    seat_id INT NOT NULL,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (seat_id) REFERENCES screens_seats(id)
);

-- USERS
INSERT INTO users (name, email, mobile, password)
VALUES
    ('Aarav Sharma', 'aarav@example.com', 1000000001, 'pass@123'),
    ('Isha Verma', 'isha@example.com', 1000000002, 'pass@123'),
    ('Kabir Mehta', 'kabir@example.com', 1000000003, 'pass@123');

-- GENRES
INSERT INTO genres (name)
VALUES
    ('Action'),
    ('Drama'),
    ('Comedy'),
    ('Sci-Fi');

INSERT INTO certificates (name)
VALUES
    ('U'),
    ('U/A'),
    ('A');

-- MOVIES
INSERT INTO movies (title, description, release_date, duration, imdb_rating, certificate_id)
VALUES
    ('Sky Warriors', 'Air combat action drama', '2026-01-10', 145, 8.1, 1),
    ('Laugh Lines', 'Family comedy entertainer', '2026-02-14', 128, 7.3, 2),
    ('Hazbin Hotel', 'A Dark comedy musical', '2026-02-14', 134, 9.0, 3),
    ('Dark Souls', 'Action adventure fantasy', '2026-03-15', 140, 8.5, 1),
    ('Orbit 9', 'Science fiction thriller set in space', '2026-03-20', 152, 8.6, 1);


-- MOVIE <-> GENRE MAPPING
INSERT INTO genres_movies (movie_id, genre_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 1),
    (3, 4),
    (4, 1),
    (4, 4),
    (5, 1),
    (5, 4);

-- THEATRES
INSERT INTO theatres (name, location)
VALUES
    ('PVR City Center', 'Bengaluru'),
    ('INOX Riverside', 'Bengaluru');

-- SCREENS
INSERT INTO screens (theatre_id, capacity, is_available)
VALUES
    (1, 120, TRUE),
    (1, 180, TRUE),
    (1, 100, TRUE),
    (2, 150, TRUE);

-- SEAT TYPES
INSERT INTO seat_types (theatre_id, type_name, price)
VALUES
    (1, 'Regular', 220.00),
    (1, 'Premium', 350.00),
    (2, 'Regular', 200.00),
    (2, 'Recliner', 550.00);

-- SCREEN SEATS
INSERT INTO screens_seats (screen_id, seat_number, seat_type_id)
VALUES
    (1, 1, 1),
    (1, 2, 1),
    (1, 3, 2),
    (2, 1, 2),
    (2, 2, 2),
    (3, 1, 3),
    (3, 2, 3);

-- LANGUAGES
INSERT INTO languages (name)
VALUES
    ('Hindi'),
    ('English'),
    ('Bengali');

-- SHOW TYPES
INSERT INTO show_types (name)
VALUES
    ('2D'),
    ('3D'),
    ('IMAX');

-- SHOWS
INSERT INTO shows (screen_id, movie_id, language_id, show_tech_id, show_time)
VALUES
    (1, 1, 1, 1, '2026-04-27 10:00:00'),
    (2, 2, 1, 2, '2026-04-27 10:00:00'),
    (3, 3, 1, 2, '2026-04-27 10:00:00'),
    (1, 2, 1, 1, '2026-04-27 14:00:00'),
    (2, 3, 2, 2, '2026-04-27 18:30:00'),
    (3, 3, 3, 3, '2026-04-28 20:00:00'),
    (1, 4, 1, 1, '2026-04-29 10:00:00'),
    (2, 5, 2, 2, '2026-04-29 10:00:00'),
    (4, 1, 3, 1, '2026-04-29 12:00:00'),
    (1, 5, 1, 3, '2026-04-29 13:00:00'),
    (3, 4, 2, 2, '2026-04-29 15:30:00'),
    (2, 1, 1, 1, '2026-04-29 16:00:00'),
    (4, 2, 2, 3, '2026-04-29 18:00:00'),
    (1, 3, 1, 2, '2026-04-29 19:00:00'),
    (3, 2, 3, 1, '2026-04-30 10:30:00'),
    (2, 4, 1, 2, '2026-04-30 11:00:00'),
    (4, 3, 1, 3, '2026-04-30 13:30:00'),
    (1, 1, 2, 2, '2026-04-30 15:00:00'),
    (3, 5, 2, 1, '2026-04-30 17:00:00'),
    (2, 2, 3, 2, '2026-04-30 19:30:00'),
    (4, 4, 1, 1, '2026-05-01 10:00:00'),
    (1, 4, 2, 3, '2026-05-01 12:00:00'),
    (3, 1, 1, 2, '2026-05-01 14:00:00'),
    (2, 5, 1, 1, '2026-05-01 16:00:00'),
    (4, 5, 3, 2, '2026-05-01 18:00:00');

-- BOOKINGS
INSERT INTO bookings (user_id, show_id, booking_count)
VALUES
    (1, 1, 2),
    (2, 3, 1),
    (3, 4, 1);

-- BOOKING <-> SEAT MAPPING
INSERT INTO bookings_seats (booking_id, seat_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 6),
    (3, 7);

-- P2 Query:
-- List all shows for a given theater on a given date with timings.
SELECT t.name AS theatre_name,
       s.id AS screen_id,
       sh.id AS show_id,
       m.title AS movie_title,
       c.name AS certificate_name,
       l.name AS language,
       st.name AS show_tech,
       sh.show_time
FROM theatres t
JOIN screens s on t.id = s.theatre_id
JOIN shows sh on s.id = sh.screen_id
JOIN movies m on m.id = sh.movie_id
JOIN certificates c on c.id = m.certificate_id
JOIN languages l on l.id = m.language_id
JOIN show_types st on st.id = sh.show_tech_id
WHERE t.id = 1 AND sh.show_time BETWEEN '2026-04-27 00:00:00' AND '2026-04-27 23:59:59';
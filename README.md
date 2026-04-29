# BookMyShow SQL Assignment

This project defines a relational schema for a simplified movie-ticket booking system and adds sample data for testing joins.

## Included Database Objects

- 14 tables: users, genres, certificates, movies, genres_movies, theatres, screens, seat_types, screens_seats, languages, show_types, shows, bookings, bookings_seats
- Seed data for users, movies, theatres, screens, seat types, shows, and bookings
- A sample reporting query for listing shows by theatre and date

## ER Diagram (Mermaid)

```mermaid
erDiagram
    USERS {
        INT id PK
        VARCHAR name
        VARCHAR email
        INT mobile
        VARCHAR password
        TIMESTAMP added_on
        TIMESTAMP updated_on
    }

    GENRES {
        INT id PK
        VARCHAR name
    }

    CERTIFICATES {
        INT id PK
        VARCHAR name
    }

    MOVIES {
        INT id PK
        VARCHAR title
        TEXT description
        DATE release_date
        INT duration
        DECIMAL imdb_rating
        INT certificate_id FK
        TIMESTAMP added_on
        TIMESTAMP updated_on
    }

    GENRES_MOVIES {
        INT id PK
        INT movie_id FK
        INT genre_id FK
    }

    THEATRES {
        INT id PK
        VARCHAR name
        VARCHAR location
        TIMESTAMP added_on
        TIMESTAMP updated_on
    }

    SCREENS {
        INT id PK
        INT theatre_id FK
        INT capacity
        BOOLEAN is_available
        TIMESTAMP added_on
        TIMESTAMP updated_on
    }

    SEAT_TYPES {
        INT id PK
        INT theatre_id FK
        VARCHAR type_name
        DECIMAL price
        TIMESTAMP added_on
        TIMESTAMP updated_on
    }

    SCREENS_SEATS {
        INT id PK
        INT screen_id FK
        INT seat_number
        INT seat_type_id FK
        TIMESTAMP added_on
        TIMESTAMP updated_on
    }

    LANGUAGES {
        INT id PK
        VARCHAR name
    }

    SHOW_TYPES {
        INT id PK
        VARCHAR name
    }

    SHOWS {
        INT id PK
        INT screen_id FK
        INT movie_id FK
        INT language_id FK
        INT show_tech_id FK
        DATETIME show_time
        TIMESTAMP added_on
        TIMESTAMP updated_on
    }

    BOOKINGS {
        INT id PK
        INT user_id FK
        INT show_id FK
        INT booking_count
        TIMESTAMP added_on
        TIMESTAMP updated_on
    }

    BOOKINGS_SEATS {
        INT id PK
        INT booking_id FK
        INT seat_id FK
        TIMESTAMP added_on
        TIMESTAMP updated_on
    }

    CERTIFICATES ||--o{ MOVIES : certifies
    MOVIES ||--o{ GENRES_MOVIES : mapped_in
    GENRES ||--o{ GENRES_MOVIES : tags

    THEATRES ||--o{ SCREENS : has
    THEATRES ||--o{ SEAT_TYPES : defines

    SCREENS ||--o{ SCREENS_SEATS : contains
    SEAT_TYPES ||--o{ SCREENS_SEATS : categorized_as

    SCREENS ||--o{ SHOWS : hosts
    MOVIES ||--o{ SHOWS : scheduled_as
    LANGUAGES ||--o{ SHOWS : played_in
    SHOW_TYPES ||--o{ SHOWS : rendered_as

    USERS ||--o{ BOOKINGS : makes
    SHOWS ||--o{ BOOKINGS : receives

    BOOKINGS ||--o{ BOOKINGS_SEATS : includes
    SCREENS_SEATS ||--o{ BOOKINGS_SEATS : allocated_to
```

## Sample Join Query (Theatre + Date)

```sql
SELECT
    t.name AS theatre_name,
    s.id AS screen_id,
    sh.id AS show_id,
    m.title AS movie_title,
    c.name AS certificate_name,
    l.name AS language,
    st.name AS show_tech,
    sh.show_time
FROM theatres t
JOIN screens s ON t.id = s.theatre_id
JOIN shows sh ON s.id = sh.screen_id
JOIN movies m ON m.id = sh.movie_id
JOIN certificates c ON c.id = m.certificate_id
JOIN languages l ON l.id = sh.language_id
JOIN show_types st ON st.id = sh.show_tech_id
WHERE t.id = 1
  AND sh.show_time BETWEEN '2026-04-27 00:00:00' AND '2026-04-27 23:59:59'
ORDER BY sh.show_time;
```

## Run Script

```sql
SOURCE book_my_show.sql;
```


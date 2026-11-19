CREATE DATABASE IF NOT EXISTS mysql_db CHARACTER SET utf8mb4;
USE [DB NAME];

DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS users;

-- USERS: role decides privileges (admin > staff > user)
CREATE TABLE users (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  email      VARCHAR(150) NOT NULL UNIQUE,
  password   VARCHAR(255) NOT NULL,              -- store a HASH, not plain text
  phone      VARCHAR(30),
  age_group  ENUM('adult','child','senior') NOT NULL DEFAULT 'adult',
  role       ENUM('admin','staff','user') NOT NULL DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ROOMS
CREATE TABLE rooms (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  room_number    VARCHAR(10) NOT NULL UNIQUE,
  type           ENUM('single','double','family','suite') NOT NULL,
  price_per_night DECIMAL(8,2) NOT NULL,
  capacity       INT NOT NULL DEFAULT 2,
  status         ENUM('available','cleaning','maintenance') NOT NULL DEFAULT 'available'
);

-- BOOKINGS
CREATE TABLE bookings (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  user_id     INT NOT NULL,
  room_id     INT NOT NULL,
  check_in    DATE NOT NULL,
  check_out   DATE NOT NULL,
  guests      INT NOT NULL DEFAULT 1,
  total_price DECIMAL(8,2),
  status      ENUM('pending','confirmed','checked_in','checked_out','cancelled')
              NOT NULL DEFAULT 'pending',
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (room_id) REFERENCES rooms(id)
);
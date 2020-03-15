PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  follower_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (follower_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT,
  question_id INTEGER NOT NULL,
  parent_id INTEGER NOT NULL, 
  author_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
  users (fname, lname)
VALUES 
  ("Felix", "Reynoso"),
  ("Mariel", "Ciprian"),
  ("Bill", "Gates"),
  ("Paola", "Santana"),
  ("Steve", "Jobs"),
  ("Elon", "Musk"),
  ("Sir. Richard", "Branson");

INSERT INTO
  questions (title, body, author_id)
VALUES
  ("Division by zero?", "Is it possible to divide a number by zero? I haven't been able to find the answer", 1),
  ("What's next in architecture?", "Hi friends, i'm interested in learning what will be the best tech coming up in the arch field.", 2),
  ("Are we prepared for the next epidemic?", "Hi mi name is Bill and I want to raise awareness in the health sector. I Believe we're not ready to face a pandemic at a large scale", 3),
  ("Can entrepreneurs disrupt governments?", "Hi, I'm the CEO of the Social Glass, we're a startup that develops AI solutions to make governments mor efficient", 4),
  ("What is design?", "Design is not only how it looks or how it works, in simple terms. 'Design is how it feels'.", 5),
  ("When will we get to mars?", "We will get a million people on Mars, by 2050.", 6),
  ("What's the meaning behind VIRGIN?", "Decades ago we came up with the concept for the Virgin Brand, what we want is for people to be happy and reinventing themselves.", 7);

INSERT INTO 
  question_follows (question_id, follower_id)
VALUES
  (2, 1),
  (1, 2),
  (3, 5),
  (4, 1),
  (5, 3),
  (6, 1),
  (7, 1),
  (1, 7), 
  (3, 5),
  (3, 6);

INSERT INTO
  replies (body, question_id, parent_id, author_id)
VALUES
  ("Sorry pal, division by 0 is not defined.", 1, 1, 6),
  ("Virtual and augmented reality are transforming architects design today.", 2, 2, 3),
  ("I'm sure we're not ready for the next pandemic. But I believe Apple and Microsoft together could work together on this.", 3, 3, 5),
  ("I know the work you guys are doing at Social Glass and it is very inspiring.", 4, 4, 1);

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 1),
  (4, 1),
  (5, 1),
  (3, 7);
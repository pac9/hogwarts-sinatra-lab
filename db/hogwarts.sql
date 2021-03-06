
DROP TABLE students;
DROP TABLE houses;


CREATE TABLE houses (
  id INT4 PRIMARY KEY,
  name VARCHAR(255)
);


CREATE TABLE students (
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(255),
  second_name VARCHAR(255),
  house INT4 REFERENCES houses(id),
  age INT4
);

create Table students(
    student_id SERIAL PRIMARY KEY ,
    student_name VARCHAR(255),
    age INT ,
    email VARCHAR(255) UNIQUE,
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(255)
);


INSERT INTO students 
VALUES  (1,	'Alice',	22,	'alice@example.com',	55,	57,	NULL),
        (2,	'Bob',	21,	'bob@example.com',	34,	45,	NULL),
        (3,	'Charlie',	23,	'charlie@example.com',	60,	59,	NULL),
        (4,	'David',	20,	'david@example.com',	40,	49,	NULL),
        (5,	'Eve',	24,	'newemail@example.com',	45,	34,	NULL),
        (6,	'Rahim',	23,	'rahim@gmail.com',	46,	42,	NULL)

SELECT * FROM students

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY ,
    course_name VARCHAR(255),
    credits INT
)

INSERT INTO courses 
VALUES(1,'Next.js',3),
(2,'React.js',4),
(3,'Databases',3),
(4,	'Prisma',3)

SELECT * FROM courses

CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    CONSTRAINT fk_constraint_student FOREIGN KEY (student_id) REFERENCES students (student_id),
    CONSTRAINT fk_constraint_course FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

INSERT INTO enrollment 
VALUES 
    (1,1,1),
    (2,1,2),
    (3,2,1),
    (4,3,2)

    SELECT * from enrollment



/* .......Query 1.............................
Insert a new student record with the following details:

Name: YourName
Age: YourAge
Email: YourEmail
Frontend-Mark: YourMark
Backend-Mark: YourMark
Status: NULL */

INSERT INTO students (student_name,age,email,frontend_mark,backend_mark,status) VALUES('Mehedi',26,'mehedi@gmail.com',50,55,'active')

SELECT * FROM students 


/*...................Query 2....................
Retrieve the names of all students who are enrolled in the course titled 'Next.js'. */

SELECT s.student_name from students AS s
JOIN enrollment e on e.student_id = s.student_id 
JOIN courses c ON c.course_id = e.course_id
WHERE c.course_name ='Next.'


/* .......................Query 3............................
Update the status of the student with the highest total (frontend_mark + backend_mark) mark to 'Awarded' */


UPDATE students
SET status = 'Awarded'
WHERE frontend_mark + backend_mark = (
SELECT MAX(frontend_mark + backend_mark)
FROM students
);


/* ...........Query 4...................
Delete all courses that have no students enrolled. */

DELETE from courses
WHERE course_id NOT In (
SELECT DISTINCT c.course_id
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
WHERE e.student_id IS NOT NULL
);

SELECT * from students


/* ..................Query 5......................
Retrieve the names of students using a limit of 2, starting from the 3rd student. */

SELECT  * FROM students
ORDER BY student_name ASC  LIMIT 2 OFFSET 2;


/* ........Query.................. 6:
Retrieve the course names and the number of students enrolled in each course. */

SELECT * FROM courses

SELECT * FROM students

SELECT c.course_name ,count(e.student_id) AS students_enrolled FROM courses c
LEFT JOIN enrollment e on e.course_id=c.course_id
GROUP BY c.course_name


/*............... Query 7................:
Calculate and display the average age of all students. */

SELECT AVG(age) AS average_age
FROM students;


/* ............Query 8........................:
Retrieve the names of students whose email addresses contain 'example.com'. */
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';

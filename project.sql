create database OLP;
use OLP;
create table Users (
    user_id int primary key,
    name varchar(100) not null,
    email varchar(100) unique not null,
    role varchar(20) check (role IN ('student', 'instructor'))
);
insert into Users (user_id, name, email, role) values
(1, 'Shreya', 'shrey@gmail.com', 'student'),
(2, 'Sneha', 'sneha@gmail.com', 'instructor'),
(3, 'Shruti', 'shruti4645@gmail.com', 'student'),
(4, 'Sonali', 'son0504@gmail.com', 'instructor'),
(5, 'Sadhana', 'sadh24@gmail.com', 'student'),
(6, 'Ritika', 'rit342@gmail.com', 'instructor'),
(7, 'Neha', 'neha765@gmail.com', 'student'),
(8, 'Neeta', 'neeta657@gmail.com', 'instructor'),
(9, 'Nisha', 'nidfh9@gmail.com', 'student'),
(10, 'Tripti', 'tripom10@gmail.com', 'student'),
(11, 'Aradhana', 'aremf4@example.com', 'instructor'),
(12, 'Akashya', 'akasdf335@gmail.com', 'student'),
(13, 'Ashish', 'ashisdh13@gmail.com', 'student'),
(14, 'Anuj', 'anguyg@gmail.com', 'instructor'),
(15, 'Ankit', 'anki335@gmail.com', 'student');
select * from Users;
select * from  Users where role = 'student';
select * from Users where role = 'instructor';
select * from Users where name like 'A%';
alter table Users add column gender varchar(50);
update Users set gender='Female' where user_id in( 1,2,3,4,5,6,7,8,9,10,11);
update Users set gender='Male' where user_id in(12,13,14,15);

create table Courses (
    course_id int primary key,
    title varchar(100) not null,
    description text,
    instructor_id int,
    foreign key(instructor_id) references Users(user_id)
);
insert into Courses (course_id, title, description, instructor_id) values
(101, 'DADS', 'Description for DADS', 11 ),
(102, 'Web dev', 'Description for Web dev', 2),
(103, 'Full stack dev', 'Description for Full stack dev', 8),
(104, 'python devlo', 'Description for python devlo', 4),
(105, 'AWS', 'Description for AWS', 6),
(106, 'DADS', 'Description for DADS', 11),
(107, 'Web dev', 'Description for Web dev', 6),
(108, 'Full stack dev', 'Description for Full stack dev', 8),
(109, 'python dev', 'Description for python dev', 4),
(1010, 'AWS', 'Description for AWS', 11),
(1011, 'cloude com', 'Description for cloude com', 6),
(1012, 'DADS', 'Description for DADS', 2),
(1013, 'software eng', 'Description for software eng', 8),
(1014, '.net dev', 'Description for .net dev', 4),
(15, 'cloud com', 'Description for cloud com', 11);

update Courses
set course_id = 1015
where course_id = 15;
select *from Courses;

create table Enrollments (
    user_id int,
    course_id int,
    enrollment_date date,
    primary key (user_id, course_id),
    foreign key (user_id) references Users(user_id),
    foreign key (course_id) references Courses(course_id)
);
insert into Enrollments (user_id, course_id, enrollment_date) values
(1, 101, '2025-07-01'),
(2, 102, '2025-07-02'),
(3, 103, '2025-07-03'),
(4, 104, '2025-07-04'),
(5, 105, '2025-07-05'),
(8, 106, '2025-07-06'),
(7, 107, '2025-07-07'),
(8, 108, '2025-07-08'),
(9, 109, '2025-07-09'),
(10, 1010, '2025-07-10'),
(11, 1011, '2025-07-11'),
(12, 1012, '2025-07-12'),
(13, 1013, '2025-07-13'),
(14, 1014, '2025-07-14'),
(15, 1015, '2025-07-15');
select *from Enrollments;
update Enrollments set user_id=6 where course_id = 106;

create table Progress (
    user_id int,
    course_id int,
    progress int check (progress between 0 and 100),
    last_accessed date,
    primary key (user_id, course_id),
    foreign key (user_id) references Users(user_id),
    foreign key (course_id) references Courses(course_id)
);
insert into Progress (user_id, course_id, progress, last_accessed) values
(1, 101, 85, '2025-07-01'),
(2, 102, 70, '2025-07-02'),
(3, 103, 40, '2025-07-03'),
(4, 104, 95, '2025-07-04'),
(5, 105, 60, '2025-07-05'),
(6, 106, 50, '2025-07-06'),
(7, 107, 30, '2025-07-07'),
(8, 108, 90, '2025-07-08'),
(9, 109, 100, '2025-07-09'),
(10, 1010, 20, '2025-07-10'),
(11, 1011, 75, '2025-07-11'),
(12, 1012, 55, '2025-07-12'),
(13, 1013, 65, '2025-07-13'),
(14, 1014, 45, '2025-07-14'),
(15, 1015, 35, '2025-07-15');
select * from Progress;

select u.name as student_name, c.title as course_title, e.enrollment_date
from Enrollments e
inner join Users u on e.user_id = u.user_id
inner join Courses c on e.course_id = c.course_id
where u.role = 'student';

select user_id, course_id, progress
from Progress
where progress >( select avg(Progress)from Progress);

select role, count(*) AS total_users
from Users
group by role;

select U.name as instructor_name, count(C.course_id) as total_courses
from Courses C
join Users U on C.instructor_id = U.user_id
group by U.name;

select C.title, U.name, P.last_accessed
from Progress P
join Courses C ON P.course_id = C.course_id
join Users U ON P.user_id = U.user_id
order by P.last_accessed desc;

select title, count(*) AS duplicates
from Courses
group by title
having count(*) > 1;

select sum(progress) from Progress;
select min(progress) from Progress;
select max(progress) from Progress;


select title, count(*) as duplicates 
from Courses 
group by title having count(*) > 1;

create view course as select * from Courses where title='DADS';
select * from course;

select * from Enrollments
limit 10 offset 5;

select user_id,course_id,progress,
dense_rank()over(order by progress desc) as ranker
from Progress;

select user_id, course_id, progress, case
 when progress = 100 then 'Completed'
 when progress >= 50 then 'In Progress'
 else 'Not Started'
 end as status
from Progress;


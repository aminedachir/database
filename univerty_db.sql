CREATE DATABASE UniversityDB;
USE UniversityDB;
CREATE SCHEMA UniversitySchema;
CREATE TABLE Address (
	IDAddress Serial Primary Key,
    StreetNumber int not null,
    StreetName varchar(100) not null,
    City varchar(50) not null,
    PostalCode varchar(10) not null
);
CREATE TABLE Student (
	StudentNumber INT PRIMARY KEY,
	LastName VARCHAR(50) NOT NULL,
	FirstName VARCHAR(50) NOT NULL,
	AddressID INT REFERENCES Address(AddressID), 
	CONSTRAINT fk_Student_Address FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);
CREATE TABLE Course (
	CourseCode VARCHAR(20) PRIMARY KEY, 
	Title VARCHAR(100) NOT NULL,
	TotalHours INT NOT NULL CHECK (TotalHours >= 0) 
);
CREATE TABLE Teacher (
	TeacherNumber INT PRIMARY KEY, 
	LastName VARCHAR(50) NOT NULL,
	FirstName VARCHAR(50) NOT NULL,
	Age INT NOT NULL CHECK (Age >= 0),
	CityOfResidence VARCHAR(50) NOT NULL,
	HoursTaught INT NOT NULL CHECK (HoursTaught >= 0)
);
CREATE TABLE StudentCourse (
	StudentNumber INT NOT NULL REFERENCES Student(StudentNumber), 
	CourseCode VARCHAR(20) NOT NULL REFERENCES Course(CourseCode), 
	CAGrade DECIMAL(4, 2) NOT NULL CHECK (CAGrade BETWEEN 0 AND 20), 
	ExamGrade DECIMAL(4, 2) NOT NULL CHECK (ExamGrade BETWEEN 0 AND 20), 
	PRIMARY KEY (StudentNumber, CourseCode)
);
ALTER TABLE Course
ADD COLUMN ResponsibleTeacher INT REFERENCES Teacher(TeacherNumber);

ALTER TABLE Teacher
ADD COLUMN CourseCode VARCHAR(20) REFERENCES Course(CourseCode); 

ALTER TABLE Course
ADD CONSTRAINT fk_Course_Teacher FOREIGN KEY (ResponsibleTeacher) REFERENCES
Teacher(TeacherNumber);

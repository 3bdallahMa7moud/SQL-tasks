CREATE DATABASE compony;
GO

USE compony;
GO

CREATE TABLE Depart (
    DNUM INT PRIMARY KEY,
    DName VARCHAR(50) NOT NULL UNIQUE,
    Manger_SSN CHAR(14) NOT NULL,
    DEP_Location VARCHAR(60) NOT NULL
);

CREATE TABLE Emp(
    SSN CHAR(14) PRIMARY KEY,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    BDate DATE NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    DNum INT NOT NULL,
    SuperSSN CHAR(14),
    FOREIGN KEY (DNum) REFERENCES Depart(DNUM),
    FOREIGN KEY (SuperSSN) REFERENCES Emp(SSN)
);

CREATE TABLE Project (
    PNum INT PRIMARY KEY,
    PName VARCHAR(50) NOT NULL,
    Location VARCHAR(60) NOT NULL,
    DNUM INT NOT NULL,
    FOREIGN KEY (DNUM) REFERENCES Depart(DNUM)
);

CREATE TABLE Employee_projects (
    SSN CHAR(14),
    PNum INT,
    Working_Hours DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (SSN, PNum),
    FOREIGN KEY (SSN) REFERENCES Emp(SSN),
    FOREIGN KEY (PNum) REFERENCES Project(PNum)
);

CREATE TABLE Dependent (
    SSN CHAR(14),
    Dependent_Name VARCHAR(60),
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    Bdate DATE NOT NULL,
    PRIMARY KEY (SSN, Dependent_Name),
    FOREIGN KEY (SSN) REFERENCES Emp(SSN) ON DELETE CASCADE
);

CREATE TABLE Manage_HireDate(
    SSN CHAR(14),
    DNum INT,
    Hire_Date DATE NOT NULL,
    PRIMARY KEY (SSN, DNum),
    FOREIGN KEY (SSN) REFERENCES Emp(SSN),
    FOREIGN KEY (DNum) REFERENCES Depart(DNUM)
);

INSERT INTO Depart VALUES (1, 'IT', '12345678901231', 'Cairo');
INSERT INTO Depart VALUES (2, 'HR', '12345678901232', 'Giza');
INSERT INTO Depart VALUES (3, 'Chemistry', '12345678901233', 'Menofia');

INSERT INTO Emp VALUES ('12345678901231', 'Abdallah', 'Mahmoud', '2004-06-21', 'M', 1, NULL); 
INSERT INTO Emp VALUES ('12345678901232', 'Yassen', 'Ahmed', '1990-05-15', 'M', 2, NULL); 
INSERT INTO Emp VALUES ('12345678901233', 'Mai', 'Ali', '1980-07-20', 'F', 3, NULL); 
INSERT INTO Emp VALUES ('12345678901234', 'David', 'Jimmy', '1992-03-12', 'M', 1, '12345678901231'); 
INSERT INTO Emp VALUES ('12345678901235', 'Sara', 'Mohamed', '1995-09-25', 'F', 2, '12345678901232');


INSERT INTO Project VALUES (1, 'Security', 'Cairo', 1);
INSERT INTO Project VALUES (2, 'Data_Science', 'Giza', 2);

INSERT INTO Employee_projects VALUES ('12345678901231', 1, 6.44); 
INSERT INTO Employee_projects VALUES ('12345678901232', 2, 8.44); 

ALTER TABLE Emp ALTER COLUMN DNum INT NOT NULL 

--Using Alter

ALTER TABLE Manage_HireDate ADD DeptNum INT
ALTER TABLE Manage_HireDate ADD CONSTRAINT FK_Manage_HireDate_Depart
FOREIGN KEY (DeptNum) REFERENCES Depart(DNUM)
ALTER TABLE Emp ALTER COLUMN Fname VARCHAR(70)
ALTER TABLE Manage_HireDate DROP CONSTRAINT FK_Manage_HireDate_Depart
--Using Alter 

UPDATE Emp SET DNum = 3 WHERE SSN = '12345678901234';


DELETE FROM Dependent WHERE SSN = '12345678901235' AND Dependent_Name = 'Amr';


SELECT * FROM Emp WHERE DNum = 1;


SELECT E.SSN, E.FName, E.LName, EP.PNum, EP.Working_Hours
FROM Emp E JOIN Employee_projects EP ON E.SSN = EP.SSN;


#HEADER
#Program Name: Homework 2 SQL
#Author: Ethan Lyons
#Class: CS162 Spring 2021
#Date: 4/26/2021
#description: A code that creates a database and tables based off of an ERD and example data

DROP DATABASE IF EXISTS OrderForms;
CREATE DATABASE OrderForms;
USE OrderForms;

/* MAKING TABLES

Create Address Table
AddressID (PK, AI, int, NOT NULL)
Line1 (Varchar50, NOT NULL)
Line2 (Varchar50, NULL)
City (Varchar30, NOT NULL)
State (Varchar30, NULL (due to some countries not using state lines as they are states))
Zip (Varchar20 (due to other countries having longer postal codes), NOT NULL)

Create Customer table
CustomerNumber (PK, AI, int, NOT NULL)
CustomerName (varchar30, NOT NULL)
AddressID (FK references Address(AddressID), AI, int, NOT NULL)
PhoneNumber (varchar16 (because international phone numbers range from 11-16 numerical values) NOT NULL)
Email (varchar50 NOT NULL)

Create Product table
ProductNumber (PK, AI, int, NOT NULL)
DescriptionText (VarChar255, NULL)
UnitPrice (Decimal(10,2), NOT NULL)

Create OrderInfo table
OrderNumber (PK, AI, int, NOT NULL)
CustomerNumber (FK references Customer(CustomerNumber), AI, int, NOT NULL)
OrderDate (Date, NOT NULL)

Create Order_Line table
OderNumber (PK, FK references Order(OrderNumber), AI, int, NOT NULL)
ProductNumber (PK, FK references Product(ProductNumber), AI, int, NOT NULL)
Quantity (int, NOT NULL)
*/

CREATE TABLE Address (
	AddressID int PRIMARY KEY auto_increment NOT NULL,
    Line1 varchar(50) NOT NULL,
    Line2 varchar(50) NULL,
    City varchar(30) NOT NULL,
    State varchar(30) NULL,
    Zip varchar(20) NOT NULL
	);

CREATE TABLE Customer (
	CustomerNumber int PRIMARY KEY auto_increment NOT NULL,
    CustomerName varchar(30) NOT NULL,
    AddressID int NOT NULL,
    PhoneNumber varchar(16) NOT NULL,
    Email varchar(50) NOT NULL,
    FOREIGN KEY (AddressID) references Address(AddressID)
	);

CREATE TABLE Product (
	ProductNumber int PRIMARY KEY auto_increment NOT NULL,
    DescriptionText varchar(255) NULL,
    UnitPrice decimal(10,2) NOT NULL
	);

Create TABLE OrderInfo (
	OrderNumber int auto_increment NOT NULL,
    CustomerNumber int NOT NULL,
    OrderDate date NOT NULL,
    PRIMARY KEY (OrderNumber, CustomerNumber),
    FOREIGN KEY (CustomerNumber) references Customer(CustomerNumber)
	);

CREATE TABLE OrderLine (
	OrderNumber int NOT NULL,
    ProductNumber int NOT NULL,
    Quantity int NOT NULL,
    PRIMARY KEY (OrderNumber, ProductNumber),
    FOREIGN KEY (OrderNumber) references OrderInfo(OrderNumber) ON DELETE CASCADE,
    FOREIGN KEY (ProductNumber) references Product(ProductNumber)
	);
 
INSERT INTO Address (Line1, Line2, City, State, Zip)
VALUES
		('456 HighTower Street', '', 'Hong Kong', '', '999077'),
        ('123 Park Place', 'Suite 100', 'Tokyo', 'Kanto', '100-0005'),
        ('1248 Post Alley', '', 'Seattle', 'Washington', '98101'),
        ('180 Greenwich Street', '', 'New York', 'New York', '10007');

INSERT INTO Customer (CustomerName, AddressID, PhoneNumber, Email)
VALUES
		('John Doe','1','+15555550001','johndoe@somemail.co'),
        ('Jane Doe','2','+15555550002','janedoe@thismail.co'),
        ('Billy','1','+15555550003','billy@anothermail.co'),
        ('Samantha Kane','3','+15555550004','skane@somedomain.co'),
        ('Sam Smith','4','+15555550005','smith@randomname.co'),
        ('Carlson English','3','+15555550006','ceng@idkman.co');

INSERT INTO Product (DescriptionText, UnitPrice)
Values
		('Pencil','3.00'),
        ('Eraser','1.50'),
        ('Sharpener','8.00'),
        ('Pen','0.21'),
        ('Paper','4.20'),
        ('Holepunch','3.68'),
        ('Stapler','3.50');

Insert Into OrderInfo (CustomerNumber, OrderDate)
Values
		('3','1998-11-04'),
        ('1','2012-05-24'),
        ('5','2021-04-25'),
        ('4','2005-12-16');
        
Insert Into OrderLine (OrderNumber, ProductNumber, Quantity)
value
		('1','1','100'),
        ('1','2','200'),
        ('1','3','5'),
        ('2','5','30'),
        ('3','7','700'),
        ('4','6','16'),
        ('4','4','20');

Select * FROM Address;
Select * FROM Customer;
Select * FROM Product;
Select * FROM OrderInfo;
Select * FROM OrderLine;

/*FOOTER
1	456 HighTower Street		Hong Kong		999077
2	123 Park Place	Suite 100	Tokyo	Kanto	100-0005
3	1248 Post Alley		Seattle	Washington	98101
4	180 Greenwich Street		New York	New York	10007

1	John Doe	1	+15555550001	johndoe@somemail.co
2	Jane Doe	2	+15555550002	janedoe@thismail.co
3	Billy	1	+15555550003	billy@anothermail.co
4	Samantha Kane	3	+15555550004	skane@somedomain.co
5	Sam Smith	4	+15555550005	smith@randomname.co
6	Carlson English	3	+15555550006	ceng@idkman.co

1	Pencil	3.00
2	Eraser	1.50
3	Sharpener	8.00
4	Pen	0.21
5	Paper	4.20
6	Holepunch	3.68
7	Stapler	3.50

1	3	1998-11-04
2	1	2012-05-24
3	5	2021-04-25
4	4	2005-12-16

1	1	100
1	2	200
1	3	5
2	5	30
3	7	700
4	4	20
4	6	16
*/
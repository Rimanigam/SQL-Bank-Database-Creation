--1.	Creating a database for a banking application called “Bank”. --
Create Database Bank

-- Using the database Bank for further Operations--

Use Bank

--Creating Tables having only Primary Keys--

--1) User Security Questions Table

Create Table UserSecurityQuestions (UserSecurityQuestionID tinyint Not Null Primary Key, UserSecurityQuestion Varchar(50))

--2) Savings Interest Rates Table

Create Table SavingsInterestRates (InterestSavingsRateID tinyint Not Null Primary Key, InterestRateValue float, 
InterestRateDescription Varchar(20))

--3) Failed Transaction Error Type

Create Table FailedTransactionErrorType (FailedTransactionErrorTypeID tinyint Not Null Primary Key, 
FailedTransactionDescription Varchar(50))

--4) Login Error Log Table

Create Table LoginErrorLog (ErrorLogID int Not Null Primary Key, ErrorTime Datetime, FailedTransactionXML XML)

--5) Account Status Type Table

Create Table AccountStatusType (AccountStatusTypeID tinyint Not Null Primary Key, AccountStatusDescription Varchar(30))

--6) Account Type Table

Create Table AccountType (AccountTypeID tinyint Not Null Primary Key, AccountTypeDescription Varchar(30))

--7) Transaction Type Table

Create Table TransactionType (TransactionTypeID tinyint Not Null Primary Key, TransactionTypeName char(10), 
TransactionTypeDescription Varchar(50), TransactionFeeAmount smallmoney)

--8) Employee Table

Create Table Employee (EmployeeID int Not Null Primary Key, EmployeeFirstName Varchar(25), EmployeeMiddleInitial Char(1), 
EmployeeLastName Varchar(25), EmployeeManager bit)

--9) User Logins Table

Create Table UserLogins (UserLoginID smallint Not Null Primary Key, UserLogin Char(15), UserPassword Varchar(20))

--Creating the Reference Tables having Foreign Keys.

--10) Failed Transaction Log Table

Create Table FailedTransactionLog (FailedTransactionID int Not Null Primary Key, FailedTransactionErrorTypeID tinyint, 
Foreign Key (FailedTransactionErrorTypeID) References FailedTransactionErrorType (FailedTransactionErrorTypeID), 
FailedTransactionErrorTime datetime, FailedTransactionXML XML)

--11) Account Table

Create Table Account (AccountID int Not Null Primary Key, CurrentBalance int, AccountTypeID tinyint, 
Foreign Key (AccountTypeID) References AccountType (AccountTypeID), AccountStatusTypeID tinyint, Foreign Key (AccountStatusTypeID)
References AccountStatusType (AccountStatusTypeID), InterestSavingsRateID tinyint, Foreign Key(InterestSavingsRateID) References 
SavingsInterestRates (InterestSavingsRateID))


--12) Login Account Table

Create Table LoginAccount (UserLoginID smallint, Foreign Key(UserLoginID) References UserLogins(UserLoginID),
AccountID int, Foreign Key(AccountID) References Account (AccountID))

--13) Overdraft Log Table

Create Table OverDraftLog (AccountID int Not Null Primary Key, Foreign Key(AccountID) References Account (AccountID),
OverDraftDate Datetime, OverDraftAmount Money, OverDraftTransactionXML XML)

--14) User Security Answers Table

Create Table UserSecurityAnswers (UserLoginID smallint Not Null Primary Key, Foreign Key(UserLoginID) References UserLogins 
(UserLoginID),UserSecurityAnswer Varchar(25), UserSecurityQuestionID tinyint, Foreign Key(UserSecurityQuestionID) References 
UserSecurityQuestions(UserSecurityQuestionID))

--15) Customer Table

Create Table Customer (CustomerID int Not Null Primary Key, AccountID int, Foreign Key(AccountID) References Account(AccountID),
CustomerAddress1 Varchar(30), CustomerAddress2 Varchar(30), CustomerFirstName Varchar(30), CustomerMiddleInitial Char(1),
CustomerLastName Varchar(30), City Varchar(20), State Char(2), ZipCode Char(10), EmailAddress Varchar(40), HomePhone Char(10),
CellPhone Char(10), WorkPhone Char(10), SSN Char(9), UserLoginID Smallint, Foreign Key(UserLoginID) References 
UserLogins(UserLoginID))

--16) Customer-Account Table

Create Table CustomerAccount (AccountID int, Foreign Key(AccountID) References Account(AccountID), CustomerID int, 
Foreign Key(CustomerID) References Customer(CustomerID))

--17) Transaction Log Table

Create Table TransactionLog (TransactionID int Not Null Primary Key, TransactionDate Datetime, TransactionTypeID tinyint, 
Foreign Key(TransactionTypeID) References TransactionType(TransactionTypeID), TransactionAmount Money, NewBalance Money, 
AccountID int, Foreign Key(AccountID) References Account(AccountID), CustomerID int, Foreign Key(CustomerID) References 
Customer(CustomerID), EmployeeID int, Foreign Key(EmployeeID) References Employee(EmployeeID), UserLoginID Smallint, 
Foreign Key(UserLoginID) References UserLogins(UserLoginID))

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- After creating the Tables, I can now start inserting data into it
-- Firstly, I will insert data into the tables having primary key then will move forward for the other tables having Foreign Key

--1) Insert data into User Security Questions Table

Insert into UserSecurityQuestions Values (1,'Favourite Color')
Insert into UserSecurityQuestions Values (2,'Memorable Date')
Insert into UserSecurityQuestions Values (3,'First School Attended')
Insert into UserSecurityQuestions Values (4,'First Toy Name')
Insert into UserSecurityQuestions Values (5,'Birthday Date')


-- 2) Insert data into Saving Interest Rates Table

Insert into SavingsInterestRates Values (01, 0.25, 'On Oct 10th 2021')
Insert into SavingsInterestRates Values (02, 0.75, 'On Sep 16th 2021')
Insert into SavingsInterestRates Values (03, 1.25, 'On Aug 4th 2021')
Insert into SavingsInterestRates Values (04, 1.75, 'On July 24th 2020')
Insert into SavingsInterestRates Values (05, 1.5, 'On July 11th 2020')
Insert into SavingsInterestRates Values (06, 0.35, 'On Dec 10th 2019')
Insert into SavingsInterestRates Values (07, 0.25, 'On Sep 16th 2019')
Insert into SavingsInterestRates Values (08, 1.75, 'On Aug 4th 2019')
Insert into SavingsInterestRates Values (09, 1.35, 'On July 24th 2018')
Insert into SavingsInterestRates Values (010, 1.65, 'On June 11th 2018')


-- 3) Insert data into Failed Transaction Error Type Table

Insert into FailedTransactionErrorType Values (1, 'Insufficient Funds')
Insert into FailedTransactionErrorType Values (2, 'Limit Exceeded')
Insert into FailedTransactionErrorType Values (3, 'Expire Card')
Insert into FailedTransactionErrorType Values (4, 'Invalid Credit Card Number')
Insert into FailedTransactionErrorType Values (5, 'Invalid Expiration Date')
Insert into FailedTransactionErrorType Values (6, 'Card Issuer Declined CVV')
Insert into FailedTransactionErrorType Values (7, 'Authentication Failure')
Insert into FailedTransactionErrorType Values (8, 'Transaction Error')
Insert into FailedTransactionErrorType Values (9, 'Transaction Not Supported')
Insert into FailedTransactionErrorType Values (10, 'System Error')

-- 4) Insert data into Login Error Log Table

Insert into LoginErrorLog Values (1, '2021-04-01 15:09:26','We could not connect to your bank because your username and/or password were reported to be incorrect. 
Please re-verify your username and password and try again.[UAR Error 402]')
Insert into LoginErrorLog Values (2, '2021-04-02 10:52:20','We could not connect to your bank because it is experiencing technical difficulties or is unresponsive.
Please try again or contact support.[Site Error 415]' )
Insert into LoginErrorLog Values (3, '2021-04-03 09:23:15','We have attempted to connect to your bank but it looks like you are already logged in. 
If you are currently logged on to your bank directly, please log off and try again in a few minutes.[Site Error 416]')
Insert into LoginErrorLog Values (4, '2021-04-04 02:42:23','It looks like your bank is experiencing technical difficulties with the connection. 
Please try again soon or contact support. [Site Error 418]')
Insert into LoginErrorLog Values (5, '2021-04-05 17:25:13','Your request was not completed because you cancelled the process. 
Please try again or start over. [UAR Error 405]')


-- 5) Insert data into Account Status Type Table

Insert into AccountStatusType Values (101, 'Active Account')
Insert into AccountStatusType Values (102, 'Inactive Account')
Insert into AccountStatusType Values (103,'Account In process')
Insert into AccountStatusType Values (104, 'Account Terminated')
Insert into AccountStatusType Values (105, 'Verfified Account')


-- 6) Insert data into Account Type

Insert into AccountType Values (001, 'Saving Account')
Insert into AccountType Values (002, 'Checking Account')


-- 7) Insert data into Transaction Type Account

Insert into TransactionType Values (1, 'ATM', 'Deposit or withdraw funds using an ATM', 200)
Insert into TransactionType Values (2, 'Online', 'Withdraw funds through online banking service', 135)
Insert into TransactionType Values (3, 'Charge', 'Withdraw funds using a debit card', 310)
Insert into TransactionType Values (4, 'ATM', 'Deposit or withdraw funds using an ATM', 380)
Insert into TransactionType Values (5, 'Withdrawal', 'Deduct funds from an account by any method', 156)
Insert into TransactionType Values (6, 'Deposit','Add funds to an account by any method' , 265)
Insert into TransactionType Values (7, 'Transfer', 'Move funds from one account to another', 560)
Insert into TransactionType Values (8, 'Online', 'Withdraw funds through online banking service', 155)
Insert into TransactionType Values (9, 'Transfer', 'Move funds from one account to another', 450)
Insert into TransactionType Values (10, 'Withdrawal', 'Deduct funds from an account by any method', 295)

-- 8) Insert into Employee Table

Insert into Employee Values (1001, 'James', 'R', 'Thompson', 1)
Insert into Employee Values (1002, 'Maria','S', 'Beckham', 0)
Insert into Employee Values (1003, 'Stanley','M', 'Abraham', 1)
Insert into Employee Values (1004, 'Lorryne', 'S', 'Schreiber', 0)
Insert into Employee Values (1005, 'Brian', 'P', 'Cohen', 1)
Insert into Employee Values (1006, 'Chaim', 'P', 'Rosner', 1)
Insert into Employee Values (1007, 'Kobi', 'T', 'Rosen', 0)
Insert into Employee Values (1008, 'Lucy', 'B', 'Martin', 0)
Insert into Employee Values (1009, 'Susan', 'T', 'Joseph', 1)
Insert into Employee Values (1010, 'David', 'K', 'Martin', 1)


-- 9) Insert data into Users Login Table

Insert into UserLogins Values (001, 'R.James', 'Thompson01')
Insert into UserLogins Values (002, 'S.Maria', 'Beckham01')
Insert into UserLogins Values (003, 'M.Stanley','Abraham01')
Insert into UserLogins Values (004, 'S.Lorryne','Schreiber01')
Insert into UserLogins Values (005, 'P.Brian', 'Cohen01')
Insert into UserLogins Values (006, 'P.Chaim', 'Rosner01')
Insert into UserLogins Values (007, 'T.Kobi', 'Rosen01')
Insert into UserLogins Values (008, 'B.Lucy', 'Martin01')
Insert into UserLogins Values (009, 'T.Susan','Joseph01')
Insert into UserLogins Values (010, 'K.David', 'Martin01')

-- Inserting Data into the Tables having Foreign Keys

-- 10) Insert data into Failed Transaction Log Table

Insert into FailedTransactionLog Values (101, 1, '2021-03-25','We could not connect to your bank because your username 
and/or password were reported to be incorrect.Please re-verify your username and password and try again.[UAR Error 402]')
Insert into FailedTransactionLog Values (102,4, '2021-03-30', 'It looks like your bank is experiencing technical 
difficulties with the connection.Please try again soon or contact support. [Site Error 418]')
Insert into FailedTransactionLog Values (103, 3, '2021-04-15', 'We have attempted to connect to your bank but it looks 
like you are already logged in. If you are currently logged on to your bank directly, please log off and try again in a few minutes.[Site Error 416]' )
Insert into FailedTransactionLog Values (104, 2, '2021-04-07', 'We could not connect to your bank because it is experiencing technical difficulties or is unresponsive.
Please try again or contact support.[Site Error 415]' )
Insert into FailedTransactionLog Values (105, 1, '2021-03-21','We could not connect to your bank because your username and/or password were reported to be incorrect. 
Please re-verify your username and password and try again.[UAR Error 402]')
Insert into FailedTransactionLog Values (106, 5, '2021-04-10', 'Your request was not completed because you cancelled the process. 
Please try again or start over. [UAR Error 405]')
Insert into FailedTransactionLog Values (107, 4, '2021-04-07','It looks like your bank is experiencing technical difficulties with the connection. 
Please try again soon or contact support. [Site Error 418]')
Insert into FailedTransactionLog Values (108, 3, '2021-03-29', 'We have attempted to connect to your bank but it looks like you are already logged in. 
If you are currently logged on to your bank directly, please log off and try again in a few minutes.[Site Error 416]' )
Insert into FailedTransactionLog Values (109, 2, '2021-04-22', 'We could not connect to your bank because it is experiencing technical difficulties or is unresponsive.
Please try again or contact support.[Site Error 415]')
Insert into FailedTransactionLog Values (110, 5, '2021-04-03','Your request was not completed because you cancelled the process. 
Please try again or start over. [UAR Error 405]')

-- 11) Insert data into Account Table

Insert into Account Values (01, 2000, 001, 105, 03)
Insert into Account Values (02, 3000, 002, 103, 05)
Insert into Account Values (03, 5600, 001, 102, 02)
Insert into Account Values (04, 7200, 001, 101, 01)
Insert into Account Values (05, 9600, 002, 102, 04)
Insert into Account Values (06, 1500, 002, 102, 01)
Insert into Account Values (07, 1423, 001, 103, 03)
Insert into Account Values (08, 2300, 001, 104, 07)
Insert into Account Values (09, 8600, 002, 102, 06)
Insert into Account Values (010,6600, 001, 105, 09)

-- 12) Insert data into Login Account Table

Insert into LoginAccount Values (003, 05)
Insert into LoginAccount Values (002, 04)
Insert into LoginAccount Values (001, 06)
Insert into LoginAccount Values (006, 02)
Insert into LoginAccount Values (009, 01)
Insert into LoginAccount Values (004, 010)
Insert into LoginAccount Values (006, 03)
Insert into LoginAccount Values (005, 09)
Insert into LoginAccount Values (002, 07)
Insert into LoginAccount Values (008, 08)

-- 13) Insert data into Overdraft Log Table

Insert into OverDraftLog Values (01, '2021-03-25',5600,'Debit Purchases')
Insert into OverDraftLog Values (02, '2021-04-07', 2300, 'Bill payments and pre-authorized debits')
Insert into OverDraftLog Values (03, '2021-04-10', 5600, 'Cheques')
Insert into OverDraftLog Values (04, '2021-03-15', 4500, 'Withdrawals')
Insert into OverDraftLog Values (05, '2021-04-12', 6300, 'Withdrawals')
Insert into OverDraftLog Values (06, '2021-04-08', 5400, 'Debit Purchases')
Insert into OverDraftLog Values (07, '2021-03-04', 2200, 'Bill payments and pre-authorized debits')
Insert into OverDraftLog Values (08, '2021-04-17', 6900,'Transfers between bank accounts')
Insert into OverDraftLog Values (09, '2021-03-30', 5200, 'Cheques')
Insert into OverDraftLog Values (010, '2021-04-29', 1400, 'Debit Purchases')


-- 14) Insert Data into User Security Answers Table

Insert into UserSecurityAnswers Values (001,'School-Faywood', 3)
Insert into UserSecurityAnswers Values (002, 'Color-Blue',1)
Insert into UserSecurityAnswers Values (003, 'Memorable- 16th October',2)
Insert into UserSecurityAnswers Values (004, 'Birthday-25Nov', 5)
Insert into UserSecurityAnswers Values (005, 'Toy-Snoopy', 4)


-- 15) Insert data into Customer Table

Insert into Customer Values (1001, 01, 'HouseNo-6','Tern Road', 'Diana','S','Williams','Woodbridge','ON','L4H2K3',
's.diana@gmail.com','4167835623','6476187023','4165694520','502243563', 002)
Insert into Customer Values (1002, 04, 'Unit-158','525 Wilson Av','Robert','M','Scott','North York','ON','M3H0A7',
'm.robert@gmail.com','4168965230','6478529645','4168953257','504963458',005)
Insert into Customer Values (1003,02,'Unit-439','Lawrence Ave','Ravon','P','Schreiber','Winfield','BC','V4V9S0',
'p.ravon@gmail.com','4168975201','9054561235','6478954236','500563412',006)
Insert into Customer Values (1004, 03, 'HouseNno-19','Rocky River Dr','Mathew','W','Baron','Strathroy','ON','N7G 4Y3',
'w.mathew@gmail.com','9052364521','4168964578','6472364521','502456148',008)
Insert into Customer Values (1005, 05, 'HouseNo-7108','South Lookout Road','Cecille','N','Hipple','Ville Émard','QC','H4E 3L7',
'n.cecille@gmail.com','9054523698','4523650789','6478594562','504895622',001)
Insert into Customer Values (1006, 07, 'HouseNo-324','South Lantern St','Aayesha','M','Mohasain','Saint-Sophie','QC','J5J 5A2',
'm.aayesha@gmail.com','6478534562','9054567524','4165634285','502897453',003)
Insert into Customer Values (1007, 06,'HouseNo-221','Hickory Dr','Rosylin','F','Mitchell','Sainte-Julie','ON','J3E 0T3' ,
'f.rosylin@gmail.com','4165637852','4168512398','6478953246','500789123',006)
Insert into Customer Values (1008, 09, 'HouseNo-20','Nelson Street','Marcia','T','Thomas','Nobel','ON','P0G 1G0',
't.marcia@gmail.com','4165634521','9054568524','6475268945','945852963',004)
Insert into Customer Values (1009, 08,'HouseNo-899','Essendene Avenue','Angela','P','Walker','Abbotsford','BC','V2S 2H7',
'p.angela@gmail.com','604854483','6045267894','9057851234','504896714',007)
Insert into Customer Values (1010,10,'HouseNo-4636','Eglinton Avenue','James','J','Eagle','Toronto','ON','M4P 1A6',
'j.james@gmail.com','6472061733','9056327584','4165632546','924564125',009)


-- 16) Insert data into Customer Account Table

Insert into CustomerAccount Values (02,1009)
Insert into CustomerAccount Values (01,1005)
Insert into CustomerAccount Values (03,1006)
Insert into CustomerAccount Values (04,1007)
Insert into CustomerAccount Values (09,1001)
Insert into CustomerAccount Values (010,1003)
Insert into CustomerAccount Values (05,1008)
Insert into CustomerAccount Values (06,1004)
Insert into CustomerAccount Values (08,1010)
Insert into CustomerAccount Values (07,1002)

-- 17) Insert data into Transaction Log Table

Insert into TransactionLog Values (201, '2021-04-25',8 , 25000, 15000, 03, 1001,1005,5)
Insert into TransactionLog Values (202,'2021-03-15',3, 65000, 23000, 01, 1002, 1007,6)
Insert into TransactionLog Values (203, '2021-03-12', 5, 51000, 45000, 02, 1005, 1005,4)
Insert into TransactionLog Values (204, '2021-04-03', 6, 423000, 12000, 09, 1007, 1004,2)
Insert into TransactionLog Values (205, '2021-03-14', 2, 54000, 56000, 08, 1010, 1006,1)
Insert into TransactionLog Values (206, '2021-03-21', 1, 15600, 41000, 07, 1006, 1005,3)
Insert into TransactionLog Values (207, '2021-04-12', 4, 13500, 16000, 04, 1004, 1009,6)
Insert into TransactionLog Values (208, '2021-03-11',10, 452300, 21000, 06, 1009, 1006,9)
Insert into TransactionLog Values (209, '2021-04-16', 7, 451400, 10000, 010, 1003, 1005,10)
Insert into TransactionLog Values (210, '2021-04-05', 9, 89000, 56000, 05, 1008, 1009,8)


--------------------------------------------------------------------------------------------------------------------------------

-- Data is inserted into the table--

--Phase-2 Project Work--
---------------------------------------------------------------------------------------------------------------------------------

--1.	Create a view to get all customers with checking account from ON province. --

CREATE VIEW Customer_ON AS
SELECT DISTINCT c.CustomerID, c.CustomerFirstName, c.CustomerLastName, c.City, c.State, c.ZipCode,c.EmailAddress, c.CellPhone, at.AccountTypeDescription FROM Customer c
JOIN Account a
ON c.AccountID = a.AccountId
JOIN AccountType at
ON a.AccountTypeID = at.AccountTypeID
WHERE at.AccountTypeDescription = 'Checking Account' and c.State = 'ON';
GO

Select * from Customer_ON

-------------------------------------------------------------------------------------------------------------------------------

--2.	Create a view to get all customers with total account balance greater than 5000. --

Create View
AccountBal As
Select CustomerID,CustomerFirstName, City, State, ZipCode, CellPhone, SSN, CurrentBalance
From Customer
Join Account
on Customer.AccountID = Account.AccountID
Where CurrentBalance>5000

Select * from AccountBal

--3.	Create a view to get counts of checking and savings accounts by customer. --

CREATE VIEW Customer_AccountTypes 
AS
SELECT c.CustomerFirstName, ac.AccountTypeDescription, COUNT(*) AS Total_Account_Types 
FROM Customer c
JOIN Account a
ON c.AccountID = a.AccountId
JOIN AccountType ac
ON a.AccountTypeID = ac.AccountTypeID
GROUP BY c.CustomerFirstName, ac.AccountTypeDescription;
GO

Select * From Customer_AccountTypes

-----Other way to do this query-----

Create View
CountAccounts As
Select CustomerID, CustomerFirstName, AccountTypeID
From Customer
Join Account
on Customer.AccountID = Account.AccountID

Select * from CountAccounts

-- Count of Saving Account--

Create View
SavingAccount As
Select CustomerID, CustomerFirstName, AccountTypeDescription
from CountAccounts
Join AccountType
On CountAccounts.AccountTypeID = AccountType.AccountTypeID
Where AccountTypeDescription = 'Saving Account'

Select * from SavingAccount

-- Count of Cheking Account--

Create View
CheckingAccount As
Select CustomerID, CustomerFirstName, AccountTypeDescription
from CountAccounts
Join AccountType
On CountAccounts.AccountTypeID = AccountType.AccountTypeID
Where AccountTypeDescription = 'Checking Account'

Select * from CheckingAccount

--4.	Create a view to get any particular user’s login and password using AccountId. --

Create View
LoginDetails As

Select AccountID, UserLogin, UserPassword
From UserLogins
Join LoginAccount
On UserLogins.UserLoginID = LoginAccount.UserLoginID


Select * from LoginDetails
Order by AccountID

--5.	Create a view to get all customers’ overdraft amount.--

Create View 
OverdraftAmount As

Select CustomerID, CustomerFirstName, CustomerLastName, CellPhone, OverDraftAmount, OverDraftTransactionXML
From OverDraftLog
join Customer
On OverDraftLog.AccountID = Customer.AccountID

Select * from OverdraftAmount

--6.	Create a stored procedure to add “User_” as a prefix to everyone’s login (username). --

CREATE PROCEDURE spUsernameUpdate
AS

Begin
UPDATE UserLogins
SET UserLogin = Concat('User_', UserLogin);
End

Execute spUsernameUpdate

select * from UserLogins

--7.	Create a stored procedure that accepts AccountId as a parameter and returns customer’s full name. --

Create Procedure
spCustomerFullName 
@AccountId int
As

Begin

 Select CustomerFirstName, CustomerMiddleInitial, CustomerLastName 
 From Customer
 Where AccountID = @AccountId

End

Execute spCustomerFullName 1Execute spCustomerFullName 2Execute spCustomerFullName 3Execute spCustomerFullName 4Execute spCustomerFullName 5Execute spCustomerFullName 6Execute spCustomerFullName 7Execute spCustomerFullName 8Execute spCustomerFullName 9Execute spCustomerFullName 10
--8.	Create a stored procedure that takes a deposit as a parameter and updates CurrentBalance value for that particular 
--account.-- 


CREATE PROCEDURE sp_Balance_Update @AccountID INT, @Deposit INT
AS

UPDATE Account
SET CurrentBalance = CurrentBalance + @Deposit
where AccountID = @AccountID;
GO

Execute sp_Balance_Update 1, 500;


Select * from Account


--9.	Create a stored procedure that takes a withdrawal amount as a parameter and updates CurrentBalance value for that 
--particular account.


CREATE PROCEDURE sp_Withdrawal_Update @AccountID INT, @Withdraw INT
AS
UPDATE Account
SET CurrentBalance = CurrentBalance - @Withdraw
WHERE AccountID = @AccountID;
GO

Execute sp_Withdrawal_Update 3, 1500;

Select * from Account

--10.	Write a query to remove SSN column from Customer table. --

CREATE PROCEDURE sp_Remove_SSN
AS
ALTER TABLE CUSTOMER
DROP COLUMN SSN;
GO

Execute sp_Remove_SSN

Select * from Customer


--All Views Created in the Project

Select * from Customer_ON
Select * from AccountBal
Select * From Customer_AccountTypes
Select * from LoginDetails
Select * from OverdraftAmount
select * from UserLogins

-- All Procedures Created in the Project

Execute spUsernameUpdate
Execute spCustomerFullName 1
Execute sp_Balance_Update 1, 500
Execute sp_Withdrawal_Update 3, 1500


----------------------------------------------------------------------------------------------------------------------------------------------------------------



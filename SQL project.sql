USE banking_system;
CREATE TABLE customers (
customer_id INT PRIMARY KEY auto_increment,
customer_name VARCHAR(50),
email_id varchar(30),
phone_number bigint,
city varchar(30));
insert into customers( customer_name,email_id,phone_number,city) values 
('Amit','amit@gmail.com',9876543210,'Delhi'),
('Neha','neha@gmail.com',9876543211,'Mumbai'),
('Rohit','rohit@gmail.com',9876543212,'Pune');
select * from customers ;
CREATE TABLE accounts (
acc_id int primary key auto_increment,
customer_id int,
account_type varchar(10),
balance int );
insert into accounts  ( customer_id,account_type , balance) values 
(1,'Savings',20000),
(2,'Current',15000),
(3,'Savings',30000);
select * from accounts ;
create table transaction(
transaction_id	int ,
acc_id int,
transaction_type varchar(30),
amount	int,
transaction_date datetime );
insert into transaction( transaction_id	,acc_id	,transaction_type,amount,transaction_date) values
(1,1,'Deposit',5000,'2026-04-09 10:00:00'),
(2,2,'Withdrawal',2000,'2026-04-09 11:00:00'),
(3,1,'Deposit',3000	,'2026-04-09 12:00:00');
create table loan( customer_id int primary key auto_increment,
loan_id int,
loan_amount int,
interest_rate decimal(2,1),
loan_status varchar(15) );
insert into loan(loan_id,loan_amount,interest_rate,loan_status)
values(1,50000,7.5,'Active'),
(2,100000,8.2,'Pending');
select * from loan ;
drop table loan;

ALTER TABLE accounts
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id) 
REFERENCES customers(customer_id);

ALTER TABLE transaction 
ADD CONSTRAINT fk_account
FOREIGN KEY (acc_id) 
REFERENCES accounts(acc_id);

ALTER TABLE loan 
ADD CONSTRAINT fk_loan
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE accounts
ADD CONSTRAINT chk_balance
CHECK (balance >= 0);

START TRANSACTION;
UPDATE accounts
SET balance = balance - 3000
WHERE acc_id = 1;
UPDATE accounts
SET balance = balance + 3000
WHERE acc_id = 2;
INSERT INTO transaction (transaction_id,acc_id,transaction_type,amount,transaction_date) VALUES
(4,1,'Debit',3000,now()),
(5,2,'Credit',3000,now());
COMMIT;
select*from accounts;
select*from transaction;
START TRANSACTION; 
UPDATE accounts
SET balance = balance - 50000 
WHERE acc_id = 1; 
ROLLBACK;

/* Question 1 Show All Customers*/
select*from customers;
/* Q 2 Show Accounts with Customer Names*/
SELECT customers.customer_name, accounts.*
FROM customers
INNER JOIN accounts
ON customers.customer_id = accounts.customer_id;
/* Q3 Show All Transactions*/
select*from Transaction;
/* Q4 show loan details*/
select*from loan;
/* Q5 total balance in bank */
select sum(balance) as total_balance_in_bank 
from  accounts;
/* Q6 insert accounts to customer */
CREATE TABLE accounts (
acc_id int primary key auto_increment,
customer_id int,
account_type varchar(10),
balance int
 );
insert into accounts  ( customer_id,account_type , balance) values 
(1,'Savings',20000),
(2,'Current',15000),
(3,'Savings',30000);
select*from accounts;
/* Q7 insert loan record */
create table loan( customer_id int primary key auto_increment,
loan_id int,
loan_amount int,
interest_rate decimal(2,1),
loan_status varchar(15)
);
insert into loan(loan_id,loan_amount,interest_rate,loan_status)
values(1,50000,7.5,'Active'),
(2,100000,8.2,'Pending');

/* Q8 transfer 2000 from account 1 to 2 */
START TRANSACTION;
UPDATE transaction
SET amount = amount - 2000
WHERE acc_id = 1;
UPDATE transaction
SET amount = amount + 2000
WHERE acc_id = 2;

/* Q9 Use commit to save transaction  */
START TRANSACTION;
UPDATE accounts
SET balance = balance - 3000
WHERE acc_id = 1;
UPDATE accounts
SET balance = balance + 3000
WHERE acc_id = 2;
INSERT INTO transaction (transaction_id,acc_id,transaction_type,amount,transaction_date) VALUES
(4,1,'Debit',3000,now()),
(5,2,'Credit',3000,now());
COMMIT;
/* Q 10 use Rollback if transaction fails*/
START TRANSACTION; 
UPDATE accounts 
SET balance = balance - 50000 
WHERE acc_id = 1; 
ROLLBACK;
/*Q11 show customer name with amount balance*/
SELECT customers.customer_name, accounts.balance
FROM customers 
INNER JOIN accounts
ON customers.customer_id = accounts.customer_id;
/*Q12 Show customer havings loan*/
/*Q13 find total bank balance */
select sum(balance) as total_balance from accounts;
/* Q14 show all  transactions of account 1 */
select*from transaction where acc_id = 1;
/* Q15 Write transaction: 
✔ Deduct ₹5000 
✔ Add ₹5000 
✔ Insert transaction records 
✔ Use COMMIT */
START TRANSACTION;
UPDATE accounts
SET balance = balance - 300
WHERE acc_id = 2;
UPDATE accounts
SET balance = balance + 300
WHERE acc_id = 3;
INSERT INTO transaction (transaction_id,acc_id,transaction_type,amount,transaction_date) VALUES
(4,1,'Debit',300,now()),
(5,2,'Credit',300,now());
COMMIT;


select * from loan;
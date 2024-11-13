CREATE DATABASE friendly_bank;
USE friendly_bank;


CREATE TABLE customers (
    cust_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    total_balance DECIMAL(10, 2)
);


CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    cust_id INT,
    account_type VARCHAR(10),
    available_balance DECIMAL(10, 2),
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_amount DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);


CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    title VARCHAR(50)
);
-- users date
INSERT INTO customers (cust_id, first_name, last_name, total_balance) VALUES
(1, 'James', 'Hadley', 5000.00),
(2, 'Alice', 'Smith', 1500.50);

-- 
INSERT INTO accounts (account_id, cust_id, account_type, available_balance) VALUES
(1, 1, 'CHK', 3000.00),
(2, 1, 'SAV', 2000.00),
(3, 2, 'CHK', 1500.50);

-- 
INSERT INTO transactions (transaction_id, account_id, transaction_amount, transaction_date) VALUES
(1, 1, 500.00, '2024-01-01'),
(2, 2, 1000.00, '2024-01-02');

-- 
INSERT INTO employees (emp_id, first_name, last_name, title) VALUES
(1, 'Michael', 'Smith', 'Manager'),
(2, 'John', 'Doe', 'Teller');
--task1-4
SELECT COUNT(*) AS TotalTransactions FROM transactions;
SELECT COUNT(*) AS TotalCHKAccounts FROM accounts WHERE account_type = 'CHK';
SELECT title, COUNT(*) AS NumEmployees FROM employees GROUP BY title;
SELECT c.first_name, c.last_name, COUNT(a.account_id) AS NumAccounts
FROM customers c
JOIN accounts a ON c.cust_id = a.cust_id
GROUP BY c.first_name, c.last_name;
SELECT SUM(available_balance) AS TotalBalance
FROM accounts
WHERE cust_id = 1;
SELECT c.first_name, c.last_name, SUM(a.available_balance) AS TotalBalance
FROM customers c
JOIN accounts a ON c.cust_id = a.cust_id
GROUP BY c.first_name, c.last_name;
SELECT account_type, AVG(available_balance) AS AvgBalance
FROM accounts
GROUP BY account_type;



--m task
SELECT account_type, MAX(available_balance) AS MaxBalance
FROM accounts
GROUP BY account_type;
SELECT MIN(available_balance) AS MinBalance FROM accounts;
SELECT c.first_name, c.last_name, FLOOR(SUM(a.available_balance)) AS TotalBalance
FROM customers c
JOIN accounts a ON c.cust_id = a.cust_id
GROUP BY c.first_name, c.last_name;
SELECT CONCAT(last_name, ', ', first_name) AS EmployeeName FROM employees;
SELECT CONCAT(first_name, ' ', last_name, ' Position: ', title) AS EmployeePosition FROM employees;


--last task
SELECT REPLACE('Fear leads to anger; anger leads to hatred; hatred leads to conflict; conflict leads to suffering', 'anger', 'panic buying') AS ModifiedText;


UPDATE customers
SET fed_id = REPLACE(fed_id, '-', '');
SELECT YEAR(transaction_date) AS Year, COUNT(*) AS TransactionCount
FROM transactions
GROUP BY YEAR(transaction_date);
UPDATE employees
SET title = UPPER(title);




SELECT COUNT(*) AS Count, 
       CASE 
           WHEN title LIKE '%TELLER%' THEN 'Cashier' 
           ELSE 'Other' 
       END AS JobTitle
FROM employees
GROUP BY CASE 
             WHEN title LIKE '%TELLER%' THEN 'Cashier' 
             ELSE 'Other' 
         END;

SELECT c.first_name, c.last_name, SUM(a.available_balance) AS TotalBalance
FROM customers c
JOIN accounts a ON c.cust_id = a.cust_id
GROUP BY c.first_name, c.last_name
HAVING SUM(a.available_balance) < 5000;
SELECT b.branch_name, COUNT(e.emp_id) AS NumEmployees
FROM employees e
JOIN branch b ON e.branch_id = b.branch_id
GROUP BY b.branch_name;
SELECT COUNT(*) AS Count, 
       CASE 
           WHEN account_type = 'CHK' THEN 'Checking Account' 
           WHEN account_type = 'SAV' THEN 'Savings Account' 
       END AS ProductType
FROM accounts
WHERE account_type IN ('CHK', 'SAV')
GROUP BY account_type;

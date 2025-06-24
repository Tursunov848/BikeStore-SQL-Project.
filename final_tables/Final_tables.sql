-- Final tables --

-- Creating schemas
Create schema Production
Create schema Sales
    
-- Creating final tables

Create table Production.categories (
    category_id int Primary key,
    category_name varchar(255) not null);

Select * from Production.categories

Create table Production.brands (
    brand_id int Primary key,
    brand_name varchar(255) not null);

Select * from Production.brands

Create table Production.products (
    product_id int Primary key,
    product_name varchar(255) not null,
    brand_id int not null,
    category_id int not null,
    model_year int,
    list_price decimal(10,2),
    Constraint fk_products_brand Foreign key (brand_id) references brands(brand_id),
    Constraint fk_products_category Foreign key (category_id) references categories(category_id));

Select * from Production.products

Create table sales.stores (
    store_id int Primary key,
    store_name varchar(255) not null,
    phone varchar(50),
    email varchar(255),
    street varchar(255),
    city varchar(100),
    state varchar(100),
    zip_code varchar(20));

Select * from sales.stores

Create table sales.staffs (
    staff_id int Primary key,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    email varchar(255),
    phone varchar(50),
    active BIT not null,
    store_id INT not null,
    manager_id int null, 
    Constraint fk_staffs_store Foreign key (store_id) references stores(store_id),
    Constraint fk_staffs_manager Foreign key (manager_id) references staffs(staff_id));

Select * from sales.staffs

Create table sales.customers (
    customer_id int Primary key,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    phone varchar(50),
    email varchar(255),
    street varchar(255),
    city varchar(100),
    state varchar(100),
    zip_code varchar(20));

Select * from sales.customers

Create table sales.orders (
    order_id int Primary key,
    customer_id int not null,
    order_status int not null,
    order_date date not null,
    required_date date not null,
    shipped_date date,
    store_id int not null,
    staff_id int not null,
    Constraint fk_orders_customer Foreign key (customer_id) references customers(customer_id),
    Constraint fk_orders_store Foreign key (store_id) references stores(store_id),
    Constraint fk_orders_staff Foreign key (staff_id) references staffs(staff_id));

Select * from sales.orders

Create table sales.order_items (
    order_id int not null,
    item_id int not null,
    product_id int not null,
    quantity int not null,
    list_price decimal(10,2) not null,
    discount decimal(4,2) not null,
    Primary key (order_id, item_id),
    Constraint fk_orderitems_order Foreign key (order_id) references orders(order_id),
    Constraint fk_orderitems_product Foreign key (product_id) references products(product_id));

Select * from sales.order_items

Create table production.stocks (
    store_id int not null,
    product_id int not null,
    quantity int not null,
    Primary key (store_id, product_id),
    Constraint fk_stocks_store Foreign key (store_id) references stores(store_id),
    Constraint fk_stocks_product Foreign key (product_id) references products(product_id));

Select * from production.stocks


-- Inserting data from staging tables to final tables
INSERT INTO Core_Banking.Accounts
SELECT * FROM [staging].[accounts];

--ALTER TABLE Core_Banking.Branches
--ALTER COLUMN [ContactNumber] VARCHAR(100); 

-- 3. Transactions
INSERT INTO Core_Banking.transactions
SELECT * FROM staging.transactions;

-- 4. Branches
INSERT INTO final.branches
SELECT * FROM staging.stg_branches;

-- 5. Employees
INSERT INTO Core_Banking.employees
SELECT * FROM staging.employees;

-- 6. CreditCards
INSERT INTO Digital_Banking_Payments.CreditCards
SELECT * FROM staging.credit_cards;

-- 7. CreditCardTransactions
INSERT INTO Digital_Banking_Payments.CreditCardTransactions
SELECT * FROM staging.credit_card_transactions;

-- 8. OnlineBankingUsers
INSERT INTO Digital_Banking_Payments.OnlineBankingUsers
SELECT * FROM staging.online_banking_users;

-- 9. BillPayments
INSERT INTO Digital_Banking_Payments.BillPayments
SELECT * FROM staging.bill_payments;

-- 10. MobileBankingTransactions
INSERT INTO Digital_Banking_Payments.MobileBankingTransactions
SELECT * FROM staging.mobile_banking_transactions;

-- 11. Loans
INSERT INTO Loans_Credit.loans
SELECT * FROM staging.loans;

-- 12. LoanPayments
INSERT INTO Loans_Credit.loanpayments
SELECT * FROM staging.loan_payments;

-- 13. CreditScores
INSERT INTO Loans_Credit.creditscores
SELECT * FROM staging.credit_scores;

-- 14. DebtCollection
INSERT INTO Loans_Credit.debtcollection
SELECT * FROM staging.debt_collection;

-- 15. KYC
INSERT INTO Compliance_Risk.kyc
SELECT * FROM staging.kyc;

-- 16. FraudDetection
INSERT INTO Compliance_Risk.frauddetection
SELECT * FROM staging.fraud_detection;

-- 17. AML Cases
INSERT INTO Compliance_Risk.amlcases
SELECT * FROM staging.aml_cases;


--SELECT COLUMN_NAME, DATA_TYPE
--FROM INFORMATION_SCHEMA.COLUMNS
--WHERE TABLE_SCHEMA = 'staging' AND TABLE_NAME = 'aml_cases';

--SELECT COLUMN_NAME, DATA_TYPE
--FROM INFORMATION_SCHEMA.COLUMNS
--WHERE TABLE_SCHEMA = 'Compliance_Risk' AND TABLE_NAME = 'amlcases';

--ALTER TABLE Compliance_Risk.amlcases
--ALTER COLUMN InvestigatorID nvarchar(100);

-- 18. RegulatoryReports
INSERT INTO Compliance_Risk.regulatoryreports
SELECT * FROM staging.regulatory_reports;

-- 19. Departments
INSERT INTO Human_Resources.departments
SELECT * FROM staging.departments;

-- 20. Salaries
INSERT INTO Human_Resources.salaries
SELECT * FROM staging.salaries;

-- 21. EmployeeAttendance
INSERT INTO Human_Resources.employeeattendance
SELECT * FROM staging.employee_attendance;

-- 22. Investments
INSERT INTO Investments_Treasury.investments
SELECT * FROM staging.investments;

-- 23. StockTradingAccounts
INSERT INTO Investments_Treasury.stocktradingaccounts
SELECT * FROM staging.stock_trading_accounts;

-- 24. ForeignExchange
INSERT INTO Investments_Treasury.foreignexchange
SELECT * FROM staging.foreign_exchange;

-- 25. InsurancePolicies
INSERT INTO Insurance_Security.insurancepolicies
SELECT * FROM staging.insurance_policies;

-- 26. Claims
INSERT INTO Insurance_Security.claims
SELECT * FROM staging.claims;

-- 27. UserAccessLogs
INSERT INTO Insurance_Security.useraccesslogs
SELECT * FROM staging.user_access_logs;

-- 28. CyberSecurityIncidents
INSERT INTO Insurance_Security.cybersecurityincidents
SELECT * FROM staging.cybersecurity_incidents;

-- 29. Merchants
INSERT INTO Merchant_Services.merchants
SELECT * FROM staging.merchants;

-- 30. MerchantTransactions
INSERT INTO Merchant_Services.merchanttransactions
SELECT * FROM staging.merchant_transactions;

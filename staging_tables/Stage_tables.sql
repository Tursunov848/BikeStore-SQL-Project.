-- Staging tables --

-- Database creation
Create database BikeStore_db
Use BikeStore_db

-- Creating schema
Create schema staging


-- Creating staging tables

-- Products Staging Table
Create table staging.stg_products (
    product_id int,
    product_name varchar(255),
    brand_id int,
    category_id int,
    model_year int,
    list_price decimal(10,2));


-- Orders Staging Table
Create table staging.stg_orders (
    order_id int,
    customer_id int,
    order_status int,
    order_date date,
    required_date date,
    shipped_date date,
    store_id int,
    staff_id int);


-- Order Items Staging Table
Create table staging.stg_order_items (
    order_id int,
    item_id int,
    product_id int,
    quantity int,
    list_price decimal(10,2),
    discount decimal(4,2));


-- Stores Staging Table
Create table staging.stg_stores (
    store_id int,
    store_name varchar(255),
    phone varchar(50),
    email varchar(255),
    street varchar(255),
    city varchar(100),
    state varchar(100),
    zip_code varchar(20));


-- Stocks Staging Table
Create table staging.stg_stocks (
    store_id int,
    product_id int,
    quantity int);


-- Staffs Staging Table
Create table staging.stg_staffs (
    staff_id int,
    first_name varchar(100),
    last_name varchar(100),
    email varchar(255),
    phone varchar(50),
    active bit,
    store_id int,
    manager_id int);


-- Customers Staging Table
Create table staging.stg_customers (
    customer_id int,
    first_name varchar(100),
    last_name varchar(100),
    phone varchar(50),
    email varchar(255),
    street varchar(255),
    city varchar(100),
    state varchar(100),
    zip_code varchar(20));


-- Brands Staging Table
Create table staging.stg_brands (
    brand_id int,
    brand_name varchar(255));


-- Categories Staging Table
Create table staging.stg_categories (
    category_id int,
    category_name varchar(255));

-- Inserting data into staging tables

Bulk insert staging.stg_products from 'C:\Users\laziz\Desktop\CSV files\products (1).csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from staging.stg_products

Bulk insert staging.stg_orders from 'C:\Users\laziz\Desktop\CSV files\orders.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from staging.stg_orders

Bulk insert staging.stg_order_items from 'C:\Users\laziz\Desktop\CSV files\order_items.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from staging.stg_order_items

Bulk insert staging.stg_stores from 'C:\Users\laziz\Desktop\CSV files\stores.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from staging.stg_stores

Bulk insert staging.stg_stocks from 'C:\Users\laziz\Desktop\CSV files\stocks.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from staging.stg_stocks

Bulk insert staging.stg_staffs from 'C:\Users\laziz\Desktop\CSV files\staffs.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from staging.stg_staffs

Bulk insert staging.stg_customers from 'C:\Users\laziz\Desktop\CSV files\customers.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from staging.stg_customers

Bulk insert staging.stg_brands from 'C:\Users\laziz\Desktop\CSV files\brands (1).csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from staging.stg_brands

Bulk insert staging.stg_categories from 'C:\Users\laziz\Desktop\CSV files\categories.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from staging.stg_categories
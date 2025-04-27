--Final tables--

-- Database creation:
Create database BikeStore
Use BikeStore

-- Tables creation

Create table categories (
    category_id int Primary key,
    category_name varchar(255) not null);

Select * from categories

Create table brands (
    brand_id int Primary key,
    brand_name varchar(255) not null);

Select * from brands

Create table products (
    product_id int Primary key,
    product_name varchar(255) not null,
    brand_id int not null,
    category_id int not null,
    model_year int,
    list_price decimal(10,2),
    Constraint fk_products_brand Foreign key (brand_id) references brands(brand_id),
    Constraint fk_products_category Foreign key (category_id) references categories(category_id));

Select * from products

Create table stores (
    store_id int Primary key,
    store_name varchar(255) not null,
    phone varchar(50),
    email varchar(255),
    street varchar(255),
    city varchar(100),
    state varchar(100),
    zip_code varchar(20));

Select * from stores

Create table staffs (
    staff_id int Primary key,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    email varchar(255),
    phone varchar(50),
    active bit not null,
    store_id int not null,
    manager_id INT null, 
    Constraint fk_staffs_store Foreign key (store_id) references stores(store_id),
    Constraint fk_staffs_manager Foreign key (manager_id) references staffs(staff_id));

Select * from staffs

Create table customers (
    customer_id int Primary key,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    phone varchar(50),
    email varchar(255),
    street varchar(255),
    city varchar(100),
    state varchar(100),
    zip_code varchar(20));

Select * from customers

Create table orders (
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

Select * from orders

Create table order_items (
    order_id int not null,
    item_id int not null,
    product_id int not null,
    quantity int not null,
    list_price decimal(10,2) not null,
    discount decimal(4,2) not null,
    Primary key (order_id, item_id),
    Constraint fk_orderitems_order Foreign key (order_id) references orders(order_id),
    Constraint fk_orderitems_product Foreign key (product_id) references products(product_id));

Select * from order_items

Create table stocks (
    store_id int not null,
    product_id int not null,
    quantity int not null,
    Primary key (store_id, product_id),
    Constraint fk_stocks_store Foreign key (store_id) references stores(store_id),
    Constraint fk_stocks_product Foreign key (product_id) references products(product_id));

Select * from stocks


-- Data inserting

-- Products
Bulk insert products from 'C:\Users\laziz\Desktop\CSV files\products (1).csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from products
	

-- Orders
Bulk insert orders from 'C:\Users\laziz\Desktop\CSV files\orders.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from Orders

-- Order_items
Bulk insert order_items from 'C:\Users\laziz\Desktop\CSV files\order_items.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from order_items

-- Stores
Bulk insert stores from 'C:\Users\laziz\Desktop\CSV files\stores.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from Stores

-- Stocks
Bulk insert stocks from 'C:\Users\laziz\Desktop\CSV files\stocks.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from stocks

-- Staffs
Bulk insert staffs from 'C:\Users\laziz\Desktop\CSV files\staffs.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from Staffs

-- Customers
Bulk insert customers from 'C:\Users\laziz\Desktop\CSV files\customers.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from Customers

-- Brands
Bulk insert brands from 'C:\Users\laziz\Desktop\CSV files\brands (1).csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from Brands

-- Categories
Bulk insert categories from 'C:\Users\laziz\Desktop\CSV files\categories.csv'
With (
    Firstrow = 2,
    Fieldterminator = ',',
    Rowterminator = '\n',
    Tablock);

Select * from Categories

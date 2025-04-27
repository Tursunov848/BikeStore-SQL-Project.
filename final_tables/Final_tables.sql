-- Final tables --

-- Creating final tables

Create table categories (
    category_id int Primary key,
    category_name varchar(255) not null);

Create table brands (
    brand_id int Primary key,
    brand_name varchar(255) not null);

Create table products (
    product_id int Primary key,
    product_name varchar(255) not null,
    brand_id int not null,
    category_id int not null,
    model_year int,
    list_price decimal(10,2),
    Constraint fk_products_brand Foreign key (brand_id) references brands(brand_id),
    Constraint fk_products_category Foreign key (category_id) references categories(category_id));

Create table stores (
    store_id int Primary key,
    store_name varchar(255) not null,
    phone varchar(50),
    email varchar(255),
    street varchar(255),
    city varchar(100),
    state varchar(100),
    zip_code varchar(20));

Create table staffs (
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

Create table stocks (
    store_id int not null,
    product_id int not null,
    quantity int not null,
    Primary key (store_id, product_id),
    Constraint fk_stocks_store Foreign key (store_id) references stores(store_id),
    Constraint fk_stocks_product Foreign key (product_id) references products(product_id));


-- Inserting data from staging tables to final tables

Insert into categories 
Select * from staging.stg_categories;

Select * from categories

Insert into brands 
Select * from staging.stg_brands;

Select * from brands


Insert into products 
Select * from staging.stg_products;

Select * from products


Insert into stores 
Select * from staging.stg_stores;

Select * from stores


Insert into staffs (staff_id, first_name, last_name, email, phone, active, store_id, manager_id)
Select
    staff_id,
    first_name,
    last_name,
    email,
    phone,
    active,
    store_id,
Case 
    When manager_id = 0 then NULL  
    Else manager_id
End manager_id from staging.stg_staffs;

Select * from staffs


Insert into customers (customer_id, first_name, last_name, phone, email, street, city, state, zip_code)
Select
    customer_id,
    first_name,
    last_name,
    phone,
    email,
    street,
    city,
    state,
    zip_code
From staging.stg_customers;

Select * from customers


Insert into orders (order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
Select
    order_id,
    customer_id,
    order_status,
    order_date,
    required_date,
    shipped_date,
    store_id,
    staff_id
from staging.stg_orders;

Select * from orders

Insert into order_items (order_id, item_id, product_id, quantity, list_price, discount)
Select
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount
From staging.stg_order_items;

Select * from order_items

Insert into stocks (store_id, product_id, quantity)
Select
    store_id,
    product_id,
    quantity
From staging.stg_stocks;

Select * from stocks



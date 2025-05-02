-- BikeStore_db - full scripts --

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

Insert into production.categories 
Select * from staging.stg_categories;

Select * from production.categories

Insert into production.brands 
Select * from staging.stg_brands;

Select * from production.brands


Insert into production.products 
Select * from staging.stg_products;

Select * from production.products


Insert into sales.stores 
Select * from staging.stg_stores;

Select * from sales.stores


Insert into sales.staffs (staff_id, first_name, last_name, email, phone, active, store_id, manager_id)
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

Select * from sales.staffs


Insert into sales.customers (customer_id, first_name, last_name, phone, email, street, city, state, zip_code)
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

Select * from sales.customers


Insert into sales.orders (order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
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

Select * from sales.orders

Insert into sales.order_items (order_id, item_id, product_id, quantity, list_price, discount)
Select
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount
From staging.stg_order_items;

Select * from sales.order_items

Insert into production.stocks (store_id, product_id, quantity)
Select
    store_id,
    product_id,
    quantity
From staging.stg_stocks;

Select * from production.stocks;

-- Views --

-- vw_StoreSalesSummary

Create view sales.vw_StoreSalesSummary as
select
    s.store_id,
    s.store_name,
    count(distinct o.order_id) as total_orders,
    count(distinct o.customer_id) as total_customers, 
    sum(oi.list_price * oi.quantity * (1 - oi.discount)) as total_revenue, 
    case 
        when count(distinct o.order_id) = 0 then 0
        else round(
            sum(oi.list_price * oi.quantity * (1 - oi.discount))  / count(distinct o.order_id), 2)
    end as average_order_value, 
    case
        when count(distinct o.customer_id) = 0 then 0
        else round(
            sum(oi.list_price * oi.quantity * (1 - oi.discount)) / count(distinct o.customer_id), 2)
    end as revenue_per_customer 
from
    sales.stores s
left join orders o on s.store_id = o.store_id
left join order_items oi on o.order_id = oi.order_id
group by s.store_id, s.store_name

select  * from  sales.vw_StoreSalesSummary order by total_revenue desc

-- vw_TopSellingProducts

Create view  sales.vw_TopSellingProducts as 
select p.product_id,
       p.[product_name],
	   c.category_name,
       coalesce(sum(oi.quantity) , 0) as total_quantity,
	   coalesce(sum(oi.list_price * oi.quantity * (1 - oi.discount)), 0 ) as total_revenue
from  production.[products] p
left join production.categories c on p.category_id = c.category_id
left join sales.[order_items] oi on p.product_id=oi.product_id
left join [dbo].[orders] o on oi.order_id=o.order_id
group by p.product_id,[product_name], c.category_name;

select  * from sales.vw_TopSellingProducts
order by  total_quantity desc;

-- vw_InventoryStatus

create view production.vw_InventoryStatus as 
select 
	p.product_id,
	p.product_name,
	coalesce(sum(s.quantity) , 0 ) as total_stock_quantity,
	case 
        when coalesce(sum(s.quantity), 0) = 0 then 'Out of Stock'
        when coalesce(sum(s.quantity), 0) < (
            select avg(coalesce(quantity, 0)) from stocks
        ) then 'Low products in stock'
        else 'Many products in stock'
    end as stock_status
from production.products p
left join  production.[stocks] s on p.product_id = s.product_id
group by p.product_id,p.product_name
--HAVING COALESCE(sum(s.quantity), 0) < 10

select * from production.vw_InventoryStatus
order by total_stock_quantity

-- vw_StaffPerformance

Create view sales.vw_StaffPerformance as
 select  
    s.staff_id,
    s.first_name + ' ' + s.last_name as StaffName,
	st.[store_name],
    count(o.order_id) as TotalOrders,
	sum(oi.quantity * oi.list_price) as TotalRevenue
from 
    sales.[staffs] s
join sales.orders o on s.staff_id = o.staff_id
join sales.order_items oi on o.order_id = oi.order_id
left join sales.[stores] st on s.store_id=st.store_id
group by s.staff_id, s.first_name, s.last_name,st.[store_name];

select * from sales.vw_StaffPerformance 
order by TotalRevenue desc;

-- vw_RegionalTrends 

 Create view sales.vw_RegionalTrends as 
 select 
	c.city,
	c.state,
	count(distinct o.order_id) as total_orders  ,
	sum(oi.quantity * oi.list_price)as TotalRevenue
 from sales.customers c 
 join sales.orders o on c.customer_id=o.customer_id
 join sales.order_items oi on oi.order_id=o.order_id
 group by c.city,c.state;

 select * from sales.vw_RegionalTrends
 order by total_orders desc

 -- vw_Top5RevenueByCityStore

 create view sales.vw_Top5RevenueByCityStore as
select top 5
    c.city,
    c.state,
    s.store_name,
    count(distinct o.order_id) as TotalOrders,
    sum(oi.quantity * oi.list_price) as TotalRevenue,
    format(sum(oi.quantity * oi.list_price), 'C', 'en-US') as TotalRevenueFormatted
from sales.customers c 
	join sales.orders o on c.customer_id = o.customer_id
	join sales.order_items oi on oi.order_id = o.order_id
	join sales.staffs st on o.staff_id = st.staff_id
	join sales.stores s on st.store_id = s.store_id
group by c.city, c.state, s.store_name
order by TotalRevenue desc;

 select * from sales.vw_Top5RevenueByCityStore

 -- vw_SalesByCategory

 
create view sales.vw_SalesByCategory as 
select  
    c.category_id,
    c.category_name,
    count(distinct  o.order_id) as total_orders,
    sum(oi.quantity) as total_sold_quantity,
    sum(oi.list_price * oi.quantity * (1 - oi.discount)) as total_revenue,
    sum(oi.list_price * oi.quantity * oi.discount) as total_discount_amount,
    round(avg(oi.discount) * 100, 2) as avg_discount_percent
from production.categories c  
join production.products p on c.category_id = p.category_id
join sales.order_items oi on p.product_id = oi.product_id
join sales.orders o on oi.order_id = o.order_id
group by c.category_id, c.category_name;

select * from sales.vw_SalesByCategory
order by  total_orders desc;

-- vw_CustomerLifetimeValue

Create view sales.vw_CustomerLifetimeValue as
select 
    c.customer_id,
    c.first_name + ' ' + c.last_name as customer_name,
  year(o.order_date) as sales_year,
  month(o.order_date) as sales_month,
    count(distinct o.order_id) as total_orders,
    sum(oi.quantity * oi.list_price * (1 - oi.discount)) as total_revenue,
  COUNT(DISTINCT o.order_id) * 10 as projected_10yr_orders,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) * 10 as projected_10yr_revenue

from sales.customers c
join sales.orders o on c.customer_id = o.customer_id
join sales.order_items oi on o.order_id = oi.order_id
WHERE YEAR(o.order_date) = 2018
group by c.customer_id, c.first_name, c.last_name, YEAR(o.order_date), MONTH(o.order_date);

select * from sales.vw_CustomerLifetimeValue
order by total_orders desc , total_revenue desc

-- vw_SalesTrendsMonthly 

create view sales.vw_SalesTrendsMonthly as
with MonthlySales as (
    select 
        year(o.order_date) as sales_year,
        month(o.order_date) as sales_month,
        count(distinct o.order_id) as total_orders,
        sum(oi.quantity * oi.list_price * (1 - oi.discount)) as total_revenue
    from sales.orders o
    join sales.order_items oi ON o.order_id = oi.order_id
    group by year(o.order_date), month(o.order_date)
)

select 
    ms.sales_year,
    ms.sales_month,
    datename(month, DATEADD(month, ms.sales_month - 1, '2000-01-01')) as sales_month_name,
    ms.total_orders,
    ms.total_revenue,
    ms.total_orders - isnull(prev.total_orders, 0) as order_diff_from_prev_month,
    ms.total_revenue - isnull(prev.total_revenue, 0) as revenue_diff_from_prev_month
from MonthlySales ms
left join MonthlySales prev 
    on (ms.sales_year = prev.sales_year and ms.sales_month = prev.sales_month + 1)
    or (ms.sales_year = prev.sales_year + 1 and ms.sales_month = 1 and prev.sales_month = 12)

select * from sales.vw_SalesTrendsMonthly
order by sales_year, sales_month;

-- Stored Procedures --

-- sp_CalculateStoreKPI:
/*
Select * from sales.orders
Select * from sales.order_items
Select * from sales.stores
*/

Create proc sales.sp_CalculateStoreKPI @store_id int
As
Begin
  Select
        s.store_id,
        s.store_name,
        Count(distinct o.order_id) total_orders,
        Sum(oi.quantity * oi.list_price * (1 - oi.discount)) total_revenue,
        AVG(oi.quantity * oi.list_price * (1 - oi.discount)) avg_order_value
  From sales.stores s
        Join sales.orders o on s.store_id = o.store_id
        Join sales.order_items oi on o.order_id = oi.order_id
  Where s.store_id = @store_id
  Group by s.store_id, s.store_name
End

Exec sales.sp_CalculateStoreKPI @store_id = 3

-- sp_GenerateRestockList:

/*
Select * from production.products
Select * from sales.stores
Select * from sproduction.stocks
*/

Create proc sales.sp_GenerateRestockList @store_id int, @quantity int 
As
Begin
  Select
        p.product_id,
        p.product_name,
        s.store_id,
        st.quantity current_stock
  From production.stocks st
        Join production.products p on st.product_id = p.product_id
        Join sales.stores s on st.store_id = s.store_id
  Where
        st.store_id = @store_id and st.quantity < @quantity
  Order by st.quantity asc  
End

Exec sales.sp_GenerateRestockList @store_id = 3, @quantity = 10

-- sp_CompareSalesYearOverYear
/*
Select * from orders
Select * from order_items
*/

Create proc sales.sp_CompareSalesYearOverYear @year1 int, @year2 int
As
Begin
 Select year(o.order_date) year, sum(o2.quantity * o2.list_price * (1 - o2.discount)) total_revenue
 From sales.orders o
 Join sales.order_items o2 on o.order_id = o2.order_id
 Where year(o.order_date) in (@year1, @year2)
 Group by year(o.order_date)
 Order by year(o.order_date);
End

Exec sales.sp_CompareSalesYearOverYear @year1 = 2016, @year2 = 2017

-- sp_GetCustomerProfile

/*
Select * from Customers
Select * from Orders
Select * from order_items
Select * from products
*/

Create proc sales.sp_GetCustomerProfile @customer_id int
As
Begin
 Select top 1 c.customer_id, 
    concat(c.first_name, ' ', c.last_name) full_name,
    count(distinct o.order_id) total_orders, 
    sum(o2.quantity * o2.list_price * (1 - o2.discount)) total_spent,
    fav.product_name as most_bought,
    fav.total_quantity_bought 
	From sales.customers c
 Join sales.orders o on c.customer_id = o.customer_id
 Join sales.order_items o2 on o.order_id = o2.order_id
     Left join (Select top 1 o.customer_id, p.product_name, sum(o2.quantity) total_quantity_bought
     From sales.orders o
     Join sales.order_items o2 on o.order_id = o2.order_id
     Join production.products p on o2.product_id = p.product_id
     Where o.customer_id = @customer_id
     Group by o.customer_id, p.product_name
     Order by total_quantity_bought desc) fav on fav.customer_id = c.customer_id
 Where c.customer_id = @customer_id
 Group by c.customer_id, c.first_name, c.last_name, fav.product_name, fav.total_quantity_bought;
End


Exec sales.sp_GetCustomerProfile @customer_id = 3

-- KPI --

--TOTAL REVENUE

Select sum(quantity *(list_price - discount)) as Total_Revenue
from sales.order_items

--AVERAGE REVENUE

Select sum(quantity *(list_price - discount))/sum(quantity) as Average_Revenue
from sales.order_items;

--Average Inventory Value
with AvgInv as(
select sum(s.quantity * p.list_price) as Average_Inventory_Value
from production.stocks s
join production.products p
on p.product_id = s.product_id),

TS as(
select sum(quantity *(list_price - discount)) as Total_Sales
from sales.order_items)

select Total_Sales/Average_Inventory_Value as Inventory_Turnover
from TS sales,
	AvgInv inv;

--REVENUE BY STORE
select sum(quantity *(list_price - discount)) as Total_Revenue, store_name
from sales.order_items o1
join sales.orders o2
on o2.order_id = o1.order_id
join sales.stores s
on s.store_id = o2.store_id
group by store_name
order by  sum(quantity *(list_price - discount)) asc

----COST---
--DECLARE @Gross_Margin DECIMAL(5,2) = 0.37;

--SELECT
--    (quantity *(list_price - discount)) * (1 - @Gross_Margin) AS Estimated_Cost
--FROM
--    sales.order_items


--GROSS PROFIT
Declare @Gross_Margin decimal(5, 2) = 0.37;

With sales as(
Select c.category_name,
    sum(quantity *(o.list_price - discount)) as Revenue,
	sum((quantity *(o.list_price - discount)) * (1 - @Gross_Margin)) as E_Cost
from sales.order_items o
Join production.products p on o.product_id = p.product_id
Join production.categories c on p.category_id = c.category_id
    Group by c.category_name)

Select category_name, Revenue as Total_Revenue , E_Cost as Cost
from sales


--SALES BY BRAND
Select sum(quantity *(o.list_price - discount)) as Total_Revenue, brand_name
from sales.order_items o
join production.products p
on p.product_id = o.product_id
join production.brands b
on b.brand_id = p.brand_id
Group by b.brand_name
Order by  sum(quantity *(o.list_price - discount)) desc

--STAFF REVENUE CONTRIBUTION

Select concat(sta.first_name, ' ', sta.last_name) as Staff_Name,
		sum(quantity *(list_price - discount)) as Total_Revenue
from sales.order_items oi
join sales.orders o
on o.order_id = oi.order_id
join sales.stores sto
on sto.store_id = o.store_id
join sales.staffs sta
on sta.store_id = sto.store_id
Group by first_name, last_name
Order by sum(quantity *(list_price - discount)) desc

--PRODUCT RETURN RATE--
--Return's Table
CREATE TABLE returns (
    return_id        INT IDENTITY(1,1) PRIMARY KEY,
    order_id         INT NOT NULL,
    product_id       INT NOT NULL,
    quantity_returned INT NOT NULL,
    return_date      DATE NOT NULL,
    return_reason    NVARCHAR(255) NULL,
    CONSTRAINT fk_returns_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_returns_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO returns (
    order_id,
    product_id,
    quantity_returned,     
    return_date,
    return_reason
)
VALUES
  (1,  20, 1, '2016-01-03', 'Defective part'),
  (2,  20, 1, '2016-01-03', 'Wrong size'),
    (5, 10, 2, '2016-01-04', 'Damaged on delivery'),
    (5, 17, 1, '2016-01-04', 'Wrong item'),
    (5, 26, 1, '2016-01-04', 'Not satisfied'),
    (6, 18, 1, '2016-01-05', 'Late delivery'),
    (6, 12, 2, '2016-01-05', 'Defective'),
    (6, 20, 1, '2016-01-05', 'Wrong size'),
    (4, 3, 2, '2016-01-06', 'Broken frame'),
    (3, 2, 1, '2016-01-06', 'Does not fit'),
    (7, 15, 1, '2016-01-06', 'Missing parts');
	
Select * from returns
--RETURN RATE CALCULATION--
select round(count(return_id) * 100.0 / (select count(order_id) from order_items), 6) as Return_Rate
from returns r



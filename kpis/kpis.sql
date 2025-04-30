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
	(24, 3, 2, '2016-01-07', 'Customer changed mind'),
	(24, 18, 2, '2016-01-07', 'Customer changed mind'),
	(25, 23, 2, '2016-01-07', 'Customer changed mind'),
	(25, 10, 2, '2016-01-07', 'Customer changed mind'),
	(25, 22, 1, '2016-01-07', 'Customer changed mind'),
	(25, 14, 1, '2016-01-07', 'Customer changed mind'),
	(25, 21, 1, '2016-01-07', 'Customer changed mind'),
	(26, 7, 1, '2016-01-07', 'Customer changed mind'),
	(26, 2, 1, '2016-01-07', 'Customer changed mind'),
	(26, 12, 1, '2016-01-07', 'Customer changed mind'),
	(26, 21, 2, '2016-01-07', 'Customer changed mind'),
	(27, 5, 1, '2016-01-07', 'Customer changed mind'),
	(27, 19, 1, '2016-01-07', 'Customer changed mind'),
	(27, 26, 2, '2016-01-07', 'Customer changed mind'),
	(27, 8, 1, '2016-01-07', 'Customer changed mind');

--RETURN RATE CALCULATION--
select round(count(return_id) * 100.0 / (select count(order_id) from order_items), 6) as Return_Rate
from returns r



--select * from categories
--select * from brands
--select * from Customers
--select * from staffs

--select * from returns
--select * from order_items
--select * from Orders
--select * from stores
--select * from staffs

--select * from products
--select * from stocks

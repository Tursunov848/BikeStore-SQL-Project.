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

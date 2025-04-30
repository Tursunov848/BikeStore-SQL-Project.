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

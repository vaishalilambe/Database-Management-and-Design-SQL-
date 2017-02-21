Use BicycleDemo;
--1. Display the category, subcategory and count of products in each combination.
select c.Cat_ID,s.SubCat_ID,count(p.Prod_ID) as Count
from Category c, Product p, SubCategory s
where s.SubCat_ID=c.Cat_ID
group by c.Cat_ID,s.SubCat_ID;
        
--2. Find the total sales quantity and price by store for everything in the bikes category
select c.Cat_ID,p.Prod_ID, i.Quantity as TotalSalesQuantity, (i.Quantity*o.Total_Price) as TotalSalesPrice
from Category c, Inventory i, OrderTable o, SubCategory s, Product p
where s.SubCat_ID=c.Cat_ID
and i.Prod_ID=o.Prod_ID
and p.Prod_ID=i.Prod_ID;


--3. Produce an inventory report of bikes by location
select i.Inv_ID,s.Location,p.Prod_ID,p.Prod_Name,l.Sup_ID,s.Store_ID,o.Order_ID,concat(c.Cust_fname,c.Cust_lname) as CustomerName,c.Cust_ID
from Product p, Inventory i, Stores s, Suppliers l,OrderTable o, Customer c
where p.Prod_ID=i.Prod_ID
and s.Store_ID=i.Store_ID
and l.Sup_ID=i.Sup_ID;
		

--4. Display a list of customers that have spent more than $1000 this year   
select c.Cust_ID ,concat(c.Cust_lname,c.Cust_fname) as CustName
from Customer c
inner join OrderTable as o on o.Cust_ID = c.Cust_ID
where o.Total_Price>1000;

---5. List the customers that shop at more than one store
select c.Cust_ID,c.Cust_fname,c.Cust_lname
from Customer c
inner join OrderTable as o on o.Cust_ID=c.Cust_ID
inner join Product as p on p.Prod_ID=o.Prod_ID
inner join Inventory as i on p.Prod_ID=i.Prod_ID
inner join Stores as s on s.Store_ID=i.Store_ID
group by c.Cust_ID,c.Cust_fname,c.Cust_lname
having count(s.Store_ID)>1;
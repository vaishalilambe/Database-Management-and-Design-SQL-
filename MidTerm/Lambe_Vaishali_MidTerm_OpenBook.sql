--Q.1. 
Use pubs
--select title and count for authors
select t.title,count(a.au_id) as CountOfAuthors
from authors a, titleauthor ta, titles t
where a.au_id=ta.au_id
and ta.title_id=t.title_id
--use group by
group by t.title;

--Q.2
Use pubs
--select store id and sale
select st.stor_id,st.stor_name,count(s.ord_num) as Sale
from stores st
inner join sales as s on s.stor_id=st.stor_id
group by st.stor_id,st.stor_name
--check condition where sale is > 1
having count(s.ord_num)>1;

--Q.3.
Use Northwind
--select total sales as per regionn id 
 select sum( od.Quantity * od.UnitPrice ) as TotalSales, v.rid as RegionID from  
 Orders o , [Order Details] od , 
    --subquery tp select employee id and region id
	(select et.EmployeeID eid, r.RegionID rid from  region r, territories t , EmployeeTerritories et  
 where r.RegionID = t.RegionID and et.TerritoryID = t.TerritoryID    ) v
 where od.OrderID = o.OrderID and v.eid = o.EmployeeID
 group by v.rid;


--Q.4.
Use Northwind
--select category and totals sales to generate sale s report
select c.CategoryID,sum(od.Quantity * od.UnitPrice ) as TotalSales
from [Order Details] as od
--join to get common from tables product , Categories and Order details
inner join Products as p on p.ProductID=od.ProductID
inner join Categories as c on c.CategoryID= p.CategoryID
group by c.CategoryID;


--Q.5
Use Northwind
--select territory ID having no sales
select et.TerritoryID, sum(od.UnitPrice * od.Quantity) as Sales
from EmployeeTerritories et, [Order Details] od
where et.EmployeeID not in
       --subquery to check 
      (select o.EmployeeID from Orders o
	   inner join [Order Details] as od on od.OrderID =o.OrderID)
group by et.TerritoryID

--Q.6.
We can have UnitPrice, TotalPrice, ProductID, Qunaity, Discounts in Orders table itself instead of having a separte table called Order Details
In current design we referring too many entities like ,
1. we have OrderID as common attribute in [Order Details] and Orders table
2. we have CustomerID from Customers table reffered into Orders table
3. we have EmployeeID from Employees table referred into Orders table
4. we have ProductID from Products table is referred into [Order Details] 

So lots of data dependancy of entities on each other. If we club Orders and [Order Details] table
we have only two entity dependancies like
1. we have CustomerID from Customers table reffered into Orders table
2. we have EmployeeID from Employees table referred into Orders table

gives more normalization by removing dependancies.





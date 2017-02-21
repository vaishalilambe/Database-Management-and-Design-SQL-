select * from customers
select * from region
select * from Territories


select postalcode from customers

-- does postal code align with territory
select postalcode 
from customers c
join Territories t on (t.TerritoryID = c.PostalCode)
  

-- return when there isn't a match
select postalcode 
from customers c
left join Territories t on (t.TerritoryID = c.PostalCode)
where t.TerritoryID is null

-- return when there is a match
select postalcode 
from customers c
left join Territories t on (t.TerritoryID = c.PostalCode)
where t.TerritoryID is not null


select postalcode 
from customers c
left join Territories t on (t.TerritoryID = c.PostalCode)
where t.TerritoryID is null

-- get a list of postal codes exclude the ones with a space or hyphen
select distinct postalcode 
from customers 
where postalcode not like '%-%'
and postalcode not like '% %'

-- make a table on the fly
select distinct postalcode into postref
from customers 
where postalcode not like '%-%'
and postalcode not like '% %'

select * from postref

-- return when they match
select * 
from customers c
join postref p on (p.PostalCode = c.PostalCode)

-- return regardless of match
select * 
from customers c
left join postref p on (p.PostalCode = c.PostalCode)

-- return when there is no match
select * 
from customers c
left join postref p on (p.PostalCode = c.PostalCode)
where p.PostalCode is null

-- another way to return without a match
select * 
from customers c
where PostalCode not in (select PostalCode from postref)

-- introduce an order by and review the data
select C.PostalCode 
from customers c
left join postref p on (p.PostalCode = c.PostalCode)
where p.PostalCode is null
ORDER BY 1

-- now look at the second query 
select C.PostalCode
from customers c
where PostalCode not in (select PostalCode from postref)
ORDER BY 1

-- yet another way to return the matched rows
select * 
from customers c
where exists
		(select 1 
		 from postref p 
		 where p.PostalCode = c.PostalCode)

-- or the unmatched
select * 
from customers c
where not exists
		(select 1 
		 from postref p 
		 where p.PostalCode = c.PostalCode)


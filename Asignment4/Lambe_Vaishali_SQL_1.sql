
--Vaishali Appasaheb Lambe

USE pubs

--1.authors in California
select au_id,au_fname,au_lname
from authors
where state='CA';                       -- condition to check state is 'CA'


--2.List of title and author names
select t.title,a.au_lname,a.au_fname
from dbo.titles as t 
inner join                              -- inner join to titleauthor table
dbo.titleauthor as r on r.title_id=t.title_id 
inner join                              -- inner join to authors table
dbo.authors as a on r.au_id=a.au_id;


--3.List of employees and their jobs
select e.emp_id,e.fname,e.lname,j.job_id,j.job_desc
from employee e, jobs j
where e.job_id=j.job_id;             


--4.List titles by total sales price
select t.title,
sum(s.qty*t.price) as TotalSalesPrice   -- calculates the Total sales Price and sums it 
from titles t,sales s
where t.price is not NULL
and t.title_id = s.title_id
group by t.title                        -- groups by titles
order by TotalSalesPrice desc;          -- outputs in descending order of TotalSalesPrice


--5.Sales for stores in California
select ytd_sales -- sales*qty
from titles t ,sales sa,stores s
where sa.title_id=t.title_id
and sa.stor_id=s.stor_id
and s.state='CA';                       -- checks state is CA


--8.List of the store name, title title name and quantity for all stores that have net 30 payterms
select s.stor_name, t.title, l.qty
from dbo.stores as s 
inner join                              -- inner join to table sales
dbo.sales as l on s.stor_id=l.stor_id 
inner join                              -- inner join to table titles
dbo.titles as t on l.title_id=t.title_id
where l.payterms='Net 30';


--9.The list of titles that do not have any sales show the name of the title
select t.title
from titles t
where t.title_id 
not in
	(select title_id 
	 from sales);


--10. Other way doing Q9
select t.title
from titles t 
where not exists                        
	(select s.title_id 
	 from sales s
	 where t.title_id=s.title_id);


--11.List of each title name and their authors can you do it on a single line for multiple authors
select t.title, 
   (select '; ' + a.au_fname 
    from authors a,titleauthor ta
	where ta.au_id=a.au_id
	and t.title_id=ta.title_id	
	for xml path('')) [Authors]         -- single line output for multiple authors having same title
from titles t
group by t.title,t.title_id
order by 1,2;


--12 List of the titles in order of total sale.
select t.title,sum(s.qty*t.price) as TotalSalesPrice
from titles t,sales s
where t.price is not NULL
and t.title_id = s.title_id
group by t.title
order by TotalSalesPrice asc;


--13.Add the store name to the query above
select t.title,s.qty*t.price as TotalSalesPrice,r.stor_name
from titles t,sales s,stores r
where t.price is not NULL
and s.stor_id = r.stor_id
and t.title_id = s.title_id
order by TotalSalesPrice asc;


--14. List of all the titles and list the royalty schedule
Select t.title,t.royalty
from titles t
left join roysched as r
on t.royalty=r.royalty
group by t.title,t.royalty;

--15.List of the stores that have orders with more than one title on the order
select s.stor_id,s.stor_name
from stores s
inner join
	(select sa.stor_id,sa.ord_num,count(*) as NoOfTitles
	from sales sa,titles t
	where sa.title_id=t.title_id
	group by sa.ord_num,sa.stor_id
	having count(*)>1) s1
on s.stor_id=s1.stor_id;






select * from titles;

select * from titles where type = 'business'

select * from titles where type like  'b%'

select * from titles where title_id  like 'B%'

select * from publishers;


select	title,
		pub_name
from titles 
join publishers on (titles.pub_id = publishers.pub_id)
order by pub_name, title


select	title,
		pub_name
from titles 
join publishers on (titles.pub_id = publishers.pub_id)
order by 1,2 

select	pub_name,
		title
from titles 
join publishers on (titles.pub_id = publishers.pub_id)
order by 1,2 

select	p.pub_name,
		t.title,
		p.pub_id
from titles t 
join publishers p on (p.pub_id = t.pub_id)

select	pub_name,
		title
from titles 
join publishers on (titles.pub_id = publishers.pub_id)
order by pub_name, title

-- join title and publishers
select	b.pub_name,
		a.title,
		b.pub_id
from titles a 
join publishers b on (a.pub_id = b.pub_id)

select * from employee

select * from discounts

select * from stores

--
select * 
from stores s
join discounts d on (d.stor_id = s.stor_id)

-- inner keyword is optional
select * 
from stores s
inner join discounts d on (d.stor_id = s.stor_id)

-- left join
select *
from stores s
left join discounts d on (d.stor_id = s.stor_id)

-- left join with alias
select 
	s.stor_id,
	d.stor_id 
from stores s
left join discounts d on (d.stor_id = s.stor_id)

-- left join getting null discounts only
select 
	s.stor_id,
	d.stor_id 
from stores s
left join discounts d on (d.stor_id = s.stor_id)
where d.stor_id is null

-- right join
select *
from stores s
right join discounts d on (d.stor_id = s.stor_id)

-- outer join
select *
from stores s
full outer join discounts d on (d.stor_id = s.stor_id)


select * 
from stores s, discounts d
where d.stor_id = s.stor_id

-- no where clause cartesian product
select * 
from stores s, discounts d

-- cartesion product
select *
from stores s
cross join discounts d 

-- get all the rows of stores and discounts
select *
from stores s
left join discounts d on (d.stor_id = s.stor_id)


select *
from stores s
left join discounts d on (d.stor_id = s.stor_id)
where state = 'CA' or state ='OR'

-- use the join clause to get the data and then filer the data
select *
from stores s
join discounts d on (d.stor_id = s.stor_id)
where state = 'CA' 
   or state ='OR'

-- join stores and discounts
-- this has an error with the and and or combination
select *
from stores s, discounts d 
where d.stor_id = s.stor_id
and state = 'CA' or state ='OR'

-- corrected the and and or combination with ()
select *
from stores s, discounts d 
where d.stor_id = s.stor_id
and (state = 'CA' or state ='OR')
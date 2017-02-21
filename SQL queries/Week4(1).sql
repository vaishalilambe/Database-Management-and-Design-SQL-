select * from sales

where qty between 1 and 10


select * from stores


select * from sales
where stor_id in (select stor_id from stores where state='ca')


select * from sales
where stor_id in (7066,7067)
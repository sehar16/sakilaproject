-- *********************************************************************************
-- SLIDE 1 Total revenue drive from both stores.
-- *********************************************************************************
select sum(amount) AS Total_revenue from payment;



-- SLIDE 2 revenue generated staff wise
-- *********************************************************************************
select concat(s.first_name,'   ', s.last_name) as store_staff, sum(amount) as Total_revenue ,count(*) as total_film_rented from payment as p 
inner join staff as s on s.staff_id=p.staff_id
group by 1;


-- *********************************************************************************
-- SLIDE 3 revenue actor wise
-- *********************************************************************************
select concat(a.first_name,'   ',a.last_name) as Actor_name, 
sum(amount) as revenue_earned from actor as a
inner join film_actor as fc on a.actor_id = fc.actor_id
inner join film as f on f.film_id = fc.film_id
inner join inventory as i on i.film_id= f.film_id
inner join rental as r on r.inventory_id=i.inventory_id 
inner join payment as p on p.rental_id= r.rental_id
group by 1 order by 2 desc limit 10;

-- *********************************************************************************
-- SLIDE 4 revenue of each film rented
-- *********************************************************************************
select title, sum(amount) total_amount from film as f
inner join inventory as i on f.film_id=i.film_id
inner join rental as r on i.inventory_id=r.inventory_id 
inner join payment as p on p.rental_id= r.rental_id
group by 1 order by 2 desc limit 10;


-- *********************************************************************************
-- SLIDE 5 category earned rented most
-- *********************************************************************************
select c.name as film_category,  sum(amount) as total_amount from category as c
inner join film_category as fc on c.category_id=fc.category_id 
inner join film as f on fc.film_id=f.film_id
inner join inventory as i on f.film_id=i.film_id
inner join rental as r on i.inventory_id=r.inventory_id
inner join payment as p on p.rental_id= r.rental_id
group by 1 order by 2 desc ;



-- *********************************************************************************
-- SLIDE 6  bins revenue wise
-- *********************************************************************************

select 
case
    when  sum < 25 then '1.$0 to $25'
    when  sum < 50 then '2.$25 to $50'
    when  sum < 75 then '3.$50 to $75'
    when  sum < 100 then '4.$75 to $100'
    when  sum < 125 then '5.$100 to $125'
    when  sum < 150 then '6.$125 to $150'
    else '7.$200+'
end as dollars , count(title) as number_of_films from
(select title, sum(amount) as sum from film as f
inner join inventory as i on f.film_id=i.film_id
inner join rental as r on i.inventory_id=r.inventory_id 
inner join payment as p on p.rental_id= r.rental_id
group by 1 order by 2 desc ) as temp group by 1 order by 1 asc;



-- *********************************************************************************
-- SLIDE 7 sum of rented film from every country
-- *********************************************************************************

select co.country, sum(amount) as Total_sum from customer as c 
inner join address as a on a.address_id=c.address_id
inner join city as ci on a.city_id=ci.city_id
inner join country as co on co.country_id=ci.country_id
inner join payment as p on p.customer_id=c.customer_id
group by 1  order by 2 desc limit 15 ;

-- *********************************************************************************
-- SLIDE 8 length and revenue
-- *********************************************************************************

select title, length, sum(amount) total_amount from film as f
inner join inventory as i on f.film_id=i.film_id
inner join rental as r on i.inventory_id=r.inventory_id 
inner join payment as p on p.rental_id= r.rental_id
group by 1,2 order by 2 desc;



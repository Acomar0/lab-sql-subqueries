use sakila;
-- How many copies of the film Hunchback Impossible exist in the inventory system?
select f.title, count(i.inventory_id)  from sakila.film f
join sakila.inventory i on  i.film_id=f.film_id
where title="Hunchback Impossible" ;

-- List all films whose length is longer than the average of all the films.
SELECT  avg(length) AS Average
  FROM sakila.film ;
  
SELECT title FROM (
  SELECT title, avg(length) AS Average
  FROM sakila.film
  GROUP BY title
  HAVING Average > 115.27) as sub1;
  
  -- Use subqueries to display all actors who appear in the film Alone Trip
  select actor from (select f.title as title, fa.actor_id as actor from sakila.film f join film_actor fa using (film_id)
  where title="Alone trip") as sub1;
  
  -- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
  select distinct rating from sakila.film;
   select title from (select title , rating from sakila.film 
  where rating="G") as sub1;
  
  -- Get name and email from customers from Canada using subqueries. 
  -- Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
  -- that will help you get the relevant information
    select name, email from (select c.first_name as name , c.email as email, co.country from sakila.customer c join country co using (last_update) where country="Canada") as sub1
    ;
  
  -- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
  -- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
  select fa.actor_id as actor, count(fa.film_id) as films from sakila.film f join film_actor fa using (film_id)
  group by actor
 order by films, actor desc;
 
 -- actor_id=107
 
 select film_id from film_actor where actor_id=107;
 
 -- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer 
 -- ie the customer that has made the largest sum of payments

select customer from (SELECT c.customer_id as customer, max(p.amount) as payment from sakila.payment p join customer c using(customer_id)
group by customer
order by payment desc) as sub1
where payment= 11.99
order by customer;

-- Customers who spent more than the average payments

SELECT customer_id FROM sakila.payment
WHERE amount > (SELECT avg(amount)
                FROM sakila.payment)
ORDER BY amount desc  
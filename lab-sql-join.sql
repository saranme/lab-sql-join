/*
Lab | SQL Join
In this lab, you will be using the Sakila database of movie rentals.

Instructions
1. List number of films per category.
2. Display the first and last names, as well as the address, of each staff member.
3. Display the total amount rung up by each staff member in August of 2005.
4. List each film and the number of actors who are listed for that film.
5. Using the tables payment and customer and the JOIN command, 
list the total paid by each customer. 
List the customers alphabetically by last name.
*/
Use sakila;
-- 1
SELECT COUNT(fc.film_id) n_films, c.category_id, c.name category
FROM film_category fc
JOIN category c
ON c.category_id = fc.category_id
GROUP BY 2,3;

-- 2
SELECT s.first_name staff_name, s.last_name staff_lname, a.address_id, a.address 
FROM staff s
JOIN address a
ON s.address_id = a.address_id;

-- 3
/*3. Display the total amount rung up by each staff member in August of 2005.
*/
SELECT count(l.amount) as 'total_payment', s.staff_id, s.first_name, s.last_name 
from payment as l
JOIN staff as s
on l.staff_id = s.staff_id
where DATE_FORMAT(payment_date, "%M %Y")='August 2005'
group by staff_id;

-- 4 
SELECT f.film_id, COUNT(fa.actor_id) n_actors, f.title film
FROM film_actor fa
JOIN film f
ON fa.film_id = f.film_id
GROUP BY 1,3;

-- 5
SELECT p.customer_id, c.first_name, c.last_name, SUM(p.amount) total_paid
FROM payment p
RIGHT JOIN customer c
ON c.customer_id = p.customer_id
GROUP BY 1,2,3
ORDER BY 3 ASC;

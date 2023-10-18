----- CASESTUDY---------
----- TASK 1 ----
Use sakila
SELECT CONCAT(first_name,' ', last_name) AS full_name FROM actor;

---- Task 2.1 ---
SELECT first_name, COUNT(*) AS name_count FROM actor GROUP BY first_name ORDER BY name_count DESC;
----- Task 2.2-----
SELECT DISTINCT first_name FROM actor;

----- Task 3.1----
SELECT last_name, COUNT(*) AS last_name_count FROM actor GROUP BY last_name ORDER BY last_name_count DESC;
----- Task 3.2 -----
SELECT DISTINCT last_name from actor;

----- TASK 4.1 ----
SELECT film_id, title, rating FROM film WHERE rating = 'R';
----- TASK 4.2 ----
SELECT film_id, title, rating FROM film WHERE rating != 'R';
----- TASK 4.3 ----
SELECT film_id ,title,rating from film where rating ='G';

----- TASK 5.1 ----
SELECT film_id, title, replacement_cost FROM film
 WHERE replacement_cost <= 11.00;
----- TASK 5.2---
SELECT film_id,title,replacement_cost FROM film 
WHERE replacement_cost between 11.00 AND 20.00 ;
----- TASK 5.3 ----
SELECT film_id, title, replacement_cost FROM film 
ORDER BY replacement_cost DESC;

----- TASK 6 ----
SELECT f.title, COUNT(*) AS actor_count FROM film AS f INNER JOIN film_actor AS fa ON f.film_id = fa.film_id
GROUP BY f.title ORDER BY actor_count DESC LIMIT 3;

----- TASK 7 ----
SELECT title FROM film WHERE title LIKE 'K%' OR title LIKE 'Q%';

----- TASK 8 ----
SELECT a.first_name, a.last_name FROM actor AS a JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON fa.film_id = f.film_id WHERE f.title = 'Agent Truman';

----- TASK 9 ----
SELECT film.title,category.name as category FROM film JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

----- TASK 10.1 ----
SELECT rating, MAX(rental_rate) AS max_rental_rate, MIN(rental_rate) AS min_rental_rate,
AVG(rental_rate) AS avg_rental_rate
FROM film GROUP BY rating ORDER BY avg_rental_rate DESC;
----- TASK 10.2 ----
SELECT film.title, COUNT(rental.rental_id) AS rental_frequency
FROM film LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id GROUP BY film.title
ORDER BY rental_frequency DESC;

----- TASK 11 ----
SELECT COUNT(*) AS category_count
FROM (SELECT c.name AS category FROM film AS f JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id GROUP BY c.name
HAVING AVG(f.replacement_cost - f.rental_rate) > 15) AS categories_with_difference;

SELECT c.name AS category, AVG(f.replacement_cost - f.rental_rate) 
AS cost_rental_difference FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name HAVING cost_rental_difference > 15;


----- TASK 12 ----
SELECT category.name AS category, COUNT(film.film_id) AS movie_count FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name HAVING movie_count > 70;

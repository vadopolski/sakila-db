--1.Which actors have the first name ‘Scarlett’
SELECT *
FROM actor
WHERE  first_name = 'Scarlett';

--2.Which actors have the last name ‘Johansson’
SELECT *
FROM actor
WHERE last_name = 'Johansson';

--3.How many distinct actors last names are there?
SELECT COUNT(DISTINCT(last_name))
FROM actor;

--4. Which last names are not repeated?
SELECT last_name
FROM actor
GROUP BY last_name
HAVING count(last_name) = 1
UNION
SELECT last_name
  FROM customer
GROUP BY last_name
HAVING count(last_name) = 1;

--5. Which last names appear more than once?
SELECT COUNT(*)
  FROM (SELECT last_name
        FROM actor
        GROUP BY last_name
        HAVING count(last_name) > 1
        UNION
        SELECT last_name
        FROM customer
        GROUP BY last_name
        HAVING count(last_name) > 1) AS Q;

--6.Which actor has appeared in the most films?
SELECT a.last_name, COUNT(fa.film_id) f_qnt
    FROM actor a INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
  GROUP BY a.last_name
ORDER BY f_qnt DESC;

--7. Is ‘Academy Dinosaur’ available for rent from Store 1?
SELECT i.inventory_id
FROM film f
  JOIN inventory i ON f.film_id = i.film_id
  JOIN rental r2 on i.inventory_id = r2.inventory_id
WHERE f.title = 'Academy Dinosaur'
      AND i.store_id = 1
      AND NOT EXISTS (SELECT * FROM rental r
WHERE r.inventory_id = i.inventory_id
      and r.return_date is null);

--8. Insert a record to represent Mary Smith renting ‘Academy Dinosaur’ from Mike Hillyer at Store 1 today .
SELECT customer_id FROM customer WHERE last_name = 'Smith' AND first_name = 'Mary';
-- 1
SELECT i.*
FROM film f
  JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;
-- 1 2 3 4
SELECT staff_id FROM staff WHERE first_name = 'Mike' AND last_name = 'Hillyer';
--1

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (NOW(), 1, 1, 1);

SELECT *
FROM rental r
  JOIN inventory i ON r.inventory_id = i.inventory_id
  JOIN film f ON i.film_id = f.film_id
  JOIN customer c ON r.customer_id = c.customer_id
WHERE f.title = 'Academy Dinosaur' AND c.first_name = 'Mary' AND c.last_name = 'Smith';

--9. When is ‘Academy Dinosaur’ due?

--10. What is that average running time of all the films in the sakila DB?
SELECT AVG(length) FROM film;

--11. What is the average running time of films by category?
SELECT c.name, AVG(length) avg
  FROM film f
    JOIN film_category fc on f.film_id = fc.film_id
    JOIN category c on fc.category_id = c.category_id
GROUP BY c.name;

--12. Why does this query return the empty set?
-- Because they has not common  identically named columns
SELECT * FROM film NATURAL JOIN film_actor;

--13.
SELECT name
    FROM language
    ORDER BY name ASC;

--14.
SELECT first_name, last_name
    FROM actor
    WHERE last_name LIKE '%DS%';

-- 15.
SELECT *
    FROM address
    WHERE address2 IS NOT NULL AND address2 != '';

--16.
SELECT a.first_name, a.last_name, f.release_year
    FROM actor a
      INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
      INNER JOIN film f ON f.film_id =  fa.film_id
    WHERE f.description LIKE '%Shark%' AND description LIKE '%Crocodile%'
    ORDER BY a.last_name ASC;

--17.
SELECT count(*)
    FROM film
    WHERE description LIKE '%Shark%' AND description LIKE '%Crocodile%';

-- 18.
SELECT  c.name, COUNT(fc.film_id) AS qnt
    FROM category c
        INNER JOIN film_category fc ON c.category_id = fc.category_id
    GROUP BY c.name
    HAVING qnt < 65 AND qnt
    ORDER BY qnt ASC;
--1.


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
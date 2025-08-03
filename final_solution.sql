

CREATE TABLE netflix
(
    show_id      VARCHAR(7),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

select * from netflix;

-- 15 business problem 

-- 1 .Count the number of Movies vs TV Shows
select 
type,
count(type) as count_type
from netflix
group by type;


-- 2 .Find the most common rating for movies and TV shows

select 
type,
rating
from 
(
select 
type,
rating,
count(*),
rank() over(partition by type order by count(*) desc) as ranking
from netflix
group by rating,type)
as t1
where ranking=1;


-- 3.List all movies released in a specific year (e.g., 2020)


select 
title,
type,
release_year from netflix
where type = 'Movie' and release_year = 2020;


-- 4. Find the top 5 countries with the most content on Netflix

select 
unnest(string_to_array(country , ',')) as new_country,
count(*)
from netflix
where country is not null
group by unnest(string_to_array(country , ','))
order by count(*) desc
limit 5;

-- 5. Identify the longest movie

select 
type,
title,
duration,
SPLIT_PART(duration, ' ', 1)::int AS number
from netflix
where type = 'Movie' and duration is not null
order by SPLIT_PART(duration, ' ', 1)::int desc
limit 1;


-- 6. Find content added in the last 5 years
SELECT 
  title,
  DATE_PART('year', age(current_date, TO_DATE(date_added, 'Month DD, YYYY'))) AS years_ago
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= current_date - INTERVAL '5 years';


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select
*
from (
select 
type,
title,
unnest(string_to_array(director , ',')) as director
from netflix) t
where director = 'Rajiv Chilaka';


-- 8. List all TV shows with more than 5 seasons
select 
type,
title,
duration
from netflix
where type = 'TV Show' and SPLIT_PART(duration, ' ', 1)::int > 5
order by SPLIT_PART(duration, ' ', 1)::int desc;


-- 9. Count the number of content items in each genre

select * from netflix;

select 
unnest(string_to_array(listed_in , ',')),
count(*)
from netflix
group by unnest(string_to_array(listed_in , ','))
order by count(*) desc;

-- 10.Find each year and the average numbers of content release in India on netflix.

select 
extract(year from to_date(date_added , 'month DD, YYYY')) as year,
count(*) as yearly_content,
round(
count(*)::numeric / (select count(*) from netflix where country ='India'):: numeric *100
,2) as avg_content_per_year
from netflix
where country ='India'
group by 1;


-- 11. List all movies that are documentaries
select
*
from(
select 
title,
unnest(string_to_array(listed_in , ',')) as type_movie
from netflix
group by title ,unnest(string_to_array(listed_in , ',')))t
where type_movie = 'Documentaries';


-- 12. Find all content without a director
SELECT * FROM netflix
WHERE director IS NULL

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT * FROM netflix
WHERE 
	casts LIKE '%Salman Khan%'
	AND 
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10


-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.



SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actor,
	COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

-- Question 15:
-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.



WITH ContentCategory AS (
    SELECT
        CASE
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad Content'
            ELSE 'Good Content'
        END AS category
    FROM Netflix
)
SELECT category, COUNT(*) AS count
FROM ContentCategory
GROUP BY category;












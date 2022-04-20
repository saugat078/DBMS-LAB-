USE imdb;
ALTER TABLE actors 
ADD CONSTRAINT PRIMARY KEY (id);
ALTER TABLE directors
ADD CONSTRAINT PRIMARY KEY (id);
ALTER TABLE movies
ADD CONSTRAINT PRIMARY KEY (id);


ALTER TABLE directors_genres
ADD FOREIGN KEY(director_id) REFERENCES directors(id);
ALTER TABLE movies_directors
ADD FOREIGN KEY(director_id) REFERENCES movies(id);
ALTER TABLE movies_genres
ADD FOREIGN KEY(movie_id) REFERENCES movies(id);
ALTER TABLE roles
ADD FOREIGN KEY(actor_id) REFERENCES actors(id);
ALTER TABLE roles
ADD FOREIGN KEY(movie_id) REFERENCES movies(id);

ALTER TABLE actors
DROP COLUMN film_count;

-- 1 find the number of actors,movies,genres and directors
SELECT (SELECT count(*) FROM movies) AS movie_count,
  (SELECT count(*) FROM actors) AS actor_count,
  (SELECT count(DISTINCT genre) FROM directors_genres) AS director_genre_count,
  (SELECT count(DISTINCT genre) FROM movies_genres) AS movie_genre_count,
  (SELECT count(*) FROM directors) AS director_count;
  

-- 2 list the full name and role of all actors who played in titanic

select first_name, last_name 
from actors
inner join roles on
actors.id= roles.actor_id
inner join movies on 
movies.id= roles.movie_id
where name="titanic";
-- 3 Find the number of movies in all genres. 
SELECT movies_genres.genre,
count(movies.name) AS movies_on_that_genre 
FROM movies
INNER JOIN movies_genres
ON movies_genres.movie_id=movies.id
GROUP BY movies_genres.genre;


-- 4 Find the average number of movies played by the actors
SELECT AVG(a.movies_played)
FROM (SELECT ro.actor_id,count(ro.movie_id) AS movies_played
FROM roles AS ro
GROUP BY ro.actor_id) AS a;

-- 5 Find the average number of actors in a movie. 
SELECT AVG (a.actors_numbers)
FROM (SELECT ro.movie_id,
count(ro.actor_id) AS actors_numbers 
FROM roles AS ro 
GROUP BY ro.movie_id) AS a;

-- 6 Find top 5 movies based on the rank. 
SELECT name, year, movies.rank from movies
order by movies.rank desc limit 5;

-- 7 Find 20 directors who have directed at least 2 movies

SELECT directors.id,count(movies_directors.movie_id) AS no_of_movies_directed 
FROM  movies_directors 
INNER JOIN  directors ON directors.id=movies_directors.director_id 
GROUP BY movies_directors.director_id ORDER BY no_of_movies_directed DESC LIMIT 20;

-- 8 Find all movies played by Kevin Bacon.

SELECT first_name,last_name,name
FROM roles  
INNER JOIN actors ON roles.actor_id = actors.id 
INNER JOIN movies ON movies.id=roles.movie_id 
WHERE first_name = 'Kevin' AND last_name = 'Bacon';

-- 9 Find all movies released from 1990 to 2000.

SELECT * FROM movies
WHERE movies.year >= 1990 and movies.year < 2000;



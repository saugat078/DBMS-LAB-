SELECT * FROM actors
WHERE a_gender='M' AND actorid= 580

SELECT * FROM directors
WHERE d_quality=4 AND avg_revenue=0

SELECT movieid,movies.year,country FROM movies
WHERE runningtime=2

SELECT cast_num FROM movies2actors
WHERE movieid=actorid

SELECT * FROM movies2actors

SELECT * FROM movies2directors

SELECT * FROM u2base
WHERE userid=5

SELECT * FROM users
WHERE u_gender='F'


-- 4) Create a view for the following

-- 4.1) average rating of all movies

CREATE VIEW rating_integer AS
(
		SELECT userid,movieid,
		CAST (rating AS integer) AS rating
		FROM u2base
)
SELECT AVG(rating) AS avg_rating 
FROM rating_integer

-- 4.2) numbers of actors in each movie

CREATE VIEW num_actors AS 
(
		SELECT m2a.movieid AS movie,
		COUNT (m2a.actorid) AS actor_count
		FROM movies2actors AS m2a
		GROUP BY m2a.movieid
)
SELECT * FROM num_actors

--4.3) number of ratings for each movie

CREATE VIEW num_ratings AS
(
		SELECT u.movieid AS movie,
		COUNT(u.rating) AS number_of_movie_rating
		FROM u2base AS u
		GROUP BY u.movieid
)
SELECT * FROM num_ratings

--4.4)number of ratings by each user

CREATE VIEW user_rating AS
(
		SELECT u.userid AS user_id,
		COUNT(u.rating)AS user_rating
		FROM u2base AS u
		GROUP BY u.userid
)
SELECT * FROM user_rating


--5)Find the number of users who have rated at least one movie.

CREATE VIEW user_rating_count AS
(
		SELECT r_i.userid AS u
		FROM 
		rating_integer AS r_i
		INNER JOIN 
		users
		ON r_i.userid=users.userid
		WHERE r_i.rating!=0		
)
SELECT COUNT(u) AS user_ratings
FROM user_rating_count


--6)Find the number of unrated movies.

SELECT COUNT(r_i.rating) AS unrated_movie
FROM rating_integer AS r_i
WHERE r_i.rating=0
		


--7)Find top 10 highest rated movies and the actors who played in those movies.

CREATE VIEW highest_rated_movie AS
(
	SELECT r_i.movieid,
	COUNT(r_i.rating) AS rating_count
	FROM
	rating_integer AS r_i
	GROUP BY r_i.movieid
	ORDER BY rating_count DESC LIMIT 10
)
SELECT * FROM highest_rated_movie

SELECT h_r_movies.movieid,m2a.actorid
FROM 
movies2actors AS m2a
INNER JOIN
highest_rated_movie AS h_r_movies
ON
h_r_movies.movieid=m2a.movieid



	

	
	



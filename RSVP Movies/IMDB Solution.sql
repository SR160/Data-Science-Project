USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/



-- Segment 1:




-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:

-- Count the total number of rows in the 'director_mapping' table
SELECT 
    COUNT(*) as number_of_rows
FROM
    director_mapping;
-- Total Count = 3867

-- Count the total number of rows in the 'genre' table
SELECT 
    COUNT(*) as number_of_rows
FROM
    genre;
-- Total row count = 14662

-- Count the total number of rows in the 'movie' table
SELECT 
    COUNT(*) as number_of_rows
FROM
    movie;
-- Total row count = 7997

-- Count the total number of rows in the 'names' table
SELECT 
    COUNT(*) as number_of_rows
FROM
    names;
-- Total row count = 25735

-- Count the total number of rows in the 'ratings' table
SELECT 
    COUNT(*) as number_of_rows
FROM
    ratings;
-- Total row count = 7997

-- Count the total number of rows in the 'role_mapping' table
SELECT 
    COUNT(*) as number_of_rows
FROM
    role_mapping;
-- Total row count = 15615


-- Q2. Which columns in the movie table have null values?
-- Type your code below:

-- Count of NULL values for each column in the 'movie' table
SELECT 
    SUM(CASE
        WHEN id IS NULL THEN 1
        ELSE 0
    END) AS id_null,
    SUM(CASE
        WHEN title IS NULL THEN 1
        ELSE 0
    END) AS title_null,
    SUM(CASE
        WHEN year IS NULL THEN 1
        ELSE 0
    END) AS year_null,
    SUM(CASE
        WHEN date_published IS NULL THEN 1
        ELSE 0
    END) AS date_published_null,
    SUM(CASE
        WHEN duration IS NULL THEN 1
        ELSE 0
    END) AS duration_null,
    SUM(CASE
        WHEN country IS NULL THEN 1
        ELSE 0
    END) AS country_null,
    SUM(CASE
        WHEN worlwide_gross_income IS NULL THEN 1
        ELSE 0
    END) AS worlwide_gross_income_null,
    SUM(CASE
        WHEN languages IS NULL THEN 1
        ELSE 0
    END) AS languages_null,
    SUM(CASE
        WHEN production_company IS NULL THEN 1
        ELSE 0
    END) AS production_company_null
FROM
    movie;

-- The columns in movie table which have null values are country, worlwide_gross_income, languages and production_company

-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Number of movies released each year
SELECT 
    year AS Year, 
    COUNT(title) AS number_of_movies
FROM
    movie
GROUP BY year
ORDER BY year;

-- Number of movies released each month 
SELECT 
    EXTRACT(MONTH FROM date_published) AS month_num,
    COUNT(*) AS number_of_movies
FROM   
    movie
GROUP BY 
    month_num
ORDER BY 
   month_num;
   
 -- The year with highest movies release is 2017.
 -- The month with highest number of movies produced is March.
 
/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

-- Number of movies produced in the USA or India in the year 2019
SELECT 
    COUNT(DISTINCT id) AS number_of_movies, 
    year
FROM
    movie
WHERE
    (country LIKE '%USA%'
        OR country LIKE '%INDIA%')
        AND year = 2019;
        
-- Movies produced in USA or India in 2019 are 1059


/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:

-- Unique genre list
SELECT DISTINCT
    genre
FROM
    genre;

-- The dataset has 13 different generes like Drama, Fantasy, Thriller, Comedy, Horror, Family, Romance, Adventure, Action, Sci-Fi, Crime, Mystery and Others

/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below: 

-- Ranking the genre with highest number of movies produced
WITH Genre_Rank AS (
    SELECT
        g.genre AS Genre,
        COUNT(m.id) AS Number_of_Movies,
        RANK() OVER (ORDER BY COUNT(m.id) DESC) AS genre_rank
    FROM
        movie AS m
			INNER JOIN
        genre AS g 
	ON 
		m.id = g.movie_id
    GROUP BY
        g.genre
)
SELECT
    genre,
    number_of_movies
FROM
    Genre_Rank
WHERE
    Genre_Rank = 1;

-- The genre with highest number of movies produced is Drama (4285 movies)


/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

-- Number of movies that belonging to only one genre
WITH Single_Genre_Movies
	AS (
		SELECT 
			movie_id
		FROM   
			genre
         GROUP BY 
			movie_id
         HAVING 
			Count(DISTINCT genre) = 1
		)
SELECT 
	Count(*) AS Number_Of_Single_Genre_Movies
FROM 
	Single_Genre_Movies;

-- 3289 movies have one genre

/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Average movie duration
SELECT 
    genre, 
    ROUND(AVG(m.duration), 2) AS avg_duration
FROM
    movie AS m
        INNER JOIN
    genre AS g 
ON g.movie_id = m.id
GROUP BY 
	genre
ORDER BY 
	avg_duration DESC;

-- The genre with highest avergae duration is Action (112.88 minutes)

/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

-- Rank of 'thriller' genre based on number of movies produced
WITH Gen_Ranking AS
(
SELECT 
	genre, count(movie_id) AS movie_count, 
	RANK() OVER(ORDER BY count(movie_id) DESC) AS genre_rank
FROM 
	genre
GROUP BY 
	genre
)
SELECT * 
FROM 
	Gen_Ranking
WHERE 
	genre = 'Thriller';

-- Rank of Thriller movies is 3

/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:

-- Minimum and Maximum values in each column of the ratings table
SELECT 
    MIN(avg_rating) AS min_avg_rating,
    MAX(avg_rating) AS max_avg_rating,
    MIN(total_votes) AS min_total_votes,
    MAX(total_votes) AS max_total_votes,
    MIN(median_rating) AS min_median_rating,
    MAX(median_rating) AS max_median_rating
FROM
    ratings; 


/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too

-- Top 10 movies by using RANK() function 
WITH Movie_Rank AS
(
SELECT title,
	avg_rating,
	RANK() OVER(ORDER BY avg_rating DESC) AS movie_rank
FROM 
	ratings AS r
		INNER JOIN 
	movie AS m
ON m.id = r.movie_id
)
SELECT * 
FROM 
	MOVIE_RANK
WHERE 
	movie_rank <= 10;

-- OR

-- Top 10 movies by using DENSE_RANK function
WITH Movie_Rank AS
(
SELECT title,
	avg_rating,
	DENSE_RANK() OVER(ORDER BY avg_rating DESC) AS movie_rank
FROM 
	ratings AS r
		INNER JOIN 
	movie AS m
ON m.id = r.movie_id
)
SELECT * 
FROM 
	MOVIE_RANK
WHERE 
	movie_rank <= 10;


/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

-- Summarize ratings table based on movie counts by median rating
SELECT 
    median_rating, 
    COUNT(movie_id) AS movie_count
FROM
    ratings
GROUP BY 
	median_rating
ORDER BY 
	median_rating ASC;

/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:

-- Production house with most hit movies
WITH prod_comp_hit_movie AS 
(
	SELECT production_company,
		Count(movie_id) AS movie_count,
		Rank() OVER(ORDER BY Count(movie_id) DESC ) AS prod_company_rank
	FROM 
		ratings AS r
			INNER JOIN 
		movie AS m
	ON m.id = r.movie_id
	WHERE 
		avg_rating > 8
		AND production_company IS NOT NULL
	GROUP BY 
		production_company
)
SELECT *
FROM 
	prod_comp_hit_movie
WHERE 
	prod_company_rank = 1;

-- Dream Warrior Pictures and National Theatre Live have 3 movies with highest average rating.  

-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Movies count per genre released in USA, March 2017 with more than 1000 votes
SELECT 
    genre, 
    COUNT(m.id) AS movie_count
FROM
    movie AS m
        INNER JOIN
genre AS g ON g.movie_id = m.id
        INNER JOIN
ratings AS r ON r.movie_id = m.id
WHERE
    year = 2017
	AND MONTH(date_published) = 3
	AND country LIKE '%USA%'
	AND total_votes > 1000
GROUP BY 
	genre
ORDER BY 
	movie_count DESC; 

-- Drama with 24 movies has the highest number of movies in USA with total votes above 1000 in March 2017.


-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

-- Movies starting with 'The' and average rating greater than 8
SELECT 
    title, 
    avg_rating, 
    GROUP_CONCAT(genre) as "genre"
FROM
    movie AS m
        INNER JOIN
    genre AS g ON g.movie_id = m.id
        INNER JOIN
    ratings AS r ON r.movie_id = m.id
WHERE
    title LIKE 'THE%' AND avg_rating > 8
GROUP BY 
	title, avg_rating
ORDER BY 
	avg_rating DESC;

-- There are 15 movies that start with 'The' and have average rating above 8


-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

-- Movies released between 1 April 2018 and 1 April 2019 with median rating above 8
SELECT 
    COUNT(movie_id) AS movies
FROM
    ratings AS r
        INNER JOIN
    movie AS m ON r.movie_id = m.id
WHERE
    (m.date_published BETWEEN '2018-04-01' AND '2019-04-01')
	AND (r.median_rating = 8)
GROUP BY 
	r.median_rating;

-- 361 movies released between 1 April 2018 and 1 April 2019 with median rating above 8

-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

-- BY LANGUAGE
WITH German_Language AS 
(
	SELECT 
		SUM(r.total_votes) AS german_total_votes,
		RANK() OVER(ORDER BY SUM(r.total_votes)) AS unique_id
	FROM movie AS m
	INNER JOIN 
		ratings AS r ON m.id=r.movie_id
	WHERE m.languages LIKE '%German%'
), 

Italian_Language AS 
(
	SELECT 
		SUM(r.total_votes) AS italian_total_votes,
		RANK() OVER(ORDER BY sum(r.total_votes)) AS unique_id
	FROM movie AS m
	INNER JOIN 
		ratings AS r ON m.id=r.movie_id
	WHERE m.languages LIKE '%Italian%'
)
 
SELECT *,
CASE
	WHEN german_total_votes > italian_total_votes THEN 'GERMAN' ELSE 'ITALIAN'
    END AS Country_with_more_votes
FROM German_Language
INNER JOIN
	Italian_Language USING(unique_id);
    
-- OR 

-- BY COUNTRY 
SELECT 
    country, 
    SUM(total_votes) AS total_votes
FROM
    movie AS m
        INNER JOIN
    ratings AS r ON m.id = r.movie_id
WHERE
    country = 'Germany' OR country = 'Italy'
GROUP BY country;  


-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

SELECT 
-- Count of NULL values in the 'name' column
    SUM(CASE
        WHEN name IS NULL THEN 1
        ELSE 0
    END) AS name_nulls,
-- Count of NULL values in the 'height' column
    SUM(CASE
        WHEN height IS NULL THEN 1
        ELSE 0
    END) AS height_nulls,
-- Count of NULL values in the 'date_of_birth' column
    SUM(CASE
        WHEN date_of_birth IS NULL THEN 1
        ELSE 0
    END) AS date_of_birth_nulls,    
-- Count of NULL values in the 'known_for_movies' column
    SUM(CASE
        WHEN known_for_movies IS NULL THEN 1
        ELSE 0
    END) AS known_for_movies_nulls
FROM
    names;

-- All the columns in names table have Nll values except 'name' column.


/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Top three directors by uisng LIMIT
WITH top_3_genres AS
(	
	SELECT genre,
		Count(m.id) AS movie_count ,
		Rank() OVER(ORDER BY Count(m.id) DESC) AS genre_rank
	FROM 
		movie AS m
			INNER JOIN 
    genre AS g ON g.movie_id = m.id
			INNER JOIN 
	ratings AS r ON r.movie_id = m.id
	WHERE avg_rating > 8
GROUP BY
	genre 
ORDER BY
	genre_rank LIMIT 3 
)
SELECT 
    n.name AS director_name, 
    COUNT(d.movie_id) AS movie_count
FROM
    director_mapping AS d
        INNER JOIN
    genre g USING (movie_id)
        INNER JOIN
    names AS n ON n.id = d.name_id
        INNER JOIN
    top_3_genres USING (genre)
        INNER JOIN
    ratings USING (movie_id)
WHERE
    avg_rating > 8
GROUP BY 
	name
ORDER BY 
	movie_count DESC
LIMIT 3;

-- OR

-- Top three directors by uisng RANK
WITH top_3_genres AS (
    SELECT
        genre,
        COUNT(m.id) AS movie_count,
        RANK() OVER (ORDER BY COUNT(m.id) DESC) AS genre_rank
    FROM
        movie AS m
        INNER JOIN genre AS g ON g.movie_id = m.id
        INNER JOIN ratings AS r ON r.movie_id = m.id
    WHERE
        avg_rating > 8
    GROUP BY
        genre
    ORDER BY
        genre_rank
    LIMIT 3
)
SELECT
    director_name,
    movie_count
FROM (
    SELECT
        n.name AS director_name,
        COUNT(d.movie_id) AS movie_count,
        RANK() OVER (ORDER BY COUNT(d.movie_id) DESC) AS movie_rank
    FROM
        director_mapping AS d
			INNER JOIN 
		genre g USING (movie_id)
			INNER JOIN 
        names AS n ON n.id = d.name_id
			INNER JOIN 
		top_3_genres USING (genre)
			INNER JOIN 
		ratings USING (movie_id)
    WHERE
        avg_rating > 8
    GROUP BY
        n.name
) AS ranked_directors
WHERE
    movie_rank <= 3;


/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Top 2 actors with median rating >= 8
SELECT 
    n.name AS actor_name, 
    COUNT(role.movie_id) AS movie_count
FROM
    role_mapping AS role
        INNER JOIN
    names n ON n.id = role.name_id
        INNER JOIN
    ratings r ON r.movie_id = role.movie_id
WHERE
    category = 'actor'
	AND r.median_rating >= 8
GROUP BY 
	n.name
ORDER BY 
	movie_count DESC
LIMIT 2;

-- Top 2 actors with median rating >= 8 are Mammootty and Mohanlal.

/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

-- Top three production houses
WITH ranking AS
(
	SELECT 
		production_company, 
		sum(total_votes) AS vote_count,
		RANK() OVER(ORDER BY SUM(total_votes) DESC) AS prod_comp_rank
	FROM 
		movie AS m
			INNER JOIN 
		ratings AS r ON r.movie_id=m.id
	GROUP BY production_company
)
SELECT 
    production_company, vote_count, prod_comp_rank
FROM
    ranking
WHERE
    prod_comp_rank < 4;

-- Top three production houses based on votes are Marvel Studios, Twentieth Century Fox and Warner Bros.

/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Actor ranking based on movies released in India
WITH actor_rank AS 
(
	SELECT 
    name AS actor_name,
    SUM(total_votes) AS total_votes,
    COUNT(role.movie_id) AS movie_count,
    ROUND(SUM(avg_rating * total_votes) / SUM(total_votes),
            2) AS actor_avg_rating
FROM
    role_mapping AS role
        INNER JOIN
    names AS n ON role.name_id = n.id
        INNER JOIN
    ratings AS r ON role.movie_id = r.movie_id
        INNER JOIN
    movie AS m ON role.movie_id = m.id
WHERE
    category = 'actor'
        AND country LIKE '%India%'
GROUP BY name_id , NAME
HAVING COUNT(DISTINCT role.movie_id) >= 5
)
SELECT *,
	DENSE_Rank() OVER(ORDER BY actor_avg_rating DESC, total_votes DESC) AS actor_rank 
 FROM 
	actor_rank;


-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top actress in Hindi movie released in India
WITH actress_rank AS 
(
	SELECT 
    NAME AS actress_name,
    SUM(total_votes) AS total_votes,
    COUNT(role.movie_id) AS movie_count,
    ROUND(SUM(avg_rating * total_votes) / SUM(total_votes), 2) AS actress_avg_rating
FROM
    role_mapping AS role
        INNER JOIN
    names AS n ON role.name_id = n.id
        INNER JOIN
    ratings AS r ON role.movie_id = r.movie_id
        INNER JOIN
    movie AS m ON role.movie_id = m.id
WHERE
    category = 'actress'
        AND country LIKE '%India%'
        AND languages LIKE '%HINDI%'
GROUP BY 
	name_id , NAME
HAVING COUNT(DISTINCT role.movie_id) >= 3
)

SELECT *,
 DENSE_Rank() OVER(ORDER BY actress_avg_rating DESC, total_votes DESC) AS actress_rank 
 FROM actress_rank;


/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:

-- Thriller movies categorized based on average rating
SELECT 
    title AS movie_name,
    avg_rating,
    CASE
        WHEN avg_rating > 8 THEN 'Superhit movies'
        WHEN avg_rating BETWEEN 7 AND 8 THEN 'Hit movies'
        WHEN avg_rating BETWEEN 5 AND 7 THEN 'One-time-watch movies'
        ELSE 'Flop Movies'
    END AS avg_rating_category
FROM
    movie AS m
        INNER JOIN
    genre AS g ON m.id = g.movie_id
        INNER JOIN
    ratings AS r ON r.movie_id = m.id
WHERE
    genre = 'Thriller';

-- OR 

-- Thriller movies categorized based on average rating (With CTE) 
WITH thriller_movies
     AS (SELECT title,
				avg_rating
         FROM movie AS m
                INNER JOIN 
		ratings AS r ON r.movie_id = m.id
                INNER JOIN 
		genre AS g using (movie_id)
         WHERE  
			genre ='THRILLER')
SELECT *,
       CASE
         WHEN avg_rating > 8 THEN 'Superhit movies'
         WHEN avg_rating BETWEEN 7 AND 8 THEN 'Hit movies'
         WHEN avg_rating BETWEEN 5 AND 7 THEN 'One-time-watch movies'
         ELSE 'Flop movies'
       END AS avg_rating_category
FROM thriller_movies; 

/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

-- Genre-wise running total and moving average of the average movie duration (Using Unbounded preceding)
SELECT 
	genre, 
	ROUND(AVG(duration),2) AS avg_duration, 
    SUM(ROUND(AVG(duration),2)) OVER(ORDER BY genre ROWS UNBOUNDED PRECEDING) AS running_total_duration, 
    AVG(ROUND(AVG(duration),2)) OVER(ORDER BY genre ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) moving_avg_duration 
FROM 
	movie m 
INNER JOIN 
	genre g ON m.id = g.movie_id 
GROUP BY genre
ORDER BY genre;

-- OR 

-- Genre-wise running total and moving average of the average movie duration 
WITH GenreAvgDuration AS (
    SELECT 
    g.genre, ROUND(AVG(m.duration), 2) AS avg_duration
FROM
    movie AS m
        JOIN
    genre AS g ON g.movie_id = m.id
GROUP BY g.genre
)

SELECT
    genre,
    avg_duration,
    SUM(avg_duration) OVER (ORDER BY genre) AS running_total_duration,
    ROUND(AVG(avg_duration) OVER (ORDER BY genre), 2) AS moving_avg_duration
FROM
    GenreAvgDuration
ORDER BY
    genre;

-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 5 movies from top 3 Genres by RANK function
WITH genre_top3 AS (
    SELECT 
        genre, 
        COUNT(movie_id) AS movie_count, 
        RANK() OVER (ORDER BY COUNT(movie_id) DESC) AS genre_rank 
    FROM genre 
    GROUP BY genre 
    LIMIT 3 
),
clean_gross_income AS (
    SELECT
        title,
        year,
        genre,
        worlwide_gross_income,
        CASE
            WHEN POSITION('INR' IN worlwide_gross_income) > 0 THEN CAST(SUBSTRING(worlwide_gross_income FROM POSITION('INR' IN worlwide_gross_income) + 4) AS DECIMAL(18,2))
            WHEN POSITION('$' IN worlwide_gross_income) > 0 THEN CAST(SUBSTRING(worlwide_gross_income FROM POSITION('$' IN worlwide_gross_income) + 2) AS DECIMAL(18,2))
            ELSE CAST(worlwide_gross_income AS DECIMAL(18,2))
        END AS cleaned_gross_income
    FROM movie AS m
		INNER JOIN 
	genre AS g ON m.id = g.movie_id
),
ranked_movies AS (
    SELECT
        genre,
        year,
        title AS movie_name,
        worlwide_gross_income,
        DENSE_RANK() OVER (PARTITION BY year ORDER BY cleaned_gross_income DESC) AS movie_rank
    FROM 
		clean_gross_income
    WHERE 
		genre IN (SELECT genre FROM genre_top3)
)

SELECT
    genre,
    year,
    movie_name,
    worlwide_gross_income,
    movie_rank
FROM 
	ranked_movies
WHERE 
	movie_rank <= 5
ORDER BY 
	year, movie_rank;

-- The movies with worldwide_gross_income in INR cannot be changes to $ as conversion rate of that time is not provided.

-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.

-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

-- Top 2 production houses with mutlilingual movies and highest number hits
WITH prod_comp AS 
(
	SELECT 
		production_company,
		Count(*) AS movie_count,
        Rank() OVER(ORDER BY Count(*) DESC) AS prod_comp_rank
	FROM 
		movie AS m
			INNER JOIN 
	ratings AS r ON r.movie_id = m.id
	WHERE 
		median_rating >= 8
		AND production_company IS NOT NULL
		AND Position(',' IN languages) > 0
	GROUP BY 
		production_company
	ORDER BY 
		movie_count DESC
)
SELECT *
FROM 
	prod_comp
WHERE 
	prod_comp_rank <= 2;

-- Star Cinema and Twentieth Century Fox are top two production houses with highest number of multilingual hit movies.

-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top actress based on number of Super Hit movies in drama using Rank
WITH top_actress AS
(
	SELECT 
		name as actress_name, 
		SUM(total_votes) AS total_votes, 
		COUNT(role.movie_id) as movie_count, 
		ROUND(SUM(avg_rating * total_votes)/Sum(total_votes),2) AS actress_avg_rating,
        Rank() OVER(ORDER BY COUNT(role.movie_id) DESC) AS actress_rank
	FROM 
		names AS n 
			INNER JOIN 
    role_mapping as role ON n.id = role.name_id 
			INNER JOIN 
	ratings AS r ON r.movie_id = role.movie_id 
			INNER JOIN 
    genre AS g ON g.movie_id = r.movie_id 
	WHERE 
		category ="actress" 
		AND avg_rating > 8 
		AND g.genre="Drama" 
	GROUP BY 
		name 
    )
SELECT *
FROM top_actress 
HAVING actress_rank <4;

-- Parvathy Thiruvothu is the top actress with highest number of hit movies


/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:

-- Top 9 directors
WITH publish_date AS 
(
	SELECT 
		d.name_id, 
        name, 
        d.movie_id, 
        duration, 
        r.avg_rating, 
        total_votes, 
        m.date_published, 
		Lead(date_published, 1) OVER(PARTITION BY d.name_id ORDER BY date_published,movie_id ) AS next_publish_date 
    FROM 
		director_mapping AS d 
			INNER JOIN 
    names AS n ON n.id = d.name_id 
			INNER JOIN 
    movie AS m ON m.id = d.movie_id
			INNER JOIN 
    ratings AS r ON r.movie_id = m.id 
), 
top_director AS 
(
	SELECT *, 
	Datediff(next_publish_date, date_published) AS date_diff 
    FROM 
		publish_date
) 
SELECT 
	name_id AS director_id, 
    name AS director_name, 
    COUNT(movie_id) AS number_of_movies, 
    ROUND(AVG(date_diff),2) AS avg_inter_movie_days, 
    ROUND(AVG(avg_rating),2) AS avg_rating, 
    SUM(total_votes) AS total_votes, 
    MIN(avg_rating) AS min_rating, 
    MAX(avg_rating) AS max_rating, 
    SUM(duration) AS total_duration 
FROM 
	top_director 
GROUP BY 
	director_id
ORDER BY 
	COUNT(movie_id) DESC
LIMIT 9;

-- Andrew Jones and A.L. Vijay directed most number of movies



-- Assignment done by Aniket Shah, Darshith P K and Shivani Raut
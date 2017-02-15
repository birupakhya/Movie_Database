-- Insert into city_master values using relmdb.cities

SET SERVEROUTPUT ON;

DECLARE

CURSOR 	C_CITIES IS
SELECT 	city_name,
		state_code,
		population
FROM	RELMDB.CITIES;

BEGIN
	FOR city in C_CITIES 
	LOOP
		INSERT INTO city_master (city_id, city_name, state_iso, population)
		VALUES (s_cities.NEXTVAL,
				city.city_name,
				city.state_code,
				city.population);
	END LOOP;
END;

-- INSERT MOVIE TITLE, RELEASE YEAR INFORMATION FROM MOVIE LENS STAGING TABLE

SET SERVEROUTPUT ON;
DECLARE

CURSOR 	c_mlmovie IS
SELECT 	movie_id,
		REGEXP_SUBSTR(SUBSTR(TRIM(title),-6),'?[0-9]+',1,1) movie_year, 
        substr(TRIM(title),1,length(TRIM(title))-6) title,
        TRIM(genre)
FROM	STAG_MOVIELENS
WHERE REGEXP_LIKE(TRIM(title),'*([0-9])+');

TYPE mov_array IS TABLE OF c_mlmovie%ROWTYPE;
cur_array mov_array;


BEGIN
	OPEN 	c_mlmovie;
	LOOP
			FETCH c_mlmovie
			BULK COLLECT INTO cur_array LIMIT 1000;

	FORALL i IN 1 .. cur_array.count
    INSERT INTO movies(movie_id,release_year,title,src_ref)
    VALUES		(s_movies.NEXTVAL,
    			cur_array(i).movie_year,
    			cur_array(i).title,
    			cur_array(i).movie_id);
      
      EXIT WHEN cur_array.COUNT = 0;
	END LOOP;
	CLOSE c_mlmovie;
END;
/

-- update movies using values loaded from OMDb database

SET SERVEROUTPUT ON;
DECLARE

CURSOR 	c_omdb IS
SELECT  DISTINCT
        TRIM(MPAA) MPAA, 
        TRIM(TITLE) TITLE,
        TO_CHAR(LANGUAGE) LANG,
        TO_DATE(RELEASE_DATE,'DD-MM-YY') RELEASE_DATE,
        REGEXP_SUBSTR(SUBSTR(TRIM(RUNTIME),1),'*[0-9]+',1,1) RUNTIME, 
        REPLACE((TRIM(IMDB_VOTES)),',','') IMDB_VOTES,
        TRIM(IMDBRATING) IMDB_RATING,
        TRIM(IMDBID) IMDBID,
        TRIM(PLOT) PLOT
FROM 	STG_OMDB
WHERE	MPAA IN ('G','PG','PG-13','R','NC-17','TV-14','NOT RATED','N/A','UNRATED','TV-MA','OPEN','K-3','PASSED','GP','M','TV-Y7','X','TV-PG','TV-G','APPROVED','S','M/PG')
AND   REGEXP_LIKE(RUNTIME,'*[0-9]')
AND   REGEXP_LIKE(IMDB_VOTES,'*[0-9]')
AND   REGEXP_LIKE(IMDBRATING,'*[0-9]')
AND   REGEXP_LIKE(RELEASE_DATE,'*[0-9]');

BEGIN
	FOR rec IN c_omdb LOOP
		BEGIN
			UPDATE MOVIES M
			SET M.MPAA_RATING 		= rec.MPAA,
				M.LANGUAGE		    = rec.LANG,
				M.RELEASE_DATE 		= rec.RELEASE_DATE,
				M.RUNTIME		    = rec.RUNTIME,
        M.IMDB_RATING_FINAL = rec.IMDB_RATING,
        M.IMDB_VOTES      = rec.IMDB_VOTES,
        M.IMDB_ID      = rec.IMDBID,
        M.PLOT      = rec.PLOT
			WHERE 	UPPER(TRIM(M.TITLE)) = UPPER(TRIM(rec.TITLE));
			DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' Rows affected');
      EXCEPTION
			WHEN OTHERS THEN
				DBMS_OUTPUT.PUT_LINE('ERROR:'|| 'FOR TITLE:' || rec.TITLE || SQLERRM);
		END;
	END LOOP;
END;


INSERT INTO MOVIE_RATINGS(USER_ID,MOVIE_ID,RATING_DATE,RATING,SRC_REF_ID)
select ROUND(DBMS_RANDOM.VALUE(100106,111813)),
            sm.movie_id,
            to_number(to_char(to_date('1970-01-01','YYYY-MM-DD') + numtodsinterval(s.TIMESTAMP,'SECOND'),'YYYYMMDDHH24MISS')),
            s.rating,
            so.source_id
from stag_movielens sm
inner join stg_ml_ratings s on sm.movie_id = s.movie_id
inner join movies m on m.movie_id = s.movie_id
left outer join source_master so on so.name = 'Movie Lens'





CREATE TABLE All_Individuals
  (
    individual_id      INTEGER NOT NULL ,
    individual_type    VARCHAR2 (100) ,
    individual_name    VARCHAR2 (200) ,
    individual_address VARCHAR2 (1000) ,
    state_id           INTEGER NOT NULL ,
    city_id            INTEGER NOT NULL ,
    pin_code           INTEGER ,
    gender             CHAR (1) ,
    profession         VARCHAR2 (500) ,
    age                INTEGER ,
    yearly_income      INTEGER ,
    education          VARCHAR2 (100)
  ) ;
ALTER TABLE All_Individuals ADD CONSTRAINT All_Individuals_PK PRIMARY KEY ( individual_id ) ;


CREATE TABLE Award_Master
  (
    award_id       INTEGER NOT NULL ,
    award_name     VARCHAR2 (500) NOT NULL ,
    event_location VARCHAR2 (500) ,
    event_date     DATE
  ) ;
ALTER TABLE Award_Master ADD CONSTRAINT Award_Master_PK PRIMARY KEY ( award_id ) ;


CREATE TABLE Box_Office_Sales
  (
    movie_id        INTEGER NOT NULL ,
    country_id      INTEGER NOT NULL ,
    budget          INTEGER ,
    opening_weekend INTEGER ,
    total_revenue   INTEGER
  ) ;
ALTER TABLE Box_Office_Sales ADD CONSTRAINT Box_Office_Sales_PK PRIMARY KEY ( movie_id ) ;


CREATE TABLE Cast_Master
  (
    cast_id   INTEGER NOT NULL ,
    cast_type VARCHAR2 (500)
  ) ;
ALTER TABLE Cast_Master ADD CONSTRAINT Cast_Master_PK PRIMARY KEY ( cast_id ) ;


CREATE TABLE City_Master
  (
    city_id    INTEGER NOT NULL ,
    city_name  VARCHAR2 (100) ,
    state_iso  VARCHAR2 (2) ,
    Population INTEGER
  ) ;
ALTER TABLE City_Master ADD CONSTRAINT City_Master_PK PRIMARY KEY ( city_id ) ;


CREATE TABLE Country_Master
  (
    country_id   INTEGER NOT NULL ,
    country_name VARCHAR2 (200) NOT NULL ,
    country_iso  VARCHAR2 (2)
  ) ;
ALTER TABLE Country_Master ADD CONSTRAINT Country_Master_PK PRIMARY KEY ( country_id ) ;



CREATE TABLE Movie_Awards
  (
    movie_id       INTEGER NOT NULL ,
    event_id       INTEGER NOT NULL ,
    cast_id        INTEGER NOT NULL ,
    award_category VARCHAR2 (200)
  ) ;
ALTER TABLE Movie_Awards ADD CONSTRAINT Movie_Awards_PK PRIMARY KEY ( movie_id ) ;


CREATE TABLE Movie_Cast
  (
    movie_id         INTEGER NOT NULL ,
    cast_category_id INTEGER NOT NULL ,
    cast_name        VARCHAR2 (500) ,
    characer_name    VARCHAR2 (500)
  ) ;
ALTER TABLE Movie_Cast ADD CONSTRAINT Movie_Cast_PK PRIMARY KEY ( movie_id ) ;


CREATE TABLE Movie_Ratings
  (
    user_id  INTEGER NOT NULL ,
    movie_id INTEGER NOT NULL ,
    rating FLOAT ,
                  TIMESTAMP TIMESTAMP WITH LOCAL TIME ZONE ,
    rating_source VARCHAR2 (50) ,
    movie_rank    INTEGER ,
    movie_votes   INTEGER
  ) ;
ALTER TABLE Movie_Ratings ADD CONSTRAINT Movie_Ratings_PK PRIMARY KEY ( user_id ) ;


CREATE TABLE Movie_Reviews
  (
    user_id  INTEGER NOT NULL ,
    movie_id INTEGER NOT NULL ,
    review   VARCHAR2 (4000) ,
             TIMESTAMP TIMESTAMP WITH LOCAL TIME ZONE
  ) ;
ALTER TABLE Movie_Reviews ADD CONSTRAINT Movie_Reviews_PK PRIMARY KEY ( user_id ) ;


CREATE TABLE Movie_Showtimes
  (
    theatre_id           INTEGER NOT NULL ,
    movie_id             INTEGER NOT NULL ,
    show_time            DATE ,
    is_premium_screening CHAR (1)
  ) ;
ALTER TABLE Movie_Showtimes ADD CONSTRAINT Movie_Showtimes_PK PRIMARY KEY ( theatre_id ) ;


CREATE TABLE Movie_Tag_Relevance
  (
    movie_id INTEGER NOT NULL ,
    tag_id   INTEGER NOT NULL ,
    relevance FLOAT
  ) ;
ALTER TABLE Movie_Tag_Relevance ADD CONSTRAINT Movie_Tag_Relevance_PK PRIMARY KEY ( movie_id ) ;


CREATE TABLE Movies
  (
    movie_id INTEGER NOT NULL ,
    title    VARCHAR2 (200) ,
    genre    VARCHAR2 (50) ,
    mpaa_rating FLOAT ,
    movie_popularity INTEGER ,
    is_sequel        INTEGER ,
    is_adaptation    INTEGER ,
    release_date     DATE ,
    runtime          INTEGER ,
    language         VARCHAR2 (50) ,
    tagline          VARCHAR2 (1000)
  ) ;
ALTER TABLE Movies ADD CONSTRAINT Movies_PK PRIMARY KEY ( movie_id ) ;


CREATE TABLE State_Master
  (
    state_id    INTEGER NOT NULL ,
    iso         VARCHAR2 (2) ,
    state_name  VARCHAR2 (400) NOT NULL ,
    description INTEGER
  ) ;
ALTER TABLE State_Master ADD CONSTRAINT State_Master_PK PRIMARY KEY ( state_id ) ;



CREATE TABLE TVSeries_Cast
  (
    tvseries_id      INTEGER NOT NULL ,
    cast_category_id INTEGER NOT NULL ,
    cast_name        VARCHAR2 (500) ,
    character_name   VARCHAR2 (500)
  ) ;
ALTER TABLE TVSeries_Cast ADD CONSTRAINT TVSeries_Cast_PK PRIMARY KEY ( tvseries_id ) ;


CREATE TABLE TVSeries_Ratings
  (
    user_id     INTEGER NOT NULL ,
    tvseries_id INTEGER NOT NULL ,
    rating FLOAT ,
    TIMESTAMP TIMESTAMP WITH LOCAL TIME ZONE
  ) ;
ALTER TABLE TVSeries_Ratings ADD CONSTRAINT TVSeries_Ratings_PK PRIMARY KEY ( user_id ) ;


CREATE TABLE TVSeries_Review
  (
    user_id     INTEGER NOT NULL ,
    tvseries_id INTEGER NOT NULL ,
    review      VARCHAR2 (4000) ,
                TIMESTAMP TIMESTAMP WITH LOCAL TIME ZONE
  ) ;
ALTER TABLE TVSeries_Review ADD CONSTRAINT TVSeries_Review_PK PRIMARY KEY ( user_id ) ;


CREATE TABLE TV_Series
  (
    tvseries_id  INTEGER NOT NULL ,
    name         VARCHAR2 (50) ,
    genre        VARCHAR2 (50) ,
    release_date DATE ,
    runtime      INTEGER ,
    language     VARCHAR2 (50)
  ) ;
ALTER TABLE TV_Series ADD CONSTRAINT TV_Series_PK PRIMARY KEY ( tvseries_id ) ;


CREATE TABLE Tags
  (
    tag_id         INTEGER NOT NULL ,
    user_id        INTEGER NOT NULL ,
    movie_id       INTEGER NOT NULL ,
    tag_name       VARCHAR2 (500) ,
    last_updated   TIMESTAMP WITH TIME ZONE ,
    tag_popularity INTEGER
  ) ;
ALTER TABLE Tags ADD CONSTRAINT Tags_PK PRIMARY KEY ( tag_id ) ;
ALTER TABLE Tags ADD CONSTRAINT Tags_All_Individuals_FK FOREIGN KEY ( user_id ) REFERENCES All_Individuals ( individual_id ) ;
ALTER TABLE Tags ADD CONSTRAINT Tags_Movies_FK FOREIGN KEY ( movie_id ) REFERENCES Movies ( movie_id ) ;



CREATE TABLE Theatre
  (
    theatre_id    INTEGER NOT NULL ,
    movie_id      INTEGER NOT NULL ,
    theatre_name  VARCHAR2 (500) ,
    count_no      INTEGER ,
    city_id       INTEGER NOT NULL ,
    state_id      INTEGER NOT NULL ,
    address       VARCHAR2 (1000) ,
    pin_code      INTEGER ,
    geom_location VARCHAR2 (100) ,
    url           VARCHAR2 (100)
  ) ;
ALTER TABLE Theatre ADD CONSTRAINT Theatre_PK PRIMARY KEY ( theatre_id ) ;


CREATE TABLE Theatre_Ratings
  (
    user_id    INTEGER NOT NULL ,
    theatre_id INTEGER NOT NULL ,
    rating FLOAT ,
    TIMESTAMP TIMESTAMP WITH LOCAL TIME ZONE
  ) ;
ALTER TABLE Theatre_Ratings ADD CONSTRAINT Theatre_Ratings_PK PRIMARY KEY ( user_id ) ;


CREATE TABLE Theatre_Reviews
  (
    user_id    INTEGER NOT NULL ,
    theatre_id INTEGER NOT NULL ,
    review     VARCHAR2 (4000) ,
               TIMESTAMP TIMESTAMP WITH LOCAL TIME ZONE
  ) ;
ALTER TABLE Theatre_Reviews ADD CONSTRAINT Theatre_Reviews_PK PRIMARY KEY ( user_id ) ;


CREATE TABLE Ticket
  (
    theatre_id      INTEGER NOT NULL ,
    movie_id        INTEGER NOT NULL ,
    screen_category VARCHAR2 (50) ,
    ticket_category VARCHAR2 (50) ,
    ticket_price    INTEGER
  ) ;
ALTER TABLE Ticket ADD CONSTRAINT Ticket_PK PRIMARY KEY ( theatre_id ) ;


ALTER TABLE All_Individuals ADD CONSTRAINT All_Individuals_City_Master_FK FOREIGN KEY ( city_id ) REFERENCES City_Master ( city_id ) ;

ALTER TABLE All_Individuals ADD CONSTRAINT Individuals_State_Master_FK FOREIGN KEY ( state_id ) REFERENCES State_Master ( state_id ) ;

ALTER TABLE Box_Office_Sales ADD CONSTRAINT BO_Sales_Country_Master_FK FOREIGN KEY ( country_id ) REFERENCES Country_Master ( country_id ) ;

ALTER TABLE Box_Office_Sales ADD CONSTRAINT Box_Office_Sales_Movies_FK FOREIGN KEY ( movie_id ) REFERENCES Movies ( movie_id ) ;

ALTER TABLE Movie_Awards ADD CONSTRAINT Movie_Awards_Award_Master_FK FOREIGN KEY ( event_id ) REFERENCES Award_Master ( award_id ) ;

ALTER TABLE Movie_Awards ADD CONSTRAINT Movie_Awards_Cast_Master_FK FOREIGN KEY ( cast_id ) REFERENCES Cast_Master ( cast_id ) ;

ALTER TABLE Movie_Awards ADD CONSTRAINT Movie_Awards_Movies_FK FOREIGN KEY ( movie_id ) REFERENCES Movies ( movie_id ) ;

ALTER TABLE Movie_Cast ADD CONSTRAINT Movie_Cast_Cast_Master_FK FOREIGN KEY ( cast_category_id ) REFERENCES Cast_Master ( cast_id ) ;

ALTER TABLE Movie_Ratings ADD CONSTRAINT Movie_Ratings_Movies_FK FOREIGN KEY ( movie_id ) REFERENCES Movies ( movie_id ) ;

ALTER TABLE Movie_Reviews ADD CONSTRAINT Movie_Rev_Individuals_FK FOREIGN KEY ( user_id ) REFERENCES All_Individuals ( individual_id ) ;

ALTER TABLE Movie_Reviews ADD CONSTRAINT Movie_Reviews_Movies_FK FOREIGN KEY ( movie_id ) REFERENCES Movies ( movie_id ) ;

ALTER TABLE Movie_Showtimes ADD CONSTRAINT Movie_Showtimes_Movies_FK FOREIGN KEY ( movie_id ) REFERENCES Movies ( movie_id ) ;

ALTER TABLE Movie_Showtimes ADD CONSTRAINT Movie_Showtimes_Theatre_FK FOREIGN KEY ( theatre_id ) REFERENCES Theatre ( theatre_id ) ;

ALTER TABLE Movie_Tag_Relevance ADD CONSTRAINT Movie_Tag_Relevance_Movies_FK FOREIGN KEY ( movie_id ) REFERENCES Movies ( movie_id ) ;

ALTER TABLE Movie_Tag_Relevance ADD CONSTRAINT Movie_Tag_Relevance_Tags_FK FOREIGN KEY ( tag_id ) REFERENCES Tags ( tag_id ) ;

ALTER TABLE TVSeries_Cast ADD CONSTRAINT TVSeries_Cast_Cast_Master_FK FOREIGN KEY ( cast_category_id ) REFERENCES Cast_Master ( cast_id ) ;

ALTER TABLE TVSeries_Cast ADD CONSTRAINT TVSeries_Cast_TV_Series_FK FOREIGN KEY ( tvseries_id ) REFERENCES TV_Series ( tvseries_id ) ;

ALTER TABLE TVSeries_Ratings ADD CONSTRAINT TVSeries_Rat_Individuals_FK FOREIGN KEY ( user_id ) REFERENCES All_Individuals ( individual_id ) ;

ALTER TABLE TVSeries_Ratings ADD CONSTRAINT TVSeries_Ratings_TV_Series_FK FOREIGN KEY ( tvseries_id ) REFERENCES TV_Series ( tvseries_id ) ;

ALTER TABLE TVSeries_Review ADD CONSTRAINT TVSeries_Rev_Individuals_FK FOREIGN KEY ( user_id ) REFERENCES All_Individuals ( individual_id ) ;

ALTER TABLE TVSeries_Review ADD CONSTRAINT TVSeries_Review_TV_Series_FK FOREIGN KEY ( tvseries_id ) REFERENCES TV_Series ( tvseries_id ) ;

ALTER TABLE Tags ADD CONSTRAINT Tags_All_Individuals_FK FOREIGN KEY ( user_id ) REFERENCES All_Individuals ( individual_id ) ;

ALTER TABLE Tags ADD CONSTRAINT Tags_Movies_FK FOREIGN KEY ( movie_id ) REFERENCES Movies ( movie_id ) ;

ALTER TABLE Theatre ADD CONSTRAINT Theatre_City_Master_FK FOREIGN KEY ( city_id ) REFERENCES City_Master ( city_id ) ;

ALTER TABLE Theatre ADD CONSTRAINT Theatre_City_Master_FKv2 FOREIGN KEY ( city_id ) REFERENCES City_Master ( city_id ) ;

ALTER TABLE Theatre ADD CONSTRAINT Theatre_Movies_FK FOREIGN KEY ( movie_id ) REFERENCES Movies ( movie_id ) ;

ALTER TABLE Theatre_Ratings ADD CONSTRAINT Theatre_Ratings_Theatre_FK FOREIGN KEY ( theatre_id ) REFERENCES Theatre ( theatre_id ) ;

ALTER TABLE Theatre_Reviews ADD CONSTRAINT Theatre_Rev_Individuals_FK FOREIGN KEY ( user_id ) REFERENCES All_Individuals ( individual_id ) ;

ALTER TABLE Theatre_Reviews ADD CONSTRAINT Theatre_Reviews_Theatre_FK FOREIGN KEY ( theatre_id ) REFERENCES Theatre ( theatre_id ) ;

ALTER TABLE Theatre ADD CONSTRAINT Theatre_State_Master_FK FOREIGN KEY ( state_id ) REFERENCES State_Master ( state_id ) ;

ALTER TABLE Ticket ADD CONSTRAINT Ticket_Movies_FK FOREIGN KEY ( movie_id ) REFERENCES Movies ( movie_id ) ;

ALTER TABLE Ticket ADD CONSTRAINT Ticket_Theatre_FK FOREIGN KEY ( theatre_id ) REFERENCES Theatre ( theatre_id ) ;


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            23
-- CREATE INDEX                             0
-- ALTER TABLE                             55
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   6
-- WARNINGS                                 0
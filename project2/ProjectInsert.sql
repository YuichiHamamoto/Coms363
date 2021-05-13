use project2;

SET GLOBAL local_infile = 'ON';
LOAD DATA LOCAL INFILE '/Users/hamamotoyuuichi/Desktop/project2/LoadData/user.txt'
INTO TABLE User
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(screen_name,name,sub_category,category,ofstate,followers,following);

LOAD DATA LOCAL INFILE '/Users/hamamotoyuuichi/Desktop/project2/LoadData/tweets.txt'
INTO TABLE Tweet
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tid,text,retweet_count,retweeted,@col5,posting_user)
set day_posted= day(str_to_date(@col5, '%Y-%m-%d %H:%i:%s')),
month_posted= month(str_to_date(@col5, '%Y-%m-%d %H:%i:%s')),
year_posted= year(str_to_date(@col5, '%Y-%m-%d %H:%i:%s'));

LOAD DATA LOCAL INFILE '/Users/hamamotoyuuichi/Desktop/project2/LoadData/mentioned.txt'
INTO TABLE Mentioned
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tid,screen_name);


LOAD DATA LOCAL INFILE '/Users/hamamotoyuuichi/Desktop/project2/LoadData/urlused.txt'
INTO TABLE Url
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tid,url);

LOAD DATA LOCAL INFILE '/Users/hamamotoyuuichi/Desktop/project2/LoadData/tagged.text'
INTO TABLE Hashtag
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tid,hastagname);






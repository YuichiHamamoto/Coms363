CREATE DATABASE IF NOT EXISTS project2;
use project2;

Drop Table if exists user;
create table user (
  following int default null,
  followers int default null,
  name varchar(500) default null,
  category varchar(500) default null,
  screen_name varchar(500) not null,
  sub_category varchar(500) default null,
  ofstate varchar(500) default null,
  primary key(screen_name)
  );

Drop Table if exists tweet;
create table tweet (
  tid bigint not null,
  text text,
  retweet_count int default null,
  retweeted int default null,
  day_posted int default NULL,
  month_posted int default NULL,
  year_posted int default NULL,
  posting_user varchar(500),
  foreign key(posting_user) references user(screen_name),
  primary key(tid)
  );
  
Drop Table if exists url;
create table url (
  tid bigint,
  url text,
  foreign key(tid) references tweet(tid)
);
 
Drop Table if exists hashtag;
create table hashtag (
  tid bigint,
  hastagname varchar(500),
  foreign key(tid) references tweet(tid)
  );

Drop Table if exists mentioned;
create table mentioned (
  tid bigint,
  screen_name varchar(500),
  foreign key(tid) references tweet(tid),
  foreign key(screen_name) references user(screen_name)
);
 
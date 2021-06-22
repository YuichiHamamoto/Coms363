create database sail;
use sail;

create table Sailors(
	sid integer,
    primary key (sid),
	sname varchar(30),
	rating integer,
	age real
	);
    
create table Boats(
	bid integer,
    primary key (bid),
	bname varchar(30),
	color varchar(80)
	);    
create table Reserves(
	sid integer,
    bid integer,
    rday date,
    primary key (sid, bid, rday),
    foreign key (sid) references sailors(sid),
    foreign key (bid) references boats(bid)
);

INSERT INTO Sailors VALUES (22,'Dustin',7,45.0);
INSERT INTO Sailors VALUES (31,'Lubber',8,55.5);
INSERT INTO Sailors VALUES (58,'Rusty',10,35.5);
INSERT INTO Sailors VALUES (28,'yuppy',9,35.0);
INSERT INTO Sailors VALUES (44,'guppy',5,35.5);
INSERT INTO Sailors VALUES (29,'Brutus',1,33.0);
INSERT INTO Sailors VALUES (32,'Andy',8,25.5);
INSERT INTO Sailors VALUES (64,'Horatio',7,35.0);
INSERT INTO Sailors VALUES (71,'Zorba',10,16.0);
INSERT INTO Sailors VALUES (74,'Horatio',9,35.5);
INSERT INTO Sailors VALUES (85,'Art',3,25.5);
INSERT INTO Sailors VALUES (95,'Bob',3,63.5);

INSERT INTO Boats VALUES (101,'Interlake','blue');
INSERT INTO Boats VALUES (102,'Interlake','red');
INSERT INTO Boats VALUES (103,'Clipper','green');
INSERT INTO Boats VALUES (104,'Marine','red');


INSERT INTO Reserves VALUES (22,101,'2016-10-10');
INSERT INTO Reserves VALUES (22,102,'2018-10-10');
INSERT INTO Reserves VALUES (22,103,'2018-10-8');
INSERT INTO Reserves VALUES (22,104,'2018-10-7');
INSERT INTO Reserves VALUES (31,102,'2018-11-10');
INSERT INTO Reserves VALUES (31,103,'2018-11-6');
INSERT INTO Reserves VALUES (31,104,'2018-11-12');
INSERT INTO Reserves VALUES (64,101,'2018-9-5');
INSERT INTO Reserves VALUES (64,102,'2018-9-8');
INSERT INTO Reserves VALUES (74,103,'2018-9-8');
INSERT INTO Reserves VALUES (58,103,'2016-11-12');


-- find name and age of all sailors
-- project
select distinct s.age
from Sailors S;
select Sailors.age
from Sailors;


-- find all sailors with a rating above 8
-- select
select *
from sailors
where sailors.rating>8;

-- let's try join
SELECT * FROM reserves natural JOIN sailors;
SELECT * FROM reserves cross JOIN sailors;
SELECT * FROM reserves JOIN sailors using (sid);

-- find the names of sailors who have researved boat number 103
select S.sname
from sailors S, Reserves R
where s.sid=r.sid and r.bid=103;

-- if we translate the relational algebra
create table temp
SELECT * FROM reserves JOIN sailors using (sid);
select sname
from temp
where bid = 103;
-- This is not as effecient as the first one

select s.sname
from sailors S
where s.sid in (select r.sid
				from reserves r
                where r.bid=103);
                
select s.sname
from sailors S
where exists (select *
			  from reserves R
              where r.bid =103 and r.sid=s.sid);

-- Find the colors of boats reserved by Lubber
select b.color
from sailors s, boats b, reserves r
where b.bid=r.bid and s.sid=r.sid and s.sname='Lubber';

-- Find the names of sailors who have reserved a red or a green boat
select distinct s.sname
from sailors s, boats b, reserves r
where b.bid=r.bid and s.sid=r.sid and (b.color='red' or b.color='green');

-- Find the names of sailors who have reserved a red and a green boat
select s.sname
from sailors s, boats b, reserves r
where b.bid=r.bid and s.sid=r.sid and b.color='red' 
and s.sid in (select s2.sid
			  from sailors s2, boats b2, reserves r2
              where b2.bid=r2.bid and s2.sid=r2.sid and b2.color='green');

-- Find the names of sailors who have reserved at least one boat
select s.sname
from sailors s, reserves r
where s.sid = r.sid;

-- Find the names of sailors who have reserved at least 2 boats
select s.sname
from sailors s, reserves r
where s.sid = r.sid
group by s.sid
having count(*)>1;

-- order the names of sailors by the number of reserved boats
select s.sname, count(*)
from sailors s, reserves r
where s.sid = r.sid
group by s.sid
order by count(*) desc;

-- find the top 3 sailors by the number of reserved boats
select s.sname, count(*)
from sailors s, reserves r
where s.sid = r.sid
group by s.sid
order by count(*) desc limit 3;

-- find the sailor who reserve the least number of boats
select s.sname, count(*)
from sailors s, reserves r
where s.sid = r.sid
group by s.sid
order by count(*) asc limit 1;

-- find the records of sailor who has the higest ranking
select *
from Sailors s
where s.rating in (select max(s.rating) from sailors s);
-- run the following and see the difference
select *
from sailors s
order by s.rating desc limit 1;

-- Find the sids of sailors with age over 20 who have not reserved a red boat
select s.sname
from sailors s
where s.age>20 and s.sid not in (select r.sid
								 from reserves r, boats b
								 where r.bid=b.bid and b.color="red");
                                 
                                 
-- Find the sids and names of sailors whose name contains a or b
select s.sid, s.sname
from sailors s
where (s.sname like "%a%" or s.sname like "%b%");

-- Find the sids and names of sailors whose name contains a or b, and how many different boads they reserved
select s.sid, s.sname, count(distinct r.bid)
from sailors s, reserves r
where (s.sname like "%a%" or s.sname like "%b%") and s.sid=r.sid
group by r.sid;

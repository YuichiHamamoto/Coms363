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


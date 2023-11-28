

create table StarsIn (
	movieTitle		varchar(40),
    movieYear		integer,
    starName		varchar(40),
    
    primary key(movieTitle,movieYear,starName)
    

);


create table Movie (
	Title		varchar(40),
    `Year`		integer,
    `Length`	integer,
    StudioName	varchar(40),
    Budget		integer,
    
    primary key(Title,`Year`)

);

create table MovieStar(
	`name`		varchar(40),
    netWorth	integer,
	
    primary key(`name`)
);


create table Studio(
	`name` 			varchar(40),
    TotalBudget		integer,

	primary key (`name`)
);





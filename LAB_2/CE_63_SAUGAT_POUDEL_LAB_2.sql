create database LAB2;
use LAB2;

CREATE table books
(
		book_id int,
        editionno int,
        page_no int,
        isbn_no int,
        price int,
        published_date date,
        language varchar(20) not null,
        title varchar(20) not null,
        genre varchar(20) not null,
        auth_id int,
        primary key (book_id),
        foreign key (auth_id) references author (author_id)
        
);
	insert into books (book_id, editionno, page_no, isbn_no, price, published_date, language, title, genre,auth_id)
	values 	(1, 10, 500, 979, 2000, '2021-10-02', 'English', 'Dont look up', 'sci-fi',1),
			(2, 11, 5000, 978, 20000, '2021-11-05', 'English', 'look up', 'sci-fi',1),
			(3, 12, 200, 975, 200, '2021-10-05', 'English', 'look down', 'lovestory,',1),
			(4, 13, 300, 95, 700, '2021-10-06', 'Nepali', 'pari', 'lovestory',2),
			(5, 14, 400, 105, 800, '1998-10-21', 'Nepali', 'sathi', 'fiction',2),
			(6, 15, 500, 108, 850, '1992-07-06', 'korean', 'miracle in cell no 7', 'novel',4);
            insert into books (book_id, editionno, page_no, isbn_no, price, published_date, language, title, genre,auth_id)
            values (7,16,666,852,5000,'1992-04-08','nepali','shaswot prem','novel',5);
			insert into books (book_id, editionno, page_no, isbn_no, price, published_date, language, title, genre,auth_id)
            values (8,17,455,999,5000,'1992-04-08','english','amplify','sci-fi',2);
            
update books
set genre='lovestory'
where book_id=3;
update books 
set auth_id = 2 
where book_id =5;
update books
set published_date = '2021-10-07'
where book_id = 2;
update books
set title = 'Ambience'
where book_id =2;
update books set `published_date` = "2021/10/22" where book_id = 1;


create table AUTHOR
(
		author_id int,
		auth_name varchar(20),
        phone_no char(11),
        email varchar(50),
        qualification varchar(20),
        dob date,
        gender varchar(20),
        primary key(author_id)
);  


insert into author (author_id,auth_name,phone_no,email,qualification,dob,gender)
values
(1,'saugat poudel', 9842101201, 'saugat.poudel478@gmail.com', 'phd in literature','1964-02-21','male'),

(2,'swastik acharya', 9842101211, 'swastik.acharya@gmail.com', 'phd in arts','1965-02-22','male'),

(3,'sukriti poudel', 9842104201, 'sukriti.poudel118@gmail.com', 'phd in literature','1955-06-1','female'),

(4,'aryan dahal', 9842185201, 'aryan.dahal852@gmail.com', 'masters in business','1968-03-25','male'),

(5,'rohan dhakal', 9844561201, 'rohan.dhakal666@gmail.com', 'phd in literature','1962-03-28','male'),

(6,'saskar khadka', 9842221201, 'saskar.khadka99@gmail.com', 'phd in psychology','1963-04-27','male');


create table magazine
(
	magazine_id int,
	title varchar(20),
    language varchar(20),
    page_no int,
    genre varchar(20),
    issue_no int,
    price int,
    published_date date
    
);

insert into magazine (magazine_id, title, language, page_no, genre, issue_no, price, published_date)
values
		(1, 'family circle','english', 25, 'family fun', 78952, 2000, '2021-10-20'),
        (2, 'achyut', 'nepali', 30, 'yoga', 66628, 2000, '2021-10-23'),
        (3, 'ronaldo', 'english', 15, 'sport', 55846, 1500, '2021-10-25'),
        (4, 'redbook', 'english', 10, 'family fun', 78265, 1000, '2020-10-11'),
        (5, 'wired', 'english', 50, 'science', 8888, 3000, '2020-10-30'),
        (6, 'traditional home', 'english', 22, 'culture', 41256, 1800,'2020-11-20'),
		(7, 'ashram', 'nepali', 222, 'culture', 41446, 5000,'2020-08-05');
        
create table distributor(
	distributor_id  int,
    location varchar(50) not null,
    email varchar(50) not null,
    pan_no char(20),
    shop_name varchar(50),
    phone_no char(11),
    primary key(distributor_id)
);
insert into distributor(distributor_id, location, email, pan_no, shop_name, phone_no)
values
	(1,'birtamode','saugat.poudel478@gmail.com',422168, 'sarika books', 9842623204),
    (2,'surunga','ram.khanal@gmail.com',422178, 'surunga books', 9842101201),
    (3,'kathmandu','shyam.prasai@gmail.com',400198, 'authentic books', 9807952323),
    (4,'bhaktapur','sitasharma@gmail.com',022168, 'stationary and books', 9852670110),
    (5,'kavre','hariprasad@gmail.com',144167, 'sunshine books', 984241401),
    (6,'bhadrapur','sitoshna@gmail.com',421858, 'sitoshna books', 9844689185);
    
create table orders
(
  id int not null,
  total_amount int not null,
  primary key  (id)
);
insert into orders(id, total_amount)
values 	(1,1500),
		(2,18000),
        (3,150),
        (4,650),
        (5,750),
        (6,800);
create table authored_by
(
  author_id int not null,
  book_id int not null,
  primary key (author_id, book_id),
  foreign key (author_id) references Author(author_id),
  foreign key (book_id) references Books(book_id)
);
insert into authored_by(author_id, book_id)
values 	(1,1),
		(1,2),
        (1,3),
        (2,4),
        (3,5),
        (4,6);
update authored_by
set author_id =2
where book_id = 5;

create table book_order
(
  quantity int not null,
  order_date date,
  discount int not null,
  book_id int not null,
  id int not null,
  primary key (book_id, id),
  foreign key (book_id) references Books(book_id),
  foreign key (id) references orders(id)
);
insert into book_order(quantity,order_date,discount,book_id,id)
values 	(20,'2021-10-21',500,1,1),
		(25,'2021-08-22',500,1,1),
		(28,'2021-12-18',2000,2,2),
        (30,'2022-02-19', 50,3,3),
        (34,'2021-08-22',500,4,4),
		(40,'2021-08-09',500,3,5);
create table makes_order
(
  distributor_id int not null,
  id int not null,
  primary key (distributor_id, id),
  foreign key (distributor_id) references distributor(distributor_id),
  foreign key (id) references orders(id)
);
insert into makes_order(distributor_id,id)
values	(1,1),
		(2,1),
        (3,2),
        (4,3),
        (5,1);
insert into makes_order(distributor_id,id)
values (6,1);
        
        


	-- 1 find the name of all published books
		select title from books;

	-- 2 find the name of all published books before 2000
		select title, published_date from books where published_date < '2000-01-01';

	-- 3 get the details of the book written by a particular author
		select * from books where Auth_ID
		in (select author_id from author WHERE auth_name = 'Saugat Poudel');
        
        select * from books where Auth_ID
		in (select author_id from author WHERE auth_name = 'Swastik Acharya');

        
	-- 4 Find the name of all weekly publications. 
		select title,published_date from books where published_date > '2021-10-01';
		select title,published_date from magazine where published_date > '2021-10-19';


	-- 5 find the name of pre ordered books
	select id, quantity, title,order_date,editionno,page_no,isbn_no,price from book_order as o join books on o.book_id = books.book_id 
    where o.order_date < books.published_date;
    
    
    
    -- 6 Get the details of all publications with the name starting with an 'A'.
    select * from books where title like 'A%';
    select * from magazine where title like 'A%';
    

    -- 7  Find all the orders for a particular book. The result must be sorted based on the order date. 
    select book_order.id, title, order_date, quantity from  books join book_order on book_order.book_id = books.book_id where books.title ='Dont look up' order by book_order.order_date;
    select book_order.id, title, order_date, quantity from books join book_order on book_order.book_id = books.book_id where books.title ='Dont look up' order by book_order.order_date desc;
    
    
    








create database session05_bt01;
use session05_bt01;
create table users(
	userId int primary key auto_increment,
    fullName varchar(100) not null,
    username varchar(50),
    pw varchar(50),
    address varchar(100),
    phone int not null unique,
    userStatus bit(1) default 1
);

create table roles(
	roleId int primary key auto_increment,
    roleName varchar(100) not null
);

create table user_role(
	user_id int not null,
    foreign key (user_id) references users(userID),
    role_id int not null,
    foreign key (role_id) references roles(roleID)
);

select * from users;
select * from roles;
select * from user_role;


insert into user_role ( user_id, role_id) values (6, 1), (7, 2), (8,2), (9,2), (10,2);
-- Dang ky

DELIMITER //
CREATE PROCEDURE PROC_ADD_USERS(
IN	fullName varchar(100), 
		username varchar(50),
		pw varchar(50),
		address varchar(100),
		phone int)
 BEGIN
	insert into users (fullName, username, pw, address, phone) 
    value (fullName, username, pw, address, phone);
END;
//
DELIMITER ;

call PROC_ADD_USERS ('nguyen van a', 'nguyenvana', 'nguyen', 'vietnam', 01234);
call PROC_ADD_USERS ('truong van a', 'truongvana', 'truong', 'nhatban', 09876);
call PROC_ADD_USERS ('dang van a', 'dangvana', 'dang', 'campuchia', 02468);
call PROC_ADD_USERS ('cao van a', 'caovana', 'cao', 'trungquoc', 01357);
call PROC_ADD_USERS ('do van a', 'dovana', 'do', 'italia', 09753);

DELIMITER //
CREATE PROCEDURE PROC_ADD_ROLES(IN roleName varchar(100))
 BEGIN
	insert into roles (roleName) 
    value (roleName);
END;
//
DELIMITER ;

call PROC_ADD_ROLES ('admin'); 
call PROC_ADD_ROLES ('nguoi dung');


-- Dang nhap
-- tham khao: https://freetuts.net/cau-lenh-if-else-trong-mysql-273.html
DELIMITER //
CREATE PROCEDURE PROC_LOGIN(IN  login_username varchar(50), login_pw varchar(50))
 BEGIN
 
 	declare login_check int;
	select username into login_check from users 
	where username = login_username  and pw = login_pw;
	if (login_check = null) then 
		select 'Ten tai khoan hoac mat khau bi sai';
	else 
        select login_check;
	end if;
 
 END;
//
DELIMITER ;

drop procedure PROC_LOGIN;

call PROC_LOGIN('truongvana','truong');
call PROC_LOGIN('caovana','truong');
call PROC_LOGIN('nguyenvana','nguyen');

-- lay ve tat ca user co role la nguoi dung
-- tham khao: https://funix.edu.vn/chia-se-kien-thuc/truy-van-co-so-du-lieu-menh-de-join/
DELIMITER //
CREATE PROCEDURE PROC_GET_ALL()
 BEGIN
	select u.* from users u 
    inner join user_role ur
	on u.userId = ur.user_id 
    inner join roles r
    on r.roleId = ur.role_id
    where r.roleName = 'nguoi dung';
 END;
//
DELIMITER ;

drop procedure PROC_GET_ALL;
call PROC_GET_ALL;




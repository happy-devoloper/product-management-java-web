create table tblRoles
(
	roleID varchar(2) primary key,
	roleName varchar(10) not null
)
go
create table tblUsers
(
	userID varchar(20) primary key,
	fullName nvarchar(50) not null,
	password nvarchar(20) not null,
	roleID varchar(2) foreign key references tblRoles(roleID),
	address nvarchar(100) not null,
	birthday date,
	phone char(20) not null,
	email varchar(50) not null,
	status varchar(10) not null
)
go
create table tblOrders
(
	orderID varchar(10) primary key,
	orderDate date not null,
	total money not null,
	userID varchar(20) foreign key references tblUsers(userID),
	status varchar(10) not null
)
go
create table tblCategory
(
	categoryID varchar(10) primary key,
	categoryName nvarchar(10) not null
)
go
create table tblProduct
(
	productID varchar(10) primary key,
	productName nvarchar(100) not null,
	image varchar(max),
	price money not null,
	quantity int not null,
	categoryID varchar(10) foreign key references tblCategory(categoryID),
	importDate date not null,
	usingDate date not null,
	status varchar(10) not null
)
go
create table tblOrderDetail
(
	detailID varchar(10) primary key,
	price money,
	quantity int,
	orderID varchar(10) foreign key references tblOrders(orderID),
	productID varchar(10) foreign key references tblProduct(productID),
)

insert into tblRoles (roleID, roleName) values ('AD', 'Admin')
insert into tblRoles (roleID, roleName) values ('US', 'User')


insert into tblUsers (userID, fullName, password, roleID, address, birthday, phone, email, status) values ('admin', 'Mariellen Gouley', '1', 'AD', '1 Walton Park','2001-06-15', '406-412-6149', 'haihoang2907@gmail.com', 'Active');
insert into tblUsers (userID, fullName, password, roleID, address, birthday, phone, email, status) values ('edeschlein1', 'Ellwood Deschlein', '5oKZkDYn', 'AD', '29 Blaine Plaza', '2001-09-20','839-887-8242' , 'minhthainguyen@gmail.com', 'NonActive');
insert into tblUsers (userID, fullName, password, roleID, address, birthday, phone, email, status) values ('user', 'Izabel Hiley', '2', 'US','502 Barnett Alley', '1996-06-15', '407-732-6555', 'nguyeanhtuan@gmail.com', 'Active');
insert into tblUsers (userID, fullName, password, roleID, address, birthday, phone, email, status) values ('hmatijevic3', 'Honey Matijevic', '9RdDsVV', 'US', '80170 Hayes Center','1998-02-23', '877-668-6701', 'mevabe@gmail.com', 'NonActive');
insert into tblUsers (userID, fullName, password, roleID, address, birthday, phone, email, status) values ('agrevatt4', 'Ailee Grevatt', 'yFVyE5ag', 'US', '1 Darwin Pass','2005-12-24', '982-199-7213', 'bavame@gmail.com', 'Active');

insert into tblCategory (categoryID, categoryName) values ('C01' , 'Đồ hộp')
insert into tblCategory (categoryID, categoryName) values ('C02' ,  'Đồ sống')

insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P01', 'Rau răm gói 100g', 'https://cdn.tgdd.vn/Products/Images/8820/271503/bhx/rau-ram-goi-100g-202202261912254571.jpg', 13500, 20, 'C01', '2022-01-15', '2022-03-29', 'Active')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P02', 'Rau đay gói 500g', 'https://cdn.tgdd.vn/Products/Images/8820/271534/bhx/rau-day-goi-500g-202202071547150231.jpeg', 14500, 10, 'C01', '2021-05-15', '2022-02-15', 'NonActive')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P03', 'Rau tan ô gói 500g', 'https://cdn.tgdd.vn/Products/Images/8820/271530/bhx/rau-tan-o-goi-500g-202202171348222799.jpg', 25000, 5, 'C01', '2022-02-28', '2022-03-29', 'Active')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P04', 'Xà lách búp thuy canh gói 300g', 'https://cdn.tgdd.vn/Products/Images/8820/271474/bhx/xa-lach-bup-thuy-canh-goi-300g-202202121611530035.jpg', 20000, 15, 'C01', '2022-01-15', '2022-04-23', 'Active')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P05', 'Cai ngot baby gói 300g', 'https://cdn.tgdd.vn/Products/Images/8820/223330/bhx/cai-ngot-baby-tui-300g-202011091645116909.jpg', 25000, 19, 'C01', '2022-01-15', '2022-06-29', 'Active')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P06', 'Đau que gói 500g', 'https://cdn.tgdd.vn/Products/Images/8820/222861/bhx/dau-cove-tui-500g-202009290951597685.jpg', 79000, 12, 'C02', '2022-01-15', '2022-05-29', 'Active')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P08', 'Chanh gói 500g', 'https://cdn.tgdd.vn/Products/Images/8820/271466/bhx/chanh-tui-500g-202202061225357811.jpg', 13500, 20, 'C02', '2021-12-15', '2022-02-28', 'NonActive')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P09', 'Đậu que gói 500g', 'https://cdn.tgdd.vn/Products/Images/8820/222861/bhx/dau-cove-tui-500g-202009290951597685.jpg', 15000, 20, 'C02', '2021-12-15', '2022-02-28', 'NonActive')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P10', 'Rau mong tơi baby gói 300g', 'https://cdn.tgdd.vn/Products/Images/8820/223332/bhx/rau-mong-toi-baby-tui-300g-202011071653165766.jpg', 14000, 20, 'C02', '2021-10-31', '2022-03-17', 'Active')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P11', 'Xà lách lô lô xanh gói 500g', 'https://cdn.tgdd.vn/Products/Images/8820/271485/bhx/xa-lach-lo-lo-xanh-goi-500g-202202101057239702.jpg', 15000, 20, 'C02', '2021-12-15', '2022-05-28', 'Active')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P12', 'Cai be dún gói 400g', 'https://cdn.tgdd.vn/Products/Images/8820/222627/bhx/cai-be-dun-tui-500g-202009292340411773.jpg', 24000, 25, 'C02', '2021-12-11', '2022-04-24', 'Active')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P13', 'Kim chi gói 200g', 'https://cdn.tgdd.vn/Products/Images/8820/232839/bhx/kim-chi-tui-100g-202012290831456838.jpg', 23000, 12, 'C01', '2021-12-11', '2022-07-28', 'Active')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P14', 'Toi tím Trung Quoc túi 300g (7-9 cu)', 'https://cdn.tgdd.vn/Products/Images/8820/271480/bhx/toi-tim-trung-quoc-tui-300g-5-7-cu-202202121629058628.jpg', 150000, 19, 'C01', '2021-12-15', '2022-02-28', 'NonActive')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P15', 'Toi tím Trung Quoc Huy Vũ gói 300g (5-7 cu)', 'https://cdn.tgdd.vn/Products/Images/8820/252741/bhx/toi-tim-trung-quoc-tui-300g-202110160331140839.jpeg', 18000, 15, 'C01', '2021-12-12', '2022-04-13', 'NonActive')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P16', 'Xà lách lolo xanh thuy canh gói 300g', 'https://cdn.tgdd.vn/Products/Images/8820/271486/bhx/xa-lach-lolo-xanh-thuy-canh-goi-300g-202202101058348325.jpg', 20000, 15, 'C01', '2021-12-12', '2022-04-13', 'NonActive')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P17', 'Lá giang tươi gói 200g', 'https://cdn.tgdd.vn/Products/Images/8820/271745/bhx/la-giang-tuoi-goi-200g-202202121608463701.jpg', 10000, 15, 'C01', '2021-12-12', '2022-04-19', 'Active')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P18', 'Rau lang gói 500g', 'https://cdn.tgdd.vn/Products/Images/8820/222884/bhx/rau-lang-tui-500g-202009292356221859.jpg', 9500, 15, 'C01', '2021-12-12', '2022-03-24', 'NonActive')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P19', 'Cải bó xôi gói 300g', 'https://cdn.tgdd.vn/Products/Images/8820/252679/bhx/cai-bo-xoi-tui-500g-202110131408059318.jpeg', 18000, 15, 'C01', '2021-12-12', '2022-05-13','Active')
insert into tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) values ('P20', 'Rau muống hạt tươi gói 500g', 'https://cdn.tgdd.vn/Products/Images/8820/226916/bhx/rau-muong-hat-tui-500g-202009292358286814.jpg', 18000, 15, 'C01', '2021-12-12', '2022-03-19','Active')


create database Gadget_Galaxy_Store_DB

use Gadget_Galaxy_Store_DB

create table Brands (-- one
ID int identity(300,1) PRIMARY KEY ,
NAME nvarchar(255) not null
)

create table Laptops (--many 
ID int identity(1000,1) PRIMARY KEY ,
NAME nvarchar(255) not null ,
Price money not null,
BrandID int FOREIGN KEY references Brands(ID) not null
)



create table Phones (--many 
ID int identity(2000,1) PRIMARY KEY ,
Name nvarchar(255) not null,
Price money not null,
BrandID int FOREIGN KEY references Brands(ID) not null
)



insert into Brands values('Apple'),
('Samsung'),
('HP')

insert into Laptops values(' MacBook Pro (M3)',2400,300),
('Galaxy Book3 Pro',1800,301)

insert into Phones values('Iphone 15 Pro',1100,300),
('Samsung Galaxy S23',1300,301),
('Iphone 15 Pro Max',1200,300)





select*from Laptops
select*from Phones
select*from Brands


----3) Laptops Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
select Laptops.Name as LaptopName, Brands.name as BrandName, Price as 'Laptop Price ($)' 
from Laptops 
join Brands on BrandID=Brands.ID


----4) Phones Adini, Brandin Adini BrandName kimi ve Qiymetini Cixardan Query.
select Phones.Name  as PhoneName, brands.NAME as BrandName , price as 'Phone Price ($)' from Phones 
join brands on BrandID=Brands.ID


----5) Brand Adinin Terkibinde s Olan Butun Laptoplari Cixardan Query.
select Laptops.Name as LaptopName, Brands.name as BrandName, Price as 'Laptop Price ($)' from Laptops 
join Brands on BrandID=Brands.ID
 WHERE Brands.name LIKE '%s%'


----6) Qiymeti 2000 ve 5000 arasi ve ya 5000 den yuksek Laptoplari Cixardan Query.
select Laptops.Name as LaptopName, Brands.name as BrandName, Price as 'Laptop Price ($)' from Laptops 
join Brands on BrandID=Brands.ID
WHERE Price BETWEEN 2000 AND 5000 OR Price > 5000;


----7) Qiymeti 1000 ve 1500 arasi ve ya 1500 den yuksek Phonelari Cixardan Query.
select Phones.Name  as PhoneName, brands.NAME as BrandName , price as 'Phone Price ($)' from Phones 
join brands on BrandID=Brands.ID
WHERE Price BETWEEN 1000 AND 1500 OR Price > 1500;


----8) Her Branda Aid Nece dene Laptop Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
SELECT Brands.Name as BrandNmae, COUNT(Laptops.ID) AS ProductCount
FROM Brands
LEFT JOIN Laptops ON Brands.Id = Laptops.BrandId
GROUP BY Brands.Name;



----9) Her Branda Aid Nece dene Phone Varsa Brandin Adini Ve Yaninda Sayini Cixardan Query.
SELECT Brands.Name AS BrandName, COUNT(Phones.Id) AS ProductCount
FROM Brands
LEFT JOIN Phones ON Brands.Id = Phones.BrandId
GROUP BY Brands.Name;



----10) Hem Phone Hem de Laptoplda Ortaq Olan Name ve BrandId Datalarni Bir Cedvelde Cixardan Query.

SELECT Brands.ID AS CommonBrandId, 
	   Brands.NAME AS CommonBrandName,
       Laptops.NAME AS LaptopName,
       Phones.Name AS PhoneName
FROM Brands
JOIN Laptops ON Brands.ID = Laptops.BrandID
JOIN Phones ON Brands.ID = Phones.BrandID
WHERE Laptops.ID IN (
    SELECT MIN(ID)
    FROM Laptops
    GROUP BY BrandID
)
AND Phones.ID IN (
    SELECT MIN(ID)
    FROM Phones
    GROUP BY BrandID
);



----11) Phone ve Laptop da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.
SELECT*FROM Phones UNION Select*FROM Laptops;



----12) Phone ve Laptop da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.
SELECT Phones.Id, Phones.Name, Price, Brands.Name AS BrandName FROM Phones
JOIN Brands ON Phones.BrandId = Brands.Id
UNION 
SELECT Laptops.Id, Laptops.Name, Laptops.Price, Brands.Name AS BrandName FROM Laptops
JOIN Brands ON Laptops.BrandId = Brands.Id



----13) Phone ve Laptop da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.
SELECT Phones.Id, Phones.Name, Price, Brands.Name AS BrandName FROM Phones
JOIN Brands ON Phones.BrandId = Brands.Id
where Price>1600
UNION 
SELECT Laptops.Id, Laptops.Name, Laptops.Price, Brands.Name AS BrandName FROM Laptops
JOIN Brands ON Laptops.BrandId = Brands.Id
where Price>1600




----14) Phones Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) ve Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olan Datalari Cixardan
select Brands.NAME as BrandName , 
SUM(Price)  as 'Total Price per Phone ($)', 
COUNT(Phones.ID) as ProductCount 
from Phones 
join brands on BrandID=Brands.ID
group by Brands.NAME



----15) Laptops Tabelenden Data Cixardacaqsiniz Amma Nece Olacaq Brandin Adi (BrandName kimi), Hemin Brandda Olan Telefonlarin Pricenin Cemi (TotalPrice Kimi) , Hemin Branda Nece dene Telefon Varsa Sayini (ProductCount Kimi) Olacaq ve Sayi 3-ve 3-den Cox Olan Datalari Cixardan 
select Brands.NAME as BrandName , 
COUNT(Laptops.id) as ProductCount,
SUM(Price)  as 'TotalPrice per Laptop ($)'
from Laptops
join Brands on brands.ID=BrandID
group by Brands.NAME
HAVING COUNT(Laptops.Id) >= 1;





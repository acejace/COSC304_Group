DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS shipment;
DROP TABLE IF EXISTS productinventory;
DROP TABLE IF EXISTS warehouse;
DROP TABLE IF EXISTS orderproduct;
DROP TABLE IF EXISTS incart;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS ordersummary;
DROP TABLE IF EXISTS paymentmethod;
DROP TABLE IF EXISTS customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Graphics Card');
INSERT INTO category(categoryName) VALUES ('CPU/Processor');
INSERT INTO category(categoryName) VALUES ('RAM');
INSERT INTO category(categoryName) VALUES ('AIO cooling');


INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('EVGA GTX 1080','1','Graphics Card','199.99','img/1.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('ASUS GTX 1080','1','Graphics Card','219.99','img/2.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('NVIDIA GTX 1080 Founders Edition','1','Graphics Card','189.99','img/3.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('MSI GTX 1080 Ti Gaming X Trio','1','Graphics Card','229.99','img/4.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('ZOTAC RTX 3070','1','Graphics Card','599.99','img/5.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Nvidia RTX 3070','1','Graphics Card','579.99','img/6.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Nvidia RTX 3080','1','Graphics Card','899.99','img/7.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('ZOTAC RTX 3080','1','Graphics Card','899.99','img/8.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('ASUS RTX 3080 TUF','1','Graphics Card','929.99','img/9.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('ASUS RTX 3080 ROG STRIX','1','Graphics Card','929.99','img/10.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Nvidia RTX 3090','1','Graphics Card','1999.99','img/11.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('EVGA GTX 1080','1','Graphics Card','199.99','img/12.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('ASUS GTX 1080','1','Graphics Card','219.99','img/13.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('NVIDIA GTX 1080 Founders Edition','1','Graphics Card','189.99','img/14.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('MSI GTX 1080 Ti Gaming X Trio','1','Graphics Card','229.99','img/15.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('ZOTAC RTX 3070','1','Graphics Card','599.99','img/16.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Nvidia RTX 3070','1','Graphics Card','579.99','img/17.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Nvidia RTX 3080','1','Graphics Card','899.99','img/18.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('ZOTAC RTX 3080','1','Graphics Card','899.99','img/19.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('ASUS RTX 3080 TUF','1','Graphics Card','929.99','img/20.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('ASUS RTX 3080 ROG STRIX','1','Graphics Card','929.99','img/21.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('AMD RYZEN 5 3600','2','Processor','299.99','img/22.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('AMD RYZEN 5 5600X','2','Processor','349.99','img/23.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('AMD RYZEN 7 3700x','2','Processor','449.99','img/24.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('AMD RYZEN 7 5800x','2','Processor','549.99','img/25.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('TridentZ RGB 16GB','3','RAM','129.99','img/26.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('CORSAIR Vengence RGB PRO 16GB','3','RAM','169.99','img/27.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('CORSAIR Vengence RGB PRO 128GB','3','RAM','822.99','img/28.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('NZXT Kraken x63 240MM','4','AIO Cpu cooling system','159.99','img/29.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('Corsair iCUE H510i 240MM','4','AIO Cpu cooling system 2','239.99','img/30.jpg');
INSERT product(productName, categoryId, productDesc, productPrice, productImageURL) VALUES ('CoolerMaster MasterLiquid 120MM','4','AIO Cpu cooling system','89.99','img/31.jpg');

INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8

UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;

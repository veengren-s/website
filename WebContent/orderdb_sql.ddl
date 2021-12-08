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

INSERT INTO category(categoryName) VALUES ('Nebula');
INSERT INTO category(categoryName) VALUES ('Star');
INSERT INTO category(categoryName) VALUES ('Galaxy');

INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Dark Nebula', 1, 'A dark nebula is a nebula so dense that it obstructs the light from the objects behind!',10000);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Mixed Nebula', 1, 'A mixed nebula is a combination of an emition nebula and a reflection nebula. Meaning that part of it is reflecting the surrounding light and part fo it is emiting its own.',8000);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Reflection Nebula', 1, 'A reflection nebula is a nebula that does not emit its own light. It is visible because it is reflecting the light from surrounding objects, such as suns, towards the observer.',8500);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Emmission Nebula', 1, 'An emmision nebula is visible because it is emiting its own light towards the observers. These are typically a bright red colour as a result of the hydrogen atoms in the nebula',7200);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Stars', 2, 'There are hundreds millions of visible with just the naked eye, and evon more visible through a telescope.',1000);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Constelation', 1, 'There a thousands of constellations  visible in the night sky, this is your chance to own your own constelation.',25000);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Spiral Galaxy', 3, 'A collection of billions of stars rotating around a large mass. These Galaxies appear to have arms,altough their are millions of these in the unverse only a handful can be seen by the naked eye!',5000);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Elliptical Galaxy', 3, 'One of the most abundant galaxy types in the universe an eliptical galaxy. These appear as an ellipse in the nights sky.',4500);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Irregular Galaxy', 3, 'These galaxies dont fit into any of the above categories. They can be all shapes and sizes and are unique.',65000);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Planetary Nebula', 1, 'These nebula are not related to planets as the name would suggest, they are emission nebula that are a round shape, giving them the name planetary nebula.',9200);
INSERT INTO product(productName, categoryId, productDesc, productPrice) VALUES ('Supernova Reminance', 1, 'These nebula a result of a large stare running out of fuel or small dwarf start collecting enought mass to cause an explosion.',1200);


INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (1, 1, 12, 10000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (2, 1, 45, 8000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (3, 1, 21, 8500);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (4, 1, 43, 7200);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (5, 1, 66, 1000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (6, 1, 31, 25000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (7, 1, 41, 5000);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (8, 1, 9, 4500);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 6500);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (10, 1, 7, 9200);
INSERT INTO productinventory(productId, warehouseId, quantity, price) VALUES (11, 1, 12, 12000);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/dark.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/cal.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/cat.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/el.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/ir.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/orion-const.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/orion.png' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/sup.jpg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/witch.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/andromeda_good.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/star.jpg' WHERE ProductId = 5;

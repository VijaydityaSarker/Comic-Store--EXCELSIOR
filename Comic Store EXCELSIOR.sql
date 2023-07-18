DROP DATABASE IF EXISTS excelsior;
create database EXCELSIOR;
USE EXCELSIOR ;

DROP TABLE IF EXISTS Comics;
CREATE TABLE Comics (
    comic_id INT PRIMARY KEY,
    title TEXT NOT NULL,
    issue_number INT NOT NULL
    );

INSERT INTO Comics (comic_id, title, issue_number) 
VALUES 
(1, 'The Amazing Spider-Man', 1), 
(2, 'Batman: The Killing Joke', 1), 
(3, 'Watchmen', 1), 
(4, 'Saga', 1), 
(5, 'The Walking Dead', 1), 
(6, 'X-Men', 1), 
(7, 'Deadpool', 1), 
(8, 'Captain America', 1), 
(9, 'The Sandman', 1), 
(10, 'Spawn', 1);

DROP TABLE IF EXISTS Quality;
CREATE TABLE Quality (
  quality_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  grade VARCHAR(255) NOT NULL,
  grade_descp TEXT NOT NULL,
  num_grade INT NOT NULL
);

INSERT INTO quality (grade, grade_descp, num_grade) VALUES
  ('Mint', 'Near-perfect condition with no visible flaws', 10),
  ('Near Mint', 'Almost perfect condition with only minor flaws', 9.5),
  ('Very Fine', 'Slightly worn with minor creases or other signs of use', 8),
  ('Fine', 'Moderately worn with visible creases and other signs of use', 6),
  ('Very Good', 'Sightly more worn with significant creases and other signs of use', 4),
  ('Good', 'Heavily worn with significant creases and other signs of use', 2.2),
  ('Fair', 'Very heavily worn with major damage or defects', 1),
  ('Poor', 'Barely readable with severe damage or defects', 0.5);
  
  DROP TABLE IF EXISTS ComicQuality;
  CREATE TABLE ComicQuality (
  comic_id INT NOT NULL,
  quality_id INT NOT NULL,
  PRIMARY KEY (comic_id, quality_id),
  FOREIGN KEY (comic_id) REFERENCES Comics(comic_id),
  FOREIGN KEY (quality_id) REFERENCES Quality(quality_id)
);

INSERT INTO ComicQuality (comic_id, quality_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(3, 3),
(4, 4),
(5, 1),
(5, 2),
(5, 3),
(5, 4);

DROP TABLE IF EXISTS Inventory;
CREATE TABLE Inventory (
  inventory_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  comic_id INT NOT NULL,
  date_added DATE NOT NULL,
  quantity INT NOT NULL,
  FOREIGN KEY (comic_id) REFERENCES Comics(comic_id)
);

INSERT INTO Inventory (comic_id, date_added, quantity)
VALUES
  (1, '2023-05-01', 50),
  (2, '2023-05-03', 25),
  (3, '2023-05-02', 100),
  (4, '2023-05-05', 75),
  (5, '2023-05-01', 10),
  (6, '2023-05-04', 5),
  (7, '2023-05-02', 30),
  (8, '2023-05-06', 20),
  (9, '2023-05-01', 15),
  (10, '2023-05-05', 10);
  
  DROP TABLE IF EXISTS InventoryCosts;
  CREATE TABLE InventoryCosts (
  comic_id INT NOT NULL PRIMARY KEY,
  cost_price DECIMAL(8,2) NOT NULL,
  FOREIGN KEY (comic_id) REFERENCES Comics(comic_id)
);
INSERT INTO InventoryCosts (comic_id, cost_price)
VALUES
(1, 5.99),
(2, 8.99),
(3, 12.99),
(4, 9.99),
(5, 14.99),
(6, 6.99),
(7, 10.99),
(8, 13.99),
(9, 7.99),
(10, 11.99);


DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
  Customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Customer_First_Name VARCHAR(50) NOT NULL,
  Customer_Last_Name VARCHAR(50) NOT NULL,
  City VARCHAR(50),
  State VARCHAR(50)
);

INSERT INTO Customers (Customer_First_Name, Customer_Last_Name, City, State)
VALUES 
    ('John', 'Doe', 'New York', 'NY'),
    ('Jane', 'Doe', 'San Francisco', 'CA'),
    ('Bob', 'Smith', 'Chicago', 'IL'),
    ('Alice', 'Johnson', 'Los Angeles', 'CA'),
    ('David', 'Lee', 'Houston', 'TX'),
    ('Emily', 'Chen', 'Seattle', 'WA'),
    ('Steven', 'Kim', 'Miami', 'FL'),
    ('Linda', 'Wang', 'Boston', 'MA'),
    ('Michael', 'Nguyen', 'San Diego', 'CA'),
    ('Sarah', 'Jones', 'Portland', 'OR');
    

DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales (
  sale_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Customer_id INT NOT NULL,
  sale_date DATE NOT NULL,
  FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)
);


INSERT INTO Sales (Customer_id, sale_date)
VALUES
  (1, '2023-02-01'),
  (2, '2023-05-01'),
  (3, '2022-07-02'),
  (4, '2023-05-02'),
  (5, '2023-05-03'),
  (6, '2022-11-03'),
  (7, '2022-05-04'),
  (8, '2022-09-04'),
  (9, '2023-05-05'),
  (10, '2022-09-05');

  
  
DROP TABLE IF EXISTS SaleDetails;
CREATE TABLE SaleDetails (
  sale_id INT NOT NULL,
  comic_id INT NOT NULL,
  sale_quantity INT NOT NULL,
  sale_price INT NOT NULL,
  PRIMARY KEY (sale_id, comic_id),
  FOREIGN KEY (sale_id) REFERENCES Sales(sale_id),
  FOREIGN KEY (comic_id) REFERENCES Comics(comic_id)
);
INSERT INTO SaleDetails (sale_id, comic_id, sale_quantity, sale_price)
VALUES
  (1, 1, 2, 10),
  (1, 2, 1, 15),
  (2, 3, 1, 20),
  (2, 4, 3, 7),
  (3, 5, 2, 25),
  (3, 6, 4, 10),
  (4, 7, 1, 15),
  (4, 8, 2, 20),
  (5, 9, 3, 12),
  (5, 10, 1, 16);

    
    
DROP TABLE IF EXISTS Publications;
CREATE TABLE Publications (
  publication_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  publication_name VARCHAR(255) NOT NULL,
  publication_type VARCHAR(50) NOT NULL,
  comic_id INT NOT NULL,
  publication_date DATE NOT NULL,
  FOREIGN KEY (comic_id) REFERENCES Comics(comic_id)
);
INSERT INTO Publications (publication_name, publication_type, comic_id, publication_date) VALUES
('MARVEL', 'Comic Book', 1, '1962-03-10'),
('MARVEL', 'Comic Book', 2, '1939-05-01'),
('MARVEL', 'graphic novels', 3, '1963-09-01'),
('DC', 'graphic novels', 4, '1942-12-01'),
('MARVEL', 'Comic Book', 5, '1962-05-01'),
('MARVEL', 'Comic Book', 6, '1963-03-01'),
('DC', 'Comic Book', 7, '1956-10-01'),
('DC', 'Comic Book', 8, '1940-07-01'),
('MARVEL', 'Comic Book', 9, '1964-04-10'),
('MARVEL', 'Comic Book', 10, '1941-03-10');





-- 1st View
CREATE VIEW ProfitAndLoss AS
SELECT SaleDetails.sale_id,
       Comics.title,
       SUM(SaleDetails.sale_quantity) AS total_sales_quantity,
       SUM(SaleDetails.sale_price) AS total_sales_price,
       SUM(SaleDetails.sale_quantity * InventoryCosts.cost_price) AS total_cost,
       SUM(SaleDetails.sale_quantity * SaleDetails.sale_price) - SUM(SaleDetails.sale_quantity * InventoryCosts.cost_price) AS total_profit
FROM Comics
INNER JOIN SaleDetails ON Comics.comic_id = SaleDetails.comic_id
INNER JOIN InventoryCosts ON Comics.comic_id = InventoryCosts.comic_id
GROUP BY SaleDetails.sale_id, Comics.title;

SELECT * FROM ProfitAndLoss;


-- 2nd VIEW
CREATE VIEW ComicSales AS
SELECT c.title, p.publication_date, sd.sale_price
FROM Comics c
JOIN Publications p ON c.comic_id = p.comic_id
JOIN SaleDetails sd ON c.comic_id = sd.comic_id;

select * From ComicSales;

-- 3rd View
CREATE VIEW SalesByPublicationType AS
SELECT p.publication_type, 
       SUM(sd.sale_quantity) AS total_quantity,
       SUM(sd.sale_price * sd.sale_quantity) AS total_revenue
FROM Sales s
JOIN SaleDetails sd ON s.sale_id = sd.sale_id
JOIN Publications p ON sd.comic_id = p.comic_id
GROUP BY p.publication_type;

select * From SalesByPublicationType;

-- 4th view
CREATE VIEW ComicInfo AS
SELECT c.title, q.grade, i.quantity
FROM Comics c
INNER JOIN Quality q ON c.comic_id = q.quality_id
INNER JOIN Inventory i ON c.comic_id = i.comic_id
WHERE q.num_grade > 8;

select * From ComicInfo;



-- 1st Stored procedures
USE `excelsior`;
DROP procedure IF EXISTS `get_comic_inventory`;

DELIMITER $$
USE `excelsior`$$
CREATE PROCEDURE `get_comic_inventory` (
 IN comic_id INT
 )
BEGIN
DECLARE quantity INT;
    SELECT Inventory.quantity INTO quantity
    FROM Inventory
    WHERE Inventory.comic_id = comic_id;
    
    SELECT Comics.title, quantity,
        IF(quantity > 0, 'Stock present', 'No stock') AS message
    FROM Comics
    WHERE Comics.comic_id = comic_id;

END;$$

DELIMITER ;

select * from inventory;
call get_comic_inventory(6);

-- 2nd stored prcedure

USE `excelsior`;
DROP procedure IF EXISTS `excelsior`.`search_comics_by_title`;
;

DELIMITER $$
USE `excelsior`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_comics_by_title`(
IN search_title VARCHAR(255)
)
BEGIN
 SELECT *
  FROM Comics
  WHERE title LIKE CONCAT('%', search_title, '%');
END$$

DELIMITER ;
;

select * from comics;
call search_comics_by_title("spider");


-- 1st trigger
DROP TRIGGER IF EXISTS `excelsior`.`prevent_deletion_if_inventory`;

DELIMITER $$
USE `excelsior`$$
CREATE DEFINER = CURRENT_USER TRIGGER `excelsior`.`prevent_deletion_if_inventory` BEFORE DELETE ON `comics` FOR EACH ROW
BEGIN
IF EXISTS(SELECT 1 FROM Inventory WHERE comic_id = OLD.comic_id AND quantity > 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete comic with inventory present.';
    END IF;
END;$$
DELIMITER ;

select * from inventory;
select * FROM COMICS;
-- use this command to se result of trigger
-- delete from comics where comic_id = 3;

-- 2nd trigger
DROP TRIGGER IF EXISTS `excelsior`.`add_to_inventory`;

DELIMITER $$
USE `excelsior`$$
CREATE DEFINER = CURRENT_USER TRIGGER `excelsior`.`add_to_inventory` AFTER INSERT ON `comics` FOR EACH ROW
BEGIN
 INSERT INTO Inventory (comic_id, date_added, quantity) VALUES (NEW.comic_id, NOW(), 1);
END;$$
DELIMITER ;

select * from inventory;
select* from comics;
INSERT INTO Comics (comic_id, title, issue_number) 
VALUES 
(12, 'The Amazing Spider-Man', 3);


-- --queries

-- --1) Retrieve all comics from the Comics table.

SELECT * FROM Comics;

-- 2)Retrieve all comic books and their associated qualities.

SELECT Comics.title, Quality.grade
FROM Comics 
JOIN ComicQuality  ON Comics.comic_id = ComicQuality.comic_id
JOIN Quality  ON ComicQuality.quality_id = Quality.quality_id;

-- 3) Retrieve the total quantity of inventory for each comic book.
 
 SELECT Comics.title, SUM(Inventory.quantity) as total_quantity
FROM Comics 
JOIN Inventory  ON Comics.comic_id = Inventory.comic_id
GROUP BY Comics.title;

-- 4)Retrieve the top 3 best-selling comics based on sales quantity.

SELECT Comics.title, SUM(SaleDetails.sale_quantity) as total_sales
FROM Comics 
JOIN SaleDetails  ON Comics.comic_id = SaleDetails.comic_id
GROUP BY Comics.title
ORDER BY total_sales DESC
LIMIT 3;

-- 5)Retrieve the total revenue from all sales for a 2022 september to 2023 March 

SELECT SUM(SaleDetails.sale_quantity * SaleDetails.sale_price) as total_revenue
FROM SaleDetails 
JOIN Sales  ON SaleDetails.sale_id = Sales.sale_id
WHERE Sales.sale_date BETWEEN '2022-09-01' AND '2023-03-31';


-- 6)Find the top 3 comics with the highest total sales amount.

SELECT Comics.comic_id, Comics.title, SUM(SaleDetails.sale_quantity * SaleDetails.sale_price) AS Total_Sales_Amount
FROM Comics 
JOIN SaleDetails  ON Comics.comic_id = SaleDetails.comic_id
GROUP BY Comics.comic_id
ORDER BY Total_Sales_Amount DESC
LIMIT 3;



-- 7)Find the comics that have never been sold.

SELECT Comics.comic_id, Comics.title
FROM Comics
LEFT JOIN SaleDetails ON Comics.comic_id = SaleDetails.comic_id
WHERE SaleDetails.sale_id IS NULL;


USE 090924_Kutushev;

CREATE TABLE goods(
	id INT,
    title VARCHAR(128),
    price INT,
    quantity INT
);

INSERT INTO goods(id, title, price, quantity) VALUES (1, 'велосипед', 12000, 4);
INSERT INTO goods(id, title, price, quantity) VALUES (2, 'лыжи', 10000, 5);
INSERT INTO goods(id, title, price, quantity) VALUES (3, 'коньки', 6000, 7);
INSERT INTO goods(id, title, price, quantity) VALUES (4, 'скейт', 10000, 2);

UPDATE goods
SET price = 10000
WHERE id = 1;

CREATE VIEW v_good_cheap AS
	SELECT * FROM goods
    WHERE price < 10000; 

SELECT * FROM goods;

SELECT * FROM v_good_cheap;
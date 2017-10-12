 -- seed the database tables

INSERT INTO customers (name) VALUES
('John'),
('Thomas'),
('Alfred'),
('Helen');

INSERT INTO products (name, price) VALUES
('phone', 150),
('radio', 250),
('tv', 400);

INSERT INTO carts (customer_id) VALUES
(1),
(2),
(1);

INSERT INTO line_items (cart_id, product_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 3);

-- 1. What products are in a cart?
--   -> you need to find the cart by ID (carts table cart_id 1-3)
--      then find all line_items with the cart_id (line_items table)
--      then find all the product in those line_items rows (l ine_items table)
--      then lookup the products.name for the product_id from those line_item rows (products table)

SELECT products.id AS "Product ID", products.name AS "Product Name", price AS "Product Price $", cart_id AS "Cart ID"
FROM products
INNER JOIN line_items
ON line_items.product_id = products.id;

-- to limit the results only present in the 1st cart, add
-- WHERE line_items.cart_id = 1;

-- left outer join
-- SELECT product_id, name, price, cart_id
-- FROM products
-- LEFT OUTER JOIN line_items
-- ON line_items.product_id = products.id;

-- 2. What's the total price of each cart?
SELECT line_items.cart_id AS "Cart ID", COUNT(*) AS "Num of Items", SUM(products.price) AS "Total $"
FROM products
INNER JOIN line_items
ON line_items.product_id = products.id
GROUP BY line_items.cart_id;

-- total for an individual cart
-- SELECT SUM(price) AS "Total $"
-- FROM products
-- INNER JOIN line_items
-- ON line_items.product_id = products.id
-- WHERE line_items.cart_id = 1;

-- 3. Who bought the items (starting at products, you need to create joins to each table before reaching customers)
SELECT customers.name AS "Customer Name", line_items.cart_id AS "Cart ID", COUNT(*) AS "Num of Items in Cart", SUM(products.price) AS "$ Total"
FROM products
INNER JOIN line_items ON products.id = line_items.product_id
INNER JOIN carts ON line_items.cart_id = carts.id
INNER JOIN customers ON carts.customer_id = customers.id
GROUP BY line_items.cart_id;


-- 4. Who is the most valuable customer?
SELECT customers.name AS "Product", COUNT(*) AS "Num of Items Ordered", SUM(products.price) AS "$ Total"
FROM products
INNER JOIN line_items ON products.id = line_items.product_id
INNER JOIN carts ON line_items.cart_id = carts.id
INNER JOIN customers ON carts.customer_id = customers.id
GROUP BY customers.id
ORDER BY "$ Total" DESC
LIMIT 1;


-- 5.  What is the most valuable product?
SELECT products.name AS "Product", COUNT(*) AS "Num of Items Ordered"
FROM products
INNER JOIN line_items ON products.id = line_items.product_id
-- INNER JOIN carts ON line_items.cart_id = carts.id
-- INNER JOIN customers ON carts.customer_id = customers.id
GROUP BY line_items.product_id
ORDER BY "Num of Items Ordered" DESC
LIMIT 1;

CREATE TABLE products (
  id INTEGER PRIMARY KEY,
  name TEXT,
  price INTEGER
);

CREATE TABLE customers (
  id INTEGER PRIMARY KEY,
  name TEXT
);

CREATE TABLE carts (
  id INTEGER PRIMARY KEY,
  customer_id INTEGER
);

-- keep a record of which cart contained which items
CREATE TABLE line_items (
  id INTEGER PRIMARY KEY,
  cart_id INTEGER,
  product_id INTEGER
);

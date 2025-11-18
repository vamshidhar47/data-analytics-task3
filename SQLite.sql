-- Create tables
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT,
    country TEXT
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date TEXT,
    amount REAL,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

-- Insert sample data
INSERT OR IGNORE INTO customers VALUES
(1, 'John', 'USA'),
(2, 'Priya', 'India'),
(3, 'Akira', 'Japan'),
(4, 'Sara', 'Canada');

INSERT OR IGNORE INTO orders VALUES
(101, 1, '2023-10-10', 250),
(102, 2, '2023-10-11', 400),
(103, 3, '2023-10-12', 150),
(104, 1, '2023-10-12', 300),
(105, 2, '2023-10-13', 200);

-- 1. View all orders
SELECT * FROM orders;

-- 2. Filter + Sort
SELECT customer_id, amount 
FROM orders 
WHERE amount > 200 
ORDER BY amount DESC;

-- 3. Group by + Sum
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- 4. Inner Join
SELECT c.customer_name, o.order_id, o.amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- 5. Left Join
SELECT c.customer_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 6. Subquery (above average)
SELECT order_id, amount
FROM orders
WHERE amount > (SELECT AVG(amount) FROM orders);

-- 7. Create View
CREATE VIEW customer_sales AS
SELECT c.customer_name, SUM(o.amount) AS total_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- 8. Select from View
SELECT * FROM customer_sales;

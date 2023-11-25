-- Create a database for your project
CREATE DATABASE bookstore;

-- Use the created database
USE bookstore;

-- Define the authors table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

-- Define the books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    ISBN VARCHAR(13) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- Define the customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    address TEXT
);

-- Define the orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Define the order_details table
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Define the inventory table
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);


-- Insert sample authors into the authors table
INSERT INTO authors (author_name) VALUES
    ('Author 1'),
    ('Author 2'),
    ('Author 3');

-- Insert sample books into the books table
INSERT INTO books (title, author_id, ISBN, price, quantity) VALUES
    ('Book 1', 1, 'ISBN001', 19.99, 50),
    ('Book 2', 2, 'ISBN002', 24.99, 30),
    ('Book 3', 1, 'ISBN003', 14.99, 70),
    ('Book 4', 3, 'ISBN004', 29.99, 40);

-- Insert sample customers into the customers table
INSERT INTO customers (name, email, address) VALUES
    ('Customer 1', 'customer1@example.com', '123 Main St, City A'),
    ('Customer 2', 'customer2@example.com', '456 Elm St, City B'),
    ('Customer 3', 'customer3@example.com', '789 Oak St, City C');

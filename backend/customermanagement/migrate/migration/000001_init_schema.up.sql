CREATE TABLE Customer (
  id integer generated always as identity,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255),
  email VARCHAR(255) UNIQUE NOT NULL,
  phone_number VARCHAR(255),
  address VARCHAR(255)
);

-- User 1
INSERT INTO Customer (first_name, last_name, email, phone_number, address)
VALUES ('John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St');

-- User 2
INSERT INTO Customer (first_name, last_name, email, phone_number, address)
VALUES ('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Oak Ave');

-- User 3
INSERT INTO Customer (first_name, last_name, email, phone_number, address)
VALUES ('Alice', 'Johnson', 'alice.j@example.com', '555-123-4567', '789 Elm St');

-- User 4
INSERT INTO Customer (first_name, last_name, email, phone_number, address)
VALUES ('Bob', 'Anderson', 'bob.anderson@example.com', '444-555-7890', '101 Pine Rd');

-- User 5
INSERT INTO Customer (first_name, last_name, email, phone_number, address)
VALUES ('Emily', 'Davis', 'emily.davis@example.com', '123-789-4560', '202 Cedar Ave');
 
INSERT INTO Customer (first_name, last_name, email, phone_number, address)
VALUES ('Chris', 'Roberts', 'chris.rob@example.com', '999-888-7777', '303 Birch Ln');

-- User 7
INSERT INTO Customer (first_name, last_name, email, phone_number, address)
VALUES ('Sophie', 'Taylor', 'sophie.t@example.com', '777-666-5555', '404 Maple St');

-- User 8
INSERT INTO Customer (first_name, last_name, email, phone_number, address)
VALUES ('David', 'Brown', 'david.b@example.com', '222-333-4444', '505 Walnut Rd');

-- User 9
INSERT INTO Customer (first_name, last_name, email, phone_number, address)
VALUES ('Olivia', 'White', 'olivia.white@example.com', '111-222-3333', '606 Pine Ave');

-- User 10
INSERT INTO Customer (first_name, last_name, email, phone_number, address)
VALUES ('Ryan', 'Miller', 'ryan.m@example.com', '888-999-0000', '707 Oak Ln');

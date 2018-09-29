DROP TABLE IF EXISTS rentals;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS cars;

CREATE TABLE cars(
  id SERIAL4 PRIMARY KEY,
  type VARCHAR(255),
  rental_cost INT4
);

CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  phone_number TEXT,
  wallet INT4
);

CREATE TABLE rentals(
  id SERIAL4 PRIMARY KEY,
  car_id INT4 REFERENCES cars(id) ON DELETE CASCADE,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
  review TEXT
);

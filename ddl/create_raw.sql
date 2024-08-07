CREATE OR REPLACE TABLE `MY_GCP_PROJECT.example_dataset_raw.sales` (
  sale_id STRING,
  product_id STRING,
  customer_id STRING,
  sale_date TIMESTAMP,
  sale_amount FLOAT64
);
INSERT INTO `MY_GCP_PROJECT.example_dataset_raw.sales` (sale_id, product_id, customer_id, sale_date, sale_amount) VALUES
('S001', 'P001', 'C001', TIMESTAMP('2024-08-01 10:00:00'), 100.00),
('S002', 'P002', 'C002', TIMESTAMP('2024-08-01 11:00:00'), 150.00),
('S003', 'P001', 'C003', TIMESTAMP('2024-08-02 09:00:00'), 200.00),
('S004', 'P003', 'C001', TIMESTAMP('2024-08-02 14:00:00'), 250.00),
('S005', 'P004', 'C004', TIMESTAMP('2024-08-03 08:00:00'), 300.00),
('S006', 'P002', 'C002', TIMESTAMP('2024-08-03 16:00:00'), 175.00),
('S007', 'P003', 'C003', TIMESTAMP('2024-08-04 10:00:00'), 220.00),
('S008', 'P004', 'C005', TIMESTAMP('2024-08-05 11:00:00'), 320.00),
('S009', 'P001', 'C006', TIMESTAMP('2024-08-06 12:00:00'), 180.00),
('S010', 'P002', 'C007', TIMESTAMP('2024-08-07 09:00:00'), 210.00);
CREATE OR REPLACE TABLE `MY_GCP_PROJECT.example_dataset_raw.products` (
  product_id STRING,
  product_name STRING
);
INSERT INTO `MY_GCP_PROJECT.example_dataset_raw.products` (product_id, product_name) VALUES
('P001', 'Product A'),
('P002', 'Product B'),
('P003', 'Product C'),
('P004', 'Product D');
CREATE OR REPLACE TABLE `MY_GCP_PROJECT.example_dataset_raw.customers` (
  customer_id STRING,
  customer_name STRING
);
INSERT INTO `MY_GCP_PROJECT.example_dataset_raw.customers` (customer_id, customer_name) VALUES
('C001', 'Alice Smith'),
('C002', 'Bob Johnson'),
('C003', 'Charlie Brown'),
('C004', 'Diana Prince'),
('C005', 'Ethan Hunt'),
('C006', 'Fiona Glenanne'),
('C007', 'George Clooney');

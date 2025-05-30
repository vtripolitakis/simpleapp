create schema api;

SET search_path TO api, public;

-- Create employees table
CREATE TABLE api.employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    manager_id INTEGER REFERENCES employees(id)
);

-- Insert 10 employee records
INSERT INTO api.employees (first_name, last_name, email, phone, hire_date, job_title, department, salary, manager_id) VALUES
('John', 'Smith', 'john.smith@company.com', '+1-555-0101', '2020-01-15', 'CEO', 'Executive', 150000.00, NULL),
('Sarah', 'Johnson', 'sarah.johnson@company.com', '+1-555-0102', '2020-03-01', 'CTO', 'Technology', 130000.00, 1),
('Michael', 'Brown', 'michael.brown@company.com', '+1-555-0103', '2021-06-15', 'Senior Developer', 'Technology', 95000.00, 2),
('Emily', 'Davis', 'emily.davis@company.com', '+1-555-0104', '2021-08-20', 'Marketing Manager', 'Marketing', 75000.00, 1),
('David', 'Wilson', 'david.wilson@company.com', '+1-555-0105', '2022-01-10', 'Software Engineer', 'Technology', 80000.00, 2),
('Lisa', 'Anderson', 'lisa.anderson@company.com', '+1-555-0106', '2022-03-15', 'HR Manager', 'Human Resources', 70000.00, 1),
('James', 'Taylor', 'james.taylor@company.com', '+1-555-0107', '2022-07-01', 'Sales Representative', 'Sales', 55000.00, 1),
('Maria', 'Garcia', 'maria.garcia@company.com', '+1-555-0108', '2023-02-14', 'Accountant', 'Finance', 60000.00, 1),
('Robert', 'Martinez', 'robert.martinez@company.com', '+1-555-0109', '2023-05-20', 'Junior Developer', 'Technology', 65000.00, 3),
('Jennifer', 'Lee', 'jennifer.lee@company.com', '+1-555-0110', '2023-09-10', 'UX Designer', 'Design', 72000.00, 2);


create role web_anon nologin;

grant usage on schema api to web_anon;
grant select on api.employees to web_anon;

create role authenticator noinherit login password 'mysecretpassword';
grant web_anon to authenticator;
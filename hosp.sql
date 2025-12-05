use dbms;

-- Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender VARCHAR(10),
    phone VARCHAR(15),
    email VARCHAR(100),
    address TEXT
);

-- Departments Table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100)
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialization VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_time TIME,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Medical Records Table
CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    diagnosis TEXT,
    treatment TEXT,
    visit_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Prescriptions Table
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    record_id INT,
    medicine_name VARCHAR(100),
    dosage VARCHAR(50),
    duration VARCHAR(50),
    FOREIGN KEY (record_id) REFERENCES Medical_Records(record_id)
);

INSERT INTO Departments (department_name) VALUES
('Cardiology'),
('Neurology'),
('Orthopedics'),
('General Medicine');

INSERT INTO Doctors (first_name, last_name, specialization, phone, email, department_id) VALUES
('Amit', 'Sharma', 'Cardiologist', '9876543210', 'amit@hospital.com', 1),
('Neha', 'Verma', 'Neurologist', '9876500000', 'neha@hospital.com', 2),
('Raj', 'Patel', 'Orthopedic', '9876511111', 'raj@hospital.com', 3),
('Priya', 'Nair', 'General Physician', '9876522222', 'priya@hospital.com', 4);

INSERT INTO Patients (first_name, last_name, dob, gender, phone, email, address) VALUES
('Rohan', 'Mehta', '1995-04-12', 'Male', '9123456789', 'rohan@example.com', 'Bangalore'),
('Sneha', 'Kumar', '2000-07-25', 'Female', '9234567890', 'sneha@example.com', 'Mumbai'),
('Arjun', 'Reddy', '1988-01-10', 'Male', '9345678901', 'arjun@example.com', 'Hyderabad');

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status) VALUES
(1, 1, '2025-09-05', '10:30:00', 'Scheduled'),
(2, 2, '2025-09-02', '11:00:00', 'Completed'),
(3, 4, '2025-09-01', '15:00:00', 'Completed');

DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Medical_Records;

CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT,
    diagnosis TEXT,
    treatment TEXT,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    record_id INT,
    medicine_name VARCHAR(100),
    dosage VARCHAR(50),
    duration VARCHAR(50),
    FOREIGN KEY (record_id) REFERENCES Medical_Records(record_id)
);

INSERT INTO Medical_Records (appointment_id, diagnosis, treatment, notes) VALUES
(2, 'Migraine', 'Prescribed painkillers', 'Patient advised rest'),
(3, 'Fever', 'Paracetamol 500mg', 'Monitor temperature daily');

INSERT INTO Prescriptions (record_id, medicine_name, dosage, duration) VALUES
(1, 'Sumatriptan', '50mg', '5 days'),
(1, 'Ibuprofen', '200mg', '7 days'),
(2, 'Paracetamol', '500mg', '3 days'),
(2, 'ORS Solution', '200ml', '5 days');


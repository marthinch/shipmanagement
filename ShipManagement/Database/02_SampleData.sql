USE ShipManagement;
GO

-- =========================
-- Ships
-- =========================
INSERT INTO Ships
(
    Code,
    Name,
    FiscalYear,
    Status,
    CreatedDateTime,
    CreatedBy
)
VALUES
('SEA01', 'MV Ocean Pioneer', '0106', 1, '2026-01-05 08:00:00', 'admin'),
('SEA02', 'MV Nordic Star', '0112', 1, '2026-01-05 08:05:00', 'admin'),
('SEA03', 'MV Pacific Dawn', '0612', 0, '2026-06-10 09:00:00', 'admin');


-- =========================
-- Crews
-- =========================
INSERT INTO Crews
(
    MemberId,
    Rank,
    FirstName,
    LastName,
    BirthDate,
    Nationality,
    CreatedDateTime,
    CreatedBy
)
VALUES
('CRW0001', 'Captain', 'Andreas', 'Lindberg', '1978-04-12', 'Swedish', '2026-01-06 08:00:00', 'admin'),
('CRW0002', 'Chief Engineer', 'Michael', 'Tan', '1982-09-21', 'Singaporean', '2026-01-06 08:05:00', 'admin'),
('CRW0003', 'Chief Officer', 'Daniel', 'Wijaya', '1985-02-15', 'Indonesian', '2026-01-06 08:10:00', 'admin'),
('CRW0004', 'Second Officer', 'Rizky', 'Pratama', '1991-07-08', 'Indonesian', '2026-01-06 08:15:00', 'admin'),
('CRW0005', 'Second Engineer', 'James', 'Anderson', '1988-11-30', 'British', '2026-01-06 08:20:00', 'admin'),
('CRW0006', 'Third Engineer', 'Arif', 'Setiawan', '1993-03-18', 'Indonesian', '2026-01-06 08:25:00', 'admin'),
('CRW0007', 'Bosun', 'Budi', 'Santoso', '1989-06-25', 'Indonesian', '2026-01-06 08:30:00', 'admin'),
('CRW0008', 'Able Seaman', 'Carlos', 'Reyes', '1995-12-02', 'Filipino', '2026-01-06 08:35:00', 'admin');


-- =========================
-- Users
-- =========================
INSERT INTO Users
(
    Name,
    Role,
    CreatedDateTime,
    CreatedBy
)
VALUES
('Andreas Lindberg', 'Employee', '2026-01-01 08:35:00', 'admin'),
('Michael Tan', 'Employee','2026-01-01 08:35:00', 'admin')


-- =========================
-- ShipUsers
-- =========================
INSERT INTO ShipUsers
(
    ShipId,
    UserId
)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 1);


-- =========================
-- ShipCrews
-- =========================
INSERT INTO ShipCrews
(
    ShipId,
    CrewId
)
VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 1),
(3, 7),
(3, 8);


-- =========================
-- Services
-- =========================
INSERT INTO Services
(
    CrewId,
    MemberId,
    Rank,
    ShipId,
    ShipCode,
    SignOnDate,
    SignOffDate,
    EndOfContractDate,
    CreatedDateTime,
    CreatedBy
)
VALUES
(1, 'CRW0001', 'Captain', 1, 'SEA01', '2026-01-15', NULL, '2026-12-31', '2026-01-15 08:00:00', 'admin'),
(2, 'CRW0002', 'Chief Engineer', 1, 'SEA01', '2026-02-01', NULL, '2026-11-30', '2026-02-01 08:00:00', 'admin'),
(3, 'CRW0003', 'Chief Officer', 1, 'SEA01', '2026-01-20', NULL, '2026-10-31', '2026-01-20 08:00:00', 'admin'),
(4, 'CRW0004', 'Second Officer', 1, 'SEA01', '2026-03-01', NULL, '2026-09-30', '2026-03-01 08:00:00', 'admin'),
(5, 'CRW0005', 'Second Engineer', 2, 'SEA02', '2026-01-10', NULL, '2026-12-31', '2026-01-10 08:00:00', 'admin'),
(6, 'CRW0006', 'Third Engineer', 2, 'SEA02', '2026-02-15', NULL, '2026-11-30', '2026-02-15 08:00:00', 'admin'),
(7, 'CRW0007', 'Bosun', 2, 'SEA02', '2026-01-25', NULL, '2026-10-31', '2026-01-25 08:00:00', 'admin'),
(8, 'CRW0008', 'Able Seaman', 3, 'SEA03', '2025-02-01', '2025-11-30', '2025-12-31', '2025-02-01 08:00:00', 'admin');


-- =========================
-- Accounts
-- =========================
INSERT INTO Accounts
(
    Number,
    ParentId,
    Description,
    CreatedDateTime,
    CreatedBy
)
VALUES
-- Parents Account
('60000000', NULL, 'Operating Revenue', '2026-01-01 08:15:00', 'admin'),
('70000000', NULL, 'Operating Expenses', '2026-01-01 08:00:00', 'admin'),
('80000000', NULL, 'Crew Expenses', '2026-01-01 08:05:00', 'admin'),
('90000000', NULL, 'Maintenance Expenses', '2026-01-01 08:10:00', 'admin'),

-- Revenue
('61000000', 4, 'Freight Revenue', '2026-01-01 08:29:00', 'admin'),
('62000000', 4, 'Charter Revenue', '2026-01-01 08:30:00', 'admin'),

-- Operating Expenses
('71000000', 1, 'Awards and Grants to Individuals', '2026-01-01 08:20:00', 'admin'),
('72000000', 1, 'Fuel and Lubricants', '2026-01-01 08:21:00', 'admin'),
('73000000', 1, 'Food and Provisions', '2026-01-01 08:22:00', 'admin'),

-- Crew Expenses
('81000000', 2, 'Crew Salaries', '2026-01-01 08:23:00', 'admin'),
('82000000', 2, 'Crew Travel', '2026-01-01 08:24:00', 'admin'),
('83000000', 2, 'Crew Training', '2026-01-01 08:25:00', 'admin'),

-- Maintenance
('91000000', 3, 'Engine Maintenance', '2026-01-01 08:26:00', 'admin'),
('92000000', 3, 'Hull Maintenance', '2026-01-01 08:27:00', 'admin'),
('93000000', 3, 'Safety Equipment', '2026-01-01 08:28:00', 'admin');

-- =========================
-- Budgets
-- =========================
-- SEA01 - January 2026
INSERT INTO Budgets
(
    ShipId,
    ShipCode,
    AccountId,
    AccountNumber,
    AccountPeriod,
    Amount,
    CreatedDateTime,
    CreatedBy
)
VALUES
(1, 'SEA01', 6,  '72000000', '2026-01', 45000.00, '2026-01-01 09:00:00', 'finance'),
(1, 'SEA01', 7,  '73000000', '2026-01', 18000.00, '2026-01-01 09:00:00', 'finance'),
(1, 'SEA01', 8,  '81000000', '2026-01', 85000.00, '2026-01-01 09:00:00', 'finance'),
(1, 'SEA01', 11, '91000000', '2026-01', 30000.00, '2026-01-01 09:00:00', 'finance'),
(1, 'SEA01', 13, '93000000', '2026-01', 12000.00, '2026-01-01 09:00:00', 'finance'),

-- SEA01 - February 2026
(1, 'SEA01', 6,  '72000000', '2026-02', 47000.00, '2026-01-20 09:00:00', 'finance'),
(1, 'SEA01', 7,  '73000000', '2026-02', 18000.00, '2026-01-20 09:00:00', 'finance'),
(1, 'SEA01', 8,  '81000000', '2026-02', 85000.00, '2026-01-20 09:00:00', 'finance'),
(1, 'SEA01', 11, '91000000', '2026-02', 25000.00, '2026-01-20 09:00:00', 'finance'),

-- SEA02 - January 2026
(2, 'SEA02', 6,  '72000000', '2026-01', 42000.00, '2026-01-01 09:30:00', 'finance'),
(2, 'SEA02', 7,  '73000000', '2026-01', 16000.00, '2026-01-01 09:30:00', 'finance'),
(2, 'SEA02', 8,  '81000000', '2026-01', 78000.00, '2026-01-01 09:30:00', 'finance'),
(2, 'SEA02', 11, '91000000', '2026-01', 28000.00, '2026-01-01 09:30:00', 'finance'),

-- SEA03 - Historical 2025 budget
(3, 'SEA03', 6, '72000000', '2025-11', 40000.00, '2025-10-25 09:00:00', 'finance'),
(3, 'SEA03', 8, '81000000', '2025-11', 75000.00, '2025-10-25 09:00:00', 'finance'),
(3, 'SEA03', 11, '91000000', '2025-11', 22000.00, '2025-10-25 09:00:00', 'finance');


-- =========================
-- Transactions
-- =========================
-- SEA01 - January actuals
INSERT INTO Transactions
(
    ShipId,
    ShipCode,
    AccountId,
    AccountNumber,
    AccountPeriod,
    Amount,
    CreatedDateTime,
    CreatedBy
)
VALUES
-- Fuel
(1, 'SEA01', 6, '72000000', '2026-01', 12500.00, '2026-01-05 10:15:00', 'finance'),
(1, 'SEA01', 6, '72000000', '2026-01', 15800.00, '2026-01-14 11:20:00', 'finance'),
(1, 'SEA01', 6, '72000000', '2026-01', 11200.00, '2026-01-27 14:10:00', 'finance'),

-- Food
(1, 'SEA01', 7, '73000000', '2026-01', 9200.00, '2026-01-08 09:30:00', 'finance'),
(1, 'SEA01', 7, '73000000', '2026-01', 8700.00, '2026-01-22 09:15:00', 'finance'),

-- Crew salary
(1, 'SEA01', 8, '81000000', '2026-01', 85000.00, '2026-01-31 16:00:00', 'finance'),

-- Engine maintenance
(1, 'SEA01', 11, '91000000', '2026-01', 18500.00, '2026-01-12 13:00:00', 'finance'),
(1, 'SEA01', 11, '91000000', '2026-01', 9500.00, '2026-01-26 15:30:00', 'finance'),

-- Safety equipment
(1, 'SEA01', 13, '93000000', '2026-01', 7500.00, '2026-01-18 10:00:00', 'finance'),

-- ============================================================
-- SEA01 - February actuals
-- ============================================================
(1, 'SEA01', 6, '72000000', '2026-02', 22000.00, '2026-02-07 10:00:00', 'finance'),
(1, 'SEA01', 6, '72000000', '2026-02', 18000.00, '2026-02-19 10:30:00', 'finance'),
(1, 'SEA01', 7, '73000000', '2026-02', 9500.00, '2026-02-10 09:00:00', 'finance'),
(1, 'SEA01', 7, '73000000', '2026-02', 9100.00, '2026-02-24 09:30:00', 'finance'),
(1, 'SEA01', 8, '81000000', '2026-02', 85000.00, '2026-02-28 16:00:00', 'finance'),

-- Maintenance exceeds budget intentionally
(1, 'SEA01', 11, '91000000', '2026-02', 18000.00, '2026-02-05 13:30:00', 'finance'),
(1, 'SEA01', 11, '91000000', '2026-02', 12500.00, '2026-02-20 14:00:00', 'finance'),

-- ============================================================
-- SEA02 - January actuals
-- ============================================================
(2, 'SEA02', 6, '72000000', '2026-01', 14500.00, '2026-01-06 10:00:00', 'finance'),
(2, 'SEA02', 6, '72000000', '2026-01', 13200.00, '2026-01-17 11:00:00', 'finance'),
(2, 'SEA02', 6, '72000000', '2026-01', 12100.00, '2026-01-28 10:45:00', 'finance'),
(2, 'SEA02', 7, '73000000', '2026-01', 7800.00, '2026-01-09 09:00:00', 'finance'),
(2, 'SEA02', 7, '73000000', '2026-01', 7500.00, '2026-01-23 09:30:00', 'finance'),
(2, 'SEA02', 8, '81000000', '2026-01', 78000.00, '2026-01-31 16:30:00', 'finance'),
(2, 'SEA02', 11, '91000000', '2026-01', 12000.00, '2026-01-11 14:00:00', 'finance'),
(2, 'SEA02', 11, '91000000', '2026-01', 8500.00, '2026-01-25 15:00:00', 'finance'),

-- SEA01 freight revenue
(1, 'SEA01', 14, '61000000', '2026-01', 250000.00, '2026-01-15 17:00:00', 'finance'),
(1, 'SEA01', 14, '61000000', '2026-01', 185000.00, '2026-01-29 17:30:00', 'finance'),

-- SEA02 freight revenue
(2, 'SEA02', 14, '61000000', '2026-01', 210000.00, '2026-01-18 17:00:00', 'finance'),
(2, 'SEA02', 14, '61000000', '2026-01', 195000.00, '2026-01-30 17:30:00', 'finance');
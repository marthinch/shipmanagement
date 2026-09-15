USE ShipManagement;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

DECLARE @Now DATETIME2 = SYSDATETIME();
DECLARE @CreatedBy NVARCHAR(100) = N'SEED';

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
('SEA01', N'MV Ocean Pioneer',     '0112', 1, @Now, @CreatedBy),
('SEA02', N'MV Pacific Horizon',   '0403', 1, @Now, @CreatedBy),
('SEA03', N'MV Nordic Star',       '0112', 1, @Now, @CreatedBy),
('SEA04', N'MV Southern Cross',    '0403', 0, @Now, @CreatedBy),
('SEA05', N'MV Eastern Voyager',   '0112', 0, @Now, @CreatedBy);


-- =========================
-- Crews
-- =========================
DECLARE @CrewSeed TABLE
(
    RowNo INT,
    MemberId CHAR(7),
    Rank NVARCHAR(100),
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    BirthDate DATETIME2,
    Nationality NVARCHAR(100),
    ShipCode CHAR(5)
);

INSERT INTO @CrewSeed
VALUES
-- SEA01
(1,'CR00001',N'Captain',          N'John',    N'Anderson','1978-02-14',N'British','SEA01'),
(2,'CR00002',N'Chief Officer',    N'Michael', N'Brown',   '1982-06-21',N'British','SEA01'),
(3,'CR00003',N'Chief Engineer',   N'Daniel',  N'Clark',   '1979-09-03',N'Filipino','SEA01'),
(4,'CR00004',N'Second Officer',   N'Peter',   N'Evans',   '1987-01-17',N'Filipino','SEA01'),
(5,'CR00005',N'Second Engineer',  N'Robert',  N'Garcia',  '1986-03-28',N'Indonesian','SEA01'),
(6,'CR00006',N'Third Officer',    N'Andrew',  N'Harris',  '1990-05-09',N'Indonesian','SEA01'),
(7,'CR00007',N'Third Engineer',   N'Kevin',   N'Miller',  '1991-11-12',N'Filipino','SEA01'),
(8,'CR00008',N'Fourth Engineer',  N'Brian',   N'Davis',   '1993-04-19',N'Indonesian','SEA01'),
(9,'CR00009',N'Bosun',             N'George',  N'Wilson',  '1985-07-07',N'Indonesian','SEA01'),
(10,'CR00010',N'AB Seaman',        N'James',   N'Moore',   '1994-08-15',N'Filipino','SEA01'),
(11,'CR00011',N'AB Seaman',        N'William', N'Taylor',  '1992-12-11',N'Filipino','SEA01'),
(12,'CR00012',N'OS Seaman',        N'Joseph',  N'Lee',     '1998-03-02',N'Indonesian','SEA01'),
(13,'CR00013',N'Oiler',            N'Thomas',  N'Walker',  '1995-10-26',N'Indonesian','SEA01'),
(14,'CR00014',N'Fitter',           N'Charles', N'Hall',    '1991-06-18',N'Filipino','SEA01'),
(15,'CR00015',N'Cook',             N'Edward',  N'Allen',   '1988-09-25',N'Indonesian','SEA01'),
(16,'CR00016',N'Steward',          N'Frank',   N'Young',   '1996-01-08',N'Filipino','SEA01'),
(17,'CR00017',N'Electrician',      N'Henry',   N'King',    '1989-02-23',N'Indonesian','SEA01'),
(18,'CR00018',N'AB Seaman',        N'Richard', N'Wright',  '1993-05-30',N'Filipino','SEA01'),
(19,'CR00019',N'Oiler',            N'Edward',  N'Scott',   '1997-07-14',N'Indonesian','SEA01'),
(20,'CR00020',N'OS Seaman',        N'Samuel',  N'Green',   '1999-11-05',N'Filipino','SEA01'),

-- SEA02
(21,'CR00021',N'Captain',          N'William', N'Bennett', '1977-01-15',N'British','SEA02'),
(22,'CR00022',N'Chief Officer',    N'Christopher',N'Adams','1981-04-11',N'British','SEA02'),
(23,'CR00023',N'Chief Engineer',   N'Mark',    N'Nelson',  '1979-08-20',N'Filipino','SEA02'),
(24,'CR00024',N'Second Officer',   N'Anthony', N'Carter',   '1988-02-16',N'Filipino','SEA02'),
(25,'CR00025',N'Second Engineer',  N'Steven',  N'Mitchell', '1986-09-09',N'Indonesian','SEA02'),
(26,'CR00026',N'Third Officer',    N'Joshua',  N'Perez',    '1991-03-14',N'Indonesian','SEA02'),
(27,'CR00027',N'Third Engineer',   N'Ryan',    N'Roberts',  '1992-05-22',N'Filipino','SEA02'),
(28,'CR00028',N'Fourth Engineer',  N'Gary',    N'Turner',   '1994-07-31',N'Indonesian','SEA02'),
(29,'CR00029',N'Bosun',             N'Paul',    N'Phillips', '1985-11-10',N'Indonesian','SEA02'),
(30,'CR00030',N'AB Seaman',        N'Jason',   N'Campbell', '1993-01-19',N'Filipino','SEA02'),
(31,'CR00031',N'AB Seaman',        N'Justin',  N'Parker',   '1994-06-06',N'Filipino','SEA02'),
(32,'CR00032',N'OS Seaman',        N'Brian',   N'Wright',   '1999-02-28',N'Indonesian','SEA02'),
(33,'CR00033',N'Oiler',            N'Adam',    N'Edwards',  '1996-04-18',N'Indonesian','SEA02'),
(34,'CR00034',N'Fitter',           N'Simon',   N'Collins',  '1990-08-12',N'Filipino','SEA02'),
(35,'CR00035',N'Cook',             N'Peter',   N'Stewart',  '1987-09-29',N'Indonesian','SEA02'),
(36,'CR00036',N'Steward',          N'Louis',   N'Sanchez',  '1995-12-03',N'Filipino','SEA02'),
(37,'CR00037',N'Electrician',      N'Patrick', N'Morris',   '1989-05-05',N'Indonesian','SEA02'),
(38,'CR00038',N'AB Seaman',        N'Jonathan',N'Rogers',   '1992-10-21',N'Filipino','SEA02'),
(39,'CR00039',N'Oiler',            N'Scott',   N'Reed',     '1996-07-17',N'Indonesian','SEA02'),
(40,'CR00040',N'OS Seaman',        N'Oliver',  N'Cook',     '2000-03-13',N'Filipino','SEA02'),

-- SEA03
(41,'CR00041',N'Captain',          N'George',  N'Morgan',   '1976-02-19',N'British','SEA03'),
(42,'CR00042',N'Chief Officer',    N'Arthur',  N'Bell',     '1980-06-15',N'British','SEA03'),
(43,'CR00043',N'Chief Engineer',   N'Edward',  N'Murphy',   '1978-10-12',N'Filipino','SEA03'),
(44,'CR00044',N'Second Officer',   N'Frank',   N'Bailey',   '1987-01-22',N'Filipino','SEA03'),
(45,'CR00045',N'Second Engineer',  N'Gregory', N'Rivera',   '1985-04-17',N'Indonesian','SEA03'),
(46,'CR00046',N'Third Officer',    N'Bruce',   N'Cooper',   '1990-08-23',N'Indonesian','SEA03'),
(47,'CR00047',N'Third Engineer',   N'Eric',    N'Richardson','1992-02-14',N'Filipino','SEA03'),
(48,'CR00048',N'Fourth Engineer',  N'Carl',    N'Cox',      '1994-11-03',N'Indonesian','SEA03'),
(49,'CR00049',N'Bosun',             N'Raymond', N'Howard',   '1984-05-28',N'Indonesian','SEA03'),
(50,'CR00050',N'AB Seaman',        N'Kenneth', N'Ward',     '1993-09-18',N'Filipino','SEA03'),
(51,'CR00051',N'AB Seaman',        N'Ronald',  N'Torres',   '1992-07-07',N'Filipino','SEA03'),
(52,'CR00052',N'OS Seaman',        N'Jason',   N'Peterson', '1999-01-31',N'Indonesian','SEA03'),
(53,'CR00053',N'Oiler',            N'Dennis',  N'Gray',     '1995-03-25',N'Indonesian','SEA03'),
(54,'CR00054',N'Fitter',           N'Jeffrey', N'Ramirez',  '1990-12-09',N'Filipino','SEA03'),
(55,'CR00055',N'Cook',             N'Harold',  N'James',    '1988-06-27',N'Indonesian','SEA03'),
(56,'CR00056',N'Steward',          N'Peter',   N'Watson',   '1996-04-05',N'Filipino','SEA03'),
(57,'CR00057',N'Electrician',      N'Roger',   N'Brooks',   '1989-08-14',N'Indonesian','SEA03'),
(58,'CR00058',N'AB Seaman',        N'Keith',   N'Kelly',    '1993-02-20',N'Filipino','SEA03'),
(59,'CR00059',N'Oiler',            N'Lawrence',N'Sanders',  '1997-09-13',N'Indonesian','SEA03'),
(60,'CR00060',N'OS Seaman',        N'Benjamin',N'Price',    '2000-05-06',N'Filipino','SEA03'),

-- SEA04
(61,'CR00061',N'Captain',          N'Charles', N'Baker',    '1975-03-17',N'British','SEA04'),
(62,'CR00062',N'Chief Officer',    N'Patrick', N'Wood',     '1981-08-11',N'British','SEA04'),
(63,'CR00063',N'Chief Engineer',   N'Andrew',  N'Barnes',   '1979-02-22',N'Filipino','SEA04'),
(64,'CR00064',N'Second Officer',   N'Matthew', N'Ross',     '1988-07-19',N'Filipino','SEA04'),
(65,'CR00065',N'Second Engineer',  N'Joshua',  N'Henderson', '1986-01-08',N'Indonesian','SEA04'),
(66,'CR00066',N'Third Officer',    N'Brian',   N'Coleman',  '1991-04-23',N'Indonesian','SEA04'),
(67,'CR00067',N'Third Engineer',   N'Nicholas',N'Jenkins',  '1992-06-18',N'Filipino','SEA04'),
(68,'CR00068',N'Fourth Engineer',  N'Adam',    N'Perry',    '1994-09-02',N'Indonesian','SEA04'),
(69,'CR00069',N'Bosun',             N'Walter',  N'Powell',   '1984-10-25',N'Indonesian','SEA04'),
(70,'CR00070',N'AB Seaman',        N'Kyle',    N'Long',     '1993-12-16',N'Filipino','SEA04'),
(71,'CR00071',N'AB Seaman',        N'Justin',  N'Patterson', '1992-05-09',N'Filipino','SEA04'),
(72,'CR00072',N'OS Seaman',        N'Brandon', N'Hughes',   '1999-08-21',N'Indonesian','SEA04'),
(73,'CR00073',N'Oiler',            N'Alex',    N'Flores',   '1996-02-11',N'Indonesian','SEA04'),
(74,'CR00074',N'Fitter',           N'Jonathan',N'Washington','1990-03-27',N'Filipino','SEA04'),
(75,'CR00075',N'Cook',             N'Stephen', N'Butler',   '1987-07-14',N'Indonesian','SEA04'),
(76,'CR00076',N'Steward',          N'Connor',  N'Simmons',  '1995-11-03',N'Filipino','SEA04'),
(77,'CR00077',N'Electrician',      N'Ryan',    N'Foster',   '1989-01-26',N'Indonesian','SEA04'),
(78,'CR00078',N'AB Seaman',        N'Jordan',  N'Gonzales', '1993-06-15',N'Filipino','SEA04'),
(79,'CR00079',N'Oiler',            N'Tyler',   N'Bryant',   '1997-04-10',N'Indonesian','SEA04'),
(80,'CR00080',N'OS Seaman',        N'Zachary', N'Alexander','2000-09-12',N'Filipino','SEA04'),

-- SEA05
(81,'CR00081',N'Captain',          N'Richard', N'Russell',  '1977-06-11',N'British','SEA05'),
(82,'CR00082',N'Chief Officer',    N'Robert',  N'Griffin',  '1980-02-15',N'British','SEA05'),
(83,'CR00083',N'Chief Engineer',   N'James',   N'Diaz',     '1978-11-19',N'Filipino','SEA05'),
(84,'CR00084',N'Second Officer',   N'Edward',  N'Hayes',    '1988-05-22',N'Filipino','SEA05'),
(85,'CR00085',N'Second Engineer',  N'David',   N'Myers',    '1986-08-14',N'Indonesian','SEA05'),
(86,'CR00086',N'Third Officer',    N'William', N'Ford',     '1990-01-17',N'Indonesian','SEA05'),
(87,'CR00087',N'Third Engineer',   N'Joseph',  N'Hamilton', '1992-03-26',N'Filipino','SEA05'),
(88,'CR00088',N'Fourth Engineer',  N'Samuel', N'Graham',   '1994-07-12',N'Indonesian','SEA05'),
(89,'CR00089',N'Bosun',             N'Benjamin',N'Sullivan', '1985-10-05',N'Indonesian','SEA05'),
(90,'CR00090',N'AB Seaman',        N'Nicholas',N'Wallace',  '1993-02-14',N'Filipino','SEA05'),
(91,'CR00091',N'AB Seaman',        N'Christopher',N'Woods', '1992-06-18',N'Filipino','SEA05'),
(92,'CR00092',N'OS Seaman',        N'Jacob',   N'Cole',     '1999-09-21',N'Indonesian','SEA05'),
(93,'CR00093',N'Oiler',            N'Dylan',   N'West',     '1996-12-08',N'Indonesian','SEA05'),
(94,'CR00094',N'Fitter',           N'Patrick', N'Jordan',   '1990-04-16',N'Filipino','SEA05'),
(95,'CR00095',N'Cook',             N'Frank',   N'Owens',    '1988-11-27',N'Indonesian','SEA05'),
(96,'CR00096',N'Steward',          N'Andrew',  N'Reynolds', '1995-03-10',N'Filipino','SEA05'),
(97,'CR00097',N'Electrician',      N'Charles', N'Fisher',   '1989-07-29',N'Indonesian','SEA05'),
(98,'CR00098',N'AB Seaman',        N'Kevin',   N'Ellis',    '1993-10-04',N'Filipino','SEA05'),
(99,'CR00099',N'Oiler',            N'Jason',   N'Harrison', '1997-01-22',N'Indonesian','SEA05'),
(100,'CR00100',N'OS Seaman',       N'Noah',    N'Gibson',   '2000-06-13',N'Filipino','SEA05');

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
SELECT
    MemberId,
    Rank,
    FirstName,
    LastName,
    BirthDate,
    Nationality,
    @Now,
    @CreatedBy
FROM @CrewSeed;


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
(N'Alice Johnson', N'ADMIN', @Now, @CreatedBy),
(N'Robert Tan', N'MANAGER', @Now, @CreatedBy),
(N'James Wilson', N'USER', @Now, @CreatedBy),
(N'Sarah Lim', N'USER', @Now, @CreatedBy),
(N'David Chen', N'USER', @Now, @CreatedBy);


-- =========================
-- ShipUsers
-- =========================
INSERT INTO ShipUsers (ShipId, UserId)
SELECT s.Id, u.Id
FROM Ships s
CROSS JOIN Users u
WHERE (s.Code = 'SEA01' AND u.Name IN (N'Alice Johnson', N'James Wilson'))
 OR (s.Code = 'SEA02' AND u.Name IN (N'Robert Tan', N'Sarah Lim'))
 OR (s.Code = 'SEA03' AND u.Name IN (N'Alice Johnson', N'David Chen'))
 OR (s.Code = 'SEA04' AND u.Name IN (N'Robert Tan'))
 OR (s.Code = 'SEA05' AND u.Name IN (N'Sarah Lim'));


-- =========================
-- ShipCrews
-- =========================
INSERT INTO ShipCrews (ShipId, CrewId)
SELECT
    s.Id,
    c.Id
FROM @CrewSeed cs
JOIN Ships s ON s.Code = cs.ShipCode
JOIN Crews c ON c.MemberId = cs.MemberId;


-- =========================
-- Services

-- Multiple service records per crew.
-- Some have NULL SignOffDate = currently onboard.
-- Some completed contracts.
-- Some short assignments representing relief/sign-off.
-- ============================================================
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
SELECT
    c.Id,
    c.MemberId,
    c.Rank,
    s.Id,
    s.Code,
    CASE
        WHEN c.Id % 4 = 0 THEN '2024-01-15'
        WHEN c.Id % 4 = 1 THEN '2024-04-01'
        WHEN c.Id % 4 = 2 THEN '2024-07-01'
        ELSE '2024-10-01'
    END AS SignOnDate,

    CASE
        WHEN c.Id % 5 = 1 THEN NULL
        WHEN c.Id % 5 = 2 THEN '2025-03-15'
        WHEN c.Id % 5 = 3 THEN '2025-06-15'
        WHEN c.Id % 5 = 4 THEN '2025-09-15'
        ELSE '2024-12-15'
    END AS SignOffDate,

    CASE
        WHEN c.Id % 5 = 1 THEN '2025-12-31'
        WHEN c.Id % 5 = 2 THEN '2025-03-31'
        WHEN c.Id % 5 = 3 THEN '2025-06-30'
        WHEN c.Id % 5 = 4 THEN '2025-09-30'
        ELSE '2025-01-15'
    END AS EndOfContractDate,
    @Now,
    @CreatedBy
FROM Crews c
JOIN ShipCrews sc
    ON sc.CrewId = c.Id
JOIN Ships s
    ON s.Id = sc.ShipId;


-- Historical completed service
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
SELECT
    c.Id,
    c.MemberId,
    c.Rank,
    s.Id,
    s.Code,
    '2023-01-01',
    '2023-12-15',
    '2024-01-15',
    @Now,
    @CreatedBy
FROM Crews c
JOIN ShipCrews sc
    ON sc.CrewId = c.Id
JOIN Ships s
    ON s.Id = sc.ShipId
WHERE c.Id % 3 = 0;


-- =========================
-- Accounts
-- =========================
DECLARE @ParentAccounts TABLE
(
    ParentNumber CHAR(8),
    Description NVARCHAR(100)
);

INSERT INTO @ParentAccounts
VALUES
('70000000',N'Operating Expenses'),
('71000000',N'Crew Expenses'),
('72000000',N'Vessel Operations'),
('73000000',N'Maintenance Expenses'),
('74000000',N'Administrative Expenses');

INSERT INTO Accounts
(
    Number,
    ParentId,
    Description,
    CreatedDateTime,
    CreatedBy
)
SELECT
    ParentNumber,
    NULL,
    Description,
    @Now,
    @CreatedBy
FROM @ParentAccounts;


DECLARE @ChildAccounts TABLE
(
    ParentNumber CHAR(8),
    ChildNumber CHAR(8),
    Description NVARCHAR(100)
);

INSERT INTO @ChildAccounts
VALUES
-- 70000000
('70000000','70010000',N'Fuel Expense'),
('70000000','70020000',N'Lubricants'),
('70000000','70030000',N'Port Charges'),
('70000000','70040000',N'Insurance'),
('70000000','70050000',N'General Vessel Expense'),

-- 71000000
('71000000','71010000',N'Crew Wages'),
('71000000','71020000',N'Crew Travel'),
('71000000','71030000',N'Crew Training'),
('71000000','71040000',N'Medical Expenses'),
('71000000','71050000',N'Crew Accommodation'),

-- 72000000
('72000000','72010000',N'Provisions'),
('72000000','72020000',N'Fresh Water'),
('72000000','72030000',N'Communication'),
('72000000','72040000',N'Navigation'),
('72000000','72050000',N'Safety Equipment'),

-- 73000000
('73000000','73010000',N'Engine Maintenance'),
('73000000','73020000',N'Deck Maintenance'),
('73000000','73030000',N'Electrical Maintenance'),
('73000000','73040000',N'Drydocking'),
('73000000','73050000',N'Spare Parts'),

-- 74000000
('74000000','74010000',N'Office Expenses'),
('74000000','74020000',N'Professional Fees'),
('74000000','74030000',N'IT Services'),
('74000000','74040000',N'Telecommunication'),
('74000000','74050000',N'Bank Charges');

INSERT INTO Accounts
(
    Number,
    ParentId,
    Description,
    CreatedDateTime,
    CreatedBy
)
SELECT
    ca.ChildNumber,
    p.Id,
    ca.Description,
    @Now,
    @CreatedBy
FROM @ChildAccounts ca
JOIN Accounts p
    ON p.Number = ca.ParentNumber;


-- =========================
-- Budgets
-- =========================
DECLARE @BudgetShips TABLE
(
    ShipCode CHAR(5)
);

INSERT INTO @BudgetShips
VALUES
('SEA01'),
('SEA02'),
('SEA03');


DECLARE @BudgetAccounts TABLE
(
    AccountNumber CHAR(8),
    BaseAmount DECIMAL(18,2)
);

INSERT INTO @BudgetAccounts
VALUES
('70010000', 25000),
('70020000',  8000),
('71010000', 60000),
('71020000', 12000),
('71030000',  7000),
('72010000', 10000),
('72030000',  5000),
('73010000', 18000),
('73050000', 22000),
('74030000',  6000);

-- FY 0112 / FY 0403
-- AccountPeriod format: YYYY-MM
-- 24 rows per ship/account pair across 2024 and 2025
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
SELECT
    s.Id,
    s.Code,
    a.Id,
    a.Number,
    CONVERT(CHAR(7), d.PeriodDate, 120),
    CAST(
        ba.BaseAmount *
        CASE
            WHEN MONTH(d.PeriodDate) IN (1,7) THEN 1.15
            WHEN MONTH(d.PeriodDate) IN (6,12) THEN 1.10
            ELSE 1.00
        END *
        CASE
            WHEN YEAR(d.PeriodDate) = 2025 THEN 1.05
            ELSE 1.00
        END
        AS DECIMAL(18,2)
    ),
    @Now,
    @CreatedBy
FROM @BudgetShips bs
JOIN Ships s
    ON s.Code = bs.ShipCode
CROSS JOIN @BudgetAccounts ba
JOIN Accounts a
    ON a.Number = ba.AccountNumber
CROSS JOIN
(
    SELECT DATEADD(MONTH, n, '2024-01-01') AS PeriodDate
    FROM
    (
        SELECT TOP (24)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n
        FROM sys.objects
    ) x
) d;


-- =========================
-- Transactions
-- =========================
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
SELECT
    s.Id,
    s.Code,
    a.Id,
    a.Number,
    CONVERT(CHAR(7), d.PeriodDate, 120),
    CAST(
        ba.BaseAmount *
        CASE
            WHEN MONTH(d.PeriodDate) IN (2,5,8,11) THEN 0.92
            WHEN MONTH(d.PeriodDate) IN (3,9) THEN 1.08
            ELSE 1.00
        END *
        CASE
            WHEN YEAR(d.PeriodDate) = 2025 THEN 1.12
            ELSE 0.97
        END
        AS DECIMAL(18,2)
    ),
    @Now,
    @CreatedBy
FROM @BudgetShips bs
JOIN Ships s
    ON s.Code = bs.ShipCode
CROSS JOIN @BudgetAccounts ba
JOIN Accounts a
    ON a.Number = ba.AccountNumber
CROSS JOIN
(
    SELECT DATEADD(MONTH, n, '2024-01-01') AS PeriodDate
    FROM
    (
        SELECT TOP (18)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS n
        FROM sys.objects
    ) x
) d;

COMMIT TRANSACTION;
GO
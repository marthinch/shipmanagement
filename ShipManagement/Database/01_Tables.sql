USE ShipManagement;
GO

-- =========================
-- Ships
-- =========================
CREATE TABLE Ships
(
    Id INT IDENTITY(1,1) PRIMARY KEY,

    Code CHAR(5) NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    FiscalYear CHAR(4) NOT NULL,
    Status BIT NOT NULL,

    CreatedDateTime DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(100) NOT NULL,
    ModifiedDateTime DATETIME2 NULL,
    ModifiedBy NVARCHAR(100) NULL,

    CONSTRAINT UQ_Ships_Code UNIQUE (Code)
);
GO

-- =========================
-- Crews
-- =========================
CREATE TABLE Crews
(
    Id INT IDENTITY(1,1) PRIMARY KEY,

    MemberId CHAR(7) NOT NULL,
    Rank NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    BirthDate DATETIME2 NOT NULL,
    Nationality NVARCHAR(100) NOT NULL,

    CreatedDateTime DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(100) NOT NULL,
    ModifiedDateTime DATETIME2 NULL,
    ModifiedBy NVARCHAR(100) NULL,

    CONSTRAINT UQ_Crews_MemberId UNIQUE (MemberId)
);
GO

-- =========================
-- User
-- =========================
CREATE TABLE Users
(
    Id INT IDENTITY(1,1) PRIMARY KEY,

    Name NVARCHAR(100) NOT NULL,
    Role NVARCHAR(10) NOT NULL,

    CreatedDateTime DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(100) NOT NULL,
    ModifiedDateTime DATETIME2 NULL,
    ModifiedBy NVARCHAR(100) NULL,
);
GO

-- =========================
-- ShipUsers
-- =========================
CREATE TABLE ShipUsers
(
    ShipId INT NOT NULL,
    UserId INT NOT NULL,

    CONSTRAINT FK_ShipUser_Ship FOREIGN KEY (ShipId) REFERENCES Ships(Id),
    CONSTRAINT FK_ShipUser_User FOREIGN KEY (UserId) REFERENCES Users(Id),
);
GO

-- =========================
-- ShipCrews
-- =========================
CREATE TABLE ShipCrews
(
    ShipId INT NOT NULL,
    CrewId INT NOT NULL,

    CONSTRAINT FK_ShipCrew_Ship FOREIGN KEY (ShipId) REFERENCES Ships(Id),
    CONSTRAINT FK_ShipCrew_Crew FOREIGN KEY (CrewId) REFERENCES Crews(Id),
);
GO

-- =========================
-- Services
-- =========================
CREATE TABLE Services
(
    Id INT IDENTITY(1,1) PRIMARY KEY,

    CrewId INT NOT NULL,
    MemberId CHAR(7) NOT NULL,
    Rank NVARCHAR(100) NOT NULL,

    ShipId INT NOT NULL,
    ShipCode CHAR(5) NOT NULL,

    SignOnDate DATETIME2 NOT NULL,
    SignOffDate DATETIME2 NULL,
    EndOfContractDate DATETIME2 NOT NULL,

    CreatedDateTime DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(100) NOT NULL,
    ModifiedDateTime DATETIME2 NULL,
    ModifiedBy NVARCHAR(100) NULL,

    CONSTRAINT FK_Service_Crew FOREIGN KEY (CrewId) REFERENCES Crews(Id),
    CONSTRAINT FK_Service_Ship FOREIGN KEY (ShipId) REFERENCES Ships(Id)
);
GO

-- =========================
-- Accounts
-- =========================
CREATE TABLE Accounts
(
    Id INT IDENTITY(1,1) PRIMARY KEY,

    Number CHAR(8) NOT NULL,
    ParentId INT NULL,
    Description NVARCHAR(100) NOT NULL,

    CreatedDateTime DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(100) NOT NULL,
    ModifiedDateTime DATETIME2 NULL,
    ModifiedBy NVARCHAR(100) NULL,

    CONSTRAINT UQ_Accounts_Number UNIQUE (Number)
);
GO

-- =========================
-- Budgets
-- =========================
CREATE TABLE Budgets
(
    Id INT IDENTITY(1,1) PRIMARY KEY,

    ShipId INT NOT NULL,
    ShipCode CHAR(5) NOT NULL,
    
    AccountId INT NOT NULL,
    AccountNumber CHAR(8) NOT NULL,
    AccountPeriod CHAR(7) NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,

    CreatedDateTime DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(100) NOT NULL,
    ModifiedDateTime DATETIME2 NULL,
    ModifiedBy NVARCHAR(100) NULL,

    CONSTRAINT FK_Budget_Ship FOREIGN KEY (ShipId) REFERENCES Ships(Id),
    CONSTRAINT FK_Budget_Account FOREIGN KEY (AccountId) REFERENCES Accounts(Id),

    CONSTRAINT CK_Budget_Amount CHECK (Amount >= 0)
);
GO

-- =========================
-- Transactions
-- =========================
CREATE TABLE Transactions
(
    Id INT IDENTITY(1,1) PRIMARY KEY,

    ShipId INT NOT NULL,
    ShipCode CHAR(5) NOT NULL,

    AccountId INT NOT NULL,
    AccountNumber CHAR(8) NOT NULL,
    AccountPeriod CHAR(7) NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,

    CreatedDateTime DATETIME2 NOT NULL,
    CreatedBy NVARCHAR(100) NOT NULL,
    ModifiedDateTime DATETIME2 NULL,
    ModifiedBy NVARCHAR(100) NULL,

    CONSTRAINT FK_Transaction_Ship FOREIGN KEY (ShipId) REFERENCES Ships(Id),
    CONSTRAINT FK_Transaction_Account FOREIGN KEY (AccountId) REFERENCES Accounts(Id),

    CONSTRAINT CK_Transaction_Amount CHECK (Amount >= 0)
);
GO
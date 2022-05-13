CREATE DATABASE sales_dwh
GO;
USE sales_dwh
GO

CREATE TABLE [dbo].[DateDim] (
  [DateID] INT PRIMARY KEY IDENTITY(1, 1),
  [Date] DATE,
  [Day] TINYINT,
  [DaySuffix] CHAR(2),
  [Weekday] TINYINT,
  [WeekDayName] VARCHAR(10),
  [IsHoliday] BIT,
  [IsWeekend] BIT,
  [HolidayText] VARCHAR(64),
  [DOWInMonth] TINYINT,
  [DayOfYear] SMALLINT,
  [WeekOfMonth] TINYINT,
  [WeekOfYear] TINYINT,
  [ISOWeekOfYear] TINYINT,
  [Month] TINYINT,
  [MonthName] VARCHAR(10),
  [Quarter] TINYINT,
  [QuarterName] VARCHAR(6),
  [Year] INT,
  [MMYYYY] CHAR(6),
  [MonthYear] CHAR(7),
  [FirstDayOfMonth] DATE,
  [LastDayOfMonth] DATE,
  [FirstDayOfQuarter] DATE,
  [LastDayOfQuarter] DATE,
  [FirstDayOfYear] DATE,
  [LastDayOfYear] DATE,
  [FirstDayOfNextMonth] DATE,
  [FirstDayOfNextYear] DATE
)
GO

CREATE TABLE [dbo].[CustomerDim] (
  [CustomerID] int PRIMARY KEY IDENTITY(1, 1),
  [CustomerName] VARCHAR(60) NOT NULL,
  [Phone] VARCHAR(12) NOT NULL,
  [AdressLine1] VARCHAR(30) NOT NULL,
  [AdressLine2] VARCHAR(30),
  [ContactLastName] VARCHAR(20) NOT NULL,
  [ContactFirstName] VARCHAR(20) NOT NULL
)
GO

CREATE TABLE [dbo].[ProductDim] (
  [ProductID] int PRIMARY KEY IDENTITY(1, 1),
  [ProductLine] VARCHAR(30) NOT NULL,
  [MSRP] int NOT NULL,
  [PRODUCTCODE] VARCHAR(10) NOT NULL
)
GO

CREATE TABLE [dbo].[GeographyDim] (
  [GeographyID] int PRIMARY KEY IDENTITY(1, 1),
  [City] VARCHAR(30) NOT NULL,
  [State] VARCHAR(30) NOT NULL,
  [PostalCode] VARCHAR(10),
  [Country] VARCHAR(20) NOT NULL,
  [Territory] VARCHAR(10) NOT NULL,
  [Currency] CHAR(3) NOT NULL
)
GO

CREATE TABLE [dbo].[OrderFact] (
  [OrderFactID] int PRIMARY KEY IDENTITY(1, 1),
  [CustomerID] int NOT NULL,
  [GeographyID] int NOT NULL,
  [ProductID] int NOT NULL,
  [Quantity] int NOT NULL,
  [PriceEach] float NOT NULL,
  [OrderLineNumber] int NOT NULL,
  [OrderDateID] int NOT NULL,
  [Status] varchar(10) NOT NULL,
  [DealSize] varchar(6) NOT NULL
)
GO

CREATE TABLE [dbo].[RatesFacts] (
  [Currency] CHAR(3) NOT NULL,
  [Rate] float NOT NULL,
  [DateID] int NOT NULL
)
GO

ALTER TABLE [dbo].[OrderFact] ADD FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[CustomerDim] ([CustomerID])
GO

ALTER TABLE [dbo].[OrderFact] ADD FOREIGN KEY ([GeographyID]) REFERENCES [dbo].[GeographyDim] ([GeographyID])
GO

ALTER TABLE [dbo].[OrderFact] ADD FOREIGN KEY ([ProductID]) REFERENCES [dbo].[ProductDim] ([ProductID])
GO

ALTER TABLE [dbo].[OrderFact] ADD FOREIGN KEY ([OrderDateID]) REFERENCES [dbo].[DateDim] ([DateID])
GO

ALTER TABLE [dbo].[RatesFacts] ADD FOREIGN KEY ([Currency]) REFERENCES [dbo].[GeographyDim] ([Currency])
GO

ALTER TABLE [dbo].[RatesFacts] ADD FOREIGN KEY ([DateID]) REFERENCES [dbo].[DateDim] ([DateID])
GO

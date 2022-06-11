CREATE DATABASE sales_dwh
GO;
USE sales_dwh
GO

CREATE TABLE [dbo].[DateDim] (
  [DateID] INT PRIMARY KEY IDENTITY(1, 1),
  [Date] DATE NOT NULL,
  [Day] TINYINT NOT NULL,
  [DaySuffix] CHAR(2)NOT NULL,
  [Weekday] TINYINT NOT NULL,
  [WeekDayName] VARCHAR(10)NOT NULL,
  [IsHoliday] BIT NOT NULL,
  [IsWeekend] BIT NOT NULL,
  [HolidayText] VARCHAR(64),
  [DOWInMonth] TINYINT NOT NULL,
  [DayOfYear] SMALLINT NOT NULL,
  [WeekOfMonth] TINYINT NOT NULL,
  [WeekOfYear] TINYINT NOT NULL,
  [ISOWeekOfYear] TINYINT NOT NULL,
  [Month] TINYINT NOT NULL,
  [MonthName] VARCHAR(10) NOT NULL,
  [Quarter] TINYINT NOT NULL,
  [QuarterName] VARCHAR(6) NOT NULL,
  [Year] INT NOT NULL,
  [MMYYYY] CHAR(6) NOT NULL,
  [MonthYear] CHAR(7) NOT NULL,
  [FirstDayOfMonth] DATE NOT NULL,
  [LastDayOfMonth] DATE NOT NULL,
  [FirstDayOfQuarter] DATE NOT NULL,
  [LastDayOfQuarter] DATE NOT NULL,
  [FirstDayOfYear] DATE NOT NULL,
  [LastDayOfYear] DATE NOT NULL,
  [FirstDayOfNextMonth] DATE NOT NULL,
  [FirstDayOfNextYear] DATE NOT NULL
)
GO

CREATE TABLE [dbo].[CustomerDim] (
  [CustomerSKID] int PRIMARY KEY IDENTITY(1, 1),
  [CustomerName] VARCHAR(60) NOT NULL,
  [ContactName] VARCHAR(20) NOT NULL,
  [City] VARCHAR(30) NOT NULL,
  [State] VARCHAR(30) NOT NULL,
  [PostalCode] VARCHAR(10),
  [Country] VARCHAR(20) NOT NULL,
  [Territory] VARCHAR(10) NOT NULL,
  [ValidFrom] DATE NOT NULL,
  [ValidTo] DATE NOT NULL,
  [CurrentFlag] CHAR(4)
)
GO

CREATE TABLE [dbo].[ProductDim] (
  [ProductSKID] int PRIMARY KEY IDENTITY(1, 1),
  [ProductLine] VARCHAR(30) NOT NULL,
  [ProductCode] VARCHAR(10) NOT NULL,
  [SuggestedRetailPricePLN] int NOT NULL,
  [ValidFrom] DATE NOT NULL,
  [ValidTo] DATE NOT NULL,
  [CurrentFlag] CHAR(4)
)
GO


CREATE TABLE [dbo].[OrderFact] (
  [OrderFactID] int PRIMARY KEY IDENTITY(1, 1),
  [OrderNumber] int NOT NULL,
  [OrderLineNumber] int NOT NULL,
  [OrderDateID] int NOT NULL,
  [ProductSKID] int NOT NULL,
  [CustomerSKID] int NOT NULL,
  [Status] varchar(10) NOT NULL,
  [DealSize] varchar(6) NOT NULL,
  [Quantity] int NOT NULL,
  [UnitPriceLocalCurrency] money NOT NULL,
  [UnitPricePLN] money NOT NULL,
  [TotalDueLocalCurrency] money NOT NULL,
  [TotalDuePLN] money NOT NULL,
  [LocalCurrencyCode] char(3) NOT NULL
)
GO

CREATE TABLE [dbo].[CurrencyExchangeRateFact] (
  [SourceCurrencyKey] CHAR(3) NOT NULL,
  [DestinationCurrencyKey] CHAR(3) NOT NULL,
  [ExchangeRate] money NOT NULL,
  [DateID] int NOT NULL,
  PRIMARY KEY (SourceCurrencyKey, DestinationCurrencyKey, DateID)
)
GO

CREATE TABLE [dbo].[CurrencyDim] (
  [CurrencyKey] CHAR(3) PRIMARY KEY,
  [CurrencyName] VARCHAR(30) NOT NULL
)
GO

ALTER TABLE [dbo].[OrderFact] ADD FOREIGN KEY ([CustomerSKID]) REFERENCES [dbo].[CustomerDim] ([CustomerSKID])
GO

ALTER TABLE [dbo].[OrderFact] ADD FOREIGN KEY ([ProductSKID]) REFERENCES [dbo].[ProductDim] ([ProductSKID])
GO

ALTER TABLE [dbo].[OrderFact] ADD FOREIGN KEY ([OrderDateID]) REFERENCES [dbo].[DateDim] ([DateID])
GO

ALTER TABLE [dbo].[CurrencyExchangeRateFact] ADD FOREIGN KEY ([SourceCurrencyKey]) REFERENCES [dbo].[CurrencyDim] ([CurrencyKey])
GO

ALTER TABLE [dbo].[CurrencyExchangeRateFact] ADD FOREIGN KEY ([DestinationCurrencyKey]) REFERENCES [dbo].[CurrencyDim] ([CurrencyKey])
GO

ALTER TABLE [dbo].[CurrencyExchangeRateFact] ADD FOREIGN KEY ([DateID]) REFERENCES [dbo].[DateDim] ([DateID])
GO

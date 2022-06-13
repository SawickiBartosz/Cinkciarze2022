
CREATE DATABASE [SalesDWH]
GO
USE [SalesDWH]
GO
/****** Object:  Table [dbo].[CurrencyDim]    Script Date: 6/12/2022 10:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrencyDim](
	[CurrencyKey] [char](3) NOT NULL,
	[CurrencyName] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CurrencyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CurrencyExchangeRateFact]    Script Date: 6/12/2022 10:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrencyExchangeRateFact](
	[SourceCurrencyKey] [char](3) NOT NULL,
	[DestinationCurrencyKey] [char](3) NOT NULL,
	[FactSKID] [int] IDENTITY(1,1) NOT NULL,
	[ExchangeRate] [money] NOT NULL,
	[DateID] [int] NOT NULL,
 CONSTRAINT [PK_CurrencyExchangeRateFact] PRIMARY KEY CLUSTERED 
(
	[FactSKID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerDim]    Script Date: 6/12/2022 10:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerDim](
	[CustomerSKID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](60) NOT NULL,
	[ContactName] [varchar](51) NOT NULL,
	[City] [varchar](30) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[PostalCode] [varchar](10) NULL,
	[Country] [varchar](20) NOT NULL,
	[Territory] [varchar](10) NOT NULL,
	[ValidFrom] [date] NOT NULL,
	[ValidTo] [date] NOT NULL,
	[CurrentFlag] [char](4) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerSKID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DateDimension]    Script Date: 6/12/2022 10:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DateDimension](
	[DateID] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Day] [tinyint] NOT NULL,
	[DaySuffix] [char](2) NOT NULL,
	[Weekday] [tinyint] NOT NULL,
	[WeekDayName] [varchar](10) NOT NULL,
	[IsWeekend] [bit] NOT NULL,
	[IsHoliday] [bit] NOT NULL,
	[HolidayText] [varchar](64) SPARSE  NULL,
	[DOWInMonth] [tinyint] NOT NULL,
	[DayOfYear] [smallint] NOT NULL,
	[WeekOfMonth] [tinyint] NOT NULL,
	[WeekOfYear] [tinyint] NOT NULL,
	[ISOWeekOfYear] [tinyint] NOT NULL,
	[Month] [tinyint] NOT NULL,
	[MonthName] [varchar](10) NOT NULL,
	[Quarter] [tinyint] NOT NULL,
	[QuarterName] [varchar](6) NOT NULL,
	[Year] [int] NOT NULL,
	[MMYYYY] [char](6) NOT NULL,
	[MonthYear] [char](7) NOT NULL,
	[FirstDayOfMonth] [date] NOT NULL,
	[LastDayOfMonth] [date] NOT NULL,
	[FirstDayOfQuarter] [date] NOT NULL,
	[LastDayOfQuarter] [date] NOT NULL,
	[FirstDayOfYear] [date] NOT NULL,
	[LastDayOfYear] [date] NOT NULL,
	[FirstDayOfNextMonth] [date] NOT NULL,
	[FirstDayOfNextYear] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderFact]    Script Date: 6/12/2022 10:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderFact](
	[OrderFactID] [int] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[OrderLineNumber] [int] NOT NULL,
	[OrderDateID] [int] NOT NULL,
	[ProductSKID] [int] NOT NULL,
	[CustomerSKID] [int] NOT NULL,
	[Status] [varchar](10) NOT NULL,
	[DealSize] [varchar](6) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPriceLocalCurrency] [money] NOT NULL,
	[UnitPricePLN] [money] NOT NULL,
	[TotalDueLocalCurrency] [money] NOT NULL,
	[TotalDuePLN] [money] NOT NULL,
	[LocalCurrencyCode] [char](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderFactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductDim]    Script Date: 6/12/2022 10:27:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDim](
	[ProductSKID] [int] IDENTITY(1,1) NOT NULL,
	[ProductLine] [varchar](30) NOT NULL,
	[ProductCode] [varchar](10) NOT NULL,
	[SuggestedRetailPricePLN] [int] NOT NULL,
	[ValidFrom] [date] NOT NULL,
	[ValidTo] [date] NOT NULL,
	[CurrentFlag] [char](4) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductSKID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CurrencyExchangeRateFact]  WITH CHECK ADD  CONSTRAINT [FK__CurrencyE__Sourc__4D94879B] FOREIGN KEY([SourceCurrencyKey])
REFERENCES [dbo].[CurrencyDim] ([CurrencyKey])
GO
ALTER TABLE [dbo].[CurrencyExchangeRateFact] CHECK CONSTRAINT [FK__CurrencyE__Sourc__4D94879B]
GO
ALTER TABLE [dbo].[CurrencyExchangeRateFact]  WITH CHECK ADD  CONSTRAINT [FK_CurrencyExchangeRateFact_DateDimension] FOREIGN KEY([DateID])
REFERENCES [dbo].[DateDimension] ([DateID])
GO
ALTER TABLE [dbo].[CurrencyExchangeRateFact] CHECK CONSTRAINT [FK_CurrencyExchangeRateFact_DateDimension]
GO
ALTER TABLE [dbo].[OrderFact]  WITH CHECK ADD FOREIGN KEY([ProductSKID])
REFERENCES [dbo].[ProductDim] ([ProductSKID])
GO
ALTER TABLE [dbo].[OrderFact]  WITH CHECK ADD  CONSTRAINT [FK_OrderFact_CurrencyDim] FOREIGN KEY([LocalCurrencyCode])
REFERENCES [dbo].[CurrencyDim] ([CurrencyKey])
GO
ALTER TABLE [dbo].[OrderFact] CHECK CONSTRAINT [FK_OrderFact_CurrencyDim]
GO
ALTER TABLE [dbo].[OrderFact]  WITH CHECK ADD  CONSTRAINT [FK_OrderFact_CustomerDim] FOREIGN KEY([CustomerSKID])
REFERENCES [dbo].[CustomerDim] ([CustomerSKID])
GO
ALTER TABLE [dbo].[OrderFact] CHECK CONSTRAINT [FK_OrderFact_CustomerDim]
GO
ALTER TABLE [dbo].[OrderFact]  WITH CHECK ADD  CONSTRAINT [FK_OrderFact_DateDimension] FOREIGN KEY([OrderDateID])
REFERENCES [dbo].[DateDimension] ([DateID])
GO
ALTER TABLE [dbo].[OrderFact] CHECK CONSTRAINT [FK_OrderFact_DateDimension]
GO
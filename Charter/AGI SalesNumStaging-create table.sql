USE [NBFBackEnd]
GO

/****** Object:  Table [dbo].[SalesNumStaging]    Script Date: 04/30/2015 09:51:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SalesNumStaging]') AND type in (N'U'))
DROP TABLE [dbo].[SalesNumStaging]
GO

USE [NBFBackEnd]
GO

/****** Object:  Table [dbo].[SalesNumStaging]    Script Date: 04/30/2015 09:51:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[SalesNumStaging](
	[OrigSalesNumSK] [int] NULL,
	[NewSalesNumSK] [int] NULL,
	[OrigSalesNumWithCheckDigit] [varchar](11) NULL,
	[NewSalesNumWithCheckDigit] [varchar](11) NULL,
	[OrigSalesNumID] [varchar](11) NULL,
	[NewSalesNumID] [varchar](11) NULL,
	[OrigOwnerDistEnitySK] [int] NULL,
	[NewOwnerDistEnitySK] [int] NULL,
	[OrigOwnerDistEntityID] varchar(11) NULL,
	[NewOwnerDistEntityID] varchar(11) NULL,
	[OrigDistEntitySK] [int] NULL,
	[NewDistEntitySK] [int] NULL,
	[OrigDistEntityID] varchar(11) NULL,
	[NewDistEntityID] varchar(11) NULL,
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SalesNumStaging]') AND name = N'Orig_Sales_Dist')
DROP INDEX [Orig_Sales_Dist] ON [dbo].[SalesNumStaging] WITH ( ONLINE = OFF )
GO


CREATE NONCLUSTERED INDEX [Orig_Sales_Dist] ON [dbo].[SalesNumStaging] 
(
	[OrigSalesNumSK] ASC,
	[OrigDistEntitySK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
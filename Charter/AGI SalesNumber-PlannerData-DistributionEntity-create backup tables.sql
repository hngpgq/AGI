USE [NBFBackEnd]
GO
/****** Object:  Table [dbo].[OldSalesNumber]    Script Date: 04/30/2015 08:42:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OldSalesNumber]') AND type in (N'U'))
DROP TABLE [dbo].[OldSalesNumber]
GO


/****** Object:  Table [dbo].[OldSalesNumber]    Script Date: 05/01/2015 15:01:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[OldSalesNumber](
	[DistEntitySK] [decimal](10, 0) NOT NULL,
	[SalesNumSK] [decimal](10, 0) NOT NULL,
	[SalesNumID] [varchar](11) NOT NULL,
	[SalesNumWithCheckDigitID] [varchar](11) NULL,
	[OwnerEntitySK] [decimal](10, 0) NULL,
	[SalesNumWithdrawnInd] [char](1) NULL,
 CONSTRAINT [PK_OLDSalesNumber] PRIMARY KEY CLUSTERED 
(
	[DistEntitySK] ASC,
	[SalesNumSK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OldDistributionEntity]') AND type in (N'U'))
DROP TABLE [dbo].[OldDistributionEntity]
GO

USE [NBFBackEnd]
GO

/****** Object:  Table [dbo].[OldDistributionEntity]    Script Date: 05/01/2015 15:00:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[OldDistributionEntity](
	[DistEntitySK] [decimal](10, 0) NOT NULL,
	[DistEntityWithCheckDigitID] [varchar](11) NOT NULL,
	[FullNm] [varchar](64) NOT NULL,
	[TenureYearsNum] [int] NULL,
	[Level5ShortDsc] [varchar](50) NULL,
	[DistEntityTypeCd] [char](1) NOT NULL,
 CONSTRAINT [PK_OLDDistributionEntity] PRIMARY KEY NONCLUSTERED 
(
	[DistEntitySK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[OldDistributionEntity] ADD  CONSTRAINT [DF_OLDDistributionEntity_DistEntityTypeCd]  DEFAULT ('O') FOR [DistEntityTypeCd]
GO




IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OldPlannerData]') AND type in (N'U'))
DROP TABLE [dbo].[OldPlannerData]
GO

USE [NBFBackEnd]
GO

/****** Object:  Table [dbo].[OldPlannerData]    Script Date: 05/01/2015 14:58:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[OldPlannerData](
	[DistEntitySK] [decimal](10, 0) NOT NULL,
	[DistEntityWithCheckDigitID] [varchar](11) NOT NULL,
	[DistEntityID] [varchar](11) NULL,
	[FullNm] [varchar](50) NOT NULL,
	[TenureYearsNum] [smallint] NULL,
	[GenderCd] [char](1) NULL,
	[BusinessPostCode] [varchar](10) NULL,
	[DeptID] [varchar](10) NULL,
	[CountryNum] [smallint] NULL,
	[ManagementChannelCd] [varchar](15) NOT NULL,
	[Level4BusinessDsc] [varchar](50) NOT NULL,
	[Level5ShortDsc] [varchar](20) NULL,
	[Level5BusinessDsc] [varchar](50) NOT NULL,
	[Level7BusinessDsc] [varchar](50) NULL,
	[Level9BusinessDsc] [varchar](50) NULL,
	[Level9HeadingTxt] [varchar](50) NULL,
	[DistEntityTypeDsc] [varchar](10) NOT NULL,
	[AdviserTypeCd] [char](1) NULL,
	[AdviserTypeDsc] [varchar](50) NULL,
	[DistEntityAKANm] [varchar](50) NULL,
	[AppointmentEffectiveDt] [datetime] NULL,
	[WithdrawalEffectiveDt] [datetime] NULL,
	[ServiceDt] [datetime] NULL,
	[StatusDsc] [varchar](30) NOT NULL,
	[AdviserInd] [varchar](1) NOT NULL,
	[AdviserJobCd] [varchar](6) NULL,
	[ManagementStructureNm] [varchar](50) NULL,
	[StructureID] [varchar](12) NULL,
	[StructureDsc] [varchar](50) NULL,
	[StructureDistEntityID] [varchar](11) NULL,
	[StructureDistEntityNm] [varchar](50) NULL,
	[PayeeDistEntityNm] [varchar](50) NULL,
	[AgrmtTypeDsc] [varchar](50) NULL,
	[TargetedPlannerInd] [char](1) NULL,
 CONSTRAINT [PK_OldPlannerData] PRIMARY KEY NONCLUSTERED 
(
	[DistEntitySK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [AgentIdx]
) ON [AgentDat]

GO

SET ANSI_PADDING OFF
GO



USE [NBFBackEnd]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[OLDDF_UnPublishedTxn_ExtractRecordSeqID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OldUnPublishedTxn] DROP CONSTRAINT [OLDDF_UnPublishedTxn_ExtractRecordSeqID]
END

GO

USE [NBFBackEnd]
GO

/****** Object:  Table [dbo].[UnPublishedTxn]    Script Date: 05/21/2015 10:27:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OldUnPublishedTxn]') AND type in (N'U'))
DROP TABLE [dbo].[OldUnPublishedTxn]
GO

USE [NBFBackEnd]
GO

/****** Object:  Table [dbo].[UnPublishedTxn]    Script Date: 05/21/2015 10:27:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[OldUnPublishedTxn](
	[ExtractRecordID] [decimal](18, 0) NOT NULL,
	[ExtractRecordSeqID] [smallint] NOT NULL,
	[NBFPeriodStartDt] [smalldatetime] NOT NULL,
	[DistEntitySK] [decimal](10, 0) NOT NULL,
	[SalesNumSK] [decimal](10, 0) NOT NULL,
	[ProductGroupLvl2SK] [int] NOT NULL,
	[ProductGroupLvl3SK] [int] NOT NULL,
	[ProductGroupLvl4SK] [int] NOT NULL,
	[ProductGroupLvl9SK] [int] NOT NULL,
	[ProductSK] [decimal](10, 0) NOT NULL,
	[ProcessingDt] [smalldatetime] NOT NULL,
	[StatusCd] [char](1) NOT NULL,
	[ContractID] [varchar](32) NULL,
	[SubContractId] [varchar](32) NULL,
	[ContractOptionCd] [varchar](32) NULL,
	[TxnEffectiveDt] [smalldatetime] NULL,
	[MovementTypeSK] [decimal](10, 0) NOT NULL,
	[CashFlowDirnCd] [char](1) NOT NULL,
	[InflowCur] [money] NOT NULL,
	[OutflowCur] [money] NOT NULL,
	[WeightedInflowCur] [money] NOT NULL,
	[WeightedOutflowCur] [money] NOT NULL,
	[ClientNm] [varchar](32) NULL,
	[PlannerTenureYearsNum] [decimal](5, 3) NULL,
	[WeightingSK] [int] NOT NULL,
 CONSTRAINT [OldPK_CurrentPeriodTxn] PRIMARY KEY NONCLUSTERED 
(
	[ExtractRecordID] ASC,
	[ExtractRecordSeqID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[OldUnPublishedTxn] ADD  CONSTRAINT [OldDF_UnPublishedTxn_ExtractRecordSeqID]  DEFAULT (0) FOR [ExtractRecordSeqID]
GO



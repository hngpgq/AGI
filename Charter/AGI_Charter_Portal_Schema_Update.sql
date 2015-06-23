ALTER TABLE NBFBackEnd.dbo.TwoYearAwardRankingByID ADD ChannelCode SMALLINT NULL ;
Go
ALTER TABLE NBFFrontEnd.dbo.TwoYearAwardRanking ADD ChannelCode SMALLINT NULL ;
GO



USE [NBFBackEnd]
GO
/****** Object:  View [dbo].[TwoYearAwardRanking]    Script Date: 04/09/2015 08:29:09 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[TwoYearAwardRanking]'))
DROP VIEW [dbo].[TwoYearAwardRanking]
GO

USE [NBFBackEnd]
GO

/****** Object:  View [dbo].[TwoYearAwardRanking]    Script Date: 04/09/2015 08:29:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  View [dbo].[TwoYearAwardRanking]
--*********************************************************************
--			CHANGE LOG
--29Oct02	e-Street Design Studio
--	SOW-018 View rewritten to take into account new table structure
--*********************************************************************
 As Select A.DistEntitySK
	,AdjustedWeightedNetCur
	,RankingOrd
	,PercentileNum
	,Year1AwardsNum
	,Year2AwardsNum
	,OnAwardTrackInd
	,EstQualifiedNo
	,ChannelCode
 From	TwoYearAwardRankingByID B
	,DistributionEntity A
 Where	A.DistEntityWithCheckDigitID = B.DistEntityWithCheckDigitID

GO




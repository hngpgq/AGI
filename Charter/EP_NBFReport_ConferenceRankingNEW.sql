USE [NBFFrontEnd]
GO

/****** Object:  StoredProcedure [dbo].[EP_NBFReport_ConferenceRanking]    Script Date: 06/09/2015 14:04:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EP_NBFReport_ConferenceRanking]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[EP_NBFReport_ConferenceRanking]
GO

USE [NBFFrontEnd]
GO

/****** Object:  StoredProcedure [dbo].[EP_NBFReport_ConferenceRanking]    Script Date: 06/09/2015 14:04:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO







CREATE            Proc [dbo].[EP_NBFReport_ConferenceRanking]
--**************************************************************
--			CHANGE LOG
--29Oct02 Rewritten  e-Street Design Studio   SOW018 
--	TwoYearRanking table change and report change.
--**************************************************************
 @PositionSK			Decimal(10,0)		--12Jul02
,@LogCd				Char(1)
,@RequestID			UniqueIdentifier

As

Create	Table #RankingReport
	(RptID			Integer			Identity
	,ReportName		Varchar(64)
	)

Create	Table #QualRow
	(RptID			Integer
	,RowNum			Integer
	,DistEntitySK		Decimal(10,0)
	,FullNm			Varchar(64)
	,Level5ShortDsc		Varchar(20)
	,AdjustedWeightedNetCur	Integer
	,RankingOrd		Integer
	,PercentileNum			Smallint
	,Year1AwardsNum		Smallint
	,Year2AwardsNum		Smallint
	,OnAwardTrackDsc	Varchar(64)
	,EstQualifiedNo			Smallint
	,ChannelCode	Smallint
	)

Declare	@RptID			Integer

Insert	#RankingReport
	(ReportName
	)
 Values	('Offshore Convention Qualification Report'
	)

Set	@RptID			= @@Identity

Insert	#QualRow
	(RptID
	,RowNum
	,DistEntitySK
	,FullNm
	,Level5ShortDsc
	,AdjustedWeightedNetCur
	,RankingOrd
	,PercentileNum
	,Year1AwardsNum
	,Year2AwardsNum
	,OnAwardTrackDsc
	,EstQualifiedNo
	,ChannelCode
	)
Select	distinct @RptID
	,Coalesce(A.RankingOrd,2147483647)
	,A.DistEntitySK
	,D.FullNm
	,D.Level5ShortDsc
	,A.AdjustedWeightedNetCur
	,A.RankingOrd
	,A.PercentileNum
	,A.Year1AwardsNum
	,A.Year2AwardsNum
	,A.OnAwardTrackInd
	,EstQualifiedNo
	,ChannelCode
 From	 TwoYearAwardRanking A
 inner join DistributionEntity D on D.DistEntitySK  = A.DistEntitySK
 Where	A.ChannelCode in (select rank.ChannelCode  
			from SalesNumber sales,
			TwoYearAwardRanking rank
			Where	sales.OwnerEntitySK = @PositionSK
  			And	rank.DistEntitySK = sales.DistEntitySK
			And 	sales.SalesNumWithdrawnInd = 'A'
			group by  rank.ChannelCode
			)
 
If	@@Error <> 0
	Begin
	Raiserror('Error %i encountered while inserting into #QualRow',11,1,@@Error)
--	Return(1)
	End

Select	 RankingReport.*
	,QualRow.RptID
	,DistEntitySK
	,FullNm
	,Level5ShortDsc
	,dbo.NBFMoneyDisp(AdjustedWeightedNetCur) As AdjustedWeightedNetCur
	,RankingOrd
	,PercentileNum
--	,Cast(Cast((PercentileNum * 100) as Integer) as varchar(16)) + '%' As PercentileNum
	,Year1AwardsNum
	,Year2AwardsNum
	,OnAwardTrackDsc
	,EstQualifiedNo
	,ChannelCode 
--	,dbo.NBFMoneyDisp(PartnerCostCur) As PartnerCostCur
 From	#RankingReport RankingReport
  Left Join	#QualRow QualRow On QualRow.RptID = RankingReport.RptID
 Order by QualRow.RowNum, QualRow.FullNm				--13Mar02
 For	XML Auto

Return(0)




GO



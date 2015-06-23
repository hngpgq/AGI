USE [NBFFrontEnd]
GO

/****** Object:  StoredProcedure [dbo].[EP_NBFExcel_ConferenceRankingExtract]    Script Date: 04/08/2015 14:30:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EP_NBFExcel_ConferenceRankingExtract]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[EP_NBFExcel_ConferenceRankingExtract]
GO

USE [NBFFrontEnd]
GO

/****** Object:  StoredProcedure [dbo].[EP_NBFExcel_ConferenceRankingExtract]    Script Date: 04/08/2015 14:30:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO





CREATE      Proc [dbo].[EP_NBFExcel_ConferenceRankingExtract]
--*****************************************************************
--			CHANGE LOG
-- 19Feb02 Created e-Street Design Studio
-- 
-- 30Oct02 e-Street Design Studio
--	SOW018. Rewrote procedure for new table and report format.
--*****************************************************************

As

Select	
'<Headings>"Practice Name","Zone","Two Year Total Points","Two Year Ranking","Top % Band","NBF Awards for Year 1 (Gold+)","On Track for Year 2 (Gold+)","On Track for Offshore Qualification","Estimated number of Qualified Planners per practice","Channel Code"</Headings>'

Select	    '"'	+ Coalesce(D.FullNm,'')
	+ '","' + Coalesce(Cast(D.Level5ShortDsc As Varchar(16)),'')
	+ '","' + Coalesce(Cast(Data.AdjustedWeightedNetCur As Varchar(16)),'')
	+ '","' + Coalesce(Cast(Data.RankingOrd As Varchar(16)),'')
	+ '","' + Coalesce(Cast(Data.PercentileNum As Varchar(16)),'')
	+ '","' + Coalesce(Cast(Data.Year1AwardsNum As Varchar(16)),'')
	+ '","' + Coalesce(Cast(Data.Year2AwardsNum As Varchar(16)),'')
	+ '","' + Case Data.OnAwardTrackInd When 'Y' Then 'Yes' Else 'No' End
	+ '","' + Coalesce(Cast(Data.EstQualifiedNo As Varchar(16)),'')
	+ '","' + Coalesce(Cast(Data.ChannelCode As Varchar(16)),'')
	+ '"' As ExcelRow
 From	 TwoYearAwardRanking	Data
	,DistributionEntity	D
 Where	Data.DistEntitySK	= D.DistEntitySK
 Order By
	Coalesce(Data.RankingOrd,2147483647)
	,D.FullNm
 For XML Auto

Return(0)



GO



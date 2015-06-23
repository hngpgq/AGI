USE [NBFFrontEnd]
GO

/****** Object:  StoredProcedure [dbo].[EP_NBFExcel_Portal_ConferenceRankingExtract]    Script Date: 04/08/2015 14:39:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EP_NBFExcel_Portal_ConferenceRankingExtract]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[EP_NBFExcel_Portal_ConferenceRankingExtract]
GO

USE [NBFFrontEnd]
GO

/****** Object:  StoredProcedure [dbo].[EP_NBFExcel_Portal_ConferenceRankingExtract]    Script Date: 04/08/2015 14:39:30 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO






CREATE      Proc [dbo].[EP_NBFExcel_Portal_ConferenceRankingExtract]
--*****************************************************************
--			CHANGE LOG
-- 19Feb02 Created e-Street Design Studio
-- 
-- 30Oct02 e-Street Design Studio
--	SOW018. Rewrote procedure for new table and report format.
--
-- 9/3/2007 - M. Bedrina i) Add 2007 Enhancements PDF 2002376 
--                      ii) Change export format for Portal 2.1 release
--*****************************************************************

As

Select	
'<tr><td>Practice Name</td><td>Zone</td><td>Two Year Total Points</td><td>Two Year Ranking</td><td>Top % Band</td><td>NBF Awards for Year 1 (Gold+)</td>
<td>On Track for Year 2 (Gold+)</td><td>On Track for Offshore Qualification</td><td>Estimated number of Qualified Planners per practice</td><td>Channel Code</td></tr>'
Select	    '<tr><td><![CDATA['	+ Coalesce(D.FullNm,'')
	+ ']]></td><td><![CDATA[' + Coalesce(Cast(D.Level5ShortDsc As Varchar(16)),'')
	+ ']]></td><td><![CDATA[' + Coalesce(Cast(Data.AdjustedWeightedNetCur As Varchar(16)),'')
	+ ']]></td><td><![CDATA[' + Coalesce(Cast(Data.RankingOrd As Varchar(16)),'')
	+ ']]></td><td><![CDATA[' + Coalesce(Cast(Data.PercentileNum As Varchar(16)),'')
	+ ']]></td><td><![CDATA[' + Coalesce(Cast(Data.Year1AwardsNum As Varchar(16)),'')
	+ ']]></td><td><![CDATA[' + Coalesce(Cast(Data.Year2AwardsNum As Varchar(16)),'')
	+ ']]></td><td><![CDATA[' + Case Data.OnAwardTrackInd When 'Y' Then 'Yes' Else 'No' End
	+ ']]></td><td><![CDATA[' + Coalesce(Cast(Data.EstQualifiedNo As Varchar(16)),'')
	+ ']]></td><td><![CDATA[' + Coalesce(Cast(Data.ChannelCode As Varchar(16)),'')
	+ ']]></td></tr>'    --as ExcelRow
 From	 TwoYearAwardRanking	Data
	,DistributionEntity	D
 Where	Data.DistEntitySK	= D.DistEntitySK
 Order By
	Coalesce(Data.RankingOrd,2147483647)
	,D.FullNm
 -- For XML Auto

Return(0)




GO



USE [NBFFrontEnd]
GO

/****** Object:  StoredProcedure [dbo].[DM_upload_NBF_CONFERENCE_RANK_IFACE]    Script Date: 04/08/2015 14:22:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DM_upload_NBF_CONFERENCE_RANK_IFACE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DM_upload_NBF_CONFERENCE_RANK_IFACE]
GO

USE [NBFFrontEnd]
GO

/****** Object:  StoredProcedure [dbo].[DM_upload_NBF_CONFERENCE_RANK_IFACE]    Script Date: 04/08/2015 14:22:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO






CREATE	Proc [dbo].[DM_upload_NBF_CONFERENCE_RANK_IFACE]
As

Delete from DMR_UPLOAD2..NBFSCHEMA.NBF_CONFERENCE_RANK_IFACE;

Insert into DMR_UPLOAD2..NBFSCHEMA.NBF_CONFERENCE_RANK_IFACE(
	PERIODENDDT
	,DISTENTITYWITHCHECKDIGITID 
	,ADJUSTEDWEIGHTEDNET
	,RANKINGORD 
	,PERCENTILENUM
	,YEAR1AWARDSNUM 
	,YEAR2AWARDSNUM 
	,ONAWARDTRACKIND
	,ESTQUALIFIEDNO
	,LOADED_TSTP
	,LOAD_ID
	,CHANNELCODE)
Select
	d.PeriodEndDt,
	b.DistEntityWithCheckDigitID,
	a.AdjustedWeightedNetCur,
	a.RankingOrd,
	a.PercentileNum,
	a.Year1AwardsNum,
	a.Year2AwardsNum,
	a.OnAwardTrackInd,
	a.EstQualifiedNo,
	GetDate(),
	0,
	ChannelCode
From	NBFFrontEnd.dbo.TwoYearAwardRanking a,
	NBFFrontEnd.dbo.DistributionEntity b,
	NBFFrontEnd.dbo.CurrentNBFPeriod c,
	NBFFrontEnd.dbo.NBFPeriod d
where	a.DistEntitySk = b.DistEntitySk
and	c.NBFPeriodStartDt = d.NBFPeriodStartDt;


Return(0)


GO



USE [NBFBackEnd]
GO

/****** Object:  StoredProcedure [dbo].[DM_SalesNumber_LookupSalesNumIDStr]    Script Date: 05/29/2015 08:43:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DM_SalesNumber_LookupSalesNumIDStr]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DM_SalesNumber_LookupSalesNumIDStr]
GO

USE [NBFBackEnd]
GO

/****** Object:  StoredProcedure [dbo].[DM_SalesNumber_LookupSalesNumIDStr]    Script Date: 05/29/2015 08:43:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  Procedure [dbo].[DM_SalesNumber_LookupSalesNumIDStr]
@InterfaceCd			Char(3)
,@ExtractID			Integer
,@ExtractRecordID		Decimal(18,0)
,@SalesNumIDStr			Varchar(64)
,@DistEntitySK			Decimal(10,0)		Output
,@SalesNumSK			Decimal(10,0)		Output
,@PlannerTenureYearsNum		Decimal(5,3)		Output
,@ErrorStatusCd			Char(1)			Output
As
Declare @ReturnCd		Integer
Declare	@SalesNumIDStrWk	VarChar(64)
Set	@SalesNumIDStrWk	= LTrim(RTrim(@SalesNumIDStr))
If	Len(@SalesNumIDStrWk) > 11
	Begin
	Exec	Er_CreateNBFErrorEntry
		@ProcID			= @@ProcID
		,@ErrorLocNm		= 'CheckSalesNumLen'
		,@ErrorCd		= 'SaleNumLen'
		,@InterfaceCd		= @InterfaceCd
		,@ExtractID		= @ExtractID
		,@ExtractRecordID	= @ExtractRecordID
		,@ErrorField1Dat	= @SalesNumIDStrWk
	Set	@ErrorStatusCd		= '1'
	Return(0)
	End
If	CharIndex(' ',@SalesNumIDStrWk) > 0
	Begin
	Exec	Er_CreateNBFErrorEntry
		@ProcID			= @@ProcID
		,@ErrorLocNm		= 'CheckSalesNumBlanks'
		,@ErrorCd		= 'SaleNumBlk'
		,@InterfaceCd		= @InterfaceCd
		,@ExtractID		= @ExtractID
		,@ExtractRecordID	= @ExtractRecordID
		,@ErrorField1Dat	= @SalesNumIDStrWk
	Set	@ErrorStatusCd		= '1'
	Return(0)
	End
Select	@DistEntitySK		= DistEntitySK
	,@SalesNumSK		= SalesNumSK
 From	SalesNumber
 Where	SalesNumWithCheckDigitID = @SalesNumIDStrWk
If	@@RowCount = 0
	Begin
	Exec	Er_CreateNBFErrorEntry
		@ProcID			= @@ProcID
		,@ErrorLocNm		= 'CheckSalesNumLookup'
		,@ErrorCd		= 'SaleNumInv'
		,@InterfaceCd		= @InterfaceCd
		,@ExtractID		= @ExtractID
		,@ExtractRecordID	= @ExtractRecordID
		,@ErrorField1Dat	= @SalesNumIDStrWk
	Set	@ErrorStatusCd		= '1'
	Return(0)
	End
Else
	Begin
	Exec	@ReturnCd = DM_DistibutionEntity_LookupDistEntitySK
		@DistEntitySK		= @DistEntitySK
		,@TenureYearsNum	= @PlannerTenureYearsNum	Output
	If	@ReturnCd <> 0
		Begin
		Raiserror('Error encountered executing DM_DistibutionEntity_LookupDistEntitySK',11,1)
		Return(1)
		End
	End
Return(0)

GO



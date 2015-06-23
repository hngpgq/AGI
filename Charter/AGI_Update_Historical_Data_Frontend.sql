use NBFFrontEnd
go

declare @Year TABLE(yr char(6))
declare @y char(6)
declare @sql varchar(8000)
declare @rowcount int
declare @maxyear int = 2015;
declare @maxmonth int = 12;
declare @yr int = 2008;
declare @mon int = 1;
declare @exit int = 0;


while @yr <= @maxyear
begin
	while @mon <= @maxmonth
	begin
	    if (@yr = @maxyear) and (@mon > 3)
	    begin
			set @exit = 1
			break
	    end 
		insert into @Year select cast(@yr as CHAR(4)) + right('0'+ convert(varchar,@mon),2) 
		set @mon = @mon + 1
	end
	if @exit = 1 break
	set @mon  = 1
	set @yr = @yr + 1
	
end


declare	Csr Cursor  for
	select * from @Year

Open	Csr

Fetch	Next
 From	Csr
 Into	@y


While	@@Fetch_Status = 0
begin
    
	If  exists (select * from sys.tables where name = 'SalesNumber' + @y and type = 'U')
	begin
	
		set @sql = 'UPDATE SalesNumber' + @y + ' SET
	SalesNumber' + @y +'.DistEntitySK = b.NewDistEntitySK,
    SalesNumber' + @y +'.SalesNumSK = b.NewSalesNumSK,SalesNumber' + @y + '.SalesNumID = b.NewSalesNumID,SalesNumber'  + @y +'.OwnerEntitySK = b.NewOwnerDistEnitySK
    FROM  SalesNumber' + @y + ' INNER JOIN NBFBackEnd.dbo.SalesNumStaging  b'
	+ ' ON  b.OrigSalesNumSK = SalesNumber' + @y +'.salesnumsk' 
		
		exec(@sql)
		set @sql = ''
	end
	select 'Done SalesNumber' + @y
	Fetch	Next
	 From	Csr
	 Into	@y
End
Close	Csr
Deallocate Csr

While	@@Fetch_Status = 0
begin
    
    IF  exists (select * from sys.tables where name = 'DistributionEntity' + @y and type = 'U')
	begin
	
		set @sql = ' delete from DistributionEntity'+ @y
		exec(@sql) -- clear Dist historical tables
		set @sql = 'Insert into DistributionEntity'+ @y + ' select * from NBFBackend.dbo.DistributionEntity'
		exec(@sql)
		select 'Done DistributionEntity' + @y		
		set @sql = ''
	end
	
	IF  exists (select * from sys.tables where name = 'PlannerData' + @y and type = 'U')
	begin
		set @sql = ' delete from PlannerData'+ @y
		exec(@sql) -- clear Dist historical tables
		set @sql = 'Insert into PlannerData'+ @y + ' select DistEntitySK,DistEntityWithCheckDigitID,DistEntityID,FullNm,9,GenderCd,BusinessPostCode,DeptID,CountryNum,ManagementChannelCd,Level4BusinessDsc,Level5ShortDsc,Level5BusinessDsc,
		Level7BusinessDsc,Level9BusinessDsc,Level9HeadingTxt,DistEntityTypeDsc,AdviserTypeCd,AdviserTypeDsc,DistEntityAKANm,AppointmentEffectiveDt,WithdrawalEffectiveDt,ServiceDt,StatusDsc,AdviserInd,AdviserJobCd,
	ManagementStructureNm,StructureID,StructureDsc,StructureDistEntityID,StructureDistEntityNm,PayeeDistEntityNm,AgrmtTypeDsc,TargetedPlannerInd from NBFBackend.dbo.PlannerData'
		exec(@sql)
		
		select 'Done PlannerData' + @y
	
	end 
	
	Fetch	Next
	 From	Csr
	 Into	@y

End

Close	Csr
Deallocate Csr



declare	Csr Cursor  for
	select * from @Year

Open	Csr

Fetch	Next
 From	Csr
 Into	@y

While	@@Fetch_Status = 0
begin
	
	IF  exists (select * from sys.tables where name = 'PlannerPeriodProductSummary' + @y and type = 'U')
	begin
	
		set @sql = 'UPDATE PlannerPeriodProductSummary' + @y + ' SET
		PlannerPeriodProductSummary' + @y +'.DistEntitySK = b.NewDistEntitySK,
		PlannerPeriodProductSummary' + @y +'.SalesNumSK = b.NewSalesNumSK  FROM  PlannerPeriodProductSummary' + @y + ' INNER JOIN NBFBackEnd.dbo.SalesNumStaging  b'
		+ ' ON  b.OrigSalesNumSK = PlannerPeriodProductSummary' + @y +'.salesnumsk' + ' and PlannerPeriodProductSummary' + @y +'.DistEntitySK = b.OrigDistEntitySK'
		exec(@sql)
		set @sql = ''
		select 'Done PlannerPeriodProductSummary' + @y
	end
	
	Fetch	Next
	 From	Csr
	 Into	@y

End

Close	Csr
Deallocate Csr


declare	Csr Cursor  for
	select * from @Year

Open	Csr

Fetch	Next
 From	Csr
 Into	@y

While	@@Fetch_Status = 0
begin

	IF  exists (select * from sys.tables where name = 'PlannerSummary' + @y and type = 'U')
	begin	
		set @sql = 'UPDATE PlannerSummary' + @y + ' SET
		PlannerSummary' + @y +'.DistEntitySK = b.NewDistEntitySK,
		PlannerSummary' + @y +'.SalesNumSK = b.NewSalesNumSK  FROM  PlannerSummary' + @y + ' INNER JOIN NBFBackEnd.dbo.SalesNumStaging  b'
		+ ' ON  b.OrigSalesNumSK = PlannerSummary' + @y +'.salesnumsk' + ' and PlannerSummary' + @y +'.DistEntitySK = b.OrigDistEntitySK'
		
		exec(@sql)
		set @sql = ''
		select 'Done PlannerSummary' + @y
	end
	
	Fetch	Next
	 From	Csr
	 Into	@y

End

Close	Csr
Deallocate Csr


declare	Csr Cursor  for
	select * from @Year

Open	Csr

Fetch	Next
 From	Csr
 Into	@y

While	@@Fetch_Status = 0
begin

	IF  exists (select * from sys.tables where name = 'TxnFact' + @y and type = 'U')
	begin
	
		set @sql = 'UPDATE TxnFact' + @y + ' SET
		TxnFact' + @y +'.DistEntitySK = b.NewDistEntitySK,
		TxnFact' + @y +'.SalesNumSK = b.NewSalesNumSK  FROM  TxnFact' + @y + ' INNER JOIN NBFBackEnd.dbo.SalesNumStaging  b'
		+ ' ON  b.OrigSalesNumSK = TxnFact' + @y +'.salesnumsk' + ' and TxnFact' + @y +'.DistEntitySK = b.OrigDistEntitySK'
		
		exec(@sql)
		set @sql = ''
		select 'Done TxnFact' + @y
	end
	
	Fetch	Next
	 From	Csr
	 Into	@y

End

Close	Csr
Deallocate Csr
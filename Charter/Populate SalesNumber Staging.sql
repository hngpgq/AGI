Use NBFBackend
Go

insert into SalesNumStaging
select b.salesnumsk,
	a.SalesNumSK,
	b.SalesNumWithCheckDigitID,
	a.SalesNumWithCheckDigitID,
	b.SalesNumID,
	a.SalesNumID,
	b.OwnerEntitySK,
	a.OwnerEntitySK,    
	olddist_owner.DistEntityWithCheckDigitID,
	newdist_owner.DistEntityWithCheckDigitID ,
	olddist_dist.DistEntitySK,
	newdist_dist.DistEntitySK,  
	olddist_dist.DistEntityWithCheckDigitID ,
	newdist_dist.DistEntityWithCheckDigitID 
	   
 from SalesNumber a
 inner join OldSalesNumber b on a.SalesNumWithCheckDigitID = b.SalesNumWithCheckDigitID
 left join DistributionEntity newdist_dist on newdist_dist.DistEntitySK  = a.DistEntitySK
 left join  DistributionEntity newdist_owner  on newdist_owner.DistEntitySK = a.OwnerEntitySK
  left join OldDistributionEntity olddist_dist on olddist_dist.DistEntitySK  = b.DistEntitySK
 left join  OldDistributionEntity olddist_owner on olddist_owner.DistEntitySK = b.OwnerEntitySK




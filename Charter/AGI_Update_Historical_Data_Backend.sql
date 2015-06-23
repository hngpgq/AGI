use NBFBackEnd

UPDATE
    UnPublishedTxn
SET
	DistEntitySK = b.NewDistEntitySK,
    SalesNumSK = b.NewSalesNumSK
    
FROM
    UnPublishedTxn 
INNER JOIN
    SalesNumStaging  b
ON  b.OrigSalesNumSK = UnPublishedTxn.salesnumsk
    and  b.OrigDistEntitySK = UnPublishedTxn.DistEntitySK 

Go


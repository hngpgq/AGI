Use NBFBackend
go
/*   Add Practise Agreement Type*/
If not exists(select AgreementTypeCd from NBFPracticeAgreement where AgreementTypeCd = 'HA')
Begin
		Insert into NBFPracticeAgreement(AgreementTypeCd)
		Values('HA')
End

If not exists(select AgreementTypeCd from NBFPracticeAgreement where AgreementTypeCd = 'AWSE')
Begin
		Insert into NBFPracticeAgreement(AgreementTypeCd)
		Values('AWSE')
End


If not exists(select AgreementTypeCd from NBFPracticeAgreement where AgreementTypeCd = 'MASE')
Begin
		Insert into NBFPracticeAgreement(AgreementTypeCd)
		Values('MASE')
End


If not exists(select AgreementTypeCd from NBFPracticeAgreement where AgreementTypeCd = 'H')
Begin
		Insert into NBFPracticeAgreement(AgreementTypeCd)
		Values('H')
End

go




foreach iso in 59318 50897 56856 59332 56411 56402 { 

*60644 60046 60177 60900 6090160984 66401 66402 66411 60476 *Master programs FEB -- replace above isatcodes to start the predictions
*59318 50897 56856 59332 56411 56402 * Bachelor programs FEB -- replace above isatcodes to start the predictions
	
	
 
 
 
	import excel "2024data.xlsx", sheet("Sheet1") firstrow clear



	






	gen EBE = (isatcode ==  59318)
	gen BA = (isatcode == 50897)
	gen BAN = (isatcode == 56856)
	gen EC = (isatcode == 59332)
	gen Actuarial = (isatcode == 56411)
	gen Fiscale = (isatcode == 56402)




	gen MsBA = (isatcode == 60644)
	gen MsFinance = (isatcode == 60046)
	gen MsEc = (isatcode == 60177)
	gen MsAenC = (isatcode == 60900)
	gen MsBusEc = (isatcode == 60901)
	gen MsBAN = (isatcode == 60984)
	gen MsEconomics = (isatcode == 66401)
	gen MsFiscale = (isatcode == 66402)
	gen MsActuarial = (isatcode == 66411)
	gen MsBIMT = (isatcode == 60476)

	keep if isatcode == `iso'





	gen x = (!missing(Studielink_Nummer))
	egen aantal = total(x)
	scalar aanmelding2024 = aantal[1]
	egen dreft = total(deft)
	scalar totdeft2024  = dreft[1]


	
	drop if ((mdy(6,1,2024)< Datumaanmelding))


	gen uva1inschrijving = (TotIns ==1)
	gen uva2tm4inschrijvingen = (TotIns > 1 & TotIns < 5 )
	gen uva5ofmeerinschrijvingen = (TotIns >= 5)

	

	gen gender = (geslacht == "M")

	gen BLvopl = (Btlvooropl == "Ja") 


	gen taaltoetsbehaald = (Taaltoets == "G") 

	gen taaltoetsnodig = inlist(Vooropleiding_Land, "Nederland", "AustraliÃ«", "Canada", "Ierland", "Malta", "Nieuw-Zeeland", "Zuid-Afrika", "Groot-BrittanniÃ«", "Verenigde Staten van Amerika")


	gen TaalVerplichtGehaald = (taaltoetsbehaald == 1 & taaltoetsnodig == 1)
	gen languagetest =  (taaltoetsbehaald == 0 & taaltoetsnodig == 1)

	gen foundation = 0
	replace foundation = 1 if (!missing(Foundation))



	gen age22plus = ((mdy(9,1,2024)- Birthdate )/365.25)>= 22
	gen age = floor((mdy(9,1,2024) - Birthdate)/365.25)




	gen nieuw_in_hoger_onderwijs = (cho_k == 1)
	gen hbo_instroom = (cho_k == 2)
	gen university_switcher = (cho_k == 4)
	gen study_switch = (cho_k == 5)
	gen herinschrijver = (cho_k == 6)


	gen vwo = (Btlvooropl != "Ja" & nieuw_in_hoger_onderwijs == 1)
	gen nl_met_internationaal_diploma = (Btlvooropl == "Ja" & nieuw_in_hoger_onderwijs == 1 & herkomst == "NL")
	gen EER_nieuw_in_hoger_onderwijs = (Btlvooropl == "Ja" & nieuw_in_hoger_onderwijs == 1 & herkomst == "EER")
	gen rest_nieuw_in_hoger_onderwijs =(Btlvooropl == "Ja" & nieuw_in_hoger_onderwijs == 1 & herkomst == "Rest") 

	gen Meercodes = meercode_v - meercode_a 
	gen Endan = TotIns - Meercodes
	gen OutsideUvA = (Endan < 0)

	drop if herinschrijver == 1
	rename TotIns AdmissionsUvA
	
	
	
	set seed 12345
	gen fold = ceil(runiform()*5)

	save train_with_folds.dta, replace







	import excel "2025data.xlsx", sheet("Sheet1") firstrow clear



	gen EBE = (isatcode ==  59318)
	gen BA = (isatcode == 50897)
	gen BAN = (isatcode == 56856)
	gen EC = (isatcode == 59332)
	gen Actuarial = (isatcode == 56411)
	gen Fiscale = (isatcode == 56402)


	gen MsBA = (isatcode == 60644)
	gen MsFinance = (isatcode == 60046)
	gen MsEc = (isatcode == 60177)
	gen MsAenC = (isatcode == 60900)
	gen MsBusEc = (isatcode == 60901)
	gen MsBAN = (isatcode == 60984)
	gen MsEconomics = (isatcode == 66401)
	gen MsFiscale = (isatcode == 66402)
	gen MsActuarial = (isatcode == 66411)

	keep if isatcode == `iso'


	


	gen deft = (DEFT == "DEFT")



	gen uva1inschrijving = (TotIns ==1)
	gen uva2tm4inschrijvingen = (TotIns > 1 & TotIns < 5 )
	gen uva5ofmeerinschrijvingen = (TotIns >= 5)

	
	

	gen gender = (geslacht == "M")

	gen BLvopl = (Btlvooropl == "Ja") 


	gen taaltoetsbehaald = 0

	replace taaltoetsbehaald = 1 if Uitslag == "G" 
	replace taaltoetsbehaald = 1 if TTuitslag == "Ja"


	gen taaltoetsnodig = 0
	replace taaltoetsnodig = 1 if inlist(Vooropleiding_Land, "Nederland", "AustraliÃ«", "Canada", "Ierland", "Malta", "Nieuw-Zeeland", "Zuid-Afrika", "Groot-BrittanniÃ«", "Verenigde Staten van Amerika")
	replace taaltoetsnodig = 0 if TTuitslag == "Niet nodig"
	replace taaltoetsnodig = 1 if TTuitslag == "Ja"
	replace taaltoetsnodig = 1 if TTuitslag == "Nog niet"


	gen TaalVerplichtGehaald = (taaltoetsbehaald == 1 & taaltoetsnodig == 1)
	gen languagetest =  (taaltoetsbehaald == 0 & taaltoetsnodig == 1)

	gen foundation = 0
	replace foundation = 1 if (!missing(Foundation))



	gen age22plus = ((mdy(9,1,2025)- Birthdate )/365.25)>= 22
	gen age = floor((mdy(9,1,2025) - Birthdate)/365.25)




	gen nieuw_in_hoger_onderwijs = (cho_k == 1)
	gen hbo_instroom = (cho_k == 2)
	gen university_switcher = (cho_k == 4)
	gen study_switch = (cho_k == 5)
	gen herinschrijver = (cho_k == 6)


	gen vwo = (Btlvooropl != "Ja" & nieuw_in_hoger_onderwijs == 1)
	gen nl_met_internationaal_diploma = (Btlvooropl == "Ja" & nieuw_in_hoger_onderwijs == 1 & herkomst == "NL")
	gen EER_nieuw_in_hoger_onderwijs = (Btlvooropl == "Ja" & nieuw_in_hoger_onderwijs == 1 & herkomst == "EER")
	gen rest_nieuw_in_hoger_onderwijs =(Btlvooropl == "Ja" & nieuw_in_hoger_onderwijs == 1 & herkomst == "Rest")

	gen Meercodes = meercode_v - meercode_a 
	gen Endan = TotIns - Meercodes
	gen OutsideUvA = (Endan < 0)
	 
	drop if herinschrijver == 1

	rename TotIns AdmissionsUvA
	 
	gen count = (!missing(Studielink_Nummer))
	 
	

	gen p_hat1 = .
	gen p_hat2 = .
	gen p_hat3 = . 
	gen p_hat4 = .
	gen p_hat5 = .

	save test_preds.dta, replace

	

	forvalues i = 1/5 {
		use train_with_folds.dta, clear 
		keep if fold != `i'
		
		logit deft study_switch vwo university_switcher languagetest AdmissionsUvA OutsideUvA age foundation
		
		
		estimates store Model`i'
		
		*margins,dydx(*) post
		*matrix m`i' = r(b)
		
		
		
		use test_preds.dta, clear
		estimates restore Model`i'
		
		predict phat_tmp, pr 
		
		
		

		replace phat_tmp = 0 if missing(phat_tmp)	
		
		replace p_hat`i' = phat_tmp

		egen tot = total(phat_tmp)
		
		gen var_tmp = phat_tmp * (1 - phat_tmp)
		egen var_sum = total(var_tmp)
		scalar sd`i' = sqrt(var_sum)
		
		scalar sum`i' = tot[1]
		
		drop tot
		drop phat_tmp
		drop var_tmp 
		drop var_sum
		
		
	
	
	}
	
	
	*matrix m_avg`iso' = (m1 + m2 + m3 + m4 + m5)/5
	*matlist m_avg`iso'


		scalar list sd1 sd2 sd3 sd4 sd5 

		scalar list sum1 sum2 sum3 sum4 sum5

		display "Voorspellingen: " (sum1 + sum2 + sum3 + sum4 + sum5) / 5


		
		

		gen p_hat_avg = (p_hat1 + p_hat2 + p_hat3 + p_hat4 + p_hat5) / 5
		gen sd_avg = (sd1 + sd2 + sd3 + sd4 + sd5)/5




		egen Aanmeldingen = total(count)
		gen tot2024 = aanmelding2024
		gen deft2024 = totdeft2024

		gen verwacht = (sum1 + sum2 + sum3 + sum4 + sum5) / 5
		gen lower = verwacht - 1 *sd_avg
		gen upper = verwacht + 1 *sd_avg
		
		replace verwacht = floor(verwacht)
		replace lower = floor(lower)
		replace upper = floor(upper)
		
		save test_preds`iso'.dta, replace
		gen isatcode_used = `iso'
		
		keep Opleiding lower verwacht upper isatcode_used 
		tempfile pred_`iso'
		save `pred_`iso'', replace 
		
	
	
}


foreach iso in 59318 50897 56856 59332 56411 56402 {
	
	use `pred_`iso'', clear
	append using all_predictions.dta
	save all_predictions.dta, replace
	*matlist m_avg`iso'
}

duplicates drop isatcode_used, force

rename isatcode_used isatcode



browse
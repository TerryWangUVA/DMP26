/*--------------------------------------------------
Heterogeneous analysis by college / non-college
Split-sample approach: run the same standard
beta x year double regressions and
experience x beta x year triple regressions
separately for college (educ > 110) and non-college.

Output file names carry _college / _noncollege postfix.

					Edit history

	03-17-2026: Created.
----------------------------------------------------*/

//================== Set Directory =======================//
global folder "C:\Projects\DMP"
cd "$folder"
global raw "$folder/raw"
global output "$folder/output"

/*
cap mkdir "$folder/output"
cap mkdir "$folder/output/tables"
cap mkdir "$folder/output/graphs"
cap mkdir "$folder/output/cleandata"
*/

global tables "$output/tables"
global graphs "$output/graphs"
global data "$output/data"


set more off
///////////////////////////////////////////////////////////



*************************************
**# Prepare dataset
*************************************

use "$data/CPS-ASEC_analysis_Dec01", clear


// drop highschool dropouts and below
keep if educ >= 73

// keep those in job mkt:
keep if labforce == 2

// calculate lnwage and years of work experience
gen real_wage = incwage * 100 / cpiaucsl
gen lnwage = ln(real_wage)
gen educyrs = .

// 12-02 note: CPS use a different coding system for degrees
replace educyrs = 12 if inlist(educ, 73)     // Highschool
replace educyrs = 16 if inlist(educ, 111)    // BA
replace educyrs = 18 if inlist(educ, 123)    // MA
replace educyrs = 19 if inlist(educ, 124)    // Professional
replace educyrs = 20 if inlist(educ, 125)    // PhD

gen exp = age - educyrs - 6
replace exp = max(exp, 0)
gen exp2 = exp^2

replace occsoc = strtrim(occsoc)
rename occsoc occsoc_2010


local ratings ///
	dv_rating_alpha dv_rating_beta dv_rating_gamma ///
	human_rating_alpha human_rating_beta human_rating_gamma ///

merge m:1 occsoc_2010 using "$data/Eloundou_updated_crosswalk"

ren _merge _merge1


preserve

	keep if _merge1 == 3
	tempfile Mer1
	save `Mer1', replace

restore

keep if _merge1 == 1
replace occsoc_2010 = substr(occsoc_2010,1,6) + "X"

drop `ratings'

merge m:1 occsoc_2010 using "$data/Eloundou_updated_crosswalk"
rename _merge _merge2


preserve

	keep if _merge2 == 1
	drop `ratings'
	replace occsoc_2010 = substr(occsoc_2010,1,5) + "XX"
	merge m:1 occsoc_2010 using "$data/Eloundou_updated_crosswalk"
	rename _merge _merge3
	keep if _merge3 == 3
	tempfile Mer3
	save `Mer3', replace

restore


keep if _merge2 == 3
tempfile Mer2
save `Mer2', replace



use `Mer1', clear
append using `Mer2'
append using `Mer3'



gen compmath = inlist(soc_gr, 21)
gen post2023 = (year > 2023)

gen is_college = educ > 110


**************************************************
**# Setup
**************************************************

gen unemployed = inlist(empstat, 21, 22)


// crosswalk for delta unemployment scatter (built from full sample)
preserve

	collapse (mean) `ratings', by(soc_gr)
	keep soc_gr `ratings'
	tempfile crosswalk
	save `crosswalk', replace

restore


tempfile analysis
save `analysis', replace

// outer tempfiles to hold coef data across loop iterations (for combined plots)
tempfile lw_naive_col    lw_sex_col    lw_sexeduc_col    lw_stateYFE_col
tempfile un_naive_col    un_sex_col    un_sexeduc_col    un_stateYFE_col
tempfile lw_naive_noncol lw_sex_noncol lw_sexeduc_noncol lw_stateYFE_noncol
tempfile un_naive_noncol un_sex_noncol un_sexeduc_noncol un_stateYFE_noncol


**************************************************
**# Install parmest if needed
**************************************************

cap ssc install parmest, replace


**************************************************
**# Helper: extract double-interaction coefs
**************************************************

cap program drop make_coef_file
program define make_coef_file
	syntax, ESTname(name) SPECname(string) OUTcome(string) OUTfile(string)

	est restore `estname'
	parmest, norestore

	keep if inlist(parm, ///
		"2018.year#c.dv_rating_beta", ///
		"2019.year#c.dv_rating_beta", ///
		"2020.year#c.dv_rating_beta", ///
		"2021.year#c.dv_rating_beta", ///
		"2023.year#c.dv_rating_beta", ///
		"2024.year#c.dv_rating_beta", ///
		"2025.year#c.dv_rating_beta")

	gen year = .
	replace year = 2018 if parm == "2018.year#c.dv_rating_beta"
	replace year = 2019 if parm == "2019.year#c.dv_rating_beta"
	replace year = 2020 if parm == "2020.year#c.dv_rating_beta"
	replace year = 2021 if parm == "2021.year#c.dv_rating_beta"
	replace year = 2023 if parm == "2023.year#c.dv_rating_beta"
	replace year = 2024 if parm == "2024.year#c.dv_rating_beta"
	replace year = 2025 if parm == "2025.year#c.dv_rating_beta"

	gen spec = "`specname'"
	gen outcome = "`outcome'"

	keep year estimate min95 max95 spec outcome
	sort year
	save "`outfile'", replace
end


**************************************************
**# Main loop: college and noncollege
**************************************************

foreach grp in col noncol {

	use `analysis', clear

	if "`grp'" == "col"    keep if is_college == 1
	if "`grp'" == "noncol" keep if is_college == 0

	eststo clear
	fvset base 2022 year


	**************************************************
	** Log wage regressions
	**************************************************

	*------------------*
	* Table A: simple
	*------------------*

	reghdfe lnwage i.year##c.dv_rating_beta, ///
		noabsorb cluster(occsoc)
	estadd scalar obs = e(N)
	estadd local sex_FE "No"
	estadd local educ_FE "No"
	estadd local state_yFE "No"
	estadd local se_cluster "Occupation"
	sum lnwage if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo lw_A1

	reghdfe lnwage i.year##c.dv_rating_beta, ///
		absorb(sex) cluster(occsoc)
	estadd scalar obs = e(N)
	estadd local sex_FE "Yes"
	estadd local educ_FE "No"
	estadd local state_yFE "No"
	estadd local se_cluster "Occupation"
	sum lnwage if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo lw_A2

	reghdfe lnwage i.year##c.dv_rating_beta, ///
		absorb(sex educ) cluster(occsoc)
	estadd scalar obs = e(N)
	estadd local sex_FE "Yes"
	estadd local educ_FE "Yes"
	estadd local state_yFE "No"
	estadd local se_cluster "Occupation"
	sum lnwage if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo lw_A3

	reghdfe lnwage i.year##c.dv_rating_beta, ///
		absorb(sex educ year#statefip) cluster(occsoc)
	estadd scalar obs = e(N)
	estadd local sex_FE "Yes"
	estadd local educ_FE "Yes"
	estadd local state_yFE "Yes"
	estadd local se_cluster "Occupation"
	sum lnwage if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo lw_A4


	*------------------*
	* Table B: exp interaction
	*------------------*

	reghdfe lnwage c.exp##i.year##c.dv_rating_beta, ///
		noabsorb cluster(occsoc)
	estadd scalar obs = e(N)
	testparm 2024.year#c.exp#c.dv_rating_beta ///
	         2025.year#c.exp#c.dv_rating_beta
	estadd scalar Ftest_p = r(p)
	estadd local sex_FE "No"
	estadd local educ_FE "No"
	estadd local state_yFE "No"
	estadd local se_cluster "Occupation"
	sum lnwage if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo lw_B1

	reghdfe lnwage c.exp##i.year##c.dv_rating_beta, ///
		absorb(sex) cluster(occsoc)
	estadd scalar obs = e(N)
	testparm 2024.year#c.exp#c.dv_rating_beta ///
	         2025.year#c.exp#c.dv_rating_beta
	estadd scalar Ftest_p = r(p)
	estadd local sex_FE "Yes"
	estadd local educ_FE "No"
	estadd local state_yFE "No"
	estadd local se_cluster "Occupation"
	sum lnwage if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo lw_B2

	reghdfe lnwage c.exp##i.year##c.dv_rating_beta, ///
		absorb(sex educ) cluster(occsoc)
	estadd scalar obs = e(N)
	testparm 2024.year#c.exp#c.dv_rating_beta ///
	         2025.year#c.exp#c.dv_rating_beta
	estadd scalar Ftest_p = r(p)
	estadd local sex_FE "Yes"
	estadd local educ_FE "Yes"
	estadd local state_yFE "No"
	estadd local se_cluster "Occupation"
	sum lnwage if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo lw_B3

	reghdfe lnwage c.exp##i.year##c.dv_rating_beta, ///
		absorb(sex educ year#statefip) cluster(occsoc)
	estadd scalar obs = e(N)
	testparm 2024.year#c.exp#c.dv_rating_beta ///
	         2025.year#c.exp#c.dv_rating_beta
	estadd scalar Ftest_p = r(p)
	estadd local sex_FE "Yes"
	estadd local educ_FE "Yes"
	estadd local state_yFE "Yes"
	estadd local se_cluster "Occupation"
	sum lnwage if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo lw_B4


	**************************************************
	** Unemployment regressions
	**************************************************

	*------------------*
	* Table A: simple
	*------------------*

	reghdfe unemployed i.year##c.dv_rating_beta, ///
		noabsorb cluster(occsoc)
	estadd scalar obs = e(N)
	estadd local sex_FE "No"
	estadd local educ_FE "No"
	estadd local state_yFE "No"
	estadd local se_cluster "Occupation"
	sum unemployed if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo un_A1

	reghdfe unemployed i.year##c.dv_rating_beta, ///
		absorb(sex) cluster(occsoc)
	estadd scalar obs = e(N)
	estadd local sex_FE "Yes"
	estadd local educ_FE "No"
	estadd local state_yFE "No"
	estadd local se_cluster "Occupation"
	sum unemployed if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo un_A2

	reghdfe unemployed i.year##c.dv_rating_beta, ///
		absorb(sex educ) cluster(occsoc)
	estadd scalar obs = e(N)
	estadd local sex_FE "Yes"
	estadd local educ_FE "Yes"
	estadd local state_yFE "No"
	estadd local se_cluster "Occupation"
	sum unemployed if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo un_A3

	reghdfe unemployed i.year##c.dv_rating_beta, ///
		absorb(sex educ year#statefip) cluster(occsoc)
	estadd scalar obs = e(N)
	estadd local sex_FE "Yes"
	estadd local educ_FE "Yes"
	estadd local state_yFE "Yes"
	estadd local se_cluster "Occupation"
	sum unemployed if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo un_A4


	*------------------*
	* Table B: exp interaction
	*------------------*

	reghdfe unemployed c.exp##i.year##c.dv_rating_beta, ///
		noabsorb cluster(occsoc)
	estadd scalar obs = e(N)
	testparm 2024.year#c.exp#c.dv_rating_beta ///
	         2025.year#c.exp#c.dv_rating_beta
	estadd scalar Ftest_p = r(p)
	estadd local sex_FE "No"
	estadd local educ_FE "No"
	estadd local state_yFE "No"
	estadd local se_cluster "Occupation"
	sum unemployed if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo un_B1

	reghdfe unemployed c.exp##i.year##c.dv_rating_beta, ///
		absorb(sex) cluster(occsoc)
	estadd scalar obs = e(N)
	testparm 2024.year#c.exp#c.dv_rating_beta ///
	         2025.year#c.exp#c.dv_rating_beta
	estadd scalar Ftest_p = r(p)
	estadd local sex_FE "Yes"
	estadd local educ_FE "No"
	estadd local state_yFE "No"
	estadd local se_cluster "Occupation"
	sum unemployed if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo un_B2

	reghdfe unemployed c.exp##i.year##c.dv_rating_beta, ///
		absorb(sex educ) cluster(occsoc)
	estadd scalar obs = e(N)
	testparm 2024.year#c.exp#c.dv_rating_beta ///
	         2025.year#c.exp#c.dv_rating_beta
	estadd scalar Ftest_p = r(p)
	estadd local sex_FE "Yes"
	estadd local educ_FE "Yes"
	estadd local state_yFE "No"
	estadd local se_cluster "Occupation"
	sum unemployed if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo un_B3

	reghdfe unemployed c.exp##i.year##c.dv_rating_beta, ///
		absorb(sex educ year#statefip) cluster(occsoc)
	estadd scalar obs = e(N)
	testparm 2024.year#c.exp#c.dv_rating_beta ///
	         2025.year#c.exp#c.dv_rating_beta
	estadd scalar Ftest_p = r(p)
	estadd local sex_FE "Yes"
	estadd local educ_FE "Yes"
	estadd local state_yFE "Yes"
	estadd local se_cluster "Occupation"
	sum unemployed if e(sample)
	estadd scalar depvar_mean = r(mean)
	eststo un_B4


	////////////////////////////////////////////////////////////////////////////////
	local keepA ///
		2018.year#c.dv_rating_beta ///
		2019.year#c.dv_rating_beta ///
		2020.year#c.dv_rating_beta ///
		2021.year#c.dv_rating_beta ///
		2023.year#c.dv_rating_beta ///
		2024.year#c.dv_rating_beta ///
		2025.year#c.dv_rating_beta

	local keepB ///
		2018.year#c.exp#c.dv_rating_beta ///
		2019.year#c.exp#c.dv_rating_beta ///
		2020.year#c.exp#c.dv_rating_beta ///
		2021.year#c.exp#c.dv_rating_beta ///
		2023.year#c.exp#c.dv_rating_beta ///
		2024.year#c.exp#c.dv_rating_beta ///
		2025.year#c.exp#c.dv_rating_beta


	**************************************************
	** Table: logwage A
	**************************************************

	esttab lw_A1 lw_A2 lw_A3 lw_A4 ///
		using "$tables/logwage_tableA_`grp'.tex", replace ///
		cells(b(star fmt(a3)) se(fmt(a3) par)) ///
		style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
		keep(`keepA') ///
		varlabels( ///
			2018.year#c.dv_rating_beta "2018 $\times$ AI exposure" ///
			2019.year#c.dv_rating_beta "2019 $\times$ AI exposure" ///
			2020.year#c.dv_rating_beta "2020 $\times$ AI exposure" ///
			2021.year#c.dv_rating_beta "2021 $\times$ AI exposure" ///
			2023.year#c.dv_rating_beta "2023 $\times$ AI exposure" ///
			2024.year#c.dv_rating_beta "2024 $\times$ AI exposure" ///
			2025.year#c.dv_rating_beta "2025 $\times$ AI exposure" ///
		) ///
		stats(depvar_mean sex_FE educ_FE state_yFE se_cluster obs, ///
		      fmt(3 0 0 0 0 %12.0gc) ///
		      labels("Mean of dependent variable" ///
		             "Sex FE" ///
		             "Education FE" ///
		             "State $\times$ Year FE" ///
		             "SE clustered at" ///
		             "Observations")) ///
		booktabs collabels(none) mlabels(none) nonumbers nomtitles gaps nonotes ///
		prehead( ///
			"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" ///
			"\begin{tabular}{l*{4}{c}}" ///
			"\toprule" ///
			"Dependent Variable: & \multicolumn{4}{c}{Log Wage} \\" ///
			"\cmidrule(lr){2-5}" ///
			" & (1) & (2) & (3) & (4) \\" ///
		) ///
		postfoot( ///
			"\bottomrule" ///
			"\end{tabular}" )


	**************************************************
	** Table: logwage B
	**************************************************

	esttab lw_B1 lw_B2 lw_B3 lw_B4 ///
		using "$tables/logwage_tableB_`grp'.tex", replace ///
		cells(b(star fmt(a3)) se(fmt(a3) par)) ///
		style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
		keep(`keepB') ///
		varlabels( ///
			2018.year#c.exp#c.dv_rating_beta "2018 $\times$ Experience $\times$ AI exposure" ///
			2019.year#c.exp#c.dv_rating_beta "2019 $\times$ Experience $\times$ AI exposure" ///
			2020.year#c.exp#c.dv_rating_beta "2020 $\times$ Experience $\times$ AI exposure" ///
			2021.year#c.exp#c.dv_rating_beta "2021 $\times$ Experience $\times$ AI exposure" ///
			2023.year#c.exp#c.dv_rating_beta "2023 $\times$ Experience $\times$ AI exposure" ///
			2024.year#c.exp#c.dv_rating_beta "2024 $\times$ Experience $\times$ AI exposure" ///
			2025.year#c.exp#c.dv_rating_beta "2025 $\times$ Experience $\times$ AI exposure" ///
		) ///
		stats(depvar_mean sex_FE educ_FE state_yFE se_cluster obs, ///
		      fmt(3 0 0 0 0 %12.0gc) ///
		      labels("Mean of dependent variable" ///
		             "Sex FE" ///
		             "Education FE" ///
		             "State $\times$ Year FE" ///
		             "SE clustered at" ///
		             "Observations")) ///
		booktabs collabels(none) mlabels(none) nonumbers nomtitles gaps nonotes ///
		prehead( ///
			"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" ///
			"\begin{tabular}{l*{4}{c}}" ///
			"\toprule" ///
			"Dependent Variable: & \multicolumn{4}{c}{Log Wage} \\" ///
			"\cmidrule(lr){2-5}" ///
			" & (1) & (2) & (3) & (4) \\" ///
		) ///
		postfoot( ///
			"\bottomrule" ///
			"\end{tabular}" )


	**************************************************
	** Table: unemployment A
	**************************************************

	esttab un_A1 un_A2 un_A3 un_A4 ///
		using "$tables/unemp_tableA_`grp'.tex", replace ///
		cells(b(star fmt(a3)) se(fmt(a3) par)) ///
		style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
		keep(`keepA') ///
		varlabels( ///
			2018.year#c.dv_rating_beta "2018 $\times$ AI exposure" ///
			2019.year#c.dv_rating_beta "2019 $\times$ AI exposure" ///
			2020.year#c.dv_rating_beta "2020 $\times$ AI exposure" ///
			2021.year#c.dv_rating_beta "2021 $\times$ AI exposure" ///
			2023.year#c.dv_rating_beta "2023 $\times$ AI exposure" ///
			2024.year#c.dv_rating_beta "2024 $\times$ AI exposure" ///
			2025.year#c.dv_rating_beta "2025 $\times$ AI exposure" ///
		) ///
		stats(depvar_mean sex_FE educ_FE state_yFE se_cluster obs, ///
		      fmt(3 0 0 0 0 %12.0gc) ///
		      labels("Mean of dependent variable" ///
		             "Sex FE" ///
		             "Education FE" ///
		             "State $\times$ Year FE" ///
		             "SE clustered at" ///
		             "Observations")) ///
		booktabs collabels(none) mlabels(none) nonumbers nomtitles gaps nonotes ///
		prehead( ///
			"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" ///
			"\begin{tabular}{l*{4}{c}}" ///
			"\toprule" ///
			"Dependent Variable: & \multicolumn{4}{c}{Unemployment} \\" ///
			"\cmidrule(lr){2-5}" ///
			" & (1) & (2) & (3) & (4) \\" ///
		) ///
		postfoot( ///
			"\bottomrule" ///
			"\end{tabular}" )


	**************************************************
	** Table: unemployment B
	**************************************************

	esttab un_B1 un_B2 un_B3 un_B4 ///
		using "$tables/unemp_tableB_`grp'.tex", replace ///
		cells(b(star fmt(a3)) se(fmt(a3) par)) ///
		style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
		keep(`keepB') ///
		varlabels( ///
			2018.year#c.exp#c.dv_rating_beta "2018 $\times$ Experience $\times$ AI exposure" ///
			2019.year#c.exp#c.dv_rating_beta "2019 $\times$ Experience $\times$ AI exposure" ///
			2020.year#c.exp#c.dv_rating_beta "2020 $\times$ Experience $\times$ AI exposure" ///
			2021.year#c.exp#c.dv_rating_beta "2021 $\times$ Experience $\times$ AI exposure" ///
			2023.year#c.exp#c.dv_rating_beta "2023 $\times$ Experience $\times$ AI exposure" ///
			2024.year#c.exp#c.dv_rating_beta "2024 $\times$ Experience $\times$ AI exposure" ///
			2025.year#c.exp#c.dv_rating_beta "2025 $\times$ Experience $\times$ AI exposure" ///
		) ///
		stats(depvar_mean sex_FE educ_FE state_yFE se_cluster obs, ///
		      fmt(3 0 0 0 0 %12.0gc) ///
		      labels("Mean of dependent variable" ///
		             "Sex FE" ///
		             "Education FE" ///
		             "State $\times$ Year FE" ///
		             "SE clustered at" ///
		             "Observations")) ///
		booktabs collabels(none) mlabels(none) nonumbers nomtitles gaps nonotes ///
		prehead( ///
			"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" ///
			"\begin{tabular}{l*{4}{c}}" ///
			"\toprule" ///
			"Dependent Variable: & \multicolumn{4}{c}{Unemployment} \\" ///
			"\cmidrule(lr){2-5}" ///
			" & (1) & (2) & (3) & (4) \\" ///
		) ///
		postfoot( ///
			"\bottomrule" ///
			"\end{tabular}" )


	**************************************************
	** Coef plots: year x dv_rating_beta
	**    (double-interaction, Table A specs only)
	**************************************************

	tempfile lw_naive lw_sex lw_sexeduc lw_stateYFE un_naive un_sex un_sexeduc un_stateYFE

	make_coef_file, estname(lw_A1) specname("Naive")                    outcome("Log wage")     outfile(`lw_naive')
	make_coef_file, estname(lw_A2) specname("Sex FE")                   outcome("Log wage")     outfile(`lw_sex')
	make_coef_file, estname(lw_A3) specname("Sex + educ FE")            outcome("Log wage")     outfile(`lw_sexeduc')
	make_coef_file, estname(lw_A4) specname("Sex + educ + state×yr FE") outcome("Log wage")     outfile(`lw_stateYFE')

	make_coef_file, estname(un_A1) specname("Naive")                    outcome("Unemployment") outfile(`un_naive')
	make_coef_file, estname(un_A2) specname("Sex FE")                   outcome("Unemployment") outfile(`un_sex')
	make_coef_file, estname(un_A3) specname("Sex + educ FE")            outcome("Unemployment") outfile(`un_sexeduc')
	make_coef_file, estname(un_A4) specname("Sex + educ + state×yr FE") outcome("Unemployment") outfile(`un_stateYFE')

	// copy to outer tempfiles for combined plots after the loop
	use `lw_naive', clear
	save `lw_naive_`grp'', replace
	use `lw_sex', clear
	save `lw_sex_`grp'', replace
	use `lw_sexeduc', clear
	save `lw_sexeduc_`grp'', replace
	use `lw_stateYFE', clear
	save `lw_stateYFE_`grp'', replace
	use `un_naive', clear
	save `un_naive_`grp'', replace
	use `un_sex', clear
	save `un_sex_`grp'', replace
	use `un_sexeduc', clear
	save `un_sexeduc_`grp'', replace
	use `un_stateYFE', clear
	save `un_stateYFE_`grp'', replace


	*------------------*
	* Log wage: naive
	*------------------*
	use `lw_naive', clear
	insobs 1
	replace year = 2022 in L
	replace estimate = 0 in L
	replace min95 = . in L
	replace max95 = . in L
	sort year

	twoway ///
		(rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
			lcolor(navy) lpattern(solid) lwidth(medthin)) ///
		(line estimate year, ///
			lcolor(maroon) lpattern(solid) lwidth(medium)) ///
		(scatter estimate year, ///
			mcolor(maroon) msymbol(O) msize(medlarge)), ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		yline(0, lcolor(gs8) lpattern(solid)) ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Coefficient on year × AI exposure") ///
		title("Log Wage: Naive Specification (`grp')") ///
		legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(lw_naive_`grp', replace)
	graph export "$graphs/lw_naive_plot_`grp'.pdf", replace


	*------------------*
	* Log wage: sex FE
	*------------------*
	use `lw_sex', clear
	insobs 1
	replace year = 2022 in L
	replace estimate = 0 in L
	replace min95 = . in L
	replace max95 = . in L
	sort year

	twoway ///
		(rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
			lcolor(navy) lpattern(solid) lwidth(medthin)) ///
		(line estimate year, ///
			lcolor(maroon) lpattern(solid) lwidth(medium)) ///
		(scatter estimate year, ///
			mcolor(maroon) msymbol(O) msize(medlarge)), ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		yline(0, lcolor(gs8) lpattern(solid)) ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Coefficient on year × AI exposure") ///
		title("Log Wage: Sex Fixed Effects (`grp')") ///
		legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(lw_sexFE_`grp', replace)
	graph export "$graphs/lw_sexFE_plot_`grp'.pdf", replace


	*------------------*
	* Log wage: sex + educ FE
	*------------------*
	use `lw_sexeduc', clear
	insobs 1
	replace year = 2022 in L
	replace estimate = 0 in L
	replace min95 = . in L
	replace max95 = . in L
	sort year

	twoway ///
		(rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
			lcolor(navy) lpattern(solid) lwidth(medthin)) ///
		(line estimate year, ///
			lcolor(maroon) lpattern(solid) lwidth(medium)) ///
		(scatter estimate year, ///
			mcolor(maroon) msymbol(O) msize(medlarge)), ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		yline(0, lcolor(gs8) lpattern(solid)) ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Coefficient on year × AI exposure") ///
		title("Log Wage: Sex and Education Fixed Effects (`grp')") ///
		legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(lw_sexeducFE_`grp', replace)
	graph export "$graphs/lw_sexeducFE_plot_`grp'.pdf", replace


	*------------------*
	* Unemployment: naive
	*------------------*
	use `un_naive', clear
	insobs 1
	replace year = 2022 in L
	replace estimate = 0 in L
	replace min95 = . in L
	replace max95 = . in L
	sort year

	twoway ///
		(rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
			lcolor(navy) lpattern(solid) lwidth(medthin)) ///
		(line estimate year, ///
			lcolor(maroon) lpattern(solid) lwidth(medium)) ///
		(scatter estimate year, ///
			mcolor(maroon) msymbol(O) msize(medlarge)), ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		yline(0, lcolor(gs8) lpattern(solid)) ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Coefficient on year × AI exposure") ///
		title("Unemployment: Naive Specification (`grp')") ///
		legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(unemp_naive_`grp', replace)
	graph export "$graphs/unemp_naive_plot_`grp'.pdf", replace


	*------------------*
	* Unemployment: sex FE
	*------------------*
	use `un_sex', clear
	insobs 1
	replace year = 2022 in L
	replace estimate = 0 in L
	replace min95 = . in L
	replace max95 = . in L
	sort year

	twoway ///
		(rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
			lcolor(navy) lpattern(solid) lwidth(medthin)) ///
		(line estimate year, ///
			lcolor(maroon) lpattern(solid) lwidth(medium)) ///
		(scatter estimate year, ///
			mcolor(maroon) msymbol(O) msize(medlarge)), ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		yline(0, lcolor(gs8) lpattern(solid)) ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Coefficient on year × AI exposure") ///
		title("Unemployment: Sex Fixed Effects (`grp')") ///
		legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(unemp_sexFE_`grp', replace)
	graph export "$graphs/unemp_sexFE_plot_`grp'.pdf", replace


	*------------------*
	* Unemployment: sex + educ FE
	*------------------*
	use `un_sexeduc', clear
	insobs 1
	replace year = 2022 in L
	replace estimate = 0 in L
	replace min95 = . in L
	replace max95 = . in L
	sort year

	twoway ///
		(rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
			lcolor(navy) lpattern(solid) lwidth(medthin)) ///
		(line estimate year, ///
			lcolor(maroon) lpattern(solid) lwidth(medium)) ///
		(scatter estimate year, ///
			mcolor(maroon) msymbol(O) msize(medlarge)), ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		yline(0, lcolor(gs8) lpattern(solid)) ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Coefficient on year × AI exposure") ///
		title("Unemployment: Sex and Education Fixed Effects (`grp')") ///
		legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(unemp_sexeducFE_`grp', replace)
	graph export "$graphs/unemp_sexeducFE_plot_`grp'.pdf", replace


	*------------------*
	* Log wage: state x year FE
	*------------------*
	use `lw_stateYFE', clear
	insobs 1
	replace year = 2022 in L
	replace estimate = 0 in L
	replace min95 = . in L
	replace max95 = . in L
	sort year

	twoway ///
		(rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
			lcolor(navy) lpattern(solid) lwidth(medthin)) ///
		(line estimate year, ///
			lcolor(maroon) lpattern(solid) lwidth(medium)) ///
		(scatter estimate year, ///
			mcolor(maroon) msymbol(O) msize(medlarge)), ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		yline(0, lcolor(gs8) lpattern(solid)) ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Coefficient on year × AI exposure") ///
		title("Log Wage: Sex, Education, and State×Year FE (`grp')") ///
		legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(lw_stateYFE_`grp', replace)
	graph export "$graphs/lw_stateYFE_plot_`grp'.pdf", replace


	*------------------*
	* Unemployment: state x year FE
	*------------------*
	use `un_stateYFE', clear
	insobs 1
	replace year = 2022 in L
	replace estimate = 0 in L
	replace min95 = . in L
	replace max95 = . in L
	sort year

	twoway ///
		(rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
			lcolor(navy) lpattern(solid) lwidth(medthin)) ///
		(line estimate year, ///
			lcolor(maroon) lpattern(solid) lwidth(medium)) ///
		(scatter estimate year, ///
			mcolor(maroon) msymbol(O) msize(medlarge)), ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		yline(0, lcolor(gs8) lpattern(solid)) ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Coefficient on year × AI exposure") ///
		title("Unemployment: Sex, Education, and State×Year FE (`grp')") ///
		legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(unemp_stateYFE_`grp', replace)
	graph export "$graphs/unemp_stateYFE_plot_`grp'.pdf", replace


	*************************************
	** DiD unemployment scatter
	**  (u2024-u2023) - (u2023-u2022)
	*************************************

	use `analysis', clear

	if "`grp'" == "col"    keep if is_college == 1
	if "`grp'" == "noncol" keep if is_college == 0

	collapse (mean) u_rate = unemployed, by(soc_gr year)

	keep if inlist(year, 2022, 2023, 2024)

	reshape wide u_rate, i(soc_gr) j(year)

	gen delta_unemp = (u_rate2024 - u_rate2023) - (u_rate2023 - u_rate2022)

	merge m:1 soc_gr using `crosswalk'
	keep if _merge == 3
	drop _merge

	twoway ///
		(scatter delta_unemp dv_rating_beta, ///
			msize(small) ///
			mcolor("232 119 34")) ///
		(lfit delta_unemp dv_rating_beta, ///
			lwidth(medthick) ///
			lcolor("0 33 71")), ///
		yline(0) ///
		xscale(range(0 0.8)) ///
		xlabel(0(.2)0.8) ///
		title("DiD Unemployment vs AI Exposure (`grp')") ///
		ytitle("(u2024−u2023)−(u2023−u2022)") ///
		xtitle("AI Exposure (Eloundou Beta)") ///
		legend(order(1 "Occupation" 2 "Linear fit") ///
		       position(6) rows(1) region(lstyle(none)))

	graph export "$graphs/delta_unemp_did_`grp'.pdf", replace


} // end foreach grp


**************************************************
**# Combined coef plots: college vs. non-college
**   (colComb postfix)
**************************************************

// helper to prep one group's tempfile with 2022 baseline and grp label
// called inline below; no program needed — just repeated pattern

*------------------*
* Log wage: naive
*------------------*
use `lw_naive_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
tempfile tmp_c
save `tmp_c', replace

use `lw_naive_noncol', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "Non-college"
append using `tmp_c'

gen x = year - 0.1 if grp == "College"
replace x = year + 0.1 if grp == "Non-college"
sort grp year

twoway ///
	(rcap min95 max95 x if grp=="College" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(navy) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="College", ///
		lcolor(navy) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="College", ///
		mcolor(navy) msymbol(O) msize(medlarge)) ///
	(rcap min95 max95 x if grp=="Non-college" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(maroon) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="Non-college", ///
		lcolor(maroon) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="Non-college", ///
		mcolor(maroon) msymbol(D) msize(medlarge)), ///
	xline(2022.5, lcolor(gs8) lpattern(dash)) ///
	yline(0, lcolor(gs8) lpattern(solid)) ///
	xlabel(2018(1)2025) ///
	xtitle("Year") ///
	ytitle("Coefficient on year × AI exposure") ///
	title("Log Wage: Naive Specification") ///
	legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(lw_naive_colComb, replace)
graph export "$graphs/lw_naive_plot_colComb.pdf", replace


*------------------*
* Log wage: sex FE
*------------------*
use `lw_sex_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
tempfile tmp_c
save `tmp_c', replace

use `lw_sex_noncol', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "Non-college"
append using `tmp_c'

gen x = year - 0.1 if grp == "College"
replace x = year + 0.1 if grp == "Non-college"
sort grp year

twoway ///
	(rcap min95 max95 x if grp=="College" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(navy) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="College", ///
		lcolor(navy) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="College", ///
		mcolor(navy) msymbol(O) msize(medlarge)) ///
	(rcap min95 max95 x if grp=="Non-college" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(maroon) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="Non-college", ///
		lcolor(maroon) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="Non-college", ///
		mcolor(maroon) msymbol(D) msize(medlarge)), ///
	xline(2022.5, lcolor(gs8) lpattern(dash)) ///
	yline(0, lcolor(gs8) lpattern(solid)) ///
	xlabel(2018(1)2025) ///
	xtitle("Year") ///
	ytitle("Coefficient on year × AI exposure") ///
	title("Log Wage: Sex Fixed Effects") ///
	legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(lw_sexFE_colComb, replace)
graph export "$graphs/lw_sexFE_plot_colComb.pdf", replace


*------------------*
* Log wage: sex + educ FE
*------------------*
use `lw_sexeduc_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
tempfile tmp_c
save `tmp_c', replace

use `lw_sexeduc_noncol', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "Non-college"
append using `tmp_c'

gen x = year - 0.1 if grp == "College"
replace x = year + 0.1 if grp == "Non-college"
sort grp year

twoway ///
	(rcap min95 max95 x if grp=="College" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(navy) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="College", ///
		lcolor(navy) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="College", ///
		mcolor(navy) msymbol(O) msize(medlarge)) ///
	(rcap min95 max95 x if grp=="Non-college" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(maroon) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="Non-college", ///
		lcolor(maroon) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="Non-college", ///
		mcolor(maroon) msymbol(D) msize(medlarge)), ///
	xline(2022.5, lcolor(gs8) lpattern(dash)) ///
	yline(0, lcolor(gs8) lpattern(solid)) ///
	xlabel(2018(1)2025) ///
	xtitle("Year") ///
	ytitle("Coefficient on year × AI exposure") ///
	title("Log Wage: Sex and Education Fixed Effects") ///
	legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(lw_sexeducFE_colComb, replace)
graph export "$graphs/lw_sexeducFE_plot_colComb.pdf", replace


*------------------*
* Unemployment: naive
*------------------*
use `un_naive_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
tempfile tmp_c
save `tmp_c', replace

use `un_naive_noncol', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "Non-college"
append using `tmp_c'

gen x = year - 0.1 if grp == "College"
replace x = year + 0.1 if grp == "Non-college"
sort grp year

twoway ///
	(rcap min95 max95 x if grp=="College" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(navy) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="College", ///
		lcolor(navy) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="College", ///
		mcolor(navy) msymbol(O) msize(medlarge)) ///
	(rcap min95 max95 x if grp=="Non-college" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(maroon) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="Non-college", ///
		lcolor(maroon) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="Non-college", ///
		mcolor(maroon) msymbol(D) msize(medlarge)), ///
	xline(2022.5, lcolor(gs8) lpattern(dash)) ///
	yline(0, lcolor(gs8) lpattern(solid)) ///
	xlabel(2018(1)2025) ///
	xtitle("Year") ///
	ytitle("Coefficient on year × AI exposure") ///
	title("Unemployment: Naive Specification") ///
	legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(unemp_naive_colComb, replace)
graph export "$graphs/unemp_naive_plot_colComb.pdf", replace


*------------------*
* Unemployment: sex FE
*------------------*
use `un_sex_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
tempfile tmp_c
save `tmp_c', replace

use `un_sex_noncol', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "Non-college"
append using `tmp_c'

gen x = year - 0.1 if grp == "College"
replace x = year + 0.1 if grp == "Non-college"
sort grp year

twoway ///
	(rcap min95 max95 x if grp=="College" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(navy) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="College", ///
		lcolor(navy) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="College", ///
		mcolor(navy) msymbol(O) msize(medlarge)) ///
	(rcap min95 max95 x if grp=="Non-college" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(maroon) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="Non-college", ///
		lcolor(maroon) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="Non-college", ///
		mcolor(maroon) msymbol(D) msize(medlarge)), ///
	xline(2022.5, lcolor(gs8) lpattern(dash)) ///
	yline(0, lcolor(gs8) lpattern(solid)) ///
	xlabel(2018(1)2025) ///
	xtitle("Year") ///
	ytitle("Coefficient on year × AI exposure") ///
	title("Unemployment: Sex Fixed Effects") ///
	legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(unemp_sexFE_colComb, replace)
graph export "$graphs/unemp_sexFE_plot_colComb.pdf", replace


*------------------*
* Unemployment: sex + educ FE
*------------------*
use `un_sexeduc_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
tempfile tmp_c
save `tmp_c', replace

use `un_sexeduc_noncol', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "Non-college"
append using `tmp_c'

gen x = year - 0.1 if grp == "College"
replace x = year + 0.1 if grp == "Non-college"
sort grp year

twoway ///
	(rcap min95 max95 x if grp=="College" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(navy) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="College", ///
		lcolor(navy) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="College", ///
		mcolor(navy) msymbol(O) msize(medlarge)) ///
	(rcap min95 max95 x if grp=="Non-college" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(maroon) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="Non-college", ///
		lcolor(maroon) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="Non-college", ///
		mcolor(maroon) msymbol(D) msize(medlarge)), ///
	xline(2022.5, lcolor(gs8) lpattern(dash)) ///
	yline(0, lcolor(gs8) lpattern(solid)) ///
	xlabel(2018(1)2025) ///
	xtitle("Year") ///
	ytitle("Coefficient on year × AI exposure") ///
	title("Unemployment: Sex and Education Fixed Effects") ///
	legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(unemp_sexeducFE_colComb, replace)
graph export "$graphs/unemp_sexeducFE_plot_colComb.pdf", replace


*------------------*
* Log wage: state x year FE colComb
*------------------*
use `lw_stateYFE_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
tempfile tmp_c
save `tmp_c', replace

use `lw_stateYFE_noncol', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "Non-college"
append using `tmp_c'

gen x = year - 0.1 if grp == "College"
replace x = year + 0.1 if grp == "Non-college"
sort grp year

twoway ///
	(rcap min95 max95 x if grp=="College" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(navy) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="College", ///
		lcolor(navy) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="College", ///
		mcolor(navy) msymbol(O) msize(medlarge)) ///
	(rcap min95 max95 x if grp=="Non-college" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(maroon) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="Non-college", ///
		lcolor(maroon) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="Non-college", ///
		mcolor(maroon) msymbol(D) msize(medlarge)), ///
	xline(2022.5, lcolor(gs8) lpattern(dash)) ///
	yline(0, lcolor(gs8) lpattern(solid)) ///
	xlabel(2018(1)2025) ///
	xtitle("Year") ///
	ytitle("Coefficient on year × AI exposure") ///
	title("Log Wage: Sex, Education, and State×Year FE") ///
	legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(lw_stateYFE_colComb, replace)
graph export "$graphs/lw_stateYFE_plot_colComb.pdf", replace


*------------------*
* Unemployment: state x year FE colComb
*------------------*
use `un_stateYFE_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
tempfile tmp_c
save `tmp_c', replace

use `un_stateYFE_noncol', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "Non-college"
append using `tmp_c'

gen x = year - 0.1 if grp == "College"
replace x = year + 0.1 if grp == "Non-college"
sort grp year

twoway ///
	(rcap min95 max95 x if grp=="College" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(navy) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="College", ///
		lcolor(navy) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="College", ///
		mcolor(navy) msymbol(O) msize(medlarge)) ///
	(rcap min95 max95 x if grp=="Non-college" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(maroon) lpattern(solid) lwidth(medthin)) ///
	(line estimate x if grp=="Non-college", ///
		lcolor(maroon) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate x if grp=="Non-college", ///
		mcolor(maroon) msymbol(D) msize(medlarge)), ///
	xline(2022.5, lcolor(gs8) lpattern(dash)) ///
	yline(0, lcolor(gs8) lpattern(solid)) ///
	xlabel(2018(1)2025) ///
	xtitle("Year") ///
	ytitle("Coefficient on year × AI exposure") ///
	title("Unemployment: Sex, Education, and State×Year FE") ///
	legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(unemp_stateYFE_colComb, replace)
graph export "$graphs/unemp_stateYFE_plot_colComb.pdf", replace




**************************************************
**# Within-occupation test (occ x year FE)
**************************************************
/*
Question: is the college vs non-college wage gap in
high-exposure occupations driven by
  H1) within-occupation sorting -- same occupations,
      college and non-college workers performing
      different tasks; or
  H2) between-occupation segregation -- non-college
      workers concentrated in different (worse)
      high-exposure occupations than college workers.

Test: pool both groups, absorb occsoc_2010 # year FE,
and run a triple interaction year x dv_rating_beta x is_college.
The occ x year FE soaks up all between-occupation variation
(including the level year x beta term, which varies only
at the occ-year level). What identifies the triple coefficient
is variation in is_college within the same occupation in
the same year.

If the triple interaction reproduces the split-sample
pattern (college relatively better than non-college in
high-exposure occs post-2022 ==> positive triple coef),
then the compression happens within the same occupations
==> H1.
If the triple coefs collapse to zero, then the split-sample
result was driven by occupation composition ==> H2.
*/

use `analysis', clear
fvset base 2022 year
eststo clear

// occsoc_2010 is a string (some imputed cells like "12-34XX"),
// so encode it to numeric for absorb()/cluster()
egen occ_id = group(occsoc_2010)


*------------------*
* Log wage: triple interaction with occ x year FE
*------------------*

reghdfe lnwage i.year##c.dv_rating_beta##i.is_college, ///
	absorb(sex educ statefip#year occ_id#year) ///
	cluster(occ_id)
estadd scalar obs = e(N)
estadd local sex_FE      "Yes"
estadd local educ_FE     "Yes"
estadd local state_yFE   "Yes"
estadd local occ_yFE     "Yes"
estadd local se_cluster  "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_within

esttab lw_within using "$tables/het_within_occ_lnwage.tex", replace ///
	se star(* 0.10 ** 0.05 *** 0.01) ///
	b(%9.3f) se(%9.3f) ///
	keep(*year#c.dv_rating_beta*) ///
	scalars("sex_FE Sex FE" "educ_FE Education FE" ///
	        "state_yFE State x Year FE" "occ_yFE Occupation x Year FE" ///
	        "se_cluster SE clustering" "obs Observations" ///
	        "depvar_mean Mean of Dep. Var.") ///
	title("Within-Occupation Heterogeneity Test (Log Wage)") ///
	label compress nomtitles


*------------------*
* Unemployment: triple interaction with occ x year FE
*------------------*

reghdfe unemployed i.year##c.dv_rating_beta##i.is_college, ///
	absorb(sex educ statefip#year occ_id#year) ///
	cluster(occ_id)
estadd scalar obs = e(N)
estadd local sex_FE      "Yes"
estadd local educ_FE     "Yes"
estadd local state_yFE   "Yes"
estadd local occ_yFE     "Yes"
estadd local se_cluster  "Occupation"
sum unemployed if e(sample)
estadd scalar depvar_mean = r(mean)
eststo un_within

esttab un_within using "$tables/het_within_occ_unemp.tex", replace ///
	se star(* 0.10 ** 0.05 *** 0.01) ///
	b(%9.3f) se(%9.3f) ///
	keep(*year#c.dv_rating_beta*) ///
	scalars("sex_FE Sex FE" "educ_FE Education FE" ///
	        "state_yFE State x Year FE" "occ_yFE Occupation x Year FE" ///
	        "se_cluster SE clustering" "obs Observations" ///
	        "depvar_mean Mean of Dep. Var.") ///
	title("Within-Occupation Heterogeneity Test (Unemployment)") ///
	label compress nomtitles


*------------------*
* Plot: triple interaction coefficients (lnwage)
*------------------*

est restore lw_within
parmest, norestore

// Stata may reorder factor terms in parm names, so match by
// substring presence rather than a fixed regex order
keep if strpos(parm, "year") > 0           ///
      & strpos(parm, "dv_rating_beta") > 0 ///
      & strpos(parm, "is_college") > 0

// drop omitted/base rows (zero estimate, missing SE)
drop if missing(estimate) | missing(stderr)

gen year = .
forvalues y = 2018/2025 {
	replace year = `y' if strpos(parm, "`y'.year") > 0
}
drop if missing(year)

insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
sort year

twoway ///
	(rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
		lcolor(dkgreen) lpattern(solid) lwidth(medthin)) ///
	(line estimate year, ///
		lcolor(dkgreen) lpattern(solid) lwidth(medium) sort) ///
	(scatter estimate year, ///
		mcolor(dkgreen) msymbol(T) msize(medlarge)), ///
	xline(2022.5, lcolor(gs8) lpattern(dash)) ///
	yline(0, lcolor(gs8) lpattern(solid)) ///
	xlabel(2018(1)2025) ///
	xtitle("Year") ///
	ytitle("Triple interaction: year x exposure x college") ///
	title("Within-occupation college vs non-college gap by exposure") ///
	legend(off) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(lw_within_plot, replace)
graph export "$graphs/lw_within_plot.pdf", replace

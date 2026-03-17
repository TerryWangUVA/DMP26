/*--------------------------------------------------
For analyzing IPMUS ACS Data (2019 - 2024)

					Edit history

	01-13-2026: Started.
	01-23-2026: Removed legacy code. 
	02-06-2026: Added unemployment regs
----------------------------------------------------*/

//================== Set Direcotry =======================//
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
replace educyrs = 12 if inlist(educ, 73) // Highschool 
replace educyrs = 16 if inlist(educ, 111) // BA              
replace educyrs = 18 if inlist(educ, 123) // MA 
replace educyrs = 19 if inlist(educ, 124) // Professional 
replace educyrs = 20 if inlist(educ, 125) // PhD

gen exp = age - educyrs - 6


replace exp = max(exp,0) 
gen exp2 = exp^2

merge m:1 soc_gr using "$data/interim/ACS_Rating_Gr"

keep if _merge == 3

drop _merge


gen compmath = inlist(soc_gr, 21)
gen post2023 = (year > 2023)



*************************************
**# log wage
*************************************


// continuous reg, fe == sex race hispan educ
reghdfe lnwage c.exp##i.year##c.dv_rating_beta_gr, ///
	absorb(sex race hispan educ) cluster(occsoc)
testparm 2024.year#c.exp#c.dv_rating_beta_gr ///
		2025.year#c.exp#c.dv_rating_beta_gr
	
// compmath indicator reg, fe == sex race hispan educ
reghdfe lnwage c.exp##i.year##i.compmath, ///
	absorb(sex race hispan educ) cluster(occsoc)
testparm 2024.year#c.exp#1.compmath ///
		2025.year#c.exp#1.compmath


*************************************
**# Unemployment
*************************************



gen unemployed = inlist(empstat, 21, 22)

// continuous reg, fe == sex race hispan educ
reghdfe unemployed c.exp##i.year##c.dv_rating_beta_gr, ///
    absorb(sex race hispan educ) cluster(occsoc)
	testparm 2024.year#c.exp#c.dv_rating_beta_gr ///
		2025.year#c.exp#c.dv_rating_beta_gr
	

// compmath indicator reg, fe == sex race hispan educ
reghdfe unemployed c.exp##i.year##i.compmath, ///
	absorb(sex race hispan educ) cluster(occsoc)
	testparm 2024.year#c.exp#1.compmath ///
		2025.year#c.exp#1.compmath

	

gen college = 0
replace college = 1 if educ > 100

// compmath indicator reg, fe == sex race hispan educ
reghdfe unemployed .exp##i.year##i.compmath, ///
	absorb(sex race hispan educ) cluster(occsoc)
	testparm 2024.year#c.exp#1.compmath ///
		2025.year#c.exp#1.compmath




reghdfe unemployed i.college##i.year##i.compmath, ///
	absorb(sex race hispan educ) cluster(occsoc)	
	
	
	

reghdfe unemployed i.college##i.year##c.dv_rating_beta_gr, ///
	absorb(sex race hispan educ) cluster(occsoc)
	
	
	
/*
1) plot: (avg 2024 & 2025) - (*some pre period) unemployment rate wrt dv rating

2) * specific level --> next step

3) 




*/
	
	
	
	
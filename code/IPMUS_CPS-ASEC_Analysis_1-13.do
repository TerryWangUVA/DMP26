
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

////////////////////////////////////////////////////////////////////////////////
					
				// 01-13: one-staged regression //

 
/*
TODO:
1) beta_2 --> include or not
2) reg logwage logexp 
3) collapse 
4) returns to college major  (*CPS don't have major)
5) managerial roles

6) COVID / 2-year pool

7) logwage logexp ## exposure score  (i.year) 

8) 4 quartiles of exposed jobs --> reg

9) don't control by college-educated --> use AI exposure, interacted w/ yrs of education


10) educ vs on-the-job training model  

11） triple interaction	
*/

















/////////////////////////////////////////////////////////////////////////////////



*************************************
**# Prepare dataset
*************************************


* Note: this dataset only contains Bachelor and above workers

use "$data/CPS-ASEC_analysis_Dec01", clear


// keep full-time workers with nonzero incwage
keep if wkswork2 == 6
keep if uhrswork1 >= 35
keep if incwage > 0


// drop highschool dropouts and below

keep if educ >= 73

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


*************************************
**# Triple Interaction
*************************************




gen lnexp = ln(exp)


* naive triple-interaction regressions
reghdfe lnwage c.exp##i.year##c.dv_rating_beta_gr, ///
		absorb(sex race hispan educ ind) cluster(ind)




* 



use "$data/CPS-ASEC_analysis_Dec01", clear






















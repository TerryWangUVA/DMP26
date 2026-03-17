
/*--------------------------------------------------
For preparing IPMUS CPS-ASEC Dataset


					Edit history

	11-20-2025: Started. Merged w/ FRED CPI data 
	
	11-23-2025: Added plots
	
	12-01-2025: Updated with new data extract. Archived old Extract.do because
				data is now available directly in .dta format  
	
	2-13-2026: Updated with new soc-cps 
	3-2-2026: Added crosswalk b/w 2018 soc and 2010 soc
	
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


**************************************
**# Prepare 2010 to 2018 soc crosswalk
**************************************

import excel "$raw\Crosswalks\soc_2010_to_2018_crosswalk.xlsx", ///
	sheet("Sorted by 2010") clear

keep A C
drop in 1/9

rename A occsoc_2010
rename C occsoc_2018

replace occsoc_2010 = strtrim(occsoc_2010)
replace occsoc_2018 = strtrim(occsoc_2018)


keep if occsoc_2010 != occsoc_2018


gen rand = runiform()
bysort occsoc_2018 (rand): keep if _n == 1
drop rand

drop if missing(occsoc_2010) | missing(occsoc_2018)




tempfile SOC_2010_2018
save `SOC_2010_2018', replace








use "$raw\IPMUS CPS ASEC\CPS-ASEC18-25_Dec01.dta", clear

replace incwage =. if incwage  == 99999999 | incwage == 99999998


// 12-04 edit: release constraint on college-educ 
keep if age >=22 & age <=65
// keep if educ >= 100

tempfile analysis
save `analysis', replace

****************
**# Merge w/ CPI
****************

use "$data/FRED_CPI_cleaned", clear

keep CPI_year cpiaucsl
rename CPI_year year
lab var year ""

collapse (mean) cpiaucsl, by(year)
lab var cpiaucsl "CPI for All Urban Consumers (year avg)"

tempfile CPI_merge
save `CPI_merge', replace


// merge with ACS data 
use `analysis', clear

merge m:1 year using `CPI_merge'
drop if _merge == 2
drop _merge 

tempfile Master
save `Master', replace

******************************************
**# Merge w/ crosswalk (occupation groups)
******************************************

// soc2010 to occ2010 crosswalk
import excel "$raw\Crosswalks\2010-occ-codes-with-crosswalk-from-2002-2011.xls", ///
			 sheet("2010OccCodeList") clear

// C=2018 Census Code 	D=2018 SOC Code 
keep C D
keep if regexm(C, "^[0-9][0-9][0-9][0-9]$")
drop if D=="none"

ren C occ
ren D occsoc
gen soc_gr = substr(occsoc,1,2)
destring soc_gr, replace 

replace soc_gr = 43 if soc_gr == 4 
destring occ, replace

rename occ occ2010

tempfile SOC_CPS
save `SOC_CPS', replace





use `Master', clear
merge m:1 occ2010 using `SOC_CPS'

drop if _merge == 2
drop _merge


// Reference: https://www.bls.gov/soc/2018/major_groups.htm			 
gen soc_gr_str = ""
replace soc_gr_str = "Management Occupations" ///
    if soc_gr == 11
replace soc_gr_str = "Business and Financial Operations Occupations" ///
    if soc_gr == 13
replace soc_gr_str = "Computer and Mathematical Occupations" ///
    if soc_gr == 15
replace soc_gr_str = "Architecture and Engineering Occupations" ///
    if soc_gr == 17
replace soc_gr_str = "Life, Physical, and Social Science Occupations" ///
    if soc_gr == 19
replace soc_gr_str = "Community and Social Service Occupations" ///
    if soc_gr == 21
replace soc_gr_str = "Legal Occupations" ///
    if soc_gr == 23
replace soc_gr_str = "Educational Instruction and Library Occupations" ///
    if soc_gr == 25
replace soc_gr_str = "Arts, Design, Entertainment, Sports, and Media Occupations" ///
    if soc_gr == 27
replace soc_gr_str = "Healthcare Practitioners and Technical Occupations" ///
    if soc_gr == 29
replace soc_gr_str = "Healthcare Support Occupations" ///
    if soc_gr == 31
replace soc_gr_str = "Protective Service Occupations" ///
    if soc_gr == 33
replace soc_gr_str = "Food Preparation and Serving Related Occupations" ///
    if soc_gr == 35
replace soc_gr_str = "Building and Grounds Cleaning and Maintenance Occupations" ///
    if soc_gr == 37
replace soc_gr_str = "Personal Care and Service Occupations" ///
    if soc_gr == 39
replace soc_gr_str = "Sales and Related Occupations" ///
    if soc_gr == 41
replace soc_gr_str = "Office and Administrative Support Occupations" ///
    if soc_gr == 43
replace soc_gr_str = "Farming, Fishing, and Forestry Occupations" ///
    if soc_gr == 45
replace soc_gr_str = "Construction and Extraction Occupations" ///
    if soc_gr == 47
replace soc_gr_str = "Installation, Maintenance, and Repair Occupations" ///
    if soc_gr == 49
replace soc_gr_str = "Production Occupations" ///
    if soc_gr == 51
replace soc_gr_str = "Transportation and Material Moving Occupations" ///
    if soc_gr == 53



save "$data/CPS-ASEC_analysis_Dec01", replace

**********************************************************
**# Prepare Eloundou dataset for single-occupation merging
**********************************************************

import delimited "$raw\Eloundou\occ_level.csv", clear


local ratings ///
	dv_rating_alpha dv_rating_beta dv_rating_gamma ///
	human_rating_alpha human_rating_beta human_rating_gamma ///


gen str7 soc_base = regexs(1) if regexm(strtrim(onetsoccode), "^([0-9]{2}-[0-9]{4})")


// Eloundou uses detailed 2018 SOC codes.
collapse (mean) `ratings', by(soc_base) 

rename soc_base occsoc_2018

merge 1:1 occsoc_2018 using `SOC_2010_2018'

replace occsoc_2010 = occsoc_2018 if _merge == 1


drop if _merge == 2
drop _merge


gen str6 soc6 = subinstr(occsoc_2010, "-", "", .)

gen str6 soc5X = substr(soc6,1,5) + "X"
gen str6 soc4XX = substr(soc6,1,4) + "XX"
	
tempfile base agg5 agg4

save `base', replace


preserve

	keep soc5X `ratings'
	collapse(mean) `ratings', by(soc5X)
	
	gen str7 occsoc_2010 = substr(soc5X,1,2) + "-" + substr(soc5X,3,3) + "X"
	gen str6 soc_key = soc5X
	gen title = "Aggregate (5-digit + X)"
	save `agg5', replace
	
restore

preserve

	keep soc4XX `ratings'
	collapse(mean) `ratings', by(soc4XX)
	
	gen str7 occsoc_2010 = substr(soc4XX,1,2) + "-" + substr(soc4XX,3,2) + "XX"
	gen str6 soc_key = soc4XX
	gen title = "Aggregate (4-digit + XX)"
	save `agg4', replace
	
restore

gen str6 soc_key = soc6
gen str24 title = "Detailed (6-digit)"

tempfile original
save `original', replace

use `original', clear
append using `agg5'
append using `agg4'




keep occsoc_2010 title `ratings'
order occsoc_2010 title `ratings'

collapse (mean) `ratings', by(occsoc_2010) 



save "$data/Eloundou_updated_crosswalk", replace




	


/*
********************
**# Prelim analysis
********************

use "$data/CPS-ASEC_Prelim_Nov16_analysis.dta", clear

keep if occ >=1000 & occ <=1240

recode age ///
    (22/24 = 1 "Below 25") ///
    (25/29 = 2 "25–29") ///
    (30/34 = 3 "30–34") ///
    (35/39 = 4 "35–39") ///
    (40/44 = 5 "40–44") ///
    (45/49 = 6 "45–49") ///
    (50/54 = 7 "50–54") ///
    (55/59 = 8 "55–59") ///
    (60/65 = 9 "60–65"), gen(age_group)

replace incwage =. if incwage == 999999 | incwage == 999998
gen real_wage = incwage * 100 / cpiaucsl


// mean wage dist graph
preserve 

keep if year == 2019 | year == 2022 | year == 2023

collapse (mean) real_wage, by(age_group year)

replace age_group = age_group - 0.2 if year == 2019
replace age_group = age_group + 0.2 if year == 2023

twoway /// 
    (bar real_wage age_group if year==2019, barwidth(0.2) color(navy)) ///
    (bar real_wage age_group if year==2022, barwidth(0.2) color(orange*0.8)) ///
    (bar real_wage age_group if year==2023, barwidth(0.2) color(maroon)) ///
    (line real_wage age_group if year==2019, lwidth(medthick) lcolor(navy)) ///
    (line real_wage age_group if year==2022, lwidth(medthick) lcolor(orange*0.8)) ///
    (line real_wage age_group if year==2023, lwidth(medthick) lcolor(maroon)), ///
	legend(order(4 "2019" 5 "2022" 6 "2023")) ///
    xlab(1 "Below 25" ///
         2 "25–29" ///
         3 "30–34" ///
         4 "35–39" ///
         5 "40–44" ///
         6 "45–49" ///
         7 "50–54" ///
         8 "55–59" ///
         9 "60–65", angle(45)) ///
	yscale(range(050000)) ///
	ylabel(0(10000)50000, angle(0)) ///
    xtitle("Age Group") ///
    ytitle("Mean Real Income") ///
    title("Mean Real Wage in Computer and Mathematical Occupations (ASEC)",size(med))
		
graph export "$graphs/IT_mean_wage_age_dist_CPS-ASEC.pdf", replace

restore




// median wage dist graph
preserve 

keep if year == 2019 | year == 2022 | year == 2023

collapse (median) real_wage, by(age_group year)

replace age_group = age_group - 0.2 if year == 2019
replace age_group = age_group + 0.2 if year == 2023

twoway /// 
    (bar real_wage age_group if year==2019, barwidth(0.2) color(navy)) ///
    (bar real_wage age_group if year==2022, barwidth(0.2) color(orange*0.8)) ///
    (bar real_wage age_group if year==2023, barwidth(0.2) color(maroon)) ///
    (line real_wage age_group if year==2019, lwidth(medthick) lcolor(navy)) ///
    (line real_wage age_group if year==2022, lwidth(medthick) lcolor(orange*0.8)) ///
    (line real_wage age_group if year==2023, lwidth(medthick) lcolor(maroon)), ///
	legend(order(4 "2019" 5 "2022" 6 "2023")) ///
    xlab(1 "Below 25" ///
         2 "25–29" ///
         3 "30–34" ///
         4 "35–39" ///
         5 "40–44" ///
         6 "45–49" ///
         7 "50–54" ///
         8 "55–59" ///
         9 "60–65", angle(45)) ///
	yscale(range(050000)) ///
	ylabel(0(10000)50000, angle(0)) ///
    xtitle("Age Group") ///
    ytitle("Median Real Income") ///
    title("Median Real Wage in Computer and Mathematical Occupations (ASEC)",size(med))
		
graph export "$graphs/IT_median_wage_age_dist_CPS-ASEC.pdf", replace
restore


// kdensity plots
preserve


twoway (kdensity real_wage if year == 2019, lcolor(navy) lpattern(solid)) ///
	   (kdensity real_wage if year == 2022, lcolor(orange) lpattern(longdash)) ///
       (kdensity real_wage if year == 2023, lcolor(maroon) lpattern(dash)), ///
       legend(label(1 "2019 Distribution") label(2 "2022 Distribution") label(3 "2023 Distribution")) ///
       xtitle("Real Wage") ytitle("Density") title("Wage Distribution in Computer and Mathematical Occupations (ASEC)",size(med))

graph export "$graphs/IT_wage_kd_CPS-ASEC.pdf", replace




twoway ///
    (kdensity age if year==2019, lcolor(navy)   lpattern(solid)) ///
    (kdensity age if year==2022, lcolor(orange) lpattern(longdash)) ///
    (kdensity age if year==2023, lcolor(maroon) lpattern(dash)), ///
    legend( ///
        order( ///
            1 "2019" ///
            2 "2022" ///
            3 "2023")) ///
    xtitle("Age") ///
    ytitle("Density") ///
    title("Age Distribution in Computer and Mathematical Occupations (ASEC)",size(med))


graph export "$graphs/IT_age_kd_CPS-ASEC.pdf", replace


restore
*/	
	
	





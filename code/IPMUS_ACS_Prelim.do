
/*--------------------------------------------------
For preparing IPMUS ACS Dataset

					Edit history
	11-16-2025: Started
	11-18-2025: Prelim Analysis
	11-20-2025: Merge w/ FRED CPI data. Updated prelim analysis
	11-27-2025: Merge w/ Eloundou
	12-02-2025: Pooled version for SOC Occuatpion-Exposure Rating
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
cap mkdir "$folder/output/data"
*/

global tables "$output/tables"
global graphs "$output/graphs"
global data "$output/data"


set more off
///////////////////////////////////////////////////////////


use "$data/ACS_Prelim_Nov27.dta", clear

// keep relavent variables
keep year hhwt cluster strata gq pernum perwt relate related sex age birthqtr ///
	 marst birthyr marrno yrmarr race raced hispan hispand bpl bpld ancestr1 ///
	 ancestr1d ancestr2 ancestr2d citizen yrnatur yrimmig yrsusa1 yrsusa2 language ///
	 languaged speakeng tribe tribed racamind racasian racblk racpacis racwht racother ///
	 racnum school educ educd gradeatt gradeattd schltype degfield degfieldd degfield2 ///
	 degfield2d empstat empstatd labforce classwkr classwkrd occ occsoc ///
	 ind indnaics wkswork1 wkswork2 uhrswork looking availble wrkrecal workedyr ///
	 inctot ftotinc incwage incbus00 incss incwelfr incinvst incretir incsupp ///
	 incother incearn poverty cbpoverty vetdisab diffrem diffphys diffmob diffcare ///
	 diffsens diffeye diffhear statefip stateicp region countyfip countyicp puma density ///
	 metro pctmetro city citypop homeland

keep if school == 1 
keep if age>=22 & age<=65


// College-educated = having 7 or more yrs of education
gen college_educated = educ>=7

la def college_educated 0"no" 1"Yes"
la val college_educated college_educated
la var college_educated "Received College Education"

// there is a veteran disability rating (vetdisab), but decided not to use
gen disability = diffrem == 2 | ///
				 diffphys == 2 | ///
				 diffmob == 2 | ///
				 diffcare == 2 | ///
				 diffsens == 2 | ///
				 diffeye == 2 | ///
				 diffhear == 2 

la def disability 0"no" 1"Yes"
la val disability disability
la var disability "Has Disability"


tempfile analysis
save `analysis', replace


**************************
**# Merge FRED CPI data
**************************


// Clean FRED CPI for future use
import delimited "$raw\FRED CPI\CPIAUCSL.csv", clear

lab var cpiaucsl "Consumer Price Index for All Urban Consumers"

gen CPI_date = date(observation_date, "YMD")
format CPI_date %td
la var CPI_date "CPI Observation Date"


gen CPI_ym = mofd(CPI_date)
format CPI_ym %tm
la var CPI_ym "CPI Observation Year-Month"

gen CPI_year = year(CPI_date)
format CPI_year %ty
la var CPI_year "CPI Observation Year"

drop observation_date

save "$data/FRED_CPI_cleaned", replace


// Process FRED CPI dataset for ACS merging 
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



*************************************
**# Merge w/ Eloundou's score dataset 
*************************************

// prepare ONET -> SOC crosswalk
import delimited "$raw\Crosswalks\2019_to_SOC_Crosswalk.csv", varnames(1) clear

ren onetsoc2019code onetsoccode
ren soccode occsoc
drop onetsoc2019title

tempfile ONET_SOC
save `ONET_SOC', replace

// prepare SOC -> ACS crosswalk
import excel "$raw\Crosswalks\nem-occcode-acs-crosswalk.xlsx", clear

//first 5 entries are empty
drop in 1/5

// B=SOC D=ACS E=ACStitle
keep B D E
ren B occsoc 
ren D occ
ren E occtitle

// 3 occsoc are not uniquely identified --> dropping duplicates in mapping
drop if occsoc == "13-1020" & occ != "510"
drop if occsoc == "21-1018" & occ != "2001"
drop if occsoc == "31-1120" & occ != "3601"

tempfile SOC_ACS
save `SOC_ACS', replace

// prepare Eloundou dataset for merge
import delimited "$raw\Eloundou\occ_level.csv", clear

merge 1:1 onetsoccode using `ONET_SOC'

drop if _merge == 2
drop _merge

drop title


// Collapse by 2018-soc codes
collapse (mean) dv_rating_alpha dv_rating_beta dv_rating_gamma ///
				human_rating_alpha human_rating_beta human_rating_gamma, ///
				by(occsoc soctitle)

merge 1:1 occsoc using `SOC_ACS'


// There are 25 mismatches in masterfile -> considering dropping those
drop if _merge == 2 | _merge == 1
drop _merge



// Collapse by 2018-soc codes
collapse (mean) dv_rating_alpha dv_rating_beta dv_rating_gamma ///
				human_rating_alpha human_rating_beta human_rating_gamma, ///
				by(occ occtitle)


la var occ ""
la var occtitle "Occupation Titles"				
la var dv_rating_alpha "GPT Rating E1"
la var dv_rating_beta "GPT Rating E1+0.5E2"
la var dv_rating_gamma "GPT Rating E1+E2"

la var human_rating_alpha "Human Rating E1"
la var human_rating_beta "Human Rating E1+0.5E2"
la var human_rating_gamma "Human Rating E1+E2"

destring occ, replace


tempfile ACS_Rating
save `ACS_Rating', replace
save "$data/interim/ACS_Rating", replace


use `Master', clear

merge m:1 occ using `ACS_Rating'


drop if _merge == 2
drop _merge

//save "$data/ACS_analysis_Nov27.dta", replace

// 12-01 edit: gen soc_gr to for merging 
gen soc_gr = substr(occsoc,1,2)
destring soc_gr, replace

tempfile Master2
save `Master2', replace


////////////////////////////////////////////////////////////////////////////////

****************************************
**# Pooled SOC-Eloundou Exposure (12-01)
****************************************

// Pool occupations by the 22 major groups as defined by BLS
import delimited "$raw\Eloundou\occ_level.csv", clear

gen soc_gr = substr(onetsoc,1,2)
destring soc_gr, replace 

ren dv_rating_alpha dv_rating_alpha_gr
ren dv_rating_beta dv_rating_beta_gr
ren dv_rating_gamma dv_rating_gamma_gr 
ren human_rating_alpha human_rating_alpha_gr
ren human_rating_beta human_rating_beta_gr
ren human_rating_gamma human_rating_gamma_gr



collapse (mean) dv_rating_alpha_gr dv_rating_beta_gr dv_rating_gamma_gr ///
		 human_rating_alpha_gr human_rating_beta_gr human_rating_gamma_gr, by(soc_gr)



la var soc_gr "Occupation Marjor Group"
//la var occtitle "Occupation Titles"				
la var dv_rating_alpha_gr "(Gr) GPT Rating E1"
la var dv_rating_beta_gr "(Gr) GPT Rating E1+0.5E2"
la var dv_rating_gamma_gr "(Gr) GPT Rating E1+E2"

la var human_rating_alpha_gr "(Gr) Human Rating E1"
la var human_rating_beta_gr "(Gr) Human Rating E1+0.5E2"
la var human_rating_gamma_gr "(Gr) Human Rating E1+E2"


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



tempfile ACS_Rating_Gr
save `ACS_Rating_Gr', replace
save "$data/interim/ACS_Rating_Gr", replace


//Merge with main dataset

use `Master2', clear

merge m:1 soc_gr using `ACS_Rating_Gr'

drop if _merge == 1
drop _merge

save "$data/ACS_analysis_Dec01.dta", replace


/*
**************************
**# Some prelim analysis
**************************

use "$data/ACSPrelim_Nov16_analysis", clear



gen IT = substr(occsoc, 1, 2) == "15"

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

keep if IT == 1
keep if year == 2019 | year == 2022 | year == 2023

collapse (mean) real_wage, by(age_group year)


gen age_group_wg = age_group
replace age_group = age_group - 0.2 if year == 2019
replace age_group = age_group + 0.2 if year == 2023

twoway /// 
    (bar real_wage age_group if year==2019, barwidth(0.2) color(navy)) ///
    (bar real_wage age_group if year==2022, barwidth(0.2) color(orange*0.8)) ///
    (bar real_wage age_group if year==2023, barwidth(0.2) color(maroon)) ///
    (line real_wage age_group_wg if year==2019, lwidth(medthick) lcolor(navy)) ///
    (line real_wage age_group_wg if year==2022, lwidth(medthick) lcolor(orange*0.8)) ///
    (line real_wage age_group_wg if year==2023, lwidth(medthick) lcolor(maroon)), ///
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
    title("Mean Real Wage in Computer and Mathematical Occupations",size(med))
		
graph export "$graphs/IT_mean_wage_age_dist.pdf", replace

restore




// median wage dist graph
preserve 

keep if IT == 1
keep if year == 2019 | year == 2022 | year == 2023

collapse (median) real_wage, by(age_group year)

gen age_group_wg = age_group
replace age_group = age_group - 0.2 if year == 2019
replace age_group = age_group + 0.2 if year == 2023

twoway /// 
    (bar real_wage age_group if year==2019, barwidth(0.2) color(navy)) ///
    (bar real_wage age_group if year==2022, barwidth(0.2) color(orange*0.8)) ///
    (bar real_wage age_group if year==2023, barwidth(0.2) color(maroon)) ///
    (line real_wage age_group_wg if year==2019, lwidth(medthick) lcolor(navy)) ///
    (line real_wage age_group_wg if year==2022, lwidth(medthick) lcolor(orange*0.8)) ///
    (line real_wage age_group_wg if year==2023, lwidth(medthick) lcolor(maroon)), ///
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
    title("Median Real Wage in Computer and Mathematical Occupations",size(med))
		
graph export "$graphs/IT_median_wage_age_dist.pdf", replace
restore


// kdensity plots
preserve

keep if IT == 1

twoway (kdensity real_wage if year == 2019, lcolor(navy) lpattern(solid)) ///
	   (kdensity real_wage if year == 2022, lcolor(orange) lpattern(longdash)) ///
       (kdensity real_wage if year == 2023, lcolor(maroon) lpattern(dash)), ///
       legend(label(1 "2019 Distribution") label(2 "2022 Distribution") label(3 "2023 Distribution")) ///
       xtitle("Real Wage") ytitle("Density") title("Wage Distribution in Computer and Mathematical Occupations",size(med))

graph export "$graphs/IT_wage_kd.pdf", replace




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
    title("Age Distribution in Computer and Mathematical Occupations",size(med))


graph export "$graphs/IT_age_kd.pdf", replace


restore
*/
	
	
	

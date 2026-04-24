/*==============================================================================
  cleaning.do
  ----------------------------------------------------------------------------
  Project:   Human in the Loop -- AI Exposure and Labor Market Frictions
  Author:    Leyao Wang, University of Virginia
  Purpose:   Prepare the CPS-ASEC worker-year sample for analysis.
             (1) Clean the FRED CPI-U series (annual means for wage deflation)
             (2) Build the 2010 SOC -> 2018 SOC crosswalk
             (3) Load raw IPUMS CPS-ASEC, restrict the sample, merge CPI and
                 Census->SOC occupation codes with SOC major-group labels
             (4) Process Eloundou et al. (2024) occupation-level AI exposure
                 scores with hierarchical (6 / 5 / 4-digit SOC) aggregation

  Inputs (in $raw):
             IPMUS CPS ASEC/CPS-ASEC18-25_Dec01.dta
             FRED CPI/CPIAUCSL.csv
             Crosswalks/soc_2010_to_2018_crosswalk.xlsx
             Crosswalks/2010-occ-codes-with-crosswalk-from-2002-2011.xls
             Eloundou/occ_level.csv

  Outputs (in $data):
             FRED_CPI_cleaned.dta
             CPS-ASEC_analysis_Dec01.dta          [main analysis sample]
             Eloundou_updated_crosswalk.dta       [exposure scores by SOC]

  Run first, before descriptives.do and analysis.do.
==============================================================================*/


//================== Directory setup =======================//

// Edit this single path to the replication folder's location.
global folder "C:\Projects\DMP\Replication"
cd "$folder"

global raw     "$folder/raw"
global output  "$folder/output"
global tables  "$output/tables"
global graphs  "$output/graphs"
global data    "$output/data"

cap mkdir "$output"
cap mkdir "$output/tables"
cap mkdir "$output/tables/descriptives"
cap mkdir "$output/graphs"
cap mkdir "$output/graphs/descriptives"
cap mkdir "$output/data"

set more off
///////////////////////////////////////////////////////////


**************************************
**# 1. Clean FRED CPI (for wage deflation)
**************************************

import delimited "$raw/FRED CPI/CPIAUCSL.csv", clear

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


**************************************
**# 2. Build 2010 SOC -> 2018 SOC crosswalk
**   (used inside the Eloundou merge below)
**************************************

import excel "$raw/Crosswalks/soc_2010_to_2018_crosswalk.xlsx", ///
    sheet("Sorted by 2010") clear

keep A C
drop in 1/9

rename A occsoc_2010
rename C occsoc_2018

replace occsoc_2010 = strtrim(occsoc_2010)
replace occsoc_2018 = strtrim(occsoc_2018)

// keep only rows where the two differ; collapse many-to-one cases by keeping
// one 2010 code per 2018 code, deterministically (sort on occsoc_2010)
keep if occsoc_2010 != occsoc_2018

bysort occsoc_2018 (occsoc_2010): keep if _n == 1

drop if missing(occsoc_2010) | missing(occsoc_2018)

tempfile SOC_2010_2018
save `SOC_2010_2018', replace


**************************************
**# 3. Prepare the CPS-ASEC analysis sample
**************************************

use "$raw/IPMUS CPS ASEC/CPS-ASEC18-25_Dec01.dta", clear

// IPUMS top-/missing-codes for incwage
replace incwage = . if incwage == 99999999 | incwage == 99999998

// Sample restriction: prime-age workers
keep if age >= 22 & age <= 65

tempfile analysis
save `analysis', replace


//---- merge year-average CPI for wage deflation ----//

use "$data/FRED_CPI_cleaned", clear

keep CPI_year cpiaucsl
rename CPI_year year
collapse (mean) cpiaucsl, by(year)
lab var cpiaucsl "CPI for All Urban Consumers (year average)"

tempfile CPI_merge
save `CPI_merge', replace


use `analysis', clear

merge m:1 year using `CPI_merge'
drop if _merge == 2
drop _merge

tempfile Master
save `Master', replace


//---- merge Census 2010 occupation code -> 2010 SOC code + major-group label ----//

import excel "$raw/Crosswalks/2010-occ-codes-with-crosswalk-from-2002-2011.xls", ///
    sheet("2010OccCodeList") clear

// columns: C = 2018 Census code, D = 2018 SOC code
keep C D
keep if regexm(C, "^[0-9][0-9][0-9][0-9]$")
drop if D == "none"

rename C occ
rename D occsoc

gen soc_gr = substr(occsoc, 1, 2)
destring soc_gr, replace

// BLS collapses "04" into the broader 43 (Office & Admin Support) major group
replace soc_gr = 43 if soc_gr == 4
destring occ, replace

rename occ occ2010

tempfile SOC_CPS
save `SOC_CPS', replace


use `Master', clear
merge m:1 occ2010 using `SOC_CPS'
drop if _merge == 2
drop _merge


// SOC major-group string labels (https://www.bls.gov/soc/2018/major_groups.htm)
gen soc_gr_str = ""
replace soc_gr_str = "Management Occupations"                                       if soc_gr == 11
replace soc_gr_str = "Business and Financial Operations Occupations"                if soc_gr == 13
replace soc_gr_str = "Computer and Mathematical Occupations"                        if soc_gr == 15
replace soc_gr_str = "Architecture and Engineering Occupations"                     if soc_gr == 17
replace soc_gr_str = "Life, Physical, and Social Science Occupations"               if soc_gr == 19
replace soc_gr_str = "Community and Social Service Occupations"                     if soc_gr == 21
replace soc_gr_str = "Legal Occupations"                                            if soc_gr == 23
replace soc_gr_str = "Educational Instruction and Library Occupations"              if soc_gr == 25
replace soc_gr_str = "Arts, Design, Entertainment, Sports, and Media Occupations"   if soc_gr == 27
replace soc_gr_str = "Healthcare Practitioners and Technical Occupations"           if soc_gr == 29
replace soc_gr_str = "Healthcare Support Occupations"                               if soc_gr == 31
replace soc_gr_str = "Protective Service Occupations"                               if soc_gr == 33
replace soc_gr_str = "Food Preparation and Serving Related Occupations"             if soc_gr == 35
replace soc_gr_str = "Building and Grounds Cleaning and Maintenance Occupations"    if soc_gr == 37
replace soc_gr_str = "Personal Care and Service Occupations"                        if soc_gr == 39
replace soc_gr_str = "Sales and Related Occupations"                                if soc_gr == 41
replace soc_gr_str = "Office and Administrative Support Occupations"                if soc_gr == 43
replace soc_gr_str = "Farming, Fishing, and Forestry Occupations"                   if soc_gr == 45
replace soc_gr_str = "Construction and Extraction Occupations"                      if soc_gr == 47
replace soc_gr_str = "Installation, Maintenance, and Repair Occupations"            if soc_gr == 49
replace soc_gr_str = "Production Occupations"                                       if soc_gr == 51
replace soc_gr_str = "Transportation and Material Moving Occupations"               if soc_gr == 53

save "$data/CPS-ASEC_analysis_Dec01", replace


**************************************
**# 4. Eloundou (2024) exposure scores
**   with hierarchical 6-/5-/4-digit SOC aggregation
**************************************

import delimited "$raw/Eloundou/occ_level.csv", clear

local ratings dv_rating_alpha dv_rating_beta dv_rating_gamma ///
              human_rating_alpha human_rating_beta human_rating_gamma

// Eloundou uses detailed 2018 SOC codes (XX-XXXX format)
gen str7 soc_base = regexs(1) if regexm(strtrim(onetsoccode), "^([0-9]{2}-[0-9]{4})")
collapse (mean) `ratings', by(soc_base)

rename soc_base occsoc_2018

// Convert 2018 SOC -> 2010 SOC where possible; otherwise reuse the 2018 code
merge 1:1 occsoc_2018 using `SOC_2010_2018'
replace occsoc_2010 = occsoc_2018 if _merge == 1
drop if _merge == 2
drop _merge

// Build 6-, 5-, and 4-digit SOC keys (the CPS crosswalk may not resolve at 6-digit)
gen str6 soc6   = subinstr(occsoc_2010, "-", "", .)
gen str6 soc5X  = substr(soc6, 1, 5) + "X"
gen str6 soc4XX = substr(soc6, 1, 4) + "XX"

tempfile base agg5 agg4

save `base', replace

// 5-digit aggregate: collapse scores within each 5-digit + X group
preserve
    keep soc5X `ratings'
    collapse (mean) `ratings', by(soc5X)
    gen str7 occsoc_2010 = substr(soc5X, 1, 2) + "-" + substr(soc5X, 3, 3) + "X"
    gen str6 soc_key     = soc5X
    gen title            = "Aggregate (5-digit + X)"
    save `agg5', replace
restore

// 4-digit aggregate: collapse scores within each 4-digit + XX group
preserve
    keep soc4XX `ratings'
    collapse (mean) `ratings', by(soc4XX)
    gen str7 occsoc_2010 = substr(soc4XX, 1, 2) + "-" + substr(soc4XX, 3, 2) + "XX"
    gen str6 soc_key     = soc4XX
    gen title            = "Aggregate (4-digit + XX)"
    save `agg4', replace
restore

// 6-digit (original) rows
gen str6  soc_key = soc6
gen str24 title   = "Detailed (6-digit)"

tempfile original
save `original', replace


// Stack: detailed + 5-digit + 4-digit rows, then collapse to one row per 2010 SOC
use `original', clear
append using `agg5'
append using `agg4'

keep  occsoc_2010 title `ratings'
order occsoc_2010 title `ratings'

collapse (mean) `ratings', by(occsoc_2010)

save "$data/Eloundou_updated_crosswalk", replace


display as text "cleaning.do complete.  Wrote:"
display as text "  $data/FRED_CPI_cleaned.dta"
display as text "  $data/CPS-ASEC_analysis_Dec01.dta"
display as text "  $data/Eloundou_updated_crosswalk.dta"

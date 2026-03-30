/*--------------------------------------------------
For preparing descriptives for IPMUS ACS Data (2019 - 2024)

					Edit history

	03-30-2026: Started.
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
cap mkdir "$output/tables/descriptives"
cap mkdir "$output/graphs/descriptives"
*/

global tables "$output/tables/descriptives"
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

// merge m:1 soc_gr using "$data/interim/ACS_Rating_Gr"

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



preserve

	collapse (mean) `ratings', by(soc_gr)

	keep soc_gr `ratings'

	tempfile crosswalk
	save `crosswalk', replace
 
restore






**************************************************
**# Setup
**************************************************


gen unemployed = inlist(empstat, 21, 22)


tempfile analysis
save `analysis', replace

eststo clear


cap mkdir "$output/tables/descriptives"
cap mkdir "$output/graphs/descriptives"



**************************************************
**# 1. Overall: kdensity of AI exposure
**************************************************

use `analysis', clear

twoway ///
	(kdensity dv_rating_beta, ///
		lcolor(navy) lwidth(medium) lpattern(solid)), ///
	xtitle("AI Exposure Score ({&beta}{subscript:o})", size(medium)) ///
	ytitle("Density", size(medium)) ///
	title("Distribution of AI Exposure Across Workers") ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	legend(off) ///
	name(kdensity_overall, replace)

graph export "$graphs/descriptives/kdensity_beta_overall.pdf", replace



**************************************************
**# 1b. Top/Bottom exposure table (from Eloundou CSV)
**************************************************

* Load the Eloundou occupation-level CSV directly
preserve
	import delimited "$raw/Eloundou/occ_level.csv", clear varnames(1)

	* Keep relevant columns
	keep title dv_rating_beta

	* Sort by beta
	gsort -dv_rating_beta

	* Top 5
	gen rank_top = _n if _n <= 5

	* Bottom 5
	gsort dv_rating_beta
	gen rank_bot = _n if _n <= 5

	* Keep only the rows we need
	keep if rank_top <= 5 | rank_bot <= 5

	* Round for display
	gen beta_display = string(dv_rating_beta, "%6.3f")

	* Export a simple tex table
	* Top 5
	gsort -dv_rating_beta
	listtex title beta_display if rank_top <= 5 ///
		using "$tables/top5_exposed.tex", replace ///
		rstyle(tabular) ///
		head("\begin{tabular}{lc}" "\hline" ///
			 "Occupation & Exposure Score \\" "\hline") ///
		foot("\hline" "\end{tabular}")

	* Bottom 5
	gsort dv_rating_beta
	listtex title beta_display if rank_bot <= 5 ///
		using "$tables/bot5_exposed.tex", replace ///
		rstyle(tabular) ///
		head("\begin{tabular}{lc}" "\hline" ///
			 "Occupation & Exposure Score \\" "\hline") ///
		foot("\hline" "\end{tabular}")
restore



**************************************************
**# 2. Heterogeneity: kdensity by education
**************************************************

use `analysis', clear

twoway ///
	(kdensity dv_rating_beta if is_college == 1, ///
		lcolor(navy) lwidth(medium) lpattern(solid)) ///
	(kdensity dv_rating_beta if is_college == 0, ///
		lcolor(maroon) lwidth(medium) lpattern(dash)), ///
	xtitle("AI Exposure Score ({&beta}{subscript:o})", size(medium)) ///
	ytitle("Density", size(medium)) ///
	title("AI Exposure Distribution: College vs Non-College") ///
	legend(order(1 "College (BA+)" 2 "Non-college") ///
		rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(kdensity_het, replace)

graph export "$graphs/descriptives/kdensity_beta_education.pdf", replace



**************************************************
**# 3a. Time-series: unemployment by exposure quartile
**************************************************

use `analysis', clear

* Create exposure quartile groups
xtile beta_q = dv_rating_beta, nquantiles(4)

label define beta_q_lbl 1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4 (highest)"
label values beta_q beta_q_lbl


*--- Post-2022 version (main) ---

preserve
	keep if year >= 2022

	collapse (mean) unemp_rate = unemployed, by(year beta_q)

	twoway ///
		(connected unemp_rate year if beta_q == 1, ///
			lcolor(navy*0.4) mcolor(navy*0.4) msymbol(O) lwidth(medium)) ///
		(connected unemp_rate year if beta_q == 2, ///
			lcolor(navy*0.7) mcolor(navy*0.7) msymbol(D) lwidth(medium)) ///
		(connected unemp_rate year if beta_q == 3, ///
			lcolor(maroon*0.7) mcolor(maroon*0.7) msymbol(T) lwidth(medium)) ///
		(connected unemp_rate year if beta_q == 4, ///
			lcolor(maroon) mcolor(maroon) msymbol(S) lwidth(medium)), ///
		xlabel(2022(1)2025) ///
		xtitle("Year") ///
		ytitle("Mean Unemployment Rate") ///
		ylabel(0(0.01)0.05) ///
		title("Unemployment by AI Exposure Quartile (Post-2022)") ///
		legend(order(1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4 (highest)") ///
			rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(unemp_ts_post, replace)

	graph export "$graphs/descriptives/unemp_by_quartile_post2022.pdf", replace
restore


// --- All-years version (commented out, uncomment if needed) ---

preserve
	collapse (mean) unemp_rate = unemployed, by(year beta_q)

	twoway ///
		(connected unemp_rate year if beta_q == 1, ///
			lcolor(navy*0.4) mcolor(navy*0.4) msymbol(O) lwidth(medium)) ///
		(connected unemp_rate year if beta_q == 2, ///
			lcolor(navy*0.7) mcolor(navy*0.7) msymbol(D) lwidth(medium)) ///
		(connected unemp_rate year if beta_q == 3, ///
			lcolor(maroon*0.7) mcolor(maroon*0.7) msymbol(T) lwidth(medium)) ///
		(connected unemp_rate year if beta_q == 4, ///
			lcolor(maroon) mcolor(maroon) msymbol(S) lwidth(medium)), ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Mean Unemployment Rate") ///
		ylabel(0(0.01)0.05) ///
		title("Unemployment by AI Exposure Quartile (2018-2025)") ///
		legend(order(1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4 (highest)") ///
			rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(unemp_ts_all, replace)

	graph export "$graphs/descriptives/unemp_by_quartile_allyears.pdf", replace
restore




**************************************************
**# 3b. Summary statistics table by exposure quartile
**************************************************

use `analysis', clear

xtile beta_q = dv_rating_beta, nquantiles(4)

* Label variables for clean table output
label variable age "Age"
label variable is_college "College (BA+)"
label variable lnwage "Log Real Wage"
label variable unemployed "Unemployed"
label variable dv_rating_beta "AI Exposure (\$\beta_o\$)"

* Overall + by quartile
eststo all: estpost summarize age is_college lnwage unemployed dv_rating_beta

forvalues q = 1/4 {
	eststo q`q': estpost summarize age is_college lnwage unemployed dv_rating_beta ///
		if beta_q == `q'
}

esttab all q1 q2 q3 q4 ///
	using "$tables/summary_stats_quartile.tex", replace ///
	cells("mean(fmt(%9.3f)) sd(fmt(%9.3f))") ///
	label ///
	title("Summary Statistics by AI Exposure Quartile") ///
	mtitles("All" "Q1 (low)" "Q2" "Q3" "Q4 (high)") ///
	nonumbers ///
	booktabs



**************************************************
**# 4. Mean AI exposure over time
**************************************************

use `analysis', clear

* Overall
preserve
	collapse (mean) mean_beta = dv_rating_beta, by(year)

	twoway ///
		(connected mean_beta year, ///
			lcolor(navy) mcolor(navy) msymbol(O) lwidth(medium)), ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Mean AI Exposure ({&beta}{subscript:o})") ///
		ylabel(0(0.1)0.5) ///
		title("Mean AI Exposure Over Time") ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		legend(off) ///
		name(beta_ts_overall, replace)

	graph export "$graphs/descriptives/mean_beta_overall.pdf", replace
restore

* By education (college vs non-college)
preserve
	collapse (mean) mean_beta = dv_rating_beta, by(year is_college)

	twoway ///
		(connected mean_beta year if is_college == 1, ///
			lcolor(navy) mcolor(navy) msymbol(O) lwidth(medium)) ///
		(connected mean_beta year if is_college == 0, ///
			lcolor(maroon) mcolor(maroon) msymbol(D) lwidth(medium) lpattern(dash)), ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Mean AI Exposure ({&beta}{subscript:o})") ///
		ylabel(0(0.1)0.5) ///
		title("Mean AI Exposure Over Time: College vs Non-College") ///
		legend(order(1 "College (BA+)" 2 "Non-college") ///
			rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(beta_ts_educ, replace)

	graph export "$graphs/descriptives/mean_beta_education.pdf", replace
restore



**************************************************
**# 5. Occupation group table: exposure + % college
**************************************************

use `analysis', clear

// preserve
	drop if missing(soc_gr_str)
	
	collapse (mean) mean_beta = dv_rating_beta ///
			 (mean) pct_college = is_college, ///
		by(soc_gr soc_gr_str)

	* Convert pct_college to percentage
	replace pct_college = pct_college * 100

	* Sort by exposure high -> low
	gsort -mean_beta

	* Create display strings
	gen beta_str = string(mean_beta, "%6.3f")
	gen pct_str  = string(pct_college, "%5.1f")

	* Wrap long occupation names using a LaTeX p{} column
	* Use the full name — LaTeX will wrap automatically
	listtex soc_gr_str beta_str pct_str ///
		using "$tables/occ_group_exposure.tex", replace ///
		rstyle(tabular) ///
		head("\begin{tabular}{p{6cm}cc}" "\hline" ///
			 "Occupation Group & AI Exposure ($\beta_o$) & \% College \\" "\hline") ///
		foot("\hline" "\end{tabular}")
// restore

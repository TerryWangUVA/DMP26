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
**# 2b. Summary statistics for AI exposure score (full / college / non-college)
**************************************************

use `analysis', clear

* Compute stats for three samples: 0 = full, 1 = college, 2 = non-college
forvalues g = 0/2 {
	if `g' == 0 local cond "1"
	if `g' == 1 local cond "is_college == 1"
	if `g' == 2 local cond "is_college == 0"

	quietly count if `cond'
	scalar N_`g' = r(N)

	quietly summarize dv_rating_beta if `cond', detail
	scalar mean_`g' = r(mean)
	scalar sd_`g'   = r(sd)
	scalar min_`g'  = r(min)
	scalar p25_`g'  = r(p25)
	scalar p50_`g'  = r(p50)
	scalar p75_`g'  = r(p75)
	scalar max_`g'  = r(max)
}

* Build each row as a local, then write to file
local row_0 "Full sample & `: display %12.0fc N_0' & `: display %4.3f mean_0' & `: display %4.3f sd_0' & `: display %4.3f min_0' & `: display %4.3f p25_0' & `: display %4.3f p50_0' & `: display %4.3f p75_0' & `: display %4.3f max_0'"
local row_1 "College & `: display %12.0fc N_1' & `: display %4.3f mean_1' & `: display %4.3f sd_1' & `: display %4.3f min_1' & `: display %4.3f p25_1' & `: display %4.3f p50_1' & `: display %4.3f p75_1' & `: display %4.3f max_1'"
local row_2 "Non-college & `: display %12.0fc N_2' & `: display %4.3f mean_2' & `: display %4.3f sd_2' & `: display %4.3f min_2' & `: display %4.3f p25_2' & `: display %4.3f p50_2' & `: display %4.3f p75_2' & `: display %4.3f max_2'"

file open tab using "$tables/beta_summary.tex", write replace
file write tab "\begin{tabular}{lrrrrrrrr}" _n
file write tab "\toprule" _n
file write tab " & N & Mean & SD & Min & p25 & p50 & p75 & Max \\" _n
file write tab "\midrule" _n
file write tab "`row_0' \\" _n
file write tab "`row_1' \\" _n
file write tab "`row_2' \\" _n
file write tab "\bottomrule" _n
file write tab "\end{tabular}" _n
file close tab



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
**# 3a-bis. Time-series: log real wage by exposure quartile
**************************************************

use `analysis', clear

* Create exposure quartile groups
xtile beta_q = dv_rating_beta, nquantiles(4)

label define beta_q_lbl 1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4 (highest)"
label values beta_q beta_q_lbl


*--- Post-2022 version (main) ---

preserve
	keep if year >= 2022
	keep if !missing(lnwage)

	collapse (mean) mean_lnwage = lnwage, by(year beta_q)

	twoway ///
		(connected mean_lnwage year if beta_q == 1, ///
			lcolor(navy*0.4) mcolor(navy*0.4) msymbol(O) lwidth(medium)) ///
		(connected mean_lnwage year if beta_q == 2, ///
			lcolor(navy*0.7) mcolor(navy*0.7) msymbol(D) lwidth(medium)) ///
		(connected mean_lnwage year if beta_q == 3, ///
			lcolor(maroon*0.7) mcolor(maroon*0.7) msymbol(T) lwidth(medium)) ///
		(connected mean_lnwage year if beta_q == 4, ///
			lcolor(maroon) mcolor(maroon) msymbol(S) lwidth(medium)), ///
		xlabel(2022(1)2025) ///
		xtitle("Year") ///
		ytitle("Mean Log Real Wage") ///
		title("Log Real Wage by AI Exposure Quartile (Post-2022)") ///
		legend(order(1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4 (highest)") ///
			rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(lw_ts_post, replace)

	graph export "$graphs/descriptives/logwage_by_quartile_post2022.pdf", replace
restore


// --- All-years version ---

preserve
	keep if !missing(lnwage)

	collapse (mean) mean_lnwage = lnwage, by(year beta_q)

	twoway ///
		(connected mean_lnwage year if beta_q == 1, ///
			lcolor(navy*0.4) mcolor(navy*0.4) msymbol(O) lwidth(medium)) ///
		(connected mean_lnwage year if beta_q == 2, ///
			lcolor(navy*0.7) mcolor(navy*0.7) msymbol(D) lwidth(medium)) ///
		(connected mean_lnwage year if beta_q == 3, ///
			lcolor(maroon*0.7) mcolor(maroon*0.7) msymbol(T) lwidth(medium)) ///
		(connected mean_lnwage year if beta_q == 4, ///
			lcolor(maroon) mcolor(maroon) msymbol(S) lwidth(medium)), ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Mean Log Real Wage") ///
		title("Log Real Wage by AI Exposure Quartile (2018-2025)") ///
		legend(order(1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4 (highest)") ///
			rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(lw_ts_all, replace)

	graph export "$graphs/descriptives/logwage_by_quartile_allyears.pdf", replace
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


	listtex soc_gr_str beta_str pct_str ///
		using "$tables/occ_group_exposure.tex", replace ///
		rstyle(tabular) ///
		head("\begin{small}" "\begin{tabular}{lcc}" "\hline" ///
			 "Occupation Group & AI Exposure ($\beta_o$) & \% College \\" "\hline") ///
		foot("\hline" "\end{tabular}" "\end{small}")
// restore



**************************************************
**# 6. Kdensity of real wage
**************************************************

use `analysis', clear

* (a) Overall
twoway ///
	(kdensity real_wage if real_wage > 0 & real_wage < 100000, ///
		lcolor(navy) lwidth(medium) lpattern(solid)), ///
	xtitle("Annual Real Wage (1982 dollars)", size(medium)) ///
	ytitle("Density", size(medium)) ///
	title("Distribution of Real Wages") ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	legend(off) ///
	name(kd_wage, replace)

graph export "$graphs/descriptives/kdensity_wage_overall.pdf", replace


* (b) By education
twoway ///
	(kdensity real_wage if is_college == 1 & real_wage > 0 & real_wage < 100000, ///
		lcolor(navy) lwidth(medium) lpattern(solid)) ///
	(kdensity real_wage if is_college == 0 & real_wage > 0 & real_wage < 100000, ///
		lcolor(maroon) lwidth(medium) lpattern(dash)), ///
	xtitle("Annual Real Wage (1982 dollars)", size(medium)) ///
	ytitle("Density", size(medium)) ///
	title("Real Wage Distribution: College vs Non-College") ///
	legend(order(1 "College (BA+)" 2 "Non-college") ///
		rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(kd_wage_educ, replace)

graph export "$graphs/descriptives/kdensity_wage_education.pdf", replace



**************************************************
**# 6b. Export college % by occupation to CSV
**************************************************

use `analysis', clear

preserve
	collapse (mean) pct_college = is_college (count) n_workers = is_college, by(occsoc_2010)
	replace pct_college = pct_college * 100
	export delimited occsoc_2010 pct_college n_workers using "$data/occ_college_pct.csv", replace
	di "Exported college % for " _N " occupations"
restore


**************************************************
**# 7. Scatter: college % vs AI exposure (occupation level)
**************************************************

use `analysis', clear

preserve
	collapse (mean) pct_college = is_college ///
			 (mean) exposure = dv_rating_beta ///
			 (count) n_workers = is_college, ///
		by(occsoc_2010)

	replace pct_college = pct_college * 100

	* Regression stats for the fitted line
	reg pct_college exposure [aw=n_workers]
	local b_slope: display %5.1f _b[exposure]
	local r2: display %4.2f e(r2)
	local N_occ = e(N)
	di "Slope = `b_slope', R2 = `r2', N = `N_occ'"

	twoway ///
		(scatter pct_college exposure [aw=n_workers], ///
			mcolor(navy%30) msymbol(O) msize(small)) ///
		(lfit pct_college exposure [aw=n_workers], ///
			lcolor(maroon) lwidth(medium) lpattern(solid)), ///
		xtitle("AI Exposure Score ({&beta}{subscript:o})", size(medium)) ///
		ytitle("% College-Educated", size(medium)) ///
		title("College Share vs AI Exposure (by Occupation)") ///
		subtitle("Each circle = one occupation, sized by CPS sample") ///
		yline(50, lcolor(gs8) lpattern(dash)) ///
		legend(off) ///
		note("Slope = `b_slope', R{superscript:2} = `r2', N = `N_occ' occupations", size(small)) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(college_vs_exposure, replace)

	graph export "$graphs/descriptives/college_vs_exposure.pdf", replace

	* Unweighted version
	reg pct_college exposure
	local b_uw: display %5.1f _b[exposure]
	local r2_uw: display %4.2f e(r2)
	di "Unweighted: Slope = `b_uw', R2 = `r2_uw'"

	twoway ///
		(scatter pct_college exposure, ///
			mcolor(navy%30) msymbol(O) msize(small)) ///
		(lfit pct_college exposure, ///
			lcolor(maroon) lwidth(medium) lpattern(solid)), ///
		xtitle("AI Exposure Score ({&beta}{subscript:o})", size(medium)) ///
		ytitle("% College-Educated", size(medium)) ///
		title("College Share vs AI Exposure (unweighted)") ///
		subtitle("Each circle = one occupation, equal weight") ///
		yline(50, lcolor(gs8) lpattern(dash)) ///
		legend(off) ///
		note("Slope = `b_uw', R{superscript:2} = `r2_uw', N = `N_occ' occupations", size(small)) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(college_vs_exposure_uw, replace)

	graph export "$graphs/descriptives/college_vs_exposure_unweighted.pdf", replace
restore


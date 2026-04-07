/*--------------------------------------------------
Descriptives & regressions using the Anthropic
automation / augmentation indices

				Edit history

	04-05-2026: Started.
----------------------------------------------------*/

//================== Set Directory =======================//
global folder "C:\Projects\DMP"
cd "$folder"
global raw "$folder/raw"
global output "$folder/output"
global tables "$output/tables/anthropic"
global graphs "$output/graphs/anthropic"
global data "$output/data"

cap mkdir "$output/tables/anthropic"
cap mkdir "$output/graphs/anthropic"

set more off
///////////////////////////////////////////////////////////


*************************************
**# 1. Prepare CPS dataset
*************************************
cap restore
use "$data/CPS-ASEC_analysis_Dec01", clear

keep if educ >= 73
keep if labforce == 2

gen real_wage = incwage * 100 / cpiaucsl
gen lnwage = ln(real_wage)
gen educyrs = .
replace educyrs = 12 if inlist(educ, 73)
replace educyrs = 16 if inlist(educ, 111)
replace educyrs = 18 if inlist(educ, 123)
replace educyrs = 19 if inlist(educ, 124)
replace educyrs = 20 if inlist(educ, 125)

gen exp = age - educyrs - 6
replace exp = max(exp, 0)
gen exp2 = exp^2

gen is_college = educ > 110
gen unemployed = inlist(empstat, 21, 22)

replace occsoc = strtrim(occsoc)
rename occsoc occsoc_2010



*************************************
**# 2. Merge Anthropic indices
*************************************

* Import the CSV and save as .dta for merging
preserve
	import delimited "$data/anthropic_occ_index.csv", clear varnames(1)

	* soc_code is the merge key (e.g. "11-1011")
	rename soc_code occsoc_2010

	keep occsoc_2010 automation_index augmentation_index mean_penetration

	tempfile anthro
	save `anthro', replace
restore

* Hierarchical merge (same logic as Eloundou merge)
merge m:1 occsoc_2010 using `anthro'
ren _merge _merge_a1

preserve
	keep if _merge_a1 == 3
	tempfile M1
	save `M1', replace
restore

keep if _merge_a1 == 1
drop automation_index augmentation_index mean_penetration
replace occsoc_2010 = substr(occsoc_2010, 1, 6) + "X"

merge m:1 occsoc_2010 using `anthro'
rename _merge _merge_a2

preserve
	keep if _merge_a2 == 1
	drop automation_index augmentation_index mean_penetration
	replace occsoc_2010 = substr(occsoc_2010, 1, 5) + "XX"
	merge m:1 occsoc_2010 using `anthro'
	rename _merge _merge_a3
	keep if _merge_a3 == 3
	tempfile M3
	save `M3', replace
restore

keep if _merge_a2 == 3
tempfile M2
save `M2', replace

use `M1', clear
append using `M2'
append using `M3'

* Check merge
count
su automation_index augmentation_index mean_penetration

label variable automation_index "Automation Index"
label variable augmentation_index "Augmentation Index"
label variable mean_penetration "Mean AI Penetration"

tempfile analysis
save `analysis', replace

eststo clear



**************************************************
**# 3. Descriptive: kdensity of both indices
**************************************************

use `analysis', clear

* (a) Automation index
twoway ///
	(kdensity automation_index, ///
		lcolor(maroon) lwidth(medium) lpattern(solid)), ///
	xtitle("Automation Index", size(medium)) ///
	ytitle("Density", size(medium)) ///
	title("Distribution of Automation Index Across Workers") ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	legend(off) ///
	name(kd_auto, replace)

graph export "$graphs/kdensity_automation.pdf", replace


* (b) Augmentation index
twoway ///
	(kdensity augmentation_index, ///
		lcolor(navy) lwidth(medium) lpattern(solid)), ///
	xtitle("Augmentation Index", size(medium)) ///
	ytitle("Density", size(medium)) ///
	title("Distribution of Augmentation Index Across Workers") ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	legend(off) ///
	name(kd_aug, replace)

graph export "$graphs/kdensity_augmentation.pdf", replace


* (c) Both overlaid
twoway ///
	(kdensity automation_index, ///
		lcolor(maroon) lwidth(medium) lpattern(solid)) ///
	(kdensity augmentation_index, ///
		lcolor(navy) lwidth(medium) lpattern(dash)), ///
	xtitle("Index Value", size(medium)) ///
	ytitle("Density", size(medium)) ///
	title("Automation vs Augmentation Index") ///
	legend(order(1 "Automation" 2 "Augmentation") ///
		rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(kd_both, replace)

graph export "$graphs/kdensity_auto_vs_aug.pdf", replace



**************************************************
**# 4. Descriptive: kdensity by education
**************************************************

use `analysis', clear

* Automation by education
twoway ///
	(kdensity automation_index if is_college == 1, ///
		lcolor(navy) lwidth(medium) lpattern(solid)) ///
	(kdensity automation_index if is_college == 0, ///
		lcolor(maroon) lwidth(medium) lpattern(dash)), ///
	xtitle("Automation Index", size(medium)) ///
	ytitle("Density", size(medium)) ///
	title("Automation Index: College vs Non-College") ///
	legend(order(1 "College (BA+)" 2 "Non-college") ///
		rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(kd_auto_educ, replace)

graph export "$graphs/kdensity_automation_education.pdf", replace


* Augmentation by education
twoway ///
	(kdensity augmentation_index if is_college == 1, ///
		lcolor(navy) lwidth(medium) lpattern(solid)) ///
	(kdensity augmentation_index if is_college == 0, ///
		lcolor(maroon) lwidth(medium) lpattern(dash)), ///
	xtitle("Augmentation Index", size(medium)) ///
	ytitle("Density", size(medium)) ///
	title("Augmentation Index: College vs Non-College") ///
	legend(order(1 "College (BA+)" 2 "Non-college") ///
		rows(1) position(6) region(lstyle(none))) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(kd_aug_educ, replace)

graph export "$graphs/kdensity_augmentation_education.pdf", replace



**************************************************
**# 5. Summary stats by automation quartile
**************************************************

use `analysis', clear

xtile auto_q = automation_index, nquantiles(4)

label variable age "Age"
label variable is_college "College (BA+)"
label variable lnwage "Log Real Wage"
label variable unemployed "Unemployed"
label variable automation_index "Automation Index"
label variable augmentation_index "Augmentation Index"

eststo all: estpost summarize age is_college lnwage unemployed ///
	automation_index augmentation_index

forvalues q = 1/4 {
	eststo q`q': estpost summarize age is_college lnwage unemployed ///
		automation_index augmentation_index if auto_q == `q'
}

esttab all q1 q2 q3 q4 ///
	using "$tables/summary_stats_auto_quartile.tex", replace ///
	cells("mean(fmt(%9.3f)) sd(fmt(%9.3f))") ///
	label ///
	title("Summary Statistics by Automation Index Quartile") ///
	mtitles("All" "Q1 (low)" "Q2" "Q3" "Q4 (high)") ///
	nonumbers ///
	booktabs



**************************************************
**# 6. 2D DiD: automation AND augmentation jointly
**************************************************

use `analysis', clear

fvset base 2022 year

eststo clear


*--- Unemployment: 2D ---
reghdfe unemployed i.year##c.automation_index ///
	i.year##c.augmentation_index, ///
	absorb(sex educ year#statefip) cluster(occsoc_2010)
eststo unemp_2d

*--- Log wages: 2D ---
reghdfe lnwage i.year##c.automation_index ///
	i.year##c.augmentation_index, ///
	absorb(sex educ year#statefip) cluster(occsoc_2010)
eststo lw_2d


*--- Export tables ---

esttab unemp_2d ///
	using "$tables/unemp_2d.tex", replace ///
	keep(*.year#c.automation_index *.year#c.augmentation_index) ///
	se star(* 0.10 ** 0.05 *** 0.01) ///
	label ///
	title("Unemployment: 2D DiD (Auto + Ass)") ///
	nonumbers ///
	booktabs

esttab lw_2d ///
	using "$tables/lw_2d.tex", replace ///
	keep(*.year#c.automation_index *.year#c.augmentation_index) ///
	se star(* 0.10 ** 0.05 *** 0.01) ///
	label ///
	title("Log Wage: 2D DiD (Auto + Ass)") ///
	nonumbers ///
	booktabs



**************************************************
**# 7. Coefplots: both dimensions on same graph
**************************************************

*--- Unemployment ---
use `analysis', clear
fvset base 2022 year

reghdfe unemployed i.year##c.automation_index ///
	i.year##c.augmentation_index, ///
	absorb(sex educ year#statefip) cluster(occsoc_2010)

matrix b = e(b)
matrix V = e(V)

preserve
	clear
	set obs 16
	gen year = .
	gen estimate = .
	gen se = .
	gen grp = ""

	local row = 1
	* Auto coefficients
	foreach y in 2018 2019 2020 2021 2022 2023 2024 2025 {
		replace year = `y' in `row'
		replace grp = "Auto" in `row'
		if `y' == 2022 {
			replace estimate = 0 in `row'
			replace se = 0 in `row'
		}
		else {
			local idx = colnumb(b, "`y'.year#c.automation_index")
			replace estimate = b[1, `idx'] in `row'
			replace se = sqrt(V[`idx', `idx']) in `row'
		}
		local row = `row' + 1
	}
	* Ass coefficients
	foreach y in 2018 2019 2020 2021 2022 2023 2024 2025 {
		replace year = `y' in `row'
		replace grp = "Ass" in `row'
		if `y' == 2022 {
			replace estimate = 0 in `row'
			replace se = 0 in `row'
		}
		else {
			local idx = colnumb(b, "`y'.year#c.augmentation_index")
			replace estimate = b[1, `idx'] in `row'
			replace se = sqrt(V[`idx', `idx']) in `row'
		}
		local row = `row' + 1
	}

	gen min95 = estimate - 1.96 * se
	gen max95 = estimate + 1.96 * se

	* Jitter for readability
	gen x = year - 0.1 if grp == "Auto"
	replace x = year + 0.1 if grp == "Ass"

	twoway ///
		(rcap min95 max95 x if grp=="Auto" & year != 2022, ///
			lcolor(maroon) lpattern(solid) lwidth(medthin)) ///
		(line estimate x if grp=="Auto", ///
			lcolor(maroon) lpattern(solid) lwidth(medium) sort) ///
		(scatter estimate x if grp=="Auto", ///
			mcolor(maroon) msymbol(O) msize(medlarge)) ///
		(rcap min95 max95 x if grp=="Ass" & year != 2022, ///
			lcolor(navy) lpattern(solid) lwidth(medthin)) ///
		(line estimate x if grp=="Ass", ///
			lcolor(navy) lpattern(solid) lwidth(medium) sort) ///
		(scatter estimate x if grp=="Ass", ///
			mcolor(navy) msymbol(D) msize(medlarge)), ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		yline(0, lcolor(gs8) lpattern(solid)) ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Coefficient") ///
		title("Unemployment: AutoIndex vs AssIndex (2D DiD)") ///
		legend(order(3 "AutoIndex" 6 "AssIndex") ///
			rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(unemp_2d_coef, replace)

	graph export "$graphs/unemp_2d_coefplot.pdf", replace
restore


*--- Log wages ---
reghdfe lnwage i.year##c.automation_index ///
	i.year##c.augmentation_index, ///
	absorb(sex educ year#statefip) cluster(occsoc_2010)

matrix b = e(b)
matrix V = e(V)

preserve
	clear
	set obs 16
	gen year = .
	gen estimate = .
	gen se = .
	gen grp = ""

	local row = 1
	foreach y in 2018 2019 2020 2021 2022 2023 2024 2025 {
		replace year = `y' in `row'
		replace grp = "Auto" in `row'
		if `y' == 2022 {
			replace estimate = 0 in `row'
			replace se = 0 in `row'
		}
		else {
			local idx = colnumb(b, "`y'.year#c.automation_index")
			replace estimate = b[1, `idx'] in `row'
			replace se = sqrt(V[`idx', `idx']) in `row'
		}
		local row = `row' + 1
	}
	foreach y in 2018 2019 2020 2021 2022 2023 2024 2025 {
		replace year = `y' in `row'
		replace grp = "Ass" in `row'
		if `y' == 2022 {
			replace estimate = 0 in `row'
			replace se = 0 in `row'
		}
		else {
			local idx = colnumb(b, "`y'.year#c.augmentation_index")
			replace estimate = b[1, `idx'] in `row'
			replace se = sqrt(V[`idx', `idx']) in `row'
		}
		local row = `row' + 1
	}

	gen min95 = estimate - 1.96 * se
	gen max95 = estimate + 1.96 * se

	gen x = year - 0.1 if grp == "Auto"
	replace x = year + 0.1 if grp == "Ass"

	twoway ///
		(rcap min95 max95 x if grp=="Auto" & year != 2022, ///
			lcolor(maroon) lpattern(solid) lwidth(medthin)) ///
		(line estimate x if grp=="Auto", ///
			lcolor(maroon) lpattern(solid) lwidth(medium) sort) ///
		(scatter estimate x if grp=="Auto", ///
			mcolor(maroon) msymbol(O) msize(medlarge)) ///
		(rcap min95 max95 x if grp=="Ass" & year != 2022, ///
			lcolor(navy) lpattern(solid) lwidth(medthin)) ///
		(line estimate x if grp=="Ass", ///
			lcolor(navy) lpattern(solid) lwidth(medium) sort) ///
		(scatter estimate x if grp=="Ass", ///
			mcolor(navy) msymbol(D) msize(medlarge)), ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		yline(0, lcolor(gs8) lpattern(solid)) ///
		xlabel(2018(1)2025) ///
		xtitle("Year") ///
		ytitle("Coefficient") ///
		title("Log Wage: AutoIndex vs AssIndex (2D DiD)") ///
		legend(order(3 "AutoIndex" 6 "AssIndex") ///
			rows(1) position(6) region(lstyle(none))) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(lw_2d_coef, replace)

	graph export "$graphs/lw_2d_coefplot.pdf", replace
restore

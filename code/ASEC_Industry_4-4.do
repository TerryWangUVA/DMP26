/*--------------------------------------------------
Industry-level analysis: occupation shares within
industries over time (informal J2J)

Are high-AI-exposure occupations shrinking within
industries post-2022?

					Edit history

	04-04-2026: Started.
----------------------------------------------------*/

//================== Set Directory =======================//
global folder "C:\Projects\DMP"
cd "$folder"
global raw "$folder/raw"
global output "$folder/output"
global tables "$output/tables/industry"
global graphs "$output/graphs/industry"
global data "$output/data"

cap mkdir "$output/tables/industry"
cap mkdir "$output/graphs/industry"

set more off
///////////////////////////////////////////////////////////


*************************************
**# 1. Prepare dataset
*************************************

use "$data/CPS-ASEC_analysis_Dec01", clear

keep if educ >= 73
keep if labforce == 2

gen is_college = educ > 110

replace occsoc = strtrim(occsoc)
rename occsoc occsoc_2010

local ratings ///
	dv_rating_alpha dv_rating_beta dv_rating_gamma ///
	human_rating_alpha human_rating_beta human_rating_gamma

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


* Create broad industry groups from ind (CPS 4-digit)
* Use floor(ind/100) for ~20 broad sectors, or keep ind as-is for finer detail
gen ind_broad = floor(ind / 100)

* Label a few key broad industries for readability
label define ind_broad_lbl ///
	1 "Agriculture" ///
	2 "Mining" ///
	3 "Construction" ///
	4 "Manufacturing" ///
	5 "Wholesale Trade" ///
	6 "Retail Trade" ///
	7 "Transportation & Utilities" ///
	8 "Information" ///
	9 "Finance & Insurance" ///
	10 "Real Estate" ///
	11 "Professional & Technical" ///
	12 "Management & Admin" ///
	13 "Education" ///
	14 "Health Care" ///
	15 "Entertainment & Food" ///
	16 "Other Services" ///
	17 "Public Admin"
label values ind_broad ind_broad_lbl

tempfile analysis
save `analysis', replace



*************************************
**# 2. Industry-level AI exposure
*************************************
* Construct: AIExp_k = Σ_o share_{k,o,2019} × β_o

use `analysis', clear

* Baseline year for shares
preserve
	keep if year == 2019

	* Count workers in each industry×occupation cell (fine occ level)
	bysort ind_broad occsoc_2010: gen cell_n = _N

	* Industry total
	bysort ind_broad: gen ind_n = _N

	* Occupation share within industry
	gen occ_share = cell_n / ind_n

	* Collapse to industry×occupation level
	collapse (mean) occ_share dv_rating_beta, by(ind_broad occsoc_2010)

	* Industry-level AI exposure = weighted average of beta
	gen weighted_beta = occ_share * dv_rating_beta
	collapse (sum) ind_ai_exp = weighted_beta, by(ind_broad)

	label var ind_ai_exp "Industry AI Exposure (occ-share weighted)"

	tempfile ind_exposure
	save `ind_exposure', replace
restore



*************************************
**# 3. Occupation shares within industries over time
*************************************

use `analysis', clear

* Count workers in each year × industry × occupation cell (fine occ level)
bysort year ind_broad occsoc_2010: gen cell_n = _N

* Industry-year total
bysort year ind_broad: gen ind_year_n = _N

* Occupation share within industry-year
gen occ_share = cell_n / ind_year_n

* Collapse to year × industry × occupation
collapse (mean) occ_share dv_rating_beta, ///
	by(year ind_broad occsoc_2010)

* Flag high-beta occupations (top quartile)
su dv_rating_beta, detail
local p75 = r(p75)
gen high_beta = (dv_rating_beta >= `p75')

tempfile occ_shares
save `occ_shares', replace



*************************************
**# 4. Descriptive: high-beta occ share within industries over time
*************************************

use `occ_shares', clear

* Aggregate across ALL industries: share of high-beta occs (full sample)
preserve
	collapse (sum) high_beta_share = occ_share if high_beta == 1, by(year ind_broad)

	collapse (mean) high_beta_share, by(year)

	twoway ///
		(connected high_beta_share year, ///
			lcolor(navy) mcolor(navy) msymbol(O) lwidth(medium)), ///
		xlabel(2018(1)2025) ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		xtitle("Year") ///
		ytitle("Share of High-Beta Occupations (all ages)") ///
		title("High-Beta Occupation Share Within Industries (All Workers)") ///
		legend(off) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(highbeta_share_ts, replace)

	graph export "$graphs/highbeta_occ_share_all.pdf", replace
restore



*************************************
**# 4b. Same as 4, restricted to workers under 35
*************************************
* Exposure + industry exposure from full sample (blocks 2);
* share computation restricted to young workers

use `analysis', clear

keep if age < 30

* Count workers in each year × industry × occupation cell (young only)
bysort year ind_broad occsoc_2010: gen cell_n = _N
bysort year ind_broad: gen ind_year_n = _N
gen occ_share = cell_n / ind_year_n

collapse (mean) occ_share dv_rating_beta, ///
	by(year ind_broad occsoc_2010)

* Flag high-beta occupations (top quartile, using full-sample cutoff)
su dv_rating_beta, detail
local p75 = r(p75)
gen high_beta = (dv_rating_beta >= `p75')

* Aggregate across ALL industries: share of high-beta occs among young workers
preserve
	collapse (sum) high_beta_share = occ_share if high_beta == 1, by(year ind_broad)

	* Average across industries (unweighted)
	collapse (mean) high_beta_share, by(year)

	twoway ///
		(connected high_beta_share year, ///
			lcolor(maroon) mcolor(maroon) msymbol(S) lwidth(medium)), ///
		xlabel(2018(1)2025) ///
		xline(2022.5, lcolor(gs8) lpattern(dash)) ///
		xtitle("Year") ///
		ytitle("Share of High-Beta Occupations (age < 30)") ///
		title("Are High-Exposure Occs Fading Among Young Workers?") ///
		legend(off) ///
		graphregion(color(white)) ///
		plotregion(color(white)) ///
		name(highbeta_share_ts_young, replace)

	graph export "$graphs/highbeta_occ_share_young.pdf", replace
restore



*************************************
**# 5. Scatter: Δ occ share vs β_o
*************************************
* For each occupation×industry cell: change in share post vs pre

use `occ_shares', clear

* Pre (2019-2021 avg) vs Post (2023-2025 avg)
gen period = "pre" if inrange(year, 2019, 2021)
replace period = "post" if inrange(year, 2023, 2025)
keep if period != ""

collapse (mean) occ_share (first) dv_rating_beta, by(ind_broad occsoc_2010 period)

* Keep only what reshape needs; beta is constant within occ, save separately
preserve
	collapse (first) dv_rating_beta, by(occsoc_2010)
	tempfile beta_xwalk
	save `beta_xwalk', replace
restore

drop dv_rating_beta

reshape wide occ_share, i(ind_broad occsoc_2010) j(period) string

merge m:1 occsoc_2010 using `beta_xwalk', nogen

gen delta_share = occ_sharepost - occ_sharepre

* Drop tiny cells (noise)
drop if occ_sharepre < 0.005

twoway ///
	(scatter delta_share dv_rating_beta, ///
		mcolor(navy%40) msymbol(O) msize(small)) ///
	(lfit delta_share dv_rating_beta, ///
		lcolor(maroon) lwidth(medium) lpattern(solid)), ///
	xtitle("Occupation AI Exposure ({&beta}{subscript:o})") ///
	ytitle("{&Delta} Occupation Share Within Industry (post - pre)") ///
	title("Change in Occupation Share vs AI Exposure") ///
	subtitle("Each dot = one occupation × industry cell") ///
	yline(0, lcolor(gs8) lpattern(dash)) ///
	legend(off) ///
	graphregion(color(white)) ///
	plotregion(color(white)) ///
	name(delta_share_scatter, replace)

graph export "$graphs/delta_occ_share_vs_beta.pdf", replace



*************************************
**# 6. Table: top-5 high-beta occs, share in top-3 industries, 2019 vs 2025
*************************************

use `occ_shares', clear

* Identify top-5 beta occupations (by unique occsoc)
preserve
	collapse (first) dv_rating_beta, by(occsoc_2010)
	gsort -dv_rating_beta
	keep if _n <= 5
	keep occsoc_2010
	tempfile top5_occs
	save `top5_occs', replace
restore

keep if year == 2019 | year == 2025

merge m:1 occsoc_2010 using `top5_occs', keep(match) nogen

* For each of these occs, find their top-3 industries (by 2019 share)
preserve
	keep if year == 2019

	bysort occsoc_2010 (occ_share): gen rank = _N - _n + 1
	keep if rank <= 3

	keep occsoc_2010 ind_broad rank
	tempfile top3_ind
	save `top3_ind', replace
restore

merge m:1 occsoc_2010 ind_broad using `top3_ind', keep(match) nogen

* Reshape for display
keep year occsoc_2010 ind_broad occ_share dv_rating_beta

preserve
	collapse (first) dv_rating_beta, by(occsoc_2010)
	tempfile beta_xwalk2
	save `beta_xwalk2', replace
restore

drop dv_rating_beta
reshape wide occ_share, i(occsoc_2010 ind_broad) j(year)
merge m:1 occsoc_2010 using `beta_xwalk2', nogen

gen share_2019 = string(occ_share2019 * 100, "%5.1f") + "%"
gen share_2025 = string(occ_share2025 * 100, "%5.1f") + "%"
gen delta = string((occ_share2025 - occ_share2019) * 100, "%+5.1f") + "pp"

* Decode industry label
decode ind_broad, gen(ind_str)

gsort -dv_rating_beta ind_broad

listtex occsoc_2010 ind_str share_2019 share_2025 delta ///
	using "$tables/top5_occ_industry_shift.tex", replace ///
	rstyle(tabular) ///
	head("\begin{small}" ///
		 "\begin{tabular}{llccc}" "\hline" ///
		 "Occupation & Industry & 2019 & 2025 & $\Delta$ \\" "\hline") ///
	foot("\hline" "\end{tabular}" "\end{small}")

/*--------------------------------------------------
Descriptives for Education Heterogeneity Section

Two starting descriptives:
  1) Occupation-level scatter of #tasks vs. college share,
     with a worker-weighted linear fit.
  2) The same scatter split by worker-weighted median
     AI exposure: high (beta_o > median) vs. low.

Sample restriction:
  (a) CPS occsoc_2010 must exact-match an O*NET 6-digit SOC
      (drops codes containing "X" wildcards).
  (b) Occupations ending in "99" (SOC "All Other" catchall
      categories) are dropped. These residual categories
      pool many heterogeneous occupations, which inflates
      their apparent task count when detailed O*NET subcodes
      are summed to the 6-digit level.
The trade-off is sample coverage for a cleaner one-to-one
interpretation.

Purpose: grounds the "bundle composition" story in
§5.4 of DMP_D3_3-17.tex --- are college workers in
occupations with richer task bundles?

                    Edit history
  04-18-2026: Created.
  04-18-2026: Restricted to exact 6-digit matches only.
----------------------------------------------------*/

//================== Set Directory =======================//
global folder "C:\Projects\DMP"
cd "$folder"
global raw    "$folder/raw"
global output "$folder/output"
global data   "$output/data"
global tables "$output/tables/descriptives"
global graphs "$output/graphs/descriptives"

set more off
///////////////////////////////////////////////////////////
cap preserve
cap restore
cap clear all



*************************************
**# Step 1: Build task counts from O*NET (6-digit SOC only)
*************************************

import delimited "$raw/Crosswalks/onet_task_statements.csv", ///
	varnames(1) clear

* O*NET-SOC codes look like "11-1011.00", "11-1011.03" etc.
* Strip the ".XX" suffix to get 6-digit SOC: "11-1011"
gen soc_6 = substr(onetsoccode, 1, strpos(onetsoccode, ".") - 1)

* Count tasks per 6-digit SOC
gen byte _one = 1
collapse (sum) n_tasks = _one, by(soc_6)

rename soc_6 occsoc_2010

* Drop SOC "All Other" catchall codes (ending in "99")
* These pool heterogeneous occupations and inflate task counts.
drop if substr(occsoc_2010, -2, 2) == "99"

tempfile task_counts
save `task_counts', replace



*************************************
**# Step 2: Prepare CPS-ASEC analysis sample
*             (6-digit exact matches only --- no wildcards)
*************************************

use "$data/CPS-ASEC_analysis_Dec01", clear

* Sample restrictions
keep if educ >= 73
keep if labforce == 2

replace occsoc = strtrim(occsoc)
rename occsoc occsoc_2010

* Drop any CPS wildcard codes (anything containing "X")
drop if strpos(occsoc_2010, "X") > 0

* Merge AI exposure (exact 6-digit match only)
merge m:1 occsoc_2010 using "$data/Eloundou_updated_crosswalk", ///
	keep(match) nogen

* Merge task count (exact 6-digit match only)
merge m:1 occsoc_2010 using `task_counts', keep(match) nogen

* Derived variables
gen real_wage  = incwage * 100 / cpiaucsl
gen lnwage     = ln(real_wage)
gen is_college = educ > 110



*************************************
**# Step 3: Compute worker-weighted median of beta_o
*             (on the filtered 6-digit-only sample)
*************************************

summarize dv_rating_beta, detail
scalar beta_median = r(p50)
display _newline "Worker-weighted median of beta_o: " beta_median



*************************************
**# Step 4: Collapse to occupation level
*************************************

collapse (mean) pct_college = is_college  ///
         (mean) beta_o      = dv_rating_beta ///
         (mean) n_tasks     = n_tasks ///
         (count) n_workers  = is_college, ///
         by(occsoc_2010)

* Convert college share to percentage points
replace pct_college = pct_college * 100



*************************************
**# Step 5: Plot 1 --- n_tasks vs. pct_college
*************************************

* Worker-weighted regression to extract slope and p-value for annotation
quietly regress n_tasks pct_college [aweight=n_workers]
local slope_all = _b[pct_college]
local pval_all  = 2 * ttail(e(df_r), abs(_b[pct_college] / _se[pct_college]))
local fit_all   = "slope = " + string(`slope_all', "%6.3f") + ",  p = " + string(`pval_all', "%6.3f")
display "Plot 1 fit: `fit_all'"

twoway ///
	(scatter n_tasks pct_college [aweight=n_workers], ///
		msymbol(circle_hollow) mcolor(navy%50) msize(small)) ///
	(lfit n_tasks pct_college [aweight=n_workers], ///
		lcolor(maroon) lwidth(medthick)), ///
	xtitle("College share of workers in occupation (%)") ///
	ytitle("Number of O*NET tasks in occupation") ///
	title("Task count vs. college share") ///
	note("Worker-weighted linear fit: `fit_all'") ///
	legend(order(1 "Occupations (marker size = # workers)" 2 "Worker-weighted linear fit") ///
		position(6) rows(1) region(lstyle(none))) ///
	graphregion(color(white)) plotregion(color(white)) ///
	name(tasks_vs_college, replace)

graph export "$graphs/tasks_vs_college.pdf", replace



*************************************
**# Step 6: Plot 2 --- split by exposure median
*************************************

gen byte high_exposure = (beta_o > beta_median)
label define hexp 0 "Low exposure (below median)" 1 "High exposure (above median)"
label values high_exposure hexp

* Low exposure: regression + fit annotation
quietly regress n_tasks pct_college [aweight=n_workers] if high_exposure == 0
local slope_lo = _b[pct_college]
local pval_lo  = 2 * ttail(e(df_r), abs(_b[pct_college] / _se[pct_college]))
local fit_lo   = "slope = " + string(`slope_lo', "%6.3f") + ",  p = " + string(`pval_lo', "%6.3f")
display "Low-exposure fit: `fit_lo'"

twoway ///
	(scatter n_tasks pct_college [aweight=n_workers] if high_exposure == 0, ///
		msymbol(circle_hollow) mcolor(navy%60) msize(small)) ///
	(lfit n_tasks pct_college [aweight=n_workers] if high_exposure == 0, ///
		lcolor(navy) lwidth(medthick)), ///
	xtitle("College share (%)") ytitle("# of O*NET tasks") ///
	title("Low exposure occupations" "(β_o below worker-weighted median)") ///
	note("`fit_lo'") ///
	legend(off) ///
	graphregion(color(white)) plotregion(color(white)) ///
	name(scatter_low, replace)

* High exposure: regression + fit annotation
quietly regress n_tasks pct_college [aweight=n_workers] if high_exposure == 1
local slope_hi = _b[pct_college]
local pval_hi  = 2 * ttail(e(df_r), abs(_b[pct_college] / _se[pct_college]))
local fit_hi   = "slope = " + string(`slope_hi', "%6.3f") + ",  p = " + string(`pval_hi', "%6.3f")
display "High-exposure fit: `fit_hi'"

twoway ///
	(scatter n_tasks pct_college [aweight=n_workers] if high_exposure == 1, ///
		msymbol(circle_hollow) mcolor(maroon%60) msize(small)) ///
	(lfit n_tasks pct_college [aweight=n_workers] if high_exposure == 1, ///
		lcolor(maroon) lwidth(medthick)), ///
	xtitle("College share (%)") ytitle("# of O*NET tasks") ///
	title("High exposure occupations" "(β_o above worker-weighted median)") ///
	note("`fit_hi'") ///
	legend(off) ///
	graphregion(color(white)) plotregion(color(white)) ///
	name(scatter_high, replace)

graph combine scatter_low scatter_high, rows(1) ///
	title("Task count vs. college share, by exposure group") ///
	graphregion(color(white))

graph export "$graphs/tasks_vs_college_by_exposure.pdf", replace

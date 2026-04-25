/*==============================================================================
  descriptives.do
  ----------------------------------------------------------------------------
  Project:   Human in the Loop -- AI Exposure and Labor Market Frictions
  Author:    Leyao Wang, University of Virginia
  Purpose:   Produce the descriptive tables and figures used in Section 4
             (Data) of the thesis.

  Inputs:    $data/CPS-ASEC_analysis_Dec01.dta  (from cleaning.do)
             $data/Eloundou_updated_crosswalk.dta  (from cleaning.do)
             $raw/Eloundou/occ_level.csv  (for the top/bottom-5 occupation list)

  Outputs (each labeled with the draft's reference, e.g. fig:kdensity_overall):
    $tables/descriptives/beta_summary.tex         tab:beta_summary
    $tables/descriptives/top5_exposed.tex         tab:top5
    $tables/descriptives/bot5_exposed.tex         tab:bot5
    $tables/descriptives/occ_group_exposure.tex   tab:occ_group
    $graphs/descriptives/kdensity_beta_overall.pdf        fig:kdensity_overall
    $graphs/descriptives/kdensity_beta_education.pdf      fig:kdensity_educ
    $graphs/descriptives/unemp_by_quartile_post2022.pdf   fig:unemp_quartile_post2022

  Run after cleaning.do, before analysis.do.
==============================================================================*/


//================== Directory setup =======================//

// When run via main.do, $folder is already set; otherwise edit this path.
if "$folder" == "" {
    global folder "C:\Projects\DMP\Replication"
}
cd "$folder"

global raw     "$folder/raw"
global output  "$folder/output"
global tables  "$output/tables/descriptives"
global graphs  "$output/graphs/descriptives"
global data    "$output/data"

cap mkdir "$output/tables"
cap mkdir "$output/tables/descriptives"
cap mkdir "$output/graphs"
cap mkdir "$output/graphs/descriptives"

set more off
///////////////////////////////////////////////////////////


*************************************
**# Prepare analysis sample
**   (same cuts as analysis.do so the descriptives
**    describe the population actually used in regressions)
*************************************

use "$data/CPS-ASEC_analysis_Dec01", clear

// drop high-school dropouts and below
keep if educ >= 73

// restrict to labor-force participants
keep if labforce == 2

// real wage (1982 dollars) and log wage
gen real_wage = incwage * 100 / cpiaucsl
gen lnwage    = ln(real_wage)

// years-of-schooling from CPS education recode (for potential experience)
gen educyrs = .
replace educyrs = 12 if inlist(educ, 73)    // high-school diploma
replace educyrs = 16 if inlist(educ, 111)   // BA
replace educyrs = 18 if inlist(educ, 123)   // MA
replace educyrs = 19 if inlist(educ, 124)   // Professional
replace educyrs = 20 if inlist(educ, 125)   // PhD

gen exp  = max(age - educyrs - 6, 0)
gen exp2 = exp^2

// college indicator (BA or above) and unemployment indicator
gen is_college = educ > 110
gen unemployed = inlist(empstat, 21, 22)

// trim occsoc and prepare for hierarchical exposure merge
replace occsoc = strtrim(occsoc)
rename  occsoc occsoc_2010

local ratings dv_rating_alpha dv_rating_beta dv_rating_gamma ///
              human_rating_alpha human_rating_beta human_rating_gamma


//---- Hierarchical exposure merge (6 -> 5 -> 4 digit SOC) ----//
// Most occupations match at detailed 6-digit SOC.  Those that don't try a
// 5-digit aggregate (last digit -> X), and finally a 4-digit aggregate.

merge m:1 occsoc_2010 using "$data/Eloundou_updated_crosswalk"
rename _merge _merge1

preserve
    keep if _merge1 == 3
    tempfile Mer1
    save `Mer1', replace
restore

keep if _merge1 == 1
replace occsoc_2010 = substr(occsoc_2010, 1, 6) + "X"
drop `ratings'

merge m:1 occsoc_2010 using "$data/Eloundou_updated_crosswalk"
rename _merge _merge2

preserve
    keep if _merge2 == 1
    drop `ratings'
    replace occsoc_2010 = substr(occsoc_2010, 1, 5) + "XX"
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

tempfile analysis
save `analysis', replace


*************************************
**# 1. Kernel density of AI exposure -- full sample
**     --> fig:kdensity_overall
*************************************

use `analysis', clear

twoway ///
    (kdensity dv_rating_beta, ///
        lcolor(navy) lwidth(medium) lpattern(solid)), ///
    xtitle("AI Exposure Score ({&beta}{subscript:o})", size(medium)) ///
    ytitle("Density", size(medium)) ///
    title("Distribution of AI Exposure Across Workers") ///
    graphregion(color(white)) plotregion(color(white)) ///
    legend(off) ///
    name(kdensity_overall, replace)

graph export "$graphs/kdensity_beta_overall.pdf", replace


*************************************
**# 2. Top / bottom 5 exposed occupations
**     (from the Eloundou occupation-level CSV directly)
**     --> tab:top5, tab:bot5
*************************************

preserve
    import delimited "$raw/Eloundou/occ_level.csv", clear varnames(1)
    keep title dv_rating_beta

    // top 5
    gsort -dv_rating_beta
    gen rank_top = _n if _n <= 5

    // bottom 5
    gsort dv_rating_beta
    gen rank_bot = _n if _n <= 5

    keep if rank_top <= 5 | rank_bot <= 5
    gen beta_display = string(dv_rating_beta, "%6.3f")

    gsort -dv_rating_beta
    listtex title beta_display if rank_top <= 5 ///
        using "$tables/top5_exposed.tex", replace ///
        rstyle(tabular) ///
        head("\begin{tabular}{lc}" "\hline" ///
             "Occupation & Exposure Score \\" "\hline") ///
        foot("\hline" "\end{tabular}")

    gsort dv_rating_beta
    listtex title beta_display if rank_bot <= 5 ///
        using "$tables/bot5_exposed.tex", replace ///
        rstyle(tabular) ///
        head("\begin{tabular}{lc}" "\hline" ///
             "Occupation & Exposure Score \\" "\hline") ///
        foot("\hline" "\end{tabular}")
restore


*************************************
**# 3. Kernel density by education
**     --> fig:kdensity_educ
*************************************

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
    graphregion(color(white)) plotregion(color(white)) ///
    name(kdensity_het, replace)

graph export "$graphs/kdensity_beta_education.pdf", replace


*************************************
**# 4. Summary statistics for beta_o
**     (full / college / non-college)
**     --> tab:beta_summary
*************************************

use `analysis', clear

// Compute mean / sd / quartiles separately for the three samples
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

// Assemble each row and write out the table manually (keeps formatting clean)
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


*************************************
**# 5. Unemployment by AI exposure quartile, post-2022
**     --> fig:unemp_quartile_post2022
*************************************

use `analysis', clear

xtile beta_q = dv_rating_beta, nquantiles(4)
label define beta_q_lbl 1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4 (highest)"
label values beta_q beta_q_lbl

preserve
    keep if year >= 2022

    collapse (mean) unemp_rate = unemployed, by(year beta_q)

    twoway ///
        (connected unemp_rate year if beta_q == 1, ///
            lcolor(navy*0.4)   mcolor(navy*0.4)   msymbol(O) lwidth(medium)) ///
        (connected unemp_rate year if beta_q == 2, ///
            lcolor(navy*0.7)   mcolor(navy*0.7)   msymbol(D) lwidth(medium)) ///
        (connected unemp_rate year if beta_q == 3, ///
            lcolor(maroon*0.7) mcolor(maroon*0.7) msymbol(T) lwidth(medium)) ///
        (connected unemp_rate year if beta_q == 4, ///
            lcolor(maroon)     mcolor(maroon)     msymbol(S) lwidth(medium)), ///
        xlabel(2022(1)2025) ///
        xtitle("Year") ///
        ytitle("Mean Unemployment Rate") ///
        ylabel(0(0.01)0.05) ///
        title("Unemployment by AI Exposure Quartile (Post-2022)") ///
        legend(order(1 "Q1 (lowest)" 2 "Q2" 3 "Q3" 4 "Q4 (highest)") ///
            rows(1) position(6) region(lstyle(none))) ///
        graphregion(color(white)) plotregion(color(white)) ///
        name(unemp_ts_post, replace)

    graph export "$graphs/unemp_by_quartile_post2022.pdf", replace
restore


*************************************
**# 6. Occupation-group table: exposure + % college
**     --> tab:occ_group
*************************************

use `analysis', clear

drop if missing(soc_gr_str)

collapse (mean) mean_beta   = dv_rating_beta ///
         (mean) pct_college = is_college, ///
    by(soc_gr soc_gr_str)

replace pct_college = pct_college * 100

gsort -mean_beta

gen beta_str = string(mean_beta,   "%6.3f")
gen pct_str  = string(pct_college, "%5.1f")

listtex soc_gr_str beta_str pct_str ///
    using "$tables/occ_group_exposure.tex", replace ///
    rstyle(tabular) ///
    head("\begin{small}" "\begin{tabular}{lcc}" "\hline" ///
         "Occupation Group & AI Exposure ($\beta_o$) & \% College \\" "\hline") ///
    foot("\hline" "\end{tabular}" "\end{small}")


display as text "descriptives.do complete.  Wrote 4 tables + 3 figures."

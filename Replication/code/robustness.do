/*==============================================================================
  robustness.do
  ----------------------------------------------------------------------------
  Project:   Human in the Loop -- AI Exposure and Labor Market Frictions
  Author:    Leyao Wang, University of Virginia
  Purpose:   Binarized-treatment robustness check for the main DiD results.
             Replaces the continuous beta_o variable with a 0/1 indicator
             (above vs. below sample median) to address the concern in
             Callaway, Goodman-Bacon and Sant'Anna (2024) that continuous-
             treatment two-way fixed effects coefficients are weighted
             averages of underlying per-exposure effects with weights that
             need not reflect the population exposure distribution.

             Mirrors analysis.do for: full-sample (B1, B2 analogs) and
             split-sample by education (B5-B8 analogs).  Skips experience
             heterogeneity and the within-occupation triple-interaction
             test, since the CGS concern is mainly about level effects.

             Treatment definition:
               high_beta = 1{dv_rating_beta > sample median},
             where the median is computed on the pooled full sample of
             worker-years (after the same restrictions as analysis.do)
             and applied uniformly to college / non-college subsamples.

  Inputs:    $data/CPS-ASEC_analysis_Dec01.dta        (from cleaning.do)
             $data/Eloundou_updated_crosswalk.dta      (from cleaning.do)

  Outputs (all with _bin suffix):
    Tables (in $tables):
      unemployment_tableA_bin.tex            (full sample)
      logwage_tableA_bin.tex                 (full sample)
      unemp_tableA_col_bin.tex               (split: college)
      unemp_tableA_noncol_bin.tex            (split: non-college)
      logwage_tableA_col_bin.tex             (split: college)
      logwage_tableA_noncol_bin.tex          (split: non-college)

    Figures (in $graphs):
      unemployment_indFE_plot_bin.pdf        full-sample, preferred spec
      logwage_indFE_plot_bin.pdf             full-sample, preferred spec
      unemp_indFE_plot_colComb_bin.pdf       split-sample, college vs non-college
      lw_indFE_plot_colComb_bin.pdf          split-sample, college vs non-college

  Run after cleaning.do (independent of descriptives.do and analysis.do).
==============================================================================*/


//================== Directory setup =======================//

// When run via main.do, $folder is already set; otherwise edit this path.
if "$folder" == "" {
    global folder "C:\Projects\DMP\Replication"
}
cd "$folder"

global raw     "$folder/raw"
global output  "$folder/output"
global tables  "$output/tables"
global graphs  "$output/graphs"
global data    "$output/data"

cap mkdir "$output/tables"
cap mkdir "$output/graphs"

set more off
///////////////////////////////////////////////////////////


*************************************
**# Prepare analysis sample
*************************************

use "$data/CPS-ASEC_analysis_Dec01", clear

// drop high-school dropouts and below
keep if educ >= 73

// restrict to labor-force participants
keep if labforce == 2

// real wage (1982 dollars) and log wage
gen real_wage = incwage * 100 / cpiaucsl
gen lnwage    = ln(real_wage)

// years-of-schooling from CPS education recode
gen educyrs = .
replace educyrs = 12 if inlist(educ, 73)
replace educyrs = 16 if inlist(educ, 111)
replace educyrs = 18 if inlist(educ, 123)
replace educyrs = 19 if inlist(educ, 124)
replace educyrs = 20 if inlist(educ, 125)

gen exp  = max(age - educyrs - 6, 0)
gen exp2 = exp^2

// college indicator and unemployment indicator
gen is_college = educ > 110
gen unemployed = inlist(empstat, 21, 22)

replace occsoc = strtrim(occsoc)
rename  occsoc occsoc_2010

local ratings dv_rating_alpha dv_rating_beta dv_rating_gamma ///
              human_rating_alpha human_rating_beta human_rating_gamma


//---- Hierarchical exposure merge (6 -> 5 -> 4 digit SOC) ----//

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


*************************************
**# Binarize the treatment
**   high_beta = 1{dv_rating_beta > sample median}
**   median computed once on the full pooled sample,
**   applied uniformly to all subsamples.
*************************************

quietly summarize dv_rating_beta, detail
scalar beta_med = r(p50)
display as text "Sample median of dv_rating_beta: " beta_med

gen high_beta = (dv_rating_beta > beta_med) if !missing(dv_rating_beta)
label var high_beta "1 if beta_o > sample median"

tempfile analysis
save `analysis', replace


**************************************************
**# Install parmest if needed
**************************************************

cap ssc install parmest, replace


**************************************************
**# Helper: make_bin_coef_file
**   Extracts the seven year x high_beta interaction
**   coefficients with 95% CIs and saves to a tempfile.
**************************************************

cap program drop make_bin_coef_file
program define make_bin_coef_file
    syntax, ESTname(name) SPECname(string) OUTcome(string) OUTfile(string)

    est restore `estname'
    parmest, norestore

    keep if inlist(parm, ///
        "2018.year#1.high_beta", ///
        "2019.year#1.high_beta", ///
        "2020.year#1.high_beta", ///
        "2021.year#1.high_beta", ///
        "2023.year#1.high_beta", ///
        "2024.year#1.high_beta", ///
        "2025.year#1.high_beta")

    gen year = .
    replace year = 2018 if parm == "2018.year#1.high_beta"
    replace year = 2019 if parm == "2019.year#1.high_beta"
    replace year = 2020 if parm == "2020.year#1.high_beta"
    replace year = 2021 if parm == "2021.year#1.high_beta"
    replace year = 2023 if parm == "2023.year#1.high_beta"
    replace year = 2024 if parm == "2024.year#1.high_beta"
    replace year = 2025 if parm == "2025.year#1.high_beta"

    gen spec    = "`specname'"
    gen outcome = "`outcome'"

    keep year estimate min95 max95 spec outcome
    sort year
    save "`outfile'", replace
end


//================================================================
//                BLOCK A.  Full-sample regressions
//================================================================

use `analysis', clear
fvset base 2022 year
eststo clear


**************************************************
**# A.1  Log wage -- five specs, binarized treatment
**************************************************

reghdfe lnwage i.year##i.high_beta, ///
    noabsorb cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "No"
estadd local educ_FE "No"
estadd local state_yFE "No"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_A1

reghdfe lnwage i.year##i.high_beta, ///
    absorb(sex) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "No"
estadd local state_yFE "No"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_A2

reghdfe lnwage i.year##i.high_beta, ///
    absorb(sex educ) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "Yes"
estadd local state_yFE "No"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_A3

reghdfe lnwage i.year##i.high_beta, ///
    absorb(sex educ year#statefip) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "Yes"
estadd local state_yFE "Yes"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_A4

reghdfe lnwage i.year##i.high_beta, ///
    absorb(sex educ year#statefip year#ind) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "Yes"
estadd local state_yFE "Yes"
estadd local ind_FE "Yes"
estadd local se_cluster "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_A5


**************************************************
**# A.2  Unemployment -- five specs, binarized treatment
**************************************************

reghdfe unemployed i.year##i.high_beta, ///
    noabsorb cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "No"
estadd local educ_FE "No"
estadd local state_yFE "No"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum unemployed if e(sample)
estadd scalar depvar_mean = r(mean)
eststo un_A1

reghdfe unemployed i.year##i.high_beta, ///
    absorb(sex) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "No"
estadd local state_yFE "No"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum unemployed if e(sample)
estadd scalar depvar_mean = r(mean)
eststo un_A2

reghdfe unemployed i.year##i.high_beta, ///
    absorb(sex educ) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "Yes"
estadd local state_yFE "No"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum unemployed if e(sample)
estadd scalar depvar_mean = r(mean)
eststo un_A3

reghdfe unemployed i.year##i.high_beta, ///
    absorb(sex educ year#statefip) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "Yes"
estadd local state_yFE "Yes"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum unemployed if e(sample)
estadd scalar depvar_mean = r(mean)
eststo un_A4

reghdfe unemployed i.year##i.high_beta, ///
    absorb(sex educ year#statefip year#ind) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "Yes"
estadd local state_yFE "Yes"
estadd local ind_FE "Yes"
estadd local se_cluster "Occupation"
sum unemployed if e(sample)
estadd scalar depvar_mean = r(mean)
eststo un_A5


**************************************************
**# A.3  Export full-sample tables (binarized)
**************************************************

local keepBin ///
    2018.year#1.high_beta ///
    2019.year#1.high_beta ///
    2020.year#1.high_beta ///
    2021.year#1.high_beta ///
    2023.year#1.high_beta ///
    2024.year#1.high_beta ///
    2025.year#1.high_beta


// Log wage, binarized
esttab lw_A1 lw_A2 lw_A3 lw_A4 lw_A5 ///
    using "$tables/logwage_tableA_bin.tex", replace ///
    cells(b(star fmt(a3)) se(fmt(a3) par)) ///
    style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
    keep(`keepBin') ///
    varlabels( ///
        2018.year#1.high_beta "2018 $\times$ high-$\beta_o$" ///
        2019.year#1.high_beta "2019 $\times$ high-$\beta_o$" ///
        2020.year#1.high_beta "2020 $\times$ high-$\beta_o$" ///
        2021.year#1.high_beta "2021 $\times$ high-$\beta_o$" ///
        2023.year#1.high_beta "2023 $\times$ high-$\beta_o$" ///
        2024.year#1.high_beta "2024 $\times$ high-$\beta_o$" ///
        2025.year#1.high_beta "2025 $\times$ high-$\beta_o$" ///
    ) ///
    stats(depvar_mean sex_FE educ_FE state_yFE ind_FE se_cluster obs, ///
          fmt(3 0 0 0 0 0 %12.0gc) ///
          labels("Mean of dependent variable" ///
                 "Sex FE" ///
                 "Education FE" ///
                 "State $\times$ Year FE" ///
                 "Industry $\times$ Year FE" ///
                 "SE clustered at" ///
                 "Observations")) ///
    booktabs collabels(none) mlabels(none) nonumbers nomtitles gaps nonotes ///
    prehead( ///
        "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" ///
        "\begin{tabular}{l*{5}{c}}" ///
        "\toprule" ///
        "Dependent Variable: & \multicolumn{5}{c}{Log Wage} \\" ///
        "\cmidrule(lr){2-6}" ///
        " & (1) & (2) & (3) & (4) & (5) \\" ///
    ) ///
    postfoot("\bottomrule" "\end{tabular}")


// Unemployment, binarized
esttab un_A1 un_A2 un_A3 un_A4 un_A5 ///
    using "$tables/unemployment_tableA_bin.tex", replace ///
    cells(b(star fmt(a3)) se(fmt(a3) par)) ///
    style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
    keep(`keepBin') ///
    varlabels( ///
        2018.year#1.high_beta "2018 $\times$ high-$\beta_o$" ///
        2019.year#1.high_beta "2019 $\times$ high-$\beta_o$" ///
        2020.year#1.high_beta "2020 $\times$ high-$\beta_o$" ///
        2021.year#1.high_beta "2021 $\times$ high-$\beta_o$" ///
        2023.year#1.high_beta "2023 $\times$ high-$\beta_o$" ///
        2024.year#1.high_beta "2024 $\times$ high-$\beta_o$" ///
        2025.year#1.high_beta "2025 $\times$ high-$\beta_o$" ///
    ) ///
    stats(depvar_mean sex_FE educ_FE state_yFE ind_FE se_cluster obs, ///
          fmt(3 0 0 0 0 0 %12.0gc) ///
          labels("Mean of dependent variable" ///
                 "Sex FE" ///
                 "Education FE" ///
                 "State $\times$ Year FE" ///
                 "Industry $\times$ Year FE" ///
                 "SE clustered at" ///
                 "Observations")) ///
    booktabs collabels(none) mlabels(none) nonumbers nomtitles gaps nonotes ///
    prehead( ///
        "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" ///
        "\begin{tabular}{l*{5}{c}}" ///
        "\toprule" ///
        "Dependent Variable: & \multicolumn{5}{c}{Unemployment} \\" ///
        "\cmidrule(lr){2-6}" ///
        " & (1) & (2) & (3) & (4) & (5) \\" ///
    ) ///
    postfoot("\bottomrule" "\end{tabular}")


**************************************************
**# A.4  Full-sample preferred-spec coefficient plots (binarized)
**************************************************

tempfile lw_full_bin un_full_bin

make_bin_coef_file, estname(lw_A5) specname("Full sample, binarized") ///
    outcome("Log wage") outfile(`lw_full_bin')
make_bin_coef_file, estname(un_A5) specname("Full sample, binarized") ///
    outcome("Unemployment") outfile(`un_full_bin')


// Log wage: preferred spec, binarized (full sample)
use `lw_full_bin', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
sort year

quietly summarize min95, meanonly
local _ymin = r(min) - 0.002
quietly summarize max95, meanonly
local _ymax = r(max) + 0.002

twoway ///
    (rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(navy)   lpattern(solid) lwidth(medthin)) ///
    (line estimate year, ///
        lcolor(maroon) lpattern(solid) lwidth(medium)) ///
    (scatter estimate year, ///
        mcolor(maroon) msymbol(O) msize(medlarge)), ///
    text(`_ymax' 2020.5 "<-- COVID -->", place(s) color(red) size(small)) ///
    xline(2019.8 2021.2, lcolor(gs10) lpattern(dash)) ///
    xline(2022.75, lcolor(blue) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Coefficient on year x high-{&beta}{subscript:o}") ///
    title("Log Wage: binarized treatment, full sample", size(medsmall)) ///
    legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(logwage_indFE_plot_bin, replace)

graph export "$graphs/logwage_indFE_plot_bin.pdf", replace


// Unemployment: preferred spec, binarized (full sample)
use `un_full_bin', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
sort year

quietly summarize min95, meanonly
local _ymin = r(min) - 0.002
quietly summarize max95, meanonly
local _ymax = r(max) + 0.002

twoway ///
    (rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(navy)   lpattern(solid) lwidth(medthin)) ///
    (line estimate year, ///
        lcolor(maroon) lpattern(solid) lwidth(medium)) ///
    (scatter estimate year, ///
        mcolor(maroon) msymbol(O) msize(medlarge)), ///
    text(`=`_ymax' - 0.005' 2020.5 "<-- COVID -->", place(s) color(red) size(small)) ///
    xline(2019.8 2021.2, lcolor(gs10) lpattern(dash)) ///
    xline(2022.75, lcolor(blue) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Coefficient on year x high-{&beta}{subscript:o}") ///
    title("Unemployment: binarized treatment, full sample", size(medsmall)) ///
    legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(unemployment_indFE_plot_bin, replace)

graph export "$graphs/unemployment_indFE_plot_bin.pdf", replace


//================================================================
//     BLOCK B.  Split-sample regressions (college / non-college)
//   high_beta cut point is fixed at the FULL-sample median;
//   sub-sample is restricted by is_college.
//================================================================

tempfile lw_bin_col lw_bin_noncol un_bin_col un_bin_noncol


foreach grp in col noncol {

    use `analysis', clear

    if "`grp'" == "col"    keep if is_college == 1
    if "`grp'" == "noncol" keep if is_college == 0

    eststo clear
    fvset base 2022 year


    **************************************************
    **# B.1  Log wage -- five specs, binarized (`grp')
    **************************************************

    reghdfe lnwage i.year##i.high_beta, ///
        noabsorb cluster(occsoc)
    estadd scalar obs = e(N)
    estadd local sex_FE "No"
    estadd local educ_FE "No"
    estadd local state_yFE "No"
    estadd local ind_FE "No"
    estadd local se_cluster "Occupation"
    sum lnwage if e(sample)
    estadd scalar depvar_mean = r(mean)
    eststo lw_A1

    reghdfe lnwage i.year##i.high_beta, ///
        absorb(sex) cluster(occsoc)
    estadd scalar obs = e(N)
    estadd local sex_FE "Yes"
    estadd local educ_FE "No"
    estadd local state_yFE "No"
    estadd local ind_FE "No"
    estadd local se_cluster "Occupation"
    sum lnwage if e(sample)
    estadd scalar depvar_mean = r(mean)
    eststo lw_A2

    reghdfe lnwage i.year##i.high_beta, ///
        absorb(sex educ) cluster(occsoc)
    estadd scalar obs = e(N)
    estadd local sex_FE "Yes"
    estadd local educ_FE "Yes"
    estadd local state_yFE "No"
    estadd local ind_FE "No"
    estadd local se_cluster "Occupation"
    sum lnwage if e(sample)
    estadd scalar depvar_mean = r(mean)
    eststo lw_A3

    reghdfe lnwage i.year##i.high_beta, ///
        absorb(sex educ year#statefip) cluster(occsoc)
    estadd scalar obs = e(N)
    estadd local sex_FE "Yes"
    estadd local educ_FE "Yes"
    estadd local state_yFE "Yes"
    estadd local ind_FE "No"
    estadd local se_cluster "Occupation"
    sum lnwage if e(sample)
    estadd scalar depvar_mean = r(mean)
    eststo lw_A4

    reghdfe lnwage i.year##i.high_beta, ///
        absorb(sex educ year#statefip year#ind) cluster(occsoc)
    estadd scalar obs = e(N)
    estadd local sex_FE "Yes"
    estadd local educ_FE "Yes"
    estadd local state_yFE "Yes"
    estadd local ind_FE "Yes"
    estadd local se_cluster "Occupation"
    sum lnwage if e(sample)
    estadd scalar depvar_mean = r(mean)
    eststo lw_A5


    **************************************************
    **# B.2  Unemployment -- five specs, binarized (`grp')
    **************************************************

    reghdfe unemployed i.year##i.high_beta, ///
        noabsorb cluster(occsoc)
    estadd scalar obs = e(N)
    estadd local sex_FE "No"
    estadd local educ_FE "No"
    estadd local state_yFE "No"
    estadd local ind_FE "No"
    estadd local se_cluster "Occupation"
    sum unemployed if e(sample)
    estadd scalar depvar_mean = r(mean)
    eststo un_A1

    reghdfe unemployed i.year##i.high_beta, ///
        absorb(sex) cluster(occsoc)
    estadd scalar obs = e(N)
    estadd local sex_FE "Yes"
    estadd local educ_FE "No"
    estadd local state_yFE "No"
    estadd local ind_FE "No"
    estadd local se_cluster "Occupation"
    sum unemployed if e(sample)
    estadd scalar depvar_mean = r(mean)
    eststo un_A2

    reghdfe unemployed i.year##i.high_beta, ///
        absorb(sex educ) cluster(occsoc)
    estadd scalar obs = e(N)
    estadd local sex_FE "Yes"
    estadd local educ_FE "Yes"
    estadd local state_yFE "No"
    estadd local ind_FE "No"
    estadd local se_cluster "Occupation"
    sum unemployed if e(sample)
    estadd scalar depvar_mean = r(mean)
    eststo un_A3

    reghdfe unemployed i.year##i.high_beta, ///
        absorb(sex educ year#statefip) cluster(occsoc)
    estadd scalar obs = e(N)
    estadd local sex_FE "Yes"
    estadd local educ_FE "Yes"
    estadd local state_yFE "Yes"
    estadd local ind_FE "No"
    estadd local se_cluster "Occupation"
    sum unemployed if e(sample)
    estadd scalar depvar_mean = r(mean)
    eststo un_A4

    reghdfe unemployed i.year##i.high_beta, ///
        absorb(sex educ year#statefip year#ind) cluster(occsoc)
    estadd scalar obs = e(N)
    estadd local sex_FE "Yes"
    estadd local educ_FE "Yes"
    estadd local state_yFE "Yes"
    estadd local ind_FE "Yes"
    estadd local se_cluster "Occupation"
    sum unemployed if e(sample)
    estadd scalar depvar_mean = r(mean)
    eststo un_A5


    **************************************************
    **# B.3  Export split-sample tables (binarized)
    **************************************************

    // Log wage, binarized, `grp'
    esttab lw_A1 lw_A2 lw_A3 lw_A4 lw_A5 ///
        using "$tables/logwage_tableA_`grp'_bin.tex", replace ///
        cells(b(star fmt(a3)) se(fmt(a3) par)) ///
        style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
        keep(*year#1.high_beta*) nobaselevels ///
        varlabels( ///
            2018.year#1.high_beta "2018 $\times$ high-$\beta_o$" ///
            2019.year#1.high_beta "2019 $\times$ high-$\beta_o$" ///
            2020.year#1.high_beta "2020 $\times$ high-$\beta_o$" ///
            2021.year#1.high_beta "2021 $\times$ high-$\beta_o$" ///
            2023.year#1.high_beta "2023 $\times$ high-$\beta_o$" ///
            2024.year#1.high_beta "2024 $\times$ high-$\beta_o$" ///
            2025.year#1.high_beta "2025 $\times$ high-$\beta_o$" ///
        ) ///
        stats(depvar_mean sex_FE educ_FE state_yFE ind_FE se_cluster obs, ///
              fmt(3 0 0 0 0 0 %12.0gc) ///
              labels("Mean of dependent variable" ///
                     "Sex FE" ///
                     "Education FE" ///
                     "State $\times$ Year FE" ///
                     "Industry $\times$ Year FE" ///
                     "SE clustered at" ///
                     "Observations")) ///
        booktabs collabels(none) mlabels(none) nonumbers nomtitles gaps nonotes ///
        prehead( ///
            "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" ///
            "\begin{tabular}{l*{5}{c}}" ///
            "\toprule" ///
            "Dependent Variable: & \multicolumn{5}{c}{Log Wage} \\" ///
            "\cmidrule(lr){2-6}" ///
            " & (1) & (2) & (3) & (4) & (5) \\" ///
        ) ///
        postfoot("\bottomrule" "\end{tabular}")


    // Unemployment, binarized, `grp'
    esttab un_A1 un_A2 un_A3 un_A4 un_A5 ///
        using "$tables/unemp_tableA_`grp'_bin.tex", replace ///
        cells(b(star fmt(a3)) se(fmt(a3) par)) ///
        style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
        keep(*year#1.high_beta*) nobaselevels ///
        varlabels( ///
            2018.year#1.high_beta "2018 $\times$ high-$\beta_o$" ///
            2019.year#1.high_beta "2019 $\times$ high-$\beta_o$" ///
            2020.year#1.high_beta "2020 $\times$ high-$\beta_o$" ///
            2021.year#1.high_beta "2021 $\times$ high-$\beta_o$" ///
            2023.year#1.high_beta "2023 $\times$ high-$\beta_o$" ///
            2024.year#1.high_beta "2024 $\times$ high-$\beta_o$" ///
            2025.year#1.high_beta "2025 $\times$ high-$\beta_o$" ///
        ) ///
        stats(depvar_mean sex_FE educ_FE state_yFE ind_FE se_cluster obs, ///
              fmt(3 0 0 0 0 0 %12.0gc) ///
              labels("Mean of dependent variable" ///
                     "Sex FE" ///
                     "Education FE" ///
                     "State $\times$ Year FE" ///
                     "Industry $\times$ Year FE" ///
                     "SE clustered at" ///
                     "Observations")) ///
        booktabs collabels(none) mlabels(none) nonumbers nomtitles gaps nonotes ///
        prehead( ///
            "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" ///
            "\begin{tabular}{l*{5}{c}}" ///
            "\toprule" ///
            "Dependent Variable: & \multicolumn{5}{c}{Unemployment} \\" ///
            "\cmidrule(lr){2-6}" ///
            " & (1) & (2) & (3) & (4) & (5) \\" ///
        ) ///
        postfoot("\bottomrule" "\end{tabular}")


    **************************************************
    **# B.4  Extract preferred-spec (col 5) coefs for combined plots
    **************************************************

    tempfile tmp_lw_bin tmp_un_bin
    make_bin_coef_file, estname(lw_A5) specname("State x year + ind x year FE, binarized") ///
                        outcome("Log wage") outfile(`tmp_lw_bin')
    make_bin_coef_file, estname(un_A5) specname("State x year + ind x year FE, binarized") ///
                        outcome("Unemployment") outfile(`tmp_un_bin')

    use `tmp_lw_bin', clear
    save `lw_bin_`grp'', replace

    use `tmp_un_bin', clear
    save `un_bin_`grp'', replace

} // end foreach grp


**************************************************
**# B.5  Combined coef plots: college vs non-college, binarized
**************************************************

// Log wage, combined
use `lw_bin_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
tempfile tmp_c
save `tmp_c', replace

use `lw_bin_noncol', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "Non-college"
append using `tmp_c'

gen x = year - 0.1 if grp == "College"
replace x = year + 0.1 if grp == "Non-college"
sort grp year

quietly summarize min95, meanonly
local _ymin = r(min) - 0.002
quietly summarize max95, meanonly
local _ymax = r(max) + 0.002

twoway ///
    (rcap min95 max95 x if grp=="College" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(navy)   lpattern(solid) lwidth(medthin)) ///
    (line estimate x if grp=="College", ///
        lcolor(navy)   lpattern(solid) lwidth(medium) sort) ///
    (scatter estimate x if grp=="College", ///
        mcolor(navy)   msymbol(O) msize(medlarge)) ///
    (rcap min95 max95 x if grp=="Non-college" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(maroon) lpattern(solid) lwidth(medthin)) ///
    (line estimate x if grp=="Non-college", ///
        lcolor(maroon) lpattern(solid) lwidth(medium) sort) ///
    (scatter estimate x if grp=="Non-college", ///
        mcolor(maroon) msymbol(D) msize(medlarge)), ///
    text(`_ymax' 2020.5 "<-- COVID -->", place(s) color(red) size(small)) ///
    xline(2019.8 2021.2, lcolor(gs10) lpattern(dash)) ///
    xline(2022.75, lcolor(blue) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Coefficient on year x high-{&beta}{subscript:o}") ///
    title("Log Wage: binarized treatment, college vs non-college", size(medsmall)) ///
    legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(lw_indFE_colComb_bin, replace)

graph export "$graphs/lw_indFE_plot_colComb_bin.pdf", replace


// Unemployment, combined
use `un_bin_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
save `tmp_c', replace

use `un_bin_noncol', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "Non-college"
append using `tmp_c'

gen x = year - 0.1 if grp == "College"
replace x = year + 0.1 if grp == "Non-college"
sort grp year

quietly summarize min95, meanonly
local _ymin = r(min) - 0.002
quietly summarize max95, meanonly
local _ymax = r(max) + 0.002

twoway ///
    (rcap min95 max95 x if grp=="College" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(navy)   lpattern(solid) lwidth(medthin)) ///
    (line estimate x if grp=="College", ///
        lcolor(navy)   lpattern(solid) lwidth(medium) sort) ///
    (scatter estimate x if grp=="College", ///
        mcolor(navy)   msymbol(O) msize(medlarge)) ///
    (rcap min95 max95 x if grp=="Non-college" & inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(maroon) lpattern(solid) lwidth(medthin)) ///
    (line estimate x if grp=="Non-college", ///
        lcolor(maroon) lpattern(solid) lwidth(medium) sort) ///
    (scatter estimate x if grp=="Non-college", ///
        mcolor(maroon) msymbol(D) msize(medlarge)), ///
    text(`_ymax' 2020.5 "<-- COVID -->", place(s) color(red) size(small)) ///
    xline(2019.8 2021.2, lcolor(gs10) lpattern(dash)) ///
    xline(2022.75, lcolor(blue) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Coefficient on year x high-{&beta}{subscript:o}") ///
    title("Unemployment: binarized treatment, college vs non-college", size(medsmall)) ///
    legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(unemp_indFE_colComb_bin, replace)

graph export "$graphs/unemp_indFE_plot_colComb_bin.pdf", replace


display as text "robustness.do complete.  Wrote 6 tables + 4 coefficient plots."

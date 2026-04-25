/*==============================================================================
  analysis.do
  ----------------------------------------------------------------------------
  Project:   Human in the Loop -- AI Exposure and Labor Market Frictions
  Author:    Leyao Wang, University of Virginia
  Purpose:   Run all event-study DiD regressions and produce every main-text
             and appendix regression table + coefficient plot used in the
             thesis.

             Three blocks of analysis, in order:
               A. Full sample (B1-B4 tables + 2 state-year FE coefplots)
               B. Split sample college vs non-college (B5-B8 tables +
                  2 combined coefplots)
               C. Within-occupation triple-interaction test
                  (B9 table + 1 coefplot)

  Inputs:    $data/CPS-ASEC_analysis_Dec01.dta        (from cleaning.do)
             $data/Eloundou_updated_crosswalk.dta      (from cleaning.do)

  Outputs (each with the draft label):
    Tables (in $tables):
      unemployment_tableA.tex            tab:unemployment_main   (B1)
      logwage_tableA.tex                 tab:logwage_main        (B2)
      unemployment_tableB.tex            tab:unemp_exphet        (B3)
      logwage_tableB.tex                 tab:lw_exphet           (B4)
      unemp_tableA_col.tex               tab:unemp_col           (B5)
      unemp_tableA_noncol.tex            tab:unemp_noncol        (B6)
      logwage_tableA_col.tex             tab:lw_col              (B7)
      logwage_tableA_noncol.tex          tab:lw_noncol           (B8)
      het_within_occ.tex                 tab:lw_within_occ       (B9)
                                         (2 cols: log wage and unemployment)

    Figures (in $graphs), ind x year FE spec -- the preferred spec shown in draft:
      logwage_indFE_plot.pdf             full-sample log wage, ind x year FE
      unemployment_indFE_plot.pdf        full-sample unemployment, ind x year FE
      lw_indFE_plot_colComb.pdf          split-sample combined log wage, ind x year FE
      unemp_indFE_plot_colComb.pdf       split-sample combined unemp, ind x year FE
      lw_within_ind_plot.pdf             within-occ triple interaction (log wage)
      unemp_within_ind_plot.pdf          within-occ triple interaction (unemployment)

    (Older state x year FE only plots are commented out in the code but retained
     for reference: logwage_stateYFE_plot.pdf, unemployment_stateYFE_plot.pdf,
     lw_stateYFE_plot_colComb.pdf, unemp_stateYFE_plot_colComb.pdf,
     lw_within_plot.pdf.)

  Every regression is also estimated with industry x year FE layered on the
  preferred specification; the ind x year FE column appears as the 5th column
  in Tables B1-B8.  Table B9 reports only the ind x year FE spec (1 column).

  Run after cleaning.do (and, optionally, descriptives.do).
==============================================================================*/


//================== Directory setup =======================//

global folder "C:\Projects\DMP\Replication"
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

// years-of-schooling from CPS education recode (for potential experience)
gen educyrs = .
replace educyrs = 12 if inlist(educ, 73)
replace educyrs = 16 if inlist(educ, 111)
replace educyrs = 18 if inlist(educ, 123)
replace educyrs = 19 if inlist(educ, 124)
replace educyrs = 20 if inlist(educ, 125)

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


**************************************************
**# Install parmest (for coefficient extraction)
**************************************************

cap ssc install parmest, replace


**************************************************
**# Helper: make_coef_file
**   Takes a stored estimate, extracts the seven
**   year x dv_rating_beta double-interaction coefs
**   with 95% CIs and outcome/spec labels,
**   and saves to a tempfile for plotting.
**************************************************

cap program drop make_coef_file
program define make_coef_file
    syntax, ESTname(name) SPECname(string) OUTcome(string) OUTfile(string)

    est restore `estname'
    parmest, norestore

    keep if inlist(parm, ///
        "2018.year#c.dv_rating_beta", ///
        "2019.year#c.dv_rating_beta", ///
        "2020.year#c.dv_rating_beta", ///
        "2021.year#c.dv_rating_beta", ///
        "2023.year#c.dv_rating_beta", ///
        "2024.year#c.dv_rating_beta", ///
        "2025.year#c.dv_rating_beta")

    gen year = .
    replace year = 2018 if parm == "2018.year#c.dv_rating_beta"
    replace year = 2019 if parm == "2019.year#c.dv_rating_beta"
    replace year = 2020 if parm == "2020.year#c.dv_rating_beta"
    replace year = 2021 if parm == "2021.year#c.dv_rating_beta"
    replace year = 2023 if parm == "2023.year#c.dv_rating_beta"
    replace year = 2024 if parm == "2024.year#c.dv_rating_beta"
    replace year = 2025 if parm == "2025.year#c.dv_rating_beta"

    gen spec    = "`specname'"
    gen outcome = "`outcome'"

    keep year estimate min95 max95 spec outcome
    sort year
    save "`outfile'", replace
end


//================================================================
//                BLOCK A.  Full-sample regressions
//   Tables B1-B4 + two state x year coefficient plots
//================================================================

use `analysis', clear
fvset base 2022 year
eststo clear


**************************************************
**# A.1  Log wage -- Table A (main) and Table B (experience het)
**************************************************

// Table A: four specifications, year x beta double interaction only
reghdfe lnwage i.year##c.dv_rating_beta, ///
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

reghdfe lnwage i.year##c.dv_rating_beta, ///
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

reghdfe lnwage i.year##c.dv_rating_beta, ///
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

reghdfe lnwage i.year##c.dv_rating_beta, ///
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

reghdfe lnwage i.year##c.dv_rating_beta, ///
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


// Table B: five specifications, experience x year x beta triple interaction
reghdfe lnwage c.exp##i.year##c.dv_rating_beta, ///
    noabsorb cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "No"
estadd local educ_FE "No"
estadd local state_yFE "No"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_B1

reghdfe lnwage c.exp##i.year##c.dv_rating_beta, ///
    absorb(sex) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "No"
estadd local state_yFE "No"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_B2

reghdfe lnwage c.exp##i.year##c.dv_rating_beta, ///
    absorb(sex educ) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "Yes"
estadd local state_yFE "No"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_B3

reghdfe lnwage c.exp##i.year##c.dv_rating_beta, ///
    absorb(sex educ year#statefip) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "Yes"
estadd local state_yFE "Yes"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_B4

reghdfe lnwage c.exp##i.year##c.dv_rating_beta, ///
    absorb(sex educ year#statefip year#ind) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "Yes"
estadd local state_yFE "Yes"
estadd local ind_FE "Yes"
estadd local se_cluster "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_B5


**************************************************
**# A.2  Unemployment -- Table A (main) and Table B (experience het)
**************************************************

reghdfe unemployed i.year##c.dv_rating_beta, ///
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

reghdfe unemployed i.year##c.dv_rating_beta, ///
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

reghdfe unemployed i.year##c.dv_rating_beta, ///
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

reghdfe unemployed i.year##c.dv_rating_beta, ///
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

reghdfe unemployed i.year##c.dv_rating_beta, ///
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


reghdfe unemployed c.exp##i.year##c.dv_rating_beta, ///
    noabsorb cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "No"
estadd local educ_FE "No"
estadd local state_yFE "No"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum unemployed if e(sample)
estadd scalar depvar_mean = r(mean)
eststo un_B1

reghdfe unemployed c.exp##i.year##c.dv_rating_beta, ///
    absorb(sex) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "No"
estadd local state_yFE "No"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum unemployed if e(sample)
estadd scalar depvar_mean = r(mean)
eststo un_B2

reghdfe unemployed c.exp##i.year##c.dv_rating_beta, ///
    absorb(sex educ) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "Yes"
estadd local state_yFE "No"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum unemployed if e(sample)
estadd scalar depvar_mean = r(mean)
eststo un_B3

reghdfe unemployed c.exp##i.year##c.dv_rating_beta, ///
    absorb(sex educ year#statefip) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "Yes"
estadd local state_yFE "Yes"
estadd local ind_FE "No"
estadd local se_cluster "Occupation"
sum unemployed if e(sample)
estadd scalar depvar_mean = r(mean)
eststo un_B4

reghdfe unemployed c.exp##i.year##c.dv_rating_beta, ///
    absorb(sex educ year#statefip year#ind) cluster(occsoc)
estadd scalar obs = e(N)
estadd local sex_FE "Yes"
estadd local educ_FE "Yes"
estadd local state_yFE "Yes"
estadd local ind_FE "Yes"
estadd local se_cluster "Occupation"
sum unemployed if e(sample)
estadd scalar depvar_mean = r(mean)
eststo un_B5


**************************************************
**# A.3  Export full-sample tables  (B1-B4)
**************************************************

local keepA ///
    2018.year#c.dv_rating_beta ///
    2019.year#c.dv_rating_beta ///
    2020.year#c.dv_rating_beta ///
    2021.year#c.dv_rating_beta ///
    2023.year#c.dv_rating_beta ///
    2024.year#c.dv_rating_beta ///
    2025.year#c.dv_rating_beta

local keepB ///
    2018.year#c.exp#c.dv_rating_beta ///
    2019.year#c.exp#c.dv_rating_beta ///
    2020.year#c.exp#c.dv_rating_beta ///
    2021.year#c.exp#c.dv_rating_beta ///
    2023.year#c.exp#c.dv_rating_beta ///
    2024.year#c.exp#c.dv_rating_beta ///
    2025.year#c.exp#c.dv_rating_beta


// B2: log wage, Table A
esttab lw_A1 lw_A2 lw_A3 lw_A4 lw_A5 ///
    using "$tables/logwage_tableA.tex", replace ///
    cells(b(star fmt(a3)) se(fmt(a3) par)) ///
    style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
    keep(`keepA') ///
    varlabels( ///
        2018.year#c.dv_rating_beta "2018 $\times$ AI exposure" ///
        2019.year#c.dv_rating_beta "2019 $\times$ AI exposure" ///
        2020.year#c.dv_rating_beta "2020 $\times$ AI exposure" ///
        2021.year#c.dv_rating_beta "2021 $\times$ AI exposure" ///
        2023.year#c.dv_rating_beta "2023 $\times$ AI exposure" ///
        2024.year#c.dv_rating_beta "2024 $\times$ AI exposure" ///
        2025.year#c.dv_rating_beta "2025 $\times$ AI exposure" ///
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


// B4: log wage, Table B (experience heterogeneity)
esttab lw_B1 lw_B2 lw_B3 lw_B4 lw_B5 ///
    using "$tables/logwage_tableB.tex", replace ///
    cells(b(star fmt(a3)) se(fmt(a3) par)) ///
    style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
    keep(`keepB') ///
    varlabels( ///
        2018.year#c.exp#c.dv_rating_beta "2018 $\times$ Experience $\times$ AI exposure" ///
        2019.year#c.exp#c.dv_rating_beta "2019 $\times$ Experience $\times$ AI exposure" ///
        2020.year#c.exp#c.dv_rating_beta "2020 $\times$ Experience $\times$ AI exposure" ///
        2021.year#c.exp#c.dv_rating_beta "2021 $\times$ Experience $\times$ AI exposure" ///
        2023.year#c.exp#c.dv_rating_beta "2023 $\times$ Experience $\times$ AI exposure" ///
        2024.year#c.exp#c.dv_rating_beta "2024 $\times$ Experience $\times$ AI exposure" ///
        2025.year#c.exp#c.dv_rating_beta "2025 $\times$ Experience $\times$ AI exposure" ///
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


// B1: unemployment, Table A
esttab un_A1 un_A2 un_A3 un_A4 un_A5 ///
    using "$tables/unemployment_tableA.tex", replace ///
    cells(b(star fmt(a3)) se(fmt(a3) par)) ///
    style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
    keep(`keepA') ///
    varlabels( ///
        2018.year#c.dv_rating_beta "2018 $\times$ AI exposure" ///
        2019.year#c.dv_rating_beta "2019 $\times$ AI exposure" ///
        2020.year#c.dv_rating_beta "2020 $\times$ AI exposure" ///
        2021.year#c.dv_rating_beta "2021 $\times$ AI exposure" ///
        2023.year#c.dv_rating_beta "2023 $\times$ AI exposure" ///
        2024.year#c.dv_rating_beta "2024 $\times$ AI exposure" ///
        2025.year#c.dv_rating_beta "2025 $\times$ AI exposure" ///
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


// B3: unemployment, Table B (experience heterogeneity)
esttab un_B1 un_B2 un_B3 un_B4 un_B5 ///
    using "$tables/unemployment_tableB.tex", replace ///
    cells(b(star fmt(a3)) se(fmt(a3) par)) ///
    style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
    keep(`keepB') ///
    varlabels( ///
        2018.year#c.exp#c.dv_rating_beta "2018 $\times$ Experience $\times$ AI exposure" ///
        2019.year#c.exp#c.dv_rating_beta "2019 $\times$ Experience $\times$ AI exposure" ///
        2020.year#c.exp#c.dv_rating_beta "2020 $\times$ Experience $\times$ AI exposure" ///
        2021.year#c.exp#c.dv_rating_beta "2021 $\times$ Experience $\times$ AI exposure" ///
        2023.year#c.exp#c.dv_rating_beta "2023 $\times$ Experience $\times$ AI exposure" ///
        2024.year#c.exp#c.dv_rating_beta "2024 $\times$ Experience $\times$ AI exposure" ///
        2025.year#c.exp#c.dv_rating_beta "2025 $\times$ Experience $\times$ AI exposure" ///
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
**# A.4  Full-sample state x year FE coefficient plots [DEPRECATED]
**   Kept as comment; the ind x year FE version in Block A.5
**   is now the preferred spec shown in the draft.
**************************************************

/*
tempfile lw_full_coef un_full_coef

make_coef_file, estname(lw_A4) specname("Full sample") outcome("Log wage") ///
    outfile(`lw_full_coef')
make_coef_file, estname(un_A4) specname("Full sample") outcome("Unemployment") ///
    outfile(`un_full_coef')


// Log wage: state x year FE (full sample)
use `lw_full_coef', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
sort year

twoway ///
    (rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(navy)   lpattern(solid) lwidth(medthin)) ///
    (line estimate year, ///
        lcolor(maroon) lpattern(solid) lwidth(medium)) ///
    (scatter estimate year, ///
        mcolor(maroon) msymbol(O) msize(medlarge)), ///
    xline(2022.5, lcolor(gs8) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Coefficient on year x AI exposure") ///
    title("Log Wage: Sex, Education, and State x Year FE") ///
    legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(logwage_stateYFE_plot, replace)

graph export "$graphs/logwage_stateYFE_plot.pdf", replace


// Unemployment: state x year FE (full sample)
use `un_full_coef', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
sort year

twoway ///
    (rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(navy)   lpattern(solid) lwidth(medthin)) ///
    (line estimate year, ///
        lcolor(maroon) lpattern(solid) lwidth(medium)) ///
    (scatter estimate year, ///
        mcolor(maroon) msymbol(O) msize(medlarge)), ///
    xline(2022.5, lcolor(gs8) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Coefficient on year x AI exposure") ///
    title("Unemployment: Sex, Education, and State x Year FE") ///
    legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(unemployment_stateYFE_plot, replace)

graph export "$graphs/unemployment_stateYFE_plot.pdf", replace
*/


**************************************************
**# A.5  Industry-FE coefficient plots (full sample)
**   Reuses lw_A5 / un_A5 already estimated in A.1 / A.2.
**************************************************

// Extract coefs for the two industry-FE plots
// (lw_A5 and un_A5 already estimated in Blocks A.1 and A.2)
tempfile lw_indFE_coef un_indFE_coef

make_coef_file, estname(lw_A5) specname("State x year + ind x year FE") ///
    outcome("Log wage") outfile(`lw_indFE_coef')
make_coef_file, estname(un_A5) specname("State x year + ind x year FE") ///
    outcome("Unemployment") outfile(`un_indFE_coef')


// Log wage: state x year + ind FE (full sample)
use `lw_indFE_coef', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
sort year

twoway ///
    (rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(navy)   lpattern(solid) lwidth(medthin)) ///
    (line estimate year, ///
        lcolor(maroon) lpattern(solid) lwidth(medium)) ///
    (scatter estimate year, ///
        mcolor(maroon) msymbol(O) msize(medlarge)), ///
    xline(2022.5, lcolor(gs8) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Coefficient on year x AI exposure") ///
    title("Log Wage: Sex, Education, State x Year, and Industry x Year FE") ///
    legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(logwage_indFE_plot, replace)

graph export "$graphs/logwage_indFE_plot.pdf", replace


// Unemployment: state x year + ind FE (full sample)
use `un_indFE_coef', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
sort year

twoway ///
    (rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(navy)   lpattern(solid) lwidth(medthin)) ///
    (line estimate year, ///
        lcolor(maroon) lpattern(solid) lwidth(medium)) ///
    (scatter estimate year, ///
        mcolor(maroon) msymbol(O) msize(medlarge)), ///
    xline(2022.5, lcolor(gs8) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Coefficient on year x AI exposure") ///
    title("Unemployment: Sex, Education, State x Year, and Industry x Year FE") ///
    legend(order(3 "Coefficient" 1 "95% CI") rows(1) position(6) region(lstyle(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(unemployment_indFE_plot, replace)

graph export "$graphs/unemployment_indFE_plot.pdf", replace


//================================================================
//     BLOCK B.  Split-sample regressions (college / non-college)
//   Tables B5-B8 + combined state x year coefplots
//================================================================

// Outer tempfiles to carry per-group state x year coefs across the loop
tempfile lw_stateYFE_col lw_stateYFE_noncol un_stateYFE_col un_stateYFE_noncol
tempfile lw_indFE_col lw_indFE_noncol un_indFE_col un_indFE_noncol


foreach grp in col noncol {

    use `analysis', clear

    if "`grp'" == "col"    keep if is_college == 1
    if "`grp'" == "noncol" keep if is_college == 0

    eststo clear
    fvset base 2022 year


    **************************************************
    **# B.1  Log wage -- Table A (`grp')
    **************************************************

    reghdfe lnwage i.year##c.dv_rating_beta, ///
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

    reghdfe lnwage i.year##c.dv_rating_beta, ///
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

    reghdfe lnwage i.year##c.dv_rating_beta, ///
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

    reghdfe lnwage i.year##c.dv_rating_beta, ///
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

    reghdfe lnwage i.year##c.dv_rating_beta, ///
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
    **# B.2  Unemployment -- Table A (`grp')
    **************************************************

    reghdfe unemployed i.year##c.dv_rating_beta, ///
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

    reghdfe unemployed i.year##c.dv_rating_beta, ///
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

    reghdfe unemployed i.year##c.dv_rating_beta, ///
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

    reghdfe unemployed i.year##c.dv_rating_beta, ///
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

    reghdfe unemployed i.year##c.dv_rating_beta, ///
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
    **# B.3  Export split-sample tables  (B5-B8)
    **************************************************

    // B7 / B8: log wage, college / non-college
    esttab lw_A1 lw_A2 lw_A3 lw_A4 lw_A5 ///
        using "$tables/logwage_tableA_`grp'.tex", replace ///
        cells(b(star fmt(a3)) se(fmt(a3) par)) ///
        style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
        keep(*year#c.dv_rating_beta*) nobaselevels ///
        varlabels( ///
            2018.year#c.dv_rating_beta "2018 $\times$ AI exposure" ///
            2019.year#c.dv_rating_beta "2019 $\times$ AI exposure" ///
            2020.year#c.dv_rating_beta "2020 $\times$ AI exposure" ///
            2021.year#c.dv_rating_beta "2021 $\times$ AI exposure" ///
            2023.year#c.dv_rating_beta "2023 $\times$ AI exposure" ///
            2024.year#c.dv_rating_beta "2024 $\times$ AI exposure" ///
            2025.year#c.dv_rating_beta "2025 $\times$ AI exposure" ///
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


    // B5 / B6: unemployment, college / non-college
    esttab un_A1 un_A2 un_A3 un_A4 un_A5 ///
        using "$tables/unemp_tableA_`grp'.tex", replace ///
        cells(b(star fmt(a3)) se(fmt(a3) par)) ///
        style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
        keep(*year#c.dv_rating_beta*) nobaselevels ///
        varlabels( ///
            2018.year#c.dv_rating_beta "2018 $\times$ AI exposure" ///
            2019.year#c.dv_rating_beta "2019 $\times$ AI exposure" ///
            2020.year#c.dv_rating_beta "2020 $\times$ AI exposure" ///
            2021.year#c.dv_rating_beta "2021 $\times$ AI exposure" ///
            2023.year#c.dv_rating_beta "2023 $\times$ AI exposure" ///
            2024.year#c.dv_rating_beta "2024 $\times$ AI exposure" ///
            2025.year#c.dv_rating_beta "2025 $\times$ AI exposure" ///
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
    **# B.4  Extract coefs for combined plots
    **   Save both state x year FE (col 4) and ind x year FE (col 5)
    **   to outer tempfiles for after-loop plotting.
    **************************************************

    tempfile tmp_lw tmp_un tmp_lw_ind tmp_un_ind

    // col 4: state x year FE
    make_coef_file, estname(lw_A4) specname("State x year FE") ///
                    outcome("Log wage") outfile(`tmp_lw')
    make_coef_file, estname(un_A4) specname("State x year FE") ///
                    outcome("Unemployment") outfile(`tmp_un')
    use `tmp_lw', clear
    save `lw_stateYFE_`grp'', replace
    use `tmp_un', clear
    save `un_stateYFE_`grp'', replace

    // col 5: state x year FE + ind x year FE
    make_coef_file, estname(lw_A5) specname("State x year + ind x year FE") ///
                    outcome("Log wage") outfile(`tmp_lw_ind')
    make_coef_file, estname(un_A5) specname("State x year + ind x year FE") ///
                    outcome("Unemployment") outfile(`tmp_un_ind')
    use `tmp_lw_ind', clear
    save `lw_indFE_`grp'', replace
    use `tmp_un_ind', clear
    save `un_indFE_`grp'', replace

} // end foreach grp


**************************************************
**# B.5  Combined coef plots: college vs non-college [DEPRECATED]
**   state x year FE version.  The ind x year FE version
**   in Block B.6 is now the preferred spec shown in the draft.
**************************************************

/*
// Log wage: state x year FE, combined
use `lw_stateYFE_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
tempfile tmp_c
save `tmp_c', replace

use `lw_stateYFE_noncol', clear
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
    xline(2022.5, lcolor(gs8) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Coefficient on year x AI exposure") ///
    title("Log Wage: Sex, Education, and State x Year FE") ///
    legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(lw_stateYFE_colComb, replace)

graph export "$graphs/lw_stateYFE_plot_colComb.pdf", replace


// Unemployment: state x year FE, combined
use `un_stateYFE_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
save `tmp_c', replace

use `un_stateYFE_noncol', clear
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
    xline(2022.5, lcolor(gs8) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Coefficient on year x AI exposure") ///
    title("Unemployment: Sex, Education, and State x Year FE") ///
    legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(unemp_stateYFE_colComb, replace)

graph export "$graphs/unemp_stateYFE_plot_colComb.pdf", replace
*/


**************************************************
**# B.6  Combined coef plots: ind x year FE version
**   --> lw_indFE_plot_colComb.pdf, unemp_indFE_plot_colComb.pdf
**************************************************

// Log wage: state x year + ind x year FE, combined
use `lw_indFE_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
tempfile tmp_c
save `tmp_c', replace

use `lw_indFE_noncol', clear
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
    xline(2022.5, lcolor(gs8) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Coefficient on year x AI exposure") ///
    title("Log Wage: Sex, Education, State x Year, and Industry x Year FE") ///
    legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(lw_indFE_colComb, replace)

graph export "$graphs/lw_indFE_plot_colComb.pdf", replace


// Unemployment: state x year + ind x year FE, combined
use `un_indFE_col', clear
insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
gen grp = "College"
save `tmp_c', replace

use `un_indFE_noncol', clear
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
    xline(2022.5, lcolor(gs8) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Coefficient on year x AI exposure") ///
    title("Unemployment: Sex, Education, State x Year, and Industry x Year FE") ///
    legend(order(3 "College" 6 "Non-college") rows(1) position(6) region(lstyle(none))) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(unemp_indFE_colComb, replace)

graph export "$graphs/unemp_indFE_plot_colComb.pdf", replace


//================================================================
//     BLOCK C.  Within-occupation test (occ x year FE)
//   Table B9 + fig:lw_within_plot
//================================================================
/*
Question: is the college vs non-college wage gap in high-exposure
occupations driven by

  (H1) within-occupation differences -- college and non-college
       workers in the SAME occupation facing different wage pressure; or
  (H2) between-occupation sorting -- college and non-college workers
       at similar beta_o ending up in systematically different jobs.

Test: pool both groups, absorb occsoc_2010 x year FE, and run a triple
interaction year x dv_rating_beta x is_college.  The occ x year FE soaks
up all between-occupation variation; the triple coefficient is
identified only by within-occupation, within-year variation in
is_college.

  positive triple coef  ==>  H1 (within-occupation)
  null (near-zero) coef ==>  H2 (between-occupation sorting)
*/

use `analysis', clear
fvset base 2022 year
eststo clear

// occsoc_2010 is a string (e.g., "12-34XX"); encode to numeric for absorb()/cluster()
egen occ_id = group(occsoc_2010)


**************************************************
**# C.1  Triple-interaction regression
**************************************************

/*
// [DEPRECATED] occ x year FE only (no ind x year).  The ind x year
// version below is the preferred spec shown in the draft.
reghdfe lnwage i.year##c.dv_rating_beta##i.is_college, ///
    absorb(sex educ statefip#year occ_id#year) ///
    cluster(occ_id)
estadd scalar obs = e(N)
estadd local sex_FE     "Yes"
estadd local educ_FE    "Yes"
estadd local state_yFE  "Yes"
estadd local occ_yFE    "Yes"
estadd local ind_FE     "No"
estadd local se_cluster "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_within
*/

// Preferred spec: occ x year FE + ind x year FE (log wage)
reghdfe lnwage i.year##c.dv_rating_beta##i.is_college, ///
    absorb(sex educ statefip#year occ_id#year year#ind) ///
    cluster(occ_id)
estadd scalar obs = e(N)
estadd local sex_FE     "Yes"
estadd local educ_FE    "Yes"
estadd local state_yFE  "Yes"
estadd local occ_yFE    "Yes"
estadd local ind_FE     "Yes"
estadd local se_cluster "Occupation"
sum lnwage if e(sample)
estadd scalar depvar_mean = r(mean)
eststo lw_within_ind

// Preferred spec: occ x year FE + ind x year FE (unemployment)
reghdfe unemployed i.year##c.dv_rating_beta##i.is_college, ///
    absorb(sex educ statefip#year occ_id#year year#ind) ///
    cluster(occ_id)
estadd scalar obs = e(N)
estadd local sex_FE     "Yes"
estadd local educ_FE    "Yes"
estadd local state_yFE  "Yes"
estadd local occ_yFE    "Yes"
estadd local ind_FE     "Yes"
estadd local se_cluster "Occupation"
sum unemployed if e(sample)
estadd scalar depvar_mean = r(mean)
eststo un_within_ind


**************************************************
**# C.2  Export B9 (within-occupation table)
**   Columns: (1) log wage, (2) unemployment
**************************************************

esttab lw_within_ind un_within_ind using "$tables/het_within_occ.tex", replace ///
    cells(b(star fmt(a3)) se(fmt(a3) par)) ///
    style(tex) se starlevels(* 0.10 ** 0.05 *** 0.01) ///
    keep(*year*is_college*dv_rating_beta*) nobaselevels ///
    varlabels( ///
        2018.year#1.is_college#c.dv_rating_beta "2018 $\times$ College $\times$ AI exposure" ///
        2019.year#1.is_college#c.dv_rating_beta "2019 $\times$ College $\times$ AI exposure" ///
        2020.year#1.is_college#c.dv_rating_beta "2020 $\times$ College $\times$ AI exposure" ///
        2021.year#1.is_college#c.dv_rating_beta "2021 $\times$ College $\times$ AI exposure" ///
        2023.year#1.is_college#c.dv_rating_beta "2023 $\times$ College $\times$ AI exposure" ///
        2024.year#1.is_college#c.dv_rating_beta "2024 $\times$ College $\times$ AI exposure" ///
        2025.year#1.is_college#c.dv_rating_beta "2025 $\times$ College $\times$ AI exposure" ///
    ) ///
    stats(depvar_mean sex_FE educ_FE state_yFE occ_yFE ind_FE se_cluster obs, ///
          fmt(3 0 0 0 0 0 0 %12.0gc) ///
          labels("Mean of dependent variable" ///
                 "Sex FE" ///
                 "Education FE" ///
                 "State $\times$ Year FE" ///
                 "Occupation $\times$ Year FE" ///
                 "Industry $\times$ Year FE" ///
                 "SE clustered at" ///
                 "Observations")) ///
    booktabs collabels(none) mlabels(none) nonumbers nomtitles gaps nonotes ///
    prehead( ///
        "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" ///
        "\begin{tabular}{l*{2}{c}}" ///
        "\toprule" ///
        "Dependent Variable: & Log Wage & Unemployment \\" ///
        "\cmidrule(lr){2-3}" ///
        " & (1) & (2) \\" ///
    ) ///
    postfoot("\bottomrule" "\end{tabular}")


**************************************************
**# C.3  Extract triple-interaction coefs and plot (ind x year FE spec)
**       --> lw_within_ind_plot.pdf
**************************************************

/*
// [DEPRECATED] plot from lw_within (occ x year FE only).
// See the lw_within_ind version below, which is the preferred spec.
est restore lw_within
parmest, norestore

keep if strpos(parm, "year") > 0           ///
      & strpos(parm, "dv_rating_beta") > 0 ///
      & strpos(parm, "is_college") > 0

drop if missing(estimate) | missing(stderr)

gen year = .
forvalues y = 2018/2025 {
    replace year = `y' if strpos(parm, "`y'.year") > 0
}
drop if missing(year)

insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
sort year

twoway ///
    (rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(dkgreen) lpattern(solid) lwidth(medthin)) ///
    (line estimate year, ///
        lcolor(dkgreen) lpattern(solid) lwidth(medium) sort) ///
    (scatter estimate year, ///
        mcolor(dkgreen) msymbol(T) msize(medlarge)), ///
    xline(2022.5, lcolor(gs8) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Triple interaction: year x exposure x college") ///
    title("Within-occupation college vs non-college gap by exposure") ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(lw_within_plot, replace)

graph export "$graphs/lw_within_plot.pdf", replace
*/


// Preferred spec: occ x year FE + ind x year FE
est restore lw_within_ind
parmest, norestore

// Stata may reorder the terms inside parm, so match by substring presence
keep if strpos(parm, "year") > 0           ///
      & strpos(parm, "dv_rating_beta") > 0 ///
      & strpos(parm, "is_college") > 0

// drop base/omitted rows
drop if missing(estimate) | missing(stderr)

gen year = .
forvalues y = 2018/2025 {
    replace year = `y' if strpos(parm, "`y'.year") > 0
}
drop if missing(year)

insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
sort year

twoway ///
    (rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(dkgreen) lpattern(solid) lwidth(medthin)) ///
    (line estimate year, ///
        lcolor(dkgreen) lpattern(solid) lwidth(medium) sort) ///
    (scatter estimate year, ///
        mcolor(dkgreen) msymbol(T) msize(medlarge)), ///
    xline(2022.5, lcolor(gs8) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Triple interaction: year x exposure x college") ///
    title("Within-occupation college vs non-college gap by exposure") ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(lw_within_ind_plot, replace)

graph export "$graphs/lw_within_ind_plot.pdf", replace


// Unemployment within-occupation plot (same layout, from un_within_ind)
est restore un_within_ind
parmest, norestore

keep if strpos(parm, "year") > 0           ///
      & strpos(parm, "dv_rating_beta") > 0 ///
      & strpos(parm, "is_college") > 0

drop if missing(estimate) | missing(stderr)

gen year = .
forvalues y = 2018/2025 {
    replace year = `y' if strpos(parm, "`y'.year") > 0
}
drop if missing(year)

insobs 1
replace year     = 2022 in L
replace estimate = 0    in L
replace min95    = .    in L
replace max95    = .    in L
sort year

twoway ///
    (rcap min95 max95 year if inlist(year,2018,2019,2020,2021,2023,2024,2025), ///
        lcolor(dkgreen) lpattern(solid) lwidth(medthin)) ///
    (line estimate year, ///
        lcolor(dkgreen) lpattern(solid) lwidth(medium) sort) ///
    (scatter estimate year, ///
        mcolor(dkgreen) msymbol(T) msize(medlarge)), ///
    xline(2022.5, lcolor(gs8) lpattern(dash)) ///
    yline(0, lcolor(gs8) lpattern(solid)) ///
    xlabel(2018(1)2025) ///
    xtitle("Year") ///
    ytitle("Triple interaction: year x exposure x college") ///
    title("Within-occupation college vs non-college gap in unemployment by exposure", ///
        size(medsmall)) ///
    legend(off) ///
    graphregion(color(white)) plotregion(color(white)) ///
    name(unemp_within_ind_plot, replace)

graph export "$graphs/unemp_within_ind_plot.pdf", replace


display as text "analysis.do complete.  Wrote 9 tables + 6 coefficient plots."


/*--------------------------------------------------
For analyzing IPMUS ACS Data (2019 - 2024)

					Edit history

	11-27-2025: Started.
	12-01-2025: Updated for pooled regression  
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
*/

global tables "$output/tables"
global graphs "$output/graphs"
global data "$output/data"


set more off
///////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////

				// 11-27 attempt: non-pool //

*************************************
**# Prepare dataset
*************************************

use "$data/ACS_analysis_Nov27.dta", clear

// keep obs w/ Bachelor or beyond degrees
keep if educd >=100

// keep full-time workers with nonzero incwage
keep if wkswork2 == 6
keep if uhrswork >= 35
keep if incwage > 0


// 12-01 Edit:removing these controls --> can adjust directly in second-stage 
// decide to keep minium-lvl controls in the first-stage

/*
// keep occ with >= 1500 observations 
// that is, occ with >= 250 obs each year on avg
bys occ: gen occN = _N
keep if occN >= 1500
drop occN
*/

// calculate lnwage and years of work experience
gen real_wage = incwage * 100 / cpiaucsl
gen lnwage = ln(real_wage)
gen educyrs = .


// 12-01 Review: these are ques
replace educyrs = 16 if inlist(educd, 101) // BA              
replace educyrs = 18 if inlist(educd, 114) // MA 
replace educyrs = 19 if inlist(educd, 115) // Professional 
replace educyrs = 20 if inlist(educd, 116) // PhD

gen exp = age - educyrs - 6

// for edge cases where genius gets degrees at very young age...
replace exp = max(exp,0) 
gen exp2 = exp^2

*************************************
**# First stage reg (non-pool)
*************************************


levelsof occ, local(occs)
levelsof year, local(years)


cap postutil clear

postfile handle ///
		 occ year b_exp b_exp2 se_exp se_exp2 p_exp p_exp2 N ///
		 using "$data/interim/ACS_1Stage(non-pool)", replace

// running separate regs for each occ-year combination
foreach o of local occs {
	foreach y of local years {
		
		qui count if occ == `o' & year == `y'
		
		scalar N = r(N)
		
		// 12-1 edit: chose to skip if N<40 --> quite conservative standard
		if (N < 40) continue 
		cap qui reghdfe lnwage exp exp2 if occ == `o' & year == `y', ///
					absorb(sex race hispan educd statefip)
		
		// 12-1 edit: chose to skip if regression failed (if error code returned)
		if (_rc) continue
		
		scalar coef_exp = _b[exp]
		scalar coef_exp2 = _b[exp2]
		scalar se_exp = _se[exp]
		scalar se_exp2 = _se[exp2]
		
		scalar p_exp = 2 * ttail(e(df_r), abs(coef_exp / se_exp))
		scalar p_exp2 = 2* ttail(e(df_r), abs(coef_exp2 / se_exp2))
		
		
		
		post handle (`o') (`y') (coef_exp) (coef_exp2) (se_exp) (se_exp2) ///
		            (p_exp) (p_exp2) (N)
		
	}
}

postclose handle



*******************************************
**# Calculate delta_beta & second-stage (non-pool)
*******************************************

use "$data/interim/ACS_1Stage(non-pool)", clear

// 12-01 edit: added weight
keep if year == 2022 | year == 2023


keep b_exp b_exp2 occ N year

reshape wide b_exp b_exp2 N, i(occ) j(year)

gen delta_beta = b_exp2023 - b_exp2022
gen delta_beta2 = b_exp22023 - b_exp22022
gen avg_N = (N2022+N2023)/2

drop if missing(avg_N)

// merge with eloundou rating
merge 1:1 occ using "$data/interim/ACS_Rating"
drop if _merge == 2
drop _merge


// scatter-lfit plot

twoway ///
    (scatter delta_beta dv_rating_beta, msymbol(O) msize(small)) ///
    (lfitci delta_beta dv_rating_beta, fcolor(navy%10)) ///
    (lfit delta_beta dv_rating_beta, lcolor(navy) lwidth(medium)), ///
    xtitle("dv_rating_beta") ///
    ytitle("Δ Experience Return") ///
    title("Scatterplot with OLS Fit and 95% CI") ///
    legend(off)

	
twoway ///
    (scatter delta_beta dv_rating_beta [w=avg_N], ///
        msymbol(O) msize(small)) ///
    (lfitci delta_beta dv_rating_beta [w=avg_N], ///
        fcolor(navy%10)) ///
    (lfit delta_beta dv_rating_beta, ///
        lcolor(navy) lwidth(medium)), ///
    xtitle("dv_rating_beta") ///
    ytitle("Δ Experience Return") ///
    title("Weighted OLS Fit and 95% CI") ///
    legend(off)
	
tab occtitle if 


////////////////////////////////////////////////////////////////////////////////


				// 12-01 attempt: pooled //


use "$data/ACS_analysis_Dec01.dta", clear

	

// keep obs w/ Bachelor or beyond degrees
keep if educd >=100

// keep full-time workers with nonzero incwage
keep if wkswork2 == 6
keep if uhrswork >= 35
keep if incwage > 0



// calculate lnwage and years of work experience
gen real_wage = incwage * 100 / cpiaucsl
gen lnwage = ln(real_wage)
gen educyrs = .


// 12-01 Review: these are ques
replace educyrs = 16 if inlist(educd, 101) // BA              
replace educyrs = 18 if inlist(educd, 114) // MA 
replace educyrs = 19 if inlist(educd, 115) // Professional 
replace educyrs = 20 if inlist(educd, 116) // PhD

gen exp = age - educyrs - 6

// for edge cases where genius gets degrees at very young age...
replace exp = max(exp,0) 
gen exp2 = exp^2

*************************************
**# First stage reg (pool)
*************************************


levelsof soc_gr, local(occs)
levelsof year, local(years)


cap postutil clear

postfile handle ///
		 occ year b_exp b_exp2 se_exp se_exp2 p_exp p_exp2 N ///
		 using "$data/interim/ACS_1Stage(pool)", replace

// running separate regs for each occ-year combination
foreach o of local occs {
	foreach y of local years {
		
		qui count if soc_gr == `o' & year == `y'
		scalar N = r(N)
		
		// 12-1 edit: chose to skip if N<40 --> quite conservative standard
		if (N < 40) continue 
		cap qui reghdfe lnwage exp exp2 if soc_gr == `o' & year == `y', ///
					absorb(sex race hispan educd statefip)
		
		// 12-1 edit: chose to skip if regression failed (if error code returned)
		if (_rc) continue
		
		scalar coef_exp = _b[exp]
		scalar coef_exp2 = _b[exp2]
		scalar se_exp = _se[exp]
		scalar se_exp2 = _se[exp2]
		scalar p_exp = 2 * ttail(e(df_r), abs(coef_exp / se_exp))
		scalar p_exp2 = 2* ttail(e(df_r), abs(coef_exp2 / se_exp2))
		
		
		
		post handle (`o') (`y') (coef_exp) (coef_exp2) (se_exp) (se_exp2) ///
		            (p_exp) (p_exp2) (N)
		
	}
}

postclose handle



*******************************************
**# Calculate delta_beta & second-stage (pool)
*******************************************

use "$data/interim/ACS_1Stage(pool)", clear

// 12-01 edit: added weight
keep if year == 2022 | year == 2023


keep b_exp b_exp2 occ N year
ren occ soc_gr


reshape wide b_exp b_exp2 N, i(soc_gr) j(year)

gen delta_beta = b_exp2023 - b_exp2022
gen delta_beta2 = b_exp22023 - b_exp22022
gen avg_N = (N2022+N2023)/2

drop if missing(avg_N)

// merge with eloundou rating
merge 1:1 soc_gr using "$data/interim/ACS_Rating_Gr"
drop if _merge == 2
drop _merge



// 2nd stage regs

reg delta_beta dv_rating_beta_gr

reg delta_beta dv_rating_beta_gr [aw=avg_N]

// scatter-lfit plot, with statistics attached
 
// unweighted 
twoway ///
    (scatter delta_beta dv_rating_beta_gr, ///
		msymbol(O) msize(small) mlabel(soc_gr_str) mlabsize(*0.3)) ///
    (lfitci delta_beta dv_rating_beta_gr, fcolor(navy%10) clcolor(blue)), ///
    xtitle("GPT Rating: E1+0.5E2") ///
    ytitle("Δ Return to Experience") ///
    title("Scatterplot with OLS Fit and 95% CI") ///
    legend(off)

	

// weighted 
twoway ///
    (scatter delta_beta dv_rating_beta, ///
			 msymbol(O) msize(small) mlabel(soc_gr_str) mlabsize(*0.3)) ///
    (lfitci delta_beta dv_rating_beta [pw=avg_N], fcolor(navy%10) clcolor(blue)), //////
    xtitle("GPT Rating: E1+0.5E2") ///
    ytitle("Δ Return to Experience") ///
    title("Weighted OLS Fit and 95% CI") ///
    legend(off)











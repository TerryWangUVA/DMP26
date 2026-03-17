
/*--------------------------------------------------
For analyzing IPMUS CPS-ASEC Dataset


					Edit history

	12-02-2025: Started. Pooled regressions
	12-03-2025: Graph exports for fall final paper
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


			// 12-02: pool //
*************************************
**# Prepare dataset
*************************************

use "$data/CPS-ASEC_analysis_Dec01", clear


// keep full-time workers with nonzero incwage
keep if wkswork2 == 6
keep if uhrswork1 >= 35
keep if incwage > 0


// calculate lnwage and years of work experience
gen real_wage = incwage * 100 / cpiaucsl
gen lnwage = ln(real_wage)
gen educyrs = .

// 12-02 note: CPS use a different coding system for degrees
replace educyrs = 16 if inlist(educ, 111) // BA              
replace educyrs = 18 if inlist(educ, 123) // MA 
replace educyrs = 19 if inlist(educ, 124) // Professional 
replace educyrs = 20 if inlist(educ, 125) // PhD

gen exp = age - educyrs - 6


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
		 using "$data/interim/CPS-ASEC_1Stage(pool)", replace

// running separate regs for each occ-year combination
foreach o of local occs {
	foreach y of local years {
		
		qui count if soc_gr == `o' & year == `y'
		scalar N = r(N)
		
		if (N < 40) continue 
		cap qui reghdfe lnwage exp exp2 if soc_gr == `o' & year == `y', ///
					absorb(sex race hispan educ statefip)
		

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

use "$data/interim/CPS-ASEC_1Stage(pool)", clear




keep b_exp b_exp2 occ N year
ren occ soc_gr



reshape wide b_exp b_exp2 N, i(soc_gr) j(year)

//gen delta_beta = b_exp2025 - b_exp2018
//gen delta_beta2 = b_exp22018 - b_exp22021

egen avg_N = rowmean(N2018 N2019 N2020 N2021 N2022 N2023 N2024 N2025) 
drop if missing(avg_N)

// merge with eloundou rating
merge 1:1 soc_gr using "$data/interim/ACS_Rating_Gr"
drop if _merge == 2
drop _merge


gen delta_beta1 = b_exp2025 - b_exp2022
gen delta_beta2 = b_exp22025 - b_exp22022


// 2nd stage reg & corr
reg delta_beta1 dv_rating_beta_gr
reg delta_beta1 dv_rating_beta_gr [w=avg_N]
corr delta_beta1 dv_rating_beta_gr 
corr delta_beta1 dv_rating_beta_gr [w=avg_N]

			// beta1 plots //

// beta1, unweighted 
twoway ///
    (lfitci delta_beta1 dv_rating_beta_gr,fcolor(blue%5) clcolor(black%25) lcolor(blue%1)) ///
	(scatter delta_beta1 dv_rating_beta_gr, ///
			 msymbol(O) msize(*0.6) mcolor(navy) mlabel(soc_gr_str) mlabcolor(blue) mlabsize(*0.3)), ///
	xscale(range(0 0.85)) ///
    xtitle("GPT Rating: E1+0.5E2") ///
    ytitle("Δ {&beta}{sub:1}") ///
    title("") ///
    legend(off)


// beta1, weighted 
twoway ///
    (lfitci delta_beta1 dv_rating_beta_gr [w=avg_N],fcolor(blue%5) clcolor(black%25) lcolor(blue%1)) ///
	(scatter delta_beta1 dv_rating_beta_gr [w=avg_N], ///
			 msymbol(O) msize(*0.6) mcolor(navy) mlabel(soc_gr_str) mlabcolor(blue) mlabsize(*0.3)), ///
	xscale(range(0 0.85)) ///
    xtitle("GPT Rating: E1+0.5E2") ///
    ytitle("Δ {&beta}{sub:1} (weighted)") ///
    title("") ///
    legend(off)

	gr export "$graphs/12-03/ASEC_beta1_scat.pdf", replace
	
// beta1, weighted altversion
twoway ///
    (lfitci delta_beta1 dv_rating_beta_gr [w=avg_N],fcolor(blue%5) clcolor(black%25) lcolor(blue%1)) ///
	(scatter delta_beta1 dv_rating_beta_gr [w=avg_N], msymbol(Oh) mcolor(blue)), ///
	xscale(range(0 0.85)) ///
    xtitle("GPT Rating: E1+0.5E2") ///
    ytitle("Δ {&beta}{sub:1} (weighted)") ///
    title("") ///
    legend(off)
	
	gr export "$graphs/12-03/ASEC_beta1_scat_alt.pdf", replace

	
			// beta2 plots //

// beta2, unweighted 
twoway ///
    (lfitci delta_beta2 dv_rating_beta_gr,fcolor(blue%5) clcolor(black%25) lcolor(blue%1)) ///
	(scatter delta_beta2 dv_rating_beta_gr, ///
			 msymbol(O) msize(*0.6) mcolor(navy) mlabel(soc_gr_str) mlabcolor(blue) mlabsize(*0.3)), ///
	xscale(range(0 0.85)) ///
    xtitle("GPT Rating: E1+0.5E2") ///
    ytitle("Δ {&beta}{sub:2}") ///
    title("") ///
    legend(off)


// beta2, weighted 
twoway ///
    (lfitci delta_beta2 dv_rating_beta_gr [w=avg_N],fcolor(blue%5) clcolor(black%25) lcolor(blue%1)) ///
	(scatter delta_beta2 dv_rating_beta_gr [w=avg_N], ///
			 msymbol(O) msize(*0.6) mcolor(navy) mlabel(soc_gr_str) mlabcolor(blue) mlabsize(*0.3)), ///
	xscale(range(0 0.85)) ///
    xtitle("GPT Rating: E1+0.5E2") ///
    ytitle("Δ {&beta}{sub:2} (weighted)") ///
    title("") ///
    legend(off)
	
	gr export "$graphs/12-03/ASEC_beta2_scat.pdf", replace
	
// beta2, weighted altversion
twoway ///
    (lfitci delta_beta2 dv_rating_beta_gr [w=avg_N],fcolor(blue%5) clcolor(black%25) lcolor(blue%1)) ///
	(scatter delta_beta2 dv_rating_beta_gr [w=avg_N], msymbol(Oh) mcolor(blue)), ///
	xscale(range(0 0.85)) ///
    xtitle("GPT Rating: E1+0.5E2") ///
    ytitle("Δ {&beta}{sub:2} (weighted)") ///
    title("") ///
    legend(off)
	
	gr export "$graphs/12-03/ASEC_beta2_scat_alt.pdf", replace

	
	
*******************************************
**# Beta each year trend
*******************************************

use "$data/interim/CPS-ASEC_1Stage(pool)", clear


keep b_exp b_exp2 occ N year
ren occ soc_gr


// merge with eloundou rating
merge m:1 soc_gr using "$data/interim/ACS_Rating_Gr"
drop if _merge == 2
drop _merge

gen IT = 0 
replace IT = 1 if soc_gr == 15

collapse (mean) b_exp b_exp2 [fw=N], by(IT year)


			// beta1 //
twoway ///
    (line b_exp year if IT==1, color(blue%80)) ///
    (line b_exp year if IT==0, color(red%80)), ///
    xlabel(2018(1)2025) /// 
	xline(2022, lpattern(dash) lcolor(gray%60) lwidth(thin)) ///
    legend(order(1 "Computer and Mathematical Occupations" ///
                 2 "Other Occupations") ///
           pos(6) ring(1) row(1)) ///
	xtitle("Year") ///
    ytitle("{&beta}{sub:1} Estimate")

	gr export "$graphs/12-03/ASEC_beta1_trend_alt.pdf", replace

			// beta2 //
twoway ///
    (line b_exp2 year if IT==1, color(blue%80)) ///
    (line b_exp2 year if IT==0, color(red%80)), ///
    xlabel(2018(1)2025) /// 
	xline(2022, lpattern(dash) lcolor(gray%60) lwidth(thin)) ///
    legend(order(1 "Computer and Mathematical Occupations" ///
                 2 "Other Occupations") ///
           pos(6) ring(1) row(1)) ///
	xtitle("Year") ///
    ytitle("{&beta}{sub:2} Estimate")
	
	gr export "$graphs/12-03/ASEC_beta2_trend_alt.pdf", replace


	 
/*
Notes (Meet w/ Prof. Harrington):

1) beta_2 --> include or not
2) reg logwage logexp 
3) collapse 
4) returns to college major  (*CPS don't have major)
5) managerial roles
6) COVID / 2-year pool
7) logwage logexp ## exposure score  (i.year) 
8) 4 quartiles of exposed jobs --> reg
9) don't control by college-educated --> use AI exposure, interacted w/ yrs of education


10) educ vs on-the-job training model  

11） triple interaction	
*/

	   
	   

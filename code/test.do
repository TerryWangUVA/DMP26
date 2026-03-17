clear all
set more off

* Simple test regression + graph output
sysuse auto, clear

regress price mpg weight

* Ensure output directory exists (relative to /code)
capture mkdir "../output"

twoway ///
    (scatter price mpg, mcolor(navy%35)) ///
    (lfit price mpg, lcolor(maroon) lwidth(medthick)), ///
    title("Test: Price vs MPG") ///
    ytitle("Price") ///
    xtitle("MPG") ///
    legend(off)

graph export "../output/test_graph.png", replace width(1600)

* Optional: save regression table to log
capture log close
log using "../output/test_regression.log", replace text
regress price mpg weight
log close

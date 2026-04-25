/*==============================================================================
  main.do
  ----------------------------------------------------------------------------
  Project:   Human in the Loop -- AI Exposure and Labor Market Frictions
  Author:    Leyao Wang, University of Virginia
  Purpose:   Top-level driver for the replication package.

             Replicators should:
               (1) Edit the single $folder line below to point at this
                   replication folder's location on their machine.
               (2) Run this dofile from start to finish.

  Pipeline (sequential):
    1. cleaning.do      -> CPS-ASEC sample + Eloundou exposure scores
    2. descriptives.do  -> Section 4 tables and figures
    3. analysis.do      -> Main and split-sample regressions
    4. robustness.do    -> Binarized-treatment robustness check

  User-written packages (auto-installed below if missing):
                          ftools, reghdfe, estout, parmest, coefplot
==============================================================================*/

clear all
set more off

//================== Edit this one line ===========================//

global folder "C:\Projects\DMP\Replication"

///////////////////////////////////////////////////////////////////

cd "$folder"

//================== Install required packages ====================//

local pkgs ftools reghdfe estout parmest coefplot
foreach p of local pkgs {
    cap which `p'
    if _rc {
        display as text "Installing `p' ..."
        ssc install `p', replace
    }
}

//================== Run the pipeline =============================//

include "$folder/code/cleaning.do"
include "$folder/code/descriptives.do"
include "$folder/code/analysis.do"
include "$folder/code/robustness.do"

display as text _newline "===== Replication pipeline complete ====="

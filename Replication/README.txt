================================================================================
  Replication Package
  Human in the Loop: AI Exposure and Labor Market Frictions
  Leyao Wang, University of Virginia
================================================================================

This package replicates every table and figure in the thesis (and its
appendices) from raw inputs.

--------------------------------------------------------------------------------
  Quick start
--------------------------------------------------------------------------------

  1. Unzip this folder anywhere on your machine.
  2. Open code/main.do in Stata.
  3. Edit the single line:
         global folder "C:\Projects\DMP\Replication"
     so that the path points to wherever you unzipped this folder.
  4. Run main.do from start to finish.

main.do installs any missing user-written packages (ftools, reghdfe, estout,
parmest, coefplot) on first run, then sequentially executes the four .do
files that produce the analysis sample, descriptives, main results, and
robustness checks.

The toy-model figures (fig_preai.png, fig_postai.png) are produced by a
separate Python notebook, code/model_graph.ipynb. It is independent of the
Stata pipeline and can be run from any Jupyter environment with numpy,
matplotlib, and scipy installed.

--------------------------------------------------------------------------------
  Folder layout
--------------------------------------------------------------------------------

  Replication/
    README.txt               this file (also README.md for GitHub viewers)
    code/                    all replication scripts
      main.do                top-level driver -- run this
      cleaning.do            sample preparation
      descriptives.do        Section 4 tables and figures
      analysis.do            main and split-sample regressions
      robustness.do          binarized-treatment robustness check
      model_graph.ipynb      toy-model figures (Python; standalone)
    raw/                     untouched source data (read-only inputs)
    output/                  everything produced by the pipeline
      data/                  intermediate Stata datasets
      tables/                LaTeX regression tables
      graphs/                PDF/PNG figures (incl. graphs/model/)

--------------------------------------------------------------------------------
  Code files
--------------------------------------------------------------------------------

  main.do
    Top-level driver. Sets the $folder macro, installs required packages,
    and includes the four pipeline dofiles in order. The other .do files
    can also be run standalone -- each contains its own $folder line that
    is used only when main.do has not already set it.

  cleaning.do
    1. Cleans the FRED CPI-U series (annual averages, for wage deflation).
    2. Builds a hierarchical SOC 2010 -> 2018 crosswalk and a Census 2010
       occupation-code -> SOC crosswalk.
    3. Loads the raw IPUMS CPS-ASEC extract, applies sample restrictions,
       merges CPI and SOC codes.
    4. Processes Eloundou et al. (2024) occupation-level beta exposure
       scores with hierarchical 6/5/4-digit fallback.
    Produces:
      output/data/CPS-ASEC_analysis_Dec01.dta    (main analysis sample)
      output/data/Eloundou_updated_crosswalk.dta  (exposure scores by SOC)
      output/data/FRED_CPI_cleaned.dta            (CPI series)
    Must run before any other .do file.

  descriptives.do
    Produces all Section 4 (Data) tables and figures:
      tables/descriptives/beta_summary.tex
      tables/descriptives/top5_exposed.tex
      tables/descriptives/bot5_exposed.tex
      tables/descriptives/occ_group_exposure.tex
      graphs/descriptives/kdensity_beta_overall.pdf
      graphs/descriptives/kdensity_beta_education.pdf
      graphs/descriptives/unemp_by_quartile_post2022.pdf

  analysis.do
    Runs every event-study DiD regression in the thesis. Three blocks:
      A. Full-sample regressions (Tables C1-C4 and main coefplots)
      B. Split-sample by education (Tables C5-C8 and combined coefplots)
      C. Within-occupation triple-interaction test (Table C9)
    Produces all *.tex tables and *.pdf coefplots referenced in
    Sections 6.1-6.4 of the thesis.

  robustness.do
    Binarized-treatment robustness check addressing Callaway, Goodman-Bacon,
    Sant'Anna (2024). Replaces the continuous beta_o variable with an
    above-/below-median indicator and re-runs the full-sample and education-
    split regressions (Tables C10-C15). Produces the four "_bin" coefplots
    used in Appendix B.

  model_graph.ipynb
    Python notebook generating the two illustrative figures for Section 3
    (toy model). Outputs:
      output/graphs/model/fig_preai.png
      output/graphs/model/fig_postai.png

--------------------------------------------------------------------------------
  Raw data (raw/)
--------------------------------------------------------------------------------

  raw/Crosswalks/
    soc_2010_to_2018_crosswalk.xlsx
        BLS official 2010 SOC -> 2018 SOC crosswalk.
        Source: https://www.bls.gov/soc/soc_2018_to_2010_crosswalk.xlsx
    2010-occ-codes-with-crosswalk-from-2002-2011.xls
        Census 2010 occupation codes with SOC crosswalk.
        Source: https://www.census.gov/topics/employment/industry-occupation/guidance/code-lists.html

  raw/Eloundou/
    occ_level.csv
        Occupation-level AI exposure scores from Eloundou et al. (2024),
        "GPTs are GPTs". The thesis uses dv_rating_beta (the GPT-4-rated
        beta score). https://github.com/openai/GPTs-are-GPTs 

  raw/FRED CPI/
    CPIAUCSL.csv
        Annual CPI-U for All Urban Consumers, used to deflate wages to
        1982 dollars. https://fred.stlouisfed.org/series/CPIAUCSL

  raw/IPMUS CPS ASEC/
    CPS-ASEC18-25_Dec01.dta
        IPUMS CPS-ASEC extract covering income reference years 2018-2025.
        Variables include empstat, occsoc, incwage, age, sex, educ, statefip,
        ind, and standard demographics. Extract retrievable from
        https://cps.ipums.org with the variable list above.

--------------------------------------------------------------------------------
  Output (output/)
--------------------------------------------------------------------------------

  output/data/        Stata datasets produced by cleaning.do (intermediate).
  output/tables/      LaTeX regression tables (\input{} into the thesis).
  output/graphs/      PDF coefplots and supporting figures.
  output/graphs/model/   PNG figures from the Python notebook.

All files in output/ are recreated from scratch each time the pipeline runs.

--------------------------------------------------------------------------------
  Software
--------------------------------------------------------------------------------

  Stata 17 or later (tested on Stata 18.5 BE). Required user-written packages
  are installed automatically by main.do.

  Python 3.9+ for the model_graph notebook, with numpy, matplotlib, scipy.

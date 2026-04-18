# Review: *Present Day, Present Time: AI Exposure and Labor Market Frictions*

**Author:** Leyao Wang (UVA)
**Draft:** 2026-04-17 (DMP26D3, 31 pp.)
**Reviewer:** coarse-review (offline mode — direct-read pass)

---

## Overview

**Recommendation: revise-and-resubmit (major).**

The drafted material is stronger than the typical DMP thesis at this stage: the task-based toy model is clean, its prediction (relative wage compression for exposed workers) is correctly mapped onto an event-study DiD, and the empirical results are defensible. The post-2022 unemployment coefficients (+0.0205*** in 2024, +0.0180*** in 2025 under the preferred spec) are robust across all four specifications and align with the displacement mechanism you sketch at the bottom of §2. The 2025 wage result (−0.059**) is real but fragile — it only surfaces under state×year FE — and you are appropriately honest about that. The thesis is on track.

The draft, however, is not yet submittable. Three macro issues block acceptance:

1. **Unfinished sections.** §5.4 Education Heterogeneity is a bare heading with no body — and it is the section your memory note tells me you repositioned the occupation-bundle idea into. §6 Limitations and §7 Conclusion are also empty headings. The abstract is empty. There are ~5 inline red TODOs in the body (§1 "THIS ESSAY…", §2 framework placeholder, §2 task-bundling placeholder, §4 AI-release timeline, §4 binned-regression robustness). Until these are filled, the paper cannot be read end-to-end as a whole argument.

2. **Pre-trends are not flat; the narrative justification is not formal.** The 2020 and 2021 coefficients are large, negative, and highly significant for unemployment (−0.0213*** and −0.0353***). For wages, 2021 is +0.049* — marginally significant the wrong direction. Your textual explanation (COVID-19 hit low-exposure manual jobs harder, high-exposure cognitive jobs were remote-compatible) is the right story, but it is only a story. Section 5.1 currently says *"The 2020–2021 pattern is therefore a pre-existing feature of the comparison, not a strict violation of parallel trends induced by the treatment."* This is a strong claim to make without either (a) a formal placebo (e.g., reserve 2019 as the baseline and show pre-2019 coefficients are flat), (b) a control for remote-work compatibility à la Dingel–Neiman, or (c) dropping 2020–21 entirely and showing the 2024/2025 results survive. Option (c) is the cheapest and most persuasive.

3. **The continuous-treatment TWFE caveat is flagged but not addressed.** Your red TODO in §4.1 reads *"if have time robustness checks with binned regs."* Callaway, Goodman-Bacon, and Sant'Anna (2024) is cited but the concern is left hanging: under a continuous treatment with heterogeneous per-exposure effects, the TWFE β̂_t is a weighted average with weights that need not reflect the population exposure distribution. Given the long right tail in Figure 3, this is not a cosmetic concern — the β̂_t you report may be dominated by the most-exposed quartile rather than the mass of workers near β_o = 0.4. The binned-exposure robustness check (by exposure quartile or by tercile) is the standard response and should not be parked.

---

## Section-by-section

### §1 Background (pp. 2–3)

The literature framing — two strands of evidence (selective samples vs. representative, sharp ID vs. broad coverage) — is exactly right and lands your contribution naturally: CPS-ASEC gives you the representativeness that Hosseini–Lichtinger and Hui et al. lack, and the exposure gradient that Chandar sacrifices for aggregate measures. Keep this framing.

The section is otherwise clean and the paragraph on Brynjolfsson et al. is tight. Two fixes:

- **The "THIS ESSAY…" placeholder is missing.** You need the standard three-sentence contribution paragraph: (i) what you do, (ii) what you find (lead with the unemployment result, wages as second), (iii) how your contribution differs from the four studies you just summarized — specifically, nationally representative *and* continuous exposure gradient, neither of which any of them has.
- Hosseini and **Lichtinger** — is this spelling right? Double-check; I suspect "Lichtinger" is a transcription of a different name.

### §2 Toy Model (pp. 3–7)

The model is appropriately minimal for DMP scope and the setup is clean. Your memory note tells me you locked in "task-level full-specialization" on 2026-04-16 and moved the occupation-bundle idea to the Heterogeneity section — good call. The model as stated carries its weight; adding bundling here would have muddied the output-expansion-vs.-supply-dilution decomposition, which is the single clearest thing the model says.

Comments on the model itself:

- **Eq. (9) is the core of the paper.** The decomposition `w₁/w₀ = (Ȳ/Y₀)^{1/σ} · (f/(f+s))^{1/σ}` into *output expansion × supply dilution* is the paper's economic contribution and it deserves to be called out more prominently — right now it reads as one equation among many. Consider boxing it, or at minimum naming the two channels in the margin.
- **"Fixed output price P_Y" (Assumption 1)** needs one sentence on what it buys you and what you're giving up. It is standard in partial-equilibrium task models, but a reader trained in general equilibrium will wonder whether the output-expansion term (Ȳ/Y₀)^{1/σ} over-counts: in GE, rising output should depress P_Y and partially offset the productivity gain. Say explicitly: this is a short-run, one-sector, relative-wage model — the empirical DiD also identifies relative effects, so P_Y fixed is without loss for the prediction being tested.
- **The "Displacement" paragraph on p. 7** is where the model meets reality, and it does real work: it is the paragraph that tells the reader the unemployment regression (§5.1) should be interpreted as the dual of the wage regression (§5.2) under downward wage stickiness. Right now it reads as an addendum. Pull it up before the "With the model's prediction in hand" closing line and dignify it with a named subsection — "§2.4 From wages to displacement" or similar. You will thank yourself later when §5.1 needs to cite a specific claim.
- **The "TASK BUNDLING, as in Autor (2025) Parked for now" red TODO** — since you decided on 2026-04-16 to discuss bundling in §5.4 rather than in the model, replace this TODO with a single forward-pointing sentence: *"Section 5.4 returns to task bundling, as in Autor (2025), as a descriptive device for interpreting the education heterogeneity."* That both removes the TODO and pre-announces §5.4.
- **Typo p. 6:** *"tt depends on the local s(i\*)/f(i\*) ratio"* → *"it depends"*.
- **Figure 1 caption:** missing final period.

### §3 Data (pp. 8–12)

Well-organized. The crosswalk description (Census 2010 → 6-digit 2010 SOC → 2018 SOC) is doing real work and you explain it concisely.

- **Red section on p. 10** describing the β_o distribution ("ranges from approximately 0 to 0.78, SD ≈ 0.17") needs to get de-red-ified and placed at the top of §3.3, not halfway down §3.2. The magnitude statement "all regression coefficients are interpreted per 0.1-unit increase" is the single most important interpretive key for the entire results section — do not bury it.
- **Justify the age 22–65 cutoff.** One sentence: standard prime-age + labor-force-active restriction; dropping sub-22 avoids conflating schooling with labor-market decisions; 65 cap avoids retirement selection. Trivial, but a reader will ask.
- **Why β (GPT-4 weighted middle) rather than α or ζ?** You give a reason — "most economically meaningful measure for the post-ChatGPT period" — but the real reason is that α is too conservative (zero weight on LLM-augmented tasks, which is the majority of real-world adoption) and ζ is too aggressive (full weight on tasks that require tooling that may or may not exist). Say that.
- **Table 3:** show the share of the sample in β_o = 0 (heavily represented in construction/farming). The right skew of Figure 3 starts from a non-trivial mass at zero and a reader needs to know how much.

### §4 Empirical Strategy (pp. 13–16)

The specification (Eq. 11) is standard and the four-spec ladder is correct. Two things:

- **Red-text TODO: "if have time robustness checks with binned regs."** See macro issue 3 above. This is not optional — it is the robustness check that answers Callaway et al. The cheapest version: re-run Eq. 11 with `AIexposure_i` replaced by quartile dummies `Q2_i, Q3_i, Q4_i`, interacted with year dummies. Report β̂_t,q4 − β̂_t,q1 and confirm the post-2022 gap matches the continuous estimate. If you do this *now* it takes an afternoon and answers two reviewers at once.
- **The "AI MODEL RELEASE TIMELINE" TODO** — a single sentence ("GPT-4 Mar 2023; GPT-4o May 2024; Claude 3.5 Jun 2024; o1 Sep 2024") plus one citation is enough. Do not build a figure.
- **§4.2 Education heterogeneity** pre-announces the split-sample spec (Eq. 13) but §5.4 doesn't deliver it. Either §5.4 writes up the Table B5–B8 results (they are already estimated!) or this paragraph gets cut.

### §5 Results (pp. 17–20+)

**§5.1 Unemployment** is the best-written section and the empirical heart of the paper. Two tightenings:

- The interpretive sentence *"A 0.1-unit increase in β_o… is associated with a 0.2 percentage-point increase in the probability of unemployment"* understates the range. Given SD(β_o) ≈ 0.17, a 1-SD increase → ~0.35 pp higher unemployment probability. Against a baseline 3.4% unemployment rate, this is a ~10% relative increase — that is a *real* magnitude and you are selling it short. Add: "Relative to the 3.4% sample mean, this represents a 10% increase in unemployment probability for a 1-SD more-exposed worker."
- Compare Q4 vs Q1 in Figure 5 explicitly: Q4 rises from ~2.2% (2022) to ~2.7% (2025), while Q1 stays at ~4.8% throughout. The raw data tells the same story the regressions tell, which is reassuring — say so.

**§5.2 Wages.** The honesty here is appropriate. I'd push you harder on one thing:

- The statement *"given my inability to travel to the future, I suggest readers interpret the 2025 result with that uncertainty in mind"* — charming in a presentation, and your 4210 presentation went well with this voice, but your writing-style memory note says *thesis register in main text*. Rewrite as: *"The 2025 estimate is the terminal observation of the sample, and its persistence cannot be verified with currently available data."* Same content, thesis register.
- **The state×year FE requirement for significance is worth a half-paragraph, not a throwaway.** Your two competing interpretations (weakness of the result vs. 2025 regional noise masking the signal) are both live. Adjudicate weakly: *"I lean toward the latter because (i) the 2024 unemployment response is stable across all four specs, and (ii) the sign and magnitude of the 2025 wage coefficient is stable across specs — only its significance moves. The state×year FE are therefore cleaning noise, not manufacturing a result."* That argument is strong enough that you should make it.

**§5.3 Experience heterogeneity.** The null is correctly reported and the reconciliation with Brynjolfsson/Hosseini is intellectually honest — you note that Brynjolfsson's effect is concentrated in ages 22–25 and a continuous experience interaction will smooth that away. Good. One addition: estimate the triple interaction on a 22–30 age restriction and see whether it recovers their gradient. If it does, you have a clean bridge; if it doesn't, you have a substantive disagreement worth stating. Either is publishable.

**§5.4 Education heterogeneity — missing.** This is where the paper most needs work and where your 2026-04-16 decision delivers the most mileage. Tables B5–B8 contain the right numbers; the write-up does not. Recommended structure:

1. *Setup sentence:* β_o varies sharply within college-share strata (Table 4), so the college/non-college split is not a proxy for the exposure split.
2. *Unemployment (Tables B5, B6):* Both college and non-college see post-2022 unemployment responses, but the 2025 non-college coefficient (+0.0135*) is roughly 2/3 the college estimate (+0.0181**). Comparable in magnitude — exposure hurts both groups at the extensive margin.
3. *Wages (Tables B7, B8):* **Here is the striking result.** The 2025 wage coefficient is *null* for college (−0.0006) and *strongly negative* for non-college (−0.0939***). Non-college workers in exposed occupations bear essentially all of the measured wage response. Office/Admin Support (β_o = 0.576, only 28.9% college) is the dense, non-college, exposed mass of workers; your wage result is probably concentrated there.
4. *Interpretation via Autor (2025) task bundling:* within an occupation, college workers perform more complementary tasks (judgment, client-facing work); non-college workers perform more substitutable tasks. When AI enters, the occupation's measured β_o averages across both, but the economic incidence falls on the non-college subset. This is the empirical payoff of the bundling idea.

This gets your paper from "yet another AI exposure study" to "AI exposure has a within-occupation distributional signature" — which is a substantive contribution.

### §6 Limitations, §7 Conclusion — missing.

Limitations you should acknowledge explicitly:

1. CPS-ASEC has one observation per person per year and is not a panel at the person level — cannot separate worker-level adjustment from composition change within occupation.
2. β_o is time-invariant; AI capability was not.
3. Continuous-treatment TWFE weighting concern (Callaway et al. 2024), now addressed by the binned robustness.
4. Sample ends in 2025; terminal-year dynamics not resolvable.
5. 2020–21 pre-period reflects COVID asymmetry; the paper addresses this narratively but not with a compatibility control.

Conclusion should be ~3 paragraphs: (i) restate the two findings (unemployment '24, wages '25 concentrated among non-college), (ii) place against the Brynjolfsson/Hosseini/Hui/Chandar literature as the representative-sample complement with a continuous gradient, (iii) one forward-looking sentence about 2026 data and whether the wage effect persists.

### Appendix A — Wage derivation

Clean and correct. Five steps, each verifiable:

- Step 1: FOC of cost minimization with CES technology and Lagrange multiplier μ → p₀(i) = μ·(Y/y(i))^{1/σ}. ✓ Standard CES dual.
- Step 2: Demand y^d(i) = Y(P_Y/p₀(i))^σ inverted from Step 1 under μ = P_Y. ✓
- Step 3: Market clearing y^d(i) = f(i) → p₀(i) = P_Y · (Y/f(i))^{1/σ}. ✓ Matches Eq. (3) in main text.
- Step 4: Plug y(i) = f(i) back into CES aggregator → Y₀ = [∫f(i)^{(σ−1)/σ} di]^{σ/(σ−1)}. ✓ Closed-form pre-AI output.
- Step 5: Replace f(i) with ȳ(i) = f(i) + s(i); inequality Ȳ > Y₀ follows from monotonicity of the CES aggregator in its arguments (since s(i) ≥ 0 with strict inequality on a subset of positive measure). ✓

No errors found. One small improvement: note explicitly in Step 5 that Ȳ > Y₀ *strictly* because s(i) > 0 on [0, I\*), which has positive Lebesgue measure. This matters because your decomposition in Eq. (9) requires the output-expansion factor to exceed 1 strictly.

### Appendix B — Tables

Complete and correctly formatted. Two small notes:

- Table B1–B4 report all four specs; B5–B8 report all four specs by education subsample. Good. But the headline numbers of interest — 2024/2025 coefficients across specs for the full sample, and the 2025 coefficient across college/non-college — are buried. Consider a summary table in the body (Table 5) that shows just {2024, 2025} × {full, college, non-college} × {unemployment, wages}. Twelve numbers. It will be the most-looked-at object in the paper.
- Clustering at the occupation level: how many occupation clusters do you have? If it's ~500 (CPS codes), fine. If it's <50 after aggregation via the crosswalk, cluster-robust inference is weak and you should consider wild-cluster bootstrap.

---

## Editorial / small items

- **Title**: *"Present Day, Present Time"* is a Trekkie reference that readers outside your cohort will not parse. It's memorable for the oral defense but reconsider for the archived thesis version. Something like *"AI Exposure, Unemployment, and the Within-Occupation Wage Gap: Evidence from CPS-ASEC 2018–2025"* is more findable.
- **Abstract is empty.** Write it last, 150 words: one sentence of motivation, one of data, one of method, two of results (lead with unemployment, then the non-college wage concentration), one of contribution.
- **Red TODOs remaining** (consolidated checklist):
  - §1 p.3: "THIS ESSAY…" → contribution paragraph
  - §2 p.3: "THIS FRAMEWORK WAS WIDELY USED…" → strike or absorb into flow
  - §2 p.7: "TASK BUNDLING, as in Autor (2025) Parked for now" → replace with forward pointer to §5.4
  - §3 p.10: β_o range/SD paragraph → move to top of §3.3, de-red
  - §4 p.15: "AI MODEL RELEASE TIMELINE" → one sentence
  - §4 p.15: "if have time robustness checks with binned regs" → *do* the binned regs
- **Typo:** p. 6 *"tt depends"* → *"it depends"*.
- **Figure 1 caption:** missing terminal period.
- **Figure 2 caption:** "s/f" should be formatted as s(i)/f(i) for consistency with the rest of §2.3.
- **Reference check:** Hosseini and "Lichtinger" — verify spelling.
- **Reference list** is complete for the current draft but does not yet include Autor (2025) on task bundling (cited inline as a red TODO). Add when §5.4 lands.

---

## Summary

Strong draft, clear contribution, honest about weaknesses. The blockers to submission are completeness (§5.4, §6, §7, abstract) and one methodological follow-through (binned-exposure robustness). The §5.4 education-heterogeneity write-up is the highest-leverage addition — it converts the paper from an exposure study into a within-occupation distributional study, which is a tighter and more novel contribution than the headline regressions alone.

Priority order for the next draft:

1. Write §5.4 around the non-college wage concentration (Tables B5–B8 already support it).
2. Run the binned-exposure robustness check and add one paragraph to §4.1.
3. Drop 2020–21 and show the 2024/2025 results survive; add this as a §5.1 robustness sentence.
4. Fill §6 (5 limitations listed above) and §7 (3-paragraph conclusion).
5. Write the abstract.
6. De-red the remaining TODO fragments.

Total estimated effort: ~1 week of focused writing, modest additional Stata work.

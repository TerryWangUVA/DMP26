# Draft: Present Day, Present Time

---

## 1. Background

The public release of ChatGPT in November 2022 marked a turning point in the diffusion of generative AI. Within months, firms and workers began adopting generative AI tools to perform a growing range of tasks: drafting emails, writing code, summarizing documents, analyzing data. 

The "productivity gains" are straightforward: generative AI tools can complete many of these tasks faster and at a lower marginal cost than human labor, even granting open debate about whether the output matches human quality. Less visible, but no less real, is the substitution between generative AI and human labor. When a new technology is capable of performing the tasks that a worker is paid to do, the worker naturally faces a new competitor in the market for those tasks. For workers whose labor is partially substituted by the technology, then, the net effect on their wage and employment is not obvious a priori: it depends on whether the productivity gains that accrue to them, through expanded output and rising demand for tasks complementary to generative AI, are large enough to offset the substitution pressure they bear directly.

Fortunately from an empirical standpoint, workplace exposure to generative AI has been uneven. Workers in some occupations or certain firms are substantially more exposed to generative AI than others, reflecting differences in the underlying task content of their jobs. This variation in occupational "AI exposure" (the degree to which an occupation's typical tasks can be performed by generative AI) makes the question above empirically tractable. If one group of workers is heavily exposed to the shock while another is not, a difference-in-differences design can be used to estimate the relative effect of AI exposure on key labor-market outcomes, including wages and unemployment risk, in the years following 2022.

Several recent studies have begun to exploit exactly this kind of occupational or firm-level variation in AI exposure. The literature has developed along two related lines distinguished by the kinds of data they use. One line of research relies on selective samples, where the treated group is narrow but relatively cleanly identified. Using LinkedIn resume data linked to job postings, Hosseini and Lichtinger (2025) identify AI-adopting firms through their hiring of "GenAI integrator" roles and, in a difference-in-differences framework, find that junior employment at adopting firms falls by roughly 9 percent within a year, while senior employment remains unchanged; the effect appears to operate through slower hiring rather than increased layoffs. Using scraped employment histories from Upwork, a large online freelance platform, Hui, Reshef, and Zhou (2024) find that workers in writing-related occupations experienced a 2 percent decline in monthly jobs and a 5 percent decline in monthly earnings after the release of ChatGPT. They also show that the release of text-to-image models such as DALL-E 2 and Midjourney generated comparable declines in design and illustration work. Importantly, these effects do not appear to be concentrated among lower-quality freelancers, suggesting that generative AI can substitute across a broad range of workers within exposed occupations.

A parallel line of work uses larger datasets that are more representative of the labor force, sacrificing some identification sharpness in exchange for broader coverage. Brynjolfsson, Chandar, and Chen (2025), drawing on ADP payroll records through July 2025, find that employment among early-career workers, narrowly defined as ages 22--25, in highly AI-exposed occupations fell by roughly 13 percent after late 2022, while employment among older workers and those in less exposed occupations was stable or growing; wage effects are limited, suggesting that adjustment has operated more through employment quantities than through wages. Chandar (2025), using monthly CPS data from Q4 2022 through Q1 2025, finds little effect of exposure on aggregate employment or earnings growth. However, within the most AI-exposed quartile, occupations with higher college shares, such as software development, have continued to grow, while those with lower college shares, such as customer service, have contracted.

// forget the following two para for now... I will come back to them once I finish the entire draft

This paper contributes exactly such a design: a nationally representative event-study difference-in-differences analysis on CPS-ASEC data covering roughly half a million observations across eight years, with pre-trend validation and heterogeneity by education --- the margin that Chandar (2025) finds to be pivotal within high-exposure occupations.


This paper asks ... (ROADMAP, intentionally kept empty, will finish after the draft is ready)

---

## 2. Toy Model

There is an established tradition in economics to analyze the labor market through the lens of *tasks* in production. Autor (2015) used this framework to explain why automation has not destroyed jobs: tasks within production are complementary, so automating routine tasks raises the economic importance of the remaining tasks that require judgment or creativity, sustaining demand for the workers who perform them.

Other researchers have applied a similar framework to offshoring: Ottaviano, Peri, and Wright (2013), for instance, used the task-based framework to study how the relocation of tasks abroad reallocates work across heterogeneous groups of workers.

The toy model below is inspired by this way of thinking. Instead of cheap foreign labor performing routine cognitive tasks, a cheap machine does it. "Offshoring to GPTopia", as it were.

The framework is deliberately stylized and highly simplified. It is meant to capture the short-run labor market adjustment after the generative AI shock, not the change in long-run general equilibrium. The goal of the model is to isolate two forces: expansion in aggregate output and dilution in task supply, and to provide a conceptual benchmark for interpreting the reduced-form evidence in the following sections.

<!-- Autor-Thompson (2025) expertise-bundles caveat moved to Het section -- will deploy there to frame the education heterogeneity story. -->

### Setup

Production requires a continuum of tasks indexed $i \in [0,1]$, ordered by susceptibility to AI. Tasks at the low end are routine cognitive tasks easily replicated by large language models (e.g., drafting emails); tasks at the high end require human expertise that AI currently struggles to replicate (e.g., negotiating complex contracts).

Final output $Y$ aggregates tasks via a CES technology:

$$Y = \left[\int_0^1 y(i)^{\frac{\sigma-1}{\sigma}}\,di\right]^{\frac{\sigma}{\sigma-1}}, \qquad \sigma > 0,$$

where $y(i)$ is the quantity of task $i$ used in production.

AI can additionally supply a subset of these tasks. Write $s(i)\geq 0$ for the quantity of task $i$ that AI contributes, with

$$s'(i) < 0 \;\text{ for } i<I^*, \qquad s(i) = 0 \;\text{ for } i \geq I^*,$$

where $I^*\in(0,1)$ is the *AI capability frontier*. Tasks below $I^*$ can theoretically be supplied by AI, with the contribution strictly decreasing in task complexity; tasks at or above $I^*$ remain beyond AI's reach. As AI improves, $I^*$ shifts rightward and $s$ may increase throughout its support.

**Assumption (Fixed Output Price).** The output price $P_Y$ is exogenous and fixed.

**Assumption (Full Specialization).** Workers are indexed by ability type $i^*\in[0,1]$. A worker of type $i^*$ fully specializes in task $i^*$ --- the task at which they hold comparative advantage over other types. Each task $i$ is therefore supplied exclusively by workers of type $i^*=i$.

**Assumption (Inelastic Labor Supply).** The density of worker types $f(i)$ over $[0,1]$ is fixed and exogenous. Workers do not adjust their type in response to wages, so the pre-AI supply of task $i$ is just $f(i)$ regardless of the task price.

Competitive firms take $P_Y$ and task prices $\{p_0(i)\}$ as given and minimize the cost of producing $Y$ subject to the CES production function. The equilibrium task prices and wages are derived in the appendix.

### Pre-AI Wages

Before AI, cost minimization subject to the CES production function yields equilibrium task prices:

$$p_0(i) = P_Y \cdot \left(\frac{Y_0}{f(i)}\right)^{1/\sigma},$$

where $Y_0 \equiv \bigl[\int_0^1 f(i)^{(\sigma-1)/\sigma}\,di\bigr]^{\sigma/(\sigma-1)}$ is pre-AI aggregate output, fully determined by the distribution of worker types $f$ via the CES aggregator. In this equilibrium, a worker of type $i^*$ earns:

$$w_0(i^*) = p_0(i^*).$$

### Effects of the AI Supply Shock

When AI enters the economy, it augments the supply side of each task market it can serve. The effective supply of task $i$ becomes

$$\bar y(i) \;=\; f(i) + s(i),$$

where $s(i)>0$ for $i<I^*$ (AI contributes to supply) and $s(i)=0$ for $i\geq I^*$ (beyond AI's capability). Because some task supplies have risen while others have not, the CES aggregator yields a new level of aggregate output

$$\bar Y \;=\; \left[\int_0^1 \bar y(i)^{\frac{\sigma-1}{\sigma}}\,di\right]^{\frac{\sigma}{\sigma-1}} \;>\; Y_0,$$

and by the same cost-minimization logic as before, the post-AI task price is

$$p_1(i) \;=\; P_Y\!\left(\frac{\bar Y}{\bar y(i)}\right)^{1/\sigma}.$$

**Post-AI wages.** Since $w_1(i^*)=p_1(i^*)$, the post-AI wage is derived directly from the post-AI task price:

$$w_1(i^*) \;=\; P_Y\!\left(\frac{\bar Y}{f(i^*)+s(i^*)}\right)^{1/\sigma}.$$

Taking the ratio to the pre-AI benchmark $w_0(i^*)=P_Y\bigl(Y_0/f(i^*)\bigr)^{1/\sigma}$ yields

$$\frac{w_1(i^*)}{w_0(i^*)} \;=\; \underbrace{\left(\frac{\bar Y}{Y_0}\right)^{1/\sigma}}_{\text{output expansion}} \cdot \underbrace{\left(\frac{f(i^*)}{f(i^*)+s(i^*)}\right)^{1/\sigma}}_{\text{supply dilution}}.$$

Two competing forces govern the wage change. The first factor exceeds one: AI adds productive capacity, aggregate output $\bar Y$ rises above $Y_0$, and the marginal value of every task goes up with it. The second factor is at most one: tasks that AI can supply ($i^* < I^*$) see their effective supply $f+s$ rise above $f$, diluting the task price. Whether the *net real wage* of any given exposed worker rises or falls depends on the relative strength of these two forces, and is ambiguous in general. 

However, the *relative effect* is unambigious. Workers above the capability frontier ($i^* \geq I^*$) receive only the output-expansion gain, while workers below ($i^* < I^*$) receive the same gain net of supply dilution. The gap between exposed and unexposed workers therefore widens, regardless of whether exposed wages fall in absolute terms. This is the prediction that the empirical analysis will test.

 **Additional Remark about Displacement.** The full-specialization and inelastic-labor-supply assumptions rule out workers switching task types in response to wages, which keeps the model tractable but does not fully describe the labor market response to the technology shock. In reality, wages are sticky downward: firms often cannot cut pay to the new market-clearing level, so the adjustment shifts from the intensive margin (wages) to the extensive margin (employment). Firms faced with compressed task prices slow hiring into exposed roles and lay off workers, and workers whose reservation wage exceeds the post-AI offer may exit their current jobs voluntarily. A formal model would require endogenous worker mobility, wage-setting frictions, and a reservation-wage mechanism, none of which the toy model incorporates.

 **Additional Remark about Occupation Level Task Bundling.** (parked)

## 3. Data

With the model's prediction in hand — that workers whose tasks are heavily exposed to AI fare worse in relative terms than workers in unexposed occupations, and that displacement is the labor market's likely outlet when wages cannot fall far enough — I now turn to the data. The empirical analysis tests this prediction using a nationally representative U.S. survey matched to a task-level measure of occupational AI exposure, over a window that spans both the pre- and post-ChatGPT periods.

### CPS-ASEC

The primary data source is the Annual Social and Economic Supplement to the Current Population Survey (CPS-ASEC), accessed through IPUMS (Flood et al., 2025). The CPS-ASEC is a nationally representative annual survey that captures labor-force status, occupation, wage income, and detailed demographic characteristics for approximately 100,000 households per year. I use eight survey waves covering income reference years 2018–2025, spanning both the pre- and post-ChatGPT periods.

I restrict the sample to respondents aged 22–65 who are active in the labor force — either employed or actively seeking work. Workers with less than a high school diploma are excluded. After merging with the AI exposure variable and dropping observations with missing values, the main estimation sample contains 500,669 person-year observations.

**Unemployment.** The unemployment indicator equals one if a respondent is classified as unemployed by the CPS — not working but actively searching for work (CPS `empstat` codes 21 and 22) — and zero otherwise. The sample mean is 3.4%, roughly consistent with official U.S. unemployment statistics over this period.

**Wages.** For the wage analysis, I use annual real wage and salary income (`incwage`), deflated to 1982 dollars using the annual average CPI-U from FRED. The outcome variable is the natural log of real wages. Observations with zero or missing wage income are excluded from the wage sample (workers who are unemployed or out of the labor force for wage purposes), yielding 464,300 observations.

**Potential experience.** For the experience heterogeneity specification, I impute potential labor-market experience as $\max(\text{age} - \text{years of schooling} - 6,\, 0)$, with years of schooling assigned from the CPS education recode.

### AI Exposure

The AI exposure variable is drawn from Eloundou et al. (2024), which constructs occupation-level LLM exposure scores from the O\*NET 27.2 database. O\*NET provides two complementary task-level resources: 19,265 *occupational tasks* (occupation-specific units of work tied to a particular occupation) and 2,087 *Detailed Work Activities* (DWAs) — broader action categories that may be associated with one or more tasks across occupations.

**Exposure rubric.** Annotators assess each task or DWA on a three-category rubric, asking whether access to an LLM could reduce the time required to complete it by at least 50% at equivalent quality:

- **E0** (no exposure): the LLM yields no meaningful time reduction, or degrades output quality.
- **E1** (direct exposure): a standard LLM interface — ChatGPT or the OpenAI Playground — reduces task time by at least 50% on its own.
- **E2** (LLM-augmented exposure): the LLM alone cannot meet the threshold, but software built *on top of* the LLM could do so.

Where DWA labels are available, they are first aggregated to the task level before proceeding to the occupation level.

**Occupation-level aggregation.** For each occupation, O\*NET designates each task as *core* (weight $w_t = 2$) or *supplemental* (weight $w_t = 1$). Three summary measures vary how E1 and E2 tasks are scored:

$$\text{Occupation Score} = \frac{\sum_{t \in T_o} w_t \cdot s_t}{\sum_{t \in T_o} w_t},$$

where $s_t = 1$ for E1 tasks, $s_t = 0.5$ for E2 tasks, and $s_t = 0$ for E0 tasks. The *alpha* score ($\alpha_o$) sets $s_t = 0$ for all E2 tasks, counting only direct LLM exposure. The *zeta* score ($\zeta_o$) sets $s_t = 1$ for E2 tasks, providing an upper bound. $\beta_o$ is the weighted middle ground: E2 tasks are discounted by half, reflecting the additional efforts required to build and deploy LLM-powered software on top of the base model.

**Annotators.** Eloundou et al. (2024) collect two independent sets of annotations. *Human ratings* — produced by the authors and experienced alignment annotators — are the primary benchmark; they were applied to DWAs and aggregated to the task level. *GPT-4 ratings* were obtained by prompting an early GPT-4 version directly on all task/occupation pairs, serving as a validation dataset. The two sources are highly correlated at the occupation level.

I use `dv_rating_beta`: the *GPT-4-annotated* $\beta$ score. Applying a single model uniformly across all task/occupation pairs ensures internal consistency. The cost is potential overconfidence in GPT-4's assessment of its own capabilities. $\beta$ is preferred to $\alpha$ (which ignores the ecosystem of LLM-powered tools already deployed or in development at the time of study) and $\zeta$ (which assumes a hypothetically well-developed AI infrastructure). $\beta$ is therefore the most economically meaningful measure for the post-ChatGPT period.

The variable ranges from approximately 0 (low exposure, e.g., Construction and Extraction) to 0.78 (high exposure, e.g., Computer and Mathematical, Legal, Business and Financial Operations), with a sample standard deviation of roughly 0.17. Because $\beta_o \in [0,1]$, all regression coefficients are interpreted per 0.1-unit increase throughout. The variable is time-invariant and assigned at the occupational level.

Because CPS-ASEC codes occupations using a Census-based scheme which is distinct from the SOC occupation codes used by Eloundou et al. (2024), I construct a hierarchical crosswalk: from Census 2010 occupation codes to 6-digit 2010 SOC codes, then from 2010 SOC to 2018 SOC using the BLS official crosswalk. Where exact 6-digit matches are unavailable, exposure scores are aggregated at the 5-digit and 4-digit SOC levels, taking group means. This procedure retains nearly all observations in the sample.

### Descriptive Statistics



Figure [FIG:KDENSITY_OVERALL] plots the kernel density of the AI exposure score $\beta_o$ across workers in the main sample. The distribution is concentrated in the low-to-moderate range with a long right tail; the tail corresponds primarily to occupations with high cognitive-task content.

Tables [TAB:TOP5] and [TAB:BOT5] list the five most and five least exposed occupations. The high end of the distribution is occupied by occupations whose task content is predominantly cognitive and language-based — computer programming, legal work, and financial analysis. The low end consists of occupations whose task content is predominantly manual or physical, such as construction trades, farming, and building maintenance, for which contemporary generative AI provides little direct substitution. This pattern is consistent with the construction of the exposure measure, which scores tasks on the basis of whether a large language model can reduce task completion time.

Figure [FIG:KDENSITY_EDUC] overlays the exposure distributions for college-educated and non-college workers in the sample. College-educated workers are more exposed to generative AI on average, reflecting their historical sorting into occupations with higher cognitive-task content (Autor and Handel, 2013). Nevertheless, the two distributions nevertheless overlap substantially: many non-college workers hold jobs with high $\beta_o$, and many college workers hold jobs with low $\beta_o$ --- so the college/non-college split is at best a modest signal for generative AI exposure. 

Table [TAB:OCC_GROUP] ranks all 22 major CPS occupation groups by mean $\beta_o$ and reports the share of college-educated workers in each group. Mean exposure and college share are not tightly coupled at the group level: occupation groups with comparable mean exposure differ substantially in their college share. This has implications for the heterogeneity analysis in Section [SEC:RESULTS], where outcomes are compared between college and non-college workers within the distribution of occupational exposure. Because college vs. non-college is not a simple reparameterization of high vs. low exposure, differences in outcomes by education within a given exposure level cannot be attributed to differences in mean exposure alone and plausibly reflect differences in within-occupation task composition.

As a final descriptive look at the data, Figure [FIG:UNEMP_QUARTILE_POST2022] plots the annual unemployment rate within each quartile of the worker-level $\beta_o$ distribution over 2022--2025. The top quartile diverges from the rest after ChatGPT's release, with unemployment rising in the most exposed occupations while remaining roughly flat in the least exposed. This pattern is suggestive at best. Establishing whether the divergence survives controls, pre-trend validation, and alternative specifications is the task of the next section.

---

## 4. Empirical Strategy

### Main Specification

The empirical strategy is continuous-treatment difference-in-differences, inspired by Callaway, Goodman-Bacon, and Sant'Anna (2024). The estimating equation is

$$Y_{it} = \alpha + \sum_{t \neq 2022} \beta_t \cdot \mathbf{1}[t] \cdot \text{AIExposure}_i + \phi \cdot \text{AIExposure}_i + \psi_t + X_{it}'\Gamma + \varepsilon_{it},$$

where $Y_{it}$ is either the unemployment indicator or log real wages for worker $i$ in year $t$; $\text{AIExposure}_i$ is the (time-invariant) occupational exposure score $\beta_o$; $\psi_t$ are year fixed effects; $X_{it}$ collects demographic and region-time controls; and year 2022 is the omitted category. The coefficients $\{\hat\beta_t\}$ trace, year by year, the differential outcome between more- and less-exposed workers relative to the 2022 baseline. Standard errors are clustered at the occupation level.

Four progressively stricter specifications are estimated: (1) no additional controls, (2) sex fixed effects, (3) sex and education fixed effects, and (4) sex, education, and state $\times$ year two-way fixed effects. Specification (4) is the preferred specification; it absorbs state-specific time shocks that would otherwise confound comparisons across occupations with different geographic concentrations.



The coefficient $\hat\beta_t$ is interpreted as the per-unit marginal effect of AI exposure on the outcome in year $t$, relative to the 2022 baseline. Callaway et al. (2024) show that under the continuous-treatment two-way fixed effects specification, this coefficient is a weighted average of the underlying per-exposure effects, with weights that need not reflect the population exposure distribution. I flag this as a limitation of the headline specification; robustness analysis with binned exposure measures is left to future work.



I prefer this event-study specification to a simple Treatment $\times$ Post specification for two reasons. First, generative AI capability improved substantially across the post-ChatGPT window. Second, workplace adoption of generative AI tools rose gradually rather than at once: Bick, Blandin, and Deming (2024) document that the share of U.S. workers using generative AI climbed from near-zero at the end of 2022 to roughly one-third by late 2024. Taken together, these features imply treatment effect heterogeneity over time: the per-period effect at $T+1$ is unlikely to equal the effect at $T+3$. A Treatment $\times$ Post specification would fail to capture this time-variation, while the year-by-year coefficients $\{\hat\beta_t\}$ preserve it.

### Heterogeneity: Experience and Education

**Experience.** The experience heterogeneity analysis is inspired by Hosseini and Lichtinger (2025) and Brynjolfsson, Chandar, and Chen (2025), both of whom find that generative AI acts as a seniority-biased technological change. Each paper, however, looks at a limited slice of the labor market: Hosseini and Lichtinger draw on a selective sample of firms that publicly hired for "GenAI integrator" roles, and Brynjolfsson et al. identify the effect on a narrowly defined 22--25 age band. I test whether the same seniority gradient appears in a nationally representative sample using a continuous measure of labor-market experience. The specification supplements the main equation with a triple interaction:

$$Y_{it} = \alpha + \sum_{t \neq 2022} \delta_t \left( \mathbf{1}[t] \times \text{Experience}_i \times \text{AIExposure}_i \right) + \text{lower-order terms} + X_{it}'\Gamma + \varepsilon_{it}.$$

The sign of post-2022 $\delta_t$ is interpreted with respect to the outcome: more-experienced workers are relatively shielded from AI shock if $\delta_t > 0$ for log wages and when $\delta_t < 0$ for unemployment.

**Education.** The education heterogeneity analysis is motivated by the descriptive patterns documented in Section 3. Because $\beta_o$ is assigned at the occupation level, and because college share varies within narrow ranges of $\beta_o$, college and non-college workers with similar measured exposure are sorting into different occupations. The college / non-college split is therefore not a proxy for the exposure split, and differences in outcomes between the two groups reflect occupational sorting by education as much as any direct effect of exposure per se. To isolate this dimension I divide the sample into *college-educated* workers (BA or above, educ $>$ 110) and *non-college* workers (high school or some college, educ $\leq$ 110) and estimate the main specification separately within each group:

$$Y_{it}^{\,g} = \alpha^g + \sum_{t \neq 2022} \beta_t^g \left( \mathbf{1}[t] \times \text{AIExposure}_i \right) + \text{lower-order terms} + X_{it}'\Gamma^g + \varepsilon_{it}^g, \quad g \in \{\text{college},\;\text{non-college}\}.$$

Each subsample has its own baseline, trend, and exposure gradient, and the two coefficient paths $\{\hat\beta_t^{\text{col}}\}$ and $\{\hat\beta_t^{\text{noncol}}\}$ can be compared directly.



Results & Interpretation 

Unemployment

- pre-trend - vibe it for now: it makes intuitive sense that cognitively heavy jobs (high exposure jobs) are more remote-compatible hence relatively more shilded from the COVID layoff. coef for 2018 and 2019 are flat thou- so pre-trend is tricky but explainable. 


- higher lvl of unemp for higher-AI exposed jobs 
- result begin to emerge in 2024 and 2025, robust across all specs (table C1 for your ref)
- interpretation: -- brainstorm a bit?
    - **timing aligns with AI capability + adoption ramp.** Null in 2023 (immediately after ChatGPT), significant in 2024 and 2025. Consistent with the year-by-year specification's rationale: GPT-4, GPT-4o, o1 and Claude 3.5/3.7 arrive across 2023-2025, and adoption rose from near-zero to ~one-third over the same window (Bick-Blandin-Deming). The lag isn't a bug — it's what the diffusion story predicts.
    - **the coefficient is a marginal effect per unit of the Eloundou $\beta_o$ exposure score.** A $0.1$-unit increase in $\beta_o$ --- corresponding to roughly half a standard deviation, or a step of one exposure quartile --- is associated with a $0.2$ percentage-point increase in the probability of unemployment in the preferred specification. The reading is a slope, not a treatment effect on the average worker; the §4 weighting caveat (CGS 2024) applies.
    - **extensive-margin adjustment matches the Displacement paragraph in §2.** The model's supply-dilution force predicts wage compression for exposed workers, but §2's Displacement remark notes that when wages are sticky downward, firms absorb the shock by slowing hiring and laying off marginal workers. The unemployment result is exactly this extensive-margin response — which is why it shows up here before wages do.
    - **robustness across all four specs strengthens the reading.** Neither sex FE, nor education FE, nor state × year FE meaningfully change the post-2022 coefficients. The effect is not an artifact of demographic or geographic composition.


Wage

- weaker results -- in stricter specs there are statistically sig effects but not in loser specs (Table C3 for your ref)
- pull the figure in main text!!! (check ASEC_Analysis_2-19.do to find it)

- statistically sig effects only in 2025 -- even later than unemployment, and we dont know if this will persist in 2026 -- so there are some uncertainty

- interpretation: -- brainstorm a bit?
    - **consistent with the Displacement paragraph's prediction that wages move after employment, not before.** Wage stickiness routes adjustment first through the extensive margin (unemployment), and the intensive margin (wage compression) only starts to show once the stock of affected workers is large enough that the labor-market clearing price cannot be held up by rigidity alone. The one-year lag of wage relative to unemployment (2025 vs. 2024) is consistent with this ordering.
    - **the fact that significance emerges only in the state × year FE spec is itself informative.** Pre-ChatGPT, AI-exposed occupations are geographically concentrated (tech hubs, financial centers, legal markets), so state-level aggregate shocks — in-migration, state-specific labor demand — correlate with the exposure regressor and add noise to the looser specs. Only when those shocks are absorbed does the exposure signal emerge cleanly. This should be framed as a feature of identification, not weakness.
    - **honest caveat:** the 2025 signal is one year, end-of-sample. Whether it persists or grows in 2026 onward is an empirical question the current data cannot answer. Flag this openly.
    - **tie back to §2 two-force framing.** The wage result is consistent with output-expansion and supply-dilution forces both being operative, with supply dilution dominating for workers deep in the exposed region of the distribution — yielding a net compression that materializes as AI capability and adoption accumulate.


Het:experience
null results lmao. this should be a short sect. Just refer the papers saying I find nothing, which provides an interesting contrast to their findings.

- **interpretation ideas:**
    - the null contrasts with H&L (LinkedIn firm sample) and BCC (22--25 age band). The nationally representative CPS-ASEC sample with a continuous experience measure does not reproduce the seniority gradient.
    - one reading: the seniority-biased technological change documented in those papers may be concentrated in specific slices of the labor market --- tech-forward firms that publicly adopt GenAI (H&L) or the just-out-of-college margin (BCC) --- and not generalize to the broader U.S. workforce.
    - another, less favorable reading: the CPS-ASEC sample may lack the statistical power to detect what is a fundamentally narrow effect. BCC's 13 percent decline is concentrated in a four-year age band; a continuous experience × exposure interaction averages over the entire experience distribution and dilutes the signal.
    - Either way, the finding is genuinely a null rather than a contradiction.

another caveat is that you should move C7 to before C3 -- since I decide to have experience before educ het

Het:educ

- unemp broadly shared
- relative wage difference post AI from noncol group rather than col group. 

- interpretation?
    - **the asymmetry is the headline.** Unemployment response is broadly shared (both groups show positive post-2022 coefficients); wage response is concentrated among non-college workers. This is the key finding of the paper.
    - **occupational sorting mechanism (per §4.4 Education motivation).** Within the same measured-exposure band, college and non-college workers are in *different* occupations with different task bundles. Non-college-heavy exposed occupations (customer service, some office roles, data entry) likely have task bundles sitting deeper in $[0, I^*)$, where supply dilution bites hardest. College-heavy exposed occupations (software, legal, financial) have task bundles closer to the capability frontier, where output expansion dominates and may even complement the college worker (as in Autor 2015).
    - **Autor-Thompson (2025) expertise bundles** — a cleaner theoretical frame. College workers hold bundles of complementary tasks and can plausibly reshuffle time within the bundle when AI supplements one task; non-college workers hold more rigidly defined task portfolios and cannot. The full-specialization model in §2 is silent on this margin, so the wage compression among non-college workers is likely a lower bound on the compression that would emerge in a richer specification.
    - **why unemployment is symmetric but wages are not.** Extensive-margin adjustment (layoffs, slower hiring) operates at the occupation level and hits both education groups in exposed occupations. Intensive-margin compression (actual wage cuts for workers who keep their jobs) requires the employer to push wages down past whatever floor wage stickiness provides. That floor is plausibly higher for college workers --- more bargaining power, tenure, within-occupation outside options --- so only non-college workers experience the compression margin.
    - **tie back to Chandar (2025).** Chandar's finding within the most exposed quartile (software grows, customer service contracts) is consistent with this education asymmetry and provides independent corroboration in a different data source. Name this in the interpretation paragraph.
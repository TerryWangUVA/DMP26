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

Two competing forces govern the wage change. The first factor exceeds one: AI adds productive capacity, aggregate output $\bar Y$ rises above $Y_0$, and the marginal value of every task goes up with it. The second factor is at most one: tasks that AI can supply ($i^*<I^*$) see their effective supply $f+s$ rise above $f$, diluting the task price. For tasks above the capability frontier ($i^*\geq I^*$), $s(i^*)=0$ and only the output-expansion factor applies; for tasks below, whether the net wage change is positive or negative depends on the size of $s/f$ relative to the aggregate output gain.

**Displacement.** The full-specialization and inelastic-labor-supply assumptions rule out workers switching task types in response to wages, which keeps the model tractable but does not fully describe the labor market response to the technology shock. In reality, wages are sticky downward: firms often cannot cut pay to the new market-clearing level, so the adjustment shifts from the intensive margin (wages) to the extensive margin (employment). Firms faced with compressed task prices slow hiring into exposed roles and lay off workers, and workers whose reservation wage exceeds the post-AI offer may exit their current jobs voluntarily. A formal model would require endogenous worker mobility, wage-setting frictions, and a reservation-wage mechanism, none of which the toy model incorporates.

---

## 3. Early Empirics

With this prediction in hand --- that AI-exposed workers should fare worse after 2022 --- what does the early evidence show?

Valid empirical evidence on the labor market effects of generative AI was rare when this project began. The landscape has since grown rapidly, but because generative AI has only been widely available since late 2022, large-scale empirical projects measuring its impact remain limited. The work most relevant to this paper falls into a few categories.

**Firm-level evidence on seniority bias.** Hosseini and Lichtinger (2025) combine LinkedIn resume data covering 62 million workers across 285,000 firms with nearly 200 million job postings. They identify firms that adopted generative AI by detecting "GenAI integrator" job postings --- roles responsible for implementing AI tools. Using a difference-in-differences framework, they find that after ChatGPT's release, junior employment in adopting firms declined by roughly 9--10%, while senior employment remained stable. The effects are concentrated in high-exposure occupations and driven by slower hiring rather than increased separations. A potential concern: firms that publicly hire for AI integration roles may not be representative of the broader labor market.

**Online freelance platforms.** Hui, Reshef, and Zhou (2024) take a different route to a selective sample, scraping the full employment histories of freelancers on Upwork, a large online labor platform where workers are hired on a per-project basis for tasks such as writing, design, and software development, and running a difference-in-differences design that treats writing-related occupations as exposed to ChatGPT (November 2022) and design/image occupations as exposed to DALL-E 2 and Midjourney (April 2022). They find that treated freelancers saw a 2% decline in monthly jobs and a 5% decline in monthly earnings, with the image-AI release producing comparable magnitudes in design occupations. Strikingly, freelancer quality --- measured by past earnings, hourly rates, and skill level of prior jobs --- does not shield workers from the shock, suggesting that generative AI substitutes for knowledge work across the quality distribution rather than displacing only the lowest-skill routine workers. The limitation mirrors the LinkedIn evidence: online freelance markets are a selected slice of the labor market and may respond more sharply than the economy-wide population of workers in the same occupations.

**Administrative payroll data.** Brynjolfsson, Li, and Raymond (2025) --- "Canaries in the Coal Mine" --- use ADP payroll records covering millions of U.S. workers through July 2025. They find that employment among early-career workers (ages 22--25) in highly AI-exposed occupations declined by roughly 13% since late 2022, even after controlling for firm-level shocks. Older workers and those in less exposed occupations remained stable or grew. They find limited wage effects, suggesting that adjustment occurs primarily through employment quantities rather than prices --- firms stop hiring rather than cut pay.

**CPS-based evidence.** Chandar (2025) uses monthly CPS data from Q4 2022 to Q1 2025 and finds that, on aggregate, occupations most exposed to AI show no substantial difference in employment or earnings growth compared to the least exposed. But this aggregate null masks important heterogeneity. Within the most exposed quartile, occupations with a higher share of college-educated workers --- such as software development --- experienced robust employment growth, while those with a lower college share --- such as customer service --- saw declines. This paper is particularly relevant because it uses the same data source (CPS) and the same exposure measure (Eloundou et al. 2024) as the present study, and its finding that education moderates the effect of AI exposure is directly related to the heterogeneity analysis in Section 6.

**What this paper adds.** The existing empirical work uses either firm-level data (Hosseini and Lichtinger), administrative payroll data (Brynjolfsson et al.), or monthly CPS without a formal identification strategy (Chandar). This paper uses the CPS-ASEC --- a nationally representative annual survey covering 500,000+ observations across eight years --- and applies a continuous-exposure event-study difference-in-differences design with pre-trend validation. The contribution is not methodological novelty but the combination: a standard, transparent approach applied to a nationally representative dataset over a longer time horizon that spans both the pre- and post-ChatGPT periods.

<!-- NOTE on contribution framing: not claiming novel contribution to literature, just that this combination hasn't been done. Reframe positively: "This paper contributes a nationally representative event-study analysis that complements the existing firm-level and administrative evidence." -->

---

## 4. Measuring AI Exposure

The empirical strategy requires a measure of how exposed each occupation is to generative AI. This paper uses the Eloundou et al. (2024) GPT-4 beta score. A separate literature has attempted to quantify occupational AI exposure; the approaches fall into two broad categories.

**Projected exposure (annotator-based).** These measures predict what AI *could* do based on expert or model assessment of task descriptions.

Felten, Raj, and Seamans (2018, 2021) introduced the earliest systematic approach, linking progress in AI subfields to human abilities defined in O\*NET. Their AI Occupational Exposure (AIOE) index uses Mechanical Turk surveys to map ten AI applications to 52 O\*NET abilities, then aggregates ability-level scores (weighted by importance and prevalence) to occupations, industries, and geographies. This was a pioneering effort, but the AI landscape has changed dramatically since the original index was constructed.

Webb (2020) took a different approach, matching verb-noun pairs from patent text to O\*NET task descriptions via textual similarity. This identified high-skill cognitive tasks --- judgment, analysis --- as most AI-exposed, contrasting with robotics' focus on routine manual work.

Eloundou et al. (2024) --- the measure this paper uses --- had GPT-4 and human annotators classify each O\*NET task on whether an LLM could reduce completion time by at least 50% at equivalent quality. The resulting beta score aggregates task-level ratings to occupations, producing a continuous exposure index that ranges from near-zero (construction, farming) to roughly 0.78 (computer and mathematical, legal occupations). This is the most widely used LLM-specific exposure measure and has the clearest mapping to the O\*NET task structure.

All of the above are *projections* --- predictions of technical feasibility rather than measures of actual adoption. They rely on annotator judgment or model self-assessment rather than observed behavior.

**Revealed usage (behavior-based).** The Anthropic Economic Index (Handa et al. 2025) takes a fundamentally different approach: analyzing over four million anonymized Claude conversations and mapping them to O\*NET tasks and occupations. This measures what AI *is* doing --- actual penetration across the task distribution. Their headline finding: roughly 57% of interactions suggest augmentation, 43% suggest automation. AI use is concentrated in software development and writing, with roughly 36% of occupations using AI for at least a quarter of their tasks. This represents the most current measure of AI exposure, incorporating observed behavior rather than expert annotation. This paper predates the Anthropic release and uses the Eloundou projected measure; incorporating revealed-usage data is a natural direction for future work.

None of these measures perfectly captures "AI exposure." But good enough is good enough. The Eloundou beta score is the most widely used, has the clearest mapping to the O\*NET task structure, and is available for the full set of occupations in my sample.

---

<!-- STOP HERE. Data, Empirical Strategy, Results, Limitations, and Conclusion to be written separately. -->
<!-- Data and Empirical Strategy sections already exist in DMP_D3_3-17.tex. -->
<!-- Results text already exists in D3. -->
<!-- Limitations content exists in presentationv3 and brainstorming notes. -->

---

## Transition notes (internal, not for thesis):

1. **Intro/Background -> Model**: the offshoring analogy ("offshoring to GPTopia") bridges the lit review into the model section naturally. The model is framed as "same framework, new shock."

2. **Model -> Early Empirics**: the three-group prediction provides the transition: "with this prediction in hand, what does the evidence show?"

3. **Early Empirics -> Measures**: the empirics section discusses what the evidence finds; the measures section discusses *how exposure is measured* --- the input to both the existing literature and this paper's empirical strategy.

4. **Measures -> Data**: natural transition from "what measure do we use" to "what data do we apply it to."

5. **Chandar (2025) and the Het analysis**: Chandar's finding that college share moderates the effect within high-exposure occupations directly motivates the education heterogeneity analysis. This should be referenced again when presenting the Het results.

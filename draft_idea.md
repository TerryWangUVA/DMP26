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

<!-- This section is written in DMP_D3_3-17.tex. The key points to set up here in the draft: -->

This section sketches a toy model, deliberately simple and not meant to be taken too seriously, that organizes the intuition about what might happen to wages and employment when a new technology can perform some of the tasks that workers currently do. The goal is modest: to isolate two competing forces, output expansion and substitution, and extract a testable prediction that can discipline the empirical analysis that follows.

There is an established tradition in economics to analyze the labor market the through lens of *tasks* in production. Autor (2015) used this framework to explain why automation has not destroyed jobs: tasks within production are complementary, so automating routine tasks raises the economic value of the remaining tasks that require judgment or creativity, sustaining demand for the workers who perform them. 

Others have applied a similar framework to offshoring: Ottaviano, Peri, and Wright (2013) model a continuum of tasks ordered by complexity and assign heterogeneous worker types to different segments of the distribution, with endogenous cutoffs that shift when the cost of substitution changes. 



the model goes like this 
> task market clearing as is

> occupation defined by a bundle of tasks --> and workers within each occupation are homogeneous & cannot allocate time betwen tasks --> these are pinned down



> then the group analysis becomes more interesting









The model below follows this tradition. Instead of cheap foreign labor performing routine cognitive tasks, a cheap machine does it --- offshoring to GPTopia, as it were. AI enters as a supply shock to a subset of tasks, the effects propagate through production complementarities, and the distributional consequences depend on where different workers sit in the task distribution. One further theoretical development is worth noting: Autor and Thompson (2025) argue that real-world workers are not single-task specialists but holders of *expertise bundles* --- packages of complementary tasks whose value derives from accumulated expertise. Automation that removes routine tasks from a bundle can *raise* expertise requirements and wages for remaining workers, while automation that removes expert tasks can *lower* barriers to entry and compress wages. The model below adopts the simpler full-specialization benchmark, which is standard in this literature and delivers the cleanest prediction; the cost is that the wage compression result is likely a lower bound, since workers who hold task bundles have more room to absorb the shock.

The setup is as follows. A continuum of cognitive tasks, ordered by susceptibility to AI. Workers fully specialize in one task each. CES production aggregates tasks into output.

AI enters as a supply shock: it adds supply $s(i)$ to tasks below a capability frontier $I^*$, with $s'(i) < 0$ (AI is better at routine tasks) and $s(I^*) = 0$ (beyond $I^*$, AI cannot perform the task).

The post-AI wage is:
$$w_1(i^*) = P_Y \left(\frac{\bar{Y}}{f(i^*) + s(i^*)}\right)^{1/\sigma}$$

Two things moved relative to the pre-AI wage: the numerator grew ($\bar{Y} > Y_0$, output expansion) and the denominator grew for exposed tasks ($f + s > f$, supply dilution). This partitions workers into three groups:

1. **Above $I^*$**: pure gain from output expansion.
2. **Deep inside $[0, I^*)$**: supply dilution outpaces output expansion --- wage compression.
3. **Near $I^*$ from below**: output expansion still dominates --- these workers gain despite being below the frontier.

The boundary between winners and losers is at $\hat{\imath} < I^*$, not at $I^*$ itself. Workers whose tasks are heavily supplemented by AI lose; workers near the frontier, where AI's contribution is small, still benefit from the expanding pie.

**Modeling choices and limitations.**

The model makes three simplifying assumptions:

1. *Workers fully specialize.* Each worker performs exactly one task. As noted above, this strips out the expertise-bundle logic of Autor and Thompson (2025); the wage compression result is likely a lower bound.

2. *Workers cannot move.* The labor supply $f(i)$ is fixed. No reallocation in response to wage changes. This is a short-run assumption --- in the long run, workers would flee compressed tasks and crowd into safe ones, partially self-correcting the displacement. The fixed-$f$ version provides an upper bound on compression.

3. *Small open economy.* Output price $P_Y$ is exogenous. Standard in trade-flavored task models.

Despite these, the model delivers the three-group prediction and a testable implication: workers in high-exposure occupations should see worse outcomes post-2022.

<!-- The full model derivation, figures, and propositions live in DMP_D3_3-17.tex. This section is a narrative summary. -->

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

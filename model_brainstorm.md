# Model Brainstorm — AI Exposure and Labor Market Risk

## Context

Empirical paper: DiD design, CPS-ASEC 2018–2025, Eloundou et al. beta scores as occupation-level AI exposure measure.
Key findings: Higher AI exposure → higher unemployment (especially post-2023), lower wages (especially non-college workers).
Constraint: Undergrad honors thesis — no GE solution. Use PE framework, be transparent about it.

---

## New Direction: Worker-as-Bundle Framework (Sketch)

These are working thoughts, not yet formalized.

### Core Departures from GRH

1. **Output price exogenous** — small open economy assumption, keep from GRH. No goods market clearing needed.

2. **Worker = bundle of tasks** — rather than atomistic task assignment (workers freely specialize), each worker $j$ carries a fixed bundle $\mathcal{B}_j \subset [0,1]$. This is the Autor-Thompson (2025) insight folded directly into the model structure.

3. **Wage = value of bundle** — in equilibrium, worker $j$'s wage is the sum of the market prices of all tasks in their bundle:

   $$w_j = \int_{\mathcal{B}_j} p(i)\, di$$

   where $p(i)$ is the competitive market price of task $i$. If AI can perform task $i$ at cost $\tau t(i) < p(i)$, competition drives $p(i)$ down to $\tau t(i)$. So partial automation of the bundle directly compresses $w_j$.

4. **Partial replacement → wage compression** — if some tasks in $\mathcal{B}_j$ become AI-cheaper, their prices fall, and $w_j$ falls. The worker stays employed but at a lower wage. This is the core result the model formally derives.

5. **Unemployment — not formally modeled** — any threshold mechanism (reservation wage, employer break-even, institutional wage floor) is structurally identical: "wage falls below $\bar{w}$ → unemployment." Committing to one is an arbitrary labeling choice, not a substantive distinction. Instead, treat unemployment as the extensive-margin consequence of severe wage compression — workers facing sufficiently large $\Delta w_j$ exit employment. The specific threshold is left implicit; the empirical DiD evidence carries the unemployment result directly.

### Division of Labor: Theory vs. Empirics

- **Theory does:** derive wage compression from AI repricing tasks in the bundle; show non-college workers face larger compression due to bundle composition
- **Empirics do:** test both wage and unemployment outcomes via DiD; unemployment is a companion finding, not a theoretical prediction requiring formal derivation
- **Bridge sentence in paper:** "Workers facing sufficiently severe wage compression may exit employment entirely; we treat the threshold as an empirical question and test the unemployment effect directly in Section~X."

### Why This Is Cleaner

- No fixed $w$ problem: wages are endogenous through task prices
- No arbitrary threshold assumption for unemployment
- Model stays focused on what it does well (wage channel); empirics carry the rest
- No GE required: exogenous output price pins down the demand side; wage is just the integral of task prices

### Education Heterogeneity

Let $\mathcal{B}_{NC} = [0, \bar\imath]$ (non-college bundle) and $\mathcal{B}_C = [\bar\imath, 1]$ (college bundle).

- As $\tau$ falls, tasks with $\tau t(i) < p_0(i)$ get repriced — concentrated in $[0, \bar\imath]$
- Non-college wage compression: $\Delta w_{NC} = \int_{\{i \in \mathcal{B}_{NC}:\, \tau t(i) < p_0(i)\}} [p_0(i) - \tau t(i)]\, di$
- College bundle tasks are mostly above the AI repricing threshold → $\Delta w_C$ smaller
- Same mechanism naturally predicts larger unemployment among non-college workers (without needing to specify the threshold)

### Open Questions for Formalization

- How to define $p_0(i)$ (pre-AI task prices)? Probably normalize from CES zero-profit conditions.
- What determines bundle composition? Taken as exogenous — empirical beta scores proxy it.
- How to parameterize $t(i)$ for light calibration?

---

## Chosen Strategy (GRH-Based, Current model.tex)

**Base model:** Grossman & Rossi-Hansberg (2008), adapted from offshoring to AI.
**Calibrate lightly** — parameterize task cost function, show cutoff shift numerically if helpful.
**Explicit PE assumption** — take wages as exogenous, solve only for task cutoffs and employment shares.
**Reality check** — one paragraph noting that in reality jobs are bundles of tasks, so Autor & Thompson (2025) likely captures real-world dynamics better; acknowledge as limitation/extension.

---

## GRH (2008) Setup, Adapted to AI

### Tasks and Production

Tasks indexed $i \in [0,1]$, ordered by **AI substitutability** — low $i$ means easier for AI to perform.
The empirical beta score is the natural counterpart: high-beta occupations are concentrated at low $i$.

Final output aggregates tasks via CES:

$$Y = \left[\int_0^1 y(i)^{\frac{\sigma-1}{\sigma}} di\right]^{\frac{\sigma}{\sigma-1}}$$

Each task requires one unit of labor input, unless automated by AI.

### AI Cost Function

Performing task $i$ via AI costs $\tau \cdot t(i)$ per unit, where:
- $\tau > 0$ is the aggregate AI capability parameter — falls as AI improves (GPT-4 shock = $\tau$ drops)
- $t(i)$ is task-specific cost: $t'(i) > 0$ — higher-indexed tasks are harder to automate

Simple parametric choice for calibration: $t(i) = e^{\alpha i}$, $\alpha > 0$.

Human labor cost of task $i$: $w$ (wage, taken as exogenous in PE).

### Equilibrium Cutoff (PE)

Task $i$ is automated iff AI is cheaper than human labor:

$$\tau \cdot t(I^*) = w \implies I^* = \frac{1}{\alpha}\ln\left(\frac{w}{\tau}\right)$$

- Tasks $i \in [0, I^*]$: done by AI
- Tasks $i \in [I^*, 1]$: done by human workers

As AI improves ($\tau \downarrow$), $I^*$ rises — more tasks get automated.

### Two Effects (following GRH)

**Displacement effect:** The rise in $I^*$ directly reduces human labor demand — workers who were doing tasks $[0, I^*]$ are displaced.

**Productivity effect:** Automating low-$i$ tasks lowers the cost of composite output $Y$, raising real demand and shifting out labor demand for remaining tasks $[I^*, 1]$.

Net employment effect is ambiguous in PE — an empirical question. Your DiD results suggest displacement dominates for unemployment. Productivity effects may partially offset wage compression.

---

## Education Heterogeneity

Non-college workers are disproportionately concentrated in low-$i$ tasks. Tractable approximation:

- Non-college workers supply tasks $i \in [0, \bar{i}_{NC}]$
- College workers supply tasks $i \in [\bar{i}_{NC}, 1]$

(In reality a continuous distribution — but the two-type cutoff gives clean propositions.)

**Proposition 1 (Unemployment):** A fall in $\tau$ raises $I^*$. Non-college workers face larger displacement when $I^*$ rises into $[0, \bar{i}_{NC}]$, while college workers are initially shielded.

**Proposition 2 (Wages):** Workers in tasks adjacent to $I^*$ face the strongest downward wage pressure at the margin. Non-college workers are closer to $I^*$ → larger wage compression.

Both propositions match your empirical findings: non-college unemployment and wage effects are larger and more significant than college effects.

---

## Task Bundling Caveat (Autor & Thompson 2025)

The GRH framework assumes **atomistic task assignment** — workers can specialize in any subset of tasks. In reality, occupations bundle tasks together; workers either perform the whole bundle or none of it.

Autor & Thompson (2025, NBER w33941) show this matters: whether AI automates the *expert* or *inexpert* tasks within a bundle determines the direction of the wage effect — the opposite of what a simple cutoff model predicts in some cases.

**Suggested language for the thesis:**
> "We follow Grossman and Rossi-Hansberg (2008) in assuming atomistic task assignment, which keeps the model tractable. In practice, jobs are bundles of tasks (Autor and Thompson 2025), and the wage effects of automation depend on whether AI displaces the expert or inexpert tasks within each bundle. We abstract from this dimension and treat the net effect as an empirical question."

---

## Light Calibration

For an undergrad thesis, calibration can be a numerical illustration:

1. Set $\sigma = 1.5$ (consistent with task-model literature)
2. Set $\alpha$ to match beta score distribution — e.g., fit $t(i) = e^{\alpha i}$ so the median task has $I^* \approx 0.5$ pre-2023
3. Shock: $\tau$ drops by some percentage in 2023 to represent GPT-4 deployment
4. Compute implied $\Delta I^*$ and change in human labor's employment share
5. Compare to your regression coefficients as a plausibility check

No structural estimation needed — just "the model implies a cutoff shift of X, which is consistent with our DiD estimates of Y."

---

## Theory Section Outline (~2 pages)

1. **Setup** — tasks, CES aggregation, AI cost function (0.5p)
2. **Equilibrium cutoff** — derive $I^*$, comparative static in $\tau$ (0.5p)
3. **Two effects** — displacement vs. productivity, sign ambiguity (0.25p)
4. **Education heterogeneity** — Propositions 1 and 2 (0.5p)
5. **Task bundling caveat** — one paragraph, cite Autor-Thompson (0.25p)

---

## Related Literature

- **Grossman & Rossi-Hansberg (2008, AER)** — base PE model; offshoring as task trade
- **Ottaviano, Peri & Wright (2013, AER)** — PE extension with multiple worker types and cutoffs
- **Autor & Thompson (2025, NBER w33941)** — task bundling and expertise; the PE caveat
- **Acemoglu & Restrepo (2018, 2019)** — task model with displacement/reinstatement; requires GE (cited for context, not used formally)
- **Eloundou et al. (2024)** — beta scores as empirical counterpart of $t(i)^{-1}$

---

## Open Questions

- [ ] Two-type education cutoff or continuous skill distribution?
- [ ] Calibrate $\alpha$ and $\tau$-shock numerically or just qualitative propositions?
- [ ] Place theory section before empirics (recommended) or in discussion?

# Model Brainstorm — AI Exposure and Labor Market Risk

## Context

Empirical paper: DiD design, CPS-ASEC 2018–2025, Eloundou et al. beta scores as occupation-level AI exposure measure.
Key findings: Higher AI exposure → higher unemployment (especially post-2023), lower wages (especially non-college workers).
Constraint: Undergrad honors thesis — no GE solution. Use PE framework, be transparent about it.

---

## Current Framework: Worker-as-Bundle with Exogenous Output Price

### Core Structure

1. **Output price $P_Y$ exogenous** — small open economy, price-taker in world market. No goods market clearing needed.

2. **Pre-AI task prices = $P_Y$** — by CES symmetry and competitive task markets, the zero-profit condition gives $p_0(i) = P_Y$ for all $i$ before AI arrives. The output price is both the composite good price and the uniform pre-AI task price. No separate human wage $w$ — workers are bundles, not homogeneous labor, so a single $w$ makes no sense.

3. **Post-AI task prices** — AI introduces competition at cost $\tau e^{\alpha i}$. Competitive markets drive:
   $$p(i) = \min(P_Y,\; \tau e^{\alpha i})$$
   Cutoff: $\tau e^{\alpha I^*} = P_Y \implies I^* = \frac{1}{\alpha}\ln(P_Y/\tau)$. Fully determined by exogenous parameters — no endogenous wage to solve for.

4. **Worker = bundle of tasks** — each worker $j$ has fixed bundle $\mathcal{B}_j \subseteq [0,1]$ (indivisible). Wage is the sum of task prices:
   $$w_j = \int_{\mathcal{B}_j} p(i)\, di$$

5. **Wage compression — unambiguous sign** — after AI shock ($\tau$ falls, $I^*$ rises):
   $$\Delta w_j = \int_{\mathcal{B}_j \cap [0, I^*)} (\tau e^{\alpha i} - P_Y)\, di \leq 0$$
   Every repriced task contributes a strictly negative term. No ambiguity, no productivity-vs-displacement trade-off for wages.

6. **Unemployment — not formally modeled** — extensive-margin consequence of wage compression. Any threshold mechanism is structurally identical ("wage below $\bar{w}$ → exit"). Empirics carry the unemployment result.

### Why Dropping the Separate Human Wage Is Necessary

In the GRH setup, "human performs task $i$ at unit cost $w$" makes sense because workers are atomistic and interchangeable across tasks. Once workers are bundles, there is no single $w$ — each worker's income depends on their specific bundle composition. The pre-AI task price $P_Y$ (derived from zero-profit + CES symmetry) replaces $w$ as the relevant benchmark. AI undercuts $P_Y$, not some separate human wage.

### Division of Labor: Theory vs. Empirics

- **Theory:** derives wage compression from AI repricing bundle tasks; shows non-college workers face larger compression (Proposition 1)
- **Empirics:** tests both wages and unemployment via DiD; unemployment is a companion finding
- **Bridge sentence:** "Workers facing sufficiently severe wage compression may exit employment; we treat this threshold as an empirical question and test the unemployment effect directly in Section~X."

### Education Heterogeneity

Assumption: $\mathcal{B}_{NC} \subseteq [0, \bar\imath]$, $\mathcal{B}_C \subseteq [\bar\imath, 1]$, with $\bar\imath > I^*$.

- Non-college: $\Delta w_{NC} = \int_{\mathcal{B}_{NC} \cap [0,I^*)} (\tau e^{\alpha i} - P_Y) di < 0$
- College: $\Delta w_C = 0$ (bundle entirely above $I^*$)
- $|\Delta w_{NC}| > |\Delta w_C|$ — proven formally in model.tex Appendix C

### Open Questions

- Bundle composition taken as exogenous — beta scores proxy it empirically. Is this defensible? Yes: occupation structure is slow-moving and determined by technology/organization, not worker choice.
- Light calibration: parameterize $\alpha$ from the beta score distribution, shock $\tau$ to match timing of 2023 effects.

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

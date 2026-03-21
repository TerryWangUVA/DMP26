# Model Brainstorm — AI Exposure and Labor Market Risk

## Context

Empirical paper: DiD design, CPS-ASEC 2018–2025, Eloundou et al. beta scores as occupation-level AI exposure measure.
Key findings: Higher AI exposure → higher unemployment (especially post-2023), lower wages (especially non-college workers).
Constraint: Undergrad honors thesis — no GE solution. Use PE framework, be transparent about it.

---

## Chosen Strategy

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

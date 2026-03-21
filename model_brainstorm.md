# Model Brainstorm — AI Exposure and Labor Market Risk

## Context

Empirical paper: DiD design, CPS-ASEC 2018–2025, Eloundou et al. beta scores as occupation-level AI exposure measure.
Key findings: Higher AI exposure → higher unemployment (especially post-2023), lower wages (especially non-college workers).
Constraint: Undergrad honors thesis — no GE solution. Use PE framework, be transparent about it.

---

## Abandoned Direction 1: Worker-as-Bundle with Individual Task CES ❌

**Why abandoned:** Fundamental internal inconsistency.

- CES over individual tasks $i$ assumes firms can freely substitute between $y(i)$ and $y(j)$ — tasks are separable in production
- Bundle assumption says tasks within a worker's bundle are indivisible complements — you hire the whole bundle or nothing

These cannot both hold. The CES FOC gives $p_0(i) = P_Y \cdot (Y/y_0(i))^{1/\sigma}$ — but this is a demand-side condition that assumes firms vary $y(i)$ independently. With bundling, $y(i)$ for different $i$ move together (tied to worker hiring decisions), so the FOC doesn't apply to individual tasks.

---

## Abandoned Direction 2: Two-Level Nested CES ❌

**Why abandoned:** Dropped tasks from the production function entirely, losing the direct link between beta scores and model mechanics. Overly complex for an undergrad thesis without adding clarity.

Production was: outer CES over $Q_{NC}$, $Q_C$; inner CES substituting $L_{NC}$ (or $L_C$) with AI services $M$; $\theta_{NC} > \theta_C$ calibrated from mean beta scores. Internally consistent but tasks disappear from the formal model.

---

## Final Direction: GRH + Full Specialization ✓

Keeps the continuum of tasks and the GRH cutoff mechanism. Resolves the bundling inconsistency by assumption: workers do not hold bundles — each worker fully specializes in exactly one task.

### Worker Types

Workers are indexed by ability type $i^* \in [0,1]$. A worker of type $i^*$:
- Is capable of performing any task $i \leq i^*$
- Under competitive assignment, **fully specializes** in task $i^*$ — the hardest task they can perform, where they have comparative advantage

This is a Roy-model / Ricardian comparative advantage assignment. No bundles, no indivisibility problem. The CES operates over tasks, each supplied by a single worker type — internally consistent.

### Production

Tasks indexed $i \in [0,1]$, ordered by AI substitutability — low $i$ is easier for AI.

$$Y = \left[\int_0^1 y(i)^{\frac{\sigma-1}{\sigma}} di\right]^{\frac{\sigma}{\sigma-1}}, \qquad \sigma > 0$$

Full specialization means the supply of task $i$ equals the mass of workers of type $i$: $y_0(i) = f(i)$ where $f$ is the density of worker types. Scarcer complex tasks (low $f(i)$ at high $i$) command higher prices — consistent with the college wage premium.

### AI Cost Function

$$c^{AI}(i) = \tau \cdot t(i), \qquad t(i) = e^{\alpha i}, \quad \alpha > 0$$

$\tau > 0$ falls as AI improves. GPT-4 deployment ≈ discrete fall in $\tau$.

### Pre-AI Task Prices

CES FOC (with output price $P_Y$ exogenous — small open economy):

$$p_0(i) = P_Y \cdot \left(\frac{Y}{y_0(i)}\right)^{1/\sigma}$$

Assumption: $p_0(i)$ is strictly increasing in $i$ (complex tasks are scarcer, command higher prices). Consistent with college wage premium.

### Automation Cutoff

Post-AI, competitive task price:

$$p(i) = \min\!\left(p_0(i),\; \tau e^{\alpha i}\right)$$

Unique cutoff $I^*$ where $\tau e^{\alpha I^*} = p_0(I^*)$. Tasks $i < I^*$ automated; tasks $i \geq I^*$ done by humans. As $\tau \downarrow$, $I^*$ rises.

### Wages

Worker of type $i^*$ earns the competitive price of their task:

$$w(i^*) = p(i^*)$$

Wage change following AI shock:

$$\Delta w(i^*) = \begin{cases} \tau e^{\alpha i^*} - p_0(i^*) < 0 & \text{if } i^* < I^* \\ 0 & \text{if } i^* \geq I^* \end{cases}$$

For $i^* < I^*$: wage is compressed to the AI's cost. If compressed wage falls below reservation wage, worker exits employment.

For $i^* \geq I^*$: wage unchanged in PE (task price unaffected). The productivity effect — AI cheapening output raises $Y$, potentially shifting up wages for retained workers — is a GE channel we abstract from.

### Two Effects (following GRH)

**Displacement effect:** $I^*$ rises → workers in $[0, I^*]$ face wage compression; some exit.

**Productivity effect:** Automating low-$i$ tasks cheapens $Y$, raising real demand for remaining tasks. Wages for $i \geq I^*$ may rise. This is the GE channel — not modeled, acknowledged as a caveat.

Net employment effect is ambiguous. DiD results suggest displacement dominates.

### Education Heterogeneity

**Assumption (Education Sorting):** Non-college workers have types $i^* \in [0, \bar\imath]$ and college workers have types $i^* \in [\bar\imath, 1]$, with $\bar\imath > I^*$.

**Proposition 1 (Differential Wage Compression):** Under education sorting, workers experiencing wage compression ($i^* < I^*$) are exclusively non-college workers. College workers ($i^* \geq \bar\imath > I^*$) face no wage compression.

**Proposition 2 (Differential Unemployment):** Workers exiting employment (compressed wage below reservation wage) are exclusively non-college workers.

Both propositions match empirical findings: non-college unemployment and wage effects are larger and more significant than college effects.

---

## Comparison to GRH (2008)

GRH had an exogenous uniform wage $w$ for all tasks — workers were fungible across tasks. The full-specialization extension gives each task its own wage $w(i^*) = p(i^*)$ pinned by the CES FOC. This is more realistic and directly connects to the college wage premium.

The cutoff mechanism and comparative statics are identical to GRH.

---

## Light Calibration

1. Set $\sigma = 1.5$ (consistent with task-model literature)
2. Set $\alpha$ to match beta score distribution — fit $t(i) = e^{\alpha i}$ so median task has $I^* \approx 0.5$ pre-2023
3. Shock: $\tau$ drops by some % in 2023 to represent GPT-4 deployment
4. Compute implied $\Delta I^*$ and change in employment share of non-college workers
5. Compare to DiD regression coefficients as a plausibility check

---

## Theory Section Outline (~2 pages)

1. **Setup** — tasks, worker types, full specialization, CES aggregation, AI cost function (0.5p)
2. **Pre-AI equilibrium** — task prices from FOC, wages = task prices, college premium (0.25p)
3. **AI shock and cutoff** — derive $I^*$, comparative static in $\tau$ (0.5p)
4. **Wage compression** — $\Delta w(i^*)$ formula, displacement vs. productivity effects (0.25p)
5. **Education heterogeneity** — Propositions 1 and 2 (0.5p)

---

## Related Literature

- **Grossman & Rossi-Hansberg (2008, AER)** — base PE model; offshoring as task trade
- **Ottaviano, Peri & Wright (2013, AER)** — PE extension with multiple worker types and cutoffs
- **Autor & Thompson (2025, NBER w33941)** — task bundling and expertise; motivation for why full specialization is an abstraction
- **Acemoglu & Restrepo (2018, 2019)** — task model with displacement/reinstatement; requires GE (cited for context, not used formally)
- **Eloundou et al. (2024)** — beta scores as empirical counterpart of $t(i)^{-1}$

---

## Open Questions

- [ ] Two-type education cutoff or continuous skill distribution?
- [ ] Calibrate $\alpha$ and $\tau$-shock numerically or just qualitative propositions?
- [ ] Place theory section before empirics (recommended) or in discussion?
- [ ] Note full specialization as simplification vs. bundle reality (one paragraph, cite Autor-Thompson)?

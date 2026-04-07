# Computation Market: Microfounding s(i)

## Setup

### Task side (same as thesis)
- Tasks $i \in [0,1]$, ordered by complexity
- Worker density $f(i)$, full specialization
- Pre-AI wage: $w_0(i) = P_Y (Y_0 / f(i))^{1/\sigma}$

### AI capability

$M(i)$ = AI's capability at task $i$.
- Decreasing in $i$: AI is best at routine tasks, worse at complex ones
- $M(I^*) = 0$: the capability frontier. Beyond $I^*$, AI simply cannot do the task.
- $M(i) > 0$ for $i < I^*$

This is the primitive. The frontier is technological, not a price outcome.

### Computation demand

Each worker at task $i$ wants to offload computation to AI. Their demand depends on:

1. $M(i)$: how much AI can actually help with this task (capability constraint)
2. $\gamma > 0$: homogeneous preference for computation (how eager workers are to use AI)
3. $f(i)$: how many workers are at task $i$

**AI supply at task $i$:**
$$s(i) = \gamma \cdot M(i) \cdot f(i) \quad \text{for } i < I^*$$
$$s(i) = 0 \quad \text{for } i \geq I^*$$

Properties (immediate):
- $s(I^*) = 0$ ✓ (because $M(I^*) = 0$)
- $s'(i) < 0$ if $[M(i) \cdot f(i)]' < 0$ — holds when AI capability drops faster than worker density rises ✓

**Total computation consumed:**
$$Q = \gamma \int_0^{I^*} M(i) \cdot f(i) \, di$$

## Supply side: Monopolist

One AI firm. Cost structure:
$$TC(Q) = F + c \cdot Q$$

- $F$: fixed cost (training, data centers)
- $c$: marginal cost per unit (inference, electricity) — low

The monopolist sets a uniform price $p$ per unit of computation.

### Monopolist's problem

At price $p$, total demand is $Q(p)$. Workers buy computation as long as $p$ is below their willingness to pay.

Worker $i^*$'s WTP per unit of computation: the marginal value of AI assistance in their task. Call this $v(i)$ — how much an extra unit of AI capability is worth to them. Plausibly proportional to their wage: $v(i) = \delta \cdot w_0(i) / (\gamma \cdot M(i))$, but we can keep it simple.

**Simplest version:** All workers below $I^*$ buy computation at any price $p < \bar{v}$ (reservation value). The monopolist just sets $p = \bar{v}$ and extracts surplus. Quantity is $Q = \gamma \int_0^{I^*} M(i) f(i) \, di$, pinned by capability, not price.

**Monopolist's profit:**
$$\pi = (\bar{v} - c) \cdot \gamma \int_0^{I^*} M(i) \cdot f(i) \, di - F$$

Entry condition: $\pi \geq 0$.

## Comparative statics

| Change | $I^*$ | $s(i)$ | Wages |
|---|---|---|---|
| AI improves: $M(i) \uparrow$, $I^* \uparrow$ | Expands | More supply, more tasks | More compression for newly exposed; more gain for those above |
| More workers adopt AI: $\gamma \uparrow$ | Unchanged | $s(i)$ scales up | Deeper compression below $I^*$ |
| MC falls: $c \downarrow$ | Unchanged (tech constraint) | Unchanged (demand-determined) | No direct effect — but makes entry easier ($\pi \uparrow$), may attract more firms |
| Competition: $N \uparrow$ (extend to oligopoly) | Unchanged | Unchanged (same demand) | $p \downarrow$, surplus shifts from AI firms to... workers? firms? Depends on who buys. |

Key insight: **$I^*$ is pinned by technology ($M$), not by price.** The computation market determines *rents* (who captures the surplus), not the *frontier*. This is cleaner than making $I^*$ endogenous to pricing.

## Connection to thesis

Current thesis: "$s(i) \geq 0$, $s'(i) < 0$ for $i < I^*$, $s(i) = 0$ for $i \geq I^*$."

Microfoundation: $s(i) = \gamma \cdot M(i) \cdot f(i)$, where $M(i)$ is AI capability (decreasing, zero at $I^*$) and $\gamma$ is adoption intensity.

What this adds:
- The *shape* of $s(i)$ is determined by $M(i) \cdot f(i)$ — an interaction between AI capability and labor market structure
- The *level* is scaled by $\gamma$ — how aggressively workers/firms adopt AI
- The *frontier* $I^*$ is purely technological — where AI capability hits zero
- The supply side (monopolist) determines who captures the rents, not the frontier itself

## Open questions

1. Should $\gamma$ vary across workers? (Education, age, tech-savviness.) If so, $s(i)$ becomes $\gamma(i) \cdot M(i) \cdot f(i)$ — richer but harder.

2. $M(i)$ improving over time is the story of AI progress. Each generation of models (GPT-3 → 4 → 5) shifts $M$ up and $I^*$ right. Could parametrize as $M(i; \tau)$ where $\tau$ is a technology vintage.

3. The monopolist earns rents $(\bar{v} - c) \cdot Q$. These rents are large (look at AI company valuations). Where do they come from? From the gap between what workers/firms are willing to pay and the marginal cost of inference. This is a transfer from the labor market to the AI sector — worth discussing.

4. Quality: $M(i)$ could be continuous (AI does the task partially, with errors) rather than binary. At $i$ near $I^*$, AI output is low quality — workers still needed to check/refine. This is the augmentation zone.

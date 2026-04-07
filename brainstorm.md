# Microfounding s(i): The Computation Market

## Core Insight

$M(i)$ does double duty:
1. **AI capability** at task $i$ (how much AI can do)
2. **Computation-substitutable share** of task $i$ (what fraction of the task is replaceable by tokens)

These are the same thing. If AI can do 80% of task $i$, then 80% of that task is computation. $M(i)$ *is* the firm's WTP structure — not a separate object.

## The Model

### Primitives

- Tasks $i \in [0,1]$, ordered by complexity
- Worker density $f(i) > 0$, fixed (short run)
- $M(i)$: AI capability / computation-substitutable share
  - $M(i) > 0$ for $i < I^*$
  - $M(I^*) = 0$
  - $M'(i) < 0$
- $\gamma > 0$: adoption intensity (homogeneous)

### AI supply

Each worker at task $i < I^*$ generates demand for $\gamma M(i)$ units of computation. With $f(i)$ workers:

$$s(i) = \gamma \cdot M(i) \cdot f(i)$$

That's it. Three primitives, one equation.

### Why the computation price doesn't matter

The firm's WTP for computation at task $i$ is proportional to $M(i) \cdot w_0(i)$ — the AI-substitutable share of the task's value. But:

- $Q = \gamma \int_0^{I^*} M(i) f(i) \, di$ is technology-determined
- $s(i)$ doesn't depend on the price
- Wages don't depend on the price
- The price only determines how rents split between AI firms and production firms

So we suppress the pricing problem. A monopolist (or oligopoly) sets some $p^*$ and earns $\pi = (p^* - c)Q - F$. This is interesting for IO but irrelevant to labor market outcomes.

### Effective supply and wages

Post-AI:
$$\bar{y}(i) = f(i) + s(i) = f(i)[1 + \gamma M(i)]$$

For $i \geq I^*$: $\bar{y}(i) = f(i)$ (unchanged).

Post-AI wages (CES):
$$w_1(i) = P_Y \left(\frac{\bar{Y}}{\bar{y}(i)}\right)^{1/\sigma}$$

Wage ratio:
$$\frac{w_1(i)}{w_0(i)} = \left(\frac{\bar{Y}}{Y_0}\right)^{1/\sigma} \cdot \frac{1}{[1 + \gamma M(i)]^{1/\sigma}}$$

- Above $I^*$: $M = 0$, second factor = 1, pure gain from $\bar{Y} > Y_0$
- Near $I^*$: $M \approx 0$, still gain
- Deep inside $[0, I^*)$: $M$ large, $[1 + \gamma M(i)]$ outpaces $\bar{Y}/Y_0$, wages fall

**Three-group result holds, now with $M(i)$ as the primitive.**

### The threshold $\hat{\imath}$

Worker $i$ loses iff:
$$1 + \gamma M(i) > \frac{\bar{Y}}{Y_0}$$

$$\gamma M(\hat{\imath}) = \frac{\bar{Y}}{Y_0} - 1$$

Since $M$ is decreasing, $\hat{\imath} < I^*$. Workers below $\hat{\imath}$ lose; workers above gain.

## Shape of $s(i)$

$$\frac{s'(i)}{s(i)} = \frac{M'(i)}{M(i)} + \frac{f'(i)}{f(i)} < 0$$

Holds when $M$ declines proportionally faster than $f$ rises. Automatic when $f$ is flat or declining.

## Comparative Statics

| Change | $I^*$ | $s(i)$ | $\hat{\imath}$ | Wages below $\hat{\imath}$ | Wages above |
|---|---|---|---|---|---|
| AI improves ($M \uparrow$, $I^* \uparrow$) | Expands | Rises | Shifts right | More compression | More gain |
| Adoption ($\gamma \uparrow$) | Unchanged | Scales up | Shifts right | More compression | More gain |
| Worker density shifts ($f$ changes) | Unchanged | Changes | Shifts | Depends | Depends |

## Long Run (not solved, future work)

In the LR, workers respond to $w_1(i)$ by reallocating across tasks (Roy sorting). $f(i)$ becomes endogenous:

- Workers exit low-wage automated tasks → $f(i) \downarrow$ at low $i$
- $s(i) = \gamma M(i) f(i) \downarrow$ → supply dilution weakens → wages partially recover
- Self-correcting mechanism

LR equilibrium: $f(i)$ consistent with $w_1(i)$ under Roy sorting. This is a fixed-point problem requiring: skill distribution, retraining costs, human capital accumulation. A separate paper.

The SR model with fixed $f$ provides a **lower bound** on displacement (workers can't flee) and an **upper bound** on wage compression.

## Summary

The model has four moving parts:
1. $M(i)$: AI capability (the primitive that drives everything)
2. $f(i)$: worker density (fixed in SR, endogenous in LR)
3. $\gamma$: adoption intensity
4. CES production with parameter $\sigma$

One equation: $s(i) = \gamma M(i) f(i)$.

The computation price, the monopolist, the entry condition — all interesting IO questions but orthogonal to the labor market results. The frontier $I^*$ is technological. The displacement pattern is governed by $M(i) \cdot f(i)$. The rest is accounting.

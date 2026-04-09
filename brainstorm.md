# Microfounding s(i): The Computation Market

## Core Insight

$M(i)$ does double duty:
1. **AI capability** at task $i$ (how much AI can do)
2. **Computation-substitutable share** of task $i$ (what fraction is replaceable by tokens)

These are the same thing. $M(i)$ *is* the firm's WTP structure.

## The Model

### Primitives

- Tasks $i \in [0,1]$, ordered by complexity
- Worker density $f(i) > 0$, fixed (short run)
- $M(i)$: AI capability, $M'(i)<0$, $M(I^*)=0$
- $\gamma > 0$: adoption intensity (homogeneous)
- Pre-AI wage: $w_0(i) = P_Y(Y_0/f(i))^{1/\sigma}$

### AI supply

$$s(i) = \gamma \cdot M(i) \cdot f(i)$$

Three primitives, one equation.

### Effective supply and wages

$$\bar{y}(i) = f(i)[1 + \gamma M(i)] \quad \text{for } i < I^*, \qquad \bar{y}(i) = f(i) \quad \text{for } i \geq I^*$$

$$\frac{w_1(i)}{w_0(i)} = \left(\frac{\bar{Y}}{Y_0}\right)^{1/\sigma} \cdot \frac{1}{[1+\gamma M(i)]^{1/\sigma}}$$

Three-group result holds. Threshold $\hat{\imath} < I^*$ where $\gamma M(\hat{\imath}) = \bar{Y}/Y_0 - 1$.

## The Computation Market

### Demand curve (no free parameters)

The firm buys computation for task $i$ iff the cost is below the value of automating the $M(i)$ share of that task. The per-unit WTP at task $i$ is:

$$v(i) = M(i) \cdot w_0(i)$$

This is endogenous — it comes from the pre-AI wage structure, not a free parameter.

At uniform price $p$, the firm buys computation for task $i$ iff $v(i) \geq p$, i.e., $M(i) \cdot w_0(i) \geq p$.

Total demand at price $p$:

$$Q(p) = \gamma \int_{\{i \,:\, M(i) \cdot w_0(i) \geq p\}} M(i) \cdot f(i) \, di$$

This is **downward-sloping** and derived entirely from primitives. No $\bar{v}$.

As $p$ rises → fewer tasks clear the threshold → $Q$ falls.
As $p \to 0$ → all tasks below $I^*$ buy → $Q = \gamma \int_0^{I^*} M(i) f(i) \, di$ (the maximum).

### Monopolist's problem

One firm, $TC = F + cQ$. Faces demand $Q(p)$ above.

$$\max_p \; \pi(p) = (p - c) \cdot Q(p) - F$$

FOC: $Q(p) + (p-c) Q'(p) = 0$, i.e., $MR = MC$.

This pins down $p^*$ — the monopoly price of computation. No free parameter.

### What $p^*$ determines

$p^*$ determines which tasks are actually automated. The automated set is:

$$\mathcal{A}(p^*) = \{i < I^* : M(i) \cdot w_0(i) \geq p^*\}$$

For tasks in $\mathcal{A}$: $s(i) = \gamma M(i) f(i)$.
For tasks outside $\mathcal{A}$ (but still below $I^*$): firm doesn't buy computation (too expensive relative to the savings). $s(i) = 0$ there.

**Note:** The frontier $I^*$ is still technological (where $M = 0$). But the *effective* automated set $\mathcal{A}$ can be smaller than $[0, I^*)$ if the monopoly price is high enough to exclude some tasks.

### Shape of $\mathcal{A}$

$v(i) = M(i) \cdot w_0(i)$ — which direction does this go?

- $M(i)$: decreasing in $i$
- $w_0(i)$: increasing in $i$ (scarce tasks pay more)
- Product: ambiguous. Depends on which force dominates.

If $M$ drops faster than $w_0$ rises: $v(i)$ is decreasing → low-$i$ tasks have highest WTP → routine tasks automated first. **This matches the thesis story.**

If $w_0$ rises faster than $M$ drops: $v(i)$ is increasing → high-$i$ tasks automated first. Counterintuitive but possible if wages are very steep.

For the standard case (routine first): $\mathcal{A}(p^*) = [0, \hat{i}(p^*))$ where $v(\hat{i}) = p^*$.

## Policy Implications

### Tax on computation (raise $c$)

$c \uparrow$ → $MC$ rises → $p^* \uparrow$ → $\mathcal{A}$ shrinks → fewer tasks automated → less displacement.

But also: less output expansion ($\bar{Y}$ lower), less gain for workers above $I^*$.

Tradeoff: protects routine workers at the cost of aggregate productivity.

### Antitrust / competition ($N \uparrow$)

Move from monopoly to oligopoly → $p$ falls toward $c$ → $\mathcal{A}$ expands → more tasks automated.

More displacement? Yes. But also more output expansion and the surplus transfers from AI firms back to the production sector.

Whether workers benefit depends on whether the output-expansion effect (wages above $\hat{\imath}$ rise) outweighs the supply-dilution effect (wages below $\hat{\imath}$ fall).

### Subsidy to computation ($c \downarrow$ via policy)

Same as cost reduction. Enriches monopolist under current structure. Under competition, passes through to firms → more automation → same tradeoff as antitrust.

### Price cap ($p \leq \bar{p}$)

Directly expands $\mathcal{A}$ without changing $c$. Forces monopolist to serve more tasks. Reduces monopolist rents, increases computation quantity.

Labor effect: same direction as antitrust — more automation, more displacement of routine workers, more gain for complex workers.

## Summary

The computation market is now fully endogenous:
- Demand: $Q(p) = \gamma \int_{\{v(i) \geq p\}} M(i) f(i) \, di$, derived from $M$, $f$, $w_0$
- Supply: monopolist with $TC = F + cQ$
- Equilibrium: $MR = MC$ pins $p^*$
- Automated set: $\mathcal{A}(p^*)$ — may be smaller than $[0, I^*)$ if monopoly price excludes some tasks
- Policy: tax, antitrust, subsidy, price cap all have traceable effects on $\mathcal{A}$, $s(i)$, and wages

No free parameters. Everything derives from $M(i)$, $f(i)$, $\sigma$, $\gamma$, $F$, $c$.

## Long Run (future work)

Roy sorting: $f(i)$ responds to $w_1(i)$. Workers exit automated tasks, self-correcting mechanism. Fixed-point problem requiring skill distribution and retraining costs. A separate paper.

---
marp: true
title: Categorical types and AGI 3
theme: econ-ark-cat
paginate: true
math: katex
---

<!-- Slide set 3, split from slide set 2 on 25 Sep 2026: Parts 2 to 4 of the Session B draft. Companion note: notes/Yoneda-stages/fields-and-stages.md.
     Build: marp --no-stdin "Categorical types and AGI -3.md" --theme-set theme/econ-ark-cat.css -o "Categorical types and AGI -3.pdf" --allow-local-files --html < /dev/null -->

<!-- _class: title -->

<p class="title-eyebrow"><span class="keep-case">𝕋v = v</span> Reading Group</p>

# Categorical types and AGI

## Session C. Natural transformations and the Yoneda lemma

<p class="title-authors">Akshay Shanker<span class="title-date">TBD</span></p>

---

<div class="kicker">Session C &middot; contents</div>

## Contents

1. **Natural transformations.** Grouping the equations of a declaration into stages; the factored programs of Sargent and Stachurski (2026) as a naturality square; moving a boundary; transforming some fields; the coarsest cut; a stage file and three applications.

<div class="sp-s"></div>

2. **The Yoneda lemma.** Its statement, its consequences, and its two uses here: inserting a policy, and which operations on value functions are natural.

<div class="sp-s"></div>

3. **Next steps.**

---

<div class="kicker">Session C &middot; recalled from Session B</div>

## Recalled from Session B: signatures and declarations

- A **signature** is a set of types, a set of operator symbols with ranks ${\mathtt{s} : \mathtt{X} \to \mathtt{X}'}$, a subset of decision symbols, and a policy set $\Sigma_{\mathtt{s}}$ for each decision symbol. The graph $\mathcal{S}_\Sigma$ has one edge $(\mathtt{s}, \sigma)$ per decision symbol and policy and one edge $(\mathtt{s}, \ast)$ per other symbol; a **term** is a path in $\mathcal{S}_\Sigma$.

<div class="sp-s"></div>

- A **declaration** is a directed graph $Q$ of fields with a graph morphism $\tau : Q \to \mathcal{S}$, the typing; $Q_\Sigma$ has one edge $(e, \sigma)$ per decision edge and policy, written $e_\sigma$. A **model** in $\mathsf{C}$ assigns an object to each field and an arrow to each edge of $Q_\Sigma$; by Proposition 1 it is the same as a functor ${\mathsf{F}Q_\Sigma \to \mathsf{C}}$.

<div class="sp-s"></div>

- **Example A** (the buffer-stock problem): types $\mathtt{Xm}$, $\mathtt{Xa}$; symbols $\mathtt{save} : \mathtt{Xm} \to \mathtt{Xa}$ (decision) and $\mathtt{income} : \mathtt{Xa} \to \mathtt{Xm}$; the chain $m_0 \to a_0 \to m_1 \to \cdots$ with edges $d_t$ and $\ell_t$. **Example E** (the consumption–portfolio problem): decision symbols $\mathtt{portfolio} : \mathtt{Xk} \to \mathtt{Xm}$ and $\mathtt{consume} : \mathtt{Xm} \to \mathtt{Xk}$; the chain $k_0 \to m_0 \to k_1 \to \cdots$.

---

<div class="kicker">Session C &middot; recalled from Session B</div>

## Recalled from Session B: the two models

- The **forward model** ${D_f : \mathsf{F}Q_\Sigma \to \mathsf{Stoch}}$ sends a field $j$ to its state space $X_j$ and an edge to a stochastic kernel. In Example A, $d_\sigma \mapsto \delta_\sigma$, the point mass at $\sigma(m)$, and $\ell \mapsto D_f(\ell)$, the law of $Ra + \xi'$ given $a$.

<div class="sp-s"></div>

- The **backward model** ${D_b : (\mathsf{F}Q_\Sigma)^{\mathrm{op}} \to \mathsf{Set}}$ sends a field to $L^{X_j}$, the measurable functions from its state space to the extended real line, and an edge $(e, \sigma) : j \to i$ to ${v \mapsto r_{e,\sigma} + \beta_e\, D_f(e, \sigma)^* v}$ from $L^{X_i}$ to $L^{X_j}$, with the reward $r = 0$ on policy-free edges and $\beta_e > 0$; $K^*$ is the backward operator of a kernel, ${(K^* v)(y) = \int K(y, dy')\, v(y')}$.

<div class="sp-s"></div>

- In Example A the period $m \to a \to m'$ goes to ${D_b(d_\sigma) \circ D_b(\ell) = T_\sigma}$, the policy operator ${(T_\sigma v)(m) = u(m - \sigma(m)) + \beta\, \mathbb{E}_{\xi'}\, v(R\sigma(m) + \xi')}$. The reward-free backward model $D_b^0$ has all rewards zero and all discount factors one.

---

<div class="kicker">Session C &middot; recalled from Session B</div>

## Closed terms and rotations

> [!definition] **Definition** (closed term, rotation).
> 1. A term ${\lambda_n \cdots \lambda_1}$ is **closed** at $\mathtt{X}$ when its source type and its target type are both $\mathtt{X}$.
> 2. For $1 \le i \le n$, its $i$-th **rotation** is ${\lambda_i \cdots \lambda_1\, \lambda_n \cdots \lambda_{i+1}}$, closed at the target type of $\lambda_i$.
> 3. The $n$-th rotation is the term itself, and the empty term has no rotation.

<div class="sp-s"></div>

- **Example A.** Writing $\mathtt{save}$ for any edge $(\mathtt{save}, \sigma)$, the closed terms at $\mathtt{Xm}$ are $(\mathtt{income}\;\mathtt{save})^n$; for $n \ge 1$ the odd rotations are $(\mathtt{save}\;\mathtt{income})^n$, closed at $\mathtt{Xa}$, and the even ones are $(\mathtt{income}\;\mathtt{save})^n$ with the policies permuted cyclically. Starting a period at savings instead of cash replaces $\mathtt{income}\;\mathtt{save}$ by $\mathtt{save}\;\mathtt{income}$.

---

<div class="kicker">Session C &middot; recalled from Session B</div>

## Rotations in Example E, period terms and stage terms

- **Example E.** With policies ignored, the closed terms at $\mathtt{Xk}$ are $(\mathtt{consume}\;\mathtt{portfolio})^n$, and their odd rotations $(\mathtt{portfolio}\;\mathtt{consume})^n$ are closed at $\mathtt{Xm}$: a period beginning at wealth against a period beginning at cash.

<div class="sp-s"></div>

- The **period term** of a grouping is the term of one of its edges, and a **stage term** is the term of a stage; both are defined once groupings and stages are, on the slides that follow.

<div class="sp-s"></div>

- Which closed terms are rotations of one another is decided by the type and symbol names alone, before any state space is chosen.

---

<!-- _class: title -->
<!-- _paginate: false -->

<p class="title-eyebrow">Part 2</p>

# 2. Natural transformations

<p class="title-authors">Factored programs &middot; Stages and examples &middot; Moving a boundary &middot; The reduced model &middot; Transforming some fields &middot; The coarsest cut &middot; A stage file</p>

---

<div class="kicker p2">2 Natural transformations &middot; factored programs</div>

## The factored program as a square

<div class="cols" style="grid-template-columns: 1fr 400px; gap: 1.2em; align-items: center;">
<div>

Sargent and Stachurski's (2026) **factored dynamic program** is a tuple ${(V, F, \hat V, \{G_\sigma\}_{\sigma \in \Sigma})}$: nonempty sets $V$ and $\hat V$, one map ${F : V \to \hat V}$, and one map ${G_\sigma : \hat V \to V}$ for each policy $\sigma$. It defines
$$T_\sigma := G_\sigma \circ F, \qquad \hat T_\sigma := F \circ G_\sigma .$$
For every $\sigma$, the definitions and associativity give ${F \circ T_\sigma = F \circ G_\sigma \circ F = \hat T_\sigma \circ F}$, the equation the square asserts; they call the two systems strongly semiconjugate under $F, G_\sigma$.

If $Fv = Fv'$ then ${T_\sigma v = G_\sigma(Fv) = G_\sigma(Fv') = T_\sigma v'}$ for every $\sigma$, so $F$ sends two value functions to the same point only when no policy operator distinguishes them. In their applications $F$ is not a bijection. In Example A, $V$ is the value functions of cash, $\hat V$ functions of savings, and $F$ the income expectation ${(Fv)(a) = \mathbb{E}\, v(Ra + \xi')}$.

</div>
<div class="center">

![w:380](assets/fs-ss-square.svg)

</div>
</div>

<div class="footnote">Sargent and Stachurski (2026), §5.2.2.1, p. 166 (their definition also requires partially ordered value sets and, for each element of the intermediate set, a greatest element among its images under the maps G; neither is used here); equation (5.14), pp. 160–161; equation (5.15) and the remark on bijectivity, p. 161.</div>

---

<div class="kicker p2">2 Natural transformations &middot; factored programs</div>

## Natural transformations

> [!definition] **Definition** (natural transformation; Riehl (2016), Definition 1.4.1).
> Let $D, D' : \mathsf{C} \to \mathsf{E}$ be functors. A **natural transformation** $\alpha : D \Rightarrow D'$ consists of
> 1. for each object $c$ of $\mathsf{C}$, an arrow ${\alpha_c : D(c) \to D'(c)}$ of $\mathsf{E}$, its **component** at $c$;
> 2. such that ${D'(f) \circ \alpha_c = \alpha_{c'} \circ D(f)}$ for every arrow $f : c \to c'$ of $\mathsf{C}$; this equation is the **naturality square** at $f$.

<div class="sp-s"></div>

- When $\mathsf{C}$ is the free category on a graph, the squares at the edges imply the squares at all paths, by pasting (Session A, "Pasting squares"; Riehl (2016), Lemma 1.6.11).

<div class="sp-s"></div>

- Example from the stock: for vector spaces, evaluation $V \to V^{**}$ is a natural transformation from the identity functor to the double-dual functor (Riehl (2016), Example 1.4.4(i), p. 25).

<div class="footnote">Riehl (2016), Definition 1.4.1, p. 25; Lemma 1.6.11, pp. 42–43.</div>

---

<div class="kicker p2">2 Natural transformations &middot; factored programs</div>

## The square is a naturality square

1. Let $\mathsf{B}\mathbb{N}$ be the category with one object, an arrow $n$ for each natural number, composition by addition and identity $0$ (Riehl (2016), Example 1.1.4(ii)).

<div class="sp-s"></div>

2. For each $\sigma$, ${n \mapsto T_\sigma^n}$ and ${n \mapsto \hat T_\sigma^n}$ are functors ${\mathsf{B}\mathbb{N} \to \mathsf{Set}}$: the object goes to $V$ or $\hat V$, and $n + n'$ goes to the composite of the images of $n$ and $n'$.

<div class="sp-s"></div>

3. The square ${F \circ T_\sigma = \hat T_\sigma \circ F}$ is the naturality condition of $F$ at the arrow $1$. At $n$ it follows by induction: ${F \circ T_\sigma^{n+1} = \hat T_\sigma \circ F \circ T_\sigma^n = \hat T_\sigma^{n+1} \circ F}$. So for every policy $\sigma$, $F$ is a natural transformation from the first functor to the second.

<div class="footnote">Riehl (2016), Example 1.1.4(ii), p. 5.</div>

---

<div class="kicker p2">2 Natural transformations &middot; stages</div>

## Chains

> [!definition] **Definition** (chain).
> A **chain** with $N \ge 1$ edges is a declaration with
> 1. fields the **positions** $0, 1, \ldots, N$;
> 2. exactly one edge from each position $j < N$ to $j + 1$, and no other edge.
>
> Its **ends** are the positions $0$ and $N$.

<div class="sp-s"></div>

- With one policy fixed at each decision edge there is exactly one path of $Q_\Sigma$ from $j$ to $j'$ when $j \le j'$ and none otherwise; the free category on a chain is the category with one arrow $j \to j'$ whenever $j \le j'$, Riehl's (2016) ordinal category.

<div class="sp-s"></div>

- **Example A.** The buffer-stock declaration over $N$ periods is a chain with $2N - 1$ edges: the positions are $m_0, a_0, m_1, \ldots, a_{N-1}$ in order.

<div class="footnote">Riehl (2016), Example 4.1.14, p. 135.</div>

---

<div class="kicker p2">2 Natural transformations &middot; stages</div>

## Groupings

> [!definition] **Definition** (grouping, grouped graph, grouped model, stage structure).
> 1. A **grouping** is an increasing sequence of positions ${j_0 < \cdots < j_n}$, its **boundaries**.
> 2. Its **grouped graph** $Q'$ has the boundaries as vertices and, as edges from $j_{i-1}$ to $j_i$, the paths of $Q_\Sigma$ between them.
> 3. ${\pi : \mathsf{F}Q' \to \mathsf{F}Q_\Sigma}$ is the functor sending each such edge to its path (Proposition 1), and the **grouped model** of a model $D$ is ${D \circ \pi}$.
> 4. A **stage structure** is a grouping that contains both ends.

<div class="sp-s"></div>

- Grouping replaces $D$, a functor on $\mathsf{F}Q_\Sigma$, by $D \circ \pi$, a functor on $\mathsf{F}Q'$. It changes the category on which the model is defined, so it is not a natural transformation, which compares two functors on one category.

---

<div class="kicker p2">2 Natural transformations &middot; stages</div>

## Stages and stagings

> [!definition] **Definition** (run, stage, staging).
> 1. A **run** is a path of $Q_\Sigma$ all of whose edges are policy-free, the empty path included.
> 2. A **stage** is an edge of $Q'$ whose path contains exactly one decision edge. Read in the direction of $Q$, it goes from a boundary, its **arrival field**, through a run to the source of the decision edge, through the decision edge, and through a run to the next boundary, its **continuation field**.
> 3. A **staging** is a stage structure all of whose edges are stages.

<div class="sp-s"></div>

- A staging divides the chain into consecutive stages, one for each decision edge. In Example A, the stage from $m_t$ to $m_{t+1}$ has arrival field $m_t$, the decision edge $d_t$, and the run $\ell_t$ to its continuation field $m_{t+1}$.

<div class="sp-s"></div>

- A boundary can be moved across a run but not across a decision edge.

---

<div class="kicker p2">2 Natural transformations &middot; stages</div>

## The number of stagings

> [!lemma] **Lemma** (number of stagings).
> Let a chain have $n_d \ge 1$ decision edges, and for $k = 1, \ldots, n_d - 1$ let $n_k$ be the number of edges of the run between the $k$-th and $(k+1)$-st. A stage structure is a staging if and only if it has exactly one boundary among the $n_k + 1$ positions of each such run, its end positions included, and no boundary other than the ends in the run before the first decision edge or after the last. Hence the chain has $\prod_{k=1}^{n_d-1} (n_k + 1)$ stagings, which is $1$ when $n_d = 1$.

<div class="sp-s"></div>

*Proof.* With no boundary in such a run, one edge of $Q'$ contains two decision edges; with two boundaries in it, or a further boundary in the first or last run, some edge of $Q'$ contains none. The choices in different runs are independent. $\blacksquare$

---

<div class="kicker p2">2 Natural transformations &middot; stages</div>

## The three operators of a stage

<div class="center">

![w:850](assets/fs-stage-sandwich.svg)

</div>

1. Read in the direction of $Q$, the path of a stage goes from its arrival field $j_0$ through a run to the source $i_0$ of the decision edge, through ${(e, \sigma) : i_0 \to i_1}$, and through a run to the continuation field $j_1$; $D_b(j \to j')$ denotes the operator of the run from $j$ to $j'$.

<div class="sp-s"></div>

2. The backward model applies first the **continuation map** ${F := D_b(i_1 \to j_1) : L^{X_{j_1}} \to L^{X_{i_1}}}$, then the **decision operator** ${D_b(e, \sigma) : L^{X_{i_1}} \to L^{X_{i_0}}}$, then the **arrival map** ${U := D_b(j_0 \to i_0) : L^{X_{i_0}} \to L^{X_{j_0}}}$. Since $D_b$ is a functor that reverses order, the **policy operator of the stage** is ${T_\sigma := U \circ D_b(e, \sigma) \circ F}$. $F$ and $U$ are operators of runs, which contain no decision edge, so only the middle factor depends on $\sigma$.

---

<div class="kicker p2">2 Natural transformations &middot; stages</div>

## The stage form and the factored program

1. The factorization ${T_\sigma = U \circ D_b(e, \sigma) \circ F}$, with $F$ and $U$ independent of $\sigma$, is the **stage form** of the family $\{T_\sigma\}$. With $U = \mathrm{id}$ and the same state space at both boundary fields, ${T_\sigma = G_\sigma \circ F}$ is Sargent and Stachurski's (2026) form, with ${G_\sigma := D_b(e, \sigma)}$; with $F = \mathrm{id}$ it is ${U \circ D_b(e, \sigma)}$.

<div class="sp-s"></div>

2. With the pointwise order on $L^X$, every policy operator of a stage is order preserving: each of its three factors sends a larger function to a larger one, since $K^*$ integrates against probability measures, a reward is added, and $\beta_e > 0$.

<div class="sp-s"></div>

3. The family $\{T_\sigma\}$ determines neither $F$ nor $U$. Theorem 7 gives the coarsest cut, through whose quotient map every $F$ factors, and the inclusion of the image of the family is the canonical injective $U$; whether the declared $U$ sends distinct value functions to the same point cannot be read from the family.

---

<div class="kicker p2">2 Natural transformations &middot; stages</div>

## Example A: two stagings of the buffer-stock chain

The chain $m_0 \to a_0 \to \cdots \to a_{N-1}$ has $N$ decision edges and $N - 1$ single-edge runs, so by the Lemma it has $2^{N-1}$ stagings. In a stationary model, two of them place every interior boundary at fields of one type.

<div class="cols" style="grid-template-columns: 480px 1fr; gap: 0.5em 1.2em; align-items: center;">
<div class="center">

![w:480](assets/fs-staging-a1.svg)

</div>
<div>

**Cash fields.** The stage from $m_t$ to $m_{t+1}$ has $U = \mathrm{id}$, ${F = D_b(\ell_t) : L^M \to L^A}$ and policy operator $T_{\sigma_t}$ on $L^M$; the last stage is the single edge $d_{N-1}$.

</div>
<div class="center">

![w:480](assets/fs-staging-a2.svg)

</div>
<div>

**Savings fields.** The first stage is the single edge $d_0$; the stage from $a_t$ to $a_{t+1}$ has $F = \mathrm{id}$, ${U = D_b(\ell_t)}$ and policy operator ${D_b(\ell_t) \circ D_b(d_{t+1}, \sigma_{t+1})}$ on $L^A$, Sargent and Stachurski's (2026) $\hat T_\sigma = F \circ G_\sigma$ with their $F$ in the place of $U$.

</div>
</div>

The interior stage terms are $\mathtt{income}\;\mathtt{save}$ at $\mathtt{Xm}$ and its rotation $\mathtt{save}\;\mathtt{income}$ at $\mathtt{Xa}$; the savings staging works with value functions of end-of-period savings.

---

<div class="kicker p2">2 Natural transformations &middot; stages</div>

## Example C: a two-decision chain

<div class="cols" style="grid-template-columns: 1fr 600px; gap: 1.2em; align-items: center;">
<div>

In the one-period chain $m \to a \to m'$, add a type $\mathtt{Xk}$ (wealth) and replace $\mathtt{income}$ by two policy-free symbols, ${\mathtt{grow} : \mathtt{Xa} \to \mathtt{Xk}}$ on the edge $\ell_{ak}$ (savings grow into wealth) and ${\mathtt{pay} : \mathtt{Xk} \to \mathtt{Xm}}$ on the edge $\ell_{km}$ (wealth plus income is cash); append a decision edge ${d' : m' \to a'}$ of symbol $\mathtt{save}$ with its own policy $\sigma'$.

The run between the decisions has two edges, so by the Lemma there are three stagings, with the interior boundary at $a$, at $k'$ or at $m'$.

</div>
<div class="center">

![w:600](assets/fs-staging-c1.svg)
![w:600](assets/fs-staging-c2.svg)
![w:600](assets/fs-staging-c3.svg)

</div>
</div>

---

<div class="kicker p2">2 Natural transformations &middot; stages</div>

## Example C: the three stagings

1. Boundary at $a$: the first stage is the single edge $d$; the second stage has ${U = D_b(\ell_{ak}) \circ D_b(\ell_{km})}$ and $F = \mathrm{id}$.

<div class="sp-s"></div>

2. Boundary at $k'$: the first stage has ${F = D_b(\ell_{ak})}$ and the second ${U = D_b(\ell_{km})}$.

<div class="sp-s"></div>

3. Boundary at $m'$: the first stage has ${F = D_b(\ell_{ak}) \circ D_b(\ell_{km})}$; the second is the single edge $d'$.

<div class="sp-s"></div>

The position of the boundary determines which edges of the run form the continuation map of the first stage and which form the arrival map of the second.

---

<div class="kicker p2">2 Natural transformations &middot; stages</div>

## Stages and abstract dynamic programs

1. Sargent and Stachurski (2026) call a pair $(V, \{T_\sigma\}_{\sigma \in \Sigma})$ an **abstract dynamic program** when $V$ is a partially ordered set and the $T_\sigma : V \to V$ form a nonempty family of order-preserving maps (Definition 2.1.1).

<div class="sp-s"></div>

2. The policy operators of a stage map $L^{X_{j_1}}$ to $L^{X_{j_0}}$ and are order preserving. So the stage is an abstract dynamic program exactly when its arrival and continuation fields have the same state space, as every stage between two cash fields in Example A does; its policy operators then factor as ${T_\sigma = U \circ D_b(e, \sigma) \circ F}$ with $F$ and $U$ independent of $\sigma$.

<div class="sp-s"></div>

3. Conversely, every abstract dynamic program is a model, in the category of partially ordered sets and order-preserving maps, of the chain with one decision edge whose policy set is $\Sigma$: both fields go to $V$, the edge $(e, \sigma)$ to $T_\sigma$, and $F = U = \mathrm{id}$. It is a backward model only when $V = L^X$ and each $T_\sigma$ has the form $r_\sigma + \beta K_\sigma^*$, a linear decision process in their terms; their value sets include matrices, ordered by positive semidefiniteness of differences.

<div class="footnote">Sargent and Stachurski (2026), Definition 2.1.1 and Remark 2.1.1, p. 59; §5.2.2, p. 166: "we view dynamic programs (ADPs) as families of dynamical systems"; linear decision processes, §6.1.2.1, pp. 187–188, and p. 183.</div>

---

<div class="kicker p2">2 Natural transformations &middot; stages</div>

## Example E over $N$ periods

1. The chain is ${k_0 \to m_0 \to k_1 \to \cdots \to m_{N-1} \to k_N}$, with decision edges $k_t \to m_t$ of symbol $\mathtt{portfolio}$ and $m_t \to k_{t+1}$ of symbol $\mathtt{consume}$. Every run between decisions is empty, so by the Lemma the only staging has a boundary at every field.

<div class="sp-s"></div>

2. Take a stationary model with one pair $\sigma = (\sigma_1, \sigma_2)$ at every date. Give the consumption edge the reward $u \circ \sigma_2$ and discount factor $\beta$, and the portfolio edge reward $0$ and discount factor $1$. The operators of the two edges in the backward model are
   $$\mathbf{M}_\sigma v(m) = u(\sigma_2(m)) + \beta\, v(m - \sigma_2(m)), \qquad \mathbf{P}_\sigma v(k) = \mathbb{E}\, v\big(k[\sigma_1(k)\Psi + (1 - \sigma_1(k))R] + \theta\big),$$
   $\mathbf{M}_\sigma$ from $L^{X_k}$ (value functions of wealth) to $L^{X_m}$ (of cash), and $\mathbf{P}_\sigma$ from $L^{X_m}$ to $L^{X_k}$.

---

<div class="kicker p2">2 Natural transformations &middot; stages</div>

## Example E: two groupings of the chain

<div class="cols" style="grid-template-columns: 560px 1fr; gap: 0.6em 1.2em; align-items: center;">
<div class="center">

![w:560](assets/fs-consport-g1.svg)

</div>
<div>

**Wealth grouping** $k_0, k_1, \ldots, k_N$: each edge $k_t \to k_{t+1}$ has operator ${\mathbf{P}_\sigma \circ \mathbf{M}_\sigma}$ on $L^{X_k}$, which Shanker (2026) calls the beginning-returns operator because the period begins at wealth.

</div>
<div class="center">

![w:560](assets/fs-consport-g2.svg)

</div>
<div>

**Cash grouping** $m_0, \ldots, m_{N-1}$: each edge $m_t \to m_{t+1}$ has operator ${\mathbf{M}_\sigma \circ \mathbf{P}_\sigma}$ on $L^{X_m}$, the end-returns operator, because the period begins at cash, after the returns.

</div>
</div>

Each edge of either grouping contains two decision edges, so neither grouping is a staging. The closed terms are $\mathtt{consume}\;\mathtt{portfolio}$ at $\mathtt{Xk}$ and its rotation $\mathtt{portfolio}\;\mathtt{consume}$ at $\mathtt{Xm}$.

---

<div class="kicker p2">2 Natural transformations &middot; moving a boundary</div>

## Moving a boundary

> [!claim] **Proposition 4** (comparing groupings).
> Let $D$ be a model of a chain in a category $\mathsf{C}$, and fix one policy at each decision edge, so that for positions $j \le j'$ there is exactly one path from $j$ to $j'$; write $D(j \to j')$ for its arrow. Let ${j_0 < \cdots < j_n}$ and ${j'_0 < \cdots < j'_n}$ be two groupings with the same number of boundaries, and let $D_\pi$ and $D_{\pi'}$ be the functors on the free category of the chain $0 \to 1 \to \cdots \to n$ that send its $i$-th edge to $D(j_{i-1} \to j_i)$ and to $D(j'_{i-1} \to j'_i)$. If $j_i \le j'_i$ for every $i$, the arrows $D(j_i \to j'_i)$ are the components of a natural transformation ${D_\pi \Rightarrow D_{\pi'}}$. If $j_i > j'_i$ for some $i$, this family is not defined.

<div class="sp-s"></div>

- In Example A under $D_b$, moving every interior boundary from $m_{t+1}$ to $a_t$ gives a transformation from the cash staging to the savings staging with components $D_b(\ell_t)$.

<div class="sp-s"></div>

- For the backward model, a functor on the reversed chain, the inequality refers to the reversed order: its components run from the grouping whose boundaries are later in $Q$ to the one whose boundaries are earlier.


---

<div class="kicker p2">2 Natural transformations &middot; moving a boundary</div>

## The squares of Proposition 4

1. **The square.** At the $i$-th edge the square asserts
   $$D(j'_{i-1} \to j'_i) \circ D(j_{i-1} \to j'_{i-1}) = D(j_i \to j'_i) \circ D(j_{i-1} \to j_i).$$
   Since $D$ is a functor, each side is the arrow of a path from $j_{i-1}$ to $j'_i$, and the chain has exactly one such path. Pasting the squares gives naturality at every path of the chain $0 \to 1 \to \cdots \to n$ on which $D_\pi$ and $D_{\pi'}$ are defined.

<div class="sp-s"></div>

2. **One boundary at a time.** If the second grouping differs from the first only in ${j'_i = j_i + 1 < j_{i+1}}$, and the edge $e$ from $j_i$ to $j_i + 1$ is policy-free, every component is an identity except the one at $i$, which is $D(e)$. In Example A these components are $D_b(\ell_t)$, which in a stationary model is the map $F$ of Sargent and Stachurski's (2026) square.

<div class="footnote">Riehl (2016), Lemma 1.6.11, pp. 42–43 (pasting); Session A, "Pasting squares".</div>

---

<div class="kicker p2">2 Natural transformations &middot; moving a boundary</div>

## The rotation in Example E

1. Take the stationary model with the same pair $\sigma$ at every date. In the reversed chain each cash field $m_t$ precedes the wealth field $k_t$ of its period, so Proposition 4 applied to $D_b$, with the cash fields as the first grouping and the wealth fields as the second, gives a natural transformation from the cash grouping to the wealth grouping whose every component is ${\mathbf{P}_\sigma : L^{X_m} \to L^{X_k}}$.

<div class="sp-s"></div>

2. Its square at each period is ${(\mathbf{P}_\sigma \mathbf{M}_\sigma) \circ \mathbf{P}_\sigma = \mathbf{P}_\sigma \circ (\mathbf{M}_\sigma \mathbf{P}_\sigma)}$, and pasting $n$ squares gives
   $$(\mathbf{P}_\sigma \mathbf{M}_\sigma)^n\, \mathbf{P}_\sigma = \mathbf{P}_\sigma\, (\mathbf{M}_\sigma \mathbf{P}_\sigma)^n \quad \text{for every } n \ge 1,$$
   which holds by associativity of composition alone. In words, applying $\mathbf{P}_\sigma$ to a value function of cash and then the wealth-to-wealth operator $n$ times gives the same function of wealth as applying the cash-to-cash operator $n$ times and then $\mathbf{P}_\sigma$.

---

<div class="kicker p2">2 Natural transformations &middot; moving a boundary</div>

## The rotation in Example E, continued

1. Pairing $k_{t+1}$ with $m_t$ instead gives the transformation in the opposite direction, with every component $\mathbf{M}_\sigma : L^{X_k} \to L^{X_m}$ and the identity ${(\mathbf{M}_\sigma \mathbf{P}_\sigma)^n\, \mathbf{M}_\sigma = \mathbf{M}_\sigma\, (\mathbf{P}_\sigma \mathbf{M}_\sigma)^n}$.

<div class="sp-s"></div>

2. For every model and every fixed choice of policies, groupings whose period terms are a closed term and one of its rotations are related by natural transformations in both directions (Proposition 4); this is the move Shanker (2026) calls a slider.

---

<div class="kicker p2">2 Natural transformations &middot; the reduced model</div>

## The chain of periods and the reduced model

1. Orient a chain of periods in the direction in which the backward operators act: the positions $N, N - 1, \ldots, 0$ are dates, and for each date $t < N$ and each policy $\sigma$ there is an edge ${(t, \sigma) : t + 1 \to t}$. Let $D$ be a model in $\mathsf{Set}$ with $D(t) = V_t$, the value functions at date $t$, and ${D(t, \sigma) = T_{t,\sigma} : V_{t+1} \to V_t}$; in the examples each edge is the stage of period $t$.

<div class="sp-s"></div>

2. Factor each operator as ${T_{t,\sigma} = G_{t,\sigma} \circ F_{t+1}}$ with ${F_{t+1} : V_{t+1} \to \hat V_{t+1}}$ the same for every $\sigma$ and ${G_{t,\sigma} : \hat V_{t+1} \to V_t}$; put $\hat V_0 := V_0$ and $F_0 := \mathrm{id}$.

<div class="sp-s"></div>

3. The **reduced model** $\hat D$, Sargent and Stachurski's (2026) subordinate program, has $\hat D(t) := \hat V_t$ and ${\hat D(t, \sigma) := F_t \circ G_{t,\sigma} : \hat V_{t+1} \to \hat V_t}$.

---

<div class="kicker p2">2 Natural transformations &middot; the reduced model</div>

## The factored program on a chain of periods

> [!claim] **Proposition 5.**
> The maps $F_t$ are the components of a natural transformation $F : D \Rightarrow \hat D$, and for every sequence of policies $(\sigma_0, \ldots, \sigma_{N-1})$, with juxtaposition denoting composition,
> $$F_0\, T_{0,\sigma_0} \cdots T_{N-1,\sigma_{N-1}} = \hat D(0, \sigma_0) \cdots \hat D(N-1, \sigma_{N-1})\, F_N .$$

<div class="sp-s"></div>

- At each date the square ${F_t \circ T_{t,\sigma} = \hat D(t, \sigma) \circ F_{t+1}}$ is Sargent and Stachurski's (2026), with a date-dependent $F_t$ in place of their single $F$.

<div class="sp-s"></div>

- Because $F_0$ is the identity, the reduced model, started from $F_N$ applied to the terminal value function, returns the same date-$0$ value function as the original model, for every sequence of policies.

---

<div class="kicker p2">2 Natural transformations &middot; the reduced model</div>

## The square at one date

<div class="center">

![w:260](assets/fs-chain-square.svg)

</div>

1. Down then across is ${F_t \circ T_{t,\sigma} = F_t \circ G_{t,\sigma} \circ F_{t+1}}$ by the factorization; across then down is ${\hat D(t, \sigma) \circ F_{t+1} = F_t \circ G_{t,\sigma} \circ F_{t+1}}$ by the definition of $\hat D$; the equation is the naturality square at $(t, \sigma)$.

<div class="sp-s"></div>

2. Applying the square at dates $0, 1, \ldots, N - 1$ in turn moves $F$ from the left of the product to the right:
   $$F_0 T_{0} T_{1} \cdots = \hat D(0) F_1 T_{1} \cdots = \hat D(0) \hat D(1) F_2 \cdots = \cdots = \hat D(0) \cdots \hat D(N-1)\, F_N ,$$
   the identity of Proposition 5.

---

<div class="kicker p2">2 Natural transformations &middot; transforming some fields</div>

## Transforming some fields

> [!claim] **Proposition 6** (partial transformations).
> Let ${D : \mathsf{F}Q_\Sigma \to \mathsf{Set}}$ be a model (for the backward model, replace $Q_\Sigma$ by the graph with every edge reversed), $J$ a set of fields, and ${\varphi_j : D(j) \to B_j}$ an onto map for each $j \in J$; for $j \notin J$ put $B_j := D(j)$ and $\varphi_j := \mathrm{id}$. There exist a model $D'$ with $D'(j) = B_j$ and a natural transformation ${\varphi : D \Rightarrow D'}$ with these components if and only if, for every edge $(e, \sigma) : j \to i$ with $j \in J$ and all $v, v' \in D(j)$,
> $$\varphi_j(v) = \varphi_j(v') \quad\text{implies}\quad \varphi_i(D(e, \sigma)\, v) = \varphi_i(D(e, \sigma)\, v') .$$
> Then $D'$ is unique, with ${D'(e, \sigma)(\varphi_j v) = \varphi_i(D(e, \sigma)\, v)}$. A family satisfying the condition is called **admissible**.

<div class="sp-s"></div>

In words: an operator out of a transformed field, followed by the component at its target, must take one value on each class of values that the component sends to one point.

---

<div class="kicker p2">2 Natural transformations &middot; transforming some fields</div>

## The condition of Proposition 6

<div class="center">

![w:380](assets/fs-partial-square.svg)

</div>

1. **Edges from an untransformed field** impose nothing: with $\varphi_j = \mathrm{id}$ the square ${D'(e, \sigma) \circ \varphi_j = \varphi_i \circ D(e, \sigma)}$ reads ${D'(e, \sigma) = \varphi_i \circ D(e, \sigma)}$, which defines $D'(e, \sigma)$.

<div class="sp-s"></div>

2. **Edges from a transformed field** require ${\varphi_i \circ D(e, \sigma)}$ to take one value on each set $\varphi_j^{-1}(b)$, $b \in B_j$. Then ${D'(e, \sigma)(b) := \varphi_i(D(e, \sigma)\, v)}$, for any $v$ with $\varphi_j(v) = b$, defines a map $B_j \to B_i$, the only one satisfying the square because $\varphi_j$ is onto; it is the dashed arrow.

---

<div class="kicker p2">2 Natural transformations &middot; transforming some fields</div>

## Necessity, one field at a time, and locality

1. **Necessity.** If $D'$ exists, its square gives ${\varphi_i(D(e, \sigma)\, v) = D'(e, \sigma)(\varphi_j v)}$, which depends on $v$ only through $\varphi_j(v)$. Proposition 1 extends $D'$ from edges to paths, and pasting gives naturality at every path.

<div class="sp-s"></div>

2. **One field.** A single field $j$ may be transformed while every other field keeps its carrier, the set $D(j)$, and the identity component. The condition then concerns only the edges that leave $j$ in the graph on which $D$ is defined, which for the backward model are the edges of $Q$ that enter $j$.

<div class="sp-s"></div>

3. **Locality.** With $J = \{j\}$, an edge with neither end at $j$ has identity components at both ends, so its square gives ${D'(e, \sigma) = D(e, \sigma)}$: only the operators of edges with an end at $j$ can change.

---

<div class="kicker p2">2 Natural transformations &middot; transforming some fields</div>

## Example B: a deterministic chain with an unreached point

The chain $x_1 \to x_2 \to x_3$ has state spaces $\{1, 2, 3\}$, $\{0, 1\}$, $\{0, 1, 2\}$; the decision edge $e_1$ has the eight maps ${\{1, 2, 3\} \to \{0, 1\}}$ as policies, and $e_2$ goes to $\delta_f$ with $f(0) = 0$, $f(1) = 2$, whose image omits $1$. Rewards are zero and discount factors one.

<div class="center">

![w:480](assets/fs-example-b.svg)

</div>

The backward model runs on the reversed chain $x_3 \to x_2 \to x_1$, so the edge leaving $x_3$ is $e_2$ reversed, with operator ${v \mapsto v \circ f}$, the function on $\{0, 1\}$ with values $v(0)$ and $v(2)$. By Proposition 6 with $J = \{x_3\}$, an onto component $\varphi_{x_3}$ is admissible exactly when ${\varphi_{x_3}(v) = \varphi_{x_3}(v')}$ implies $v(0) = v'(0)$ and $v(2) = v'(2)$; the coarsest admissible component, ${v \mapsto (v(0), v(2))}$, discards the value at the unreached point $1$.

---

<div class="kicker p2">2 Natural transformations &middot; moving a boundary</div>

## Exchanging two symbols

1. Moving a boundary regroups one fixed sequence of edges without changing their order, and rotating a closed term is such a regrouping. Exchanging two adjacent edges changes the sequence itself and gives a different declaration; when one edge draws a shock and the other takes a decision, the exchange changes whether the shock is known when the decision is taken.

<div class="sp-s"></div>

2. A shock $\varepsilon$ is $0$ or $1$ with equal probability; an action is $0$ or $1$; the reward is $1$ when action and shock agree. Every action chosen **before** the draw has expected reward $\tfrac12$. An action chosen **after** the draw may depend on $\varepsilon$, and the policy that sets the action equal to $\varepsilon$ earns $1$. So the maximal expected reward is $\tfrac12$ in one order and $1$ in the other.

<div class="sp-s"></div>

3. So "decide then draw" and "draw then decide" are different declarations. Proposition 4 compares groupings of one chain and does not relate them; the free category imposes no equation between distinct paths, so any equality between the two would be a property of a particular model, and this model violates it.

<div class="footnote">The Bellman calculus states the same point as the inequality max ∘ 𝔼 ≤ 𝔼 ∘ max, whose gap is the value of information (Shanker (2026), bellman-ddsl, AI/dev-docs/theory/semantics/bellman-core-theory.md, §3.3, R5).</div>

---

<div class="kicker p2">2 Natural transformations &middot; the coarsest cut</div>

## Cuts

> [!definition] **Definition** (cut, coarser, indistinguishable).
> Let $V$ and $W$ be sets and $\{T_\sigma\}_{\sigma \in \Sigma}$ a family of maps $V \to W$; for a stage, $V$ is the set of value functions on the continuation field and $W$ the set on the arrival field.
> 1. A **cut** of the family is a triple $(\hat V, F, G_\sigma)$: a set $\hat V$, a map ${F : V \to \hat V}$ independent of $\sigma$, and maps ${G_\sigma : \hat V \to W}$ with ${T_\sigma = G_\sigma \circ F}$ for every $\sigma$.
> 2. A cut $(\hat V, F, G_\sigma)$ is **coarser** than a cut $(\hat V', F', G'_\sigma)$ when ${F = \omega \circ F'}$ for some map ${\omega : F'(V) \to \hat V}$, and **coarsest** when it is coarser than every cut.
> 3. Two elements are **indistinguishable**, $v \sim v'$, when ${T_\sigma v = T_\sigma v'}$ for every $\sigma$.

<div class="sp-s"></div>

- $\sim$ is an equivalence relation. Let $\bar V$ be the set of its classes, ${q : V \to \bar V}$, $q(v) := [v]$, and ${\bar G_\sigma [v] := T_\sigma v}$, which is well defined because $v \sim v'$ means $T_\sigma v = T_\sigma v'$; $q$ is the **quotient map**. With one policy, $q$ is the map of $T$ onto its image. In Example A, two value functions of cash are indistinguishable exactly when they have the same expected value $\mathbb{E}\, v(Ra + \xi')$ at every saving level $a$.


---

<div class="kicker p2">2 Natural transformations &middot; the coarsest cut</div>

## The coarsest cut

> [!claim] **Theorem 7** (the coarsest cut).
> $(\bar V, q, \bar G_\sigma)$ is a cut, and for every cut $(\hat V, F, G_\sigma)$ there is exactly one map ${\omega_F : F(V) \to \bar V}$ with ${q = \omega_F \circ F}$. It is onto, and ${\bar G_\sigma \circ \omega_F = G_\sigma}$ on $F(V)$.

<div class="sp-s"></div>

*Proof.* If $Fv = Fv'$ then ${T_\sigma v = G_\sigma(Fv) = G_\sigma(Fv') = T_\sigma v'}$ for every $\sigma$, so ${\omega_F(Fv) := [v]}$ is well defined. It is the only map with $q = \omega_F \circ F$ because every point of $F(V)$ has the form $Fv$; it is onto because $q$ is; and ${\bar G_\sigma(\omega_F(Fv)) = T_\sigma v = G_\sigma(Fv)}$. $\blacksquare$

<div class="sp-s"></div>

- Hence $(\bar V, q, \bar G_\sigma)$ is a coarsest cut. If $(\hat V, F, G_\sigma)$ is any coarsest cut, then ${F = \omega \circ q}$ for some $\omega$, and ${\omega \circ \omega_F}$ and ${\omega_F \circ \omega}$ are identities because $F$ and $q$ are onto their images; so $\omega_F : F(V) \to \bar V$ is a bijection, and the coarsest cut is determined up to this one bijection.

<div class="sp-s"></div>

- In words, the quotient map $q$ sends two value functions to the same point exactly when every $T_\sigma$ takes the same value at them.

---

<div class="kicker p2">2 Natural transformations &middot; the coarsest cut</div>

## The canonical stage form

<div class="center">

![w:620](assets/fs-canonical.svg)

</div>

1. ${W_\Sigma := \bigcup_\sigma T_\sigma(V) \subseteq W}$ is the **image of the family**, with inclusion ${U_\Sigma : W_\Sigma \to W}$, and $\bar G_\sigma$ is read as a map $\bar V \to W_\Sigma$.

<div class="sp-s"></div>

2. A **stage form** of the family is a factorization ${T_\sigma = U \circ G_\sigma \circ F}$ for every $\sigma$, with ${F : V \to \hat V}$ and ${U : \tilde V \to W}$ independent of $\sigma$ and ${G_\sigma : \hat V \to \tilde V}$; the diagram draws $F$ onto its image $F(V)$. The top row is itself a stage form, ${T_\sigma = U_\Sigma \circ \bar G_\sigma \circ q}$.

---

<div class="kicker p2">2 Natural transformations &middot; the coarsest cut</div>

## The two equations of the diagram

1. ${q = \omega_F \circ F}$ on $V$: this is Theorem 7 applied to the cut $(\hat V, F, U \circ G_\sigma)$.

<div class="sp-s"></div>

2. ${U_\Sigma \circ \bar G_\sigma \circ \omega_F = U \circ G_\sigma}$ on $F(V)$: both sides send $Fv$ to $T_\sigma v$.

<div class="sp-s"></div>

3. So every stage form is linked to the top row by the single map $\omega_F$ (Corollary 9 of the companion note fields-and-stages.md). On the arrival side, for every factorization ${T_\sigma = U \circ \tilde G_\sigma}$ with $U$ injective and independent of $\sigma$, exactly one ${\omega_U : W_\Sigma \to \tilde V}$ satisfies ${U \circ \omega_U = U_\Sigma}$ (Proposition 8 of the note, not proved here).

<div class="sp-s"></div>

4. In words, the policy operators of every stage can be written as the quotient map $q$, then a map that depends on the policy, then the inclusion of the values that some policy reaches.

---

<div class="kicker p2">2 Natural transformations &middot; the coarsest cut</div>

## Example A: the coarsest cut in the buffer-stock problem

1. Take the cash staging of a stationary model, on value functions with finite income expectations, with family ${(T_\sigma v)(m) = u(m - \sigma(m)) + \beta\, \mathbb{E}_{\xi'}[v(R\sigma(m) + \xi')]}$. Since ${T_\sigma v - T_\sigma v' = \beta\, \mathbb{E}_{\xi'}[(v - v')(R\sigma(m) + \xi')]}$, $\beta > 0$, and every $a \in A$ is $\sigma(m)$ for some policy and some $m > a$, $v \sim v'$ exactly when ${\mathbb{E}_{\xi'}[(v - v')(Ra + \xi')] = 0}$ for every $a \in A$.

<div class="sp-s"></div>

2. The continuation map $D_b(\ell)$, ${(D_b(\ell) v)(a) = \mathbb{E}_{\xi'}\, v(Ra + \xi')}$, is linear, so item 1 says $v \sim v'$ exactly when $D_b(\ell) v = D_b(\ell) v'$. By Theorem 7, $\omega_{D_b(\ell)}$ is a bijection from the image of $D_b(\ell)$ onto $\bar V$: the stage's own continuation map, with its codomain restricted to its image, is the map of a coarsest cut, and $\bar V$ is in bijection with a set of functions of savings, the state after the decision and before the shock.

<div class="sp-s"></div>

3. With ${G_\sigma := D_b(d, \sigma)}$, the reduced model of Proposition 5 has ${\hat D(t, \sigma) = D_b(\ell) \circ G_\sigma}$, that is, ${(\hat D(t, \sigma)\, w)(a) = \mathbb{E}_{\xi'}[u(m' - \sigma(m')) + \beta\, w(\sigma(m'))]}$ with $m' = Ra + \xi'$, acting on functions of savings; this is the policy operator of the savings staging.

---

<div class="kicker p2">2 Natural transformations &middot; a stage file</div>

## Example F: the stage file

The bellman-ddsl project writes a dynamic program as stage files, one per stage in the sense of these slides, composed into periods by a trellis file. The file `buffer_stock.bl` declares one stage of the buffer-stock problem in ratios to permanent income: a growth factor $\Gamma$, a lognormal permanent shock $\psi$ with mean one and log standard deviation $\sigma_\psi$, a transitory shock $\xi$ that is zero with probability $p_{\mathrm{zero}}$ and lognormal otherwise, utility ${u(c) = c^{1-\gamma}/(1-\gamma)}$ with $\gamma > 1$ (the file writes $\rho$), and consumption $c \in (0, m)$. Its state fields are $k$ (arrival), $m$ (decision) and $a$ (continuation), with types $\mathtt{Xa}$, $\mathtt{Xm}$, $\mathtt{Xa}$, each bound in the file to the set $\mathbb{R}_{++}$.

<div class="center">

![w:500](assets/fs-bufferstock.svg)

</div>

The forward equations are on the arrows; with the shocks integrated into its kernel, the arrival equation is the one edge $k \to m$. The file's control is consumption $c$; under a saving policy $\sigma$, ${c = m - \sigma(m)}$.

<div class="footnote">Shanker (2026), bellman-ddsl, applications/buffer-stock/buffer_stock.bl: types ll. 3–4, shocks ll. 15–18, utility l. 20, feasible consumption l. 24, forward equations ll. 27, 31, value equations ll. 35, 40.</div>

---

<div class="kicker p2">2 Natural transformations &middot; a stage file</div>

## The stage form of the file

1. The decision edge is $m \to a$, with ${(G_\sigma w)(m) = u(m - \sigma(m)) + \beta\, w(\sigma(m))}$ from value functions on $a$ to value functions on $m$, the file's value equation on $m$. The run after the decision edge is empty, so the continuation map is the identity.

<div class="sp-s"></div>

2. The arrival map is ${(Uv)(k) = \mathbb{E}_{\psi,\xi}\big[(\Gamma\psi)^{1-\gamma}\, v(Rk/(\Gamma\psi) + \xi)\big]}$, the file's value equation on $k$; the weight $(\Gamma\psi)^{1-\gamma}$ comes from the normalization by permanent income. It is linear and maps nonnegative functions to nonnegative functions, but ${U1 = \mathbb{E}[(\Gamma\psi)^{1-\gamma}] = \Gamma^{1-\gamma} \exp(\gamma(\gamma - 1)\sigma_\psi^2/2)}$, which differs from $1$ in general. So $U$ is $\mathbb{E}[(\Gamma\psi)^{1-\gamma}]$ times the backward operator of the kernel of the same equation under the law of $\psi$ reweighted by $(\Gamma\psi)^{1-\gamma}$, that is, the operator of a policy-free edge with a discount factor, taken as the file declares it.

---

<div class="kicker p2">2 Natural transformations &middot; a stage file</div>

## The arrival map does not distinguish some value functions

1. When $\sigma_\psi > 0$, for each $k > 0$ the law of ${Rk/(\Gamma\psi) + \xi}$ has a density with respect to Lebesgue measure, because $Rk/(\Gamma\psi)$ is lognormal and $\xi$ is independent of $\psi$. So $Uv = Uv'$ whenever $v$ and $v'$ agree outside a Lebesgue-null set, and $U$ is not injective.

<div class="sp-s"></div>

2. Replacing the domain of $U$ by its quotient under ${Uw = Uw'}$ gives a second factorization of the same family $\{U \circ G_\sigma\}$ with an injective arrival map. Whether the arrival map sends distinct value functions to the same point is therefore not a property of the family; the declaration supplies $U$.

<div class="sp-s"></div>

3. When $\sigma_\psi = 0$, which the file allows, the law of $m$ given $k$ has an atom at $Rk/\Gamma$ of mass $p_{\mathrm{zero}}$, and $U$ distinguishes functions that differ at that atom.

---

<div class="kicker p2">2 Natural transformations &middot; applications</div>

## Application: portfolio choice with a discounting stage

<div class="center">

![w:820](assets/fs-app-k-period.svg)

</div>

The trellis file `port-cons.yml` composes three stage files per period: `port.bl` (share $\sigma_1$ chosen, then $(\Psi, \theta)$ drawn), `cons.bl` (consumption $\sigma_2$) and `disc.bl`, a stage with no decision that multiplies the value by $\beta$. Each file also has an identity edge from its arrival field to its decision field, so a period has six edges and two decision edges.

<div class="center">

![w:820](assets/fs-app-k-staging.svg)

</div>

Two periods have four decision edges and runs of $1$, $3$ and $1$ edges between them, hence ${2 \cdot 4 \cdot 2 = 16}$ stagings. Every arrival and continuation map is a composite of identities and at most one multiplication by $\beta$, a discount factor on a policy-free edge. In the staging drawn, the stages of a period have the operators $\mathbf{P}_\sigma$ and $\mathbf{M}_\sigma$ of Example E.

<div class="footnote">Shanker (2026), applications/portfolio-choice/port.bl, cons.bl, disc.bl; applications/cons-port/trellises/port-cons.yml; Example K of AI/working/2026-09-25-application-examples.md.</div>

---

<div class="kicker p2">2 Natural transformations &middot; applications</div>

## Application: a perfect-foresight chain and a natural isomorphism

<div class="cols" style="grid-template-columns: 500px 1fr; gap: 0.6em 1.2em; align-items: center;">
<div class="center">

![w:500](assets/fs-app-m-1.svg)

</div>
<div>

`ConsPerfForesight_simple.bl` declares a single type, whose carrier is $\mathbb{R}$, a policy-free edge ${\ell : k \to m}$ with law ${m = Rk/\Gamma + 1}$ and a decision edge ${d : m \to a}$ with $a = m - c$; identifying $a$ with the next period's $k$ gives the chain drawn, with two stagings.

</div>
<div class="center">

![w:500](assets/fs-app-m-2.svg)

</div>
<div>

The operator of $\ell$ in the backward model is ${(D_b(\ell)\, v)(k) = \Gamma^{1-\gamma}\, v(Rk/\Gamma + 1)}$, a substitution scaled by a constant. Since $k \mapsto Rk/\Gamma + 1$ is a bijection of $\mathbb{R}$, $D_b(\ell)$ is a bijection of value functions.

</div>
</div>

Moving each interior boundary from $k_{t+1}$ to $m_t$ is a natural transformation between the grouped models of the two stagings (Proposition 4), each component $D_b(\ell)$ a bijection: a **natural isomorphism**, a natural transformation whose components are all isomorphisms (Riehl (2016), Definition 1.4.3, p. 25). No arrival map averages, and none sends two value functions to the same point.

<div class="footnote">Shanker (2026), bellman-ddsl, applications/preliminary/ConsPerfForesight_simple/ConsPerfForesight_simple.bl; Example M of the working file.</div>

---

<div class="kicker p2">2 Natural transformations &middot; applications</div>

## Application: a rotation blocked by type names

<div class="center">

![w:1000](assets/fs-app-p.svg)

</div>

`ConsKinkedR.bl` names three types, $\mathtt{Xk}$, $\mathtt{Xm}$ and $\mathtt{Xa}$, all assigned the set $\mathbb{R}$, with a policy-free symbol $\mathtt{Xk} \to \mathtt{Xm}$ (interest at a rate that depends on the sign of $k$, then the shocks $\psi$ and $\theta$) and a decision symbol $\mathtt{Xm} \to \mathtt{Xa}$.

<div class="sp-s"></div>

- The period term runs from $\mathtt{Xk}$ to $\mathtt{Xa}$, so as the file writes it the term is not closed and has no rotation. The identification $a_t = k_{t+1}$ made in the project's documentation treats $\mathtt{Xa}$ and $\mathtt{Xk}$ as one type; the common set $\mathbb{R}$ permits this and the two names do not state it. The type names thus block a rotation that the state spaces allow.

<div class="sp-s"></div>

- The arrival map averages over $\psi$ and $\theta$. For $k \ne 0$ the law of $m$ has a density; at $k = 0$ it has an atom, since $m = \theta$ and $\theta$ has a point mass. So the arrival map sends two value functions that differ on a Lebesgue-null set avoiding that atom to the same point, and it is not injective.

<div class="footnote">Shanker (2026), bellman-ddsl, applications/preliminary/ConsKinkedR/ConsKinkedR.bl; Example P of the working file.</div>

---

<div class="kicker p2">2 Natural transformations &middot; three questions</div>

## Is there a natural isomorphism between the two models?

1. A **natural isomorphism** is a natural transformation whose every component is an isomorphism (Riehl (2016), Definition 1.4.3). A natural transformation, and so a natural isomorphism, is defined only between functors with the same domain and codomain; ${D_f : \mathsf{F}Q_\Sigma \to \mathsf{Stoch}}$ and ${D_b : (\mathsf{F}Q_\Sigma)^{\mathrm{op}} \to \mathsf{Set}}$ share neither. So the answer is no.

<div class="sp-s"></div>

2. The two are related by the pairing ${\langle \mu K, v \rangle = \langle \mu, K^* v \rangle}$ at every path, a dinatural transformation for the reward-free backward model. With rewards the identity ${\langle \mu, D_b(e, \sigma)\, v \rangle = \langle \mu, r_{e,\sigma} \rangle + \beta_e \langle \mu K, v \rangle}$ is affine in $v$ and is not a dinaturality condition.

<div class="footnote">Riehl (2016), Definition 1.4.3, p. 25.</div>

---

<div class="kicker p2">2 Natural transformations &middot; three questions</div>

## Does a factorization of one model give one of the other?

1. **From forward to backward the answer is yes.** A factorization ${K = K_2 \circ K_1}$ of a kernel gives ${K^* = K_1^* \circ K_2^*}$ of its backward operator, and a grouping $\pi$ groups both models alike, as $D_f \circ \pi$ and $D_b \circ \pi^{\mathrm{op}}$.

<div class="sp-s"></div>

2. **From backward to forward it is not, in general.** In a cut ${T_\sigma = G_\sigma \circ F}$ the map $F$ may be any map of sets, for instance $Fv := v^3$ pointwise. A map between the bounded functions in $L^{X'}$ and in $L^X$ is the backward operator of a kernel exactly when it is linear, maps nonnegative functions to nonnegative functions, sends $1$ to $1$, and satisfies ${Tv_n \uparrow Tv}$ whenever ${v_n \uparrow v}$ uniformly bounded; the kernel is then ${K(x, B) = (T\mathbf{1}_B)(x)}$ (not proved here). The arrival map of Example F fails the third condition.

---

<div class="kicker p2">2 Natural transformations &middot; three questions</div>

## The coarsest cut of a stage as a backward operator

1. For a stage of a backward model, on value functions with finite integrals, ${T_\sigma v - T_\sigma v' = \beta_\sigma\, K_\sigma^*(v - v')}$, where $K_\sigma$ is the forward kernel of the stage path under $\sigma$ and $\beta_\sigma$ the product of the discount factors on that path; so $v \sim v'$ exactly when ${K_\sigma^* v = K_\sigma^* v'}$ for every $\sigma$.

<div class="sp-s"></div>

2. Under the bijection ${[v] \mapsto (K_\sigma^* v)_\sigma}$, the quotient map $q$ is the backward operator of the kernel ${J((\sigma, x), \cdot) := K_\sigma(x, \cdot)}$ on pairs (policy, arrival state), with its codomain restricted to its image.

<div class="sp-s"></div>

3. In the buffer-stock problem this is the income expectation, and the reduced model of Proposition 5 is itself a backward model on functions of savings.

---

<div class="kicker p2">2 Natural transformations &middot; three questions</div>

## Are the transformations of Propositions 4 to 6 natural isomorphisms?

1. In $\mathsf{Set}$ the isomorphisms are the bijections, so a transformation of Proposition 4, 5 or 6 is a natural isomorphism exactly when every component is a bijection. A component that is the backward operator of an invertible deterministic map is a bijection, as in the perfect-foresight application; a bijective backward operator need not be deterministic, since the stochastic matrix with rows $(0.9, 0.1)$ and $(0.1, 0.9)$ is invertible.

<div class="sp-s"></div>

2. In the buffer-stock problem the income expectation $D_b(\ell)$, and with it the quotient map $q$, is not injective when $\nu$ has a density: two value functions of cash that differ on a Lebesgue-null set have the same income expectation at every saving level. These transformations are then not natural isomorphisms, and their use is exactly that they discard what no policy operator can distinguish.

---

<!-- _class: title -->
<!-- _paginate: false -->

<p class="title-eyebrow">Part 3</p>

# 3. The Yoneda lemma

<p class="title-authors">The lemma &middot; Consequences &middot; Representability &middot; Policies are sections &middot; Policy insertion &middot; The lemma in this session</p>

---

<div class="kicker p3">3 The Yoneda lemma &middot; represented functors</div>

## The lemma

> [!definition] **Riehl's Definition 1.3.11** (represented functor).
> For a category $\mathsf{C}$ whose arrows between any two objects form a set (a **locally small** category) and an object $c$, the functor ${\mathsf{C}(c, -) : \mathsf{C} \to \mathsf{Set}}$ sends an object $x$ to the set $\mathsf{C}(c, x)$ of arrows from $c$ to $x$, and an arrow $f : x \to y$ to the map ${\mathsf{C}(c, x) \to \mathsf{C}(c, y)}$, $g \mapsto f \circ g$.

<div class="sp-s"></div>

> [!claim] **Riehl's Theorem 2.2.4** (Yoneda lemma).
> For every locally small category $\mathsf{C}$, every functor ${Y : \mathsf{C} \to \mathsf{Set}}$ and every object $c$, the map ${\alpha \mapsto \alpha_c(\mathrm{id}_c)}$ from the natural transformations ${\mathsf{C}(c, -) \Rightarrow Y}$ to the set $Yc$ is a bijection; in particular these transformations form a set. The bijection is natural in $c$ and in $Y$, a fact not used below.

<div class="sp-s"></div>

The proof in outline: naturality of $\alpha$ at $g : c \to d$, applied to $\mathrm{id}_c$, gives ${\alpha_d(g) = Y(g)(\alpha_c(\mathrm{id}_c))}$, so $\alpha$ is determined by the one element $\alpha_c(\mathrm{id}_c)$. Conversely, for every $u \in Yc$ the maps ${g \mapsto Y(g)(u)}$ form a natural transformation sending $\mathrm{id}_c$ to $u$. Degenerate case: in a preorder, $\mathsf{C}(c, x)$ is empty or a singleton, so such a transformation is one element $u \in Yc$ with its images.

<div class="footnote">Riehl (2016), Definition 1.3.11, p. 20; Theorem 2.2.4, p. 61; Example 2.2.1, p. 60 (the ordinal ω).</div>

---

<div class="kicker p3">3 The Yoneda lemma &middot; the Yoneda embedding</div>

## Consequences of the lemma

> [!claim] **Riehl's Corollary 2.2.8** (Yoneda embedding).
> Let $\mathsf{C}$ be locally small and $c, c'$ objects. The natural transformations ${\mathsf{C}(c, -) \Rightarrow \mathsf{C}(c', -)}$ correspond exactly to the arrows $f : c' \to c$: the arrow $f$ gives the transformation with components $g \mapsto g \circ f$, and every natural transformation arises from exactly one $f$. This is the lemma with $Y = \mathsf{C}(c', -)$, for which $Yc = \mathsf{C}(c', c)$ and ${Y(g)(f) = g \circ f}$.

<div class="sp-s"></div>

1. **An object is known, up to isomorphism, by the arrows out of it.** Let ${\alpha : \mathsf{C}(c, -) \Rightarrow \mathsf{C}(c', -)}$ be a natural isomorphism with inverse $\alpha^{-1}$; by the corollary $\alpha$ is precomposition with some $f : c' \to c$ and $\alpha^{-1}$ with some $h : c \to c'$. Then ${\alpha^{-1} \circ \alpha}$ and ${\alpha \circ \alpha^{-1}}$ are precomposition with $f \circ h$ and with $h \circ f$, both are identities, and uniqueness gives ${f \circ h = \mathrm{id}_c}$, ${h \circ f = \mathrm{id}_{c'}}$: $c \cong c'$.

<div class="sp-s"></div>

2. **Natural operations on arrows are compositions.** A family of maps ${\Phi_x : \mathsf{C}(c, x) \to \mathsf{C}(c', x)}$ with ${\Phi_y(k \circ g) = k \circ \Phi_x(g)}$ for all $g : c \to x$ and $k : x \to y$ is precomposition with the one arrow $\Phi_c(\mathrm{id}_c) : c' \to c$.

<div class="footnote">Riehl (2016), Corollary 2.2.8, p. 64, stated there as: c ↦ C(c, −) is a full and faithful functor from C<sup>op</sup> to the functors C → Set (Definition 1.5.7, p. 32); Proposition 2.3.1, p. 67.</div>

---

<div class="kicker p3">3 The Yoneda lemma &middot; representability</div>

## Representability

1. An element $u \in Yc$ is a **universal element** when the transformation ${g \mapsto Y(g)(u)}$ of the lemma is a natural isomorphism ${\mathsf{C}(c, -) \cong Y}$; then $c$ **represents** $Y$, and for every object $x$ the elements of $Yx$ correspond exactly to the arrows $c \to x$ (Riehl (2016), Definitions 2.1.4 and 2.3.4).

<div class="sp-s"></div>

2. **Session A.** The forgetful functor ${\mathsf{U}_{\mathsf{End}} : \mathsf{End} \to \mathsf{Set}}$ is represented by $(\mathbb{N}, s)$ with universal element $0$: the transformation of the lemma has, at $(X, g)$, the component sending a trajectory ${h : (\mathbb{N}, s) \to (X, g)}$ to its initial condition $h(0)$, and it is a bijection because every $x \in X$ is $h(0)$ for exactly one $h$, namely $h(n) = g^n(x)$ (Riehl (2016), Example 2.4.11).

<div class="sp-s"></div>

3. The natural transformations ${\mathsf{End}((\mathbb{N}, s), -) \Rightarrow \mathsf{U}_{\mathsf{End}}}$ are exactly the maps $h \mapsto h(n)$ that read a trajectory at a fixed date $n$, by the lemma applied to the elements $n \in \mathbb{N}$; only $n = 0$ gives an isomorphism, since for $n \ge 1$ two trajectories of a constant map agree at $n$ without agreeing at $0$.

<div class="footnote">Riehl (2016), Definition 2.1.4, p. 55; Definition 2.3.4, p. 69; Example 2.4.11, p. 76.</div>

---

<div class="kicker p3">3 The Yoneda lemma &middot; policies</div>

## Policies are sections

Let $S$ be a set of states, $\mathcal{D}(s)$ the nonempty set of actions allowed at $s$, ${E := \{(s, b) : s \in S,\ b \in \mathcal{D}(s)\}}$, and ${p : E \to S}$, $p(s, b) := s$. A **section** of $p$ is a map ${\iota : S \to E}$ with ${p \circ \iota = \mathrm{id}_S}$; every section is ${\iota_\sigma(s) = (s, \sigma(s))}$ for a feasible policy $\sigma$, so sections are exactly the feasible policies, the selections from $\mathcal{D}$.

<div class="sp-s"></div>

> [!claim] **Proposition 10.**
> For each set $Z$ let ${\Phi_Z : \mathsf{Set}(E, Z) \to \mathsf{Set}(S, Z)}$ be a map, and suppose the family is **natural in the value set**: ${\Phi_{Z'}(\lambda \circ w) = \lambda \circ \Phi_Z(w)}$ for every map $\lambda : Z \to Z'$ and every $w : E \to Z$. Then there is exactly one ${\iota : S \to E}$ with ${\Phi_Z(w) = w \circ \iota}$ for every $Z$ and $w$, namely ${\iota = \Phi_E(\mathrm{id}_E)}$; and $\iota$ is a section of $p$ if and only if ${\Phi_S(p) = \mathrm{id}_S}$.

<div class="sp-s"></div>

*Proof.* The equation says that $\Phi$ is a natural transformation ${\mathsf{Set}(E, -) \Rightarrow \mathsf{Set}(S, -)}$. $\mathsf{Set}$ is locally small, so Riehl's (2016) Corollary 2.2.8 with $c = E$ and $c' = S$ gives exactly one $\iota$ with $\Phi_Z(w) = w \circ \iota$, and the lemma gives ${\iota = \Phi_E(\mathrm{id}_E)}$. With $Z = S$ and $w = p$, ${\Phi_S(p) = p \circ \iota}$, which is $\mathrm{id}_S$ exactly when $\iota$ is a section. $\blacksquare$

---

<div class="kicker p3">3 The Yoneda lemma &middot; policies</div>

## Policy insertion

<div class="cols" style="grid-template-columns: 1fr 440px; gap: 1.2em; align-items: center;">
<div>

Suppose the state space of the target of a decision edge is the set $E$ of feasible pairs and that of its source is $S$. In the reward-free backward model the decision operator is ${w \mapsto w \circ \iota_\sigma}$, precomposition with the section ${\iota_\sigma(s) = (s, \sigma(s))}$: inserting a policy is natural in the value set.

<div class="sp-s"></div>

In the buffer-stock declaration the target is savings alone, and ${w \circ \sigma = (w \circ \mathrm{pr}_A) \circ \iota_\sigma}$ with ${\mathrm{pr}_A(m, a) := a}$.

</div>
<div class="center">

![w:420](assets/fs-section.svg)

</div>
</div>

The diagram asserts ${p \circ \iota = \mathrm{id}_S}$; if $w(s, b)$ is the value of taking action $b$ in state $s$, then ${(w \circ \iota_\sigma)(s) = w(s, \sigma(s))}$ is the value of following $\sigma$ at $s$.

---

<div class="kicker p3">3 The Yoneda lemma &middot; the lemma in this session</div>

## The lemma in this session

1. **The initial system of Session A.** $(\mathbb{N}, s, 0)$ is initial among discrete dynamical systems and $(\mathsf{F}Q, \eta)$ among interpretations (Proposition 1); neither proof uses the lemma. The lemma adds that $(\mathbb{N}, s, 0)$ is initial among the pairs of a system and a point of it exactly when $0$ is a universal element (Riehl (2016), Proposition 2.4.8). For $(\mathsf{F}Q, \eta)$ the lemma is not applied, because interpretations in $\mathsf{Set}$ and $\mathsf{Stoch}$ belong to a category of categories that is not locally small.

<div class="sp-s"></div>

2. **Policy insertion.** The families ${\mathsf{Set}(E, Z) \to \mathsf{Set}(S, Z)}$ natural in $Z$ are exactly the precompositions with maps $S \to E$, and those sending $p$ to $\mathrm{id}_S$ are precompositions with sections (Proposition 10). The reward-free decision operator ${w \mapsto w \circ \iota_\sigma}$ has this form; the policy operator $T_\sigma$, which adds a reward and takes an expectation, does not.

<div class="sp-s"></div>

3. **Expectation is not natural in the value set.** It fails the naturality equation for $\lambda(z) := z^2$: averaging $0$ and $2$ and then squaring gives $1$, squaring and then averaging gives $2$. Since a probability integrates to one, expectation commutes with every affine map, so it is natural once the value maps are restricted to affine maps.

<div class="footnote">Riehl (2016), Proposition 2.4.8, p. 75; Example 2.4.11, p. 76; Cat, the category of small categories, p. 21.</div>

---

<div class="kicker p3">3 The Yoneda lemma &middot; the lemma in this session</div>

## The form of a rule

1. A **bifunctor** ${P : \mathsf{C}^{\mathrm{op}} \times \mathsf{C} \to \mathsf{Set}}$ assigns a set $P(c, c')$ to each pair of objects and, to arrows $f : b \to c$ and $g : c' \to b'$, a map ${P(f, g) : P(c, c') \to P(b, b')}$, respecting identities and composites; the hom bifunctor $\mathsf{C}(-, -)$, with ${\mathsf{C}(f, g)(h) = g \circ h \circ f}$, is the example (Riehl (2016), Definition 1.3.13).

<div class="sp-s"></div>

2. For a locally small $\mathsf{C}$ and objects $c_0, c_1, c_2, c_3$, a **rule** (not a decision rule) is a family of maps ${\alpha_P : P(c_1, c_2) \to P(c_0, c_3)}$, one for each bifunctor $P$, with ${\kappa_{(c_0, c_3)} \circ \alpha_P = \alpha_{P'} \circ \kappa_{(c_1, c_2)}}$ for every natural transformation $\kappa : P \Rightarrow P'$.

<div class="sp-s"></div>

3. **Proposition 11 of the companion note.** Every rule is ${\alpha_P = P(F, U)}$ for exactly one pair of arrows $F : c_0 \to c_1$ and $U : c_2 \to c_3$, by the argument of the lemma applied to the bifunctor ${\mathsf{C}(-, c_1) \times \mathsf{C}(c_2, -)}$ and its element $(\mathrm{id}_{c_1}, \mathrm{id}_{c_2})$. The proof needs $\mathsf{C}$ only locally small, so $\mathsf{C} = \mathsf{Set}$ is admitted. On the hom bifunctor the rule sends ${G : c_1 \to c_2}$ to $U \circ G \circ F$, so the stage form is the form of every rule, applied to each decision operator $G_\sigma$ with the same $F$ and $U$.

<div class="footnote">Riehl (2016), Definition 1.3.13, p. 21 (the two-sided represented functor); Theorem 2.2.4, p. 61; p. 64 on locally small domains.</div>

---

<div class="kicker p3">3 The Yoneda lemma &middot; the lemma in this session</div>

## Stage-by-stage construction and the lemma

1. **Informal.** Studying a declaration through all its models resembles the viewpoint of the lemma, in which an object is determined up to isomorphism by the arrows out of it (Riehl (2016), Proposition 2.3.1); no result of this session makes the resemblance precise.

<div class="sp-s"></div>

2. A model ${D : \mathsf{F}Q_\Sigma \to \mathsf{C}}$ is determined by its values on fields and edges (Proposition 1), and a family of arrows ${\varphi_j : D(j) \to D'(j)}$, one at each field, is a natural transformation ${D \Rightarrow D'}$ as soon as ${D'(e, \sigma) \circ \varphi_j = \varphi_i \circ D(e, \sigma)}$ for every edge, by pasting; restricting along a grouping $\pi$ gives the natural transformation ${D \circ \pi \Rightarrow D' \circ \pi}$ with the same components at the boundaries.

<div class="sp-s"></div>

3. Propositions 10 and 11 then characterize the operations inside a stage that are natural in two further senses, in the value set and in the bifunctor: precomposition with a section, and composition with fixed maps before and after.

---

<div class="kicker p3">3 The Yoneda lemma &middot; the lemma in this session</div>

## What the lemma does not do

1. Proposition 11 does not select a factorization of a given family: $F = \mathrm{id}$ and $U = \mathrm{id}$ with $G_\sigma = T_\sigma$ is one.

<div class="sp-s"></div>

2. The quotient map $q$ of the coarsest cut comes from Theorem 7, whose proof uses quotients of sets and not the lemma.

<div class="sp-s"></div>

3. By Proposition 6, $q$ is the coarsest admissible component, at one field, of a natural transformation of models.

---

<!-- _class: title -->
<!-- _paginate: false -->

<p class="title-eyebrow">Part 4</p>

# 4. Next steps

<p class="title-authors">Several inputs &middot; Dimension &middot; Choosing the grouping &middot; Branching</p>

---

<div class="kicker p4">4 Next steps &middot; open problems</div>

## Several inputs and branching

1. **Several inputs.** An equation that reads several fields is not an edge of a graph. The signature then needs symbols with several inputs, interpreted with a product of state spaces: the cartesian product in $\mathsf{Set}$, and the product of measurable spaces in $\mathsf{Stoch}$, which is not a product in the sense of category theory there, because a kernel into ${X \times Y}$ is not determined by its two marginals.

<div class="sp-s"></div>

2. The stage file's arrival equation ${m = Rk/(\Gamma\psi) + \xi}$ is one edge when its shocks are integrated into its kernel, and reads three fields only if $\psi$ and $\xi$ are declared as fields.

<div class="sp-s"></div>

3. **Branching.** A discrete choice among continuations, as in Session A's housing model, is a decision whose value equation reads several fields, so it needs the symbols of item 1.

<div class="footnote">Fritz (2020), Example 2.5, pp. 13–14, on the product in Stoch.</div>

---

<div class="kicker p4">4 Next steps &middot; open problems</div>

## Dimension and the choice of grouping

1. **Dimension.** In the buffer-stock problem the quotient map $q$ sends a value function of cash to its income expectation, a function of savings; both are functions of one variable, and the gain is only that the reduced model works with the post-decision state. Which declarations give coarsest cuts on functions of fewer variables than the state is not examined here.

<div class="sp-s"></div>

2. **Choosing the grouping.** A rotation of a closed term gives operators related by a natural transformation under every model (Proposition 4), and an exchange of two symbols does not. Every staging has one stage per decision edge; among the $\prod_k (n_k + 1)$ stagings one may seek those with the fewest distinct stage terms, or, where the carriers are vector spaces, those whose coarsest cuts have the smallest dimension. Neither criterion is examined here.

---

<div class="kicker">References</div>

## References

- Fritz, Tobias (2020). "A Synthetic Approach to Markov Kernels, Conditional Independence and Theorems on Sufficient Statistics." *Advances in Mathematics* 370, 107239; arXiv:1908.07021, pages of the arXiv version.
- Riehl, Emily (2016). *Category Theory in Context*. Dover.
- Sargent, Thomas J., and John Stachurski (2026). *Dynamic Programming, Volume II: General States*, draft of 10 April 2026.
- Shanker, A. (2026). *Factoring dynamic programs: semi-conjugate sliders*, talk, `bellman-ddsl/AI/dev-docs/presentation/abstract-programs/abstract-programs-talk.md`. The Bellman-core theory note `bellman-ddsl/AI/dev-docs/theory/semantics/bellman-core-theory.md`; the stage file `bellman-ddsl/applications/buffer-stock/buffer_stock.bl`; the portfolio application (`bellman-ddsl/applications/portfolio-choice/port.bl`, `cons.bl` and `disc.bl`) and its trellis `bellman-ddsl/applications/cons-port/trellises/port-cons.yml`; the stage files `bellman-ddsl/applications/preliminary/ConsPerfForesight_simple/ConsPerfForesight_simple.bl` and `bellman-ddsl/applications/preliminary/ConsKinkedR/ConsKinkedR.bl`.

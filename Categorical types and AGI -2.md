---
marp: true
title: Categorical types and AGI 2
theme: econ-ark-cat
paginate: true
math: katex
---

<!-- Slide set 2. Started 13 Aug 2026 by moving "Represented functors" and
     "Additional properties of functors" out of "Categorical types and AGI -1.md".
     Two references in the moved slides point back at talk 1 material and will
     need restating here: Lemma 1.2.3 (isomorphisms via post/precomposition)
     and the ℝ^(−) application slides. Build:
     marp "Categorical types and AGI -2.md" --theme-set theme/econ-ark-cat.css -o out.pdf --allow-local-files -->

<!-- _class: title -->

<p class="title-eyebrow"><span class="keep-case">𝕋v = v</span> Reading Group</p>

# Categorical types and AGI

## 2. Functors and universality

<p class="title-authors">Akshay Shanker<span class="title-date">TBD</span></p>

---

<div class="kicker p2">Category theory &middot; Riehl §1.3</div>

## Contravariant functors

A **contravariant** functor is a functor $\mathsf{C}^{\mathrm{op}} \to \mathsf{D}$. The application slides of talk 1 used one such functor, $\mathbb{R}^{(-)}$, which reverses the direction of the state transition.

<div class="footnote">Riehl (2016), Definition 1.3.5, §1.3, p. 17.</div>

---

<div class="kicker p2">Category theory &middot; Riehl §1.3</div>

## Represented functors

> "…every sufficiently good analogy is yearning to become a functor." — John Baez, epigraph to §1.3

<div class="defbox">

**Definition 1.3.11.** For locally small $\mathsf{C}$ and $c \in \mathsf{C}$: the covariant represented functor $\mathsf{C}(c, -) : \mathsf{C} \to \mathsf{Set}$ sends $x \mapsto \mathsf{C}(c, x)$ and $f \mapsto f_{*}$; the contravariant $\mathsf{C}(-, c) : \mathsf{C}^{\mathrm{op}} \to \mathsf{Set}$ sends $f \mapsto f^{*}$.

</div>

Postcomposition is always covariant, and precomposition is always contravariant. The functor $\mathbb{R}^{(-)}$ of the closing application slides is the measurable-space analogue of the represented functor $\mathsf{Set}(-, \mathbb{R})$: it sends a measurable space $X$ to the bounded measurable functions on $X$ and a map to precomposition, exactly the pattern of Definition 1.3.11.

Applying "functors preserve isomorphisms" to the represented functors re-proves (i) ⇒ (ii) and (i) ⇒ (iii) of Lemma 1.2.3.

<div class="footnote">Riehl (2016), §1.3: Definition 1.3.11 and the covariance remark (p. 20); Baez epigraph (p. 14).</div>

---

<div class="kicker p2">Category theory &middot; Riehl §1.3</div>

## Additional properties of functors

- **Bifunctoriality** (Definitions 1.3.12–1.3.13). The product $\mathsf{C} \times \mathsf{D}$ is formed componentwise, and the two represented functors combine into one **bifunctor** — a functor of two variables — $\mathsf{C}(-, -) : \mathsf{C}^{\mathrm{op}} \times \mathsf{C} \to \mathsf{Set}$, acting on morphisms by $g \mapsto h g f$.
- **Preservation.** Split monomorphisms and epimorphisms — those admitting a one-sided inverse — are preserved, because a one-sided inverse is an equation between composites and functors preserve such equations. General monomorphisms and epimorphisms need not be preserved.
- **$\mathsf{Cat}$.** Small categories and functors form a category $\mathsf{Cat}$, which is locally small but not small. The size distinctions of §1.1 return.

<div class="footnote">Riehl (2016), §1.3: Definitions 1.3.12–1.3.13 (p. 21); preservation of split monomorphisms and epimorphisms (p. 20); Cat (p. 21).</div>

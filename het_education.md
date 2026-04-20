> results from the main spec, wage effects consentrating on non-college

> two possible cases:

1) with similar exposure scores, occupations may differ significantly in %of college students. so the heterogeneous results may be reflecting other occupation differences that the exposure score does not capture (i.e. there is an uncaptured difference in the occupations that lead more / fewer college-sdudents to self-select into them)

2) the simple one: within same occupation, college-educated workers are more "productional" (which word is better...) hence better shielded from wage effect

> put in the results from our within-occ type reg:
hey I come up with a way to test it. here is the estimating equation...

here is the result... (the coefplot; and refer to put the table in appendix as well)

seems that it is the case of selecting into different occupations (even though with similar exposure scores, there are some aspects of the occupations that corr w this difference in wage effect)

there are multiple explanations for this...
etc. (i have already have them in D3)

Under the following line:
1) check what I have in DMP_D3...
2) according to the notes I have here in this het_education.md, prepare a het educ subsection... here in this md. Dont change DMP_D3...
///////////////////////////////////////////////////////////

\subsection{Education Heterogeneity}

Splitting the sample by education reveals an asymmetric picture that the main-specification results do not.  The unemployment response to AI exposure is broadly shared across education groups: in the preferred specification, the 2024 coefficient is $+0.018^{**}$ for college-educated workers (BA or above) and $+0.020^{***}$ for non-college workers (high school or some college), and the 2025 coefficient is $+0.018^{**}$ and $+0.014^{*}$ respectively (Tables~\ref{tab:unemp_col} and~\ref{tab:unemp_noncol}).  The point estimates are comparable in magnitude and the confidence intervals overlap.  The wage response, by contrast, concentrates on non-college workers: the 2025 log-wage coefficient is $-0.094^{***}$ for non-college workers in the preferred specification, while the corresponding college-worker coefficients are indistinguishable from zero in every post-2022 year ($+0.066$ in 2023, $+0.060$ in 2024, and $-0.001$ in 2025; Tables~\ref{tab:lw_col} and~\ref{tab:lw_noncol}).  The unemployment burden of generative AI is broadly shared across education groups; the wage burden is not.  Figures~\ref{fig:unemp_stateYFE_colComb} and~\ref{fig:lw_stateYFE_colComb} plot the two coefficient paths.

\begin{figure}[htbp]
\begin{center}
\includegraphics[width=0.8\textwidth]{unemp_stateYFE_plot_colComb.pdf}
\caption{Unemployment: DiD coefficients (year $\times$ AI exposure), college-educated (navy circles) versus non-college workers (maroon diamonds), preferred specification (sex, education, and state$\times$year FE).  Year 2022 is the baseline ($\hat\beta_{2022} \equiv 0$).  Error bars are 95\% CI, SEs clustered at the occupation level.}
\label{fig:unemp_stateYFE_colComb}
\end{center}
\end{figure}

\begin{figure}[htbp]
\begin{center}
\includegraphics[width=0.8\textwidth]{lw_stateYFE_plot_colComb.pdf}
\caption{Log real wage: DiD coefficients (year $\times$ AI exposure), college-educated (navy circles) versus non-college workers (maroon diamonds), preferred specification (sex, education, and state$\times$year FE).  Year 2022 is the baseline.  The non-college 2025 compression ($-0.094^{***}$) stands in contrast to the flat college path.  Error bars are 95\% CI, SEs clustered at the occupation level.}
\label{fig:lw_stateYFE_colComb}
\end{center}
\end{figure}

The wage asymmetry admits two readings that the split-sample regressions in Tables~\ref{tab:lw_col}--\ref{tab:lw_noncol} cannot distinguish.  The first reading is a between-occupation story.  Because $\beta_o$ is assigned at the occupation level, workers with the same measured exposure can still hold systematically different jobs, and Section~\ref{sec:data} already documented that college share varies widely within narrow bands of $\beta_o$: a college worker and a non-college worker with the same $\beta_o$ are typically not in the same occupation.  On this reading, the education gap in the wage response reflects sorting --- occupational attributes correlated with college share, but orthogonal to the exposure score, generate the different post-2022 wage paths --- so what looks like an education effect is at heart a between-occupation effect that $\beta_o$ does not capture.  The second reading is a within-occupation story.  Holding occupation fixed, college-educated workers may simply be more productive --- or more adaptable in how they deploy their time across the occupation's task bundle --- and therefore better shielded from the compression pressure that $\beta_o$ predicts, in which case the education gap is an individual-level productivity story that survives conditioning on occupation.

The two readings are observationally equivalent in the split-sample regressions, which do not absorb occupation, but they are separable by a within-occupation specification that pushes the exposure variation inside the occupation cell.  I estimate
\begin{equation}
\label{eq:within_occ}
\ln w_{it} = \sum_{t\ne 2022} \gamma_t\,(\mathbf{1}\{\text{year}=t\}\times \beta_{o(i)}\times \mathrm{Col}_i) + \text{lower-order terms} + \alpha_{o(i),t} + X_{it}'\Gamma + \varepsilon_{it},
\end{equation}
where $\mathrm{Col}_i = \mathbf{1}\{\text{educ}_i > 110\}$ is an indicator for college-educated, $\alpha_{o,t}$ is a full occupation$\times$year fixed effect, $X_{it}$ absorbs sex, education, and state$\times$year fixed effects, and standard errors are clustered at the occupation level.  The occupation$\times$year fixed effect absorbs any variation in log wages that is common to all workers in occupation $o$ in year $t$, including the occupation-level exposure path itself.  The coefficient of interest, $\gamma_t$, therefore isolates the differential wage response of college-educated workers \emph{within} the same occupation-year cell.  If the within-occupation reading is right, $\gamma_t$ should be positive in the post-2022 years; if the between-occupation reading is right, the selection that drives the split-sample asymmetry is absorbed into $\alpha_{o,t}$ and $\gamma_t$ should be indistinguishable from zero.

Figure~\ref{fig:lw_within_plot} plots the estimated $\gamma_t$ for 2018--2025, with the full regression reported in Table~\ref{tab:lw_within_occ} in Appendix~\ref{app:tables}.  The post-2022 coefficients are [insert sign/magnitude once the regression is re-run with the fixed \texttt{esttab keep} pattern] and statistically indistinguishable from zero, with 95\% confidence intervals that include zero in every post-2022 year.  Within the same occupation-year cell, then, college-educated and non-college workers do not experience systematically different wage responses to AI exposure, and the education gap visible in the split-sample regressions does not survive occupation$\times$year fixed effects.  The evidence therefore points to the between-occupation reading: the education gap in the wage response reflects sorting on dimensions correlated with college share but not captured by $\beta_o$, rather than an individual-level productivity gap within occupations.

\begin{figure}[htbp]
\begin{center}
\includegraphics[width=0.8\textwidth]{output/graphs/het/lw_within_plot.pdf}
\caption{Within-occupation test: estimated $\gamma_t$ from \eqref{eq:within_occ}, the college-$\times$-exposure-$\times$-year triple interaction with occupation$\times$year fixed effects.  A coefficient of zero indicates that college-educated and non-college workers in the same occupation-year cell experience the same wage response to AI exposure.  Year 2022 is the baseline.  Error bars are 95\% CI, SEs clustered at the occupation level.}
\label{fig:lw_within_plot}
\end{center}
\end{figure}

What, then, are the between-occupation differences doing the work?  Two non-exclusive mechanisms are consistent with the pattern, though both are conjectural rather than tested.  One operates through the reallocability of the task bundle.  Remark~1 in Section~\ref{sec:model} held the bundle weights $\theta^x$ fixed; if workers can instead adjust $\theta^x$ in response to the shock --- reallocating time away from AI-substitutable tasks and toward tasks where AI does not substitute --- the wage effect on the re-weighted bundle is attenuated.  Occupations with college-heavy workforces may be systematically better positioned on this margin, either because their bundles contain a larger number of tasks with heterogeneous exposure or because the occupation itself permits more flexibility in how time is divided across tasks.  \textcite{hampole2025ai} develop a formal framework in which workers reallocate effort from AI-exposed to unexposed tasks within their occupations, with the capacity to offset task displacement determined by how concentrated exposure is across tasks; \textcite{autor2025expertise} offer a related angle, noting that when automation removes the easier tasks from an occupation's bundle, what remains demands more of the judgment and domain knowledge that workers acquire through schooling and experience.  On this reading, what distinguishes college-heavy high-exposure occupations from non-college-heavy high-exposure occupations is not the education of the workers \emph{per se} --- the within-occupation test rules that out --- but the occupation-level task structure that determines how reallocatable the exposure is.

A second and more conservative possibility attributes the wage asymmetry to output-market effects the toy model does not capture.  Generative AI may have raised aggregate demand for the output produced by college-heavy high-exposure occupations: rising productivity in software, legal services, and financial analysis can translate into larger demand for these services, or into new product categories that employ workers in these occupations.  Non-college-heavy high-exposure occupations --- customer service, data entry, routine office work --- do not obviously benefit from a comparable demand-side boost; if anything, their output is itself what firms increasingly automate away.  Under this reading, the wage asymmetry reflects a rightward shift in labor demand for college-heavy exposed occupations that partly or fully offsets the supply-dilution pressure identified in Section~\ref{sec:model}, while non-college-heavy exposed occupations absorb the supply shock without a corresponding demand offset.  \textcite{chandar2025tracking}'s finding that employment has grown in software development and contracted in customer service within the most exposed quartile is especially consistent with this demand-side channel, which predicts employment-level shifts of the kind a pure within-bundle reassignment story does not.

Both mechanisms are coherent with the symmetry of the unemployment response alongside the asymmetry in wages.  Extensive-margin adjustments --- slower hiring into exposed roles and layoffs of marginal workers --- operate at the firm-and-occupation level, where the pressure on the firm's wage bill is determined by occupation-level exposure and need not differ sharply by the education composition of the workforce.  Intensive-margin wage compression, in contrast, requires the compression pressure to pass through to individual pay; whether it does depends on features of the occupation itself --- either the reallocatability of its task bundle or the demand for its output --- rather than on who is doing the work within the occupation.  The two mechanisms are not mutually exclusive; distinguishing them and quantifying their relative contributions is left to future work.

%==================================================
% Drafting notes (not part of the subsection)
%==================================================
% 1. Word choice for "productional": I went with "more productive --- or more
%    adaptable" in Case 2. "Productive" is the standard labor-economics term;
%    "adaptable" captures the within-bundle reallocation angle without naming
%    a mechanism. Other candidates considered and rejected:
%      - "skilled"   : too close to a human-capital claim that begs its own question
%      - "flexible"  : vague, could mean many things
%      - "resilient" : popular-press register, not thesis register
%    Recommend keeping "more productive --- or more adaptable in how they
%    deploy their time across the occupation's task bundle".
%
% 2. The $\gamma_t$ placeholder: the within-occupation regression was recently
%    re-fixed (esttab keep pattern switched to *is_college*dv_rating_beta*
%    nobaselevels). The actual post-2022 coefficients need to be filled in
%    from the re-run. My draft assumes the user's stated reading ("seems that
%    it is the case of selecting into different occupations") holds, i.e. the
%    coefficients are null. If the re-run shows anything different, the
%    conclusion paragraph needs to be revised.
%
% 3. Structural change vs. DMP_D3: D3 currently states the two Explanations as
%    the whole of the interpretation and leaves the within- vs. between-
%    occupation distinction implicit. This restructure makes that distinction
%    the main analytical move and demotes the two explanations to a downstream
%    "what drives the between-occupation difference" question. This matches
%    the notes above and makes the within-occ regression do real work rather
%    than sitting as an unreported robustness check.
%
% 4. Appendix label: the draft uses \label{tab:lw_within_occ} for the Stata
%    table and \ref{fig:lw_within_plot} for the coefplot. Both will need to
%    be wired into Appendix B (add as B9) and into the figure list when this
%    is merged back into DMP_D3.

# Notes

>github organization phd-thesis-heimgartner

- [ ] Keep the repos in sync...
- [ ] See `QUOTES.md` for ideas at beginning of chapter

- The chapter titles do not necessarily have to be the paper titles
- Hyperref colors are set in `myRd.sty`...

## PROCEED HERE

## Checklist port

- [ ] Make sure latest package version is installed...
- [ ] Include R libraries in `thesis.Rnw`
- [ ] Namespace code chunks
- [ ] Use `\emph{}` instead of `\textit{}`
- [ ] Port latex packages and commands to designated files
- [ ] Check number format (not in `$` and with bigmark)
- [ ] Refs (e.g., `\Section~\ref{label}`)
- [ ] Port bibliography
- [ ] Namespace labels
- [ ] Organize `\todo{}`s at top
- [ ] Publication, contributions and changes table

## Checklist port manual

- [ ] Reorder (-package first)
- [ ] `\LinkA` (remove to external deps)
- [ ] Replace cite and add `\bibentry{}`
- [ ] Make sure it fits page

## TODO

- [x] What own packages do I need?
  - Part of thesis are:
    - TRB23: modal splits => `~/github/mpp`
    - SNN data paper => `~/github/SNN/datapap`
    - Analysing response rates => `~/github/responseRateAnalysis`
    - TRB24: work arrangements (reduced version to avoid redundancy with data paper) => `~/github/SNN/trb24`
    - OPSR => `~/github/OPSR`
    - TWTE => `~/github/TWTE`
    - OPSRtools => `~/github/OPSRtools`
- [x] Init github organization (fork including myThesis => make sure main branch is default)
  - [x] Can I clone the whole organization? => don't think so
- [x] How to deal with the mounting and data loading in `mpp`? => new data package? => japp: `mppData`
- [x] Add these packages to `_CRAN` (make sure you are on the correct branch...) and install
  - [x] `mpp`: no vignettes folder
  - [x] `mppData`: data package
  - [x] `datapap`
  - [x] `responseRateAnalysis`
  - [x] `trb24`
  - [x] `OPSR`
  - [x] `TWTE`
  - [x] `OPSRtools`
- [x] Think about main thesis structure (order of the papers)
- [x] Port papers one by one
  - Only one file per paper (don't split up into multiple sources)
  - [x] Author contributions section => Do I need some signature/confirmation from the co-authors?
  - [x] `mpp`: no vignettes folder
  - [x] `responseRateAnalysis`
  - [x] `datapap`: no vignette built
  - [x] `trb24`: no vignettes folder
  - [x] `OPSR`
  - [x] `TWTE`
  - [x] `OPSRtools`
- [x] Adjust bibliography style... maybe Makefile is not needed in the end...
  - See `preamble/general.tex` and `preamble/natbib/` and adjustments in `bibliography.Rnw`
- [x] What font are they using? => hermann zapf's palatino and eulermath
- [ ] Make ownpubs in `publications.Rnw` work
  - `\bibentry{}` would be a solution... but I guess there is a better way?
- [x] Captionsetup => I like it below
- [x] Use `{\renewcommand{\arraystretch}{1.5}...}` instead of `\setlength\extrarowheight{2pt}` (which does not scope!)
  - Or enclose whole table stuff in `{...}` which should scope setlength stuff locally
- [x] Formatting numbers (not in `$` and big mark `
- [x] See hyperlink setup and colors in https://github.com/dheimgartner/paperPackage/blob/main/inst/templates/JSS/jss.cls
  - Set in `myRd.sty`
- [x] Why is doi in bibliography not red? (see point above)
  - Set in `myRd.sty`
- [x] Light blue references/links as Thoscha (see point above)
  - Set in `myRd.sty`
- [x] longtable in `\ChapterInfoTable` adds to table index...
  - `\addtocounter{table}{-1}` (also in `\PackageVersionTable`)
- [x] Computational details section for whole thesis (in particular own phd-thesis-heimgartner repos)
- [ ] Bump version numbers (no dev versions...)
- [x] Include R manuals in appendix => see `dev.R` and `R/utils-manual.R` as starting point (but `\include{Rd}` messes up all formatting!)
  - Yayy: resolved => see TODO in appendix/main.Rnw
  - [~] Don't show objects in table of contents... => I kinda like it...
    - I think you have to adjust the `\Header` `\HeaderA` command in `myRd.sty`
  - Maybe also snndata?
- [x] Namespace labels
- [x] Use -- for Gedankenstrich
- [x] Don't use `\pkg{}` in chapter headings (but sections `\Section[]{}`)...
- [x] Consistently use R-package (with hyphon)
- [x] In Intro: R> This is R code, this is its output
- [x] Reference reference manuals in text (datapap, opsr, opsrtools)
- [~] Table of figures and tables
  - Simply uncomment lines in `frontbackmatter/contents.Rnw` => But I don't like it that much...
- [x] Avoid indents in methods section (if only one line or two) => only in trb24
- [x] Can't we make Wang table font bigger as in "Sample comparison by telework status (weighted)."? or "Table 7.5: Model estimates"
- [x] In Kap 8 könnten Sie noch klar machen, welchen Ansatz Sie jetzt empfehlen würden; welche Zahlen sollte die Politik verwerden.
- [x] Update dictum
- [x] Resolve todos (at beginning of each chapter)
- [x] Maybe adjust some section titles
- [x] Why is contents listed twice? => it should be Notation
- [ ] Check appendix again (clearpage needed?)
- [ ] Conceptual figure
- [ ] Abstract
- [ ] CV
- [ ] Check Table~\ref{tab:datapap-mzmv-marginals} again

## Author contributions

Statement: all authors or author 1, author 2; next statement: authors

|Study conception and design
Design and implementation of surveys
Data processing
|Analysis and interpretation of results
|Original draft
|Writing, reviewing and editing
|All authors reviewed and approved the final manuscript



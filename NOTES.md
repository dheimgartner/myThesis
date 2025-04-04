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
- [ ] Port papers one by one
  - Only one file per paper (don't split up into multiple sources)
  - [x] Author contributions section => Do I need some signature/confirmation from the co-authors?
  - [x] `mpp`: no vignettes folder
  - [x] `responseRateAnalysis`
  - [x] `datapap`: no vignette built
  - [x] `trb24`: no vignettes folder
  - [ ] `OPSR`
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
- [ ] Formatting numbers (not in `$` and big mark `
- [x] See hyperlink setup and colors in https://github.com/dheimgartner/paperPackage/blob/main/inst/templates/JSS/jss.cls
  - Set in `myRd.sty`
- [x] Why is doi in bibliography not red? (see point above)
  - Set in `myRd.sty`
- [x] Light blue references/links as Thoscha (see point above)
  - Set in `myRd.sty`
- [ ] longtable in `\ChapterInfoTable` adds to table index...
- [ ] Computational details section for whole thesis (in particular own phd-thesis-heimgartner repos)
- [x] Include R manuals in appendix => see `dev.R` and `R/utils-manual.R` as starting point (but `\include{Rd}` messes up all formatting!)
  - Yayy: resolved => see TODO in appendix/main.Rnw
  - [ ] Don't show objects in table of contents...
    - I think you have to adjust the `\Header` `\HeaderA` command in `myRd.sty`
  - Maybe also snndata?
- [ ] Use --- for Gedankenstrich and separation (- for compound words, -- for ranges, --- for Gedankenstrich)
- [ ] Don't use `\pkg{}` in chapter headings (but subheadings?)...
- [x] Consistently use R-package (with hyphon)
- [x] In Intro: R> This is R code, this is its output
- [ ] Table of figures and tables
- [ ] Reference reference manuals in text (datapap, opsr, opsrtools)

## Author contributions

Statement: all authors or author 1, author 2; next statement: authors

|Study conception and design
Design and implementation of surveys
Data processing
|Analysis and interpretation of results
|Original draft
|Writing, reviewing and editing
|All authors reviewed and approved the final manuscript



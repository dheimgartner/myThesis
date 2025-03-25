# Notes

>github organization phd-thesis-heimgartner

- [ ] Keep the repos in sync...
- [ ] See `QUOTES.md` for ideas at beginning of chatper

- The chapter titles do not necessarily have to be the paper titles

## PROCEED HERE

## Checklist port

- [x] Include R libraries in `thesis.Rnw`
- [x] Namespace code chunks
- [x] Use `\emph{}` instead of `\textit{}`
- [x] Port latex packages and commands to designated files
- [x] Check number format (not in `$` and with bigmark)
- [x] Refs (e.g., `\Section~\ref{label}`)
- [x] Port bibliography
- [ ] Namespace labels
- [x] Organize `\todo{}`s at top
- [x] Publication, contributions and changes table

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
  - [x] `trb24`: no vignettes folder
  - [x] `OPSR`
  - [x] `TWTE`
  - [x] `OPSRtools`
- [x] Think about main thesis structure (order of the papers)
- [ ] Port papers one by one
  - Only one file per paper (don't split up into multiple sources)
  - [ ] Author contributions section => Do I need some signature/confirmation from the co-authors?
  - [x] `mpp`: no vignettes folder
  - [ ] `responseRateAnalysis`
  - [x] `datapap`: no vignette built
  - [ ] `trb24`: no vignettes folder
  - [ ] `OPSR`
  - [ ] `TWTE`
  - [ ] `OPSRtools` (maybe before `TWTE`?)
- [x] Adjust bibliography style... maybe Makefile is not needed in the end...
  - See `preamble/general.tex` and `preamble/natbib/` and adjustments in `bibliography.Rnw`
- [x] What font are they using? => hermann zapf's palatino and eulermath
- [ ] Make ownpubs in `publications.Rnw` work
- [~] Captionsetup => I like it below
- [ ] Formatting numbers (not in `$` and big mark `
- [ ] See hyperlink setup and colors in https://github.com/dheimgartner/paperPackage/blob/main/inst/templates/JSS/jss.cls
- [ ] Why is doi in bibliography not red? (see point above)
- [ ] Light blue references/links as Thoscha (see point above)
- [ ] longtable in `\ChapterInfoTable` adds to table index...
- [ ] Computational details section for whole thesis (in particular own phd-thesis-heimgartner repos)

## Author contributions

Statement: all authors or author 1, author 2; next statement: authors

|Study conception and design
Design and implementation of surveys
Data processing
|Analysis and interpretation of results
|Original draft
|Writing, reviewing and editing
|All authors reviewed and approved the final manuscript



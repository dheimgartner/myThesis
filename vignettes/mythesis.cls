\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mythesis}[2025/03/19 Custom report class based on scrreprt]

% Forward all options to the base scrreprt class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrreprt}}

% Process the options
\ProcessOptions\relax

% Load the base class
\LoadClass{scrreprt}

% Customizations to the report class
\newcommand\code{\bgroup\@makeother\_\@makeother\~\@makeother\$\@codex}
\def\@codex#1{{\normalfont\ttfamily\hyphenchar\font=-1 #1}\egroup}

\newcommand{\proglang}[1]{\textsf{#1}}
\newcommand{\pkg}[1]{\textbf{#1}}
\newcommand{\class}[1]{`\code{#1}'}
\newcommand{\fct}[1]{\code{#1()}}

% doi: taken from jss.cls
\ifx\csname urlstyle\endcsname\relax
  \newcommand\@doi[1]{doi:\discretionary{}{}{}#1}\else
  \newcommand\@doi{doi:\discretionary{}{}{}\begingroup
\urlstyle{tt}\Url}\fi
\newcommand{\doi}[1]{\href{https://doi.org/#1}{\normalfont\texttt{\@doi{#1}}}}

% some math stuff from jss.cls
\newcommand{\E}{\mathsf{E}}
\newcommand{\VAR}{\mathsf{VAR}}
\newcommand{\COV}{\mathsf{COV}}
\newcommand{\Prob}{\mathsf{P}}

% End of class file

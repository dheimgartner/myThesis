\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mythesis}[2025/03/19 Custom report class based on scrreprt]

% Load the base class
\LoadClass{scrreprt}

% Customizations to the report class
\newcommand\code{\bgroup\@makeother\_\@makeother\~\@makeother\$\@codex}
\def\@codex#1{{\normalfont\ttfamily\hyphenchar\font=-1 #1}\egroup}

% End of class file

%%Identification
%%The class identifies itself and the LaTeX version needed
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UsydReport}[2020/08/25 Class for writing USYD Reports]
\newcommand{\superclass}{article}
\DeclareOption{article}{\renewcommand{\superclass}{article}}
\DeclareOption{report}{\renewcommand{\superclass}{report}}
\DeclareOption{draft}{
    \renewcommand{\linkcolor}{usydred}
    \PassOptionsToClass{\CurrentOption}{\superclass}
    \PackageWarningNoLine{UsydReport}{Draft mode still enabled. Remove 'draft' from class options at the beginning of the document.}
}
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{\superclass}
}
\newcommand{\linkcolor}{linkgrey}

\ProcessOptions\relax
\LoadClass{\superclass}



%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Typography and Typesetting
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[english]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc} % Output font encoding for international characters
\RequirePackage[pdftex,dvipsnames, table]{xcolor} % custom colours
\definecolor{darkmidnightblue}{rgb}{0.0, 0.2, 0.4}
\definecolor{usydred}{HTML}{E94424}
\definecolor{linkgrey}{HTML}{555555}
\definecolor{mygreen}{RGB}{28,172,0} % color values Red, Green, Blue
\definecolor{mylilas}{RGB}{170,55,241}
\RequirePackage{listings} % Used to typeset code
\lstset{language=Matlab,% 
    %basicstyle=\color{red},
    breaklines=true,%
    morekeywords={matlab2tikz},
    keywordstyle=\color{blue},%
    morekeywords=[2]{1}, keywordstyle=[2]{\color{black}},
    identifierstyle=\color{black},%
    stringstyle=\color{mylilas},
    commentstyle=\color{mygreen},%
    showstringspaces=false,%without this there will be a symbol in the places where there is a space
    numbers=left,%
    numberstyle={\tiny \color{black}},% size of the numbers
    numbersep=9pt, % this defines how far the numbers are from the text
    emph=[1]{for,end,break},emphstyle=[1]\color{red}, %some words to emphasise
    %emph=[2]{word1,word2}, emphstyle=[2]{style},    
}
\RequirePackage{csquotes} % Context sensitive quotation facilities
\RequirePackage[a4paper,top=2.54cm,bottom=2.54cm,left=2.54cm,right=2.54cm, marginparwidth=2cm]{geometry} % Set 1 inch margins
\RequirePackage{url}
\RequirePackage{verbatim}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Graphics and Floats
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[final]{graphicx} % better graphics with optional args for \includegraphics{}
\RequirePackage[%
    labelfont=bf,
    format=hang,    
    format=plain,
    margin=0pt,
    calcwidth=0.8\linewidth
]{caption} % float caption settings
\RequirePackage{subcaption} % for subfloats

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Maths and Numbers
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{amsmath, amsfonts, amssymb}
% \allowdisplaybreaks % Allows page breaks across multi-line equations
\RequirePackage{esint} % Closed-form integrals
\RequirePackage{physics} % quick maths definitions
\newcommand{\qwhere}{\@ifstar{\qq*{where}}{\qq{where}}}
\RequirePackage{siunitx} % SI units and in-text numbers
\sisetup{
    range-phrase = ~-~, 
    range-units = single,
    list-units = single,
    multi-part-units = single,
    product-units = single,
    table-alignment = right,
    list-pair-separator = {, },
    list-final-separator = {, },
    list-separator = {, },
}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sections
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \RequirePackage{titlesec} % Custom section titles
% Uncomment below for smaller spacing between titles
% \titlespacing\section{0pt}{0ex plus 1ex minus .2ex}{0ex plus .2ex}
% \titlespacing\subsection{0pt}{0ex plus 1ex minus .2ex}{0ex plus .2ex}
% \titlespacing\subsubsection{0pt}{0ex plus 1ex minus .2ex}{0ex plus .2ex}

% Page numbering and section counter reset
\def\frontmatter{%
    \pagenumbering{roman}
    \setcounter{page}{1}
    \renewcommand{\thesection}{\Roman{section}}
}%
\def\mainmatter{%
    \pagenumbering{arabic}
    \setcounter{page}{1}
    \setcounter{section}{0}
    \renewcommand{\thesection}{\arabic{section}}
}%
\def\backmatter{%
    \setcounter{section}{0}
    \renewcommand{\thesection}{\Alph{section}}
}%

\RequirePackage[title]{appendix} % Appendix environment with cleveref settings
\AtBeginEnvironment{appendices}{\crefalias{section}{appendix}}
\AtBeginEnvironment{appendices}{\crefalias{subsection}{appendix}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{multirow}
\RequirePackage{multicol}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{tabularx}
\RequirePackage{tabulary}
\RequirePackage{xltabular}
\RequirePackage{array}
\RequirePackage{makecell}
\RequirePackage{enumitem} % Tighter lists
\newlist{tightitemize}{itemize}{3}
\setlist[tightitemize]{label=\textbullet,nosep,after=\strut}
\newlist{tightenumerate}{enumerate}{3}
\setlist[tightenumerate]{label=\arabic*,nosep,after=\strut}
\newenvironment{tabitemize}{\begin{minipage}[t]{\linewidth}\begin{tightitemize}}
{\end{tightitemize}\end{minipage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Referencing and TOC
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[draft=false]{hyperref}
\hypersetup{colorlinks=true,
            allcolors={\linkcolor},
            urlcolor=blue}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage[noabbrev]{cleveref}
\newcommand\crefrangeconjunction{\textendash}
\RequirePackage[style=numeric]{biblatex}
\addbibresource{refs.bib}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Scripting
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{xargs}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Word Counting
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Don't ignore words in tabular
%TC:group table 0 1
%TC:group tabular 1 1
\newcommand{\detailtexcount}[1]{%
  \immediate\write18{texcount -merge -sum -q #1.tex output.bbl > #1.wcdetail }%
  \verbatiminput{#1.wcdetail}%
}

\newcommand{\quickwordcount}[1]{%
  \immediate\write18{texcount -1 -sum -merge -q #1.tex output.bbl > #1-words.sum }%
  \input{#1-words.sum} words%
}

\newcommand{\quickcharcount}[1]{%
  \immediate\write18{texcount -1 -sum -merge -char -q #1.tex output.bbl > #1-chars.sum }%
  \input{#1-chars.sum} characters (not including spaces)%
}

\newcommand{\wordcount}{%
    %TC:ignore
    \todo[inline,caption={Word Count}]{
    \quickwordcount{main}%
    \quickcharcount{main}%
    \detailtexcount{main}}%
    %TC:endignore
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Misc
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{pdflscape}
\RequirePackage[textsize=small,obeyDraft]{todonotes}
\RequirePackage{lipsum}


\newcommand{\makeshorttitle}{%
    \onecolumn
    \noindent\makebox[\textwidth][c]{%
    \begin{minipage}{0.8\textwidth}
    \centering
        {\Large
        \reporttitle} \\[1em]
        {\large 
        SID: \authorSID \\
        \today\\}
    \end{minipage}}\\[2em]   
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Title page defaults
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\reporttitle}{Title of Report}
\newcommand{\authorname}{~}
\newcommand{\authorSID}{~} 
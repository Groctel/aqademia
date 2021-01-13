% ==============================================================================
% AQADEMIA: A LaTeX template for academic documents
% ------------------------------------------------------------------------------
% Author:  Atanasio Rubio Gil
% Licence: GPL-2.0
% ==============================================================================

% ==============================================================================
% Class declaration
% ==============================================================================

\RequirePackage{expl3}

\ProvidesExplClass{aqademic}
                  {2020/06/30}
                  {3.0}
                  {Template for academic documents}

\LoadClass{report}

% ==============================================================================
% Core Packages
% ==============================================================================

\RequirePackage{xifthen}
\RequirePackage{xkeyval}
\RequirePackage{xparse}

% ==============================================================================
% Class constants
% ==============================================================================

\RequirePackage{xcolor}
	\definecolor{listing-background} {HTML} {f7f7f7}
	\definecolor{listing-numbers}    {HTML} {8e8e8e}
	\definecolor{listing-text-color} {HTML} {2c2c2c}
	\definecolor{listing-keyword}    {HTML} {6a2398}
	\definecolor{listing-keyword-2}  {HTML} {1284CA}
	\definecolor{listing-keyword-3}  {HTML} {9137CB}
	\definecolor{listing-identifier} {HTML} {2467be}
	\definecolor{listing-string}     {HTML} {568a34}
	\definecolor{listing-comment}    {HTML} {8e8e8e}

% ==============================================================================
% Class variables
% ==============================================================================

% TeX core variables
\def\AqademiaChapterString{\chaptertitlename}
\def\AqademiaSectionString{\S}
\def\AqademiaSubsectionString{}
\def\AqademiaSubsubsectionString{}

% Expl3 variables declarations
\bool_new:N \g_render_doclicense
\bool_new:N \g_render_cover

% Expl3 variables definitions
\bool_set_false:N \g_render_doclicense
\bool_set_false:N \g_render_cover

\RequirePackage{titling}
	\author{Anonymous}
	\title{Untitled~document}

% ==============================================================================
% Class internal commands
% ==============================================================================

% Compare current environment with 'appendices'
\newcommand*\@appendices{appendices}

% Print the chapter index according to the 'appendices' environment
\newcommand*\@aqchapterindex{%
	\ifx\@currenvir\@appendices{%
		\MakeUppercase{\alph{chapter}}
	}
	\else{%
		\arabic{chapter}
	}
	\fi
}

% ==============================================================================
% Page properties
% ==============================================================================

% Margins and physical geometry
\RequirePackage{geometry}
	\geometry{%
		a4paper,
		left     = 2cm,
		right    = 2cm,
		top      = 3cm,
		bottom   = 2.3cm,
		headsep  = 0.5cm,
		footskip = 0.75cm
	}

% Fancy page style
\RequirePackage{fancyhdr}
	\pagestyle{fancy}
	\fancyhf{}
	\lhead{\AqademiaTitleString}
	\rhead{\theauthor}
	\cfoot{\thepage}

% Footnotes format
\RequirePackage[bottom, multiple, norule]{footmisc}

% ==============================================================================
% Custom title format and displaying
% ==============================================================================

\RequirePackage{titlesec}

\titleformat{\chapter}[block]
	{\normalfont\bfseries\Huge}
	{{\AqademiaChapterString}~{\@aqchapterindex}:\\}
	{0pt}{}

\titleformat{\section}[block]
	{\normalfont\bfseries\huge}
	{\AqademiaSectionString{\@aqchapterindex}.\arabic{section}:~}
	{0pt}{}

\titleformat{\subsection}[block]
	{\normalfont\bfseries\Large}
	{\AqademiaSubsectionString{\@aqchapterindex}.\arabic{section}.\arabic{subsection}:~}
	{0pt}{}

\titleformat{\subsubsection}[block]
	{\normalfont\bfseries\large}
	{\AqademiaSubsubsectionString\arabic{subsubsection}:~}
	{0pt}{}

\titlespacing*{\chapter}
	{0pt}{0pt}{30pt}

% ==============================================================================
% Custom tables format and displaying
% https://tex.stackexchange.com/questions/12703/how-to-create-fixed-width- \
% table-columns-with-text-raggedright-centered-raggedlef
% ==============================================================================

\RequirePackage{array}
\RequirePackage{booktabs}

\newcolumntype{L}[1]{%
	>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}
}
\newcolumntype{C}[1]{%
	>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}
}
\newcolumntype{R}[1]{%
	>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}
}

\setlength{\tabcolsep}{3ex}
\renewcommand{\arraystretch}{1.25}

% ==============================================================================
% Source code listings
% ==============================================================================

\RequirePackage{listings}

\lstdefinestyle{aqademia-listings}{%
	basicstyle       = \color{listing-text-color}\linespread{1.0}\small\ttfamily{},
	backgroundcolor  = \color{listing-background},
	numbers          = left,
	breaklines       = true,
	breakindent      = 0pt,
	frame            = single,
	xleftmargin      = 0cm,
	framexleftmargin = 0.08cm,
	tabsize          = 3,
	numberstyle      = \color{listing-numbers},
	keywordstyle     = {\color{listing-keyword}\bfseries},
	keywordstyle     = {[2]\color{listing-keyword-2}\bfseries},
	keywordstyle     = {[3]\color{listing-keyword-3}\bfseries\itshape},
	sensitive        = true,
	identifierstyle  = \color{listing-identifier},
	commentstyle     = \color{listing-comment},
	stringstyle      = \color{listing-string},
	showstringspaces = false,
	escapeinside     = {/*@}{@*/}, % Allow LaTeX inside these special comments
	literate         =
		{á}{{\'a}}1    {é}{{\'e}}1     {í}{{\'\i}}1 {ó}{{\'o}}1   {ú}{{\'u}}1
		{Á}{{\'A}}1    {É}{{\'E}}1     {Í}{{\'I}}1  {Ó}{{\'O}}1   {Ú}{{\'U}}1
		{à}{{\`a}}1    {è}{{\'e}}1     {ì}{{\`\i}}1 {ò}{{\`o}}1   {ù}{{\`u}}1
		{À}{{\`A}}1    {È}{{\'E}}1     {Ì}{{\`I}}1  {Ò}{{\`O}}1   {Ù}{{\`U}}1
		{ä}{{\"a}}1    {ë}{{\"e}}1     {ï}{{\"\i}}1 {ö}{{\"o}}1   {ü}{{\"u}}1
		{Ä}{{\"A}}1    {Ë}{{\"E}}1     {Ï}{{\"I}}1  {Ö}{{\"O}}1   {Ü}{{\"U}}1
		{â}{{\^a}}1    {ê}{{\^e}}1     {î}{{\^\i}}1 {ô}{{\^o}}1   {û}{{\^u}}1
		{Â}{{\^A}}1    {Ê}{{\^E}}1     {Î}{{\^I}}1  {Ô}{{\^O}}1   {Û}{{\^U}}1
		{œ}{{\oe}}1    {Œ}{{\OE}}1     {æ}{{\ae}}1  {Æ}{{\AE}}1   {ß}{{\ss}}1
		{ç}{{\c c}}1   {Ç}{{\c C}}1    {ø}{{\o}}1   {å}{{\r a}}1  {Å}{{\r A}}1
		{…}{{\ldots}}1 {≥}{{>=}}1      {≤}{{<=}}1   {„}{{\glqq}}1 {“}{{\grqq}}1
		{”}{{''}}1     {ñ}{{\~n}}1     {Ñ}{{\~N}}1  {¿}{{?`}}1
		{«}{{\guillemotleft}}1         {€}{{\EUR}}1 {£}{{\pounds}}1
		{»}{{\guillemotright}}1
}

\lstset{escapechar=@,style=aqademia-listings}

% ==============================================================================
% Other settings and packages
% ==============================================================================

% Hyperref support and colours
\RequirePackage{hyperref}
	\hypersetup{colorlinks = true,
	            linkcolor  = black,
	            filecolor  = black,
	            urlcolor   = darkgray
	           }

% Add space between paragraphs
\RequirePackage{parskip}

% URL support, required by the titlepage
\RequirePackage{url}

% ==============================================================================
% Post-preface processing
% ==============================================================================

\AtBeginDocument{%
	% Display the license in the titlepage if 'doclicense' is loaded
	\@ifpackageloaded{doclicense}{%
		\bool_set_true:N \g_render_doclicense
	}{%
		\relax
	}

	% Allow displaying the cover image in the titlepage if 'graphicx' is loaded
	\@ifpackageloaded{graphicx}{%
		\bool_set_true:N \g_render_cover
	}{%
		\relax
	}

	% Define the following keys for the titlepage
	\define@key{aqademia} {author}   [\theauthor] {\def\aqademia@author{#1}}
	\define@key{aqademia} {cover}    []           {\def\aqademia@cover{#1}}
	\define@key{aqademia} {title}    [\thetitle]  {\def\aqademia@title{#1}}
	\define@key{aqademia} {org}      []           {\def\aqademia@org{#1}}
	\define@key{aqademia} {subtitle} []           {\def\aqademia@subtitle{#1}}
	\define@key{aqademia} {url}      []           {\def\aqademia@url{#1}}

	% Set the document title for the header
	\let\AqademiaTitleString\thetitle%

	\ifthenelse{\isundefined{\thedate}}
	{
		\date{\today}
	}
	{}
}

% ==============================================================================
% Custom commands
% ==============================================================================

% Print Aqademia's custom titlepage
\NewDocumentCommand{\AqMaketitle}{O{}}{%
	\setkeys{aqademia}{author, cover, title, org, subtitle, url, #1}%

	\begin{titlepage}
		\begin{center}
			\bool_if:NT \g_render_cover {%
				\ifx\aqademia@cover\empty{%
					{\hfill}\\
					\vspace{10cm}
				}
				\else{%
					\includegraphics[height=13cm]{\aqademia@cover}\\[0.5cm]
				}
				\fi
			}

			\textsc{\Huge{\aqademia@org}}\\

			\rule{\linewidth}{0.2 mm}\\
			{%
				\huge{\textbf{
					\aqademia@title

					\ifx\aqademia@subtitle\empty{%
					}
					\else{%
						{~---~}\aqademia@subtitle
					}
					\fi
					\\
				}}
			}
			\rule{\linewidth}{0.2 mm}\\

			\vfill

			\Large{\textbf{\aqademia@author}}

			\ifx\aqademia@url\empty{%
			}
			\else{%
				{\\[0.1cm]\large{\url{\aqademia@url}}}
			}
			\fi

			\\[0.5 cm]

			\large{\thedate}
		\end{center}

		\bool_if:NT \g_render_doclicense {%
			\doclicenseThis%
		}
	\end{titlepage}
}

% Set the chapter string
\NewDocumentCommand{\AqSetChapter}{m}{%
	\def\AqademiaChapterString{#1}
}

% Set the section string
\NewDocumentCommand{\AqSetSection}{m}{%
	\def\AqademiaSectionString{#1}
}

% Set the subsection string
\NewDocumentCommand{\AqSetSubsection}{m}{%
	\def\AqademiaSubsectionString{#1}
}

% Set the subsubsection string
\NewDocumentCommand{\AqSetSubsubsection}{m}{%
	\def\AqademiaSubsubsectionString{#1}
}

% ==============================================================================
% Commands renewal
% ==============================================================================

% Force \titleformat after \appendix
\let\oldappendix\appendix%

\renewcommand{\appendix}{%
	\oldappendix%
	\titleformat{\chapter}[block]
		{\normalfont\bfseries\Huge}
		{{\chaptertitlename}~\MakeUppercase{\alph{chapter}}:\\}
		{0pt}{}
	\titleformat{\section}[block]
		{\normalfont\bfseries\huge}
		{\S\MakeUppercase{\alph{chapter}}.\arabic{section}:~}
		{0pt}{}
	\titleformat{\subsection}[block]
		{\normalfont\bfseries\Large}
		{\MakeUppercase{\alph{chapter}}.\arabic{section}.\arabic{subsection}:~}
		{0pt}{}
}

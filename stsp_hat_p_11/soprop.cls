% soprop.cls        (New LaTeX2e class file for Steward Observatory proposals)
%
%               *****  DO NOT EDIT OR RENAME THIS FILE  *****
%
% Revision history:
%   v0.9 -- R.A. Jansen 06/05/2006  Initial LaTeX2e version, submitted to TAC;
%                                   complete rewrite of 'sodefs06.sty'
%   v1.0 -- R.A. Jansen 06/18/2006  Initial LaTeX2e version, as shipped out for
%                                   the 2006C Call for Proposals.
%   v1.1 -- P. Smith    09/25/2006  Removed "past/present/future" table on
%                                   cover page; added "time request" narrative.
%   v1.2 -- R.A. Jansen 10/06/2006  Fixed bugs of missing '\obs[G-L]@*', of
%                                   'sopwarningu' (6-->12), and of missing
%                                   'altruns' (3); corrected page limit check.
%   v1.3 -- R.A. Jansen 08/01/2007  Added explicit AO-query and -flag for MMT
%                                   and associated warning; added \boldmath in
%                                   def of \Maketitle and \(sub)section, since
%                                   many proposers are unaware titles can have
%                                   proper math fonts; added warning for thesis
%                                   proposal with non-student PI; added legend
%                                   to bottom of front page.
%   v1.3.1 -- D. Zaritsky 09/01/2015  edited slightly to support autoprocessing
%   v1.33  -- K. Su 03/05/2018      edited for PI Instrument, Student Project

%% Basic declarations
\NeedsTeXFormat{LaTeX2e}[1995/12/01]%
\ProvidesClass{soprop}[2007/08/01 v1.3 Steward Observatory proposals class]%
\ClassInfo{soprop}{Initial version, ported to \protect\LaTeXe\space from
        `sodefs06.sty'\MessageBreak by R.A. Jansen (Rolf.Jansen@asu.edu)
        \MessageBreak}%

%% Required standard LaTeX2e packages
\RequirePackage{ifthen}
\RequirePackage{latexsym}
\RequirePackage{epsf}
\RequirePackage{epsfig}
\RequirePackage{graphicx}
\RequirePackage{psfig}
\RequirePackage{bm}
% Should the 'times' package not be installed on the proposer's system, then
% the following line may be commented out. This will result in a reduction of
% the amount of text the proposer can fit into the available space (~10-15%).
\RequirePackage{times}

%% Revtex information
\def\revtex@ver{1.3}            % Version number of this file.
\def\revtex@date{2007 Aug 01}   % Revision date.
\def\revtex@author{RAJ}         % This file's author.
\def\revtex@genre{\LaTeXe\ UAO Observing Proposal class, 'soprop.cls'}

% The font size shall remain fixed to 11pt
\LoadClass[11pt]{article}

% Ensure that the format of the proposal is identical on both Letter and A4
% size paper; adjust the margins accordingly.
\DeclareOption{letter}{
   %\renewcommand{\normalsize}{\fontsize{11pt}{12pt}\selectfont}
   \setlength{\paperwidth}{8.5in}
   \setlength{\paperheight}{11in}
   \setlength{\textwidth}{6.5in}
   \setlength{\textheight}{9.0in}
   \setlength{\oddsidemargin}{0in}
   \setlength{\evensidemargin}{\oddsidemargin}
   \setlength{\topmargin}{0.0in}
   \setlength{\headsep}{0.2in}
   \addtolength{\topmargin}{-\headsep}
   \setlength{\headheight}{0.2in}
   \setlength{\parindent}{0pt}
   \def\SO@pagewidth{6.5}
   \def\SO@pagelength{9.0}
}
\DeclareOption{a4paper}{
   %\renewcommand{\normalsize}{\fontsize{10pt}{12pt}\selectfont}
   \setlength{\paperwidth}{21.0cm}
   \setlength{\paperheight}{29.7cm}
   \setlength{\textwidth}{16.51cm}
   \setlength{\textheight}{22.86cm}
   \setlength{\oddsidemargin}{-0.295cm}
   \setlength{\evensidemargin}{\oddsidemargin}
   \setlength{\topmargin}{-0.88cm}
   \setlength{\headsep}{0.2in}
   \addtolength{\topmargin}{-\headsep}
   \setlength{\headheight}{0.2in}
   \setlength{\parindent}{0pt}
   \def\SO@pagewidth{16.51}
   \def\SO@pagelength{22.86}
}
\newboolean{borderbox}
\DeclareOption{final}{
   \setboolean{borderbox}{false}
}
\DeclareOption{draft}{
   \setboolean{borderbox}{true}
}
% Ignore any unknown options
\DeclareOption*{\ClassWarningNoLine{soprop}{Ignoring option '\CurrentOption'}}

\ExecuteOptions{11pt,letter,final}
\ProcessOptions*


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  GENERATE THE TWO PROPOSAL COVER PAGES (unnumbered)
%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareRobustCommand{\makecoverpages}{
    \addtocounter{page}{-2}
    \thispagestyle{empty}
    \ifthenelse{\boolean{borderbox}}{
        \noindent
        \begin{picture}(\SO@pagewidth,\SO@pagelength)
            \put(-0.025,-0.025){
                \rule{0.425\textwidth}{0.05pt}
                \raisebox{-2pt}{\itshape\tiny \space do not write past this line\space}
                \rule{0.425\textwidth}{0.05pt}
            }
            \put(-0.025,-0.025){\rule{0.05pt}{4pt}}
            \put(\SO@pagewidth,-0.025){\rule{0.05pt}{4pt}}
            \framebox(\SO@pagewidth,\SO@pagelength)[tl]{
                \vbox{
                    \MakeHeader
                    \MakeObsTerm
                    \MakeTitle
                    \MakeInvestigators
                    \MakeAbstract
                    \MakeObsrunTable
                    \MakeConstraints
%                   %\MakeAllocInfo
                }
            }
        \end{picture}
        \vfill\pagebreak
        \thispagestyle{empty}
        \noindent
        \begin{picture}(\SO@pagewidth,\SO@pagelength)
            \framebox(\SO@pagewidth,\SO@pagelength)[tl]{
                \vbox{
                    \MakeTargetList
                    \MakePiApproval
                    \MakeGradInfo
                }
            }
        \end{picture}
        \vfill\pagebreak
    }{
        \noindent
        \begin{picture}(\SO@pagewidth,\SO@pagelength)
            \put(-0.050,-0.025){
                \rule{0.440\textwidth}{0.05pt}
                \raisebox{-2pt}{\itshape\tiny \space no text past this line\space}
                \rule{0.440\textwidth}{0.05pt}
            }
            \put(-0.025,-0.050){\rule{0.05pt}{4pt}}
            \put(\SO@pagewidth,-0.050){\rule{0.05pt}{4pt}}
            \put(-0.050,-0.225){
                {\tiny\noindent A \raisebox{1.5pt}{$\star$} appended to the
                proposal type indicates a continuation proposal; \ 
                a \raisebox{1.5pt}{$\star$} appended to the name of a proposer
                indicates the proposer is a (graduate) student; \ a proposer
                whose name is underlined}
            }
            \put(-0.050,-0.300){
                {\tiny\noindent is certified on the proposed 
                telescope/instrument combination; \ if a \raisebox{-1pt}{*}
                appears within the PI or AO box in the observations summary
                table, the instrument is a PI instrument and/or Adaptive
                Optics}
	    }
            \put(-0.050,-0.375){
                {\tiny\noindent are requested -- signatures are required on the
                next page.}
            }
            \makebox(\SO@pagewidth,\SO@pagelength)[tl]{
                \vbox{
                    \MakeHeader
                    \MakeObsTerm
                    \MakeTitle
                    \MakeInvestigators
                    \MakeAbstract
                    \MakeObsrunTable
                    \MakeConstraints
%                   %\MakeAllocInfo
                }
            }
        \end{picture}
        \vfill\pagebreak
        \thispagestyle{empty}
        \noindent
        \begin{picture}(\SO@pagewidth,\SO@pagelength)
            \makebox(\SO@pagewidth,\SO@pagelength)[tl]{
                \vbox{
                    \MakeTargetList
                    \MakePiApproval
                    \MakeGradInfo
                }
            }
        \end{picture}
        \vfill\pagebreak
    }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%   MACROS DEFINITIONS   %%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Most of the macros that will print information at their designated place in
%% the proposal will have to accept a blank or only partially filled out latex
%% proposal template (and even mistakenly deleted obligatory section commands)
%% and still produce a proposal that has the correct layout so that a blank
%% proposal can be compiled and printed.
%% This means that most macros will explicitly test whether a value (either a
%% boolean, numerical or plain text) was provided, and provide warnings/hints
%% on the screen about what might be missing or wrong. 

% Tighten up the text somewhat
\renewcommand{\baselinestretch}{0.9}
\setlength{\unitlength}{1.0in}
\setlength{\parskip}{1ex}
\voffset=-0.25in
\hoffset=-0.12in

%% Macro: fixmbox
%% Draw a box of fixed width #1 and height #2 with contents #4 aligned inter-
%% nally on #3 (=c,l,r). Note that argument #2 MUST be an integer length (5mm
%% will work, 0.2in will not)!
\DeclareRobustCommand*{\fixmbox}[4]{%
    \fboxsep=0pt\makebox[#1][#3]{\rule[-0.8#2]{0pt}{#2}\ #4\ }\hspace{-2mm}
}
%% End Macro

%% Macro: fixfbox
%% Draw a framebox of fixed width #1 and height #2 with contents #4 aligned
%% internally on #3 (=c,l,r). Note that argument #2 MUST be integer length
%% (5mm will work, 0.2in will not)!
\DeclareRobustCommand*{\fixfbox}[4]{%
    \fboxsep=0pt\framebox[#1][#3]{\rule[-0.8#2]{0pt}{#2}\ #4\ }\hspace{-2mm}
}
%% End Macro


%% Macro: MakeHeader
%% This macro creates a centerbox for the header on the proposal cover page
%% of fixed width, height and position
\DeclareRobustCommand{\MakeHeader}{%
    %\typeout{MakeHeader ... entering}
    \noindent\hspace*{-3pt}\makebox[\textwidth][t]{
        \parbox[t][7mm][t]{\textwidth}{
            \centerline{\large\bf OBSERVING REQUEST}
            \centerline{\bf University of Arizona Observatories}
        }
    }\par
    %\typeout{MakeHeader ... done}
}
%% End Macro

%% Macro: MakeObsTerm
%% This macro creates the line with observing cycle and proposal type info
\DeclareRobustCommand{\MakeObsTerm}{%
    \typeout{MakeObsTerm ... entering}
    % Test whether a year was provided and if so whether in a valid format
    \ifthenelse{\equal{\@proptermyear}{}}{
        \@sopwarninga
        \gdef\propyearbox{\sopheadu\space }
    }{
        \ifthenelse{ \@proptermyear < 2006 \or \@proptermyear > 2030 }{
            \@sopwarningb
            \gdef\propyearbox{\sopheadu\space }
        }{
            % a correctly formatted 4-digit year was provided
            \gdef\propyearbox{\sopheadu\space \@proptermyear}
        }
    }
    % Test whether a term (trimester/semester) was provided and if so whether
    % a valid one.  Translate the term ID to the standard text string.
    \ifthenelse{\equal{\@proptermterm}{}}{
        \@sopwarningc
        \gdef\proptermbox{\sopheadv\space$\qquad$--$\qquad$}
    }{
        \ifthenelse{\equal{\@proptermterm}{1}}{
            \gdef\proptermbox{\sopheadv\space Jan--Apr}
        }{
            \ifthenelse{\equal{\@proptermterm}{2}}{
                \gdef\proptermbox{\sopheadv\space May--Jul}
            }{
                \ifthenelse{\equal{\@proptermterm}{3}}{
                    \gdef\proptermbox{\sopheadv\space Sep--Dec}
                }{
                    \ifthenelse{\equal{\@proptermterm}{A} \or
                                \equal{\@proptermterm}{a}}{
                        \gdef\proptermbox{\sopheadv\space Jan--Jun}
                    }{
                        \ifthenelse{\equal{\@proptermterm}{B} \or
                                    \equal{\@proptermterm}{b}}{
                            \gdef\proptermbox{\sopheadv\space Jul--Dec}
                        }{
                            % not a valid term identifier
                            \@sopwarningd
                            \gdef\proptermbox{\sopheadv\space$\qquad$--$\qquad$}
                        }
                    }
                }
            }
        }
    }
    % Test whether the proposal is a continuation of a program that was
    % previously awarded time. The default is 'false'.
    \newboolean{ptcont}\setboolean{ptcont}{false}
    \ifthenelse{\equal{\@proptermcont}{}}{
        \@sopwarninge
    }{
        \ifthenelse{\equal{\@proptermcont}{true} \or
                    \equal{\@proptermcont}{yes}}{
            \setboolean{ptcont}{true}
        }{
            \ifthenelse{\equal{\@proptermcont}{false} \or
                        \equal{\@proptermcont}{no}}{
                \relax
            }{
                % invalid entry: ptcont -> false (default)
                \@sopwarningf
            }
        }
    }
    % Test whether this is an education/public outreach proposal ('true')
    % and translate the switch to the standard text string. The default is
    % 'false'. If 'true', then the 'proplong' switch is ignored.
    \newboolean{pteduc}\setboolean{pteduc}{false}
    \ifthenelse{\equal{\@proptermeduc}{true} \or
                \equal{\@proptermeduc}{yes}}{
        \setboolean{pteduc}{true}
        \gdef\proptypebox{education/outreach}
    }{
        \relax
    }
    % Test whether this is an engineering proposal ('true') and translate
    % the switch to the standard text string.  The default is 'false'. If
    % 'true', then the 'proplong' and 'propeduc' switches are ignored.
    \newboolean{ptengr}\setboolean{ptengr}{false}
    \ifthenelse{\equal{\@proptermengr}{true} \or
                \equal{\@proptermengr}{yes}}{
        \setboolean{ptengr}{true}
        \gdef\proptypebox{engineering}
    }{
        \relax
    }
    % Test whether this is a long-term program ('true') and translate the
    % switch to the standard text string. The default is 'false'.
    \newboolean{ptlong}\setboolean{ptlong}{false}
    \ifthenelse{ \not\boolean{ptengr} \and \not\boolean{pteduc} }{
        \ifthenelse{\equal{\@proptermlong}{}}{
            \@sopwarningg
            \gdef\proptypebox{short-term}
        }{
            \ifthenelse{\equal{\@proptermlong}{true} \or
                        \equal{\@proptermlong}{yes}}{
                \setboolean{ptlong}{true}
                \gdef\proptypebox{long-term}
            }{
                \ifthenelse{\equal{\@proptermlong}{false} \or
                            \equal{\@proptermlong}{no}}{
                    \gdef\proptypebox{short-term}
                }{
                    % invalid entry -> default = false
                    \@sopwarningh
                    \gdef\proptypebox{short-term}
                }
            }
        }
    }{
        \relax
    }
    \let\@proptypebox=\proptypebox
    \ifthenelse{\boolean{ptcont}}{
        \gdef\proptypebox{\sopheadw\space \fbox{\@proptypebox$^{\star}$}}
    }{
        \gdef\proptypebox{\sopheadw\space \fbox{\@proptypebox}}
    }
    % If both long-term and continuation flags are true, test whether a
    % program ID number was specified
    \ifthenelse{\boolean{ptcont} \and \boolean{ptlong}}{
        \ifthenelse{\equal{\@proptermltnr}{}}{
            \@sopwarningi
            \gdef\propltnrbox{\sopheadx\space L$\qquad$}
        }{
            % following line causes a latex 'Missing number' error if value
            % is non-numeric
            \ifthenelse{ \@proptermltnr < 0 }{
                \@sopwarningj
                \gdef\propltnrbox{\sopheadx\space L$\qquad$}
            }{
                % a correctly formatted number was provided
                \gdef\propltnrbox{\sopheadx\space L\@proptermltnr}
            }
        }
    }{
        % either not a long-term program or not a continuation. Ignore any 
        % entry provided in \propltnr
        \gdef\propltnrbox{}
    }
    % Now generate the terminfo line on the proposal cover page
    \noindent\hspace*{-3pt}\makebox[\textwidth][t]{
        \parbox[t][\totalheight][t]{0.995\textwidth}{
            \hspace*{-5pt}
            \propyearbox\hfill
            \proptermbox\hfill
            \proptypebox
            \ifthenelse{\boolean{ptcont} \and \boolean{ptlong}}{
                \hfill\propltnrbox\par
            }{
                \par
            }
        }
    }\par
    \typeout{MakeObsTerm ... done}
}
%% End Macro

%% Environment: proposalterminfo
%% Dummy environment, used merely as a logical container to collect the info
%% to appear on the proposal term and type info line.
\newenvironment{proposalterminfo}{
    \gdef\sopheadu{\mbox{\bfseries Year:}}
    \gdef\sopheadv{\mbox{\bfseries Term:}}
    \gdef\sopheadw{\mbox{\bfseries Proposal type:}}
    \gdef\sopheadx{\mbox{\bfseries Proposal ID:}}
}{
    \relax
}

% the actual containers for the propoposal term info items
\gdef\@proptermyear{}
\gdef\@proptermterm{}
\gdef\@proptermcont{}
\gdef\@proptermlong{}
\gdef\@proptermeduc{}
\gdef\@proptermengr{}
\gdef\@proptermltnr{}
\gdef\propyear#1{\gdef\@proptermyear{#1}}
\gdef\propterm#1{\gdef\@proptermterm{#1}}
\gdef\propcont#1{\gdef\@proptermcont{#1}}
\gdef\proplong#1{\gdef\@proptermlong{#1}}
\gdef\propltnr#1{\gdef\@proptermltnr{#1}}
\gdef\propeduc#1{\gdef\@proptermeduc{#1}}
\gdef\propengr#1{\gdef\@proptermengr{#1}}

%% Macro: MakeTitle
%% This macro creates a box of up to two lines containing the proposal title
\DeclareRobustCommand{\MakeTitle}{%
    \typeout{MakeTitle ... entering}
    %\typeout{  setting all font sizes to \protect\LARGE\protect\bf\space...}
    \let\ltx@hbadness  =\hbadness    \hbadness=1000000
    \let\ltx@normalsize=\normalsize  \def\normalsize{\LARGE}
    \let\ltx@large     =\large       \def\large{\LARGE}
    \let\ltx@Large     =\Large       \def\Large{\LARGE}
    \let\ltx@huge      =\huge        \def\huge{\LARGE}
    \let\ltx@rm        =\rm          \def\rm{\bf}
    \let\ltx@it        =\it          \def\it{\bf}
    \ifthenelse{\equal{\@proptitle}{}}{
        \@sopwarningk
        \noindent\hspace*{-3pt}\makebox[\textwidth][t]{
            \hspace*{-2.2pt}\parbox[t][36pt][t]{0.999\textwidth}{
                \bfseries\LARGE Title: \hrulefill
                \hspace{5pt}\makebox[0.998\textwidth][t]{\hrulefill}
            }
        }
    }{
        \noindent\hspace*{-3pt}\parbox[t][36pt][t]{\textwidth}{
            \sloppy\bfseries\LARGE\boldmath\@proptitle
        }
    }\par
    \vspace{2mm}
    %\typeout{  resetting font sizes to proper size...}
    \hbadness      =\ltx@hbadness
    \let\normalsize=\ltx@normalsize
    \let\large     =\ltx@large
    \let\Large     =\ltx@Large
    \let\huge      =\ltx@huge
    \let\rm        =\ltx@rm
    \let\it        =\ltx@it
    \typeout{MakeTitle ... done}
}
%% End Macro

% the actual container for the title text.
\gdef\@proptitle{}
\gdef\proptitle#1{\gdef\@proptitle{#1}}

%% Macro: MakeInvestigators
%% This macro creates the box with the principal investigator line and the
%% box of up to three lines listing the co-investigators.
\DeclareRobustCommand{\MakeInvestigators}{%
    \typeout{MakeInvestigators ... entering}
    \ifthenelse{ \value{nPI} < 1 }{
        \@sopwarningl
        \gdef\sopheady{\mbox{\bfseries P.I.:}}
        \gdef\@proppiname{$\qquad$}
    }{
        \ifthenelse{ \value{nPI} > 1 }{
            \@sopwarningm
            \gdef\@proppiname{$\qquad$}
        }{
            \ifthenelse{\equal{\@proppiname}{}\and\equal{\@proppiinst}{}\and
                        \equal{\@proppiaddr}{}\and\equal{\@proppiphon}{}}{
                \fixmbox{6.5in}{1mm}{l}{\tiny\itshape
                    \hspace*{1.00in}first+last name\hspace*{0.65in}inst.
                    \hspace*{0.50in}e-mail address\hspace*{0.70in}phone number
                }\\[-18pt]
            }{\relax}

            \ifthenelse{\equal{\@proppiname}{}}{
                \@sopwarningn
                \gdef\@proppiname{\hspace*{1.5in}}
            }{
                \relax
            }
            \ifthenelse{\equal{\@proppiinst}{}}{
                \@sopwarningo
                \ifthenelse{\equal{\@proppiname}{\hspace*{1.5in}}}{
                    \gdef\@proppiinst{$\qquad$}
                }{
                    \gdef\@proppiinst{SO}
                }
            }{
                \relax
            }
            \ifthenelse{\equal{\@proppiaddr}{}}{
                \@sopwarningp
                \gdef\@proppiaddr{\hspace*{1.3in}}
            }{
                \relax
            }
            \ifthenelse{\equal{\@proppiphon}{}}{
                \@sopwarningq
                \gdef\@proppiphon{\hspace*{1.0in}}
            }{
                \relax
            }
            \ifthenelse{\equal{\@proppicert}{true} \or
                        \equal{\@proppicert}{yes}}{
                \let\sonproppi=\@proppiname
                \gdef\@proppiname{\underline{\sonproppi}}
            }{
                \relax
            }
            \ifthenelse{\equal{\@proppigrad}{true} \or
                        \equal{\@proppigrad}{yes}}{
                \let\sosproppi=\@proppiname
                \gdef\@proppiname{\sosproppi$^{\star}$}
            }{
                \relax
            }
        }
    }
    \typeout{  number of co-investigators is \arabic{nCoI}}

    % Now generate the PI and CoI info line(s) on the proposal cover page
    \noindent\hspace*{-3pt}\makebox[\textwidth][t]{
        \hspace*{-5pt}\parbox[t][0.75in][t]{0.995\textwidth}{
           \fixmbox{0.50in}{3mm}{l}{\parbox[t]{0.5in}{\sopheady\space\space}}
           \fixmbox{5.98in}{3mm}{l}{
              \parbox[t]{5.98in}{\raggedright\@proppiname\space\space
                    (\@proppiinst;\space{\itshape\@proppiaddr};\space
                    \@proppiphon)}
           }
           \ifthenelse{ \value{nCoI} = 0 }{
              \fixmbox{0.50in}{5mm}{l}{\parbox[t]{0.5in}{\sopheadz\space\space}}
              \fixmbox{5.98in}{5mm}{l}{
                     \parbox[t]{5.96in}{\hrulefill
                     \hspace{3pt}\makebox[5.96in]{\hrulefill}
                     \hspace{3pt}\makebox[5.96in]{\hrulefill}
                  }
              }
           }{
              \ifthenelse{\equal{\@propcoinameA}{}}{
                \@sopwarningr
                \fixmbox{0.50in}{5mm}{l}{\parbox[t]{0.5in}{\sopheadz\space\space}}
                \fixmbox{5.98in}{5mm}{l}{
                     \parbox[t]{5.96in}{\hrulefill
                     \hspace{3pt}\makebox[5.96in]{\hrulefill}
                     \hspace{3pt}\makebox[5.96in]{\hrulefill}
                  }
                }
              }{
                \fixmbox{0.50in}{5mm}{l}{\parbox[t]{0.5in}{\sopheadz\space\space}}
                \fixmbox{5.98in}{5mm}{l}{
                    \parbox[t]{5.98in}{\raggedright\propcoibox\hfill}
                }
              }
           }
        }
    }\par
    \typeout{MakeInvestigators ... done}
}
%% End Macro

%% Environment: PrincipalInvestigator
%% Dummy environment, used merely as a logical container to collect the info
%% to appear on the proposal principal investigator line
\newcounter{nPI}
\newenvironment{PrincipalInvestigator}{
    \stepcounter{nPI}
}{
    \relax
}

% the actual containers for the propoposal investigator items
\gdef\sopheady{\mbox{\bfseries P.I.:}}
\gdef\@proppiname{}
\gdef\@proppiinst{}
\gdef\@proppiaddr{}
\gdef\@proppiphon{}
\gdef\@proppicert{}
\gdef\@proppigrad{}
\gdef\PIname#1       {\gdef\@proppiname{#1}}
\gdef\PIinstitution#1{\gdef\@proppiinst{#1}}
\gdef\PIemail#1      {\gdef\@proppiaddr{#1}}
\gdef\PIphone#1      {\gdef\@proppiphon{#1}}
\gdef\PIcertified#1  {\gdef\@proppicert{#1}}
\gdef\PIstudent#1    {\gdef\@proppigrad{#1}}

%% Environment: CoInvestigator
%% This environment is used both as a logical container to collect the info
%% to appear on the proposal co-investigator line(s) and to underline the
%% co-I name when certified and append an asterisk when a (graduate) student
\newcounter{nCoI}
\newenvironment{CoInvestigator}{
    \stepcounter{nCoI}
}{
    \ifthenelse{ \equal{\propcoibox}{} }{
        \chkcertn{\@propcoicertA}{\@propcoinameA}
        \chkgrada{\@propcoigradA}{\@propcoiinstA}
    }{
        \let\@propcoibox=\propcoibox
        \ifthenelse{ \value{nCoI} = 2 }{
            \chkcertn{\@propcoicertB}{\@propcoinameB}
            \chkgradn{\@propcoigradB}{\@propcoiinstB}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 3 }{
            \chkcertn{\@propcoicertC}{\@propcoinameC}
            \chkgradn{\@propcoigradC}{\@propcoiinstC}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 4 }{
            \chkcertn{\@propcoicertD}{\@propcoinameD}
            \chkgradn{\@propcoigradD}{\@propcoiinstD}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 5 }{
            \chkcertn{\@propcoicertE}{\@propcoinameE}
            \chkgradn{\@propcoigradE}{\@propcoiinstE}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 6 }{
            \chkcertn{\@propcoicertF}{\@propcoinameF}
            \chkgradn{\@propcoigradF}{\@propcoiinstF}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 7 }{
            \chkcertn{\@propcoicertG}{\@propcoinameG}
            \chkgradn{\@propcoigradG}{\@propcoiinstG}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 8 }{
            \chkcertn{\@propcoicertH}{\@propcoinameH}
            \chkgradn{\@propcoigradH}{\@propcoiinstH}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 9 }{
            \chkcertn{\@propcoicertI}{\@propcoinameI}
            \chkgradn{\@propcoigradI}{\@propcoiinstI}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 10 }{
            \chkcertn{\@propcoicertJ}{\@propcoinameJ}
            \chkgradn{\@propcoigradJ}{\@propcoiinstJ}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 11 }{
            \chkcertn{\@propcoicertK}{\@propcoinameK}
            \chkgradn{\@propcoigradK}{\@propcoiinstK}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 12 }{
            \chkcertn{\@propcoicertL}{\@propcoinameL}
            \chkgradn{\@propcoigradL}{\@propcoiinstL}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 13 }{
            \chkcertn{\@propcoicertM}{\@propcoinameM}
            \chkgradn{\@propcoigradM}{\@propcoiinstM}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 14 }{
            \chkcertn{\@propcoicertN}{\@propcoinameN}
            \chkgradn{\@propcoigradN}{\@propcoiinstN}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 15 }{
            \chkcertn{\@propcoicertO}{\@propcoinameO}
            \chkgradn{\@propcoigradO}{\@propcoiinstO}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 16 }{
            \chkcertn{\@propcoicertP}{\@propcoinameP}
            \chkgradn{\@propcoigradP}{\@propcoiinstP}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 17 }{
            \chkcertn{\@propcoicertQ}{\@propcoinameQ}
            \chkgradn{\@propcoigradQ}{\@propcoiinstQ}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 18 }{
            \chkcertn{\@propcoicertR}{\@propcoinameR}
            \chkgradn{\@propcoigradR}{\@propcoiinstR}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 19 }{
            \chkcertn{\@propcoicertS}{\@propcoinameS}
            \chkgradn{\@propcoigradS}{\@propcoiinstS}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 20 }{
            \chkcertn{\@propcoicertT}{\@propcoinameT}
            \chkgradn{\@propcoigradT}{\@propcoiinstT}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 21 }{
            \chkcertn{\@propcoicertU}{\@propcoinameU}
            \chkgradn{\@propcoigradU}{\@propcoiinstU}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 22 }{
            \chkcertn{\@propcoicertV}{\@propcoinameV}
            \chkgradn{\@propcoigradV}{\@propcoiinstV}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 23 }{
            \chkcertn{\@propcoicertW}{\@propcoinameW}
            \chkgradn{\@propcoigradW}{\@propcoiinstW}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 24 }{
            \chkcertn{\@propcoicertX}{\@propcoinameX}
            \chkgradn{\@propcoigradX}{\@propcoiinstX}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 25 }{
            \chkcertn{\@propcoicertY}{\@propcoinameY}
            \chkgradn{\@propcoigradY}{\@propcoiinstY}
        }{\relax}
        \ifthenelse{ \value{nCoI} = 26 }{
            \chkcertn{\@propcoicertZ}{\@propcoinameZ}
            \chkgradn{\@propcoigradZ}{\@propcoiinstZ}
        }{\relax}
        \ifthenelse{ \value{nCoI} > 26  }{
            \let\@propcoibox=\propcoibox
            \typeout{  WARNING: nCoI>26! Ignoring CoI number \arabic{nCoI} ...}
        }{\relax}
    }
}

% Auxilliary macro \chkcertn to underline the current CoIname if the
% 'CoIcertified' flag is set. Output is '\prop@coiname'.
\DeclareRobustCommand*{\chkcertn}[2]{%
    \ifthenelse{\equal{#1}{true} \or \equal{#1}{yes}}{
        \xdef\prop@coiname{\underline{#2}}%
    }{
        \xdef\prop@coiname{#2}%
    }
}%

% Auxilliary macros \chkgrada and \chkgradn to mark the current Co-I name if
% the 'CoIstudent' flag is set. The 2nd command concatenates to previously
% defined Co-I text strings. Output is '\propcoibox' (may be long, hence no
% * to the command).  Variable \prop@coiname is assumed to exist already.
\DeclareRobustCommand{\chkgrada}[2]{%
    \ifthenelse{\equal{#2}{}}{\def\coi@inst{SO}}{\def\coi@inst{#2}}
    \ifthenelse{\equal{#1}{true} \or \equal{#1}{yes}}{
        \xdef\propcoibox{\mbox{\prop@coiname$^{\star}$\space (\coi@inst)}}%
    }{
        \xdef\propcoibox{\mbox{\prop@coiname\space (\coi@inst)}}%
    }
}%
\DeclareRobustCommand{\chkgradn}[2]{%
    \ifthenelse{\equal{#2}{}}{\def\coi@inst{SO}}{\def\coi@inst{#2}}
    \ifthenelse{\equal{#1}{true} \or \equal{#1}{yes}}{
        \xdef\propcoibox{\@propcoibox,\space \mbox{\prop@coiname$^{\star}$\space (\coi@inst)}}%
    }{
        \xdef\propcoibox{\@propcoibox,\space \mbox{\prop@coiname\space (\coi@inst)}}%
    }
}%

% the actual containers (up to 26) for the propoposal investigator items
\gdef\sopheadz{\mbox{\bfseries CoI(s):}}
\gdef\propcoibox{}
\gdef\@propcoibox{}
\gdef\prop@coiname{}
\gdef\@propcoinameA{}    \gdef\@propcoiinstA{}    \gdef\@propcoicertA{}
\gdef\@propcoinameB{}    \gdef\@propcoiinstB{}    \gdef\@propcoicertB{}
\gdef\@propcoinameC{}    \gdef\@propcoiinstC{}    \gdef\@propcoicertC{}
\gdef\@propcoinameD{}    \gdef\@propcoiinstD{}    \gdef\@propcoicertD{}
\gdef\@propcoinameE{}    \gdef\@propcoiinstE{}    \gdef\@propcoicertE{}
\gdef\@propcoinameF{}    \gdef\@propcoiinstF{}    \gdef\@propcoicertF{}
\gdef\@propcoinameG{}    \gdef\@propcoiinstG{}    \gdef\@propcoicertG{}
\gdef\@propcoinameH{}    \gdef\@propcoiinstH{}    \gdef\@propcoicertH{}
\gdef\@propcoinameI{}    \gdef\@propcoiinstI{}    \gdef\@propcoicertI{}
\gdef\@propcoinameJ{}    \gdef\@propcoiinstJ{}    \gdef\@propcoicertJ{}
\gdef\@propcoinameK{}    \gdef\@propcoiinstK{}    \gdef\@propcoicertK{}
\gdef\@propcoinameL{}    \gdef\@propcoiinstL{}    \gdef\@propcoicertL{}
\gdef\@propcoinameM{}    \gdef\@propcoiinstM{}    \gdef\@propcoicertM{}
\gdef\@propcoinameN{}    \gdef\@propcoiinstN{}    \gdef\@propcoicertN{}
\gdef\@propcoinameO{}    \gdef\@propcoiinstO{}    \gdef\@propcoicertO{}
\gdef\@propcoinameP{}    \gdef\@propcoiinstP{}    \gdef\@propcoicertP{}
\gdef\@propcoinameQ{}    \gdef\@propcoiinstQ{}    \gdef\@propcoicertQ{}
\gdef\@propcoinameR{}    \gdef\@propcoiinstR{}    \gdef\@propcoicertR{}
\gdef\@propcoinameS{}    \gdef\@propcoiinstS{}    \gdef\@propcoicertS{}
\gdef\@propcoinameT{}    \gdef\@propcoiinstT{}    \gdef\@propcoicertT{}
\gdef\@propcoinameU{}    \gdef\@propcoiinstU{}    \gdef\@propcoicertU{}
\gdef\@propcoinameV{}    \gdef\@propcoiinstV{}    \gdef\@propcoicertV{}
\gdef\@propcoinameW{}    \gdef\@propcoiinstW{}    \gdef\@propcoicertW{}
\gdef\@propcoinameX{}    \gdef\@propcoiinstX{}    \gdef\@propcoicertX{}
\gdef\@propcoinameY{}    \gdef\@propcoiinstY{}    \gdef\@propcoicertY{}
\gdef\@propcoinameZ{}    \gdef\@propcoiinstZ{}    \gdef\@propcoicertZ{}

\gdef\@propcoigradA{}    \gdef\@propcoigradN{}
\gdef\@propcoigradB{}    \gdef\@propcoigradO{}
\gdef\@propcoigradC{}    \gdef\@propcoigradP{}
\gdef\@propcoigradD{}    \gdef\@propcoigradQ{}
\gdef\@propcoigradE{}    \gdef\@propcoigradR{}
\gdef\@propcoigradF{}    \gdef\@propcoigradS{}
\gdef\@propcoigradG{}    \gdef\@propcoigradT{}
\gdef\@propcoigradH{}    \gdef\@propcoigradU{}
\gdef\@propcoigradI{}    \gdef\@propcoigradV{}
\gdef\@propcoigradJ{}    \gdef\@propcoigradW{}
\gdef\@propcoigradK{}    \gdef\@propcoigradX{}
\gdef\@propcoigradL{}    \gdef\@propcoigradY{}
\gdef\@propcoigradM{}    \gdef\@propcoigradZ{}

\gdef\CoIname#1          {\global\@namedef{@propcoiname\@Alph{\c@nCoI}}{#1}}
\gdef\CoIinstitution#1   {\global\@namedef{@propcoiinst\@Alph{\c@nCoI}}{#1}}
\gdef\CoIcertified#1     {\global\@namedef{@propcoicert\@Alph{\c@nCoI}}{#1}}
\gdef\CoIstudent#1       {\global\@namedef{@propcoigrad\@Alph{\c@nCoI}}{#1}}


%% Macro: MakeAbstract
%% This macro creates the box with the abstract of the science justification
\DeclareRobustCommand{\MakeAbstract}{%
    \typeout{MakeAbstract ... entering}
    %\typeout{  setting all font sizes to \protect\normalsize\space...}
    \let\ltx@large       =\large         \def\large{\normalsize}
    \let\ltx@small       =\small         \def\small{\normalsize}
    \let\ltx@footnotesize=\footnotesize  \def\footnotesize{\normalsize}
    \let\ltx@scriptsize  =\scriptsize    \def\scriptsize{\normalsize}
    \renewcommand{\abstractname}{Abstract of Scientific Justification}
    %\typeout{  creating abstract box...}
    \ifthenelse{\equal{\@propabstract}{}}{
        \noindent\hspace*{-3pt}\framebox[\textwidth][t]{
            \hspace*{-1pt}\parbox[t][21em][t]{0.98\textwidth}{
                \centerline{\bfseries\abstractname}
                \@sopwarnings
            }
        }
    }{
        \noindent\hspace*{-3pt}\framebox[\textwidth][t]{
            \hspace*{-1pt}\parbox[t][21em][t]{0.98\textwidth}{
                \centerline{\bfseries\abstractname}
                \@propabstract
            }
        }
    }\par
    %\typeout{  resetting font sizes to proper size...}
    \let\large       =\ltx@large
    \let\small       =\ltx@small
    \let\footnotesize=\ltx@footnotesize
    \let\scriptsize  =\ltx@scriptsize
    \typeout{MakeAbstract ... done}
}
%% End Macro

% the actual container for the abstract text.
\gdef\@propabstract{}
\gdef\propabstract#1    {\gdef\@propabstract{#1}}


%% Macro: MakeObsrunTable
%% This macro creates the box with the observation run summary table
\DeclareRobustCommand{\MakeObsrunTable}{%
    \typeout{MakeObsrunTable ... entering}
    \typeout{  number of observing runs specified is \arabic{obsrun}}
    \typeout{  number of alternate runs specified is \arabic{altrun}}
    \ifthenelse{ \value{obsrun} < 1 }{
        \@sopwarningt
        % draw an empty box where the table should have appeared
        \noindent\hspace*{-3pt}\makebox[\textwidth][t]{
            \parbox[t][2.5in][t]{0.995\textwidth}{
                \noindent\hspace*{-5pt}\sopheado\hfill\par
                \noindent\hspace*{-5pt}
                \fixmbox{0.25in}{4mm}{c}{\ltx@obsheadsize Run}\hspace{2pt}
                \fixmbox{0.90in}{4mm}{c}{\ltx@obsheadsize Telescope}
                \fixmbox{0.45in}{4mm}{c}{\ltx@obsheadsize Cage}
                \fixmbox{1.44in}{4mm}{c}{\ltx@obsheadsize Instrument}
                \fixmbox{0.20in}{4mm}{c}{\ltx@obsheadsize PI}
                \fixmbox{0.20in}{4mm}{c}{\ltx@obsheadsize AO}
                \fixmbox{0.45in}{4mm}{c}{\ltx@obsheadsize Nights}
                \fixmbox{0.50in}{4mm}{c}{\ltx@obsheadsize Moon}
                \fixmbox{0.75in}{4mm}{c}{\ltx@obsheadsize Optimal}
                \fixmbox{0.75in}{4mm}{c}{\ltx@obsheadsize Acceptable}
                \fixmbox{0.30in}{4mm}{c}{\ltx@obsheadsize Poss.}
                \fixmbox{0.30in}{4mm}{c}{\ltx@obsheadsize Adv.}\par
                \noindent\hspace*{-5pt}\mbox{
                  \fixfbox{0.25in}{4mm}{c}{1}\hspace{2pt}
                  \fixfbox{0.90in}{4mm}{l}{}
                  \fixfbox{0.45in}{4mm}{c}{}
                  \fixfbox{1.44in}{4mm}{l}{}
                  \fixfbox{0.20in}{4mm}{c}{}
                  \fixfbox{0.20in}{4mm}{c}{}
                  \fixfbox{0.45in}{4mm}{c}{}
                  \fixfbox{0.50in}{4mm}{c}{}
                  \fixfbox{0.75in}{4mm}{c}{}
                  \fixfbox{0.75in}{4mm}{c}{}
                  \fixfbox{0.30in}{4mm}{c}{}
                  \fixfbox{0.30in}{4mm}{c}{}
                }\par
            }
        }\par
    }{
        % generate the observing runs summary table
        \noindent\hspace*{-3pt}\makebox[\textwidth][t]{
            \parbox[t][2.5in][t]{0.995\textwidth}{
                \noindent\hspace*{-5pt}\sopheado\hfill\\[-10pt]
                \rightline{\ltx@obsheadsize Scheduling\hspace{0.50in}
                           Sharing\space\space\space}\\[-4pt]
                \noindent\hspace*{-5pt}
                \fixmbox{0.25in}{4mm}{c}{\ltx@obsheadsize Run}\hspace{2pt}
                \fixmbox{0.90in}{4mm}{c}{\ltx@obsheadsize Telescope}
                \fixmbox{0.45in}{4mm}{c}{\ltx@obsheadsize Cage}
                \fixmbox{1.44in}{4mm}{c}{\ltx@obsheadsize Instrument}
                \fixmbox{0.20in}{4mm}{c}{\ltx@obsheadsize PI}
                \fixmbox{0.20in}{4mm}{c}{\ltx@obsheadsize AO}
                \fixmbox{0.45in}{4mm}{c}{\ltx@obsheadsize Nights}
                \fixmbox{0.50in}{4mm}{c}{\ltx@obsheadsize Moon}
                \fixmbox{0.75in}{4mm}{c}{\ltx@obsheadsize Optimal}
                \fixmbox{0.75in}{4mm}{c}{\ltx@obsheadsize Acceptable}
                \fixmbox{0.30in}{4mm}{c}{\ltx@obsheadsize Poss.}
                \fixmbox{0.30in}{4mm}{c}{\ltx@obsheadsize Adv.}\par
                \ifthenelse{\equal{\obsA@scope}{}}{
                      \@sopwarningN
                }{\relax}
                \ifthenelse{\equal{\obsA@cage}{}}{
                      \@sopwarningO
                }{\relax}
                \ifthenelse{\equal{\obsA@instr}{}}{
                      \@sopwarningP
                }{\relax}
                \ifthenelse{\equal{\obsA@piflg}{}}{
                      \@sopwarningQ
                }{\relax}
                \ifthenelse{\equal{\obsA@aoflg}{}}{
                      \@sopwarningAA
                }{\relax}
                \ifthenelse{\equal{\obsA@nights}{}}{
                      \@sopwarningR
                }{\relax}
                \ifthenelse{\equal{\obsA@moon}{}}{
                      \@sopwarningS
                }{\relax}
                \ifthenelse{\equal{\obsA@optimal}{}}{
                      \@sopwarningT
                }{\relax}
                \ifthenelse{\equal{\obsA@acceptbl}{}}{
                      \@sopwarningU
                }{\relax}
                \noindent\hspace*{-5pt}\mbox{
                    \fixfbox{0.25in}{4mm}{c}{1}\hspace{2pt}
                    \fixfbox{0.90in}{4mm}{l}{\obsA@scope}
                    \fixfbox{0.45in}{4mm}{c}{\obsA@cage}
                    \fixfbox{1.44in}{4mm}{l}{\obsA@instr}
                    \ifthenelse{\equal{\obsA@piflg}{true} \or
                                \equal{\obsA@piflg}{yes}}{
                        \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                    }{
                        \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                    }
                    \ifthenelse{\equal{\obsA@aoflg}{true} \or
                                \equal{\obsA@aoflg}{yes}}{
                        \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{*}
                    }{
                        \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{\null}
                    }
                    \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\obsA@nights}
                    \fixfbox{0.50in}{4mm}{c}{\obsA@moon}
                    \fixfbox{0.75in}{4mm}{c}{\obsA@optimal}
                    \fixfbox{0.75in}{4mm}{c}{\obsA@acceptbl}
                    \ifthenelse{\equal{\obsA@shareok}{true} \or
                                \equal{\obsA@shareok}{yes}}{
                        \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                    }{  \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}\hspace*{3pt}}
                    \ifthenelse{\equal{\obsA@shareOK}{true} \or
                                \equal{\obsA@shareOK}{yes}}{
                        \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                    }{  \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}}
                }\par
                \ifthenelse{ \value{obsrun} > 1 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{2}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\obsB@scope}
                        \fixfbox{0.45in}{4mm}{c}{\obsB@cage}
                        \fixfbox{1.44in}{4mm}{l}{\obsB@instr}
                        \ifthenelse{\equal{\obsB@piflg}{true} \or
                                    \equal{\obsB@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\obsB@aoflg}{true} \or
                                    \equal{\obsB@aoflg}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\obsB@nights}
                        \fixfbox{0.50in}{4mm}{c}{\obsB@moon}
                        \fixfbox{0.75in}{4mm}{c}{\obsB@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\obsB@acceptbl}
                        \ifthenelse{\equal{\obsB@shareok}{true} \or
                                    \equal{\obsB@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\obsB@shareOK}{true} \or
                                    \equal{\obsB@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
                }{
                    \relax
                }
                \ifthenelse{ \value{obsrun} > 2 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{3}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\obsC@scope}
                        \fixfbox{0.45in}{4mm}{c}{\obsC@cage}
                        \fixfbox{1.44in}{4mm}{l}{\obsC@instr}
                        \ifthenelse{\equal{\obsC@piflg}{true} \or
                                    \equal{\obsC@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\obsC@aoflg}{true} \or
                                    \equal{\obsC@aoflg}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\obsC@nights}
                        \fixfbox{0.50in}{4mm}{c}{\obsC@moon}
                        \fixfbox{0.75in}{4mm}{c}{\obsC@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\obsC@acceptbl}
                        \ifthenelse{\equal{\obsC@shareok}{true} \or
                                    \equal{\obsC@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\obsC@shareOK}{true} \or
                                    \equal{\obsC@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
                }{
                    \relax
                }
                \ifthenelse{ \value{obsrun} > 3 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{4}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\obsD@scope}
                        \fixfbox{0.45in}{4mm}{c}{\obsD@cage}
                        \fixfbox{1.44in}{4mm}{l}{\obsD@instr}
                        \ifthenelse{\equal{\obsD@piflg}{true} \or
                                    \equal{\obsD@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\obsD@aoflg}{true} \or
                                    \equal{\obsD@aoflg}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\obsD@nights}
                        \fixfbox{0.50in}{4mm}{c}{\obsD@moon}
                        \fixfbox{0.75in}{4mm}{c}{\obsD@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\obsD@acceptbl}
                        \ifthenelse{\equal{\obsD@shareok}{true} \or
                                    \equal{\obsD@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\obsD@shareOK}{true} \or
                                    \equal{\obsD@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
                }{
                    \relax
                }
                \ifthenelse{ \value{obsrun} > 4 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{5}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\obsE@scope}
                        \fixfbox{0.45in}{4mm}{c}{\obsE@cage}
                        \fixfbox{1.44in}{4mm}{l}{\obsE@instr}
                        \ifthenelse{\equal{\obsE@piflg}{true} \or
                                    \equal{\obsE@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\obsE@aoflg}{true} \or
                                    \equal{\obsE@aoflg}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\obsE@nights}
                        \fixfbox{0.50in}{4mm}{c}{\obsE@moon}
                        \fixfbox{0.75in}{4mm}{c}{\obsE@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\obsE@acceptbl}
                        \ifthenelse{\equal{\obsE@shareok}{true} \or
                                    \equal{\obsE@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\obsE@shareOK}{true} \or
                                    \equal{\obsE@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
                }{
                    \relax
                }
                \ifthenelse{ \value{obsrun} > 5 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{6}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\obsF@scope}
                        \fixfbox{0.45in}{4mm}{c}{\obsF@cage}
                        \fixfbox{1.44in}{4mm}{l}{\obsF@instr}
                        \ifthenelse{\equal{\obsF@piflg}{true} \or
                                    \equal{\obsF@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\obsF@aoflg}{true} \or
                                    \equal{\obsF@aoflg}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\obsF@nights}
                        \fixfbox{0.50in}{4mm}{c}{\obsF@moon}
                        \fixfbox{0.75in}{4mm}{c}{\obsF@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\obsF@acceptbl}
                        \ifthenelse{\equal{\obsF@shareok}{true} \or
                                    \equal{\obsF@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\obsF@shareOK}{true} \or
                                    \equal{\obsF@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
                }{
                    \relax
                }
                \ifthenelse{ \value{obsrun} > 6 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{7}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\obsG@scope}
                        \fixfbox{0.45in}{4mm}{c}{\obsG@cage}
                        \fixfbox{1.44in}{4mm}{l}{\obsG@instr}
                        \ifthenelse{\equal{\obsG@piflg}{true} \or
                                    \equal{\obsG@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\obsG@aoflg}{true} \or
                                    \equal{\obsG@aoflg}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\obsG@nights}
                        \fixfbox{0.50in}{4mm}{c}{\obsG@moon}
                        \fixfbox{0.75in}{4mm}{c}{\obsG@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\obsG@acceptbl}
                        \ifthenelse{\equal{\obsG@shareok}{true} \or
                                    \equal{\obsG@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\obsG@shareOK}{true} \or
                                    \equal{\obsG@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
                }{
                    \relax
                }
                \ifthenelse{ \value{obsrun} > 7 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{8}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\obsH@scope}
                        \fixfbox{0.45in}{4mm}{c}{\obsH@cage}
                        \fixfbox{1.44in}{4mm}{l}{\obsH@instr}
                        \ifthenelse{\equal{\obsH@piflg}{true} \or
                                    \equal{\obsH@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\obsH@aoflg}{true} \or
                                    \equal{\obsH@aoflg}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\obsH@nights}
                        \fixfbox{0.50in}{4mm}{c}{\obsH@moon}
                        \fixfbox{0.75in}{4mm}{c}{\obsH@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\obsH@acceptbl}
                        \ifthenelse{\equal{\obsH@shareok}{true} \or
                                    \equal{\obsH@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\obsH@shareOK}{true} \or
                                    \equal{\obsH@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
                }{
                    \relax
                }
                \ifthenelse{ \value{obsrun} > 8 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{9}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\obsI@scope}
                        \fixfbox{0.45in}{4mm}{c}{\obsI@cage}
                        \fixfbox{1.44in}{4mm}{l}{\obsI@instr}
                        \ifthenelse{\equal{\obsI@piflg}{true} \or
                                    \equal{\obsI@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\obsI@aoflg}{true} \or
                                    \equal{\obsI@aoflg}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\obsI@nights}
                        \fixfbox{0.50in}{4mm}{c}{\obsI@moon}
                        \fixfbox{0.75in}{4mm}{c}{\obsI@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\obsI@acceptbl}
                        \ifthenelse{\equal{\obsI@shareok}{true} \or
                                    \equal{\obsI@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\obsI@shareOK}{true} \or
                                    \equal{\obsI@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
                }{
                    \relax
                }
                \ifthenelse{ \value{obsrun} > 9 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{10}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\obsJ@scope}
                        \fixfbox{0.45in}{4mm}{c}{\obsJ@cage}
                        \fixfbox{1.44in}{4mm}{l}{\obsJ@instr}
                        \ifthenelse{\equal{\obsJ@piflg}{true} \or
                                    \equal{\obsJ@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\obsJ@aoflg}{true} \or
                                    \equal{\obsJ@aoflg}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\obsJ@nights}
                        \fixfbox{0.50in}{4mm}{c}{\obsJ@moon}
                        \fixfbox{0.75in}{4mm}{c}{\obsJ@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\obsJ@acceptbl}
                        \ifthenelse{\equal{\obsJ@shareok}{true} \or
                                    \equal{\obsJ@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\obsJ@shareOK}{true} \or
                                    \equal{\obsJ@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
                }{
                    \relax
                }
                \ifthenelse{ \value{obsrun} > 10 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{11}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\obsK@scope}
                        \fixfbox{0.45in}{4mm}{c}{\obsK@cage}
                        \fixfbox{1.44in}{4mm}{l}{\obsK@instr}
                        \ifthenelse{\equal{\obsK@piflg}{true} \or
                                    \equal{\obsK@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\obsK@aoflg}{true} \or
                                    \equal{\obsK@aoflg}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\obsK@nights}
                        \fixfbox{0.50in}{4mm}{c}{\obsK@moon}
                        \fixfbox{0.75in}{4mm}{c}{\obsK@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\obsK@acceptbl}
                        \ifthenelse{\equal{\obsK@shareok}{true} \or
                                    \equal{\obsK@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\obsK@shareOK}{true} \or
                                    \equal{\obsK@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
                }{
                    \relax
                }
                \ifthenelse{ \value{obsrun} > 11 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{12}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\obsL@scope}
                        \fixfbox{0.45in}{4mm}{c}{\obsL@cage}
                        \fixfbox{1.44in}{4mm}{l}{\obsL@instr}
                        \ifthenelse{\equal{\obsL@piflg}{true} \or
                                    \equal{\obsL@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\obsL@aoflg}{true} \or
                                    \equal{\obsL@aoflg}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\obsL@nights}
                        \fixfbox{0.50in}{4mm}{c}{\obsL@moon}
                        \fixfbox{0.75in}{4mm}{c}{\obsL@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\obsL@acceptbl}
                        \ifthenelse{\equal{\obsL@shareok}{true} \or
                                    \equal{\obsL@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\obsL@shareOK}{true} \or
                                    \equal{\obsL@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
                }{
                    \relax
                }
                \ifthenelse{ \value{obsrun} > 12 }{
                    \@sopwarningu
                }{
                    \relax
                }

                % generate alternate runs table (if any are requested)
                \ifthenelse{ \value{altrun} > 0 }{
                    \ifthenelse{\equal{\altA@run}{}}{\def\altA@run{1}}{\relax}
                    \ifthenelse{\altA@run>\value{obsrun}}{\@sopwarningv}{\relax}
                    \ifthenelse{\equal{\altA@scope}{}}{\@sopwarningZ}{\relax}
                    \noindent\hspace*{-2pt}\sopheadp\par
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{\altA@run a}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\altA@scope}
                        \fixfbox{0.45in}{4mm}{c}{\altA@cage}
                        \fixfbox{1.44in}{4mm}{l}{\altA@instr}
                        \ifthenelse{\equal{\altA@piflg}{true} \or
                                    \equal{\altA@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\altA@aoflg}{true} \or
                                    \equal{\altA@aoflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\altA@nights}
                        \fixfbox{0.50in}{4mm}{c}{\altA@moon}
                        \fixfbox{0.75in}{4mm}{c}{\altA@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\altA@acceptbl}
                        \ifthenelse{\equal{\altA@shareok}{true} \or
                                    \equal{\altA@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\altA@shareOK}{true} \or
                                    \equal{\altA@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
%                   \ifthenelse{ \value{altrun} > 1 }{\relax}{\relax}
                }{
                    \relax
                }
                \ifthenelse{ \value{altrun} > 1 }{
                    \ifthenelse{\equal{\altB@run}{}}{\def\altB@run{2}}{\relax}
                    \ifthenelse{\altB@run>\value{obsrun}}{\@sopwarningv}{\relax}
                    \ifthenelse{\equal{\altB@scope}{}}{\@sopwarningZ}{\relax}
                    %\noindent\hspace*{-2pt}\sopheadp\par
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{\altB@run a}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\altB@scope}
                        \fixfbox{0.45in}{4mm}{c}{\altB@cage}
                        \fixfbox{1.44in}{4mm}{l}{\altB@instr}
                        \ifthenelse{\equal{\altB@piflg}{true} \or
                                    \equal{\altB@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\altB@aoflg}{true} \or
                                    \equal{\altB@aoflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\altB@nights}
                        \fixfbox{0.50in}{4mm}{c}{\altB@moon}
                        \fixfbox{0.75in}{4mm}{c}{\altB@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\altB@acceptbl}
                        \ifthenelse{\equal{\altB@shareok}{true} \or
                                    \equal{\altB@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\altB@shareOK}{true} \or
                                    \equal{\altB@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
		}{
		    \relax
		}
                \ifthenelse{ \value{altrun} > 2 }{
                    \ifthenelse{\equal{\altC@run}{}}{\def\altC@run{3}}{\relax}
                    \ifthenelse{\altC@run>\value{obsrun}}{\@sopwarningv}{\relax}
                    \ifthenelse{\equal{\altC@scope}{}}{\@sopwarningZ}{\relax}
                    %\noindent\hspace*{-2pt}\sopheadp\par
                    \noindent\hspace*{-5pt}\mbox{
                        \fixfbox{0.25in}{4mm}{c}{\altC@run a}\hspace{2pt}
                        \fixfbox{0.90in}{4mm}{l}{\altC@scope}
                        \fixfbox{0.45in}{4mm}{c}{\altC@cage}
                        \fixfbox{1.44in}{4mm}{l}{\altC@instr}
                        \ifthenelse{\equal{\altC@piflg}{true} \or
                                    \equal{\altC@piflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \ifthenelse{\equal{\altC@aoflg}{true} \or
                                    \equal{\altC@aoflg}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{*}
                        }{
                            \hspace*{-3pt}\fixfbox{0.20in}{4mm}{c}{\null}
                        }
                        \hspace*{-3pt}\fixfbox{0.45in}{4mm}{c}{\altC@nights}
                        \fixfbox{0.50in}{4mm}{c}{\altC@moon}
                        \fixfbox{0.75in}{4mm}{c}{\altC@optimal}
                        \fixfbox{0.75in}{4mm}{c}{\altC@acceptbl}
                        \ifthenelse{\equal{\altC@shareok}{true} \or
                                    \equal{\altC@shareok}{yes}}{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-3pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                        \ifthenelse{\equal{\altC@shareOK}{true} \or
                                    \equal{\altC@shareOK}{yes}}{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{yes}
                        }{
                            \hspace*{-5.5pt}\fixfbox{0.30in}{4mm}{c}{no}
                        }
                    }\par
                    \ifthenelse{ \value{altrun} > 3 }{
                        \@sopwarningw
                    }{
                        \relax
                    }
                }
            }
        }{
            \relax
        }\par
        \vspace{-4mm}
    }
    \typeout{MakeObsrunTable ... done}
}
%% End Macro

%% Environments: ObsRun and AltRun
%% Dummy environments, used merely as a logical container to collect the info
%% associated with a single run to appear in the observing run summary table.
\newcounter{obsrun}
\newenvironment{ObservingRun}{
    \stepcounter{obsrun}
}{
    \relax%\typeout{Collected info for summary of observing run \arabic{obsrun}}
}

% the actual containers for the observing run variables
\gdef\sopheado{
    \mbox{\bfseries Summary of observing runs requested for this project}
}
\gdef\obsA@scope{}  \gdef\obsA@cage{}  \gdef\obsA@instr{}  \gdef\obsA@piflg{}
\gdef\obsB@scope{}  \gdef\obsB@cage{}  \gdef\obsB@instr{}  \gdef\obsB@piflg{}
\gdef\obsC@scope{}  \gdef\obsC@cage{}  \gdef\obsC@instr{}  \gdef\obsC@piflg{}
\gdef\obsD@scope{}  \gdef\obsD@cage{}  \gdef\obsD@instr{}  \gdef\obsD@piflg{}
\gdef\obsE@scope{}  \gdef\obsE@cage{}  \gdef\obsE@instr{}  \gdef\obsE@piflg{}
\gdef\obsF@scope{}  \gdef\obsF@cage{}  \gdef\obsF@instr{}  \gdef\obsF@piflg{}
\gdef\obsG@scope{}  \gdef\obsG@cage{}  \gdef\obsG@instr{}  \gdef\obsG@piflg{}
\gdef\obsH@scope{}  \gdef\obsH@cage{}  \gdef\obsH@instr{}  \gdef\obsH@piflg{}
\gdef\obsI@scope{}  \gdef\obsI@cage{}  \gdef\obsI@instr{}  \gdef\obsI@piflg{}
\gdef\obsJ@scope{}  \gdef\obsJ@cage{}  \gdef\obsJ@instr{}  \gdef\obsJ@piflg{}
\gdef\obsK@scope{}  \gdef\obsK@cage{}  \gdef\obsK@instr{}  \gdef\obsK@piflg{}
\gdef\obsL@scope{}  \gdef\obsL@cage{}  \gdef\obsL@instr{}  \gdef\obsL@piflg{}

\gdef\obsA@aoflg{}  \gdef\obsA@nights{}  \gdef\obsA@moon{}  \gdef\obsA@optimal{}
\gdef\obsB@aoflg{}  \gdef\obsB@nights{}  \gdef\obsB@moon{}  \gdef\obsB@optimal{}
\gdef\obsC@aoflg{}  \gdef\obsC@nights{}  \gdef\obsC@moon{}  \gdef\obsC@optimal{}
\gdef\obsD@aoflg{}  \gdef\obsD@nights{}  \gdef\obsD@moon{}  \gdef\obsD@optimal{}
\gdef\obsE@aoflg{}  \gdef\obsE@nights{}  \gdef\obsE@moon{}  \gdef\obsE@optimal{}
\gdef\obsF@aoflg{}  \gdef\obsF@nights{}  \gdef\obsF@moon{}  \gdef\obsF@optimal{}
\gdef\obsG@aoflg{}  \gdef\obsG@nights{}  \gdef\obsG@moon{}  \gdef\obsG@optimal{}
\gdef\obsH@aoflg{}  \gdef\obsH@nights{}  \gdef\obsH@moon{}  \gdef\obsH@optimal{}
\gdef\obsI@aoflg{}  \gdef\obsI@nights{}  \gdef\obsI@moon{}  \gdef\obsI@optimal{}
\gdef\obsJ@aoflg{}  \gdef\obsJ@nights{}  \gdef\obsJ@moon{}  \gdef\obsJ@optimal{}
\gdef\obsK@aoflg{}  \gdef\obsK@nights{}  \gdef\obsK@moon{}  \gdef\obsK@optimal{}
\gdef\obsL@aoflg{}  \gdef\obsL@nights{}  \gdef\obsL@moon{}  \gdef\obsL@optimal{}

\gdef\obsA@acceptbl{}   \gdef\obsA@shareok{}   \gdef\obsA@shareOK{}
\gdef\obsB@acceptbl{}   \gdef\obsB@shareok{}   \gdef\obsB@shareOK{}
\gdef\obsC@acceptbl{}   \gdef\obsC@shareok{}   \gdef\obsC@shareOK{}
\gdef\obsD@acceptbl{}   \gdef\obsD@shareok{}   \gdef\obsD@shareOK{}
\gdef\obsE@acceptbl{}   \gdef\obsE@shareok{}   \gdef\obsE@shareOK{}
\gdef\obsF@acceptbl{}   \gdef\obsF@shareok{}   \gdef\obsF@shareOK{}
\gdef\obsG@acceptbl{}   \gdef\obsG@shareok{}   \gdef\obsG@shareOK{}
\gdef\obsH@acceptbl{}   \gdef\obsH@shareok{}   \gdef\obsH@shareOK{}
\gdef\obsI@acceptbl{}   \gdef\obsI@shareok{}   \gdef\obsI@shareOK{}
\gdef\obsJ@acceptbl{}   \gdef\obsJ@shareok{}   \gdef\obsJ@shareOK{}
\gdef\obsK@acceptbl{}   \gdef\obsK@shareok{}   \gdef\obsK@shareOK{}
\gdef\obsL@acceptbl{}   \gdef\obsL@shareok{}   \gdef\obsL@shareOK{}

\def\telescope#1       {\global\@namedef{obs\@Alph{\c@obsrun}@scope}{#1}}
\def\secondary#1       {\global\@namedef{obs\@Alph{\c@obsrun}@cage}{#1}}
\def\instrument#1      {\global\@namedef{obs\@Alph{\c@obsrun}@instr}{#1}}
\def\piflag#1          {\global\@namedef{obs\@Alph{\c@obsrun}@piflg}{#1}}
\def\aoflag#1          {\global\@namedef{obs\@Alph{\c@obsrun}@aoflg}{#1}}
\def\numnights#1       {\global\@namedef{obs\@Alph{\c@obsrun}@nights}{#1}}
\def\nightsky#1        {\global\@namedef{obs\@Alph{\c@obsrun}@moon}{#1}}
\def\optimalmonths#1   {\global\@namedef{obs\@Alph{\c@obsrun}@optimal}{#1}}
\def\acceptablemonths#1{\global\@namedef{obs\@Alph{\c@obsrun}@acceptbl}{#1}}
\def\sharingpossible#1 {\global\@namedef{obs\@Alph{\c@obsrun}@shareok}{#1}}
\def\sharingadvisable#1{\global\@namedef{obs\@Alph{\c@obsrun}@shareOK}{#1}}
\def\altrun#1{\global\@namedef{obs\@Alph{\c@obsrun}@altrunOK}{#1}}

\newcounter{altrun}
\newenvironment{AlternateRun}{
    \stepcounter{altrun}
}{
    \relax%\typeout{  Writing summary of alternate run \arabic{altrun} ...}
}

% the actual containers for the observing run variables
\gdef\sopheadp{\mbox{\bfseries or:}}

\gdef\altA@scope{}  \gdef\altA@cage{}  \gdef\altA@instr{}  \gdef\altA@piflg{}
\gdef\altB@scope{}  \gdef\altB@cage{}  \gdef\altB@instr{}  \gdef\altB@piflg{}
\gdef\altC@scope{}  \gdef\altC@cage{}  \gdef\altC@instr{}  \gdef\altC@piflg{}

\gdef\altA@aoflg{}  \gdef\altA@nights{}  \gdef\altA@moon{}  \gdef\altA@optimal{}
\gdef\altB@aoflg{}  \gdef\altB@nights{}  \gdef\altB@moon{}  \gdef\altB@optimal{}
\gdef\altC@aoflg{}  \gdef\altC@nights{}  \gdef\altC@moon{}  \gdef\altC@optimal{}

\gdef\altA@run{} \gdef\altA@acceptbl{} \gdef\altA@shareok{} \gdef\altA@shareOK{}
\gdef\altB@run{} \gdef\altB@acceptbl{} \gdef\altB@shareok{} \gdef\altB@altrunOK{}
\gdef\altC@run{} \gdef\altC@acceptbl{} \gdef\altC@shareok{} \gdef\altC@altrunOK{}

\def\alttorunnumber#1     {\global\@namedef{alt\@Alph{\c@altrun}@run}{#1}}
\def\alttelescope#1       {\global\@namedef{alt\@Alph{\c@altrun}@scope}{#1}}
\def\altsecondary#1       {\global\@namedef{alt\@Alph{\c@altrun}@cage}{#1}}
\def\altinstrument#1      {\global\@namedef{alt\@Alph{\c@altrun}@instr}{#1}}
\def\altpiflag#1          {\global\@namedef{alt\@Alph{\c@altrun}@piflg}{#1}}
\def\altaoflag#1          {\global\@namedef{alt\@Alph{\c@altrun}@aoflg}{#1}}
\def\altnumnights#1       {\global\@namedef{alt\@Alph{\c@altrun}@nights}{#1}}
\def\altnightsky#1        {\global\@namedef{alt\@Alph{\c@altrun}@moon}{#1}}
\def\altoptimalmonths#1   {\global\@namedef{alt\@Alph{\c@altrun}@optimal}{#1}}
\def\altacceptablemonths#1{\global\@namedef{alt\@Alph{\c@altrun}@acceptbl}{#1}}
\def\altsharingpossible#1 {\global\@namedef{alt\@Alph{\c@altrun}@shareok}{#1}}
\def\altsharingadvisable#1{\global\@namedef{alt\@Alph{\c@altrun}@shareOK}{#1}}


%% Macro: MakeConstraints
%% This macro creates the box with the scheduling constraints and/or unusable
%% dates, constraints on coordination with other facilities, and constraints
%% on sharing of nights.
\DeclareRobustCommand{\MakeConstraints}{%
    \typeout{MakeConstraints ... entering}
    \vspace*{4mm}\ifthenelse{\equal{\@constraints}{}}{
        \@sopwarningV
        \noindent\hspace{-3pt}\makebox[\textwidth][t]{
            \hspace{-5pt}\parbox[t][5em][t]{\textwidth}{
                \makebox[\textwidth]{\sopheadq\space\space\hrulefill}\par
                \hspace{3pt}\makebox[0.993\textwidth]{\hrulefill}\par
                \hspace{3pt}\makebox[0.993\textwidth]{\hrulefill}\par
                \hspace{3pt}\makebox[0.993\textwidth]{\hrulefill}\par
                \hspace{3pt}\makebox[0.993\textwidth]{\hrulefill}\par
                %\hspace{3pt}\makebox[0.993\textwidth]{\hrulefill}\par
            }\par
        }
    }{
        \noindent\hspace*{-3pt}\makebox[\textwidth][t]{
            \hspace*{-2pt}\parbox[t][5em][t]{\textwidth}{
                \sopheadq\space\space\@constraints
            }\par
          
        }
    }\par
    %\vspace*{3mm}
    \typeout{MakeConstraints ... done}
}
%% End Macro

% the actual containers for the scheduling constraints variables
\gdef\sopheadq{
    \mbox{{\bfseries Scheduling constraints and unusable dates}%
          \space{\itshape (up to 4 lines)}{\bfseries :}\space\space}%
}
\gdef\@constraints{}
\gdef\schedulingconstraints#1{\gdef\@constraints{#1}}


%% Macro: MakeAllocInfo
%% This macro creates the box with the summary of time requested and awarded
%% for this project and additional comment/justification lines.
 \DeclareRobustCommand{\MakeAllocInfo}{%
   \typeout{MakeAllocInfo ... entering}
   \ifthenelse{\equal{\@totalnights}{}}{\@sopwarningW}{\relax}
   \ifthenelse{\equal{\@totalchanged}{}}{\@sopwarningx}{\relax}
   \ifthenelse{\equal{\@totalUAO}{}}{\@sopwarningX}{\relax}
   \ifthenelse{\equal{\@currentrequest}{}}{\@sopwarningY}{\relax}
   % generate the summary of time requested and awarded
   \noindent\hspace{-3pt}\makebox[\textwidth][t]{
       \hspace{-3pt}\parbox[t][5em][t]{\textwidth}{
           \makebox[\textwidth]{\sopheadt}\par
           %*%\fixfbox{1.00in}{5mm}{s}{%
           \fixfbox{1.35in}{5mm}{s}{%
               \mbox{\bfseries Total: \@totalnights} \chflgbox%
           }\hspace*{3pt}
           %*%\fixfbox{2.25in}{5mm}{s}{%
           \fixfbox{3.30in}{5mm}{s}{\mbox{UAO: \@totalUAO}
               \mbox{CfA: \@totalCfA} \mbox{Other: \@totalOther}%
           }\hspace*{3pt}
           %*%\fixfbox{1.75in}{5mm}{s}{%
           %*%    Past: \@totalpast\ Anticipated: \@totalfuture%
           %*%}\hspace*{3pt}
           %*%\fixfbox{1.40in}{5mm}{s}{Current~request: \@currentrequest%
           \fixfbox{1.75in}{5mm}{s}{%
               \mbox{\bfseries Current~request:}
               \mbox{\bfseries \@currentrequest}%
           }\\[-8pt]

          \ifthenelse{\equal{\@totalchanged}{}}{
               \par\sopheadc\hrulefill\par
               \hrulefill\par\hrulefill\par\hrulefill\par
           }{
               \ifthenelse{\equal{\@totalchanged}{true} \or
                           \equal{\@totalchanged}{yes}}{
                   \ifthenelse{\equal{\@reasonforchange}{}}{
                       \@sopwarningy
                   }{
                       \parbox[t][2em][t]{0.995\textwidth}{
                           \sopheadc\@reasonforchange\par
                       }
                   }
              }{
                   \ifthenelse{\equal{\@reasonforchange}{}}{
                       \def\@reasonforchange{N/A}\par
                   }{\relax}
                   \parbox[t][2em][t]{0.995\textwidth}{
                       \sopheadc\@reasonforchange\par
                   }
               }
           }
       }
   }
   \typeout{MakeAllocInfo ... done}
 }
%% End Macro

%% Environment: TimeSummary
%% Dummy environments, used merely as a logical container to collect the info
%% associated with a single run to appear in the observing run summary table.
\newcounter{nTsum}
\newenvironment{TimeSummary}{
    \stepcounter{nTsum}
}{
    \relax
}

% actual containers for the time request/allocation variables
\gdef\sopheadt{
    \mbox{\bfseries Summary of time requested and awarded for this project}%
}
\gdef\sopheadc{
    \mbox{\bfseries Justify why current total differs from that on previous
          proposal {\normalfont\itshape (up to 3 lines)}:\space\space}
}
\gdef\@totalnights{}
\gdef\@totalchanged{}
\gdef\@reasonforchange{}
\gdef\@totalUAO{}
\gdef\@totalCfA{}
\gdef\@totalOther{}
\gdef\@totalpast{}
\gdef\@totalfuture{}
\gdef\@currentrequest{}
\gdef\totalnights#1       {\gdef\@totalnights{#1}}
\gdef\totalchanged#1      {\gdef\@totalchanged{#1}}
\gdef\reasonforchange#1   {\gdef\@reasonforchange{#1}}
\gdef\totalUAO#1          {\gdef\@totalUAO{#1}}
\gdef\totalCfA#1          {\gdef\@totalCfA{#1}}
\gdef\totalOther#1        {\gdef\@totalOther{#1}}
\gdef\totalpast#1         {\gdef\@totalpast{#1}}
\gdef\totalfuture#1       {\gdef\@totalfuture{#1}}
\gdef\currentrequest#1    {\gdef\@currentrequest{#1}}
\gdef\chflgbox{
    \ifthenelse{\equal{\@totalchanged}{true} \or
                \equal{\@totalchanged}{yes}}{
        \mbox{\bfseries\rlap{\ *}\Large$\Box\!\!$}%
    }{
        \mbox{\Large$\Box\!\!$}%
    }
}


%% Macro: MakeTargetList
%% This macro generates the target list on the reverse of the cover page
\DeclareRobustCommand{\MakeTargetList}{%
    \typeout{MakeTargetList ... entering}
    \typeout{  number of targets specified is \arabic{starget}.}
    \ifthenelse{ \value{target} < 1 }{
        \@sopwarningz
        % draw an empty box where the target table should have appeared
        \noindent\hspace*{-3pt}\makebox[\textwidth][t]{
            \parbox[t][1.5in][t]{0.995\textwidth}{
                \noindent\centerline{\sopheadl}\par
                \noindent\hspace*{-5pt}
                \fixmbox{0.25in}{4mm}{c}{\small \#}\hspace{2pt}
                \fixmbox{1.80in}{4mm}{c}{\small Object}
                \fixmbox{0.90in}{4mm}{c}{\small RA}
                \fixmbox{0.90in}{4mm}{c}{\small Dec}
                \fixmbox{2.64in}{4mm}{c}{\small mag\,/\,color\,/\,type\,/\,redshift\,/\,comment\,/\,etc.}
                \noindent\hspace*{-5pt}\mbox{
                    \fixfbox{0.25in}{4mm}{r}{1}\hspace{2pt}
                    \fixfbox{1.80in}{4mm}{l}{\null}
                    \fixfbox{0.90in}{4mm}{r}{\null}
                    \fixfbox{0.90in}{4mm}{r}{\null}
                    \fixfbox{2.64in}{4mm}{l}{\null}
                }\par
            }
        }\par
        \vfill
    }{
        % generate the table of targets
        \noindent\hspace*{-3pt}\makebox[\textwidth][t]{
            \parbox[t][4.75in][t]{0.995\textwidth}{
                \noindent\centerline{\sopheadl}\par
                \noindent\hspace*{-5pt}
                \fixmbox{0.25in}{4mm}{c}{\small \#}\hspace{2pt}
                \fixmbox{1.80in}{4mm}{c}{\small Object}
                \fixmbox{0.90in}{4mm}{c}{\small RA}
                \fixmbox{0.90in}{4mm}{c}{\small Dec}
                \fixmbox{2.64in}{4mm}{c}{\small
                    mag\,/\,color\,/\,type\,/\,redshift\,/\,comment\,/\,etc.
                }\\[-8pt]
                \fixmbox{6.47in}{4mm}{c}{\rule{6.45in}{0.1pt}}
                \ifthenelse{\equal{\objA@name}{}}{
                    \@sopwarningA
                    \def\objA@name{\raisebox{1pt}{
                        \footnotesize\itshape (Identify at least 1 object)}}
                }{\relax}
                \noindent\hspace*{-5pt}\mbox{
                    \fixmbox{0.25in}{4mm}{r}{1}\hspace{2pt}
                    \fixmbox{1.80in}{4mm}{l}{\objA@name}
                    \fixmbox{0.90in}{4mm}{r}{\objA@ra\space}
                    \fixmbox{0.90in}{4mm}{r}{\objA@dec\space}
                    \fixmbox{2.64in}{4mm}{l}{\space\objA@info}
                }\par
                \ifthenelse{ \value{target} > 1 }{
                    \ifthenelse{\equal{\objB@name}{}}{
                        \@sopwarningB
                    }{\relax}
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{2}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objB@name}
                        \fixmbox{0.90in}{4mm}{r}{\objB@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objB@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objB@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 2 }{
                    \ifthenelse{\equal{\objC@name}{}}{
                        \@sopwarningC
                    }{\relax}
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{3}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objC@name}
                        \fixmbox{0.90in}{4mm}{r}{\objC@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objC@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objC@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 3 }{
                    \ifthenelse{\equal{\objD@name}{}}{
                        \@sopwarningD
                    }{\relax}
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{4}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objD@name}
                        \fixmbox{0.90in}{4mm}{r}{\objD@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objD@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objD@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 4 }{
                    \ifthenelse{\equal{\objE@name}{}}{
                        \@sopwarningE
                    }{\relax}
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{5}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objE@name}
                        \fixmbox{0.90in}{4mm}{r}{\objE@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objE@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objE@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 5 }{
                    \ifthenelse{\equal{\objF@name}{}}{
                        \@sopwarningF
                    }{\relax}
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{6}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objF@name}
                        \fixmbox{0.90in}{4mm}{r}{\objF@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objF@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objF@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 6 }{
                    \ifthenelse{\equal{\objG@name}{}}{
                        \@sopwarningG
                    }{\relax}
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{7}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objG@name}
                        \fixmbox{0.90in}{4mm}{r}{\objG@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objG@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objG@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 7 }{
                    \ifthenelse{\equal{\objH@name}{}}{
                        \@sopwarningH
                    }{\relax}
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{8}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objH@name}
                        \fixmbox{0.90in}{4mm}{r}{\objH@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objH@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objH@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 8 }{
                    \ifthenelse{\equal{\objI@name}{}}{
                        \@sopwarningI
                    }{\relax}
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{9}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objI@name}
                        \fixmbox{0.90in}{4mm}{r}{\objI@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objI@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objI@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 9 }{
                    \ifthenelse{\equal{\objJ@name}{}}{
                        \@sopwarningJ
                    }{\relax}
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{10}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objJ@name}
                        \fixmbox{0.90in}{4mm}{r}{\objJ@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objJ@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objJ@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 10 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{11}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objK@name}
                        \fixmbox{0.90in}{4mm}{r}{\objK@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objK@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objK@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 11 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{12}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objL@name}
                        \fixmbox{0.90in}{4mm}{r}{\objL@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objL@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objL@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 12 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{13}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objM@name}
                        \fixmbox{0.90in}{4mm}{r}{\objM@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objM@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objM@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 13 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{14}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objN@name}
                        \fixmbox{0.90in}{4mm}{r}{\objN@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objN@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objN@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 14 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{15}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objO@name}
                        \fixmbox{0.90in}{4mm}{r}{\objO@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objO@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objO@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 15 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{16}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objP@name}
                        \fixmbox{0.90in}{4mm}{r}{\objP@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objP@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objP@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 16 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{17}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objQ@name}
                        \fixmbox{0.90in}{4mm}{r}{\objQ@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objQ@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objQ@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 17 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{18}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objR@name}
                        \fixmbox{0.90in}{4mm}{r}{\objR@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objR@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objR@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 18 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{19}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objS@name}
                        \fixmbox{0.90in}{4mm}{r}{\objS@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objS@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objS@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 19 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{20}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objT@name}
                        \fixmbox{0.90in}{4mm}{r}{\objT@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objT@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objT@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 20 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{21}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objU@name}
                        \fixmbox{0.90in}{4mm}{r}{\objU@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objU@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objU@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 21 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{22}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objV@name}
                        \fixmbox{0.90in}{4mm}{r}{\objV@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objV@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objV@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 22 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{23}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objW@name}
                        \fixmbox{0.90in}{4mm}{r}{\objW@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objW@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objW@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 23 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{24}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objX@name}
                        \fixmbox{0.90in}{4mm}{r}{\objX@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objX@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objX@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 24 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{25}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objY@name}
                        \fixmbox{0.90in}{4mm}{r}{\objY@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objY@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objY@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{target} > 25 }{
                    \noindent\hspace*{-5pt}\mbox{
                        \fixmbox{0.25in}{4mm}{r}{26}\hspace{2pt}
                        \fixmbox{1.80in}{4mm}{l}{\objZ@name}
                        \fixmbox{0.90in}{4mm}{r}{\objZ@ra\space}
                        \fixmbox{0.90in}{4mm}{r}{\objZ@dec\space}
                        \fixmbox{2.64in}{4mm}{l}{\space\objZ@info}
                    }\par
                }{\relax}
                \ifthenelse{ \value{starget} > 26 }{
                    \@sopwarningK
                }{\relax}
            }\par
        }
    }\\[-4pt]
    \fixmbox{6.47in}{4mm}{c}{\rule{6.45in}{0.1pt}}\par
    \typeout{MakeTargetList ... done}
}
%% End Macro

%% Environments: Target
%% Dummy environment, used merely as a logical container to collect the info
%% associated with a single target to appear in the table of targets.
\newcounter{target}
\newcounter{starget}
\newenvironment{Target}{
    \stepcounter{starget}
    \ifthenelse{ \value{starget} < 27 }{
        \stepcounter{target}
    }{\relax}
}{
    \relax%\typeout{Collected info for target \arabic{target}}
}

% the actual containers for the target data (up to 26)
\gdef\sopheadl{
    \mbox{\bfseries Target list (attach list if longer than 26 objects)}
}
\gdef\objA@name{}    \gdef\objJ@name{}    \gdef\objS@name{}
\gdef\objB@name{}    \gdef\objK@name{}    \gdef\objT@name{}
\gdef\objC@name{}    \gdef\objL@name{}    \gdef\objU@name{}
\gdef\objD@name{}    \gdef\objM@name{}    \gdef\objV@name{}
\gdef\objE@name{}    \gdef\objN@name{}    \gdef\objW@name{}
\gdef\objF@name{}    \gdef\objO@name{}    \gdef\objX@name{}
\gdef\objG@name{}    \gdef\objP@name{}    \gdef\objY@name{}
\gdef\objH@name{}    \gdef\objQ@name{}    \gdef\objZ@name{}
\gdef\objI@name{}    \gdef\objR@name{}
\gdef\objA@ra{}      \gdef\objJ@ra{}      \gdef\objS@ra{}
\gdef\objB@ra{}      \gdef\objK@ra{}      \gdef\objT@ra{}
\gdef\objC@ra{}      \gdef\objL@ra{}      \gdef\objU@ra{}
\gdef\objD@ra{}      \gdef\objM@ra{}      \gdef\objV@ra{}
\gdef\objE@ra{}      \gdef\objN@ra{}      \gdef\objW@ra{}
\gdef\objF@ra{}      \gdef\objO@ra{}      \gdef\objX@ra{}
\gdef\objG@ra{}      \gdef\objP@ra{}      \gdef\objY@ra{}
\gdef\objH@ra{}      \gdef\objQ@ra{}      \gdef\objZ@ra{}
\gdef\objI@ra{}      \gdef\objR@ra{}
\gdef\objA@dec{}     \gdef\objJ@dec{}     \gdef\objS@dec{}
\gdef\objB@dec{}     \gdef\objK@dec{}     \gdef\objT@dec{}
\gdef\objC@dec{}     \gdef\objL@dec{}     \gdef\objU@dec{}
\gdef\objD@dec{}     \gdef\objM@dec{}     \gdef\objV@dec{}
\gdef\objE@dec{}     \gdef\objN@dec{}     \gdef\objW@dec{}
\gdef\objF@dec{}     \gdef\objO@dec{}     \gdef\objX@dec{}
\gdef\objG@dec{}     \gdef\objP@dec{}     \gdef\objY@dec{}
\gdef\objH@dec{}     \gdef\objQ@dec{}     \gdef\objZ@dec{}
\gdef\objI@dec{}     \gdef\objR@dec{}
\gdef\objA@info{}    \gdef\objJ@info{}    \gdef\objS@info{}
\gdef\objB@info{}    \gdef\objK@info{}    \gdef\objT@info{}
\gdef\objC@info{}    \gdef\objL@info{}    \gdef\objU@info{}
\gdef\objD@info{}    \gdef\objM@info{}    \gdef\objV@info{}
\gdef\objE@info{}    \gdef\objN@info{}    \gdef\objW@info{}
\gdef\objF@info{}    \gdef\objO@info{}    \gdef\objX@info{}
\gdef\objG@info{}    \gdef\objP@info{}    \gdef\objY@info{}
\gdef\objH@info{}    \gdef\objQ@info{}    \gdef\objZ@info{}
\gdef\objI@info{}    \gdef\objR@info{}

\def\targname#1{\global\@namedef{obj\@Alph{\c@target}@name}{#1}}
\def\targra#1  {\global\@namedef{obj\@Alph{\c@target}@ra}{#1}}
\def\targdec#1 {\global\@namedef{obj\@Alph{\c@target}@dec}{#1}}
\def\targinfo#1{\global\@namedef{obj\@Alph{\c@target}@info}{#1}}


%% Macro: MakePiApproval
%% This macro creates the box for the instrument PI signature, to indicate
%% approval of the use of that instrument for the proposed observations.
\DeclareRobustCommand{\MakePiApproval}{%
    \typeout{MakePiApproval ... entering}
    \vspace*{7mm}
    \parbox[t][1.5em][t]{0.994\textwidth}{
        \sopheadr\space\space
        \ifthenelse{\equal{\@piapproval}{}}{
            {\hrulefill\\[-6pt]
            \rightline{\tiny\itshape (have instrument PI send confirmation email 
            to TAC chair}}
        }{
            \@piapproval
        }
    }\par
    \vspace*{-1mm}
    \typeout{MakePiApproval ... done}
}
%% End Macro

% the actual containers for the instrument PI approval variables
\gdef\sopheadr{
    \mbox{\bfseries Approval for Instrument Use from PI:}%
}
\gdef\@piapproval{}
\gdef\piapproval#1{\gdef\@piapproval{#1}}


%% Macro: MakeGradInfo
%% This macro creates a table with graduate student and advisor information,
%% and advisor signatures to indicate advisor approval.
\DeclareRobustCommand{\MakeGradInfo}{%
    \typeout{MakeGradInfo ... entering}
    \typeout{  number of graduate students identified is \arabic{graduate}}
    \null\vspace*{4pt}
    \ifthenelse{ \value{graduate} < 1 }{
        % draw an empty box where the graduate student table should appear
            \noindent\hspace*{-3pt}\makebox[\textwidth][t]{
            \parbox[t][2.0in][t]{0.995\textwidth}{
                \noindent\parbox[t]{0.995\textwidth}{\sopheadg}\\[4pt]
                \noindent\hspace*{-2pt}
                \fixmbox{1.75in}{4mm}{c}{\small Student's Name}
                \fixmbox{1.75in}{4mm}{c}{\small Advisor's Name}
                \fixmbox{2.00in}{4mm}{c}{\small Advisor's Email}
                \fixmbox{0.49in}{4mm}{c}{\small 2nd-yr}
                \fixmbox{0.48in}{4mm}{c}{\small Thesis}
                \noindent\hspace*{-2pt}\mbox{
                    \fixfbox{1.75in}{8mm}{l}{\null}
                    \fixfbox{1.75in}{8mm}{l}{\null}
                    \fixfbox{2.00in}{8mm}{c}{\null}
                    \fixfbox{0.49in}{8mm}{c}{\null}
                    \fixfbox{0.48in}{8mm}{c}{\null}
                }\par
            }
        }\par
        \vfill
    }{
        % generate the graduate student table
        \noindent\hspace*{-3pt}\makebox[\textwidth][t]{
            \parbox[t][2.0in][t]{0.995\textwidth}{
                \noindent\parbox[t]{0.995\textwidth}{\sopheadg}\\[4pt]
                \noindent\hspace*{-2pt}
                \fixmbox{1.75in}{4mm}{c}{\small Student's Name}
                \fixmbox{1.75in}{4mm}{c}{\small Advisor's Name}
                \fixmbox{2.00in}{4mm}{c}{\small Advisor's Email}
                \fixmbox{0.49in}{4mm}{c}{\small 2nd-yr}
                \fixmbox{0.48in}{4mm}{c}{\small Thesis}%\\[-8pt]
                %\fixmbox{6.48in}{4mm}{c}{\rule{6.45in}{0.1pt}}
                \ifthenelse{\equal{\gradA@name}{}}{
                    \@sopwarningL
                }{\relax}
                \ifthenelse{\equal{\gradA@thesis}{yes} \and
                            \not\equal{\@proppigrad}{true} \and
                            \not\equal{\@proppigrad}{yes}       }{
                    \@sopwarningBB
                }{\relax}
                \noindent\hspace*{-2pt}\mbox{
                    \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradA@name}}
                    \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradA@advisorname}}
                    \fixfbox{2.00in}{8mm}{l}{\raisebox{4pt}{\gradA@advisoremail}}
                    \fixfbox{0.49in}{8mm}{c}{\raisebox{4pt}{\gradA@secyr}}
                    \fixfbox{0.48in}{8mm}{c}{\raisebox{4pt}{\gradA@thesis}}
                }\par
                \ifthenelse{ \value{graduate} > 1 }{
                    \ifthenelse{\equal{\gradB@name}{}}{
                        \@sopwarningL
                    }{\relax}
                    \ifthenelse{\equal{\gradB@thesis}{yes} \and
                                \not\equal{\@proppigrad}{true} \and
                                \not\equal{\@proppigrad}{yes}       }{
                        \@sopwarningBB
                    }{\relax}
                    \noindent\hspace*{-2pt}\mbox{
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradB@name}}
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradB@advisorname}}
                        \fixfbox{2.00in}{8mm}{l}{\raisebox{4pt}{\gradB@advisoremail}}
                        \fixfbox{0.49in}{8mm}{c}{\raisebox{4pt}{\gradB@secyr}}
                        \fixfbox{0.48in}{8mm}{c}{\raisebox{4pt}{\gradB@thesis}}
                    }\par
                }{\relax}
                \ifthenelse{ \value{graduate} > 2 }{
                    \ifthenelse{\equal{\gradC@name}{}}{
                        \@sopwarningL
                    }{\relax}
                    \ifthenelse{\equal{\gradC@thesis}{yes} \and
                                \not\equal{\@proppigrad}{true} \and
                                \not\equal{\@proppigrad}{yes}       }{
                        \@sopwarningBB
                    }{\relax}
                    \noindent\hspace*{-2pt}\mbox{
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradC@name}}
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradC@advisorname}}
                        \fixfbox{2.00in}{8mm}{l}{\raisebox{4pt}{\gradC@advisoremail}}
                        \fixfbox{0.49in}{8mm}{c}{\raisebox{4pt}{\gradC@secyr}}
                        \fixfbox{0.48in}{8mm}{c}{\raisebox{4pt}{\gradC@thesis}}
                    }\par
                }{\relax}
                \ifthenelse{ \value{graduate} > 3 }{
                    \ifthenelse{\equal{\gradD@name}{}}{
                        \@sopwarningL
                    }{\relax}
                    \ifthenelse{\equal{\gradD@thesis}{yes} \and
                                \not\equal{\@proppigrad}{true} \and
                                \not\equal{\@proppigrad}{yes}       }{
                        \@sopwarningBB
                    }{\relax}
                    \noindent\hspace*{-2pt}\mbox{
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradD@name}}
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradD@advisorname}}
                        \fixfbox{2.00in}{8mm}{l}{\raisebox{4pt}{\gradD@advisoremail}}
                        \fixfbox{0.49in}{8mm}{c}{\raisebox{4pt}{\gradD@secyr}}
                        \fixfbox{0.48in}{8mm}{c}{\raisebox{4pt}{\gradD@thesis}}
                    }\par
                }{\relax}
                \ifthenelse{ \value{graduate} > 4 }{
                    \ifthenelse{\equal{\gradE@name}{}}{
                        \@sopwarningL
                    }{\relax}
                    \ifthenelse{\equal{\gradE@thesis}{yes} \and
                                \not\equal{\@proppigrad}{true} \and
                                \not\equal{\@proppigrad}{yes}       }{
                        \@sopwarningBB
                    }{\relax}
                    \noindent\hspace*{-2pt}\mbox{
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradE@name}}
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradE@advisor}}
                        \fixfbox{2.00in}{8mm}{l}{\raisebox{4pt}{\gradE@advisorname}}
                        \fixfbox{0.49in}{8mm}{c}{\raisebox{4pt}{\gradE@secyr}}
                        \fixfbox{0.48in}{8mm}{c}{\raisebox{4pt}{\gradE@thesis}}
                    }\par
                }{\relax}
                \ifthenelse{ \value{graduate} > 5 }{
                    \ifthenelse{\equal{\gradF@name}{}}{
                        \@sopwarningL
                    }{\relax}
                    \ifthenelse{\equal{\gradF@thesis}{yes} \and
                                \not\equal{\@proppigrad}{true} \and
                                \not\equal{\@proppigrad}{yes}       }{
                        \@sopwarningBB
                    }{\relax}
                    \noindent\hspace*{-2pt}\mbox{
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradF@name}}
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradF@advisor}}
                        \fixfbox{2.00in}{8mm}{l}{\raisebox{4pt}{\gradF@advisorname}}
                        \fixfbox{0.49in}{8mm}{c}{\raisebox{4pt}{\gradF@secyr}}
                        \fixfbox{0.48in}{8mm}{c}{\raisebox{4pt}{\gradF@thesis}}
                    }\par
                }{\relax}
                \ifthenelse{ \value{graduate} > 6 }{
                    \ifthenelse{\equal{\gradG@name}{}}{
                        \@sopwarningL
                    }{\relax}
                    \ifthenelse{\equal{\gradG@thesis}{yes} \and
                                \not\equal{\@proppigrad}{true} \and
                                \not\equal{\@proppigrad}{yes}       }{
                        \@sopwarningBB
                    }{\relax}
                    \noindent\hspace*{-2pt}\mbox{
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradG@name}}
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradG@advisor}}
                        \fixfbox{2.00in}{8mm}{l}{\raisebox{4pt}{\gradG@advisorname}}
                        \fixfbox{0.49in}{8mm}{c}{\raisebox{4pt}{\gradG@secyr}}
                        \fixfbox{0.48in}{8mm}{c}{\raisebox{4pt}{\gradG@thesis}}
                    }\par
                }{\relax}
                \ifthenelse{ \value{graduate} > 7 }{
                    \ifthenelse{\equal{\gradH@name}{}}{
                        \@sopwarningL
                    }{\relax}
                    \ifthenelse{\equal{\gradH@thesis}{yes} \and
                                \not\equal{\@proppigrad}{true} \and
                                \not\equal{\@proppigrad}{yes}       }{
                        \@sopwarningBB
                    }{\relax}
                    \noindent\hspace*{-2pt}\mbox{
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradH@name}}
                        \fixfbox{1.75in}{8mm}{l}{\raisebox{4pt}{\gradH@advisor}}
                        \fixfbox{2.00in}{8mm}{l}{\raisebox{4pt}{\gradH@advisorname}}
                        \fixfbox{0.49in}{8mm}{c}{\raisebox{4pt}{\gradH@secyr}}
                        \fixfbox{0.48in}{8mm}{c}{\raisebox{4pt}{\gradH@thesis}}
                    }\par
                }{\relax}
                \ifthenelse{ \value{graduate} > 8 }{
                    \@sopwarningM
                }{\relax}
            }
        }
    }
    \typeout{MakeGradInfo ... done}
}
%% End Macro

%% Environment: graduatestudent
%% Dummy environment, used merely as a logical container to collect the
%% names of the graduate students and their advisors
\newcounter{graduate}
\newenvironment{graduatestudent}{
    \stepcounter{graduate}
}{
    \ifthenelse{ \value{graduate} = 1 }{
        \ifthenelse{\equal{\gradA@secyr}{true}\or\equal{\gradA@secyr}{yes}}{
            \gdef\gradA@secyr{yes}
        }{  \gdef\gradA@secyr{no}}
        \ifthenelse{\equal{\gradA@thesis}{true}\or\equal{\gradA@thesis}{yes}}{
            \gdef\gradA@thesis{yes}
        }{  \gdef\gradA@thesis{no}}
    }{\relax}
    \ifthenelse{ \value{graduate} = 2 }{
        \ifthenelse{\equal{\gradB@secyr}{true}\or\equal{\gradB@secyr}{yes}}{
            \gdef\gradB@secyr{yes}
        }{  \gdef\gradB@secyr{no}}
        \ifthenelse{\equal{\gradB@thesis}{true}\or\equal{\gradB@thesis}{yes}}{
            \gdef\gradB@thesis{yes}
        }{  \gdef\gradB@thesis{no}}
    }{\relax}
    \ifthenelse{ \value{graduate} = 3 }{
        \ifthenelse{\equal{\gradC@secyr}{true}\or\equal{\gradC@secyr}{yes}}{
            \gdef\gradC@secyr{yes}
        }{  \gdef\gradC@secyr{no}}
        \ifthenelse{\equal{\gradC@thesis}{true}\or\equal{\gradC@thesis}{yes}}{
            \gdef\gradC@thesis{yes}
        }{  \gdef\gradC@thesis{no}}
    }{\relax}
    \ifthenelse{ \value{graduate} = 4 }{
        \ifthenelse{\equal{\gradD@secyr}{true}\or\equal{\gradD@secyr}{yes}}{
            \gdef\gradD@secyr{yes}
        }{  \gdef\gradD@secyr{no}}
        \ifthenelse{\equal{\gradD@thesis}{true}\or\equal{\gradD@thesis}{yes}}{
            \gdef\gradD@thesis{yes}
        }{  \gdef\gradD@thesis{no}}
    }{\relax}
    \ifthenelse{ \value{graduate} = 5 }{
        \ifthenelse{\equal{\gradE@secyr}{true}\or\equal{\gradE@secyr}{yes}}{
            \gdef\gradE@secyr{yes}
        }{  \gdef\gradE@secyr{no}}
        \ifthenelse{\equal{\gradE@thesis}{true}\or\equal{\gradE@thesis}{yes}}{
            \gdef\gradE@thesis{yes}
        }{  \gdef\gradE@thesis{no}}
    }{\relax}
    \ifthenelse{ \value{graduate} = 6 }{
        \ifthenelse{\equal{\gradF@secyr}{true}\or\equal{\gradF@secyr}{yes}}{
            \gdef\gradF@secyr{yes}
        }{  \gdef\gradF@secyr{no}}
        \ifthenelse{\equal{\gradF@thesis}{true}\or\equal{\gradF@thesis}{yes}}{
            \gdef\gradF@thesis{yes}
        }{  \gdef\gradF@thesis{no}}
    }{\relax}
    \ifthenelse{ \value{graduate} = 7 }{
        \ifthenelse{\equal{\gradG@secyr}{true}\or\equal{\gradG@secyr}{yes}}{
            \gdef\gradG@secyr{yes}
        }{  \gdef\gradG@secyr{no}}
        \ifthenelse{\equal{\gradG@thesis}{true}\or\equal{\gradG@thesis}{yes}}{
            \gdef\gradG@thesis{yes}
        }{  \gdef\gradG@thesis{no}}
    }{\relax}
    \ifthenelse{ \value{graduate} = 8 }{
        \ifthenelse{\equal{\gradH@secyr}{true}\or\equal{\gradH@secyr}{yes}}{
            \gdef\gradH@secyr{yes}
        }{  \gdef\gradH@secyr{no}}
        \ifthenelse{\equal{\gradH@thesis}{true}\or\equal{\gradH@thesis}{yes}}{
            \gdef\gradH@thesis{yes}
        }{  \gdef\gradH@thesis{no}}
    }{\relax}
}

% actual containers for the graduate student and advisor variables
\gdef\sopheadg{
    \mbox{\bfseries Graduate students} {\itshape (provide the following
          information if student is PI on
          the cover page or if this is a 2nd-year or Thesis program. Send confirmation email to TAC chair in place of signature.)
    }
}

\gdef\gradA@name{}    \gdef\gradA@advisor{}
\gdef\gradB@name{}    \gdef\gradB@advisor{}
\gdef\gradC@name{}    \gdef\gradC@advisor{}
\gdef\gradD@name{}    \gdef\gradD@advisor{}
\gdef\gradE@name{}    \gdef\gradE@advisor{}
\gdef\gradF@name{}    \gdef\gradF@advisor{}
\gdef\gradG@name{}    \gdef\gradG@advisor{}
\gdef\gradH@name{}    \gdef\gradH@advisor{}
\gdef\gradA@secyr{}   \gdef\gradA@thesis{}
\gdef\gradB@secyr{}   \gdef\gradB@thesis{}
\gdef\gradC@secyr{}   \gdef\gradC@thesis{}
\gdef\gradD@secyr{}   \gdef\gradD@thesis{}
\gdef\gradE@secyr{}   \gdef\gradE@thesis{}
\gdef\gradF@secyr{}   \gdef\gradF@thesis{}
\gdef\gradG@secyr{}   \gdef\gradG@thesis{}
\gdef\gradH@secyr{}   \gdef\gradH@thesis{}

\def\student#1{\global\@namedef{grad\@Alph{\c@graduate}@name}{#1}}
\def\advisorname#1{\global\@namedef{grad\@Alph{\c@graduate}@advisorname}{#1}}
\def\advisoremail#1{\global\@namedef{grad\@Alph{\c@graduate}@advisoremail}{#1}}
\def\secondyr#1{\global\@namedef{grad\@Alph{\c@graduate}@secyr}{#1}}
\def\thesis#1{\global\@namedef{grad\@Alph{\c@graduate}@thesis}{#1}}


%% Warning Messages --  at present, 56 (a-zA-Z) error conditions are caught
%% and hopefully meaningfull hints of how to resolve the issue are returned.
\gdef\@errindent{\space\space\space\space\space\space\space\space\space}
%
\DeclareRobustCommand{\@sopwarninga}{%
    \typeout{ }
    \typeout{  WARNING: \protect\propyear{}\space is empty. Please edit the
             proposal template file and}
    \typeout{  \@errindent provide the 4-digit year [2006--2030] of the
             proposed observations.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningb}{%
    \typeout{ }
    \typeout{  WARNING: the year specified in \protect\propyear{}\space is
             either out of range or has}
    \typeout{  \@errindent an invalid format. Please specify a 4-digit year
             [2006--2030].}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningc}{%
    \typeout{ }
    \typeout{  WARNING: \protect\propterm{}\space is empty. Please edit the
             proposal template file and}
    \typeout{  \@errindent specify a trimester [1,2,3] or semester [A,B].}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningd}{%
    \typeout{ }
    \typeout{  WARNING: the term identifier in \protect\propterm{}\space is
             invalid! Please}
    \typeout{  \@errindent specify a trimester [1,2,3] or semester [A,B].}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarninge}{%
    \typeout{ }
    \typeout{  WARNING: \protect\propcont{}\space is empty; assuming default
             value: 'false'.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningf}{%
    \typeout{ }
    \typeout{  WARNING: the program continuation flag value in
            \protect\propcont{}\space is invalid!}
    \typeout{  \@errindent Assuming default value: 'false'.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningg}{%
    %*%\typeout{ }
    %*%\typeout{  WARNING: \protect\proplong{}\space is empty; assuming default
    %*%         value: 'false'.}
    %*%\typeout{ }
}%
\DeclareRobustCommand{\@sopwarningh}{%
    \typeout{ }
    \typeout{  WARNING: the long-term program flag value in
             \protect\propcont{}\space is invalid!}
    \typeout{  \@errindent Assuming default value: 'false'.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningi}{%
    \typeout{ }
    \typeout{  WARNING: \protect\propltnr{}\space is empty. Please edit the
             proposal template file and}
    \typeout{  \@errindent provide the assigned long-term program number.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningj}{%
    \typeout{ }
    \typeout{  WARNING: the program number specified in
             \protect\propltnr{}\space appears to be negative!}
    \typeout{  \@errindent Please specify your assigned program number.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningk}{%
    \typeout{ }
    \typeout{  WARNING: \protect\proptitle{}\space is empty. Please edit the
             proposal template file and}
    \typeout{  \@errindent provide a descriptive, but concise proposal
             title.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningl}{%
    \typeout{ }
    \typeout{  WARNING: \protect\begin{PrincipalInvestigator}}
    \typeout{  \@errindent \space\space ..}
    \typeout{  \@errindent \protect\end{PrincipalInvestigator}}
    \typeout{  \@errindent block is missing in the proposal template file!
             Check whether}
    \typeout{  \@errindent it was inadvertently commented out or deleted.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningm}{%
    \typeout{ }
    \typeout{  WARNING: there appears to be more than one}
    \typeout{  \@errindent \space\space \protect\begin{PrincipalInvestigator}}
    \typeout{  \@errindent \space\space\space\space ..}
    \typeout{  \@errindent \space\space \protect\end{PrincipalInvestigator}}
    \typeout{  \@errindent block in the proposal template file!  Please 
             identify a single PI.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningn}{%
    \typeout{ }
    \typeout{  WARNING: \protect\PIname{}\space is empty. Please identify a
             principal investigator.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningo}{%
    \typeout{ }
    \typeout{  WARNING: \protect\PIinstitution{}\space is empty. Assuming
             default SO (Steward Observatory).}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningp}{%
    \typeout{ }
    \typeout{  WARNING: \protect\PIemail{}\space is empty. Please provide an
             e-mail address via which}
    \typeout{  \@errindent the PI (or actual observer) can be contacted.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningq}{%
    \typeout{ }
    \typeout{  WARNING: \protect\PIphone{}\space is empty. Please provide a
             telephone number via which}
    \typeout{  \@errindent the PI (or actual observer) can be contacted.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningr}{%
    \typeout{ }
    \typeout{  WARNING: empty \protect\begin{CoInvestigator} ..
             \protect\end{CoInvestigator} block!}
    \typeout{  \@errindent Please enter CoI information, or comment out this
             block.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarnings}{%
    \typeout{ }
    \typeout{  WARNING: \protect\propabstract{}\space is empty. Please edit
             the proposal template file}
    \typeout{  \@errindent and provide a concise abstract of the scientific
             justification.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningt}{%
    \typeout{ }
    \typeout{  WARNING: there should be at least one}
    \typeout{  \@errindent \space\space\protect\begin{ObservingRun}}
    \typeout{  \@errindent \space\space\space\space ..}
    \typeout{  \@errindent \space\space\protect\end{ObservingRun}}
    \typeout{  \@errindent block in the proposal template file! Check whether}
    \typeout{  \@errindent it was inadvertently commented out or deleted.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningu}{%
    \typeout{ }
    \typeout{  WARNING: too many observing runs specified! Please limit the
             total number of}
    \typeout{  \@errindent requested runs to 12 or less.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningv}{%
    \typeout{ }
    \typeout{  WARNING: alternate run number \altA@run , specified in
             \protect\alttorunnumber{}, is larger}
    \typeout{  \@errindent than the number of primary runs defined
             (\arabic{obsrun})!}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningw}{%
    \typeout{ }
    \typeout{  WARNING: too many alternate runs specified! Please limit the
             total number of}
    \typeout{  \@errindent requested alternate runs to 3 or less.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningx}{%
    \typeout{ }
    \typeout{  WARNING: \protect\totalchanged{} is empty! Please enter
             either 'true' or 'false'}
    \typeout{  \@errindent (without the quotes)}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningy}{%
    \typeout{ }
    \typeout{  WARNING: \protect\totalchanged{true}, but
             \protect\reasonforchange{} is empty!}
    \typeout{  \@errindent Please justify why the total time for this
             project estimated here}
    \typeout{  \@errindent differs from that on the most recent previous
             proposal.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningz}{%
    \typeout{ }
    \typeout{  WARNING: there should be at least one}
    \typeout{  \@errindent \space\space\protect\begin{Target}}
    \typeout{  \@errindent \space\space\space\space ..}
    \typeout{  \@errindent \space\space\protect\end{Target}}
    \typeout{  \@errindent block in the proposal template file! Check whether}
    \typeout{  \@errindent it was inadvertently commented out or deleted.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningA}{%
    \typeout{ }
    \typeout{  WARNING: \protect\targname{} is empty for target nr. 1! Please
             enter object name,}
    \typeout{  \@errindent RA, Dec, and any other relevant target properties.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningB}{%
    \typeout{ }
    \typeout{  WARNING: \protect\targname{} is empty for target nr. 2! Please
             enter object name,}
    \typeout{  \@errindent RA, Dec, and any other relevant target properties.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningC}{%
    \typeout{ }
    \typeout{  WARNING: \protect\targname{} is empty for target nr. 3! Please
             enter object name,}
    \typeout{  \@errindent RA, Dec, and any other relevant target properties.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningD}{%
    \typeout{ }
    \typeout{  WARNING: \protect\targname{} is empty for target nr. 4! Please
             enter object name,}
    \typeout{  \@errindent RA, Dec, and any other relevant target properties.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningE}{%
    \typeout{ }
    \typeout{  WARNING: \protect\targname{} is empty for target nr. 5! Please
             enter object name,}
    \typeout{  \@errindent RA, Dec, and any other relevant target properties.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningF}{%
    \typeout{ }
    \typeout{  WARNING: \protect\targname{} is empty for target nr. 6! Please
             enter object name,}
    \typeout{  \@errindent RA, Dec, and any other relevant target properties.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningG}{%
    \typeout{ }
    \typeout{  WARNING: \protect\targname{} is empty for target nr. 7! Please
             enter object name,}
    \typeout{  \@errindent RA, Dec, and any other relevant target properties.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningH}{%
    \typeout{ }
    \typeout{  WARNING: \protect\targname{} is empty for target nr. 8! Please
             enter object name,}
    \typeout{  \@errindent RA, Dec, and any other relevant target properties.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningI}{%
    \typeout{ }
    \typeout{  WARNING: \protect\targname{} is empty for target nr. 9! Please
             enter object name,}
    \typeout{  \@errindent RA, Dec, and any other relevant target properties.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningJ}{%
    \typeout{ }
    \typeout{  WARNING: \protect\targname{} is empty for target nr. 10!
             Please enter object name,}
    \typeout{  \@errindent RA, Dec, and any other relevant target properties.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningK}{%
    \typeout{ }
    \typeout{  WARNING: too many targets specified (\arabic{starget})!  Please
             limit the total number}
    \addtocounter{starget}{-1}
    \typeout{  \@errindent of targets to 26 or less.  Targets 
             26-\arabic{starget} have been ignored.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningL}{%
    \typeout{ }
    \typeout{  WARNING: empty \protect\begin{graduatestudent} ..
             \protect\end{graduatestudent} block!}
    \typeout{  \@errindent Please enter student information, or comment out
             this block.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningM}{%
    \typeout{ }
    \typeout{  WARNING: too many graduate students specified
             (\arabic{graduate})!  Please limit
             the total}
    \typeout{  \@errindent number of students to 8 or less.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningN}{%
    \typeout{ }
    \typeout{  WARNING: \protect\telescope{} for observing run nr. 1 is empty!
             Please enter a}
    \typeout{  \@errindent valid telescope identifier.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningO}{%
    \typeout{ }
    \typeout{  WARNING: \protect\secondary{} for observing run nr. 1 is empty!
             Please enter a}
    \typeout{  \@errindent valid secondary cage identifier.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningP}{%
    \typeout{ }
    \typeout{  WARNING: \protect\instrument{} for observing run nr. 1 is 
             empty! Please enter a}
    \typeout{  \@errindent valid instrument identifier.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningQ}{%
    \typeout{ }
    \typeout{  WARNING: \protect\piflag{} for observing run nr. 1 is empty!
             Assuming default}
    \typeout{  \@errindent value: 'false'.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningR}{%
    \typeout{ }
    \typeout{  WARNING: \protect\numnights{} for observing run nr. 1 is empty!
             Please enter the}
    \typeout{  \@errindent number of nights you are requesting.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningS}{%
    \typeout{ }
    \typeout{  WARNING: \protect\nightsky{} for observing run nr. 1 is empty!
             Please enter one}
    \typeout{  \@errindent of 'bright', 'grey' or 'dark'.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningT}{%
    \typeout{ }
    \typeout{  WARNING: \protect\optimalmonths{} for observing run nr. 1 is
             empty! Please enter}
    \typeout{  \@errindent the optimal month-range for the proposed
             observations using}
    \typeout{  \@errindent three-letter abbreviations for the months,
             seperated by a}
    \typeout{  \@errindent double-dash. E.g., Sep--Nov, Jan--Jan, etc..}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningU}{%
    \typeout{ }
    \typeout{  WARNING: \protect\acceptablemonths{} for observing run nr. 1
             is empty! Please}
    \typeout{  \@errindent enter the acceptable month-range for the proposed
             observations}
    \typeout{  \@errindent using three-letter abbreviations for the months,
             seperated}
    \typeout{  \@errindent by a double-dash. E.g., Sep--Nov, Jan--Jan, etc..}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningV}{%
    \typeout{ }
    \typeout{  WARNING: \protect\schedulingconstraints{} is empty!  Please
             enter any unusable}
    \typeout{  \@errindent dates and/or scheduling constraints. If there are
             no constraints,}
    \typeout{  \@errindent please enter 'None' (without the quotes).}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningW}{%
    \typeout{ }
    \typeout{  WARNING: \protect\totalnights{} is empty! Please enter the
             current estimate of the}
    \typeout{  \@errindent total number of nights from start to finish
             that this project}
    \typeout{  \@errindent will likely require, i.e., the sum of any past
             allocations, the}
    \typeout{  \@errindent presently requested nights, and the time
             anticipated in future}
    \typeout{  \@errindent requests. Please enter digits (integer number of
             nights.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningX}{%
   \typeout{ }
   \typeout{  WARNING: \protect\totalUAO{} is empty!  Please enter how many
            nights out of the}
   \typeout{  \@errindent total in \protect\totalnights are to be from UAO.}
   \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningY}{%
   \typeout{ }
   \typeout{  WARNING: \protect\currentrequest{} is empty!  Please enter the
            number of nights}
   \typeout{  \@errindent requested in the current proposal (sum of requested
            observing runs.}
   \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningZ}{%
    \typeout{ }
    \typeout{  WARNING: \protect\alttelescope{} for alternate run nr. 1 is
             empty! Please enter a}
    \typeout{  \@errindent valid telescope identifier, or comment out the
             possibly empty}
    \typeout{  \@errindent \space\space\protect\begin{AlternateRun}}
    \typeout{  \@errindent \space\space\space\space ..}
    \typeout{  \@errindent \space\space\protect\end{AlternateRun}}
    \typeout{  \@errindent block.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningAA}{%
    \typeout{ }
    \typeout{  WARNING: \protect\aoflag{} for observing run nr. 1 is empty!
             Assuming default}
    \typeout{  \@errindent value: 'false'.}
    \typeout{ }
}%
\DeclareRobustCommand{\@sopwarningBB}{%
    \typeout{ }
    \typeout{  WARNING: "Thesis" flag is set to 'yes', but P.I. is not a
             student!}
    \typeout{ }
}%
%% End Warning Messages


%% The scientific justification and the proposed observing program are typeset
%% (printed) as they are specified by the author. The observing run request(s)
%% are summarized in the "ObservingRun/AlternateRun" environment (above) and
%% collected in the table on the cover page. The target information is listed
%% in the table on the second cover page.

\DeclareRobustCommand{\propsection}{\@startsection{section}{1}{\z@}
    {7pt plus 4pt minus 2pt}{-1em}{\normalsize\bf\boldmath}}
\DeclareRobustCommand{\subsection}{\@startsection{subsection}{2}{\z@}
    {-3.25ex plus -1ex minus -.2ex}{1.5ex plus .2ex}{\normalsize\bf\boldmath}}

\renewcommand{\refname}{\normalsize References\vspace*{-8pt}}
\newenvironment{references}{%
    \subsubsection*{References}
    \setlength{\parskip}{0pt}
    \ltx@small
}{\relax}
\let\reference=\par

\DeclareRobustCommand{\instruct@font}{\small\sl $\!\!$}

\DeclareRobustCommand{\justif@head}{{\instruct@font \ \par}}

\DeclareRobustCommand{\feas@head}{{\instruct@font Describe your overall
    observational program. How will these observations contribute toward the
    accomplishment of the goals outlined in the science justification?  If 
    you've requested long-term status, justify why this is necessary for
    successful completion of the science. ({\bfseries\itshape up to one 
    page})\par}}

\DeclareRobustCommand{\ofac@head}{{\instruct@font List any time from partner
    institutions, going toward this {MMT/}\-{Magellan} project; who is the
    lead investigator on that time; list any time being asked from other
    facilities (e.g., Keck, NOAO, HST, Spitzer, etc..)\ for this project and
    whether there is need for any specific coordination; does the project's
    success depend on such capabilities not covered by UAO telescopes.\par}}
    %*%; list how many nights have been granted from {\bfseries all} sources,
    %*%and how many were weathered out; justify the number of remaining nights
    %*%toward completion of the project.\par}}

%\DeclareRobustCommand{\time@head}{{\instruct@font The TAC needs to understand
%    the scope of this project.  First, tell us how many UAO nights you've
%    already had for this project, how many you're asking for this time, and
%    give a good guess for how many you'll need to complete the project.
%    Second, if substantial amounts of the observing for this project are
%    coming from non-UAO telescopes, tell us about that observing, and tell us
%    how the UAO part fits in. Third, if you are collaborating with people who
%    have telescopes, and especially if you are part of a very large
%    collaboration, tell us who is leading the project, and how UAO time and
%    your participation fit into the large project. ({\bfseries\itshape up to
%    one page})\par}}

\DeclareRobustCommand{\time@head}{{\instruct@font The TAC needs to understand
    the scope of this project ---\\ (1) tell us how many UAO nights you've
    already had for this project, how many you request this time, and (a good
    guess of) how many you need to complete the project; (2) if a substantial
    amount of observing for this project comes from non-UAO telescopes, tell
    us about that observing, and how the UAO part fits in; (3) if you are
    collaborating with people who have telescopes, especially if you are part
    of a large collaboration, tell us who is leading the project, and how UAO
    time and your participation fit in. ({\bfseries\itshape up to one
    page})\par}}

\DeclareRobustCommand{\past@head}{{\instruct@font List {\bfseries all}
    allocations of telescope time for the present project and allocations for
    other projects on facilities available through UAO during the past 2 years,
    together with the current status of the data (cite publications where
    appropriate).  Mark those allocations related to the present proposal
    {(i.e, precede text with } \texttt{$\tt\backslash\!$related} command).
    ({\bfseries\itshape up to one page})\par}}
    %*%{\itshape This section does not count toward the page limit}.


\DeclareRobustCommand{\other@head}{{\instruct@font Provide any additional
    program-related information including, for example, relation of current program to
    externally funded research, to the development of expanded capabilities 
    for UA telescopes, or to individual timescales (e.g. PI is finishing postdoc appointment and this
    request would complete program).
    ({\bfseries\itshape up to one page})\par}}
    %*%{\itshape This section does not count toward the page limit}.
    
\DeclareRobustCommand{\sciencejustification}{
    \newpage\propsection{
        \hspace*{-2pt}\fixfbox{1.50in}{4mm}{c}{Scientific Justification}
    }
    \justif@head
}

\DeclareRobustCommand{\experimentaldesign}{
    \ifthenelse{\equal{\@proptermlong}{true}\or\equal{\@proptermlong}{yes}}{
        \ifthenelse{\value{page} > 5}{
            \typeout{ }
            \typeout{   WARNING: Scientific Justification page limit of 4
                     pages exceeded!}
            \typeout{ }
        }{\relax}
    }{
        \ifthenelse{\value{page} > 4}{
            \typeout{ }
            \typeout{   WARNING: Science Justification page limit of 3
                     pages exceeded!}
            \typeout{ }
        }{\relax}
    }
    \newpage\propsection{
        \hspace*{-2pt}\fixfbox{3.07in}{4mm}{c}{Experimental Design \&
              Technical Description}
    }
    \feas@head
}

\DeclareRobustCommand{\collaborations}{
    \vfill\propsection{
       \hspace*{-2pt}\fixfbox{1.05in}{4mm}{c}{Collaborations}
    }
    \ofac@head
}

\DeclareRobustCommand{\timerequest}{
    \vfill\propsection{
        \hspace*{-2pt}\fixfbox{2.90in}{4mm}{c}{Summary of Time Requested and Awarded}
    }
    \time@head
}

\DeclareRobustCommand{\pastuse}{
    \gdef\related{\mbox{$\!\!\!\!\star\,$}}
    \vfill\propsection{
         \hspace*{-2pt}\fixfbox{2.90in}{4mm}{c}{Previous Use of Steward Facilities}
    }
    \past@head
}

\DeclareRobustCommand{\otherinfo}{
    \gdef\related{\mbox{$\!\!\!\!\star\,$}}
    \vfill\propsection{
         \hspace*{-2pt}\fixfbox{2.0in}{4mm}{c}{Other Information}
    }
    \other@head
}


%% We only want page numbers at the top of each page and we turn off major
%% section numbering (subsection numbers will still work)
\DeclareRobustCommand{\ps@soprophead}{
    \def\@oddfoot{}
    \def\@evenfoot{}
    \def\@oddhead{\hbox to\textwidth{\small\sl\hfill Page \thepage\hfill}}
    \let\@evenhead\@oddhead
    % don't number major sections
    \setcounter{secnumdepth}{0}
    % don't complain about underfull \hbox
    \hbadness=100000
    % attempt to disable resizing of fonts
    \let\ltx@small       =\small         \gdef\small{\normalsize}
    \let\ltx@footnotesize=\footnotesize
    \let\ltx@obsheadsize =\footnotesize
    \gdef\footnotesize{\normalsize}
}

%% Redefine the \end{document} command
\DeclareRobustCommand{\revtex@pageid}{
    \def\@thefnmark{\null}
    \@footnotetext{\ltx@footnotesize\revtex@genre\space v\revtex@ver\space
                   (\revtex@date\space[\revtex@author]).}
}
\let\ltx@enddoc=\enddocument
\DeclareRobustCommand{\enddocument}{
   \typeout{EndDocument ... entering}
   \ifthenelse{\equal{\@proptermlong}{true}\or\equal{\@proptermlong}{yes}}{
       \typeout{  total number of pages is 2 cover pages + \arabic{page} and
                long-term is 'true'.}
       \ifthenelse{\value{page} > 7}{
           \typeout{ }
           \typeout{  WARNING: Nominal proposal page limit of 7 pages
                    exceeded!}
           %\typeout{  \@errindent This may be OK if this is due to the
           %         "Time Summary" and/or}
           %\typeout{  \@errindent "Collaborations" section(s) and no page
           %         limit warning}
           %\typeout{  \@errindent was issued for the "Scientific
           %         Justification" section.}
           \typeout{ }
       }{
           \typeout{  your proposal obeys the page limit.}
           \relax
       }
   }{
       \typeout{  total number of pages is 2 cover pages + \arabic{page} and
                long-term is 'false'.}
       \ifthenelse{\value{page} > 6}{
           \typeout{ }
           \typeout{  WARNING: Nominal proposal page limit of 6 pages
                    exceeded!}
           %\typeout{  \@errindent This may be OK if this is due to the
           %         "Time Summary" and/or}
           %\typeout{  \@errindent "Collaborations" section(s) and no page
           %         limit warning}
           %\typeout{  \@errindent was issued for the "Scientific
           %         Justification" section.}
           \typeout{ }
       }{
           \typeout{  your proposal obeys the page limit.}
           \relax
       }
   }
   \vfill
   \typeout{EndDocument ... done}
   \revtex@pageid\ltx@enddoc
}%

%% Set headers after the cover and target pages
\ps@soprophead


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simplified EPS inclusion macros, layered on Rokicki's dvips material,
%% that provide commands \plotone{EPSFILE}, \plottwo{EPSFILE}{EPSFILE}, and
%% \plotfiddle{EPSFILE}{VSIZE}{ANGLE}{HSIZ}{VSIZ}{HTRANS}{VTRANS}, where
%% \plotone inserts the plot in a space that is \columnwidth wide;  the
%% plot is scaled so the horizontal dimension fits in the text width,
%% and the vertical dimension is scaled to maintain the aspect ratio.
%% \plottwo inserts two plots next to each other in one \columnwidth,
%% sort of like "two-up" mode.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \ifundefined sequence
\def\ifundefined#1{\expandafter\ifx\csname#1\endcsname\relax}

% Include Rokicki's epsf.sty file explicitly.
\@ifundefined{epsfbox}{\input{epsf.sty}}{\relax}

%\epsfverbosetrue
\def\eps@scaling{.95}
\def\epsscale#1{\gdef\eps@scaling{#1}}

\def\plotone#1{\centering \leavevmode
    \epsfxsize=\eps@scaling\columnwidth \epsfbox{#1}}

\def\plottwo#1#2{\centering \leavevmode
    \epsfxsize=.45\columnwidth \epsfbox{#1} \hfil
    \epsfxsize=.45\columnwidth \epsfbox{#2}}

\def\plotfiddle#1#2#3#4#5#6#7{\centering \leavevmode
    \vbox to#2{\rule{0pt}{#2}}
    \special{psfile=#1 voffset=#7 hoffset=#6 vscale=#5 hscale=#4 angle=#3}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Convenient shorthand notations - compatible with AASTeX v4.0.
\newcommand{\lesssim}    {\mbox{\rlap{\hbox{\lower3pt\hbox{\ensuremath{\sim}}}}\raise1.5pt\hbox{\ensuremath{<}}}}%
\newcommand{\lsim}       {\lesssim}%
\newcommand{\la}         {\lesssim}% For Springer A&A compliance...
\newcommand{\gtrsim}     {\mbox{\rlap{\hbox{\lower3pt\hbox{\ensuremath{\sim}}}}\raise1.5pt\hbox{\ensuremath{>}}}}%
\newcommand{\gsim}       {\gtrsim}%
\newcommand{\ga}         {\gtrsim}%
\newcommand{\sq}         {\mbox{\rlap{\ensuremath{\sqcap}}\ensuremath{\sqcup}}}%
\newcommand{\arcdeg}     {\mbox{\ensuremath{{}^\circ}}}%
\newcommand{\arcmin}     {\mbox{\ensuremath{{}^\prime}}}%
\newcommand{\arcsec}     {\mbox{\ensuremath{{}^{\prime\prime}}}}%
\newcommand{\fd}         {\mbox{\ensuremath{.\mkern-4mu^{\rm d}}}}%
\newcommand{\fh}         {\mbox{\ensuremath{.\mkern-5mu^{\rm h}}}}%
\newcommand{\fm}         {\mbox{\ensuremath{.\mkern-6mu^{\rm m}}}}%
\newcommand{\fs}         {\mbox{\ensuremath{.\mkern-4mu^{\rm s}}}}%
\newcommand{\fdg}        {\mbox{\ensuremath{.\mkern-5mu^{\circ}}}}%
\newcommand{\farcd}      {\mbox{\ensuremath{.\mkern-5mu^{\circ}}}}%
\newcommand{\farcm}      {\mbox{\ensuremath{.\mkern-4mu^{\prime}}}}%
\newcommand{\farcs}      {\mbox{\ensuremath{.\mkern-5mu^{\prime\prime}}}}%
\newcommand{\fp}         {\mbox{\ensuremath{.\mkern-4mu^{\rm p}}}}%
\newcommand{\micron}     {\ensuremath{\mu\mbox{m}}}%
\newcommand{\kms}        {\ensuremath{\mbox{km\,s}^{-1}}}%
\newcommand{\kmsMpc}     {\ensuremath{\mbox{km\,s}^{-1}\,\mbox{Mpc}^{-1}}}%
\newcommand{\magarc}     {\ensuremath{\mbox{mag\,arcsec}^{-2}}}%
\newcommand{\fluxdens}   {\ensuremath{\mbox{ergs\,s}^{-1}\,\mbox{cm}^{-2}\,\mbox{\AA}{\!}^{-1}}}%
\newcommand{\case}[2]    {\mbox{\ensuremath{\frac{#1}{#2}}}}%
\newcommand{\slantfrac}[2]{\mbox{\ensuremath{\,^#1\!/_#2}}}%
\newcommand{\onehalf}    {\slantfrac{1}{2}}%
\newcommand{\onethird}   {\slantfrac{1}{3}}%
\newcommand{\twothirds}  {\slantfrac{2}{3}}%
\newcommand{\onequarter} {\slantfrac{1}{4}}%
\newcommand{\threequarters}{\slantfrac{3}{4}}%
\newcommand{\ubv}        {\mbox{\ensuremath{U\!BV}}}%
\newcommand{\ubvr}       {\mbox{\ensuremath{U\!BV\!R}}}%
\newcommand{\ub}         {\mbox{\ensuremath{U\!-\!B}}}%
\newcommand{\uv}         {\mbox{\ensuremath{U\!-\!V}}}%
\newcommand{\ur}         {\mbox{\ensuremath{U\!-\!R}}}%
\newcommand{\bv}         {\mbox{\ensuremath{B\!-\!V}}}%
\newcommand{\br}         {\mbox{\ensuremath{B\!-\!R}}}%
\newcommand{\bh}         {\mbox{\ensuremath{B\!-\!H}}}%
\newcommand{\bk}         {\mbox{\ensuremath{B\!-\!K}}}%
\newcommand{\vr}         {\mbox{\ensuremath{V\!-\!R}}}%
\newcommand{\vi}         {\mbox{\ensuremath{V\!-\!I}}}%
\newcommand{\ri}         {\mbox{\ensuremath{R\!-\!I}}}%
\newcommand{\jhk}        {\mbox{\ensuremath{J\!H\!K}}}%
\newcommand{\jk}         {\mbox{\ensuremath{J\!-\!K}}}%
\newcommand{\hk}         {\mbox{\ensuremath{H\!-\!K}}}%
\newcommand{\ebv}        {\mbox{\ensuremath{E(B\!-\!\V)}}}%
\newcommand{\Lya}        {\ensuremath{\mbox{Ly}\alpha}}%
\newcommand{\Lyb}        {\ensuremath{\mbox{Ly}\beta}}%
\newcommand{\Ha}         {\ensuremath{\mbox{H}\alpha}}%
\newcommand{\Hb}         {\ensuremath{\mbox{H}\beta}}%
\newcommand{\Hg}         {\ensuremath{\mbox{H}\gamma}}%
\newcommand{\Hd}         {\ensuremath{\mbox{H}\delta}}%
\newcommand{\Paa}        {\ensuremath{\mbox{Pa}\alpha}}%
\newcommand{\Pab}        {\ensuremath{\mbox{Pa}\beta}}%
\newcommand{\Pag}        {\ensuremath{\mbox{Pa}\gamma}}%
\newcommand{\Bra}        {\ensuremath{\mbox{Br}\alpha}}%
\newcommand{\Brb}        {\ensuremath{\mbox{Br}\beta}}%
\newcommand{\Brg}        {\ensuremath{\mbox{Br}\gamma}}%
\newcounter{ion}
\newcommand{\ion}[2]     {\setcounter{ion}{#2}\mbox{#1\,{\fontsize{9pt}{9}\selectfont\@\Roman{ion}}}}%
\newcommand{\HI}         {\mbox{\ion{H}{1}}}%
\newcommand{\HII}        {\mbox{\ion{H}{2}}}%
\newcommand{\HeI}        {\mbox{\ion{He}{1}}}%
\newcommand{\HeII}       {\mbox{\ion{He}{2}}}%
\newcommand{\HeIII}      {\mbox{\ion{He}{3}}}%
\newcommand{\nodata}     { ~\ensuremath{\cdots}~ }%
\newcommand{\sun}        {\mbox{\ensuremath{\odot}}}%
\newcommand{\Sun}        {\sun}%
\newcommand{\Sol}        {\sun}%
\newcommand{\earth}      {\mbox{\ensuremath{\oplus}}}%
\newcommand{\Earth}      {\earth}%
\newcommand{\Terra}      {\earth}%

% Journal abbreviations
\def\aj{\rmfamily{AJ~}}           % Astronomical Journal
\def\apj{\rmfamily{ApJ~}}         % Astrophysical Journal
\def\apjl{\rmfamily{ApJ~}}        % Astrophysical Journal, Letters
\def\apjs{\rmfamily{ApJS~}}       % Astrophysical Journal, Supplement
\let\apjlett=\apjl
\let\apjsupp=\apjs
\def\aap{\rmfamily{A\&A~}}        % Astronomy and Astrophysics
\let\astap=\aap
\def\araa{\rmfamily{ARA\&A~}}     % Annual Review of Astronomy and Astrophysics
\def\aapr{\rmfamily{A\&A~Rev.~}}  % Astronomy and Astrophysics Reviews
\def\aaps{\rmfamily{A\&AS~}}      % Astronomy and Astrophysics, Supplement
\def\mnras{\rmfamily{MNRAS~}}     % Monthly Notices of the Royal Astron. Soc.
\def\pasp{\rmfamily{PASP~}}       % Publications of the Astron. Soc. o/t Pacific
\def\apss{\rmfamily{Ap\&SS~}}     % Astrophysics and Space Science
\def\pasj{\rmfamily{PASJ~}}       % Publications of the Astron. Soc. of Japan
\def\pra{\rmfamily{Phys.~Rev.~A~}}% Physical Review A: Atomic, Molecular, and  
                                  %   Optical Physics
\def\prb{\rmfamily{Phys.~Rev.~B~}}% Physical Review B: Condensed Matter and
                                  %   Materials Physics
\def\prc{\rmfamily{Phys.~Rev.~C~}}% Physical Review C: Nuclear Physics
\def\prd{\rmfamily{Phys.~Rev.~D~}}% Physical Review D: Particles, Fields,
                                  %   Gravitation and Cosmology
\def\pre{\rmfamily{Phys.~Rev.~E~}}% Physical Review E: Statistical, Nonlinear,
                                  %   and Soft Matter Physics
\def\rmp{\rmfamily{Rev.~Mod.~Phys.~}}% Reviews of Modern Physics
\def\prl{\rmfamily{Phys.~Rev.~Lett.~}}% Physical Review Letters
\def\nat{\rmfamily{Nature~}}      % Nature
\def\sci{\rmfamily{Science~}}     % Science
\def\skytel{\rmfamily{S\&T~}}     % Sky and Telescope
\def\ao{\rmfamily{Appl.~Opt.~}}   % Applied Optics
\let\applopt=\ao
\def\azh{\rmfamily{AZh~}}         % Astronomicheskii Zhurnal
\def\baas{\rmfamily{BAAS~}}       % Bulletin of the AAS
\def\jrasc{\rmfamily{JRASC~}}     % Journal of the Royal Astron. Soc. of Canada
\def\memras{\rmfamily{MmRAS~}}    % Memoirs of the Royal Astron. Soc.
\def\qjras{\rmfamily{QJRAS~}}     % Quarterly Journal of the Royal Astron. Soc.
\def\solphys{\rmfamily{Sol.~Phys.~}}% Solar Physics
\def\sovast{\rmfamily{Soviet~Ast.~}}% Soviet Astronomy
\def\ssr{\rmfamily{Space~Sci.~Rev.~}}% Space Science Reviews
\def\zap{\rmfamily{ZAp~}}         % Zeitschrift fuer Astrophysik
\def\iauc{\rmfamily{IAU~Circ.~}}  % IAU Cirulars
\let\iaucirc=\iauc
\def\aplett{\rmfamily{Astrophys.~Lett.~}}% Astrophysics Letters
\def\apspr{\rmfamily{Astrophys.~Space~Phys.~Res.~}}% Astrophysics Space Physics
                                  % Research
\def\bain{\rmfamily{Bull.~Astron.~Inst.~Netherlands~}}% Bulletin of the 
                                  % Astronomical Institute of the Netherlands
\def\fcp{\rmfamily{Fund.~Cosmic~Phys.~}}% Fundamental Cosmic Physics
\def\gca{\rmfamily{Geochim.~Cosmochim.~Acta~}}% Geochimica Cosmochimica Acta
\def\grl{\rmfamily{Geophys.~Res.~Lett.~}}% Geophysics Research Letters
\def\jcp{\rmfamily{J.~Chem.~Phys.~}}% Journal of Chemical Physics
\def\jgr{\rmfamily{J.~Geophys.~Res.~}}% Journal of Geophysics Research
\def\jqsrt{\rmfamily{J.~Quant.~Spec.~Radiat.~Transf.~}} % Journal of Quantitative
                                  % Spectroscopy and Radiative Transfer
\def\memsai{\rmfamily{Mem.~Soc.~Astron.~Italiana~}}
                                  % Mem. Societa Astronomica Italiana
\def\nphysa{\rmfamily{Nucl.~Phys.~A~}}% Nuclear Physics A
\def\physrep{\rmfamily{Phys.~Rep.~}}% Physics Reports
\def\physscr{\rmfamily{Phys.~Scr~}}% Physica Scripta
\def\planss{\rmfamily{Planet.~Space~Sci.~}}% Planetary Space Science
\def\procspie{\rmfamily{Proc.~SPIE~}}% Proceedings of the SPIE
\def\aipconf{\rmfamily{AIP~Conf.~Proc.~}}% AIP Conference Proceedings
\def\aspconf{\rmfamily{ASP~Conf.~Ser.~}}% ASP Conference Series
\def\asslconf{\rmfamily{Ap\&SSL~Conf.~Ser.~}}% ASSL Conference Series}
\def\maps{\rmfamily{MAPS~}}       % Meteoritics and Planetary Science

%%%%%%%%%%%%%%%%%%%%%%%%%%%%   RAJ - Aug 01 2007  %%%%%%%%%%%%%%%%%%%%%%%%%%%%

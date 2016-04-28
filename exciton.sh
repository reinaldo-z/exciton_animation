#!/bin/bash

files=3exciton
frames=5

step1=1
step2=0

for (( i = 1; i <= $frames+1; i++ )); do


echo "\documentclass[border=2mm]{standalone}
\usepackage{amsmath}
\usepackage{pgfplots}
\usetikzlibrary{3d,calc}

\pgfplotsset{compat=1.12}
\begin{document}


%%% EXCITON
 \begin{tikzpicture}
   \begin{axis}[hide axis][
    clip=false,
    xmin=0,xmax=10*pi,
    ymin=-3,ymax=3,
    axis lines=middle,
    xtick=\empty,
    ytick=\empty,
    ]
     %%%% Auxiliar code to have same frame size: objects in white color
     \addplot[domain=-2*pi:1*pi,samples=200,white,thick]{0.5*sin(deg(x))}
                               node[right,pos=0.9,font=\footnotesize]{};
     \draw [white, thick, ->] (-2.03*pi,0) -- (1*pi,0) node [right] {};
     \draw [white] (-1.5*pi,0.6) node [left] {$\overrightarrow{E}$};


     \addplot[domain=0:10*pi,samples=200,black,thick]{-1+sin(deg(x/10))}
                               node[right,pos=0.9,font=\footnotesize]{};
     \addplot[domain=0:10*pi,samples=200,black,thick]{2-sin(deg(x/10))}
                               node[right,pos=0.9,font=\footnotesize]{};

     
     %%%% Electrom moves from (5*pi,0) to (5*pi,1)
     \shade[ball color=white!60!white,opacity=0.4] (5*pi,0) circle (0.2cm); %% hole
     \draw [] (5.2*pi,0.15) node [right] {hole};
     \shade[ball color=gray!50!white,opacity=1] (5*pi,1) circle (0.2cm); %% electron
     \draw [] (5.2*pi,0.9) node [right] {\$e^{-}\$};
     \draw [] (4.6*pi,-0.6) node [left] {IPA};

     %%%% Green arrow banishing
     \draw [green, thick, ->, opacity=$step1] (5*pi,0) -- (5*pi,1)  node [right] {};
     %%%% Blue arrows and text apearing
     \draw [blue, thick, ->, opacity=$step2] (5*pi,1) -- (5*pi,0.5)  node [right] {};
     \draw [blue, thick, ->, opacity=$step2] (5*pi,0) -- (5*pi,0.5)  node [right] {};
     \draw [opacity=$step2] (5*pi,0.6)  node [left] {exciton:  \hspace{3mm}};
     \draw [opacity=$step2] (5*pi,0.4)  node [left] {Coulomb force  \hspace{3mm}};

   \end{axis}
 \end{tikzpicture}

\end{document}" >> "$files"_`printf "%03d\n" $i`.tex

step1=`echo "$step1-1.5/$frames" | bc -l`
step2=`echo "$step2+1.5/$frames" | bc -l`


pdflatex "$files"_`printf "%03d\n" $i`.tex
rmtex "$files"_`printf "%03d\n" $i`.
rm "$files"_`printf "%03d\n" $i`.tex

done










############################



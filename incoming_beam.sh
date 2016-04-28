#!/bin/bash

files=1incoming_beam
frames=100
step1=-1.999999999

for (( i = 1; i <= $frames; i++ )); do

step1=`echo "$step1+7.0/$frames" | bc -l`

echo "\documentclass[border=2mm]{standalone}
\usepackage{amsmath}
\usepackage{pgfplots}
\usetikzlibrary{3d,calc}

\pgfplotsset{compat=1.12}
\begin{document}

%%%% INCOMING BEAM
 \begin{tikzpicture}
   \begin{axis}[hide axis][
    clip=false,
    xmin=0,xmax=10*pi,
    ymin=-3,ymax=3,
    axis lines=middle,
    xtick=\empty,
    ytick=\empty,
    ]
     \addplot[domain=0:10*pi,samples=200,black,thick]{-1+sin(deg(x/10))}
                               node[right,pos=0.9,font=\footnotesize]{};
     \addplot[domain=0:10*pi,samples=200,black,thick]{2-sin(deg(x/10))}
                               node[right,pos=0.9,font=\footnotesize]{};
     
     \shade[ball color=gray!50!white,opacity=1] (5*pi,0) circle (0.2cm);
     \draw [] (5.2*pi,0.25) node [right] {\$e^{-}\$};
     
     %%%% INCOMING BEAM FROM -2*pi TO 5*pi -> RANGE OF 7
     \addplot[domain=-2*pi:$step1*pi,samples=200,red,thick]{0.5*sin(deg(x))}
                               node[right,pos=0.9,font=\footnotesize]{};
     \draw [red, thick, ->] (-2*pi,0) -- ($step1*pi,0) node [right] {};
     \draw [] (-1.5*pi,0.6) node [left] {$\overrightarrow{E}$};
     \draw [] (4.6*pi,-0.6) node [left] {IPA};
   \end{axis}
 \end{tikzpicture}


\end{document}" >> "$files"_"$i".tex

pdflatex "$files"_"$i".tex
rmtex "$files"_"$i".
rm "$files"_"$i".tex

done

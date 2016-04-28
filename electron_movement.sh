#!/bin/bash

files=2electron_movement
frames=80

step=0
step2=0.15
step3=0

for (( i = 1; i <= $frames+1; i++ )); do


echo "\documentclass[border=2mm]{standalone}
\usepackage{amsmath}
\usepackage{pgfplots}
\usetikzlibrary{3d,calc}

\pgfplotsset{compat=1.12}
\begin{document}

% %%%% ELECTRON MOVEMENT
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
     \shade[ball color=gray!50!white,opacity=1] (5*pi,$step) circle (0.2cm); %% electron
     \draw [green, thick, ->] (5*pi,0) -- (5*pi,$step)  node [right] {};
     \draw [] (5.2*pi,$step2) node [right] {\$e^{-}\$};
     \draw [opacity=$step3] (5.2*pi,0.15) node [right] {hole};
     \draw [] (4.6*pi,-0.6) node [left] {IPA};   \end{axis}
 \end{tikzpicture}

\end{document}" >> "$files"_"$i".tex

step=`echo "$step+1.0/$frames" | bc -l`
step2=`echo "$step2+0.75/$frames" | bc -l`
step3=`echo "$step3+1.0/$frames" | bc -l`


pdflatex "$files"_"$i".tex
rmtex "$files"_"$i".
rm "$files"_"$i".tex

done

echo "$step2"

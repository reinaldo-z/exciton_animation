#!/bin/bash

latex () {
    
    pdflatex ipa-frame`printf "%03d\n" $i`.tex
    rmtex ipa-frame`printf "%03d\n" $i`.
    rm ipa-frame`printf "%03d\n" $i`.tex

}

incoming_beam () {

step1=-1.999999999

for (( i = 1; i <= $1; i++ )); do

step1=`echo "$step1+7.0/$1" | bc -l`

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
     \draw [] (5.2*pi,0.15) node [right] {\$e^{-}\$};
     
     %%%% INCOMING BEAM FROM -2*pi TO 5*pi -> RANGE OF 7
     \addplot[domain=-2*pi:$step1*pi,samples=200,red,thick]{0.5*sin(deg(x))}
                               node[right,pos=0.9,font=\footnotesize]{};
     \draw [red, thick, ->] (-2*pi,0) -- ($step1*pi,0) node [right] {};
     \draw [] (-1.5*pi,0.6) node [left] {$\overrightarrow{E}$};
     \draw [] (6*pi,-0.6) node [left] {IPA};
   \end{axis}
 \end{tikzpicture}


\end{document}" >> ipa-frame`printf "%03d\n" $i`.tex

latex

done

parse=$i

}


################################################################################


electron_movement () {


step=0
step2=0.15
step3=0
step4=1

for (( i = $parse; i <= $parse+$1; i++ )); do


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
     %%%% Auxiliar code to have same ipa-frame size: objects in white color
     \addplot[domain=-2*pi:1*pi,samples=200,white,thick]{0.5*sin(deg(x))}
                               node[right,pos=0.9,font=\footnotesize]{};
     \draw [white, thick, ->] (-2.03*pi,0) -- (1*pi,0) node [right] {};
     \draw [white] (-1.5*pi,0.6) node [left] {$\overrightarrow{E}$};


     \addplot[domain=0:10*pi,samples=200,black,thick]{-1+sin(deg(x/10))}
                               node[right,pos=0.9,font=\footnotesize]{};
     \addplot[domain=0:10*pi,samples=200,black,thick]{2-sin(deg(x/10))}
                               node[right,pos=0.9,font=\footnotesize]{};

     
     %%%% Electrom moves from (5*pi,0) to (5*pi,1)
     % \shade[ball color=white!60!white,opacity=0.4] (5*pi,0) circle (0.2cm); %% hole
     \shade[ball color=gray!50!white,opacity=1] (5*pi,$step) circle (0.2cm); %% electron
     \draw [red, thick, ->] (5*pi,0) -- (5*pi,$step)  node [right] {}; %% arrow
     \draw [] (5.2*pi,$step2) node [right] {\$e^{-}\$};
     \draw [opacity=$step3, red] (6.2*pi,0.5) node [right] {\$\hbar \omega$};
     % \draw [opacity=$step3] (5.2*pi,0.15) node [right] {hole}; 
     \draw [] (6*pi,-0.6) node [left] {IPA};
     \end{axis}
 \end{tikzpicture}

\end{document}" >> ipa-frame`printf "%03d\n" $i`.tex

step=`echo "$step+1.0/$1" | bc -l`    ### used to create the arrow
step2=`echo "$step2+0.75/$1" | bc -l` ### used to momve "e-"
step3=`echo "$step3+1.0/$1" | bc -l`  ### used to appear "hole"
step4=`echo "$step4-1.0/$1" | bc -l`  ### used to vanish IPA


latex

done

parse=$i

}


# ################################################################################


# incoming_beam 70
# electron_movement 30

incoming_beam 40
electron_movement 20


# 70 30 20

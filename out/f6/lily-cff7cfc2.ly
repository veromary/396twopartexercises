%% Generated by lilypond-book
%% Options: [indent=0\mm,line-width=512\pt]
\include "lilypond-book-preamble.ly"


% ****************************************************************
% Start cut-&-pastable-section
% ****************************************************************



\paper {
  indent = 0\mm
  line-width = 512\pt
  % offset the left padding, also add 1mm as lilypond creates cropped
  % images with a little space on the right
  line-width = #(- line-width (* mm  3.000000) (* mm 1))
}

\layout {
  
}





% ****************************************************************
% ly snippet:
% ****************************************************************
\sourcefileline 30
<< 
\new Staff {
\relative c' {
c1 d e f g a b c \bar "||"
}}
\new Staff { 
\relative c'' {
r4 c d c b c b a g a b c d e d c b c d e f e d c b a g f e1
}}>>




% ****************************************************************
% end ly snippet
% ****************************************************************

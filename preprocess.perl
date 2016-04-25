#!/usr/bin/perl

#use strict;

my $FILE = $ARGV[0];
my $PAGE = $ARGV[1];
my $INLINE = "";
my @VARS;
my $OUT = "main.3.lytex";
my $OUTTEX = "main.3.tex";
my $OUTPDF = "main.3.pdf";

my $EXERCISE;
my $TIME;
my $TOP;
my $TOPOCTAVE;
my $BOTTOM;
my $BOTTOMOCTAVE;
my $KEY = "c \\major";

#Clear output from previous run
system("rm $OUT");
system("rm $OUTTEX");

#Format: \exercise{No.}{time}{relative}{top_line}{relative}{bottom_line}

open (OUTPUT,">".$OUT);
open (SCORE,"<".$FILE) or die "No such file: $FILE\n";
while ($INLINE = <SCORE>) {
  if ($INLINE =~ m/\\key(.*?)/) {
    $INLINE =~ s/\n//;
    $INLINE =~ s/^[^{]*{//;
    $INLINE =~ s/}$//;
    $KEY = $INLINE;
    $INLINE = "";
  }
  if ($INLINE =~ m/\\exercise(.*?)/) {
    $INLINE =~ s/\n//;
    $INLINE =~ s/^[^{]*{//;
    $INLINE =~ s/}$//;
    
    ($EXERCISE, $TIME, $TOPOCTAVE, $TOP, $BOTTOMOCTAVE, $BOTTOM) = split /}{/, $INLINE;

    print OUTPUT "\\subsection{No. $EXERCISE.}\n\n";
    print OUTPUT "\\begin{lilypond}\n";
    print OUTPUT "\\score {\n";
    print OUTPUT "  \<\<\n";
    print OUTPUT "    \\new Staff {\n";
    if ($TIME != "") {
      if ($TIME == "4/2") {
        print OUTPUT "\\once \\override Staff.TimeSignature #'stencil = #ly:text-interface::print\n";
        print OUTPUT "\\once \\override Staff.TimeSignature #'text = \\markup \\musicglyph #\"timesig.C22\"\n";
        print OUTPUT "\\time $TIME\n";
      }
      else {
        print OUTPUT "    \\time $TIME\n";
      }
    }
    print OUTPUT "      \\key $KEY\n";
    print OUTPUT "      \\relative $TOPOCTAVE {\n";
    if ($TOP =~ m/r4/) {
      print OUTPUT "        \\override Staff.Rest #'style = #'classical\n";
    }
    print OUTPUT "        $TOP \\bar \"||\"\n";
    print OUTPUT "      }\n";
    print OUTPUT "    }\n";
    print OUTPUT "    \\new Staff {\n";
      if ($TIME == "4/2") {
        print OUTPUT "\\once \\override Staff.TimeSignature #'stencil = #ly:text-interface::print\n";
        print OUTPUT "\\once \\override Staff.TimeSignature #'text = \\markup \\musicglyph #\"timesig.C22\"\n";
        print OUTPUT "\\time $TIME\n";
      }
    print OUTPUT "      \\key $KEY\n";
    print OUTPUT "      \\relative $BOTTOMOCTAVE {\n";
#Lily2.18: override Staff.Rest.style = #'classical
    if ($BOTTOM =~ m/r4/) {
    print OUTPUT "        \\override Staff.Rest #'style = #'classical\n"; 
    }
    print OUTPUT "        $BOTTOM\n";
    print OUTPUT "      }\n";
    print OUTPUT "    }\n";
    print OUTPUT "  >>\n";
    print OUTPUT "  \\layout {\n";
    print OUTPUT "  }\n";
    print OUTPUT "  \\midi {\n";
    print OUTPUT "  }\n";
    print OUTPUT "}\n";
    print OUTPUT "\\end{lilypond}\n\n";
  }
  else {
    print OUTPUT $INLINE;
  }
}

# 

system("lilypond-book $OUT");
system("lualatex --shell-escape $OUTTEX");
system("xpdf -cont -g 1100x260+0+500 -z 150 $OUTPDF $PAGE");

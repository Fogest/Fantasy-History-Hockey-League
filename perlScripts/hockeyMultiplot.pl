#!/usr/bin/perl
use strict;
use warnings;
#
#  Use the R Perl module for the ggplot2 graphics
#
use Statistics::R;

my @passInfo;
$passInfo[0] = "print1.csv";
$passInfo[1] = "ASDASD";
$passInfo[2] = "print2.csv";
$passInfo[3] = "TEAM2";
$passInfo[4] = "print3.csv";
$passInfo[5] = "JOSH";
$passInfo[6] = "out.pdf";

&pdfMultiplot(@passInfo);

#
#  Use the multiplot R function to plot multiple plots 
#  on one page

#require 'multiplotR.pl';

#
#  hockeyMultiplot.pl
#  Author: Deborah Stacey
#  Date of Last Update: Monday, February 16, 2015
#  Synopsis: plot multiple R (ggplot2) plots on one PDF page
#

#IN      Array[filename1,filename2,filename3,...,output file path]
#OUT     Shit gets printed
sub pdfMultiplot
{
   if (scalar @_ < 1 )
   {
      print "[filename1,Team name year1, filename2, Team name year2,filename3,...,output file path]\n";
      return;
   }

   my @infer = @_;
   my @in_file;
   my @teamNameYear;
   my $count = (scalar @infer - 1) / 2;

   for ( my $i=0; $i<$count; $i++ )
   {
      $in_file[$i]  = "print/$infer[$i*2]";
      $teamNameYear[$i] = "$infer[$i*2+1]";
   }
   my $out_file  = $infer[$count*2];
   my $cols      = 2;

   my $title = "";

   # Create a communication bridge with R and start R
   my $R = Statistics::R->new();

   # Name the PDF output file for the plot  
   my $Rplots_file = $out_file;

   # Set up the PDF file for plots
   $R->run(qq`pdf("$Rplots_file" , paper="letter")`);

   # Load the plotting library
   $R->run(q`library(ggplot2)`);

   #
   # Include the multiplotR definition
   #
   $R = multiplotR($R);
   my $string = "multiplot(";
   my $j = 0;

   my $size  = 15 - (($cols-1) * 5);

   for ( my $i=1; $i<=$count; $i++ ) {
   #
   #  Create plot
   #
      $j = $i - 1;
      $R->run(qq`data <- read.csv("$in_file[$j]")`);
      $title = "$teamNameYear[$j]";

      $R->run(qq`p$i <- ggplot(data, aes(x=Game, y=Differential)) + 
      geom_bar(aes(fill=Performance),stat="identity",binwidth=2) + 
      ggtitle("$title") + ylab("Goal Differential") + xlab("Games") + 

      theme(axis.title.x=element_text(size=$size)) +
      theme(axis.title.y=element_text(size=$size)) +
      theme(plot.title  =element_text(face="bold",size=$size)) + 

      scale_fill_manual(values=c("red", "blue")) + 

      theme(legend.position="none") +

      theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5)) `);

      $string = $string."p".$i.",";
   }

   $string = $string."cols=".$cols.")";
   #print "string = ".$string."and size = ".$size."\n";

   $R->run(qq`$string`);

   # Close down the PDF device
   $R->run(q`dev.off()`);

   $R->stop();
}

sub multiplotR ($) {

#
#  multiplotR subroutine
#  Adapted from code posted on http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
#  Date of Last Update: Monday, February 16, 2015
#  Synopsis: multiple PDF plots on one page
#

my ($RR) = @_;

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#



$RR->run(q`multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  require(grid)

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols))
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}`);

return($RR);

}
1;

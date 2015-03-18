#!/usr/bin/perl
use strict;
use warnings;

#
#  Use the CSV module
#
use Text::CSV;
my $csvInput = Text::CSV->new({ sep_char => ',' });
#my $csvName    = Text::CSV->new({ sep_char => ',' });
#my $csvCoaches = Text::CSV->new({ sep_char => ',' });
#my $csvTeams   = Text::CSV->new({ sep_char => ',' });

#
#  NHLteamRoster.pl
#     Author: Deborah Stacey
#     Date of Last Update: Saturday, January 24, 2015.
#
#     Summary
#
#        This program prints out the roster of an NHL team given
#        the year and the team ID as input parameters.
#        It uses the Master, Scoring, Coaches and Teams tables.
#        The first output line is the Team name and the year and 
#        then the coach's name is output as well as the First and 
#        Last Name of each player and the position they played.
#
#     Parameters on the commandline:
#        $ARGV[0] = name of the Master player table
#        $ARGV[1] = name of the Scoring table
#        $ARGV[2] = name of the Coaches table
#        $ARGV[3] = name of the Teams table
#        $ARGV[4] = year
#        $ARGV[5] = 3 letter team designation, e.g. TOR for
#                   Toronto Maple Leafs
#
#     References
#        Hockey files from http://www.opensourcesports.com/hockey
#        Last year in these files is 2011
#        NHL dates are 1917 to 2011
#

#
#  Check that you have the right number of parameters
#  $#ARGV contains the number representing the last valid index value of the array ARGV
#  which contains the commandline parameters.
#
if ($#ARGV != 1 ) {
   print "Usage: NHLteamRoster.pl <master table file> <scoring table file> <coaches table file> <teams table file> Year Team\n";
   exit;
}

#
#   Store the filenames and year and teamID from the commandline
#
my $fileName  = $ARGV[0];
#my $scoringFName = $ARGV[1];
#my $coachesFName = $ARGV[2];
#my $teamsFName   = $ARGV[3];
#my $yearID       = $ARGV[4];
my $teamID       = $ARGV[1];

#
#   Year error checking - the only valid years for the NHL in this database are 1917 to 2011.
#
#if ( $yearID > 2011 || $yearID < 1917 ) {
#   die "Incorrect year - must be greater than 1916 or less than 2012";
#}

#
#   Information to be retrieved from file
#
my $date = "";
my $visitor     = "";
my $home     = "";
my $vGoal      = "";
my $hGoal   = "";

#
#

#

#
#   Array to store all player information for the team roster
#
my @fieldName;
my @teamScore;
my $count = 0;   # Number of roster array elements

#
#  Find the team name first - make sure that the team ID is valid for the
#  year in question.
#
#  Open the teams file - assign a file handle
#
open my $fileFH, '<', $fileName
   or die "Unable to open teams file: $fileName";

#
#   Read in the first record (column names) and ignore.
#
my $fileRecord = <$fileFH>;

#
#   Read in each record from the Teams.csv file until the record withA
#   the required year and teamID is found
#
while ( $fileRecord = <$fileFH> ) {
   chomp ( $fileRecord );
   if ( $csvInput->parse($fileRecord) ) {               # check to see if you can break the record into its component (columns)
      my @fieldName = $csvInput->fields();             # put all of the columns from this record into the @teamsField array
       	$date   = $fieldName[0];
 	$visitor= $fieldName[2];
	$home   = $fieldName[5];
	$vGoal = $fieldName[3];
	$hGoal  = $fieldName[6];

      if ( $visitor eq $teamID || $home eq $teamID ) {      
           print $visitor." ". $vGoal." ".$home. " ".$hGoal."\n";        
      }
      
      $fileRecord = "";
   } else {
      warn "Line could not be parsed: $fileRecord\n";
   }
}
close ($fileFH);      # Always close a file as soon as you are finished with it

#
#   If the team ID does not exist for this particular year then abort the program
#



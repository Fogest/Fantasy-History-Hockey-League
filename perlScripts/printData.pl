#!/usr/bin/perl
use strict;
use warnings;

#
#  Use the CSV module
#  Created By Nick
use Text::CSV;
my $csvInput = Text::CSV->new({ sep_char => ',' });
#
if ($#ARGV != 1 ) {
   print "Usage: NHLteamRoster.pl <results.csv> <teamID>\n ";
   exit;
}

my $fileName  = $ARGV[0];
my $teamID       = $ARGV[1];
my $date = "";
my $visitor     = "";
my $home     = "";
my $vGoal      = "";
my $hGoal   = "";

my @fieldName;
my @teamScore;
my $count = 0;   # Number of roster array elements
my $found = 0;
open my $fileFH, '<', $fileName
   or die "Unable to open teams file: $fileName";

my $fileRecord = <$fileFH>;

while ( $fileRecord = <$fileFH> ) {
    chomp ( $fileRecord );
    if ( $csvInput->parse($fileRecord) ) {               # check to see if you can break the record into its component (columns)
    my @fieldName = $csvInput->fields();             # put all of the columns from this record into the @teamsField array
       	$date   = $fieldName[0];
 	    $visitor= $fieldName[2];
	    $home   = $fieldName[5];
	    $vGoal =  $fieldName[3];
	    $hGoal  = $fieldName[6];

      if ( $visitor eq $teamID) {      
           print $visitor." ". $vGoal." ".$home. " ".$hGoal."\n"; 
           $found = 1;
      }
      if($home eq $teamID){
          print $home." ".$hGoal." ".$visitor." ". $vGoal."\n";
          $found = 1;
      }
      
      $fileRecord = "";
   } else {
      warn "Line could not be parsed: $fileRecord\n";
   }
}
close ($fileFH);      # Always close a file as soon as you are finished with it

if(!$found){
    printf "TeamID: ".$teamID." could not be found in file: ".$fileName."\n";
}
#
#   If the team ID does not exist for this particular year then abort the program
#



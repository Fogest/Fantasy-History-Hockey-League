#!/usr/bin/perl
use strict;
use warnings;
############################
#  Use the CSV module
#  Created By Nick
sub getTeamInfo{
    use Text::CSV;
    my $csvInput = Text::CSV->new({ sep_char => ',' });
#
    if ($#_ != 1 ) {
        print "Usage: NHLteamRoster.pl <results.csv> <teamID>\n ";
        exit;
    }

    my $fileName  = $_[0];
    my $teamID       = $_[1];
    
    my $visitor     = "";
    my $home     = "";
    my $vGoal      = "";
    my $hGoal   = "";

    my @fieldName=" ";
    my @goalsF=" ";
    my @goalsA= " ";
    my @teamInfo= " ";
    $teamInfo[0] = @goalsF;
    $teamInfo[1] = @goalsA;
    
    
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
            $teamInfo[0][$count] = $vGoal;
            $teamInfo[1][$count] = $hGoal;              
            $found = 1;
            $count++;
          }
          if($home eq $teamID){
            $teamInfo[0][$count] = $hGoal;   
            $teamInfo[1][$count] = $vGoal;            
            $found = 1;
            $count++;
          }
          
          $fileRecord = "";
       } else {
          warn "Line could not be parsed: $fileRecord\n";
       }
    }
    close ($fileFH);      # Always close a file as soon as you are finished with it
    
    if(!$found){
        printf "TeamID: ".$teamID." could not be found in file: ".$fileName."\n";
        return found;
    }
    return @teamInfo;
}
##############################################
#test Variables (temp since no input)
#goal Differential isa good indicator of team strength
#but it hides the teams actual scores
#it consists of goals scored - goals scored on

my @teamNames = ("OTS","MTL","TRA");

my @teamWins = (12,10,5);
my @teamLosses(6,8,13);
my @teamPoints(24,20,10);
my @OTS(5,5,2,7,2,4,2,6,3,3,1,2,3,3,3,7,4,9);
my @MTL(2,4,6,2,5,7,13,10,5,3,0,2,10,3,4,4,0,8);
my @TRA(3,2,3,4,6,2,4,5,11,2,1,0,6,1,6,2,3,3);
my @PlusMinus= "";

my $gamesPlayed= 18

print &getTeamInfo("results.csv","TRA");
sub calcPM{
#calculates the PlusMinus of a team given the scores that team made
    my @diffArray;
    
    my $mScore;
    my $oScore;
    my $count =0;
    
    while(@_){
        $mScore = pop@_[0];
        $oScore = pop@_[1];
        
        push@diffArray,$mScore-$oScore;
    }
}





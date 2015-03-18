#!/usr/bin/perl
use strict;
use warnings;

#test Variables (temp since no input)
#goal Differential isa good indicator of team strength
#but it hides the teams actual scores
#it consists of goals scored - goals scored on

@teamNames = ("OTS","MTL","TRA");

@teamWins = (12,10,5);
@teamLosses(6,8,13);
@teamPoints(24,20,10);
@OTS(5,5,2,7,2,4,2,6,3,3,1,2,3,3,3,7,4,9);
@MTL(2,4,6,2,5,7,13,10,5,3,0,2,10,3,4,4,0,8);
@TRA(3,2,3,4,6,2,4,5,11,2,1,0,6,1,6,2,3,3);
@PlusMinus= "";

my $gamesPlayed= 18


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





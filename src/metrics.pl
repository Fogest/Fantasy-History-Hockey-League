#!/usr/bin/perl
use strict;
use warnings;
############################
#  Use the CSV module
#  Created By Nick
#####testing fake info
my @teamNames=("MTL","OTS");
my @MTLa=(2,1,4,0,4,2,1,2,3);
my @MTLf=(4,5,6,2,0,1,3,4,4);
my @MTL = (@MTLf,@MTLa);
my @OTSa=(3,3,3,3,3,3,3,3,3);
my @OTSf=(2,2,2,2,2,1,0,1,0);
my @OTS = (@OTSf,@OTSa);
####################

my @plusMinus1;
my @plusMinus2;
#############
@plusMinus1 =&calcPM(\@MTLa,\@MTLf);

foreach (@plusMinus1){
    print $_,"\n";
};

@plusMinus2 =&calcPM(\@OTSa,\@OTSf);

foreach (@plusMinus2){
    print $_,"\n";
};

my @quart1;
my @quart2;

@quart1 = &quarterly(\@MTLa);
print @quart1;
sub calcPM{
#calculates the PlusMinus of a team given the scores that team made
    my @teama = @{$_[0]};
    my @teamf = @{$_[1]};
    my @pM;

    my $i;

    for($i=0;$i<9;$i++)
    {
        $pM[$i] = $teama[$i] - $teamf[$i];
    }

    return @pM;
}

sub quarterly{
    my (@quart) = @{$_[0]};
    my  $avg=0;
   
    my $i;
    for($i=0;$i<9;$i++)
    {
       $avg += $quart[$i]; 
    }
    
    $avg = $avg /($#quart+1);
    return $avg;
}



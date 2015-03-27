#!/usr/bin/perl
use strict;
use warnings;
############################
#  Use the CSV module
#  Created By Nick
#####testing fake info
my @teamNames=("MTL","OTS");
my @MTLa=(2,1,4,0,4,2,2,3,3,3,3,1,2,3,11,11);
my @MTLf=(1,1,1,2,2,2,1,1,1,3,3,3,4,4,4,1,1);
my @MTL = (@MTLf,@MTLa);
my @OTSa=(3,3,3,3,3,3,3,3,3);
my @OTSf=(2,2,2,2,2,1,0,1,0);
my @OTS = (@OTSf,@OTSa);
######simulate justin's array pass##############
#my @matchSyntax = (homeYear,homeTeam,awayYear,awayTeam);
my @matchArray=(
     [1981,"MTL",1990,"OTS"],
     [1990,"OTS",1988,"NYR"],
     [1988,"NYR",1981,"MTL"],
     [1981,"MTL",1990,"OTS"],
     [1988,"NYR",1981,"MTL"],
     [1990,"OTS",1988,"NYR"],
     [1981,"MTL",1988,"NYR"],
     [1988,"NYR",1990,"OTS"],
     );

######################
my @plusMinus1;
my @plusMinus2;
#############
@plusMinus1 =&calcPM(\@MTLa,\@MTLf);
print "plusMinus1: \n";
foreach (@plusMinus1){
    print $_,"\n";
};

@plusMinus2 =&calcPM(\@OTSa,\@OTSf);
print "plusMinus2: \n";
foreach (@plusMinus2){
    print $_,"\n";
};

my @quart1;
my @quart2;

@quart1 = &quarterly(\@MTLf);
print "quartely offence: \n";
foreach(@quart1)
{
    print $_,"\n";
}


@quart2 = &quarterly(\@MTLa);
print "quartely defence: \n";
foreach(@quart2)
{
    print $_,"\n";
}


my $random;

$random = roulette(20,5,1);

print "random: $random \n";

my $win;
my @score;

$win =&calcWinner(\@MTLf,\@MTLa,\@OTSf,\@OTSa);

if($win == 1)
{
    print"Team 1 wins\n";
    @score = genScore(\@MTLf,\@MTLa);
    print "Goals: $score[0], Against: $score[1]\n";
}

if($win == 2)
{
    print"Team 2 wins\n";
    @score = genScore(\@OTSf,\@OTSa);
    print "Goals: $score[0], Against: $score[1]\n";
}

if($win == 0)
{
    print"draw?\n";
}

loopMatches(\@matchArray);

sub loopMatches{
    my @matchArray = @{$_[0]};
    my $numMatches = $#matchArray+1;
    my $i;
    print"SCHEDULE: \n";
    for( $i = 0; $i<$numMatches; $i++){
        print "$matchArray[$i][0] ";
        print "$matchArray[$i][1] vs ";
        print "$matchArray[$i][2] ";
        print "$matchArray[$i][3]\n";
    }

    return 0;


}


sub calcPM{
#calculates the PlusMinus of a team given the scores that team made
    my @teama = @{$_[0]};
    my @teamf = @{$_[1]};
    my @pM;

    my $i;

    for($i=0;$i<$#teama+1;$i++)
    {
        $pM[$i] = $teama[$i] - $teamf[$i];
    }

    return @pM;
}

sub quarterly{
    my (@quart) = @{$_[0]};
    my @avg;
    my $numGames = $#quart+1; 
    my $i=0;
    my $k=0;
    my $qLength =$numGames/4;
    
    for($i=0;$i<4;$i++)
    {
        for($k=$qLength*($i);($k<$numGames) && ($k<$qLength*($i+1));$k++){ 
            $avg[$i] += $quart[$k]; 
        }
        $avg[$i]=int($avg[$i]/$qLength);
    }
    return @avg;
}

sub roulette{

    my ($max,$median,$min) = @_;
    my $random;
    
    $random =int(rand($max))+1;
    
    if($random < $median){
        $random = int(rand($median)+1);
    }
    else{
        $random = int(rand($max)+1);
    }

    return $random;
}

sub compareQ{

    my @quart1 = @{$_[0]};
    my @quart2 = @{$_[1]};
    my $qNum = $_[2];
    my $i;

    if($qNum > 0 && $qNum < 4)
    {
        $qNum--;

        if(int(rand($quart1[$qNum])+1) > int(rand($quart2[$qNum])+1))
        {
            return 1;
        }
        else
        {
            return 2;
        }
    }
            
}

sub calcWinner{
    my @Team1f= @{$_[0]};
    my @Team1a= @{$_[1]};
    my @Team2f= @{$_[2]};
    my @Team2a= @{$_[3]};
    
    my @quart1f= quarterly(\@Team1f); 
    my @quart1a= quarterly(\@Team1a);
    my @quart2f= quarterly(\@Team2f);
    my @quart2a= quarterly(\@Team2a);
    
    my $winnera = 0; 
    my $winnerf = 0;
    
    $winnera = compareQ(\@quart1a,\@quart2a,3);
    $winnerf = compareQ(\@quart1f,\@quart2f,3);

    if($winnera == $winnerf)
    {
        return $winnera;
    }
    else
    {
        return 0;
    }
}  

sub genScore{
    my @Teamf= @{$_[0]};
    my @Teama= @{$_[0]};

    my $i;
    my $Max =-1;
    my $Min = 99999;
    my $average = 0;
    my $Goalf = 0;
    my $Goala= 0;
    my @Goals;

    for($i=0;$i<$#Teamf+1;$i++){
        if($Teamf[$i] > $Max){
            $Max = $Teamf[$i];
        }
        if($Teamf[$i] < $Min){
            $Min = $Teamf[$i];
        }
        $average=+$Teamf[$i];
    }
    $average= int($average / ($#Teamf+1));

    $Goalf = &roulette($Max,$average,$Min);
    
    for($i=0;$i<$#Teama+1;$i++){
        if($Teama[$i] > $Max){
            $Max = $Teama[$i];
        }
        if($Teama[$i] < $Min){
            $Min = $Teama[$i];
        }
        $average=+$Teama[$i];
    }
    $average= int($average / ($#Teama+1));

    $Goala = &roulette($Max,$average,$Min);
    
    $Goals[0] = $Goalf;
    $Goals[1] = $Goala;
    
    return @Goals;
}

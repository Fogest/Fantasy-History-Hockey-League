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
#@plusMinus1 =&calcPM(\@MTLa,\@MTLf);
#print "plusMinus1: \n";
#foreach (@plusMinus1){
#    print $_,"\n";
#};

#@plusMinus2 =&calcPM(\@OTSa,\@OTSf);
#print "plusMinus2: \n";
#foreach (@plusMinus2){
#    print $_,"\n";
#};

#my @quart1;
#my @quart2;

#@quart1 = &quarterly(\@MTLf);
#print "quartely offence: \n";
#foreach(@quart1)
#{
#    print $_,"\n";
#}
#
#
#@quart2 = &quarterly(\@MTLa);
#print "quartely defence: \n";
#foreach(@quart2)
#{
#    print $_,"\n";
#}
#
#
#my $random;

#$random = roulette(20,5,1);

#print "random: $random \n";

#my $win;
#my @score;

#$win =&calcWinner(\@MTLf,\@MTLa,\@OTSf,\@OTSa);

#if($win == 1)
#{
#    print"Team 1 wins\n";
#    @score = genScore(\@MTLf,\@MTLa);
#    print "Goals: $score[0], Against: $score[1]\n";
#}
#
#if($win == 2)
#{
#    print"Team 2 wins\n";
#    @score = genScore(\@OTSf,\@OTSa);
#    print "Goals: $score[0], Against: $score[1]\n";
#}
#
#if($win == 0)
#{
#    print"draw?\n";
#}
#
loopMatches(\@matchArray);

sub loopMatches{
    my @matchArray = @{$_[0]};
    my $numMatches = $#matchArray+1;
    my $i;
    my $curQuart;
    my @results;
    my @home;
    my @homef;
    my @homea;
    my @awayf;
    my @awaya;
    my @away;
#temp data till i can grab data on demand
    my @MTL1981=(
      #goalsfor
        [9,9,9,9,9,0,0,0,0,0,0,0,11,11,11,11],
      #goalsAgainst  
        [1,1,1,2,2,2,1,1,1,3,3,3,4,4,4,1,1],
    );

    my @OTS1990 = (
      #goalsfor
        [1,1,1,1,2,2,13,13,13,13,13,13,8,8,8,9],
      #goalsAgainst
        [2,2,4,4,1,1,1,3,2,2,1,1,1,1,1,1],
    );

    my @NYR1988 = (
      #goalsFor
        [15,15,15,15,15,15,15,0,0,0,0,0,0,0,0,0],
      #goalsAgainst
        [3,3,3,3,3,3,3,7,7,7,7,7,12,12,12,12],
    );
    
###############
    print"SCHEDULE: \n";
    for( $i = 0; $i<$numMatches; $i++){
        print "$matchArray[$i][0] ";
        print "$matchArray[$i][1] vs ";
        print "$matchArray[$i][2] ";
        print "$matchArray[$i][3]\n";
    #this is where I will grab the data from files per match
    #for the time being i will use fake data for each match
        if($matchArray[$i][1] eq "MTL")
        {
            @home=@MTL1981;
        }
        if($matchArray[$i][1] eq "OTS")
        {
            @home=@OTS1990;
        }
        if($matchArray[$i][1] eq "NYR")
        {
            @home=@NYR1988;
        }
        if($matchArray[$i][3] eq "MTL")
        {
            @away=@MTL1981;
        }
        if($matchArray[$i][3] eq "OTS")
        {
            @away=@OTS1990;
        }
        if($matchArray[$i][3] eq "NYR")
        {
            @away=@NYR1988;
        }
        
        @homef= @{$home[0]};
        @homea= @{$home[1]};

        @awayf= @{$away[0]};
        @awaya= @{$away[1]};
        
        $curQuart= &checkQuart($i,$numMatches);
        print "current quarter: $curQuart\n"; 
        $results[$i] = &calcWinner(\@homef,\@homea,\@awayf,\@awaya,$curQuart);
    }

    foreach(@results)
    {
        print "$_\n";
    }
     
    return 0;


}

sub checkQuart{
    my $currentGame = $_[0];
    my $totalGames = $_[1];
    my $quarterSize;
    my $i;
    my $currentQuarter = 1;
    
    #multiply by 4 to generate even quarters
    $currentGame *= 4;

    $quarterSize = $totalGames;

    #multiply by 4 to generate even quarters
    $totalGames *= 4;
    
    for($i = $quarterSize; $i <= $totalGames; $i+=$quarterSize){
        if($currentGame < $i){
            return $currentQuarter;
        }
        $currentQuarter ++;
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

#calculates the quarterly averges and returns them in an array(av1,av2,av3,av4)
sub quarterly{
    my (@scoreArray) = @{$_[0]};
    my @avgArray;
    my $numGames = $#scoreArray+1; 
    my $cQuart=0;
    my $k=0;
    my $countNumScores=0;
    my $addToQuarter = $numGames%4;
    my @addToQ= (0,0,0,0);
    my $actualQLength;      
    my $lastValue=0;
    my $avgQLength =(($numGames-($numGames%4))/4);
    
    for($k=0; $k<$addToQuarter; $k++){
        $addToQ[$k]=1;
    }
    
    for($cQuart=0;$cQuart<4;$cQuart++){
        #for each quarter, find the average
        $countNumScores = 0;
        $avgArray[$cQuart] = 0;
        $actualQLength = (($cQuart+1) *$avgQLength)+$addToQ[$cQuart];
        for($k = $lastValue; $k<$actualQLength; $k++){
            $avgArray[$cQuart] += $scoreArray[$k];
            $countNumScores++;
        }

        $lastValue= $actualQLength;
        $avgArray[$cQuart] = int($avgArray[$cQuart] / $countNumScores);
    }
    return @avgArray;
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

    if($qNum > 0 && $qNum < 5)
    {
        $qNum--;
        
        print "$quart1[$qNum] vs $quart2[$qNum]\n";

        if($quart1[$qNum] > $quart2[$qNum])
        {
            #team 1 is higher
            return 1;
        }
        if($quart1[$qNum] < $quart2[$qNum])
        {
            #team 2 is Higher
            return 2;
        }
        else
        {
            #equal
            return 0;
        }
    }
            
}

sub calcWinner{
    my @Team1f= @{$_[0]};
    my @Team1a= @{$_[1]};
    my @Team2f= @{$_[2]};
    my @Team2a= @{$_[3]};
    my $quartNum = $_[4]; 
    
    my @quart1f= quarterly(\@Team1f); 
    my @quart1a= quarterly(\@Team1a);
    my @quart2f= quarterly(\@Team2f);
    my @quart2a= quarterly(\@Team2a);
   
    my $betterAttack = 0; 
    my $weakerDefence = 0;
    print"for: ";    
    $betterAttack = compareQ(\@quart1f,\@quart2f,$quartNum);
    print"against: ";
    $weakerDefence = compareQ(\@quart1a,\@quart2a,$quartNum);

    if($betterAttack == 1){
        if($weakerDefence == 2){
            #team 1 is much stronger
            return 1;
        }
        if($weakerDefence == 0)
        {
            #team 1 is stronger offence
            return 1;
        }
        if($weakerDefence == 1)
        {
            #team 1 has good offence but weak defence
            return 3;
        }
    }
    if($betterAttack == 2){
        if($weakerDefence == 1){
            #team 2 is much stronger
            return 2;
        }
        if($weakerDefence == 0)
        {
            #team 2 is stronger offence
            return 2;
        }
        if($weakerDefence == 1)
        {
            #team 2 has good offence but weak defence
            return 4;
        }
    }
    else
    {
        if($weakerDefence == 1){
            #team 1 has a better defence
            return 1;
        }
        if($weakerDefence == 2)
        {
            #team 2 has a better defence
            return 2;
        }
        if($weakerDefence == 0)
        {
            #both teams seem evenly matched
            return 5;
        }
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

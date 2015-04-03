#!/usr/bin/perl
use strict;
use warnings;
use Text::CSV;
############################
#  Use the CSV module
#  Created By Nick
######simulate justin's array pass##############
#my @matchSyntax = (homeYear,homeTeam,awayYear,awayTeam);
my @matchArray; #=(
   # [1917,"TRA",1917,"MTW"],
   # [1917,"MTL",1917,"OTS"],
   # [1917,"MTL",1917,"MTW"],
    #[1917,"OTS",1917,"TRA"],
    #[1917,"OTS",1917,"MTW"],
    #[1917,"MTL",1917,"TRA"],
    #[1917,"TRA",1917,"MTL"],
    #[1917,"MTW",1917,"OTS"],
    #[1917,"MTW",1917,"MTL"],
    #[1917,"TRA",1917,"OTS"],
    #[1917,"OTS",1917,"MTL"],
    #[1917,"MTW",1917,"TRA"],
    #[1917,"MTL",1917,"TRA"],
    #[1917,"OTS",1917,"MTL"],
    #[1917,"TRA",1917,"OTS"],
    #[1917,"OTS",1917,"TRA"],
    #[1917,"TRA",1917,"MTL"],
    #[1917,"MTL",1917,"OTS"],
    #[1917,"OTS",1917,"MTL"],
    #[1917,"TRA",1917,"OTS"],
    #[1917,"MTL",1917,"TRA"],
    #[1917,"MTL",1917,"OTS"],
    #[1917,"TRA",1917,"MTL"],
    #[1917,"OTS",1917,"TRA"],
    #[1917,"MTL",1917,"OTS"],
    #[1917,"TRA",1917,"MTL"],
    #[1917,"OTS",1917,"TRA"],
    #[1917,"TRA",1917,"OTS"],
    #[1917,"OTS",1917,"MTL"],
    #[1917,"MTL",1917,"TRA"],
    #[1917,"TRA",1917,"MTL"],
    #[1917,"OTS",1917,"TRA"],
    #[1917,"MTL",1917,"OTS"],
    #[1917,"OTS",1917,"MTL"],
    #[1917,"MTL",1995,"DET"],
    #[1917,"TRA",1917,"OTS"],
    # );

######################

#loopMatches(\@matchArray);
########################JLANGE's CODE#######################
#
#Resources Used:
#http://stackoverflow.com/questions/197933/whats-the-best-way-to-clear-the-screen-in-perl
#This website provided us with the information required to clear the screen after each input.
#

my $csvTestYearFile = Text::CSV->new({ sep_char => ','});
my @yearToTeamFields;
my @tempTeamRoster;
my @teamRoster="";
my @yearRoster=0;
my $yearToTeamAbbrev;

my $i = 0;
my $j = 0; 
my $tempCounter =0;
my $testVar =0;
my $totalTeams =0;
my $usrInput1 = 0;
my $usrInput2 = 0;
my $usrInput3 = 0;
my $usrInput4 = 0;
my $usrYearInput = 1900;
my $usrTeamInput = "default";
my $teamCountUp=0;

print "\033[2J";    #clear the screen
print "\033[0;0H"; #jump to 0,0
while ($usrInput1 != 4)
{
    $usrInput2 = 0; 
    print "|-----------------------------|\n";
    print "|- Welcome to Fantasy Hockey- |\n";
    print "|-----------------------------|\n";

    print "1. Choose your Teams\n";
    print "2. Play Game\n";
    print "3. Statistics\n";
    print "4. Exit\n\n";

    print "Enter the number of your choice:";
    $usrInput1 = <>;
    print "\033[2J";    #clear the screen
    print "\033[0;0H"; #jump to 0,0
    if ($usrInput1 == 1)
    {
        while ($usrInput2 !=3)
        {
            $usrYearInput = 1900;
            print "|----------------------------|\n";
            print "|------Choose Your Team------|\n";
            print "|----------------------------|\n\n";


            print "1.Search by year\n";
            print "2.Quick Add\n";
            print "3.Return to Main Menu\n\n";
            print "Enter the number of your choice:";
            $usrInput2= <>; 
            print "\033[2J";    #clear the screen
            print "\033[0;0H"; #jump to 0,0            
            my $testVar; 
           
            if ($usrInput2 == 1)
            {
                while ($usrYearInput != 0)
                {
                    my $tempCount=0;
                    print "Enter a year between 1917 and 2014 that you wish to search for, or 0 to exit:";
                    $usrYearInput= <>;
                    chomp ($usrYearInput); 
                    print "\033[2J";    #clear the screen
                    print "\033[0;0H"; #jump to 0,0

                    if (($usrYearInput > 1916) && ($usrYearInput < 2015))
                    {
                        my $yearFile = "../data/$usrYearInput/teams.csv";
                        #$testVar=<>;                        
                        open (my $yearToTeamFH, "<",$yearFile) 
                            
                            or die "Unable to open the required year's file: $yearFile";
                      

                        my $yearToTeamRecord = <$yearToTeamFH>;
                        my $teamCount=0;
                        $tempCount=0; 
                        while ( $yearToTeamRecord = <$yearToTeamFH>)
                        {
                            my $test; 
                            chomp ($yearToTeamRecord);
#$testVar=<>;
                            if ($csvTestYearFile->parse($yearToTeamRecord) )
                            {
                                @yearToTeamFields = $csvTestYearFile->fields();
                                $yearToTeamAbbrev = $yearToTeamFields[2];
                                #$yearToTeamAbbrev = $tempTeamRoster[$tempCount];
                                $tempTeamRoster[$tempCount]=$yearToTeamAbbrev;
                                $tempCount=$tempCount+1;
#crashes before this point      $testVar=<>;                                
                                if ($teamCount < 5)
                                {
                                    print "$yearToTeamFields[2]\t";               
                                    $teamCount=$teamCount+1;
                                }
                                else
                                {
                                    print "$yearToTeamFields[2]\n";
                                    $teamCount=0;
                                }
                                #$test= <>;
                            }
                            else
                            {
                                warn "Line could not be parsed: $yearToTeamRecord\n";
                            }
                        }
                        
                        print "\nEnter the team abbreviation you wish to use: ";
                        $usrTeamInput = <>;
                        chomp ($usrTeamInput);
                        my $tempVal=0;
                        for ($i=0;$i<$tempCount;$i++)
                        {
                            if ($tempTeamRoster[$i] eq $usrTeamInput)
                            {                                
                
                                $teamRoster[$teamCountUp]= $tempTeamRoster[$i];
                                $yearRoster[$teamCountUp]=$usrYearInput;
                print "$yearRoster[$totalTeams] ";
                                printf" $teamRoster[$totalTeams] has been added to your list\n";
                $tempVal=$tempVal+1;
                                $teamCountUp=$teamCountUp+1;
                            }
                        }
                        if ($tempVal==0)
                        {
                            print"Invalid Team Choice\n";
                        }
                        close ($yearFile);
            $usrYearInput=0;
                    }


                    while ((($usrYearInput < 1917) || ($usrYearInput > 2014)) && ($usrYearInput != 0)) 
                    {
                        print "Bad Input, please choose a number between 1917 and 2014: ";
                        $usrYearInput= <>; 
                        chomp($usrYearInput);
                        print "\033[2J";    #clear the screen
                        print "\033[0;0H"; #jump to 0,0 
                    }
                }
            }
            if ($usrInput2 == 10)
            {
                $usrTeamInput = "default"; 
                while ($usrTeamInput ne "exit")
                {
                    print "Here is a list of teams to choose from:";

                    # open the team file which holds all the team abbreviations
                    # then print to the screen

                    print "\n\nEnter the abreviation you want to use, or type exit to return to the main menu:";
                    $usrTeamInput= <>;
                    print "\033[2J";    #clear the screen
                    print "\033[0;0H"; #jump to 0,0
                    chomp ($usrTeamInput);
                    if ($usrTeamInput eq "exit")
                    {
                        $usrInput2 = 0;
                    } 
                }
            }
            if ($usrInput2 == 2)
            {
                my $tempCount=0;
        print "Please enter the year between 1917 and 2014 that you wish to use:";
                $usrYearInput= <>;
        chomp ($usrYearInput);
                print "Please enter the team abbreviation that you wish to use:";
                $usrTeamInput= <>;
        chomp ($usrTeamInput);
                print "\033[2J"; #clear the screen
                print "\033[0;0H"; #jump to 0,0

                if (($usrYearInput < 1917) || ($usrYearInput > 2014))
                {
                    print "Invalid year input\n";
                }                
                if (($usrYearInput > 1916) && ($usrYearInput < 2015))
                {
                    my $yearFile = "../data/$usrYearInput/teams.csv";                        
                    open (my $yearToTeamFH, "<",$yearFile) 
                          
                        or die "Unable to open the required year's file: $yearFile";
                     
                    my $yearToTeamRecord = <$yearToTeamFH>;
                    my $teamCount=0;
                    $tempCount=0; 
                    while ( $yearToTeamRecord = <$yearToTeamFH>)
                    {
                        my $test; 
                        chomp ($yearToTeamRecord);
                        if ($csvTestYearFile->parse($yearToTeamRecord) )
                        {
                            @yearToTeamFields = $csvTestYearFile->fields();
                            $yearToTeamAbbrev = $yearToTeamFields[2];
                            #$yearToTeamAbbrev = $tempTeamRoster[$tempCount];
                            $tempTeamRoster[$tempCount]=$yearToTeamAbbrev;
                            $tempCount=$tempCount+1;

                            my $tempVal=0;
                            for ($i=0;$i<$tempCount;$i++)
                            {
                                if ($tempTeamRoster[$i] eq $usrTeamInput)
                                {                                
                                    
                                    $teamRoster[$teamCountUp]=$usrTeamInput;
                                    $yearRoster[$teamCountUp]=$usrYearInput;
                    print "$yearRoster[$teamCountUp]  $teamRoster[$teamCountUp] has been added to your list\n";
                    $tempVal=$tempVal+1;
                                    $teamCountUp=$teamCountUp+1;
                                }
                            }
                            if ($tempVal==0)
                            {
                                print"Invalid Team Choice\n";
                            }
                            close ($yearFile);
                $usrTeamInput="exit";



                       }
                   }
               }
       }               
       }
    }   
    if ($usrInput1 == 2)
    {   
        if($#teamRoster < 1)
        {
            print"Sorry, Need to select some teams before we continue\n";

        }
        else
        {          
            print "Here are the teams that you have chosen to use for the game: \n";
            for ($i=0;$i<$teamCountUp;$i++)
            {
                my $teamCount=0;
                if ($teamCount < 5)
                {
                    print "$yearRoster[$i] $teamRoster[$i]\t";               
                    $teamCount=$teamCount+1;
                }
                else
                {
                    print "$yearRoster[$i] $teamRoster[$i]\n";
                    $teamCount=0;
                }
            }
            print "\nHow many games would you like to play?\n";
            my $numGamesToPlay = <>; 
            chomp($numGamesToPlay);
            while($numGamesToPlay < 4 || $numGamesToPlay > 500)
            {
                print"Sorry, We cannot play $numGamesToPlay matches in our league\n";
                print"minimum #: 4, Max #: 500\n";
                $numGamesToPlay = <>; 
                chomp($numGamesToPlay);
            }

            @matchArray = &genSchedule(\@teamRoster,\@yearRoster,$numGamesToPlay);
            
            &loopMatches(\@matchArray); 
        } 
    }

}


################END OF J LANGE's CODE ##################

sub genSchedule{
    my @teamRoster = @{$_[0]};
    my @yearRoster = @{$_[1]};
    my $numGames = $_[2];

    my@schedule;
    my $i=0;
    my $k=0;

    while($i<$numGames ){
        if($k == $#teamRoster +1)
        {
            $k=0;
        }    

        $schedule[$i][0] = $yearRoster[$k];
        $schedule[$i][1] = $teamRoster[$k];
        
        $k++;
        
        if($k == $#teamRoster +1)
        {
            $k=0;
        }
        $schedule[$i][2] = $yearRoster[$k];
        $schedule[$i][3] = $teamRoster[$k];

        $i++;
        
    }
    return @schedule;
}


#loops through the schedule of matches and calculates the winners
sub loopMatches{
#get input
    my @matchArray = @{$_[0]};
#declare variables
    my $numMatches = $#matchArray+1;
    my $i;
    my $k;
    my $curQuart;
    my $winPoint;
    my @results;
    my @home;
    my @homef;
    my @homea;
    my @awayf;
    my @awaya;
    my @away;
    my $resultHome;
    my $resultAway;
    
    for( $i = 0; $i<$numMatches; $i++){
       # print "$matchArray[$i][0] ";
       # print "$matchArray[$i][1] vs ";
       # print "$matchArray[$i][2] ";
       # print "$matchArray[$i][3]\n";

        @home = &resultsInfo($matchArray[$i][0],$matchArray[$i][1]);
        @away = &resultsInfo($matchArray[$i][2],$matchArray[$i][3]);
       
       #get for and against scores for home then for away 
        for($k = 0; $k <$#home+1;$k++){
            $homef[$k] = $home[$k][1];
            $homea[$k] = $home[$k][3];
        }
        
        for($k = 0; $k <$#away+1;$k++){
            $awayf[$k] = $away[$k][1];
            $awaya[$k] = $away[$k][3];
        }
        
        #get current quarter
        $curQuart= &checkQuart($i,$numMatches);
        
        #calculate the winners and store in array         
        
        $winPoint = &calcWinner(\@homef,\@homea,\@awayf,\@awaya,$curQuart);
        
        if($winPoint == 1 || $winPoint == 3)
        {
            $resultHome = genScore(\@homef,\@homea,$curQuart,0);
            $resultAway = genScore(\@awayf,\@awaya,$curQuart,$winPoint);
        }
        if($winPoint == 2 || $winPoint == 4)
        {
            $resultAway = genScore(\@awayf,\@awaya,$curQuart,0);
            $resultHome = genScore(\@homef,\@homea,$curQuart,$winPoint);
        }
        if($winPoint == 5)
        {   
            $resultAway = genScore(\@awayf,\@awaya,$curQuart,$winPoint);
            $resultHome = genScore(\@homef,\@homea,$curQuart,$winPoint);
        }
        
        $results[$i][0] = $matchArray[$i][1];
        $results[$i][1] = $resultHome;
        $results[$i][2] = $matchArray[$i][3];
        $results[$i][3] = $resultAway;
        

    }
    
    #print the results 
    print"game#\t| home\t| score\t| away\t| score\n";
    my $counter = 0;
    foreach(@results)
    {
        $counter++;
        print"$counter\t| @$_[0]\t| @$_[1]\t| @$_[2]\t| @$_[3]\n";
    }
    return 0;


}

    

#determines which quarter we are currently in and returns it (1..4)
sub checkQuart{
#get input
    my $currentGame = $_[0];
    my $totalGames = $_[1];
#declare variables
    my $quarterSize;
    my $i;
    my $currentQuarter = 1;
    
    #multiply by 4 to generate even quarters
    $currentGame *= 4;

    $quarterSize = $totalGames;

    #multiply by 4 to generate even quarters
    $totalGames *= 4;
    
    #loop through the quarters and return when we find which quarter we are within
    for($i = $quarterSize; $i <= $totalGames; $i+=$quarterSize){
        if($currentGame < $i){
            return $currentQuarter;
        }
        $currentQuarter ++;
    }

    #this indicates there was some error
    return 0;
}

#sub remains unused;
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

#calculates the quarterly averages and returns them in an array(av1,av2,av3,av4)
sub quarterly{
#get the input
    my (@scoreArray) = @{$_[0]};
#declare variables
    my @avgArray;
    my $numGames = $#scoreArray+1; 
    my $cQuart=0;
    my $k=0;
    my $addedToQ; # used to track how much we have displaced quartes by
    my $countNumScores=0;
    
    #this tells me how much i need to displace my quarters
    #it will be either 1, 2, 3 or 0
    my $addToQuarter = $numGames%4;
    
    #used to modify quarters, initialized to prevent strange behavior
    my @addToQ= (0,0,0,0);
    
    my $actualQLength;      
    my $lastValue=0;
    
    #the even length of each quarter
    #removes up to 3 games from the length in order to maintain whole numbers
    my $avgQLength =(($numGames-($numGames%4))/4);
    
    #for every game removed from the season, assign 1 to be added to a quarter
    #Quarters 1, 2,and 3 can have up to 1 game added to them
    for($k=0; $k<$addToQuarter; $k++){
        $addToQ[$k]=1;
    }
    #this is where we get the quarterly averages
    for($cQuart=0;$cQuart<4;$cQuart++){
        #for each quarter
        #count the number of scores we encounter
        $countNumScores = 0;
        #initialize the array value to 0 to prevent strange behavior;
        $avgArray[$cQuart] = 0;
        #calculate how long the quarter actually is by:
            #multiplying avg quarter length by the current quarter we are in
            #adding any extra games to the quarter
        $addedToQ += $addToQ[$cQuart];
        $actualQLength = + (($cQuart+1) *$avgQLength)+$addedToQ;
        #loop through the quarter and sum all the scores
        for($k = $lastValue; $k<$actualQLength; $k++){
            $avgArray[$cQuart] += $scoreArray[$k];
            $countNumScores++;
        }
        #save the lastPosition we checked to use as starting pos for next iteration
        $lastValue= $actualQLength;
        #calculate average score rounded to nearest whole int;
        $avgArray[$cQuart] = int($avgArray[$cQuart] / $countNumScores);
    }
    
    return @avgArray;
}

#plays roullete to generate random scores
sub roulette{

    my ($max,$avg,$min,$mod) = @_;
    my $random;
    
    if($mod == 1){
        $max= int($max*1.3);
        $min = $avg;
    }

    $random =int(rand(10))+1;
    
    if($random <= 2){
        $random = int(rand($min));
    }
    if($random <= 8){
        $random = $min+int(rand($avg-$min));
    }
    if($random <=10){
        $random = $avg+int(rand($max-$avg));
    }

    return $random;
}

#compares two quarterly averages to determine which is higher
sub compareQ{
#get input
    my @quart1 = @{$_[0]};
    my @quart2 = @{$_[1]};
    my $qNum = $_[2];
#declare variables
    my $i;
    
    #ensure valid quarter was passed to function
    if($qNum > 0 && $qNum < 5)
    {
        #get the array index corresponding to that quarter
        $qNum--; 

        #compare quarters to determine which is higher  
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
    else
    {
        #error
        return -1;
    }
}

#checks which team should win based on their offensive and defensive strengths
#returns a number corresponding to which team is stronger
#return value key
#------------------------------
# 1 : team 1 is stronger overall
# 2 : team 2 is stronger overall
# 3 : team 1 is stronger offensively, but weaker defensively
# 4 : team 2 is stronger offensively, but weaker defensively
# 5 : teams are evenly matched
sub calcWinner{
#get input
    my @Team1f= @{$_[0]};
    my @Team1a= @{$_[1]};
    my @Team2f= @{$_[2]};
    my @Team2a= @{$_[3]};
    my $quartNum = $_[4]; 
#declare variables    
    my $betterAttack = 0; 
    my $weakerDefence = 0;
    
    my @quart1f= quarterly(\@Team1f);
    
    my @quart1a= quarterly(\@Team1a);
   
    my @quart2f= quarterly(\@Team2f);
    
    my @quart2a= quarterly(\@Team2a);
   
    #compare offensive strength
    $betterAttack = compareQ(\@quart1f,\@quart2f,$quartNum);
    
    #compare defensice strength
    $weakerDefence = compareQ(\@quart1a,\@quart2a,$quartNum);

    #based on offensive and defensive strengths, determine a winner
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


#generate realistic scores based on match outcome and average team performance
sub genScore{
    my @teamF= @{$_[0]};
    my @teamA= @{$_[1]};
    my $curQuart = $_[2];
    my $winPoint = $_[3];

    my @quartAvgF = &quarterly(\@teamF);
    my @quartAvgA = &quarterly(\@teamA);
    my $i;
    my $curAvgF;
    my $curAvgA;
    my $Max =-1;
    my $Min = 99999;
    my $average = 0;
    my $Goalf = 0;
    my $Goala= 0;
    my @Goals;
    my $modifier = 0;

    if($winPoint == 2 || $winPoint == 4)
    {
        $modifier = 1; #they have a weak defence
    }

    if($curQuart == 1)
    {
        $curAvgF = $quartAvgF[0];
        $curAvgA = $quartAvgA[0];
    }
    if($curQuart == 2)
    {
        $curAvgF = $quartAvgF[1];
        $curAvgA = $quartAvgA[1];
    }
    if($curQuart == 3)
    {
        $curAvgF = $quartAvgF[2];
        $curAvgA = $quartAvgA[2];
    }
    if($curQuart == 4)
    {
        $curAvgF = $quartAvgF[3];
        $curAvgA = $quartAvgA[3];
    }

    for($i=0;$i<$#teamF+1;$i++){
        if($teamF[$i] > $Max){
            $Max = $teamF[$i];
        }
        if($teamF[$i] < $Min){
            $Min = $teamF[$i];
        }
    }
    
    $Goalf = &roulette($Max,$curAvgF,$Min,$modifier);
    
    for($i=0;$i<$#teamA+1;$i++){
        if($teamA[$i] > $Max){
            $Max = $teamA[$i];
        }
        if($teamA[$i] < $Min){
            $Min = $teamA[$i];
        }
    }

    $Goala = &roulette($Max,$curAvgA,$Min,0);
    
    $Goals[0] = $Goalf;
    $Goals[1] = $Goala;
    
    return $Goalf;
}

####################JROGER's CODE########################################
# IN: Year
sub getTeamYear
{
   my $teamYear = $_[0];

   my $csvTeams= Text::CSV->new({ sep_char => ',' });

   open my $teamsFH, '<', "../data/$teamYear/teams.csv"
      or die "Unable to open teams file in $teamYear folder.";

   my $teamsRecord = <$teamsFH>;

   my @teamNames;

   my $i = 0;

   while( $teamsRecord = <$teamsFH> ) {
      chomp ($teamsRecord);
      if ( $csvTeams->parse($teamsRecord) ) 
      {
         my @TeamsFields = $csvTeams->fields();
         if ($TeamsFields[2] ne "teamAbrv")
         {
            $teamNames[$i][0] = $TeamsFields[1];
            $teamNames[$i][1] = $TeamsFields[2];
            $i++;
         }
      }
   }
   close $teamsFH
      or warn "Unable to close teams.csv in folder $teamYear, during sub getTeamYear.";
   @teamNames;
}

# IN: Year, Team abbreviation
# OUT: Results of games the team played in in the format [called team, their score, team they're against, that team's score]
sub resultsInfo
{
   my $year = $_[0];
   my $teamAbbr = $_[1];      
   my $csvResults = Text::CSV->new({ sep_char => ',' });
   
   my @results;

   #
   #  Open the results file - assign a file handle
   #
   open my $resultsFH, '<', "../data/$year/results.csv"
      or die "Unable to open results file";

   my $resultsRecord = <$resultsFH>;
   my $i = 0;
   my @teamResults;
   #Saves the game info if the team played in that game
   while( $resultsRecord = <$resultsFH> ) {
      chomp ($resultsRecord);
      if ( $csvResults->parse($resultsRecord) ) {
         my @resultsField = $csvResults->fields();
         if (($resultsField[2] eq $teamAbbr))
         {
            $teamResults[$i][0] = $resultsField[2];
            $teamResults[$i][1] = $resultsField[3];
            $teamResults[$i][2] = $resultsField[5];
            $teamResults[$i][3] = $resultsField[6];
            $i++;
         }
         if ($resultsField[5] eq $teamAbbr)
         {
            $teamResults[$i][0] = $resultsField[5];
            $teamResults[$i][1] = $resultsField[6];
            $teamResults[$i][2] = $resultsField[2];
            $teamResults[$i][3] = $resultsField[3];
            $i++;
         }
      }
   }
   close $resultsFH
      or warn "Unable to close results.csv in folder $year during sub resultsInfo";
   @teamResults;
}

sub playersInfo
{
   my $year = $_[0];
   my $teamAbbr;
   my $csvPlayers = Text::CSV->new({ sep_char => ',' });

   my @players;

   #
   #  Open the results file - assign a file handle
   #
   open my $playersFH, '<', "../data/$year/players.csv"
      or die "Unable to open results file";

   my $playerRecord = <$playersFH>;

   my $i = 0;

   for (my $j = 0; $j <= 11; $j++) {
      $players[$j] = 0;
   }

   #Saves the game info if the team played in that game
   while( $playerRecord = <$playersFH> ) {
      chomp ($playerRecord);
      if ( $csvPlayers->parse($playerRecord) ) {
         my @playersFields = $csvPlayers->fields();
         if (( $playersFields[3] eq $teamAbbr))
         {
            for (my $k = 0; $k<=15; $k++)
            {
              if ($playersFields[7+$k] > 0)
              {
                $players[0] += $playersFields[7+$k];
              }
            }
            #$players[0] += $playersFields[7]; #goals
            #$players[1] += $playersFields[8]; #assists
            #$players[2] += $playersFields[9]; #points
           # $players[3] += $playersFields[10]; #plus/minus
          #  $players[4] += $playersFields[11]; #penalty minutes
         #   $players[5] += $playersFields[12]; #even strength goals
        #    $players[6] += $playersFields[13]; #pwrplay goals
       #     $players[7] += $playersFields[14]; #shrthnd goals
      #      $players[8] += $playersFields[15]; #game winning pts
     #       $players[9] += $playersFields[16]; #even strength assists
    #        $players[10] += $playersFields[17]; #power play assists
   #         $players[11] += $playersFields[18]; #shrthnd assists
  #          $players[12] += $playersFields[19]; #shots
 #           $players[13] += $playersFields[20]; #shooting %
#            $players[14] += $playersFields[21]; #time on ice
#            $players[15] += $playersFields[22]; #avg time on ice
            $i ++; 
         }
      }
   }

   close $playersFH
      or warn "Unable to close players.csv in folder $year during sub playersInfo";   
}


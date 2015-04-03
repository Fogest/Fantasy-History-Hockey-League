#!/usr/bin/perl
use Text::CSV;
use Statistics::R;
############################
#  Use the CSV module

my @matchArray; 

########################JLANGE's CODE#######################
#
#Resources Used:
#http://stackoverflow.com/questions/197933/whats-the-best-way-to-clear-the-screen-in-perl
#This website provided us with the information required to clear the screen after each input.
#

my $csvTestYearFile = Text::CSV->new({ sep_char => ','});
my @yearToTeamFields;
my @tempTeamRoster;
my @teamRoster;
my @yearRoster;
my $countTeams= 0;
my $yearToTeamAbbrev;
my $tempSwapName;
my $tempSwapYear;
my @gameResults;
my $i = 0;
my $j = 0; 
my $tempCounter =0;
my $testVar =0;
my $totalTeams =0;

my $usrInput1 = 0;
my $usrInput2 = 0;
my $usrInput3 = 0;
my $usrInput4 = 0;
my $usrInput5 = 0;
my $usrYearInput = 1900;
my $usrTeamInput = "default";
my $teamCountUp=0;
my $usrAbrInput;
#######testchange
my @teamsForYear;

#####

&clrScreen;

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

    &clrScreen;

    if ($usrInput1 == 1)
    {
        while ($usrInput2 !=3)
        {
            $usrYearInput = 1900;
            print "|----------------------------|\n";
            print "|------Choose Your Team------|\n";
            print "|----------------------------|\n\n";


            print "1.Search by year\n";
            print "2.Manage team roster\n";
            print "3.Return to Main Menu\n\n";
            print "Enter the number of your choice:";
            $usrInput2= <>; 
            chomp ($usrInput2);
            &clrScreen;           
                       
            if ($usrInput2 == 1)
            {
                print "|-----------------------------|\n";
                print "|------ Search by Year------- |\n";
                print "|-----------------------------|\n";
                print "1.Detailed Search\n";
                print "2.Quick Search\n";
                print "3.Multi-Select\n";
                print "4.Back\n\n";
                print "Enter the number of your choice\n";
                print "choice: ";

                $usrInput3 = <>;
                chomp($usrInput3);

                while($usrInput3 < 1 || $usrInput3> 4)
                {
                    &clrScreen;
                    print"Sorry, That was not an option, Please try again\n\n";


                    print "1.Detailed Search\n";
                    print "2.Quick Search\n";
                    print "3.Multi-Select\n";
                    print "4.Back\n\n";
                    print "Enter the number of your choice\n";
                    print "choice: ";

                    $usrInput3 = <>;
                    chomp($usrInput3);
                }


                if($usrInput3 == 1)
                {
                    $usrYearInput = &getInputYear;

                    @teamsForYear = &getTeamYear($usrYearInput);

                    #display teams

                    foreach(@teamsForYear)
                    {
                        foreach(@$_)
                        {
                            if(length($_) > 15)
                            {
                                print "$_\t";
                            }
                            else
                            {
                            print "$_\t\t";
                            }
                         }
                        print"\n";
                    }
                   
                    $usrAbrInput =&getInputAbrev(\@teamsForYear);

                    #add the year and team to the array
                    &clrScreen;
                    foreach(@teamsForYear)
                    {
                        foreach(@$_)
                        {
                            if($_ eq $usrAbrInput)
                            {
                               print"\n$usrYearInput $_ has been added to your list\n";
                               $teamRoster[$countTeams] = $_;
                               $yearRoster[$countTeams] = $usrYearInput; 
                               $countTeams++;
                            }
                        }
                    }

                }
                if($usrInput3 == 2)
                {
                    $usrYearInput = &getInputYear;

                    @teamsForYear = &getTeamYear($usrYearInput);

                    for ($i=0;$i<$#teamsForYear;$i++)
                    {
                        if ($i % 5 == 0)
                        {   
                            print"\n";                        
                        }
                        print "$teamsForYear[$i][1]   "
                    }

                    $usrAbrInput =&getInputAbrev(\@teamsForYear);
                    &clrScreen;
                    foreach(@teamsForYear)
                    {
                        foreach(@$_)
                        {
                            if($_ eq $usrAbrInput)
                            {
                               print"\n***$usrYearInput $_ has been added to your list***\n";
                               $teamRoster[$countTeams] = $_;
                               $yearRoster[$countTeams] = $usrYearInput; 
                               $countTeams++;
                            }
                        }
                    }
                    

                }

                if($usrInput3 == 3)
                {

                    $usrYearInput = &getInputYear;

                    print"select as many teams as you want, or exit to go back\n\n";

                    @teamsForYear = &getTeamYear($usrYearInput);


                    for ($i=0;$i<$#teamsForYear;$i++)
                    {
                        if ($i % 5 == 0)
                        {   
                            print"\n";                        
                        }
                        print "$teamsForYear[$i][1]   "
                    }

                    while(($usrAbrInput =&getInputAbrev(\@teamsForYear,1) ) ne "EXIT"){

                        &clrScreen;
                        foreach(@teamsForYear)
                        {
                            foreach(@$_)
                            {
                                if($_ eq $usrAbrInput)
                                {
                                   print"\n***$usrYearInput $_ has been added to your list***\n";
                                   $teamRoster[$countTeams] = $_;
                                   $yearRoster[$countTeams] = $usrYearInput; 
                                   $countTeams++;
                                }
                            }
                        }
                        
                        print"Select as many teams as you want, or 'exit' to stop\n\n";
                        for ($i=0;$i<$#teamsForYear;$i++)
                        {
                            if ($i % 5 == 0)
                            {   
                                print"\n";                        
                            }
                            print "$teamsForYear[$i][1]   "
                        }
                    }

                }

               
            }
           
            if ($usrInput2 == 2)
            {

                &displayTeamRoster(\@teamRoster,\@yearRoster);  

                print"\n1.Remove Team from Roster\n";
                print"2.swap team positions\n";
                print"3.clear current roster\n";
                print"4.back\n";
                print"\nEnter the number of your choice\n";
                print"choice: ";

                $usrInput3 =<>;
                chomp($usrInput3);

                while($usrInput3 < 1 && $usrInput3 > 4)
                {
                    &clrScreen;
                    &displayTeamRoster(\@teamRoster,\@yearRoster);  
                    print"Sorry, that was not an option, Please try Again\n\n";
                    print"\n1.Remove Team from Roster\n";
                    print"2.Swap team positions\n";
                    print"3.Back\n";
                    print"Enter the number of your choice\n";
                    print"choice: ";

                    $usrInput3 =<>;
                    chomp($usrInput3);
                }

                if($usrInput3 == 1)
                {
                    &clrScreen;
                    &displayTeamRoster(\@teamRoster,\@yearRoster);
                    print"\nEnter the number of the team you want to remove, or 0 to go back\n";
                    print"team #: ";
                    $usrInput4 =<>;
                    chomp($usrInput4);

                    while($usrInput4 < 0 || $usrInput4 > $#teamRoster+1)
                    {
                        &clrScreen;
                        &displayTeamRoster(\@teamRoster,\@yearRoster);
                        print"Sorry that number doesnt match a team, Please try again";
                        print"\nEnter the number of the team you want to remove or 0 to go back\n";
                        print"team #: ";
                        $usrInput4 =<>;
                        chomp($usrInput4);
                    }

                    

                    if($usrInput4 != 0)
                    {
                        &clrScreen;
                        print"\n**Removing: $yearRoster[$usrInput4-1] $teamRoster[$usrInput4-1]**\n";
                        for($i=$usrInput4-1;$i<$#teamRoster;$i++)
                        {
                            $teamRoster[$i]= $teamRoster[$i+1];
                            $yearRoster[$i]= $yearRoster[$i+1];
                        }
                        $#teamRoster = $#teamRoster-1;
                        $#yearRoster = $#yearRoster-1;
                        $countTeams--;
                    }

                }

                if($usrInput3 == 2)
                {
                    &clrScreen;
                    &displayTeamRoster(\@teamRoster,\@yearRoster);
                    print"\nEnter the number of the team you want to swap, or 0 to go back\n";
                    print"team 1 #: ";
                    $usrInput4 =<>;
                    chomp($usrInput4);

                    while($usrInput4 < 0 || $usrInput4 > $#teamRoster+1)
                    {
                        &clrScreen;
                        &displayTeamRoster(\@teamRoster,\@yearRoster);
                        print"Sorry that number doesnt match a team, Please try again";
                        print"\nEnter the number of the team you want to swap or 0 to go back\n";
                        print"team 1 #: ";
                        $usrInput4 =<>;
                        chomp($usrInput4);
                    }

                    if($usrInput4 != 0)
                    {                    
                        print"\nEnter the number of the team to swap with\n";
                        print"team 2 #: ";
                        $usrInput5 =<>;
                        chomp($usrInput5);

                        while($usrInput5 < 1 || $usrInput5 > $#teamRoster+1)
                        {
                            &clrScreen;
                            &displayTeamRoster(\@teamRoster,\@yearRoster);
                            print"Sorry that number doesnt match a team, Please try again\n";
                            print"\nEnter the number of the team you want to swap\n";
                            print"team 2 #: ";
                            $usrInput5 =<>;
                            chomp($usrInput5);
                            
                        }
                        if($usrInput5 == $usrInput4)
                        {
                            &clrScreen;
                            print"Team is already in that position\n";
                            print"\n**nothing to change, returning to menu**\n";
                        }
                        else
                        {

                            $tempSwapName = $teamRoster[$usrInput4-1];
                            $teamRoster[$usrInput4-1] = $teamRoster[$usrInput5-1];
                            $teamRoster[$usrInput5-1] = $tempSwapName;  

                            $tempSwapYear = $yearRoster[$usrInput4-1];
                            $yearRoster[$usrInput4-1] = $yearRoster[$usrInput5-1];
                            $yearRoster[$usrInput5-1] = $tempSwapYear; 

                            &clrScreen;
                            print"***$yearRoster[$usrInput4-1] $teamRoster[$usrInput4-1] swapped with $yearRoster[$usrInput5-1] $teamRoster[$usrInput5-1]***\n";
                        }
                    }
                }

                if($usrInput3 == 3)
                {
                    &clrScreen;
                    &displayTeamRoster(\@teamRoster,\@yearRoster);
                    print"\nAre you sure you want to clear this roster?\n";
                    print"Enter Yes to continue or No to cancel\n";

                    $usrInput4 =<>;
                    chomp($usrInput4);
                    $usrInput4 = uc($usrInput4);    


                    while($usrInput4 ne "YES" && $usrInput4 ne "NO")
                    {
                        &clrScreen;
                        &displayTeamRoster(\@teamRoster,\@yearRoster);
                        print"\nSorry, that was not an option\n";
                        print"\nAre you sure you want to clear this roster?\n";
                        print"Enter Yes to continue or No to cancel\n";

                        $usrInput4 =<>;
                        chomp($usrInput4);
                        $usrInput4 = uc($usrInput4);  
                    }

                    if($usrInput4 eq "YES")
                    {
                        &clrScreen;
                        $#teamRoster = -1;
                        $#yearRoster = -1;
                        $countTeams = 0;
                        print"\n***Team Roster Cleared**\n";
                    }
                }

                if($usrInput3 == 3)
                {
                    &clrScreen;
                }
               
            }               
       }
    }   
    if ($usrInput1 == 2)
    {   
        if($#teamRoster < 1)
        {
            print"Sorry, need at least 2 teams before we continue\n";

        }
        else
        {          
            print "Here are the teams that you have chosen to use for the game: \n";
            for ($i=0;$i<$countTeams;$i++)
            {
                if ($i % 4 == 0)
                {
                    print "\n";   
                }
                print "$yearRoster[$i] $teamRoster[$i]\t";    
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
            
            @gameResults=&loopMatches(\@matchArray); 
        } 
    }
    if($usrInput1==3)
    {
        &clrScreen;
        print"Generating PDF\n";
        &createCsvResults(\@gameResults);
        &pdfMultiplot("output.csv","Season Results","print/seasonResults.pdf");
    }

}

sub getInputAbrev{

    my @teamNameArray= @{$_[0]};
    my $checkForMulti = $_[1];
    my $inputAbr;
    my $i;
    my $found = 0;

    
    
    while(!$found)
    {
        print "\nEnter the team abbreviation you wish to use \n";
        print "team: ";
        $inputAbr = <>;
        chomp ($inputAbr);
        $inputAbr =uc($inputAbr);
        if($checkForMulti)
        {
            if($inputAbr eq "EXIT")
            {
                return  $inputAbr;
            }       
        }
        
        for ($i=0;$i<$#teamNameArray+1;$i++)
        {
            if ($teamNameArray[$i][1] eq $inputAbr)
            {   
                $found = 1;                        
            }
        }

        if(!$found)
        {
            &clrScreen;
            print "Sorry, That team abreviation was not found\n";
            print "Please try again\n";
            print "the available abreviations are: \n";

           
            for ($i=0;$i<$#teamNameArray;$i++)
            {
                if ($i % 5 == 0)
                {   
                    print"\n";                        
                }
                print "$teamNameArray[$i][1]   "
            }
        }
    }

    return $inputAbr;   
}

sub displayTeamRoster{
    my @currentTeams= @{$_[0]};
    my @currentYears= @{$_[1]};
    my $i;
    my $rosterNum;

    &clrScreen;

    print"|-----------------------------|\n";
    print"|------ Current Roster------- |\n";
    print"|-----------------------------|\n";
    print"Team #|\tYear|\tName\n";
    for($i=0;$i<$#currentTeams+1;$i++){
        $rosterNum = $i +1;
        print"$rosterNum\t$currentYears[$i]\t$currentTeams[$i]\n";
    } 
}

sub getInputYear{
    &clrScreen;

    print "Enter a year between 1917 and 2014 or 0 to exit:\n";
    print "Year: ";
    my $inputY= <>;
    chomp ($inputY); 
    &clrScreen;

    while($inputY < 1917 || $inputY > 2014)
    {
        &clrScreen;
        print"Sorry, we only have records from years 1917 to 2014\n";
        print"Please enter a different year\n";
        print"Year: ";
        $inputY= <>;
        chomp ($inputY); 
    }

    return $inputY;
}

sub clrScreen{
    print "\033[2J";    #clear the screen
    print "\033[0;0H"; #jump to 0,0
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
        
        $results[$i][0] = $matchArray[$i][0];
        $results[$i][1] = $matchArray[$i][1];
        $results[$i][2] = $resultHome;
        $results[$i][3] = $matchArray[$i][2];
        $results[$i][4] = $matchArray[$i][3];
        $results[$i][5] = $resultAway;
        

    }
    
    #print the results 
    print"game#\t| year\t| home\t| score\t| year\t| home\t| score\n";
    my $counter = 0;
    foreach(@results)
    {
        $counter++;
        print"$counter\t| @$_[0]\t| @$_[1]\t| @$_[2]\t| @$_[3] \t| @$_[4]\t| @$_[5]\n";
    }
    return @results;


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
sub createCsvResults{
#calculates the PlusMinus of a team given the scores that team made
    my @resultArray = @{$_[0]};
    
    my @pM;
    my $gameNum;
    my $i;

    for($i=0;$i<$#resultArray+1;$i++)
    {
        $pM[$i] = $resultArray[$i][2] - $resultArray[$i][5];
    }

    my $newCsv = "print/output.csv";

    open(my $fh, '>', $newCsv) or die "could not open file";

    print $fh "Game,Differential,Performance\n";
    for($i =0; $i<$#pM+1;$i++)
    {
        $gameNum = $i +1;    
        print $fh "$gameNum,$pM[$i],";
        if($pM[$i] >= 0)
        {
            print $fh "Wins\n";
        }
        else
        {
            print $fh "Losses\n";
        }
    }
    
    close($fh);
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

#IN:    Year
#OUT:   Abbrv of teams that played that year
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

#IN:    Year, Team Abbreviation
#OUT:   $players[0]  = goals
#       $players[1]  = assists
#       $players[2]  = points
#       $players[3]  = plus/minus
#       $players[4]  = penalty minutes
#       $players[5]  = even strength goals
#       $players[6]  = pwrplay goals
#       $players[7]  = shorthand goals
#       $players[8]  = game winning pts
#       $players[9]  = even strength assists
#       $players[10] = power play assists
#       $players[11] = shorthand assists
#       $players[12] = shots
#       $players[13] = shooting %
#       $players[14] = time on ice
#       $players[15] = avg time on ice

sub playersInfo
{
    my $year = $_[0];
    my $teamAbbr = $_[1];
    my $csvPlayers = Text::CSV->new({ sep_char => ',' });

    my @players;

    #
    #  Open the results file - assign a file handle
    #
    open my $playersFH, '<', "../data/$year/players.csv"
        or die "Unable to open results file";

    my $playerRecord = <$playersFH>;

    my $i = 0;

    for (my $j = 0; $j <= 16; $j++) {
        $players[$j] = 0;
    }

    #Saves the game info if the team played in that game
    while( $playerRecord = <$playersFH> ) 
    {
        chomp ($playerRecord);
        if ( $csvPlayers->parse($playerRecord) ) 
        {
            my @playersFields = $csvPlayers->fields();
            if (( $playersFields[3] eq $teamAbbr))
            {
                for (my $k = 0; $k<=16; $k++)
                {
                    if ((defined $playersFields[7+$k]) && ($playersFields[6+$k] ne ""))
                    {
                        $players[$k] += $playersFields[6+$k];
                    }
                }
                $i ++; 
            }
        }
    }
    if ($i == 0)
    {
        print "Team did not play that year\n";
        return;
    }
    for (my $k = 0; $k<=16; $k++)
    {
        if (defined $players[$k])
        {
            $players[$k] = $players[$k] / $i;
        }
    }
    close $playersFH
        or warn "Unable to close players.csv in folder $year during sub playersInfo";

    @players;
}
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

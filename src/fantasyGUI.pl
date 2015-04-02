#!/usr/bin/perl
use strict;
use warnings;
use Text::CSV;
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
	#print "This function is not currently implemented in this version. This function will be implemented in V2 of the program";
    } 
}







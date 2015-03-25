#!/usr/bin/perl
use strict;
#use warnings;

use Text::CSV;

my $usrInput1 = 0;
my $usrInput2 = 0;
my $usrInput3 = 0;
my $usrInput4 = 0;
my $usrYearInput = 1900;
my $usrTeamInput = "default";


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
            print "2.Search by team\n";
            print "3.Return to Main Menu\n\n";
            print "Enter the number of your choice:";
            $usrInput2= <>; 
            print "\033[2J";    #clear the screen
            print "\033[0;0H"; #jump to 0,0            

            if ($usrInput2 == 1)
            {
            while ($usrYearInput != 0)
                {
                    print "Enter a year between 1917 and 2014 that you wish to search for, or 0 to exit:";
                    $usrYearInput= <>; 
                    print "\033[2J";    #clear the screen
print "\033[0;0H"; #jump to 0,0

                    while ((($usrYearInput < 1917) || ($usrYearInput > 2014)) && ($usrYearInput != 0)) {
                        print "Bad Input, please choose a number between 1917 and 2014: ";
                        $usrYearInput= <>; 
                        print "\033[2J";    #clear the screen
                        print "\033[0;0H"; #jump to 0,0 
                    }
                }
            }
            if ($usrInput2 == 2)
            {
                $usrTeamInput = "default"; while ($usrTeamInput ne "exit")
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
        }
    }        
}







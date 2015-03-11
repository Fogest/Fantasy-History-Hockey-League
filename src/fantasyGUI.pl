#!/usr/bin/perl

$usrInput1 = 0;
$usrInput2 = 0;
$usrInput3 = 0;
$usrInput4 = 0;
$usrYearInput = 1900;
$usrTeamInput = "default";
while ( $usrInput1 != 3)
{
    $usrInput2 = 0;
    print "|----------------------------|\n";
    print "| Welcome to Fantasy Hockey  |\n";
    print "|----------------------------|\n";

    print "1. Dashboard\n";
    print "2. Play Game\n";
    print "3. Exit\n\n";

    print "Enter the number of your choice:";
    $usrInput1 = <>;
    if ($usrInput1 == 1)
    {
        while ($usrInput2 !=3)
        {
            $usrYearInput = 1900;
            print "\n\n|----------------------------|\n";
            print "|---------Dashboard----------|\n";
            print "|----------------------------|\n\n";


            print "1.Search by year\n";
            print "2.Search by team\n";
            print "3.Return to Main Menu\n\n";
            print "Enter the number of your choice:";
            $usrInput2= <>;
            
            if ($usrInput2 == 1)
            {
                while ($usrYearInput != 0)
                {
                    print "Enter the year that you wish to search for, or 0 to exit:";
                    $usrYearInput= <>; 
                }
            }
            if ($usrInput2 == 2)
            {
                while ($usrTeamInput ne "exit")
                {
                    print "Here is a list of teams to choose from:";

#
# open the team file which holds all the team abbreviations
# then print to the screen
#
                    $usrTeamInput= "exit";

                    print "\n\nEnter the abreviation you want to use, or type exit to return to the main menu:";
                    $usrTeamInput= <>;
                    if ($usrTeamInput eq "exit")
                    {
                        $usrInput2 = 0; 
                    } 
                }
            }
        }
    }        
}







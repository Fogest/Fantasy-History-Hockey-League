#!/usr/bin/perl

$usrInput1=0;
$usrInput2=0;
$usrInput3=0;
$usrInput4=0;
while( $usrInput1!=3)
{

    print "|----------------------------|\n";
    print "| Welcome to Fantasy Hockey  |\n";
    print "|----------------------------|\n";

    print "1. Dashboard\n";
    print "2. Play Game\n";
    print "3. Exit\n\n";

    print "Enter the number of your choice:";
    $usrInput1= <>;
    if ($usrInput1==1)
    {
        while ( $usrInput2!=3 )
        {
            print "\n\n|----------------------------|\n";
            print "|---------Dashboard----------|\n";
            print "|----------------------------|\n\n";


            print "1.Search by year\n";
            print "2.Search by team\n";
            print "3.Return to Main Menu\n\n";
            print "Enter the number of your choice:";
            $usrInput2= <>;
            
            if ($usrInput2==1)
            {
 #               while

            }
        }        
    }
}







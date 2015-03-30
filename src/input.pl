#!/usr/bin/perl
use strict;
use warnings;
use Text::CSV;


###############testing code####################
print"enter year:";
my $input = <>;
chomp($input);
my @resultY=&getTeamYear($input);

print "TEAMS IN YEAR: \n";
print "-------------------\n";
foreach(@resultY)
{
    print "team: ";
    foreach(@$_)
    {
        print "$_ ";
    }
    print "\n";
}


print "RESULTS OF SEASON: \n";
print "-------------------\n";

#currently only get data for 1 team from the season to display.
#too long an output if you display multiple.

my @resultT = &resultsInfo($input,$resultY[0][1]);

foreach(@resultT)
{
    print"game: ";
    foreach(@$_)
    {
        print"$_ ";
    }
    print "\n";
}
#######end of testing##################################


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

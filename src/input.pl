#!/usr/bin/perl
use strict;
use warnings;
use Text::CSV;


###############testing code####################
print"enter year:";
my $input = <>;
chomp($input);
print"Enter team abbrv: ";
my $inputAbbr = <>;
chomp($inputAbbr);
my @playersOut=&playersInfo($input,$inputAbbr);

#print "TEAMS IN YEAR: \n";
#print "-------------------\n";
foreach(@playersOut)
{
    print "team: ";
    foreach($_)
    {
        print "$_ ";
    }
    print "\n";
}


#print "RESULTS OF SEASON: \n";
#print "-------------------\n";

#currently only get data for 1 team from the season to display.
#too long an output if you display multiple.

#my @resultT = &resultsInfo($input,$resultY[0][1]);

#foreach(@resultT)
#{
#    print"game: ";
#    foreach(@$_)
#    {
#        print"$_ ";
#    }
#    print "\n";
#}
#######end of testing##################################


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

    for (my $j = 0; $j <= 11; $j++) {
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
                for (my $k = 0; $k<=15; $k++)
                {
                    if ((defined $playersFields[7+$k]) && ($playersFields[7+$k] ne ""))
                    {
                        $players[$k] += $playersFields[7+$k];
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
    for (my $k = 0; $k<=15; $k++)
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

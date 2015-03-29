#!/usr/bin/perl
use strict;
use warnings;

# IN: Year
sub getTeamYear
{
   my $teamYear = @_ [0];

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
            $teamNames[i] = $TeamsFields[1];
            $i++;
         }
      }
   }
   close $teamsFH
      or warn "Unable to close teams.csv in folder $year, during sub getTeamYear.";
   @teamNames;
}

# IN: Year, Team abbreviation
# OUT: Results of games the team played in in the format [called team, their score, team they're against, that team's score]
sub resultsInfo
{
   my $year = @_[0];

   use Text::CSV;
   my $csvResults = Text::CSV->new({ sep_char => ',' });

   my @results;

   #
   #  Open the results file - assign a file handle
   #
   open my $resultsFH, '<', "../data/$teamYear/teams.csv"
      or die "Unable to open results file";

   my $resultsRecord = <$resultsFH>;

   my $i = 0;

   #Saves the game info if the team played in that game
   while( $resultsRecord = <$resultsFH> ) {
      chomp ($resultsRecord);
      if ( $csvResults->parse($resultsRecord) ) {
         my @ResultsFields = $csvResults->fields();
         if (($resultsRecord[2] eq $teamAbbr))
         {
            $teamResults[i][0] = $resultsRecord[2];
            $teamResults[i][1] = $resultsRecord[3];
            $teamResults[i][2] = $resultsRecord[5];
            $teamResults[i][3] = $resultsRecord[6];
            $i++;
         }
         else if ($resultsRecord[5] eq $teamAbbr)
         {
            $teamResults[i][0] = $resultsRecord[5];
            $teamResults[i][1] = $resultsRecord[6];
            $teamResults[i][2] = $resultsRecord[2];
            $teamResults[i][3] = $resultsRecord[3];
            $i++;
         }
      }
   }
   close $resultsFH
      or warn "Unable to close results.csv in folder $year during sub resultsInfo";
   @resultsRecord;
}

sub playersInfo
{
   my $year = @_[0];

   use Text::CSV;
   my $csvPlayers = Text::CSV->new({ sep_char => ',' });

   my @players;

   #
   #  Open the results file - assign a file handle
   #
   open my $playersFH, '<', "../data/$year/players.csv"
      or die "Unable to open results file";

   my $playerRecord = <$playerFH>;

my $i = 0;

   #Saves the game info if the team played in that game
   while( $playerRecord = <$resultsFH> ) {
      chomp ($playerRecord);
      if ( $csvResults->parse($playerRecord) ) {
         my @ResultsFields = $csvResults->fields();
         if (($playerRecord[2] eq $teamAbbr))
         {
         }
         else if ($playerRecord[5] eq $teamAbbr)
         {
         }
      }
   }

   close $playersFH
      or warn "Unable to close players.csv in folder $year during sub playersInfo";   
}
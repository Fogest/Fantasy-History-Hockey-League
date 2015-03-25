#!/usr/bin/perl
use strict;
use warnings;

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
   @teamNames;
}

sub information
{
   use Text::CSV;
   my $csvResults = Text::CSV->new({ sep_char => ',' });

   if ($#ARGV != 1 ) {
      print "Usage: Just the Perl file.";
      exit;
   }


   my $year              = 1950;
   my @players;
   my @results;
   my @teams;

   #
   #  Open the scoring file and master file - assign a file handle
   #
   open my $resultsFH, '<', ..\data\$year\results.csv
      or die "Unable to open results file";


   my $resultsRecord = <$resultsFH>;

   my $i = 0;

   while( $resultsRecord = <$resultsFH> ) {
      chomp ($playerRecord);
      if ( $csvResults->parse($resultsRecord) ) {
         my @ResultsFields = $csvResults->fields();
            if ($resultsRecord[2] eq $teamAbbr)
            {
               $teamResults[i][0] = $resultsRecord[3];
               $teamResults[i][1] = $resultsRecord[6];
               $i++;
            }
            else if  ($resultsRecord[5] eq $teamAbbr)
            {
               $teamResults[i][0] = $resultsRecord[6];
               $teamResults[i][1] = $resultsRecord[3];
               $i++;
            }
         }
      }
   }
}
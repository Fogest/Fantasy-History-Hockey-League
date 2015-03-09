//2015-03-08
//Copyright: Justin Visser
var cheerio = require("cheerio");
var request = require('request');
var fs = require('fs');

function doResultsRequest(year, dir, url, csv) {
	request(url, function(err, resp, data){
		if (!err) {
			//console.log(data);
			var $ = cheerio.load(data);
			
			csv += "date,vistor,vistorAbrv,vistorGoals,home,homeAbrv,homeGoals,notes";
			$("#div_games table tr").each(function() {
				$('td',this).each(function(index,element) {
					if($(this).attr("align") != ("center")) {
						if(index == 5)
							csv += '"' + $(this).text() + '"';
						else {
							if(index == 6 && $(this).text() != '')
								csv += '"' + $(this).text() + '"';
							else if(index != 6)
								csv += '"' + $(this).text() + '"' + ',';
						}
						if(index == 1 || index == 3) {
							var re = /\/([A-Z]*)\//g; 
							var match = re.exec($("a",this).attr("href"));
							csv += '"' + match[1] + '"' + ",";
						}
					}
				});
				csv += "\n";
			});
			
			if (!fs.existsSync(dir)){
				fs.mkdirSync(dir);
			}
			
			fs.writeFile(dir + "results.csv", csv, function(err) {
				if(err) {
					console.log(err);
				} else {
					console.log("The file was saved!");
				}
			}); 
		}
	});
}

function doPlayersRequest(year, dir, url, csv) {
	request(url, function(err, resp, data){
		if (!err) {
			//console.log(data);
			var $ = cheerio.load(data);
			
			csv += "rank,player,age,teamName,position,gamesPlayed,goals,assists,points,plusMinus,penaltyMinutes,evenStrengthGoals,powerPlayGoals,shortHandedGoals,gameWinningPoints,evenStrengthAssists,powerPlayAssits,shortHandedAssists,shots,shootingPercentage,timeOnIce,averageTimeOnIce\n";
			$("#div_stats table tbody tr").each(function() {
				//Only take if not one of the headings.
				if(!($(this).hasClass("no_ranker"))) {
					$('td',this).each(function(index,element) {
						if(index >= 21)
							var field = '"' + $(this).text().replace('*','') + '"';
						else
							var field = '"' + $(this).text().replace('*','') + '"' +',';
						csv += field;
					});
					csv += "\n";
				}
			});
			if (!fs.existsSync(dir)){
				fs.mkdirSync(dir);
			}
			
			fs.writeFile(dir + "players.csv", csv, function(err) {
				if(err) {
					console.log(err);
				} else {
					console.log("The file was saved!");
				}
			});
		}
	});
}

function getResults() {
	var year = 1917;
	var dir = "";
	var url = "";
	var csv = "";
	while (year < 2015) {
		dir = "../../data/" + year + "/";
		url = "http://www.hockey-reference.com/leagues/NHL_"+ (year+1) +"_games.html";
		
		csv = "";
		doResultsRequest(year, dir, url, csv);
		url = "http://www.hockey-reference.com/leagues/NHL_"+ (year+1) +"_skaters.html";
		csv = "";
		doPlayersRequest(year, dir, url, csv);
		
		year++;
	}
}

function testing() {
	var year = 1917;
	var dir = "";
	var url = "";
	var csv = "";
	
	dir = "../../data/" + year + "/";
	url = "http://www.hockey-reference.com/leagues/NHL_"+ (year+1) +"_skaters.html";
	csv = "";
	doPlayersRequest(year, dir, url, csv);
	
	year++;
}

//testing();
getResults();
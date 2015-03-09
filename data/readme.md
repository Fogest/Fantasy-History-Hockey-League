# L.A. Kings Data.
Data collected/scraped by [Justin Visser](https://jhvisser.com) on 2015-03-08.

## About
Hello, thank you for taking an interest in our data! L.A Kings data files from [hockey-reference](http://www.hockey-reference.com/). All data is from the NHL league. The data is fair game for anyone to use. The data is from years 1917-2014. These are ALL of the years that is provided on the website. 

The file structure is: `<year>/<csvName>.csv`. An example is `2000/players.csv`. The years represent the **start** years of the season, not the end year! 
### The different files
1. `players.csv` - Contains the the players for ALL teams for the specific year. Use the "teamName" heading to get the abbreviated team name of the player. There is a large amount of data here about each player. 
2. `results.csv` - Contains the results of every single game during the season. Includes who played who, the score, as well as dates and abbreviations. 
3. `teams.csv` - Simply a list of all the teams in a season associated with some stats about the team. Includes full team name and abbreviations. 
4. `goalies.csv` - Provides a file just like `players.csv` except with data for goalies. This is all of the goalies for the season! 

### CSV Format
The csv is formatted just like Hockey Reference's tables, except in some cases a team abbreviation has been added on as the table did not contain them. The abbreviations are present in every CSV file. This is the ideal way to refer to teams. The full name is only in `teams.csv` and `results.csv`, but is not in `players.csv` so be careful!

The first row of every csv file are the headings for the CSV file (csv standard). The rows following are all data rows. Every single field is within quoation marks. This avoids any issues with commas. This is still a valid CSV format and the Perl Parser should have no problems reading it.

If you look at the files from early years there are usually a lot of missing stats. This is not a bug, this is just what the tables contained. The headings are all still present however, and the column still contains a `""`. So you simply should check if the field is empty or not. The years closer to ours usually contain full data.

## Methodology
The data was collected via a javascript file running with [Nodejs](https://nodejs.org/). The file includes the following libraries: [cheerio](https://github.com/cheeriojs/cheerio), [request](https://github.com/request/request), and [fs](https://nodejs.org/api/fs.html).

## Misc
If you would like the data in any other format feel free to contact me and I may be able to help you. Simply email me at [justin@jhvisser.com](mailto:justin@jhvisser.com) and I'll get back to you ASAP. The code used to scrape the website is made by me (Justin Visser), and will not be shared. Only data is being shared, no code! 

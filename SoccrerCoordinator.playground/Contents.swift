/*
 * Assumption, for this project, we are asked to store all the data as Strings. Therefore, we
 * need to calculate an average of Doubles without type casting. The following data structure is
 * is a workaround to the previous explained limitation
 */
let playerHeights: [String: Double] = [
    "Joe Smith":           42.0,
    "Jill Tanner":         36.0,
    "Bill Bon":            43.0,
    "Eva Gordon":          45.0,
    "Matt Gill":           40.0,
    "Kimmy Stein":         41.0,
    "Sammy Adams":         45.0,
    "Karl Saygan":         42.0,
    "Suzane Greenberg":    44.0,
    "Sal Dali":            41.0,
    "Joe Kavalier":        39.0,
    "Ben Finkelstein":     44.0,
    "Diego Soto":          41.0,
    "Chloe Alaska":        47.0,
    "Arnold Willis":       43.0,
    "Phillip Helm":        44.0,
    "Les Clay":            42.0,
    "Herschel Krustofski": 45.0
]

let players = [
    [ "name": "Joe Smith",           "height": "42", "hasExperience": "YES", "guardianName": "Jim and Jan Smith"           ],
    [ "name": "Jill Tanner",         "height": "36", "hasExperience": "YES", "guardianName": "Clara Tanner"                ],
    [ "name": "Bill Bon",            "height": "43", "hasExperience": "YES", "guardianName": "Sara and Jenny Bon"          ],
    [ "name": "Eva Gordon",          "height": "45", "hasExperience": "NO",  "guardianName": "Wendy and Mike Gordon"       ],
    [ "name": "Matt Gill",           "height": "40", "hasExperience": "NO",  "guardianName": "Charles and Sylvia Gill"     ],
    [ "name": "Kimmy Stein",         "height": "41", "hasExperience": "NO",  "guardianName": "Bill and Hillary Stein"      ],
    [ "name": "Sammy Adams",         "height": "45", "hasExperience": "NO",  "guardianName": "Jeff Adams"                  ],
    [ "name": "Karl Saygan",         "height": "42", "hasExperience": "YES", "guardianName": "Heather Bledsoe"             ],
    [ "name": "Suzane Greenberg",    "height": "44", "hasExperience": "YES", "guardianName": "Henrietta Dumas"             ],
    [ "name": "Sal Dali",            "height": "41", "hasExperience": "NO",  "guardianName": "Gala Dali"                   ],
    [ "name": "Joe Kavalier",        "height": "39", "hasExperience": "NO",  "guardianName": "Sam and Elaine Kavalier"     ],
    [ "name": "Ben Finkelstein",     "height": "44", "hasExperience": "NO",  "guardianName": "Aaron and Jill Finkelstein"  ],
    [ "name": "Diego Soto",          "height": "41", "hasExperience": "YES", "guardianName": "Robin and Sarika Soto"       ],
    [ "name": "Chloe Alaska",        "height": "47", "hasExperience": "NO",  "guardianName": "David and Jamie Alaska"      ],
    [ "name": "Arnold Willis",       "height": "43", "hasExperience": "NO",  "guardianName": "Claire Willis"               ],
    [ "name": "Phillip Helm",        "height": "44", "hasExperience": "YES", "guardianName": "Thomas Helm and Eva Jones"   ],
    [ "name": "Les Clay",            "height": "42", "hasExperience": "YES", "guardianName": "Wynonna Brown"               ],
    [ "name": "Herschel Krustofski", "height": "45", "hasExperience": "YES", "guardianName": "Hyman and Rachel Krustofski" ],
];

var experiencedPlayers: [[String: String]] = []
var unexperiencedPlayers: [[String: String]] = []

var teamSharks: [[String: String]] = []
var teamDragons: [[String: String]] = []
var teamRaptors: [[String: String]] = []

var letters: [String] = []

let numberOfTeams = 3

/*
 * Helper function to check if a player is experienced or not
 */
func hasExperience(player: [String: String]) -> Bool {
    return player["hasExperience"] == "YES"
}

/*
 * Separate players in two groups of players (experienced vs. unexperienced)
 */
func splitPlayersByExperience() {
    for player in players {
        if hasExperience(player: player) {
            experiencedPlayers.append(player)
        } else {
            unexperiencedPlayers.append(player)
        }
    }
}

func sortPlayersByHeight(players: [[String: String]]) -> [[String: String]] {
    return players.sorted {
        return playerHeights[$0["name"]!]! < playerHeights[$1["name"]!]!
    }
}

/*
 * Lookup team from its name
 */
func getTeam(fromName name: String) -> (players: [[String: String]], playDate: String) {
    switch name {
        case "Sharks": return (players: teamSharks, playDate: "March 17, 1pm")
        case "Dragons": return (players: teamDragons, playDate: "March 17, 3pm")
        case "Raptors": return (players: teamRaptors, playDate: "March 18, 1pm")
        default:
            print("There is no team for name: \(name)")
            return (players: [[:]], playDate: "n/a")
    }
}

/*
 * Count the number of experienced players in a collection of players
 */
func countExperiencedPlayers(players: [[String: String]]) -> Int {
    var nbExperiencedPlayers = 0
    
    for player in players {
        if hasExperience(player: player) {
            nbExperiencedPlayers += 1
        }
    }
    
    return nbExperiencedPlayers;
}

/*
 * Assign the players to a team
 */
func assignPlayers(players: [[String: String]]) {
    for i in 0..<players.count {
        if (i % numberOfTeams == 0) { // First team
            teamSharks.append(players[i])
        } else if (i % numberOfTeams == 1) { // Second team
            teamDragons.append(players[i])
        } else { // Third team
            teamRaptors.append(players[i])
        }
    }
}

/*
 * Compute the repartion of all the players in the different teams
 */
func processRepartition() {
    splitPlayersByExperience()
    
    experiencedPlayers = sortPlayersByHeight(players: experiencedPlayers)
    unexperiencedPlayers = sortPlayersByHeight(players: unexperiencedPlayers)
    
    assignPlayers(players: experiencedPlayers)
    assignPlayers(players: unexperiencedPlayers)
}

/*
 * Create the letter content with data:
 * - playDate, team name, player name and guardian name
 */
func createLetter(forPlayer player: [String: String], teamName: String, playDate: String) -> String {
    return "Fellow Guardian \(player["guardianName"]!),\n\n" +
        "Your child \(player["name"]!) is invited to play his soccer game on the \(playDate). Don't miss the date.\n\n" +
        "Take note that your child will be part of the team \(teamName).\n\n" +
        "Best regards.\n" +
        "Your Soccer Leaguer Coordinator - Laurent"
}

/*
 * Helper function to print a single letter
 */
func printLetter(letter: String) {
    print("--------------------------------")
    print(letter)
    print("--------------------------------")
    print()
    print()
}

/*
 * Create all the letters for a specific team
 */
func createLetters(forTeam name: String) {
    let teamData = getTeam(fromName: name)
    
    for player in teamData.players {
        letters.append(createLetter(forPlayer: player, teamName: name, playDate: teamData.playDate))
        printLetter(letter: letters.last!)
    }
}

processRepartition()

/*
 * Create letters for all the teams
 */
let teams = [ "Sharks", "Dragons", "Raptors" ]
for team in teams {
    createLetters(forTeam: team)
}

func calculateAvgHeight(players: [[String: String]]) -> Double {
    var sum = 0.0
    var nbPlayers = 0.0
    
    for player in players {
        sum += playerHeights[player["name"]!]!
        nbPlayers += 1.0
    }
    
    return sum / nbPlayers
}

print("Average height of team Sharks is: \(calculateAvgHeight(players: teamSharks)) inches")
print("Average height of team Dragons is: \(calculateAvgHeight(players: teamDragons)) inches")
print("Average height of team Raptors is: \(calculateAvgHeight(players: teamRaptors)) inches")




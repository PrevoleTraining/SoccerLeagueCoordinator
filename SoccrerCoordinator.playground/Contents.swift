/*
 * Assumption, for this project, we are asked to store all the data as Strings. Therefore, we
 * need to calculate an average of Doubles without type casting. The following data structure is
 * is a workaround to the previous explained limitation
 *
 * Having the heights directly into the players data in Double type can help to really simplify the code.
 * For example, we can avoid double guards: one for player from players, another one for player height
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

/*
 * Accordingly to my understanding of the instructions, we have to set a dictionnary for players with all the data as Strings
 */
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

let heightAverageThreshold = 1.5

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
        // Arbitrary sort unknown any player name
        guard let leftName = $0["name"], let rightName = $1["name"] else {
            return false
        }
        
        // Arbitrary sort unknown player height
        guard let leftHeight = playerHeights[leftName], let rightHeight = playerHeights[rightName] else {
            return false
        }
        
        return leftHeight < rightHeight
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
func countExperienced(players: [[String: String]]) -> Int {
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
func assign(players: [[String: String]]) {
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
    
    assign(players: experiencedPlayers)
    assign(players: unexperiencedPlayers)
}

func createLetterTextWith(playerName: String, guardianName: String, teamName: String, playDate: String) -> String {
    return """
Fellow Guardian \(guardianName),

Your child \(playerName) is invited to play his soccer game on the \(playDate). Don't miss the date.

Take note that your child will be part of the team \(teamName).

Best regards.
Your Soccer Leaguer Coordinator - Laurent
"""
}

/*
 * Create the letter content with data:
 * - playDate, team name, player name and guardian name
 */
func createLetter(for player: [String: String], teamName: String, playDate: String) -> String {
    guard let playerName = player["name"] else {
        print("No player name for player \(player)")
        return createLetterTextWith(playerName: "Unknown player", guardianName: "Unknown guardian", teamName: teamName, playDate: playDate)
    }
    
    guard let guardianName = player["guardianName"] else {
        print("No guardian name for player \(player)")
        return createLetterTextWith(playerName: playerName, guardianName: "Unknown guardian", teamName: teamName, playDate: playDate)
    }
 
    return createLetterTextWith(playerName: playerName, guardianName: guardianName, teamName: teamName, playDate: playDate)
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
func createLetters(for name: String) {
    let teamData = getTeam(fromName: name)
    
    for player in teamData.players {
        letters.append(createLetter(for: player, teamName: name, playDate: teamData.playDate))
        
        guard let lastInsertedLetter = letters.last else {
            print("The last letter is unreadable or was lost by the post office")
            printLetter(letter: "Oops! The letter was lost in an electric storm")
            return
        }
        
        printLetter(letter: lastInsertedLetter)
    }
}

processRepartition()

/*
 * Create letters for all the teams
 */
let teams = [ "Sharks", "Dragons", "Raptors" ]
for team in teams {
    createLetters(for: team)
}

/*
 * Calculate the average height of a collection of players
 */
func calculateAvgHeight(players: [[String: String]]) -> Double {
    var sum = 0.0
    var nbPlayers = 0.0 // Avoid type casting
    
    for player in players {
        guard let playerName = player["name"] else {
            print("Unknown player name for \(player), continue to next player")
            continue
        }
        
        guard let playerHeight = playerHeights[playerName] else {
            print("Unknown player height for \(playerName), continue to next player")
            continue
        }
        
        sum += playerHeight
        nbPlayers += 1.0
    }
    
    return sum / nbPlayers
}

/*
 * Calculate the average height of all teams and return the result
 * in this order: sharks, dragons and raptors
 */
func calculateAvgHeightForAllTeams() -> [Double] {
    return [
        calculateAvgHeight(players: teamSharks),
        calculateAvgHeight(players: teamDragons),
        calculateAvgHeight(players: teamRaptors)
    ]
}

// Acts as a random number
var permutationIndex = 0

/*
 * Permute a player from first team to second team, and a player from second team to first team.
 *
 * By definition, the teams are ordered in terms of experienced players are placed first and then
 * the other players. Also, each team has the same number of experienced players and non-experienced.
 * Therefore, we can permute any player as long as we permute the same position in both teams.
 * Ex: teamA -> first player with teamB -> first player
 */
func permutePlayersBetweenTeams(first firstTeam: [[String: String]], second secondTeam: [[String: String]]) -> (first: [[String: String]], second: [[String: String]]) {
    var teams: (first: [[String: String]], second: [[String: String]]) = (first: firstTeam, second: secondTeam)
    
    // Avoid permutation between always the same players. A random permutation is also a possibility.
    let realPermutationIndex = permutationIndex % firstTeam.count
    
    let perumtedPlayer = teams.first[realPermutationIndex]
    teams.first[realPermutationIndex] = teams.second[realPermutationIndex]
    teams.second[realPermutationIndex] = perumtedPlayer
    
    permutationIndex += 1
    
    return teams
}

/*
 * Retrieve a team based on a index where:
 * 1 -> sharks, 2 -> dragons, 3 -> raptors
 */
func getTeam(for index: Int) -> [[String: String]] {
    switch (index) {
        case 0: return teamSharks
        case 1: return teamDragons
        case 2: return teamRaptors
        default:
            print("Ouch! There is no team for index \(index)")
            return []
    }
}

/*
 * Update a team with the same principle of index. The mapping
 * is the same than getTeam
 */
func updateTeam(with team: [[String: String]], for index: Int) {
    switch (index) {
        case 0: teamSharks = team
        case 1: teamDragons = team
        case 2: teamRaptors = team
        default: print("Ouch! There is no team for index \(index)")
    }
}

/*
 * Manage the permutation of players between two teams based of the team with the lowest height average and
 * the team with the highest height average.
 */
func managePermutationWith(averageHeights: [Double], minAverage: Double, maxAverage: Double) {
    guard let firstTeamIndex = averageHeights.index(of: minAverage), let secondTeamIndex = averageHeights.index(of: maxAverage) else {
        print("Ouch! There is no index for min or max average. Should not be possible here!")
        return
    }
    
    // Retrieve the teams
    let firstTeam = getTeam(for: firstTeamIndex)
    let secondTeam = getTeam(for: secondTeamIndex)
    
    // Proceed the permutation of players between both team
    let teams = permutePlayersBetweenTeams(first: firstTeam, second: secondTeam)
    
    updateTeam(with: teams.first, for: firstTeamIndex)
    updateTeam(with: teams.second, for: secondTeamIndex)
}

var averageRuleRepected: Bool

repeat {
    let teamHeightAverages: [Double] = calculateAvgHeightForAllTeams()
    
    // Retrieve the min and max of the averages
    guard let minAverage = teamHeightAverages.min(), let maxAverage = teamHeightAverages.max() else {
        print("Ouch! There is no min or no max. Should not be possible here!")
        break
    }
    
    // Diff the averages to check against threshold
    averageRuleRepected = maxAverage - minAverage < heightAverageThreshold
    
    // If the threshold rule is not respected, we try to permute two players between two teams
    if (!averageRuleRepected) {
        managePermutationWith(averageHeights: teamHeightAverages, minAverage: minAverage, maxAverage: maxAverage)
    }
} while (!averageRuleRepected)

print("Average height of team Sharks is: \(calculateAvgHeight(players: teamSharks)) inches")
print("Average height of team Dragons is: \(calculateAvgHeight(players: teamDragons)) inches")
print("Average height of team Raptors is: \(calculateAvgHeight(players: teamRaptors)) inches")




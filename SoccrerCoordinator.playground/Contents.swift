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

var teamSharks: [[String: String]] = []
var teamDragons: [[String: String]] = []
var teamRaptors: [[String: String]] = []

func hasExperience(player: [String: String]) -> Bool {
    return player["hasExperience"] == "YES"
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

let numberOfTeams = 3

let numberOfPlayersPerTeam = players.count / numberOfTeams
let totalExperiencedPlayers = countExperiencedPlayers(players: players)
let numberOfExperiencedPlayersPerTeam = totalExperiencedPlayers / numberOfTeams

/*
 * Check if the player can be assigned to the team according to the givent rules
 * - Same number of experienced players in all teams
 */
func playerCanBeAssigned(toTeam players: [[String: String]], withPlayer player: [String: String]) -> Bool {
    // Do not add more players than it is allowed
    if players.count >= numberOfPlayersPerTeam {
        return false;
    }
    
    // When player has experience, we check we not have the maximum of experienced players in the team
    if hasExperience(player: player) {
        return countExperiencedPlayers(players: players) < numberOfExperiencedPlayersPerTeam
    } else { // When player has no experience, we check the maximum remaining players in the team is reached
        return players.count - countExperiencedPlayers(players: players) < numberOfPlayersPerTeam - numberOfExperiencedPlayersPerTeam
    }
}

var playersToAssign = players

for player in playersToAssign {
    // We try to assign the player to the first team, then the second and finally the third team
    if playerCanBeAssigned(toTeam: teamSharks, withPlayer: player) {
        teamSharks.append(player)
    } else if playerCanBeAssigned(toTeam: teamDragons, withPlayer: player) {
        teamDragons.append(player)
    } else if playerCanBeAssigned(toTeam: teamRaptors, withPlayer: player) {
        teamRaptors.append(player)
    }
}


print(teamSharks)
print(teamSharks.count)
print(teamDragons)
print(teamDragons.count)
print(teamRaptors)
print(teamRaptors.count)




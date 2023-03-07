import Foundation

struct PlayGame {
   
    private(set) var playerChoice: GameOptions = .rock
    private(set) var compChoice: GameOptions = .rock
    private(set) var playerWins = 0
    private(set) var compWins = 0
    private(set) var roundTitle = ""
    private(set) var roundText = ""
    private(set) var winGame = true
    var endOfRound = false
    var endOfGame = false
    var round = 0
    
    var winnerTitle: String {
        if playerWins == compWins {
            return "Tie Game"
        } else if playerWins > compWins {
            return "You Won!"
        } else {
            return "Computer Won"
        }
    }
    
    var winnerText: String {
        return "Computer: \(compWins) / Player: \(playerWins)"
    }
    
    mutating func setPlayerChoice(with choice: GameOptions) {
        playerChoice = choice
    }
    mutating func setCompChoice() {
        compChoice = GameOptions.allCases.randomElement() ?? .rock
    }
    
    mutating func playRound(win: Bool) {
        roundText = "Computer: \(compChoice.rawValue)\nPlayer: \(playerChoice.rawValue)"
        switch compChoice {
        case .rock:
            if playerChoice == .scissors {
                if win {
                    compWins += 1
                    roundTitle = "Computer Won"
                } else {
                    playerWins += 1
                    roundTitle = "Player Won"
                }
            } else if playerChoice == .paper {
                if win {
                    playerWins += 1
                    roundTitle = "Player Won"
                } else {
                    compWins += 1
                    roundTitle = "Computer Won"
                }
            } else {
                roundTitle = "It's a Tie"
            }
        case .paper:
            if playerChoice == .rock {
                if win {
                    compWins += 1
                    roundTitle = "Computer Won"
                } else {
                    playerWins += 1
                    roundTitle = "Player Won"
                }
            } else if playerChoice == .scissors {
                if win {
                    playerWins += 1
                    roundTitle = "Player Won"
                } else {
                    compWins += 1
                    roundTitle = "Computer Won"
                }
            } else {
                roundTitle = "It's a Tie"
            }
        case .scissors:
            if playerChoice == .paper {
                if win {
                    compWins += 1
                    roundTitle = "Computer Won"
                } else {
                    playerWins += 1
                    roundTitle = "Player Won"
                }
            } else if playerChoice == .rock {
                if win {
                    playerWins += 1
                    roundTitle = "Player Won"
                } else {
                    compWins += 1
                    roundTitle = "Computer Won"
                }
            } else {
                roundTitle = "It's a Tie"
            }
        }
        
        winGame = Bool.random()
        endOfRound.toggle()
    }
    
    mutating func resetGame() {
        round = 0
        playerWins = 0
        compWins = 0
        
    }
    
}

enum GameOptions: String, CaseIterable {
    case rock = "🪨"
    case paper = "📄"
    case scissors = "✂️"
}

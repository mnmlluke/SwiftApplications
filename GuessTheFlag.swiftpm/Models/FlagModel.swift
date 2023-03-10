import SwiftUI

struct FlagModel {
    var showingScore = false
    var endOfGame = false
    var scoreTitle = ""
    var scoreText = ""
    var score = ["Correct": 0, "Wrong": 0]
    var round = 0
    var animationAmount = 0.0
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    var correctAnswer = Int.random(in: 0...2)
    
    mutating func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreText = "That is Correct"
            score["Correct"]? += 1
        } else {
            scoreTitle = "Wrong"
            scoreText = "That’s the flag of \(countries[number])"
            score["Wrong"]? += 1
        }
        showingScore = true
        round += 1
    }
    
    mutating func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
    mutating func resetGame() {
        score = ["Correct": 0, "Wrong": 0]
        round = 0
        askQuestion()
    }
    
    
}

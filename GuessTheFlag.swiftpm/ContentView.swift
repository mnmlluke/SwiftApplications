import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var endOfGame = false
    @State private var scoreTitle = ""
    @State private var scoreText = ""
    @State private var score = ["Correct": 0, "Wrong": 0]
    @State private var round = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    func flagTapped(_ number: Int) {
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
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = ["Correct": 0, "Wrong": 0]
        round = 0
        askQuestion()
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag")
                    .titleView()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0 ..< 3) { number in
                        Button {
                            if round < 7 {
                                flagTapped(number)
                            } else {
                                scoreText = "You had \(score["Correct"] ?? 0) Correct and \(score["Wrong"] ?? 0) Wrong."
                                scoreTitle = "End Of Game"
                                endOfGame = true
                            }
                            
                        } label: {
                            FlagView(imageName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score["Correct"] ?? 0) / 8")
                    .titleView()
                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreText)
        }
        .alert(scoreTitle, isPresented: $endOfGame) {
            Button("Reset", action: resetGame)
        } message: {
            Text(scoreText)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

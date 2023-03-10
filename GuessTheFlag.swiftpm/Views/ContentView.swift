import SwiftUI

struct ContentView: View {

    @State var game = FlagModel()
    @State var faded = [false, false, false]
    
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
                        Text(game.countries[game.correctAnswer])
                            .foregroundColor(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0 ..< 3) { number in
                        FlagView(image: game.countries[number]){
                            switch number {
                            case 0:
                                faded = [false, true, true]
                            case 1:
                                faded = [true, false, true]
                            case 2:
                                faded = [false, false, true]
                            default:
                                faded = [false, false, false]
                            }
                            if game.round < 7 {
                                game.flagTapped(number)
                            } else {
                                game.scoreText = "You had \(game.score["Correct"] ?? 0) Correct and \(game.score["Wrong"] ?? 0) Wrong."
                                game.scoreTitle = "End Of Game"
                                game.endOfGame = true
                            }
                        }
                        .opacity(faded[number] ? 0.25 : 1.0)
                        .scaleEffect(faded[number] ? 0.75 : 1.0)
                        .animation(.default)
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(game.score["Correct"] ?? 0) / 8")
                    .titleView()
                Spacer()
            }
            .padding()
            
        }
        .alert(game.scoreTitle, isPresented: $game.showingScore) {
            Button("Continue") {
                game.askQuestion()
                faded = [false, false, false]
            }
        } message: {
            Text(game.scoreText)
        }
        .alert(game.scoreTitle, isPresented: $game.endOfGame) {
            Button("Reset") {
                game.resetGame()
                faded = [false, false, false]
            }
        } message: {
            Text(game.scoreText)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

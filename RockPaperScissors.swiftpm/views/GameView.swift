import SwiftUI

struct GameView: View {
    
    @State var game = PlayGame()
    
    var body: some View {
        ZStack {
            // background
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Main Content
            VStack {
                Spacer()
                TitleView(text: "Rock, Paper, Scissors")
                Spacer()
                
                Text("Round \(game.endOfGame ? 10 :  game.round + 1) of 10")
                    .foregroundColor(.white)
                // user selections
                VStack(spacing: 15) {
                    Text("You will need to \(game.winGame ? "WIN" : "LOSE") the round.\nPlease choose your option.")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                        .multilineTextAlignment(.center)
                        
                    
                    HStack {
                        ForEach(GameOptions.allCases, id: \.self){ option in
                            Spacer()
                            Button {
                                game.setPlayerChoice(with: option)
                                game.setCompChoice()
                                game.playRound(win: game.winGame)
                                
                            } label: {
                                ChoiceView(option: option)
                            }
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                // Score Information
                Spacer()
                ScoreView(player: game.playerWins, comp: game.compWins)
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            
        
            
        }
        .alert(game.roundTitle, isPresented: $game.endOfRound) {
            Button("Continue") {
                game.round += 1
                if game.round > 9 {
                    game.endOfGame.toggle()
                }
            }
        } message: {
            Text(game.roundText)
        }
        .alert(game.winnerTitle, isPresented: $game.endOfGame) {
            Button("Play Again") {
                game.resetGame()
            }
        } message: {
            Text(game.winnerText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

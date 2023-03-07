import SwiftUI

struct ScoreView: View {
    var player: Int
    var comp: Int
    var body: some View {
        TitleView(text: "Score")
            .padding()
        HStack {
            Spacer()
            VStack{
                Text("Computer")
                    .font(.title)
                    .padding(.bottom, 10)
                Text("\(comp)")
                    .font(.title2.bold())
            }
            Spacer()
            VStack {
                Text("Player")
                    .font(.title)
                    .padding(.bottom, 10)
                Text("\(player)")
                    .font(.title2.bold())
            }
            Spacer()
        }
        .foregroundColor(.white)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(player: 0, comp: 0)
    }
}

import SwiftUI

struct FlagView: View {
    @State private var animationAmount = 0.0
    let image: String
    let action: () -> ()
    
    
    var body: some View {
        Button {
            withAnimation {
                animationAmount += 360
                action()
            }
        } label: {
            Image(image)
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
        }
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagView(image: "US") {
            print("hello")
        }
    }
}

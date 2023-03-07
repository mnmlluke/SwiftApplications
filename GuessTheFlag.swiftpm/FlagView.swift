import SwiftUI

struct FlagView: View {
    
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagView(imageName: "US")
    }
}

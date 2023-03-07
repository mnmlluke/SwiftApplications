import SwiftUI

struct TitleView: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(text: "Test")
    }
}

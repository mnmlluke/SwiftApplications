import SwiftUI

struct ChoiceView: View {
    var option: GameOptions
        
        var body: some View {
            Text(option.rawValue)
                .font(.system(size: 72))
        }
}

struct ChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceView(option: GameOptions.rock)
    }
}

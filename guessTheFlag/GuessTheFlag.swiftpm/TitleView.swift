import SwiftUI

struct TitleView: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

extension View {
    func titleView() -> some View {
        modifier(TitleView())
    }
}

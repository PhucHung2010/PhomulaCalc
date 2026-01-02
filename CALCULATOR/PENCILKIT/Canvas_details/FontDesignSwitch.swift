import SwiftUI

enum FontDesign: String, CaseIterable {
    case Default = "default"
    case Rounded = "round"
    case Serif = "serif"
}

struct FontDesignSwitch: View {
    @Namespace private var animation
    @Binding var selectedFont: FontDesign
    @Binding var fontReturn: Font.Design
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(FontDesign.allCases, id: \.rawValue) { font in
                    Number("\(font.rawValue)", numberColor: selectedFont == font ? .darkGray : .white, fontWeight: .bold, fontSize: 12.5)
                        .scaleEffect(selectedFont == font ? 1.2 : 1)
                        .animation(.easeInOut(duration: 0.3), value: selectedFont)
                        .frame(width: 55, height: 30)
                        .background(
                            ZStack {
                                if selectedFont == font {
                                    RoundedRectangle(cornerRadius: 45)
                                        .fill(Color.white)
                                        .matchedGeometryEffect(id: "switch", in: animation)
                                }
                            }
                            .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.3, blendDuration: 0.3), value: selectedFont)
                        )
                        .onTapGesture {
                            selectedFont = font
                            if selectedFont == .Default {
                                fontReturn = .default
                            }
                            else if selectedFont == .Rounded {
                                fontReturn = .rounded
                            }
                            else {
                                fontReturn = .serif
                            }
                        }
                }
            }
            .padding(3.5)
            .shadow(radius: 4)
            .background(RoundedRectangle(cornerRadius: 45).opacity(0.2))
        }
    }
}


//struct FontDesignSwitch_Previews: PreviewProvider {
//    static var previews: some View {
//        FontDesignSwitch(selectedFont: FontDesign.Default)
//    }
//}

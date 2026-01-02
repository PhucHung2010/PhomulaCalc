//
//  PopUp.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 05/10/2024.
//

import SwiftUI


struct NoteGuide: View {
    @Binding var showPopup: Bool
    @State private var currentSlide = 0
    let totalSlides = 18
    
    var THEME: ThemeStyle
    
    var body: some View {
        ZStack {
            
            if showPopup {
                BlurView(style: .systemUltraThinMaterialDark) // Hiệu ứng blur mạnh hơn
                    .ignoresSafeArea()
                    .onTapGesture {
                        // Đóng pop-up khi bấm vào bất kỳ đâu
                        showPopup = false
                        currentSlide = 0
                    }
                    .transition(.opacity)
            }

            // Pop-up Content with blur background
            if showPopup {
                VStack(spacing: 0) {
                    Text("Note")
                        .foregroundColor(THEME.CircleFunctionButton_characterColor)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                        .shadow(radius: 4)
                        .padding()

                    TabView(selection: $currentSlide) {
                        Group {
                            SlideView("pencil.tip.crop.circle", description: "Dive into your creation!", THEME: THEME)
                                .tag(0)
                            SlideView("pencil.tip.crop.circle.badge.plus", description: "Let's add new canvas!", THEME: THEME)
                                .tag(1)
                            SlideView("rectangle.and.text.magnifyingglass", description: "Name the cavas", THEME: THEME)
                                .tag(2)
                            SlideView("square.grid.2x2", description: "Tap on canvas to make notes", THEME: THEME)
                                .tag(3)
                            SlideView("rectangle.and.hand.point.up.left.fill", description: "Tap and hold the canvas for 1.5 sec to preview or delete", THEME: THEME)
                                .tag(4)
                            SlideView("pencil", description: "Tap on the pencil icon to begin drawing", THEME: THEME)
                                .tag(5)
                            SlideView("xmark.circle", description: "Tap on the x icon to clear the canvas", THEME: THEME)
                                .tag(6)
                            SlideView("trash", description: "Tap on the trash icon to delete the canvas", THEME: THEME)
                                .tag(7)
                            SlideView("square.and.arrow.down", description: "Tap on the save icon to add the canvas to your photo library", THEME: THEME)
                                .tag(8)
                            SlideView("rectangle.grid.2x2.fill", description: "Tap on the grid icon to return home", THEME: THEME)
                                .tag(9)
                        }
                        Group {
                            SlideView("character.textbox", description: " Tap on the chacracter box to add new text", THEME: THEME)
                                .tag(10)
                            SlideView("slider.horizontal.below.rectangle", description: "Drag the slider to select your text font and color", THEME: THEME)
                                .tag(11)
                            SlideView("circle.dotted", "circle.dotted", "hand.tap.fill", description: "Double tap on the text to enable dragging", THEME: THEME)
                                .tag(12)
                            SlideView("circle.dotted", "circle.dotted", "circle.dotted" , "hand.tap.fill", description: "Triple tap on the text to enable scrolling", THEME: THEME)
                                .tag(13)
                            SlideView("dot.circle.and.hand.point.up.left.fill", description: "Tap and hold for 1.5 sec to change text properties", THEME: THEME)
                                .tag(14)
                            SlideView("text.badge.xmark", description: "To delete a text, drag it off the canvas", THEME: THEME)
                                .tag(15)
                            SlideView("hand.draw.fill", description: "Make sure you are not in drawing mode to drag or scroll text!", THEME: THEME)
                                .tag(16)
                            SlideView("heart.fill", description: "Thankyou!", THEME: THEME)
                                .tag(17)
                        }
                    }
                    .shadow(radius: 4)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 350)
                    
                    
                    
                    HStack {
                        if currentSlide <= 0 {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    currentSlide = 1
                                }
                            }) {
                                Number("Start", numberColor: THEME.CircleFunctionButton_characterColor, fontWeight: .bold, fontSize: 30)
                            }
                            .buttonStyle(FunctionButtonStyle(widthNum: 150, heightNum: 50, THEME: THEME))
                            .transition(.scale)
                        }
                        else {
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    currentSlide -= 1
                                }
                            }) {
                                Number("Back", numberColor: THEME.CircleFunctionButton_characterColor, fontWeight: .semibold, fontSize: 25)
                            }
                            .buttonStyle(FunctionButtonStyle(widthNum: 110, heightNum: 45, cornerRadius: 45, THEME: THEME))
                            .transition(.scale)
                            
                            Spacer()

                            if currentSlide < totalSlides - 1 {
                                Button(action: {
                                    withAnimation {
                                        currentSlide += 1
                                    }
                                }) {
                                    Number("Next", numberColor: THEME.CircleFunctionButton_characterColor, fontWeight: .semibold, fontSize: 25)
                                }
                                .buttonStyle(FunctionButtonStyle(widthNum: 110, heightNum: 45, cornerRadius: 45, THEME: THEME))
                                .transition(.scale)
                            } else {
                                Button(action: {
                                    showPopup = false
                                    currentSlide = 0
                                }) {
                                    Number("Got it!", numberColor: THEME.CircleFunctionButton_characterColor, fontWeight: .bold, fontSize: 25)
                                        .padding()
                                        .background(Color.green.opacity(0.6).frame(width: 110, height: 45).cornerRadius(45).shadow(radius: 7))
                                        
                                }
                                .buttonStyle(ScaledButtonStyle(scaleRadius: 0))
                                .transition(.scale)
                            }
                        }
                        
                    }
                    .padding()
                    
                }
                .background(LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).opacity(0.98).cornerRadius(30).shadow(radius: 5))
                .padding()
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.1), value: showPopup)
    }
}


struct SlideView: View {
    let imageName: String
    var imageName2: String = ""
    var imageName3: String = ""
    var imageName4: String = ""
    let description: String
    let THEME: ThemeStyle
    
    
    init(_ imageName: String,
         _ imageName2: String = "",
         _ imageName3: String = "",
         _ imageName4: String = "",
         description: String,
         THEME: ThemeStyle) {
        self.imageName = imageName
        self.imageName2 = imageName2
        self.imageName3 = imageName3
        self.imageName4 = imageName4
        self.description = description
        self.THEME = THEME
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Image(systemName: imageName).resizable().scaledToFit().padding()
                    if !imageName2.isEmpty {Image(systemName: imageName2).resizable().scaledToFit().padding()}
                }
                VStack {
                    if !imageName3.isEmpty {Image(systemName: imageName3).resizable().scaledToFit().padding()}
                    if !imageName4.isEmpty {Image(systemName: imageName4).resizable().scaledToFit().padding()}
                }
            }
            .foregroundColor(THEME.CircleFunctionButton_characterColor)
            
            Text(description)
                .foregroundColor(THEME.CircleFunctionButton_characterColor.opacity(0.9))
                .font(.system(.title2, design: .rounded))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding()
                
        }
    }
}


// Tạo hiệu ứng Blur bằng UIKit (dành cho SwiftUI)
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}











// Gọi view như thế này trong ứng dụng chính:
//struct PopUp: View {
//    @State private var showHelpPopup = false
//
//    var body: some View {
//        ZStack {
//            // Nội dung chính của ứng dụng
//            Button(action: {showHelpPopup.toggle()}) {
//                Text("show pop up")
//            }
//
//
//            AddCanvasPopupView(showPopup: $showHelpPopup, THEME: StyleChoices().darkTheme)
//
//        }
//    }
//}


struct PopUp_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}

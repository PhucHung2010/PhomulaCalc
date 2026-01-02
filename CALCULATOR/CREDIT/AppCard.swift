//
//  AppCard.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 21/10/2024.
//

import SwiftUI

struct AppCard: View {
    let THEME: ThemeStyle
    @State private var isMoving = false

    var body: some View {
        ZStack {
            LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Spacer().frame(height: 80)

                    Button(action: {}) {
                        ZStack {
                            Image("divide")
                                .scaleEffect(0.9)
                                .background(
                                    RoundedRectangle(cornerRadius: 70, style: .continuous)
                                        .fill(LinearGradient(Color.darkBlueStart, Color.darkBlueEnd))
                                        .frame(width: 172, height: 172)
                                )
                                .shadow(radius: 8)
                                .frame(width: 170, height: 170)

                            RoundedRectangle(cornerRadius: 82, style: .continuous)
                                .strokeBorder(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round, dash: [80, 910], dashPhase: isMoving ? 500: -500))
                                .frame(width: 190, height: 190)
                                .foregroundStyle (
                                    LinearGradient(gradient: Gradient(colors: [.red, .yellow, .orange, .green]), startPoint: .trailing, endPoint: .leading)
                                )
                        }
                    }
                    .buttonStyle(ScaledButtonStyle2(scaleRadius: 0.5))


                    VStack {
                        Text("Version Information")
                            .font(.system(size: 32, weight: .bold, design: .rounded))

                        Text("Current Version: 1.0.0\nLast Update: December 2024\nCheck for updates to make sure you’re always using the latest version of the app.")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)



                    Divider()
                        .background(THEME.ExtraOperatorInfor_titleCharacterColor)
                        .padding(.horizontal)


                    VStack {
                        Text("Compatibility")
                            .font(.system(size: 32, weight: .bold, design: .rounded))

                        Text("Compatible with IOS devices.\nRequires iOS 15.0 or later.")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .multilineTextAlignment(.center)
                    }
                    .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)


                    Divider()
                        .background(THEME.ExtraOperatorInfor_titleCharacterColor)
                        .padding(.horizontal)




                    VStack {
                        Text("Ratings & Feedback")
                            .font(.system(size: 32, weight: .bold, design: .rounded))

                        Divider()
                            .background(THEME.ExtraOperatorInfor_titleCharacterColor)
                            .frame(width: 150)

                        Text("Rate the App")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                        Text("Please take a moment to rate our app on the App Store. Your rating  ensures we continue to meet user expectations.")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .padding(.horizontal)

                        Divider()
                            .background(THEME.ExtraOperatorInfor_titleCharacterColor)
                            .frame(width: 150)


                        Text("Provide Feedback")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                        Text("If you have any suggestions, issues, or general thoughts, we’d love to hear from you. You can share your feedback directly through the app or via email at phomulacalchelp@gmail.com. We are committed to reviewing all comments and continuously improving the app based on user input.")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .padding(.horizontal)

                    }
                    .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                }   
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
                isMoving.toggle()
            }
        }
        
    }
}


struct AppCard_Previews: PreviewProvider {
    static var previews: some View {
        CreditView(THEME: StyleChoices().defaultTheme)
    }
}

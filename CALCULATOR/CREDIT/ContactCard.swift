//
//  ContactCard.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 21/10/2024.
//

import SwiftUI

struct ContactCard: View {
    let THEME: ThemeStyle
    @State private var isMoving = false
    var body: some View {
        ZStack {
            LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack (spacing: 20){
                    
                    Spacer().frame(height: 40)
                    
                    Button(action: {}) {
                        ZStack {
                            Image(systemName: "person.text.rectangle.fill")
                                .font(.system(size: 150, weight: .bold))
                                .foregroundColor(THEME.CircleFunctionButton_characterColor)
                                .background(
                                    BlurView(style: .regular)
                                        .mask (
                                            RoundedRectangle(cornerRadius: 27)
                                                .frame(width: 185, height: 150)
                                        )
                                )
                                .shadow(radius: 8)
                            
                            RoundedRectangle(cornerRadius: 38.5)
                                .strokeBorder(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round, dash: [60, 575], dashPhase: isMoving ? 315: -315))
                                .frame(width: 205, height: 170)
                                .foregroundStyle (
                                    LinearGradient(gradient: Gradient(colors: [.red, .yellow, .orange, .green]), startPoint: .trailing, endPoint: .leading)
                                )
                        }
                        
                    }
                    .buttonStyle(ScaledButtonStyle2(scaleRadius: 0.5))
                    
                    
                    VStack {
                        Button(action: {}) {
                            Text("I am Nguyen Huu Phuc Hung, the developer of this application. Currently, I am a student at Le Quy Don High School for the Gifted, Danang, Vietnam. My focus is on software development and technology, and this application was created as part of my academic project to provide users with a smart tool.")
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                                .padding()
                                .foregroundColor(THEME.Board_resultStringColor)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .foregroundColor(THEME.Board_Color)
                                        .shadow(color: THEME.Board_upShadow.opacity(THEME.Board_upShadow_opacity), radius: THEME.Board_upShadow_radius, x: THEME.Board_upShadow_x_y, y: THEME.Board_upShadow_x_y)
                                        .shadow(color: THEME.Board_downShadow.opacity(THEME.Board_downShadow_opacity), radius: THEME.Board_downShadow_radius, x: THEME.Board_downShadow_x_y, y: THEME.Board_downShadow_x_y)
                                )
                                .padding()
                        }
                        .buttonStyle(ScaledButtonStyle2(scaleRadius: 0.8))
                        
                        
                        
                        
                        Divider()
                            .background(THEME.ExtraOperatorInfor_titleCharacterColor)
                            .padding(.horizontal)
                        
                        
                        
                        VStack (spacing: 30){
                            Text("Connect with me\non social media")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                                
                            
                            
                            VStack (spacing: -30){
                                Button(action: {
                                }) {
                                    HStack {
                                        Image("gmail")
                                            .resizable().scaledToFit().padding().shadow(radius: 2)
                                        
                                        Text("nhphung2468@gmail.com")
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                                            .font(.system(size: 23, weight: .bold, design: .rounded))
                                            .frame(width: 160, height: 60)
                                    }
                                    .frame(height: 110)
                                    .padding()
                                    .background(
                                        BlurView(style: .regular)
                                            .clipShape(RoundedRectangle(cornerRadius: 50))
                                            .frame(minWidth: 355)
                                            .frame(height: 110)
                                            .padding()
                                    )
                                    .padding()
                                }
                                .buttonStyle(ScaledButtonStyle3(scaleRadius: 0.8))
                                
                                
                                
                                
                                Button(action: {
                                    if let url = URL(string: "https://www.facebook.com/profile.php?id=100075438516465") {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    HStack {
                                        Image("facebook")
                                            .resizable()
                                            .scaledToFit()
                                            .mask(RoundedRectangle(cornerRadius: 20))
                                            .shadow(radius: 2)
                                            .padding()
                                        
                                        Text("Facebook")
                                            .font(.system(size: 27, weight: .bold, design: .rounded))
                                            .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                                            .frame(width: 160, height: 20)
                                    }
                                    .frame(height: 110)
                                    .padding()
                                    .background(
                                        BlurView(style: .regular)
                                            .clipShape(RoundedRectangle(cornerRadius: 50))
                                            .frame(minWidth: 355)
                                            .frame(height: 110)
                                            .padding()
                                    )
                                    .padding()
                                }
                                .buttonStyle(ScaledButtonStyle3(scaleRadius: 0.8))
                                
                                
                                Button(action: {
                                    if let url = URL(string: "https://www.instagram.com/nguyenhuuphuchung_2009/") {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    HStack {
                                        Image("instagram")
                                            .resizable().scaledToFit()
                                            .mask(RoundedRectangle(cornerRadius: 20))
                                            .shadow(radius: 2).padding()
                                        
                                        Text("Instagram")
                                            .font(.system(size: 27, weight: .bold, design: .rounded))
                                            .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                                            .frame(width: 160, height: 20)
                                    }
                                    .frame(height: 110)
                                    .padding()
                                    .background(
                                        BlurView(style: .regular)
                                            .clipShape(RoundedRectangle(cornerRadius: 50))
                                            .frame(minWidth: 355)
                                            .frame(height: 110)
                                            .padding()
                                    )
                                    .padding()
                                }
                                .buttonStyle(ScaledButtonStyle3(scaleRadius: 0.8))
                                
                                
//                                Button(action: {
//                                    if let url = URL(string: "https://www.linkedin.com/in/hưng-nguyễn-179058301/") {
//                                        UIApplication.shared.open(url)
//                                    }
//                                }) {
//                                    HStack {
//                                        Image("linkedin")
//                                            .resizable().scaledToFit()
//                                            .mask(RoundedRectangle(cornerRadius: 20))
//                                            .shadow(radius: 2).padding()
//
//                                        Text("LinkedIn")
//                                            .font(.system(size: 27, weight: .bold, design: .rounded))
//                                            .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
//                                            .frame(width: 160, height: 20)
//                                    }
//                                    .frame(height: 110)
//                                    .padding()
//                                    .background(
//                                        BlurView(style: .regular)
//                                            .clipShape(RoundedRectangle(cornerRadius: 50))
//                                            .frame(minWidth: 355)
//                                            .frame(height: 110)
//                                            .padding()
//                                    )
//                                    .padding()
//                                }
//                                .buttonStyle(ScaledButtonStyle3(scaleRadius: 0.8))
                            }
                            .shadow(radius: 5)
                        }
                    }
                }
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 7).repeatForever(autoreverses: false)) {
                isMoving.toggle()
            }
        }
        
    }
}

struct ContactCard_Previews: PreviewProvider {
    static var previews: some View {
        CreditView(THEME: StyleChoices().lightTheme)
    }
}

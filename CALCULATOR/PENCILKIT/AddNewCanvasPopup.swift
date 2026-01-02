//
//  AddNewCanvasView.swift
//  Drawing Pencil Kit
//
//  Created by Haaris Iqubal on 5/7/21.
//

import SwiftUI


struct AddNewCanvasPopup: View {
    @Binding var showPopup: Bool
    var THEME: ThemeStyle
    @State private var title: String = ""
    @Environment (\.managedObjectContext) var viewContext
    
    
    var body: some View {
        ZStack {
            if showPopup {
                BlurView(style: .systemUltraThinMaterialDark)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showPopup = false
                            title = ""
                        }
                    }
                    .transition(.opacity)
            }

            // Pop-up Content with blur background
            if showPopup {
                VStack {
                    Text("Add new canvas")
                        .foregroundColor(THEME.CircleFunctionButton_characterColor)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .padding()
                    
                    
                    
                    HStack {
                        Image(systemName: "textformat").foregroundColor(THEME.TextField_AaSymbolColor).font(.system(size: 20, weight: .semibold))
                        TextField("", text: $title)
                    }
                    .modifier(customViewModifier(startColor: THEME.TextField_backgroundStart, endColor: THEME.TextField_backgroundEnd, textColor: THEME.TextField_textColor, roundedCornes: 30))
                    .padding()
                    
                    
                    
                    
                    Button(action: {
                        if !title.isEmpty{
                            let drawing = Drawing(context: viewContext)
                            drawing.id = UUID()
                            drawing.title = title
                            drawing.dateCreated = Date()
                            
                            do {
                                try viewContext.save()
                            }
                            catch{
                            }
                        }
                        showPopup = false
                        title = ""
                    }) {
                        Number("Save", numberColor: THEME.CircleFunctionButton_characterColor, fontWeight: .semibold, fontSize: 30)
                            .background(
                                RoundedRectangle(cornerRadius: 45)
                                    .stroke(lineWidth: 5)
                                    .foregroundColor(THEME.backgroundStart)
                                    .background(
                                        BlurView(style: . regular)
                                            .clipShape(RoundedRectangle(cornerRadius: 45))
                                    )
                                    .frame(width: 150, height: 55)
                            )
                    }
                    .offset(y: 20)
                    .buttonStyle(ScaledButtonStyle3(scaleRadius: 1.3))
                }
                .shadow(radius: 10)
                .background(LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).opacity(0.98).cornerRadius(30))
                .padding()
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.1), value: showPopup)
    }
}




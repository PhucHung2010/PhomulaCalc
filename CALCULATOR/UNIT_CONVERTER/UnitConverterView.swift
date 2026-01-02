//
//  UnitConverter.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 12/10/2024.
//

import SwiftUI


struct navigationLinkLabel: View {
    let category: Category
    let THEME: ThemeStyle
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "\(CategoryManager.getIcon(category: category))")
                    .resizable().scaledToFit().padding()
                    .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
            }
                
            Text("\(category.rawValue)")
                .font(.system(.title, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                .frame(minWidth: 180)
        }
        .frame(height: 110)
        .padding()
        .background(
            BlurView(style: .regular)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .frame(minWidth: 355)
                .frame(height: 130)
                .padding()
        )
        .padding()
    }
}



struct UnitConverter: View {
    @State private var showSelectUnitPopup = false
    @State private var selectedUnit: Category?
    
    var iphone: Iphone
    var THEME: ThemeStyle
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [THEME.backgroundStart, THEME.backgroundEnd], startPoint: .topTrailing, endPoint: .bottomLeading).ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 1)) {
                    ForEach(Category.allCases, id: \.self) { category in
                        
                        Button(action: {
                            selectedUnit = category
                            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.1)) {
                                showSelectUnitPopup = true
                            }
                        }) {
                            navigationLinkLabel(category: category, THEME: THEME)
                                .shadow(radius: 8)
                        }
                        .buttonStyle(ScaledButtonStyle3(scaleRadius: 0.5))
                    }
                }
                Spacer().frame(height: 50)
            }
            .overlay{
                if let selectedUnit = selectedUnit {
                    SelectUnitPopup(showPopup: $showSelectUnitPopup, viewModel: DetailViewModel(category: selectedUnit), THEME: THEME, scaleEffect: iphone.extraOperatorScale, category: selectedUnit)
                }
            }
        }
    }
}



struct UnitConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}

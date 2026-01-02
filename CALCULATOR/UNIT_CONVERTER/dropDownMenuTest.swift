//
//  dropDownMenuTest.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 08/11/2024.
//

import SwiftUI

struct dropDownMenuTest: View {
    @State private var birthMonth: DropdownMenuOption? = nil
    
    var body: some View {
        VStack {
            DropdownMenu(
                selectedOption: self.$birthMonth,
                placeholder: "Select your birth month",
                options: DropdownMenuOption.testAllMonths
            )
            
            Text(birthMonth?.option ?? "")
        }
    }
}

struct dropDownMenuTest_Previews: PreviewProvider {
    static var previews: some View {
        dropDownMenuTest()
    }
}

struct DropdownMenu: View {
    /// Used to show or hide drop-down menu options
    @State private var isOptionsPresented: Bool = false
    
    /// Used to bind user selection
    @Binding var selectedOption: DropdownMenuOption?
    
    /// A placeholder for drop-down menu
    let placeholder: String
    
    /// The drop-down menu options
    let options: [DropdownMenuOption]
    
//    let THEME = StyleChoices().lightTheme
    
    var body: some View {
        Button(action: {
            withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.6, blendDuration: 0.1)) {
                self.isOptionsPresented.toggle()
            }
        }) {
            HStack {
                Text(selectedOption == nil ? placeholder : selectedOption!.option)
                    .fontWeight(.medium)
                    .foregroundColor(selectedOption == nil ? .white : .black)
                
                Image(systemName: self.isOptionsPresented ? "chevron.up" : "chevron.down")
                    // This modifier available for Image since iOS 16.0
            }
        }
        .buttonStyle(TinyFuncButtonStyle(widthNum: 200, heightNum: 90, cornerRadius: 45, symbolScaleEffect: 0.5, backgroundScaleEffect: 0.4))
        .padding()
        .overlay(alignment: .top) {
            VStack {
                if self.isOptionsPresented {
                    Spacer(minLength: 60)
                    DropdownMenuList(options: self.options) { option in
                        self.isOptionsPresented = false
                        self.selectedOption = option
                    }
                    .transition(.scale)
                }
            }
        }
        // We need to push views under drop down menu down, when options list is
        // open
        .padding(
            // Check if options list is open or not
            .bottom, self.isOptionsPresented
            // If options list is open, then check if options size is greater
            // than 300 (MAX HEIGHT - CONSTANT), or not
            ? CGFloat(self.options.count * 32) > 300
                // IF true, then set padding to max height 300 points
                ? 300 + 30 // max height + more padding to set space between borders and text
                // IF false, then calculate options size and set padding
                : CGFloat(self.options.count * 32) + 30
            // If option list is closed, then don't set any padding.
            : 0
        )
    }
}




struct DropdownMenuList: View {
    /// The drop-down menu list options
    let options: [DropdownMenuOption]
    
    /// An action called when user select an action.
    let onSelectedAction: (_ option: DropdownMenuOption) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 2) {
                ForEach(options) { option in
                    DropdownMenuListRow(option: option, onSelectedAction: self.onSelectedAction)
                }
            }
        }
        // Check first if number of options * 32 (Option height - CONSTANT - YOU
        // MAY CHANGE IT) is greater than 300 (MAX HEIGHT - ALSO, YOU MAY CHANGE
        // IT), if true, then make it options list scroll, if not set frame only
        // for available options.
        .frame(height: CGFloat(self.options.count * 32) > 300
               ? 300
               : CGFloat(self.options.count * 32)
        )
        .padding(.vertical, 5)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 2)
        }
    }
}



struct DropdownMenuListRow: View {
    let option: DropdownMenuOption
    
    /// An action called when user select an action.
    let onSelectedAction: (_ option: DropdownMenuOption) -> Void
    
    var body: some View {
        Button(action: {
            withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.6, blendDuration: 0.1)) {
                self.onSelectedAction(option)
            }
        }) {
            Text(option.option)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.black)
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}


struct DropdownMenuOption: Identifiable, Hashable {
    let id = UUID().uuidString
    let option: String
}

extension DropdownMenuOption {
    static let testSingleMonth: DropdownMenuOption = DropdownMenuOption(option: "March")
    static let testAllMonths: [DropdownMenuOption] = [
        DropdownMenuOption(option: "January"),
        DropdownMenuOption(option: "February"),
        DropdownMenuOption(option: "March"),
        DropdownMenuOption(option: "April"),
        DropdownMenuOption(option: "May"),
        DropdownMenuOption(option: "June"),
        DropdownMenuOption(option: "July"),
        DropdownMenuOption(option: "August"),
        DropdownMenuOption(option: "September"),
        DropdownMenuOption(option: "October"),
        DropdownMenuOption(option: "November"),
        DropdownMenuOption(option: "December")
    ]
}

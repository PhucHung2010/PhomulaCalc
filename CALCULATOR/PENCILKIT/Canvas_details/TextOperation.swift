//
//  TextOperation.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 04/10/2024.
//

import SwiftUI

struct DraggableTextItemsView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var currentDrawing: Drawing
    @Binding var textItems: [TextItem]
    @Binding var newText: TextItem
    @Binding var showTextField: Bool
    @Binding var textPositionBeforeSet: CGPoint?
    
    var drawEnable: Bool
    let isTextFullyVisible: (TextItem) -> Bool
    let isTextVisible: (TextItem) -> Bool
    let geometrySizeWidth: CGFloat
    
    
    @State private var lastTapTime = Date()
    @State private var tapCount = 0
    @State private var isPressingOnText = false
    @State private var selectedText: UUID?
    

    var body: some View {
        ZStack {
            ForEach($textItems) { $textItem in
                
                if isTextVisible(textItem) {
                    
                    if textItem.isScrolling && !drawEnable {
                        ScrollView(.vertical) {
                            
                            Text(textItem.text)
                                .foregroundColor(textItem.color)
                                .font(.system(size: textItem.fontSize, weight: textItem.fontWeight, design: textItem.fontDesign))
                                .opacity(isPressingOnText && selectedText == textItem.id ? 0.4 : 1)
                                .opacity(textItem.isDragging ? 0.5 : 1)
                                .padding(.horizontal, 15)
                                .frame(maxWidth: geometrySizeWidth - 30)
                                .position(x: textItem.position.x + textItem.offset.width,
                                          y: textItem.position.y + textItem.offset.height)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            if textItem.isDragging && !drawEnable {
                                                textItem.offset = value.translation
                                            }
                                        }
                                        .onEnded { _ in
                                            if textItem.isDragging && !drawEnable {
                                                textItem.position.x += textItem.offset.width
                                                textItem.position.y += textItem.offset.height
                                                textItem.offset = .zero

                                                // Xóa nếu hoàn toàn nằm ngoài canvas ngay lập tức
                                                if !isTextFullyVisible(textItem) {
                                                    if let index = textItems.firstIndex(where: { $0.id == textItem.id }) {
                                                        textItems.remove(at: index)
                                                    }
                                                }
                                            }
                                        }
                                )
                                .onTapGesture {
                                    if !drawEnable {
                                        
                                        let currentTime = Date()
                                        let timeDifference = currentTime.timeIntervalSince(lastTapTime)
                                        
                                        if timeDifference < 0.6 {
                                            tapCount += 1
                                        } else {
                                            tapCount = 1
                                        }
                                        
                                        lastTapTime = currentTime
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                            if tapCount == 2 {
                                                textItem.isDragging.toggle()
                                                if !textItem.isDragging {
                                                    if let jsonString = encodeTextItems(items: textItems) {
                                                        currentDrawing.textItemsEncodeString = jsonString
                                                        do{
                                                            try viewContext.save()
                                                        }
                                                        catch{
                                                            
                                                        }
                                                    }
                                                }
                                                
                                                textItem.isScrolling = false
                                            } else if tapCount == 3 {
                                                textItem.isScrolling.toggle()
                                                textItem.isDragging = false
                                            }
                                            
                                            tapCount = 0
                                        }
                                    }
                                }
                                .onLongPressGesture(minimumDuration: 1.3, pressing: { isPressing in
                                    if !drawEnable {
                                        selectedText = textItem.id
                                        isPressingOnText = isPressing
                                    }
                                } ,perform: {
                                    if !drawEnable {
                                        textItem.isScrolling = false
                                        textItem.isDragging = false
                                        textPositionBeforeSet = textItem.position
                                        
                                        newText = textItem
                                        
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.1)) {
                                            newText.position = CGPoint(x: UIScreen.main.bounds.width / 2.2, y: UIScreen.main.bounds.height / 4.5)
                                        }
                                        
                                        if let index = textItems.firstIndex(where: { $0.id == textItem.id }) {
                                            textItems.remove(at: index)
                                        }
                                        showTextField = true
                                    }
                                })
                                .animation(.easeInOut(duration: 0.1), value: textItem.isDragging)
                                .animation(.easeInOut(duration: 0.4), value: textItem.offset)
                                .animation(.easeInOut(duration: 0.18), value: isPressingOnText)
                            
                        }
                    }
                    else {
                        Text(textItem.text)
                            .foregroundColor(textItem.color)
                            .font(.system(size: textItem.fontSize, weight: textItem.fontWeight, design: textItem.fontDesign))
                            .opacity(isPressingOnText && selectedText == textItem.id ? 0.4 : 1)
                            .opacity(textItem.isDragging ? 0.5 : 1)
                            .padding(.horizontal, 15)
                            .frame(maxWidth: geometrySizeWidth - 30)
                            .position(x: textItem.position.x + textItem.offset.width,
                                      y: textItem.position.y + textItem.offset.height)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        if textItem.isDragging && !drawEnable {
                                            textItem.offset = value.translation
                                        }
                                    }
                                    .onEnded { _ in
                                        if textItem.isDragging && !drawEnable {
                                            textItem.position.x += textItem.offset.width
                                            textItem.position.y += textItem.offset.height
                                            textItem.offset = .zero

                                            // Xóa nếu hoàn toàn nằm ngoài canvas ngay lập tức
                                            if !isTextFullyVisible(textItem) {
                                                if let index = textItems.firstIndex(where: { $0.id == textItem.id }) {
                                                    textItems.remove(at: index)
                                                }
                                            }
                                        }
                                    }
                            )
                            .onTapGesture {
                                if !drawEnable {
                                    let currentTime = Date()
                                    let timeDifference = currentTime.timeIntervalSince(lastTapTime)
                                    
                                    if timeDifference < 0.6 {
                                        tapCount += 1
                                    } else {
                                        tapCount = 1
                                    }
                                    
                                    
                                    lastTapTime = currentTime
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                        if tapCount == 2 {
                                            textItem.isDragging.toggle()
                                            if !textItem.isDragging {
                                                if let jsonString = encodeTextItems(items: textItems) {
                                                    currentDrawing.textItemsEncodeString = jsonString
                                                    do{
                                                        try viewContext.save()
                                                    }
                                                    catch{
                                                        
                                                    }
                                                }
                                            }
                                            
                                            textItem.isScrolling = false
                                        } else if tapCount == 3 {
                                            textItem.isScrolling.toggle()
                                            textItem.isDragging = false
                                        }
                                        
                                        tapCount = 0
                                    }
                                }
                            }
                            .onLongPressGesture(minimumDuration: 1.3, pressing: { isPressing in
                                if !drawEnable {
                                    selectedText = textItem.id
                                    isPressingOnText = isPressing
                                }
                            } ,perform: {
                                if !drawEnable {
                                    textItem.isScrolling = false
                                    textItem.isDragging = false
                                    textPositionBeforeSet = textItem.position
                                    
                                    newText = textItem
                                    
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.1)) {
                                        newText.position = CGPoint(x: UIScreen.main.bounds.width / 2.2, y: UIScreen.main.bounds.height / 4.5)
                                    }
                                    
                                    if let index = textItems.firstIndex(where: { $0.id == textItem.id }) {
                                        textItems.remove(at: index)
                                    }
                                    showTextField = true
                                }
                            })
                            
                            .animation(.easeInOut(duration: 0.07), value: textItem.isDragging)
                            .animation(.easeInOut(duration: 0.4), value: textItem.offset)
                            .animation(.easeInOut(duration: 0.1), value: isPressingOnText)

                    }
                }
            }
        }
    }
}


struct TextPreview: View {
    @Binding var newText: TextItem
    
    var drawEnable: Bool
    let isTextFullyVisible: (TextItem) -> Bool
    let geometrySizeWidth: CGFloat
    
    @State private var lastTapTime = Date()
    @State private var tapCount = 0
    
    var body: some View {
        Text(newText.text)
            .foregroundColor(newText.color)
            .font(.system(size: newText.fontSize, weight: newText.fontWeight, design: newText.fontDesign))
            .opacity(newText.isDragging ? 0.5 : 1)
            .padding(.horizontal, 15)
            .frame(maxWidth: geometrySizeWidth - 30)
            .position(x: newText.position.x + newText.offset.width,
                      y: newText.position.y + newText.offset.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if newText.isDragging && !drawEnable {
                            newText.offset = value.translation
                        }
                    }
                    .onEnded { _ in
                        if newText.isDragging && !drawEnable {
                            newText.position.x += newText.offset.width
                            newText.position.y += newText.offset.height
                            newText.offset = .zero

                            if !isTextFullyVisible(newText) {
                                newText.text = ""
                            }
                        }
                    }
            )
            .onTapGesture {
                if !drawEnable {
                    let currentTime = Date()
                    let timeDifference = currentTime.timeIntervalSince(lastTapTime)
                    
                    if timeDifference < 0.6 {
                        tapCount += 1
                    } else {
                        tapCount = 1
                    }
                    
                    lastTapTime = currentTime
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        if tapCount == 2 {
                            newText.isDragging.toggle()
                            newText.isScrolling = false
                        } else if tapCount == 3 {
                            newText.isScrolling.toggle()
                            newText.isDragging = false
                        }
                        tapCount = 0
                    }
                }
            }
            .animation(.easeInOut(duration: 0.1), value: newText.isDragging)
            .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.1), value: newText.fontWeight)
            .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.1), value: newText.fontDesign)
            .animation(.easeInOut(duration: 0.4), value: newText.offset)
    }
}





struct TextOperation_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}

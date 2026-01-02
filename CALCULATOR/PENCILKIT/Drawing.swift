//
//  DrawingView.swift
//  Drawing Pencil Kit
//
//  Created by Haaris Iqubal on 5/7/21.
//

import SwiftUI
import ScreenshotSwiftUI
import UIKit

struct DrawingCanvas: View {

    @Environment(\.managedObjectContext) var viewContext

    @State var id:UUID?
    @State var data:Data?
    @State var title:String?
    @ObservedObject var currentDrawing: Drawing





    @State private var eraseCanvas = false
    @State private var showTool = false
    @State private var showToolCheck = false
    @State private var showTextField = false
    @State private var editingText = false




    @State private var textItems: [TextItem] = []
    @State private var newText = TextItem(text: "",
                                          color: .black,
                                          fontSize: 20,
                                          fontWeight: .medium,
                                          fontDesign: .default,
                                          position: CGPoint(x: UIScreen.main.bounds.width / 2.2, y: UIScreen.main.bounds.height / 4.5))
    @State private var textPositionBeforeSet: CGPoint?

    @State private var selectedFontWeight: FontWeight = .Default
    @State private var selectedFontDesign: FontDesign = .Default
    @State private var colorPickerDraggOffset: CGFloat = 0

    @State private var showPopUp = false

    let THEME: ThemeStyle
    var scaleEffect: CGFloat



    @FetchRequest(entity: Drawing.entity(), sortDescriptors: []) var drawings: FetchedResults<Drawing>
    @Binding var selectedDrawing: Drawing?
    @Binding var animateView: Bool
    @Namespace var animation


    @State private var UIIMAGE: UIImage?
    @State private var capture = false
    @State private var screenshotMakerInstance: ScreenshotMaker?
    @State private var showScreenshotPreviewBoder = false
    @State private var showScreenshotPreviewImage = false
    @State private var lastTimeCapture = Date() - 1.4

    let viewController = YourViewController()

    var body: some View {
        ZStack {
            LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).ignoresSafeArea()

            GeometryReader { geometry in
                VStack (spacing: 10){


                    CanvasView(data: data ?? Data(), id: id ?? UUID(), showTool: showTool, eraseCanvas: $eraseCanvas)
                        .environment(\.managedObjectContext, viewContext)
                        .onAppear {
                            let decodedItems = decodeTextItems(jsonString: currentDrawing.textItemsEncodeString ?? "")
                            textItems = decodedItems ?? []
                        }
                        .overlay {
                            DraggableTextItemsView(
                                currentDrawing: currentDrawing,
                                textItems: $textItems,
                                newText: $newText,
                                showTextField: $showTextField,
                                textPositionBeforeSet: $textPositionBeforeSet,
                                drawEnable: showTool,
                                isTextFullyVisible: { textItem in
                                    isTextFullyVisible(textItem, canvasSize: geometry.size)
                                },
                                isTextVisible: { textItem in
                                    isTextVisible(textItem, canvasSize: geometry.size)
                                },
                                geometrySizeWidth: geometry.size.width
                            )

                            if newText.text != "" {
                                if newText.isScrolling && !showTool{
                                    ScrollView(.vertical) {
                                        TextPreview(
                                            newText: $newText,
                                            drawEnable: showTool,
                                            isTextFullyVisible: { textItem in
                                                isTextFullyVisible(textItem, canvasSize: geometry.size)
                                            },
                                            geometrySizeWidth: geometry.size.width
                                        )
                                        .background(
                                            BlurView(style: .regular)
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                        )
                                        .transition(.opacity)
                                    }
                                }
                                else {
                                    TextPreview(
                                        newText: $newText,
                                        drawEnable: showTool,
                                        isTextFullyVisible: { textItem in
                                            isTextFullyVisible(textItem, canvasSize: geometry.size)
                                        },
                                        geometrySizeWidth: geometry.size.width
                                    )
                                    .background(
                                        BlurView(style: .regular)
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                    )
                                    .transition(.opacity)
                                }
                            }



                            if showScreenshotPreviewBoder {
                                Color.black.opacity(0.95)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(lineWidth: 50)
                                    )
                                    .onAppear {
                                        withAnimation(Animation.easeInOut(duration: 1.3)) {
                                            showScreenshotPreviewBoder = false
                                        }
                                    }
                                    .transition(.opacity)
                            }


                            if let screenshot = UIIMAGE, showScreenshotPreviewImage {
                                Image(uiImage: screenshot)
                                    .resizable()
                                    .scaledToFit()
                                    .onAppear {
                                        withAnimation(Animation.easeInOut(duration: 1.3)) {
                                            showScreenshotPreviewImage = false
                                        }
                                    }
                                    .shadow(radius: 10)
                                    .transition(.scale(scale: 0.15).combined(with: .offset(x: 270)))
                            }
                        }
                        .screenshotMaker { screenshotMaker in
                            screenshotMakerInstance = screenshotMaker
                        }
                        .onChange(of: capture) { newValue in
                            if newValue, let screenshotMakerInstance = screenshotMakerInstance {
                                UIIMAGE = screenshotMakerInstance.screenshot()
                                if let image = UIIMAGE {
                                    viewController.someFunctionWhereYouWantToSaveImage(IMAGE: image)
                                }
                                capture = false
                                
                                withAnimation(.easeInOut(duration: 1.3)) {
                                    showScreenshotPreviewBoder = true
                                }
                                showScreenshotPreviewImage = true
                            }
                        }
                        .animation(.easeInOut(duration: 0.3), value: newText.text != "")
                        .cornerRadius(15)
                        .shadow(radius: 7.5)
                        .padding()








                    // Thanh công cụ tùy chỉnh
                    if !showTextField {
                        VStack {
                            HStack(spacing: 75) {

                                Button(action: {
                                    showTool.toggle()
                                    if showTool {
                                        resetTextItemScrollingDragging(&textItems)
                                    }
                                }) {
                                    Symbol(showTool ? "pencil.slash" : "pencil", symbolColor: THEME.NumberButton_characterColor, symbolSize: 35, boldFontWeight: true)
                                }
                                .buttonStyle(NumberButtonStyle(widthNum: 180, heightNum: 70, cornerRadius: 40, THEME: THEME))
                                .padding(.horizontal)




                                Button(action: {
                                    showTextField.toggle()

                                    if showTool {
                                        showToolCheck = true
                                        withAnimation(.easeInOut(duration: 0.4)) {
                                            showTool = false
                                        }
                                    }

                                    resetTextItemScrollingDragging(&textItems)
                                }) {
                                    Symbol("character.textbox", symbolColor: THEME.NumberButton_characterColor, symbolSize: 35, boldFontWeight: true)
                                }
                                .buttonStyle(NumberButtonStyle(widthNum: 180, heightNum: 70, cornerRadius: 40, THEME: THEME))
                                .padding(.horizontal)




                                Button(action: {
                                    if !showTool {
                                        withAnimation(.easeInOut(duration: 0.15)) {
                                            animateView = false
                                        }

                                        selectedDrawing = nil

                                        if let jsonString = encodeTextItems(items: textItems) {
                                            currentDrawing.textItemsEncodeString = jsonString
                                        }
                                    }
                                }) {
                                    Symbol("rectangle.grid.2x2.fill", symbolColor: THEME.NumberButton_characterColor, symbolSize: 30, boldFontWeight: true)
                                }
                                .buttonStyle(NumberButtonStyle(widthNum: 180, heightNum: 70, cornerRadius: 40, THEME: THEME))
                                .padding(.horizontal)

                            }
                            .padding(.top, 10)
                            .padding(.bottom, 40)



                            HStack (spacing: 75){

                                Button(action: {
                                    if !showTool {
                                        for drawing in drawings {
                                            if selectedDrawing == drawing {
                                                viewContext.delete(drawing)

                                                withAnimation(.interactiveSpring(response: 0.45, dampingFraction: 0.6, blendDuration: 0.1)) {
                                                    animateView = false
                                                }
                                                selectedDrawing = nil

                                                do{
                                                    try viewContext.save()
                                                }
                                                catch{

                                                }
                                            }
                                        }
                                    }
                                }) {
                                    Symbol("trash", symbolColor: THEME.NumberButton_characterColor, symbolSize: 30, boldFontWeight: true)
                                }
                                .padding(.horizontal)






                                Button {
                                    if !showTool {
                                        withAnimation(.easeInOut(duration: 0.15)) {
                                            textItems.removeAll()
                                            eraseCanvas = true
                                        }
                                        if let jsonString = encodeTextItems(items: textItems) {
                                            currentDrawing.textItemsEncodeString = jsonString
                                            do{
                                                try viewContext.save()
                                            }
                                            catch{

                                            }
                                        }
                                    }
                                } label: {
                                    Symbol("xmark.circle", symbolColor: THEME.NumberButton_characterColor, symbolSize: 30, boldFontWeight: true)
                                }
                                .padding(.horizontal)






                                Button(action: {
                                    if !showTool{
                                        let currentTime = Date()
                                        let timeDifference = currentTime.timeIntervalSince(lastTimeCapture)
                                        if timeDifference > 1.4 {
                                            capture = true
                                            lastTimeCapture = currentTime
                                        }
                                    }
                                }) {
                                    Symbol("square.and.arrow.down", symbolColor: THEME.NumberButton_characterColor, symbolSize: 30, boldFontWeight: true)
                                }
                                .padding(.horizontal)
                            }
                            .buttonStyle(NumberButtonStyle(widthNum: 180, heightNum: 70, cornerRadius: 40, THEME: THEME))
                        }
                        .transition(.offset(y: 300))
                    }







                    // Hiển thị TextField và các tùy chọn
                    if showTextField {
                        VStack (spacing: 10){
                            HStack {
                                Image(systemName: "textformat").foregroundColor(THEME.TextField_AaSymbolColor).font(.system(size: 20, weight: .semibold))

                                TextField("", text: $newText.text, onEditingChanged: { isEditing in
                                    if isEditing {
                                        editingText = true
                                    }
                                }, onCommit: {
                                    editingText = false
                                })
                            }
                            .modifier(customViewModifier(startColor: THEME.TextField_backgroundStart, endColor: THEME.TextField_backgroundEnd, textColor: THEME.TextField_textColor, roundedCornes: 30))
                            .shadow(radius: 8)
                            .padding()

                            if !editingText {
                                VStack (spacing: 10){
                                    VStack(spacing: 45) {
                                        CustomColorPicker(selectedColor: $newText.color,
                                                          uiColor: $newText.uiColor,
                                                          dragOffset: $colorPickerDraggOffset)
                                        VStack (spacing: 30){
                                            CustomSlider($newText.fontSize, THEME: THEME)

                                            HStack{
                                                FontDesignSwitch(selectedFont: $selectedFontDesign, fontReturn: $newText.fontDesign)
                                                FontWeightSwitch(selectedFont: $selectedFontWeight, fontDesign: selectedFontDesign ,fontReturn: $newText.fontWeight)
                                            }
                                            .scaleEffect(scaleEffect + 0.08)
                                        }
                                    }



                                    Button(action: {
                                        showTextField = false
                                        if showToolCheck {
                                            showToolCheck = false
                                            withAnimation(.easeInOut(duration: 0.5)) {
                                                showTool = true
                                            }
                                        }

                                        if newText.text != "" {
                                            if let textPositionBeforeSet = textPositionBeforeSet {
                                                newText.position = textPositionBeforeSet
                                                self.textPositionBeforeSet = nil
                                            }

                                            let newTextItem = TextItem(text: newText.text,
                                                                       color: newText.color,
                                                                       uiColor: newText.uiColor,
                                                                       fontSize: newText.fontSize,
                                                                       fontWeight: newText.fontWeight,
                                                                       fontDesign: newText.fontDesign,
                                                                       position: newText.position)

                                            textItems.append(newTextItem)
                                            newText.text = ""
                                            newText.position = CGPoint(x: UIScreen.main.bounds.width / 2.2, y: UIScreen.main.bounds.height / 4.5)
                                            newText.isScrolling = false
                                            newText.isDragging = false
                                        }



                                        if let jsonString = encodeTextItems(items: textItems) {
                                            currentDrawing.textItemsEncodeString = jsonString
                                            do{
                                                try viewContext.save()
                                            }
                                            catch{

                                            }
                                        }

                                    }) {
                                        Symbol("checkmark.circle.fill", symbolColor: THEME.NumberButton_characterColor, symbolSize: 50)
                                            .padding()
                                    }
                                    .buttonStyle(ScaledButtonStyle3(scaleRadius: 0.7))
                                }
                                .transition(.offset(y: 500))
                            }

                        }
                        .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.1), value: editingText)
                        .transition(.offset(y: 500))
                    }

                    Spacer().frame(height: 35)
                }
            }
        }
        .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.1), value: showTextField)


    }
}


func isTextVisible(_ textItem: TextItem, canvasSize: CGSize) -> Bool {
    let canvasBounds = CGRect(x: 0, y: 0, width: canvasSize.width, height: canvasSize.height)
    let textBounds = CGRect(x: textItem.position.x, y: textItem.position.y, width: 10, height: 10)
    return canvasBounds.intersects(textBounds)
}

func isTextFullyVisible(_ textItem: TextItem, canvasSize: CGSize) -> Bool {
    let canvasBounds = CGRect(x: 0, y: 0, width: canvasSize.width, height: canvasSize.height)
    let textBounds = CGRect(x: textItem.position.x, y: textItem.position.y, width: 10, height: 10)
    return canvasBounds.contains(textBounds)
}


func resetTextItemScrollingDragging(_ textItems: inout [TextItem]) {
    for index in textItems.indices {
        textItems[index].isDragging = false
        textItems[index].isScrolling = false
    }
}


class YourViewController: UIViewController {
    func saveImageToPhotoLibrary(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {

    }


    func someFunctionWhereYouWantToSaveImage(IMAGE: UIImage) {
        saveImageToPhotoLibrary(image: IMAGE)
    }
}





struct PreviewDrawingCanvas: View {
    @Environment(\.managedObjectContext) var viewContext

    @State var id:UUID?
    @State var data:Data?
    @State var title:String?

    @State var Showtool = false
    @State var eraseCanvas = false
    var body: some View {
        CanvasView(data: data ?? Data(), id: id ?? UUID(), showTool: Showtool, eraseCanvas: $eraseCanvas)
            .environment(\.managedObjectContext, viewContext)
    }
}

struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}




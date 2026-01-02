//
//
//import SwiftUI
//import PencilKit
//
//
//struct CanvasView: UIViewRepresentable {
//    @Binding var canvasView: PKCanvasView
//
//    func makeUIView(context: Context) -> some UIView {
//        canvasView.drawingPolicy = .anyInput
//        return canvasView
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator {
//        var parent: CanvasView
//
//        init(_ parent: CanvasView) {
//            self.parent = parent
//        }
//    }
//}
//
//
//
//
//struct PencilkitFramework: View {
//    let THEME: ThemeStyle
//    @State private var canvasView = PKCanvasView()
//    @State private var toolPicker = PKToolPicker()
//    @State private var showTool = false
//    @State private var showToolCheck = false
//    @State private var showTextField = false
//
//
//    @State private var textItems: [TextItem] = []
//    @State private var newText = TextItem(text: "", color: .black, fontSize: 20, fontWeight: .medium, fontDesign: .default, position: CGPoint(x: 170, y: 170))
//    @State private var selectedFontWeight: FontWeight = .Default
//    @State private var selectedFontDesign: FontDesign = .Default
//    @State private var colorPickerDraggOffset: CGFloat = 0
//
//    @State private var showPopUp = false
//
//    var scaleEffect: CGFloat
//
//
//
//
//    var body: some View {
//        ZStack {
//            LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).ignoresSafeArea()
//
//            GeometryReader { geometry in
//                VStack (spacing: 10){
//
//
//
//                    CanvasView(canvasView: $canvasView)
//                        .onAppear {
//                            updateTextItemsVisibility(for: geometry.size)
//                        }
//                        .onChange(of: geometry.size) { newSize in
//                            updateTextItemsVisibility(for: newSize)
//                        }
//                        .onAppear{
//                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                               let _ = windowScene.windows.first {
//                                toolPicker.setVisible(showTool, forFirstResponder: canvasView)
//                                toolPicker.addObserver(canvasView)
//                                canvasView.becomeFirstResponder()
//                                canvasView.isUserInteractionEnabled = showTool
//                            }
//                        }
//                        .onChange(of: showTool) { newValue in
//                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                               let _ = windowScene.windows.first {
//                                toolPicker.setVisible(showTool, forFirstResponder: canvasView)
//                                toolPicker.addObserver(canvasView)
//                                canvasView.becomeFirstResponder()
//                                canvasView.isUserInteractionEnabled = showTool
//                            }
//                        }
//                        .overlay {
//                            DraggableTextItemsView(
//                                textItems: $textItems,
//                                drawEnable: showTool,
//                                isTextFullyVisible: { textItem in
//                                    isTextFullyVisible(textItem, canvasSize: geometry.size)
//                                },
//                                isTextVisible: { textItem in
//                                    isTextVisible(textItem, canvasSize: geometry.size)
//                                },
//                                geometrySizeWidth: geometry.size.width
//                            )
//
//                            if newText.text != "" {
//                                if newText.isScrolling && !showTool{
//                                    ScrollView(.vertical) {
//                                        TextPreview(
//                                            newText: $newText,
//                                            drawEnable: showTool,
//                                            isTextFullyVisible: { textItem in
//                                                isTextFullyVisible(textItem, canvasSize: geometry.size)
//                                            },
//                                            geometrySizeWidth: geometry.size.width
//                                        )
//                                    }
//                                }
//                                else {
//                                    TextPreview(
//                                        newText: $newText,
//                                        drawEnable: showTool,
//                                        isTextFullyVisible: { textItem in
//                                            isTextFullyVisible(textItem, canvasSize: geometry.size)
//                                        },
//                                        geometrySizeWidth: geometry.size.width
//                                    )
//                                }
//                            }
//                        }
//                        .cornerRadius(15)
//                        .shadow(radius: 7.5)
//                        .padding()
//
//
//
//
//
//
//                    // Thanh công cụ tùy chỉnh
//                    if !showTextField {
//                        VStack {
//                            HStack(spacing: 75) {
//
//                                Button(action: {
//                                    showTool.toggle()
//                                    if showTool {
//                                        resetTextItemScrollingDragging(&textItems)
//                                    }
//                                }) {
//                                    Symbol(showTool ? "arrow.down.to.line.compact" : "arrow.up.to.line.compact", symbolColor: THEME.NumberButton_characterColor, symbolSize: 35, boldFontWeight: true)
//                                }
//                                .buttonStyle(NumberButtonStyle(widthNum: 180, heightNum: 70, cornerRadius: 40, THEME: THEME))
//                                .padding(.horizontal)
//
//
//
//                                Button(action: clearCanvas) {
//                                    Symbol("trash", symbolColor: THEME.NumberButton_characterColor, symbolSize: 30, boldFontWeight: true)
//                                }
//                                .buttonStyle(NumberButtonStyle(widthNum: 180, heightNum: 70, cornerRadius: 40, THEME: THEME))
//                                .padding(.horizontal)
//
//
//
//                                Button(action: {
//                                    showTextField.toggle()
//                                    if showTool {
//                                        showToolCheck = true
//                                        showTool = false
//                                    }
//                                    resetTextItemScrollingDragging(&textItems)
//                                }) {
//                                    Symbol("character.textbox", symbolColor: THEME.NumberButton_characterColor, symbolSize: 35, boldFontWeight: true)
//                                }
//                                .buttonStyle(NumberButtonStyle(widthNum: 180, heightNum: 70, cornerRadius: 40, THEME: THEME))
//                                .padding(.horizontal)
//
//
//                            }
//                            .padding(.top, 10)
//                            .padding(.bottom, 40)
//
//                            Button(action: {showPopUp.toggle()}) {
//                                Symbol("questionmark.circle", symbolColor: THEME.NumberButton_characterColor, symbolSize: 30, boldFontWeight: true)
//                            }
//                            .buttonStyle(NumberButtonStyle(widthNum: 150, heightNum: 70, cornerRadius: 40, THEME: THEME))
//                            .padding(.bottom, -7)
//                        }
//                    }
//
//
//
//
//
//
//                    // Hiển thị TextField và các tùy chọn
//                    if showTextField {
//                        VStack (spacing: 10){
//                            HStack {
//                                Image(systemName: "textformat").foregroundColor(THEME.TextField_AaSymbolColor).font(.system(size: 20, weight: .semibold))
//                                TextField("", text: $newText.text)
//                            }
//                            .modifier(customViewModifier(startColor: THEME.TextField_backgroundStart, endColor: THEME.TextField_backgroundEnd, textColor: THEME.TextField_textColor, roundedCornes: 30))
//                            .shadow(radius: 8)
//                            .padding()
//
//
//                            VStack(spacing: 45) {
//                                CustomColorPicker(selectedColor: $newText.color, dragOffset: $colorPickerDraggOffset)
//                                VStack (spacing: 15){
//                                    CustomSlider($newText.fontSize, THEME: THEME)
//
//                                    HStack{
//                                        FontDesignSwitch(selectedFont: $selectedFontDesign, fontReturn: $newText.fontDesign)
//                                        FontWeightSwitch(selectedFont: $selectedFontWeight, fontDesign: selectedFontDesign ,fontReturn: $newText.fontWeight)
//                                    }
//                                    .scaleEffect(scaleEffect + 0.05)
//                                }
//                            }
//
//
//                            Button(action: {
//                                showTextField = false
//                                if showToolCheck {
//                                    showTool = true
//                                    showToolCheck = false
//                                }
//                                if newText.text != "" {
//                                    let newTextItem = TextItem(text: newText.text, color: newText.color, fontSize: newText.fontSize, fontWeight: newText.fontWeight, fontDesign: newText.fontDesign, position: newText.position)
//                                    textItems.append(newTextItem)
//                                    newText.text = ""
//                                    newText.position = CGPoint(x: 170, y: 170)
//                                    newText.isScrolling = false
//                                    newText.isDragging = false
//                                }
//                            }) {
//                                Symbol("checkmark.circle.fill", symbolColor: THEME.NumberButton_characterColor, symbolSize: 50)
//                                    .padding()
//                            }
//                            .buttonStyle(ScaledButtonStyle(scaleRadius: 1.5))
//                        }
//                    }
//                }
//            }
//
//
//            // QUICK START GUIDE POP UP
//            HelpPopupView(showPopup: $showPopUp, THEME: THEME)
//
//        }
//        .animation(.interactiveSpring(response: 0.45, dampingFraction: 0.5, blendDuration: 0.1), value: showTextField)
//    }
//
//
//    func updateTextItemsVisibility(for size: CGSize) {
//        for index in textItems.indices {
//            let textItem = textItems[index]
//            if !isTextVisible(textItem, canvasSize: size) {
//                textItems.remove(at: index)
//            }
//        }
//    }
//
//    func clearCanvas() {
//        canvasView.drawing = PKDrawing()
//        textItems.removeAll()
//    }
//}
//
//
//
//// Giả lập dữ liệu của giao diện
//struct PencilkitFramework_Previews: PreviewProvider {
//    static var previews: some View {
//        PencilkitFramework(THEME: StyleChoices().lightTheme, scaleEffect: 1)
//    }
//}
//
//
//

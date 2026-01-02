//
//  DrawingCanvasViewController.swift
//  Drawing Pencil Kit
//
//  Created by Haaris Iqubal on 5/7/21.
//

import SwiftUI
import PencilKit

class DrawingCanvasViewController: UIViewController {

    lazy var canvas: PKCanvasView = {
        let view = PKCanvasView()
        view.drawingPolicy = .anyInput
        view.minimumZoomScale = 1
        view.maximumZoomScale = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    var isToolPickerVisible: Bool
    init(isToolPickerVisible: Bool = false) {
        self.isToolPickerVisible = isToolPickerVisible
        super.init(nibName: nil, bundle: nil)
    }
    
    

    lazy var toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        toolPicker.addObserver(self)
        return toolPicker
    }()

    var drawingData = Data()
    var drawingChanged: (Data) -> Void = {_ in}



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canvas)
        NSLayoutConstraint.activate([
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvas.topAnchor.constraint(equalTo: view.topAnchor),
            canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        toolPicker.setVisible(isToolPickerVisible, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.delegate = self
        canvas.becomeFirstResponder()
        if let drawing = try? PKDrawing(data: drawingData){
            canvas.drawing = drawing
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        toolPicker.setVisible(isToolPickerVisible, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.isUserInteractionEnabled = isToolPickerVisible
    }
    
    
    func updateToolPickerVisibility() {
        canvas.becomeFirstResponder()
        toolPicker.setVisible(isToolPickerVisible, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.isUserInteractionEnabled = isToolPickerVisible
    }
   
    
    func updateCanvas() {
        canvas.delegate = self
        canvas.becomeFirstResponder()
        
        let emptyDrawing = PKDrawing()
        canvas.drawing = emptyDrawing
    }
}



extension DrawingCanvasViewController:PKToolPickerObserver, PKCanvasViewDelegate{
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        drawingChanged(canvasView.drawing.dataRepresentation())
    }
}






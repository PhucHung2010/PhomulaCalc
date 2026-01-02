//
//  DrawingCanvasView.swift
//  Drawing Pencil Kit
//
//  Created by Haaris Iqubal on 5/7/21.
//

import SwiftUI
import CoreData
import PencilKit

struct CanvasView: UIViewControllerRepresentable {

    
    @Environment(\.managedObjectContext) private var viewContext
    var data: Data
    var id: UUID
    var showTool: Bool
    @Binding var eraseCanvas: Bool
    
    func updateUIViewController(_ uiViewController: DrawingCanvasViewController, context: Context) {
       
        uiViewController.drawingData = data
        
        if eraseCanvas {
            DispatchQueue.main.async {
                eraseCanvas = false
            }
            uiViewController.updateCanvas()
        }


        if uiViewController.isToolPickerVisible != showTool {
            uiViewController.isToolPickerVisible = showTool
            uiViewController.updateToolPickerVisibility()
        }
    }
    typealias UIViewControllerType = DrawingCanvasViewController
    
    
    
    
    func makeUIViewController(context: Context) -> DrawingCanvasViewController {
        let viewController = DrawingCanvasViewController(isToolPickerVisible: showTool)
        viewController.drawingData = data
        
        viewController.drawingChanged = { data in
            DispatchQueue.main.async {
                let request: NSFetchRequest<Drawing> = Drawing.fetchRequest()
                let predicate = NSPredicate(format: "id == %@", id as CVarArg)
                request.predicate = predicate
                do {
                    let result = try viewContext.fetch(request)
                    if let obj = result.first {
                        obj.setValue(data, forKey: "canvasData")
                        do {
                            try viewContext.save()
                        } catch {
                            print(error)
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
        return viewController
    }
}

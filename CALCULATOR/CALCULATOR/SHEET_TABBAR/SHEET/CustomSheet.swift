//
//  ContentView.swift
//  CALCULATOR
//
//  Created by Hung Nguyen on 12/08/2024.
//

import SwiftUI
import UIKit
import Foundation


// Custom Half sheet modifier

extension View {
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, fullSizeSheet: Bool = false, @ViewBuilder sheetView: @escaping () -> SheetView, onEnd: @escaping ()->()) -> some View {
        return self
            .background (
                HalfSheetHelper(sheetView: sheetView(), fullSizeSheet: fullSizeSheet, showSheet: showSheet, onEnd: onEnd)
            )
    }
}

struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    var sheetView: SheetView
    var fullSizeSheet: Bool
    @Binding var showSheet: Bool
    var onEnd: () -> ()

    let controller = UIViewController()

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

        if showSheet {

            let sheetController = fullSizeSheet ? CustomHostingControllerFullSize(rootView: sheetView) : CustomHostingControllerHalfSize(rootView: sheetView)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
//            {
//                DispatchQueue.main.async {
//                    self.showSheet.toggle()
//                }
//            }
        }
//        else {uiViewController.dismiss(animated: true)}
    }

    // On dismiss
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {

        var parent: HalfSheetHelper

        init(parent: HalfSheetHelper) {
            self.parent = parent
        }

        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
            parent.onEnd()
        }
    }
}

class CustomHostingControllerHalfSize <Content: View>: UIHostingController<Content> {
    
    override func viewDidLoad() {

        view.backgroundColor = .clear

        if let presentationController = presentationController as? UISheetPresentationController {

            presentationController.detents = [.medium()]

            presentationController.prefersGrabberVisible = false
        }
    }
}

class CustomHostingControllerFullSize <Content: View>: UIHostingController<Content> {
    
    override func viewDidLoad() {

        view.backgroundColor = .clear

        if let presentationController = presentationController as? UISheetPresentationController {

            presentationController.detents = [.medium(), .large()]

            presentationController.prefersGrabberVisible = false
        }
    }
}



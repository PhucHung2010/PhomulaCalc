//
//  ContentView.swift
//  Drawing Pencil Kit
//
//  Created by Haaris Iqubal on 5/7/21.
//

import SwiftUI
import CoreData



struct PencilKitHome: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Drawing.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Drawing.dateCreated, ascending: true)
    ]) var drawings: FetchedResults<Drawing>
    
    @State private var selectedDrawing: Drawing?
    
    @State private var allowScroll = true
    
    @State private var addCanvas = false
    @State private var deleteCanvas = false
    @State private var guidePopup = false

    var THEME: ThemeStyle
    var iphone: Iphone
    var scaleEffect: CGFloat
    
    @State private var animateView: Bool = false
    @Namespace private var animation
    
    @State private var isPressingOnWindow: Bool = false
    
    
    
    var body: some View {
        ZStack {
            
            LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).ignoresSafeArea()
            
            ScrollView(.vertical) {
                    
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                    ForEach(drawings) { drawing in
                        CardView(drawing)
                            .onTapGesture {
                                selectedDrawing = drawing
                                withAnimation(.interactiveSpring(response: 0.45, dampingFraction: 0.55, blendDuration: 0.1)) {
                                    animateView = true
                                }
                            }
                            .onLongPressGesture(minimumDuration: 1.2, pressing: { isPressing in
                                selectedDrawing = drawing
                                self.isPressingOnWindow = isPressing
                            } ,perform: {
                                withAnimation(.interactiveSpring(response: 0.45, dampingFraction: 0.6, blendDuration: 0.1)) {
                                    deleteCanvas = true
                                }
                            })
                            .scaleEffect(isPressingOnWindow && selectedDrawing == drawing ? 0.7 : 1)
                            .animation(.easeInOut(duration: 0.5), value: isPressingOnWindow)
                            .animation(.interactiveSpring(response: 0.45, dampingFraction: 0.55, blendDuration: 0.1), value: animateView)
                            
                    }
                    
                    Button(action: {
                        addCanvas = true
                    }) {
                        Image(systemName: "pencil.tip.crop.circle.badge.plus")
                            .font(.system(size: 90, weight: .semibold, design: .rounded))
                            .foregroundColor(THEME.ExtraOperatorInfor_titleCharacterColor)
                            .frame(width: 150, height: 150)
                            .background(
                                BlurView(style: .regular)
                                    .clipShape(Circle())
                            )
                    }
                    .buttonStyle(ScaledButtonStyle3(scaleRadius: 0.5))
                    .shadow(radius: 6)
                }
                .padding()
            }
            .overlay {
                GeometryReader {_ in
                    ForEach(drawings) {drawing in
                        if drawing.id == selectedDrawing?.id && animateView {
                            DrawingCanvas(id: drawing.id,
                                        data: drawing.canvasData,
                                        title: drawing.title,
                                        currentDrawing: drawing,
                                        THEME: THEME,
                                        scaleEffect: scaleEffect,
                                        selectedDrawing: $selectedDrawing,
                                        animateView: $animateView)
                                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                                .transition(.scale)
                                .matchedGeometryEffect(id: drawing.id, in: animation)
                        }
                    }
                }
            }
            
            // POPUP
            AddNewCanvasPopup(showPopup: $addCanvas, THEME: THEME)
            if let selectedDrawing = selectedDrawing {
                DeleteCanvasView(selectedDrawing)
            }
        }
    }
    
    
    
    @ViewBuilder
    func CardView(_ drawing: Drawing) -> some View {
        ZStack {
            if selectedDrawing?.id == drawing.id && animateView {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.clear)
            }
            else {

                PreviewDrawingCanvas(id: drawing.id, data: drawing.canvasData, title: drawing.title)
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                    .mask(RoundedRectangle(cornerRadius: 30))
                    .overlay(
                        Text(drawing.title ?? "Untitled")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.darkGray)
                            .padding(6)
                    )
                    .frame(height: 175)
                    .shadow(radius: 5)
                    .matchedGeometryEffect(id: drawing.id, in: animation)

            }
        }
    }

    
    
    
    
    
    @ViewBuilder
    func DeleteCanvasView(_ drawing: Drawing) -> some View {
        if deleteCanvas {
            ZStack {

                Color.black.opacity(0.2).ignoresSafeArea().transition(.opacity)
                
                VStack {
                    Button (action: {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.55, blendDuration: 0.1)) {
                            animateView = true
                            deleteCanvas = false
                        }
                    }) {
                        PreviewDrawingCanvas(id: drawing.id, data: drawing.canvasData, title: drawing.title)
                            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                            .mask(RoundedRectangle(cornerRadius: 30))
                            .overlay(
                                Text(drawing.title ?? "Untitled")
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.darkGray)
                                    .padding(.horizontal, 5)
                            )
                            .frame(height: 300)
                            .padding()
                            .shadow(radius: 5)
                            
                            
                    }
                    .buttonStyle(ScaledButtonStyle(scaleRadius: 0.8))
                    .matchedGeometryEffect(id: drawing.id, in: animation)
                    
                    
                    
                    
                    HStack (spacing: 60){
                        Button(action: {
                            withAnimation(.interactiveSpring(response: 0.45, dampingFraction: 0.6, blendDuration: 0.1)) {
                                deleteCanvas = false
                            }
                        }) {
                            Number("Cancel", numberColor: THEME.CircleFunctionButton_characterColor, fontWeight: .semibold, fontSize: 30)
                                .background(
                                    RoundedRectangle(cornerRadius: 45)
                                        .stroke(lineWidth: 5)
                                        .foregroundColor(THEME.backgroundStart)
                                        .background(
                                            BlurView(style: . regular)
                                                .clipShape(RoundedRectangle(cornerRadius: 45))
                                        )
                                        .frame(width: 130, height: 55)
                                )
                        }
 
                        Button(action: {
                            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.1)) {
                                deleteCanvas = false
                            }
                            viewContext.delete(drawing)
                            selectedDrawing = nil
                            do{
                                try viewContext.save()
                            }
                            catch{
                                
                            }
                        }) {
                            Number("Delete", numberColor: Color.red.opacity(0.8), fontWeight: .semibold, fontSize: 30)
                                .background(
                                    RoundedRectangle(cornerRadius: 45)
                                        .stroke(lineWidth: 5)
                                        .foregroundColor(THEME.backgroundStart)
                                        .background(
                                            BlurView(style: . regular)
                                                .clipShape(RoundedRectangle(cornerRadius: 45))
                                        )
                                        .frame(width: 130, height: 55)
                                )
                        }
                    }
                    .offset(y: 5)
                    .shadow(radius: 8)
                    .buttonStyle(ScaledButtonStyle3(scaleRadius: 1.2))
                    
                }
                .background(
                    LinearGradient(THEME.backgroundStart, THEME.backgroundEnd)
                        .cornerRadius(30)
                        .shadow(radius: 10)
                )
                .padding()
                .transition(.scale)
            }
        }
    }

}


struct PencilKitHome_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}








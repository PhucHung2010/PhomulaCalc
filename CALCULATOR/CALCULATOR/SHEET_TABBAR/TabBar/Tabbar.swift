//
//  Tabbar.swift
//  CALCULATOR
//
//  Created by Hung Nguyen on 17/08/2024.
//

import SwiftUI
import UIKit

//struct Tabbar: View {
//
//    @State private var activeTab: Tab = .home
//    @Namespace private var animation
//    @State private var tabShapePosition: CGPoint = .zero
//    @State var uiTabarController: UITabBarController?
//    
//    init() {
//        UITabBar.appearance().isHidden = true
//    }
//
//    var body: some View {
//
//        ZStack {
//            Color.offWhite.ignoresSafeArea()
//
//            VStack (spacing: 0) {
//
//                CustomTabBar()
//            }
//        }
//    }
//
//
//    // custom tabbar
//    @ViewBuilder
//    func CustomTabBar(_ tint: Color = Color("black"), _ inactiveTint: Color = .darkGray) -> some View {
//
//        HStack(alignment: .bottom, spacing: 0) {
//            ForEach(Tab.allCases, id: \.rawValue) {
//                TabItem(
//                    tint: .darkGray,
//                    inactiveTint: inactiveTint,
//                    tab: $0,
//                    animation: animation,
//                    activeTab: $activeTab,
//                    position: $tabShapePosition
//                )
//            }
//        }
//        .padding(.horizontal, 15)
//        .padding(.top, -14)
//        .padding(.bottom, 15)
//        .background(content: {
//            TabShape(midpoint: tabShapePosition.x)
//                .fill(Color.offWhite)
//                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: -1)
//                .ignoresSafeArea()
//        })
//        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.3, blendDuration: 0.3), value: activeTab)
//    }
//
//}



struct TabItem: View {
    var tint: Color
    var activeTint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    @Binding var position: CGPoint
    
    @Binding var changeTheme: Bool
    
    @State private var tabPosition: CGPoint = .zero
    @AppStorage("currentImage") private var currentTheme: CustomShape = .Default
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: tabImage(tab, currentTheme))
                .font(.system(size: 23, weight: .regular, design: .rounded))
                .foregroundColor(activeTab == tab ? activeTint : inactiveTint)
                .scaleEffect(activeTab == tab ? 1.4 : 1)
                .frame(width: activeTab == tab ? 25 : 30, height: activeTab == tab ? 25 : 5)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint)
                            .frame(width: 45, height: 45)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion:  {rect in
            tabPosition.x = rect.midX
            
            if activeTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            if tab == .setting {
                changeTheme.toggle()
            }
            else {
                withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.4, blendDuration: 0.1)) {
                    activeTab = tab
                    position.x = tabPosition.x
                }
            }
        }
    }
    
    
    func tabImage(_ tab: Tab, _ currentTheme: CustomShape) -> String {
        if tab == .setting {
            if currentTheme == CustomShape.Default {
                return "cloud.sun.fill"
            }
            else if currentTheme == CustomShape.Sun {
                return "sun.max.fill"
            }
            else {
                return "moon.fill"
            }
        }
        return tab.systemImage
    }
}



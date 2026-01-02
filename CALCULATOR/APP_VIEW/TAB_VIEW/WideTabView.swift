//
//  WideTabView.swift
//  CALCULATOR
//
//  Created by Hung Nguyen on 19/08/2024.
//

import SwiftUI


struct TabBarAccessor: UIViewControllerRepresentable {
    var callback: (UITabBar) -> Void
    private let proxyController = ViewController()

    func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarAccessor>) ->
                              UIViewController {
        proxyController.callback = callback
        return proxyController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<TabBarAccessor>) {
    }
    
    typealias UIViewControllerType = UIViewController

    private class ViewController: UIViewController {
        var callback: (UITabBar) -> Void = { _ in }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let tabBar = self.tabBarController {
                self.callback(tabBar.tabBar)
            }
        }
    }
}





struct WideTabView: View {

    // IphoneType
    var iphone: Iphone
    
        
    // TAB BAR
    @State private var activeTab: Tab = .home
    @State private var beforeChangeThemeTab: Tab = .home
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    @State var uiTabarController: UITabBarController?
    

    
    // THEME_OPERATOR SHEET
    /// Theme
    @State private var changeTheme: Bool = false
    @State private var themeChanged: Bool = false
    /// Extra operator
    @State private var extraOperator: Bool = false
    
    @AppStorage("userTheme") private var userTheme: Theme = .Default
    @State private var THEME: ThemeStyle = StyleChoices().defaultTheme
    
    private func updateTheme(for theme: Theme) -> ThemeStyle {
        switch theme {
        case .Default:
            return StyleChoices().defaultTheme
        case .dark:
            return StyleChoices().darkTheme
        case .light:
            return StyleChoices().lightTheme
        }
    }
    
    
    let persistenceController = PersistenceController.shared
    

    var body: some View {
        ZStack {
            LinearGradient(THEME.backgroundStart, THEME.backgroundEnd).ignoresSafeArea()

            VStack (spacing: iphone.spacing) {
                TabView(selection: $activeTab) {
                    
                    
                    
                    UnitConverter(iphone: iphone, THEME: THEME)
                        .tag(Tab.converter)
                        .background(TabBarAccessor { tabBar in
                            tabBar.isHidden = true
                         })
                    
                    
                    CalculationInterface(
                        THEME: THEME,
                        boardWidth: iphone.boardWidth,
                        tinyFunc_gridWidth: iphone.tinyFunc_gridWidth,
                         func_gridWidth: iphone.func_gridWidth,
                         num_gridWidth: iphone.num_gridWidth,
                         scaleEffect: iphone.CalculationUI_Scale,
                        extraOperatorSheetScale: iphone.extraOperatorScale,
                         zeroWidth: iphone.zeroWidth
                    )
                    .tag(Tab.home)
                    .background(TabBarAccessor { tabBar in
                        tabBar.isHidden = true
                     })
                    
                    
                    PencilKitHome(THEME: THEME, iphone: iphone, scaleEffect: iphone.CalculationUI_Scale)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .background(TabBarAccessor { tabBar in
                            tabBar.isHidden = true
                         })
                        .tag(Tab.draw)
                    
                    
                    CreditView(THEME: THEME)
                    .background(TabBarAccessor { tabBar in
                        tabBar.isHidden = true
                     })
                    .tag(Tab.more)

                }
                .halfSheet(showSheet: $changeTheme) {
                    ThemeSheet(ScaleEffect: iphone.sheetScale, THEME: $THEME)
                } onEnd: {}
                
                CustomTabBar()
                    .offset(y: iphone.tabbarOffset)
            }
            .animation(.easeInOut(duration: 2.5), value: userTheme)
            .onAppear {THEME = updateTheme(for: userTheme)}
            .ignoresSafeArea(.keyboard)
        }
        
    }
    
    
    
    
    @ViewBuilder
    func CustomTabBar() -> some View {

        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: THEME.TabItem_tint,
                    activeTint: THEME.TabItem_activeTint,
                    inactiveTint: THEME.TabItem_inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab,
                    position: $tabShapePosition,
                    changeTheme: $changeTheme
                )
                .scaleEffect(iphone.tabItemScale)
            }
        }
        .padding(.horizontal, 15)
        .padding(.top, iphone.tabbarTopPadding)
        .padding(.bottom, 15)
        .background(content: {
            TabShape(midpoint: tabShapePosition.x)
                .fill(THEME.Tabbar_background)
                .shadow(color: THEME.Tabbar_Shadow.opacity(0.3), radius: 2, x: 0, y: -1)
                .ignoresSafeArea()
        })
    }
}

struct WideTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewCalculator()
    }
}

//
//  AppTabView.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import SwiftUI

struct AppTabView: View {
    private var coordinator: TabsCoordinator
    
    init(coordinator: TabsCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                coordinator.makeHomeView()
            }
            
            Tab("Settiings", systemImage: "gear") {
                coordinator.makeSettingsView()
            }
        }
    }
}

#Preview {
    let container = MockDIContainer()
    AppTabView(coordinator: TabsCoordinator(diContainer: container))
        .environment(AppCoordinator(diContainer: container))
}

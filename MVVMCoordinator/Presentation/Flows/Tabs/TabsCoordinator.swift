//
//  TabsCoordinator.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation
import SwiftUI

@Observable
class TabsCoordinator {
    
    private let diContainer: Container
    
    init(diContainer: Container) {
        self.diContainer = diContainer
    }
    
    @ViewBuilder
    func showView() -> some View {
        AppTabView(coordinator: self)
    }
    
    func makeHomeView() -> some View {
        HomeView(viewModel: diContainer.makeHomeViewModel())
    }
    
    func makeSettingsView() -> some View {
        SettingsView(viewModel: diContainer.makeSettingsViewModel())
    }
}

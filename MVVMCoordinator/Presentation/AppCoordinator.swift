//
//  AppCoordinator.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation
import SwiftUI

/// AppCoordinator is responsible for managing the application's navigation flow and coordinating dependency injection.
/// It determines which primary UI flow (authentication or main content) should be presented based on user state.
/// Handles dependency injection, mock environments, and UI testing scenarios.
@Observable
class AppCoordinator {
    
    /// Enumerates the possible navigation flows in the app.
    enum Flow {
        case none
        case auth
        case main
    }
    
    /// The navigation path used for controlling navigation stack.
    var path = NavigationPath()
    /// Current flow state of the application.
    private var currentFlow: Flow = .none
    
    /// Dependency injection container used throughout the app.
    private let diContainer: Container
    
    /// Initializes the AppCoordinator with a dependency injection container.
    /// Uses mock dependencies if the USE_MOCK_API environment variable is set.
    /// Also triggers login state check on initialization.
    init(diContainer: Container = DIContainer()) {
        if (ProcessInfo.processInfo.environment["USE_MOCK_API"] == "true") {
            self.diContainer = MockDIContainer()
        } else {
            self.diContainer = diContainer
        }
        checkLogin()
    }
    
    /// Checks user login state and sets the current flow accordingly.
    /// Resets user defaults if running under UI testing.
    func checkLogin() {
        
        if ProcessInfo.processInfo.arguments.contains("--ui-testing") {
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        }
        
        Task {
            try? await Task.sleep(for: .seconds(1))
            let result = UserDefaults().value(forKey: "isLoggedIn") as? Bool
            let isLoggedIn = result == true
            currentFlow = isLoggedIn ? .main : .auth
        }
    }
    
    /// Returns the root view for the current flow.
    @ViewBuilder
    func showView() -> some View {
        switch currentFlow {
            case .none:
                ProgressView()
                    .controlSize(.large)
                    .foregroundStyle(.blue)
            case .auth:
                AuthCoordinator(diContainer: diContainer).makeAuthView()
            case .main:
                TabsCoordinator(diContainer: diContainer).showView()
        }
    }
    
    /// Programmatically transitions to a specific navigation flow.
    func goToFlow(_ flow: Flow) {
        currentFlow = flow
    }
}

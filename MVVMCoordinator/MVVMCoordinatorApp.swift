//
//  MVVMCoordinatorApp.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//

import SwiftUI

@main
struct MVVMCoordinatorApp: App {
    private let coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            coordinator.showView()
                .environment(coordinator)
        }
    }
}

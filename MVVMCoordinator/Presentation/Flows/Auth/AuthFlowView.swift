//
//  AuthFlowView.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import SwiftUI

struct AuthFlowView: View {
    
    @State private var coordinator: AuthCoordinator
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.showView(.login)
                .navigationDestination(for: AuthCoordinator.Routes.self) {
                    coordinator.showView($0)
                }
                .sheet(isPresented: $coordinator.isSheetPresented, content: {
                    coordinator.showView(.forgotPassword)
                })
                .fullScreenCover(isPresented: $coordinator.isFullScreenPresented) {
                    coordinator.showView(.register)
                }
        }
    }
}

#Preview {
    AuthFlowView(coordinator: AuthCoordinator(diContainer: MockDIContainer()))
        .environment(AppCoordinator())
}

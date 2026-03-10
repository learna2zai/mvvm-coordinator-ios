//
//  AuthCoordinator.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//

import Foundation
import SwiftUI

@Observable
class AuthCoordinator {
    
    enum Routes: Hashable {
        case login
        case register
    }
    
    var path = NavigationPath()
    
    private let diContainer: Container
    
    init(diContainer: Container) {
        self.diContainer = diContainer
    }
    
    func makeAuthView() -> some View {
        AuthFlowView(coordinator: self)
    }
    
    @ViewBuilder
    func showView(_ route: Routes) -> some View {
        switch route {
            case .login:
                LoginView(viewModel: diContainer.loginViewModel,
                          coordinator: self)
            case .register:
                RegisterView(viewModel: diContainer.registerViewModel,
                             coordinator: self)
        }
    }
    
    func goTo(_ route: Routes) {
        path.append(route)
    }
    
    func dismiss() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
}

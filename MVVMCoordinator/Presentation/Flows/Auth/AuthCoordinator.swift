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
        case forgotPassword
    }
    
    enum PresentationType: Hashable {
        case sheet
        case fullScreen
    }
    
    var path = NavigationPath()
    
    var isSheetPresented: Bool = false
    var isFullScreenPresented: Bool = false
    
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
                LoginView(viewModel: diContainer.makeLoginViewModel(),
                          coordinator: self)
            case .register:
                RegisterView(viewModel: diContainer.makeRegisterViewModel())
            case .forgotPassword:
                ForgotPasswordView(viewModel: diContainer.makeForgotPasswordViewModel())
        }
    }
    
    func goTo(_ route: Routes) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func present(_ type: PresentationType) {
        if type == .fullScreen {
            isFullScreenPresented = true
        } else {
            isSheetPresented = true
        }
    }
}

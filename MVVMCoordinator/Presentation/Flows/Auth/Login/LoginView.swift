//
//  LoginView.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @Environment(AppCoordinator.self) private var appCoordinator: AppCoordinator
    @State var viewModel: LoginViewModel
    private var coordinator: AuthCoordinator
    
    init(viewModel: LoginViewModel,
         coordinator: AuthCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        BaseAuthView {
            VStack(alignment: .center, spacing: 20) {
                Text("Login To App")
                    .makeTitle()
                
                VStack(spacing: 20) {
                    TextField("Username", text: $viewModel.username)
                    SecureField("Password", text: $viewModel.password)
                }
                .textFieldStyle(.roundedBorder)
                
                PrimaryButton(title: "Login", isLoading: $viewModel.isLoading) {
                    Task {
                        let result = await viewModel.login()
                        if result {
                            withAnimation {
                                appCoordinator.goToFlow(.main)
                            }
                        }
                    }
                }
                
                HStack(alignment: .center) {
                    Button("Register Now!") {
                        withAnimation {
                            coordinator.present(.fullScreen)
                        }
                    }
                    Spacer()
                    Text("-- ✤ --")
                    Spacer()
                    Button("Forgot password?") {
                        withAnimation {
                            coordinator.present(.sheet)
                        }
                    }
                }
                .font(.callout)
            }
        }
    }
}

#Preview {
    let container = MockDIContainer()
    LoginView(viewModel: container.makeLoginViewModel(),
              coordinator: AuthCoordinator(diContainer: container))
    .environment(AppCoordinator())
}

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
        ZStack {
            LinearGradient(colors: [.gray.opacity(0.2), .gray.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 20) {
                Text("Login To App")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                    .padding(.bottom)
                
                VStack(spacing: 20) {
                    TextField("Username", text: $viewModel.username)
                    SecureField("Password", text: $viewModel.password)
                }
                .textFieldStyle(.roundedBorder)
                Button {
                    Task {
                        let result = await viewModel.login()
                        if result {
                            withAnimation {
                                appCoordinator.goToFlow(.main)
                            }
                        }
                    }
                } label: {
                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(Color.white)
                                .padding(2)
                                
                        } else {
                            Text("Login")
                                .font(.headline)
                        }
                    }
                    .frame(maxWidth: .greatestFiniteMagnitude)
                    .padding(.vertical, 10)
                }
                .foregroundStyle(.white)
                .background(Color.orange)
                .cornerRadius(10)
                
                Button("Register New") {
                    withAnimation {
                        coordinator.goTo(.register)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    let container = MockDIContainer()
    LoginView(viewModel: container.loginViewModel,
              coordinator: AuthCoordinator(diContainer: container))
        .environment(AppCoordinator())
}

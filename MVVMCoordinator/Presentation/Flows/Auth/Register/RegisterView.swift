//
//  RegisterView.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import SwiftUI

struct RegisterView: View {
    
    @State var viewModel: RegisterViewModel
    private var coordinator: AuthCoordinator
    
    init(viewModel: RegisterViewModel,
         coordinator: AuthCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gray.opacity(0.2), .gray.opacity(0.6)],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 20) {
                Text("Register New Account")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                    .padding(.bottom)
                VStack(spacing: 20) {
                    TextField("Name", text: $viewModel.name)
                    TextField("Username", text: $viewModel.username)
                    SecureField("Password", text: $viewModel.password)
                }
                .textFieldStyle(.roundedBorder)
                Button {
                    Task {
                        let result = await viewModel.register()
                        if result {
                            withAnimation {
                                coordinator.dismiss()
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
                            Text("Regitser")
                                .font(.headline)
                        }
                    }
                    .frame(maxWidth: .greatestFiniteMagnitude)
                    .padding(.vertical, 10)
                }
                .foregroundStyle(.white)
                .background(Color.orange)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Cancel") {
                    coordinator.dismiss()
                }
                .glassEffect()
            }
        }
    }
}

#Preview {
    let container = MockDIContainer()
    RegisterView(viewModel: container.registerViewModel,
                 coordinator: AuthCoordinator(diContainer: container))
}

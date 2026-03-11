//
//  ForgotPasswordView.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//

import SwiftUI


import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: ForgotPasswordViewModel
    
    init( viewModel: ForgotPasswordViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        BaseAuthView {
            
            VStack {
                HStack {
                    Spacer()
                    Button("Cancel") {
                        dismiss()
                    }
                    .padding(8)
                    .glassEffect()
                }
                .padding(.bottom, 100)
                
                VStack(alignment: .center, spacing: 20) {
                    Text("Reset your password")
                        .makeTitle()
                    
                    TextField("Username", text: $viewModel.username)
                        .textFieldStyle(.roundedBorder)
                    
                    PrimaryButton(title: "Submit", isLoading: $viewModel.isLoading) {
                        Task {
                            let result = await viewModel.submit()
                            if result { dismiss() }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    let container = MockDIContainer()
    ForgotPasswordView(viewModel: container.makeForgotPasswordViewModel())
}

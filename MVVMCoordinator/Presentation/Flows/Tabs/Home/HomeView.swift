//
//  HomeView.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import SwiftUI

struct HomeView: View {
    
    @State private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.users) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .onAppear(perform: {
                Task {
                    await viewModel.fetchUsers()
                }
            })
            .overlay {
                if !viewModel.isLoading && viewModel.errorMessage == nil && viewModel.users.isEmpty {
                    ContentUnavailableView("Users list is empty",
                                           systemImage:"person.3.fill",
                                           description: Text("There is no users available yet."))
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.headline)
                        .foregroundStyle(.red)
                } else if viewModel.isLoading {
                    ProgressView().controlSize(.large)
                }
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    HomeView(viewModel: MockDIContainer().makeHomeViewModel())
}

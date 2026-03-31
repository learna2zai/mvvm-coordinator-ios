//
//  SettingsView.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation
import SwiftUI

struct SettingsView: View {
    
    @Environment(AppCoordinator.self) private var coordinator: AppCoordinator
    @State private var viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Notifications")) {
                    Toggle("Push Notifications", isOn: $viewModel.pusNotification)
                }
                
                Button {
                    Task {
                        let result = await viewModel.logout()
                        if result {
                            withAnimation {
                                coordinator.goToFlow(.auth)
                            }
                        }
                    }
                } label: {
                    HStack {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                        if viewModel.isLoading {
                            ProgressView().controlSize(.regular)
                        }
                    }
                    
                }
            }
            .navigationTitle(Text("Settings"))
        }
    }
}

#Preview {
    PreviewMock { container in
        SettingsView(viewModel: container.makeSettingsViewModel())
    }
}

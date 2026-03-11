//
//  SettingsViewModel.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

@Observable
class SettingsViewModel {
    var pusNotification: Bool = true
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func logout() async -> Bool {
        isLoading = true
        defer { self.isLoading = false }
        
        do {
           return try await authRepository.logout()
        } catch {
            errorMessage = "Failed to logout"
            return false
        }
    }
}

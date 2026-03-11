//
//  ForgotPasswordViewModel.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

@Observable
class ForgotPasswordViewModel {
    
    var username: String = ""
    
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private var authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func submit() async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        do {
           return try await authRepository.forgotPassword(username: username)
        } catch {
            errorMessage = "Failed to submit. Please try again. \(error.localizedDescription)"
            return false
        }
    }
}

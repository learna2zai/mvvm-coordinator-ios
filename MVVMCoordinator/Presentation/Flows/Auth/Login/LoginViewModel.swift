//
//  LoginViewModel.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

@Observable
class LoginViewModel {
    var username: String = ""
    var password: String = ""
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func login() async -> Bool {
        isLoading = true
        defer { isLoading = false }
        do {
            return try await authRepository.login(username: username, password: password)
        } catch {
            errorMessage = "Failed to login."
            return false
        }
    }
}

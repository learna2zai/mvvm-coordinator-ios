//
//  RegisterViewModel.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

@Observable
class RegisterViewModel {
    var name: String = ""
    var username: String = ""
    var password: String = ""
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let authrepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authrepository = authRepository
    }

    func register() async -> Bool {
        isLoading = true
        defer { isLoading = false }
        do {
            return try await authrepository.register(name: name,
                                                     username: username,
                                                     password: password)
        } catch {
            errorMessage = "Failed to login."
            return false
        }
    }
}

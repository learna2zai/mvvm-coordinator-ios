//
//  DIContainer.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//

import Foundation
import NetraLink

final class DIContainer: Container {
    
    private let apiClient: NetworkClient
    
    init() {
        self.apiClient = NetraLink(baseUrl: "https://jsonplaceholder.typicode.com")
    }
    
    // MARK: - Repositories
    
    func makeAuthRepository() -> AuthRepository {
        AuthRepositoryImpl(apiClient: apiClient)
    }
    
    func makeHomeRepository() -> HomeRepository {
        HomeRepositoryImpl(apiClient: apiClient)
    }
    
    // MARK: - View Models
    
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(authRepository: makeAuthRepository())
    }
    
    func makeRegisterViewModel() -> RegisterViewModel {
        RegisterViewModel(authRepository: makeAuthRepository())
    }
    
    func makeForgotPasswordViewModel() -> ForgotPasswordViewModel {
        ForgotPasswordViewModel(authRepository: makeAuthRepository())
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(homeRepository: makeHomeRepository())
    }
    
    func makeSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(authRepository: makeAuthRepository())
    }
}

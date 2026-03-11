//
//  MockDIContainer.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//

import Foundation

#if DEBUG

struct MockApiClient: NetworkClient {
    func send<T>(request: URLRequest) async throws -> T where T : Decodable {
        let data = try! JSONEncoder().encode([UserDTO]())
        return try JSONDecoder().decode(T.self, from: data)
    }
}

final class MockDIContainer: Container {
    
    private let apiClient: NetworkClient
    
    init(apiClient: NetworkClient = MockApiClient()) {
        self.apiClient = apiClient
    }
    
    // MARK: - Repositories
    
    func makeAuthRepository() -> any AuthRepository {
         MockAuthRepository(apiClient: apiClient)
    }
    
    func makeHomeRepository() -> any HomeRepository {
         MockHomeRepository(apiClient: apiClient)
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


#endif // DEBUG


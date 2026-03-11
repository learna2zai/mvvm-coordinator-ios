//
//  MockDIContainer.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

#if DEBUG

class MockApiClient: NetworkClient {
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
    
    lazy var authRepository: AuthRepository = {
        return MockAuthRepository(apiClient: apiClient)
    }()
    
    lazy var homeRepository: HomeRepository = {
        return MockHomeRepository(apiClient: apiClient)
    }()
    
    // MARK: - View Models
    
    lazy var loginViewModel: LoginViewModel = {
        return LoginViewModel(authRepository: authRepository)
    }()
    
    lazy var registerViewModel: RegisterViewModel = {
        return RegisterViewModel(authRepository: authRepository)
    }()
    
    lazy var homeViewModel: HomeViewModel = {
        return HomeViewModel(homeRepository: homeRepository)
    }()
    
    lazy var settingsViewModel: SettingsViewModel = {
        return SettingsViewModel(authRepository: authRepository)
    }()
}

#endif // DEBUG


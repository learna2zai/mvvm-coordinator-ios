//
//  DIContainer.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

protocol Container {
    var authRepository: AuthRepository { get }
    var homeRepository: HomeRepository { get }
    
    var loginViewModel: LoginViewModel { get }
    var registerViewModel: RegisterViewModel { get }
    var homeViewModel: HomeViewModel { get }
    var settingsViewModel: SettingsViewModel { get }
}

final class DIContainer: Container {
    
    private let apiClient: NetworkClient
    
    init(apiClient: NetworkClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    // MARK: - Repositories
    
    lazy var authRepository: AuthRepository = {
        return AuthRepositoryImpl(apiClient: apiClient)
    }()
    
    lazy var homeRepository: HomeRepository = {
        return HomeRepositoryImpl(apiClient: apiClient)
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

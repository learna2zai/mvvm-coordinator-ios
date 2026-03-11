//
//  Container.swift
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

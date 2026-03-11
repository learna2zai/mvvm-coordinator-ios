//
//  Container.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

protocol Container {
    
    func makeAuthRepository() -> AuthRepository
    func makeHomeRepository() -> HomeRepository
    
    func makeLoginViewModel() -> LoginViewModel
    func makeRegisterViewModel() -> RegisterViewModel
    func makeForgotPasswordViewModel() -> ForgotPasswordViewModel
    
    func makeHomeViewModel() -> HomeViewModel
    func makeSettingsViewModel() -> SettingsViewModel
}

//
//  AuthRepositoryImpl.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

class AuthRepositoryImpl: AuthRepository {
    
    private let apiClient: NetworkClient
    
    init(apiClient: NetworkClient) {
        self.apiClient = apiClient
    }
    
    func login(username: String, password: String) async throws -> Bool {
        try await Task.sleep(for: .seconds(2))
        UserDefaults().setValue(true, forKey: "isLoggedIn")
        return true
    }
    
    func register(name: String, username: String, password: String) async throws -> Bool {
        try await Task.sleep(for: .seconds(1))
        return true
    }
    
    func logout() async throws -> Bool {
        try await Task.sleep(for: .seconds(1))
        UserDefaults().removeObject(forKey: "isLoggedIn")
        return true
    }
}

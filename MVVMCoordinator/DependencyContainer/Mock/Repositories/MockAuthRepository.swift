//
//  MockAuthRepository.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

#if DEBUG

struct MockAuthRepository: AuthRepository {
    
    private let apiClient: NetworkClient
    
    init(apiClient: NetworkClient) {
        self.apiClient = apiClient
    }
    
    func login(username: String, password: String) async throws -> Bool {
        true
    }
    
    func register(name: String, username: String, password: String) async throws -> Bool {
        true
    }
    
    func forgotPassword(username: String) async throws -> Bool {
        true
    }
    
    func logout() async throws -> Bool {
        true
    }
}

#endif // DEBUG

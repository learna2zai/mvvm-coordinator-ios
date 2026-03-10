//
//  MockHomeRepository.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

#if DEBUG

final class MockHomeRepository: HomeRepository {
    
    private let apiClient: NetworkClient
    
    init(apiClient: NetworkClient) {
        self.apiClient = apiClient
    }
    
    func fetchUsers() async throws -> [User] {
        [
            .init(id: 1, name: "Test", email: "test@test.com"),
            .init(id: 2, name: "Test2", email: "test2@test.com"),
            .init(id: 3, name: "Test3", email: "test3@test.com"),
        ]
    }
}

#endif // DEBUG

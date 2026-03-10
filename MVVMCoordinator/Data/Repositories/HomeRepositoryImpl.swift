//
//  HomeRepositoryImpl.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

struct HomeRepositoryImpl: HomeRepository {
    
    private let apiClient: NetworkClient
    
    init(apiClient: NetworkClient) {
        self.apiClient = apiClient
    }
    
    func fetchUsers() async throws -> [User] {
        var request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/users")!)
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        let data: [UserDTO] = try await apiClient.send(request: request)
        return data.compactMap { User(id: $0.id, name: $0.name, email: $0.email)}
    }
}

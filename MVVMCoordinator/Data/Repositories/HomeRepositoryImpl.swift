//
//  HomeRepositoryImpl.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation
import NetraLink

struct UsersRequest: APIRequest {
    var path: String = "/users"
    var headers: [String : String] = [:]
    var method: HTTPMethod {
        .GET
    }
    var body: Data? = nil
    var queryItems: [URLQueryItem]? = nil
    var timeout: TimeInterval = 10
}

struct HomeRepositoryImpl: HomeRepository {
    
    private let apiClient: NetworkClient
    
    init(apiClient: NetworkClient) {
        self.apiClient = apiClient
    }
    
    func fetchUsers() async throws -> [User] {
        let data: [UserDTO] = try await apiClient.send(request: UsersRequest())
        return data.compactMap { User(id: $0.id, name: $0.name, email: $0.email)}
    }
}

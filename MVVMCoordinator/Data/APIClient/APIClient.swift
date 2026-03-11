//
//  APIClient.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//

import Foundation

class APIClient: NetworkClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func send<T>(request: URLRequest) async throws -> T where T: Decodable {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200  else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

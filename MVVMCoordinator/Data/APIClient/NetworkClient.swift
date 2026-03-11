//
//  NetworkClient.swift
//  MVVMCoordinator
//
//  Created on 11/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

protocol NetworkClient {
    func send<T: Decodable>(request: URLRequest) async throws -> T
}

//
//  AuthRepository.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

protocol AuthRepository {
    func login(username: String, password: String) async throws -> Bool
    func register(name: String, username: String, password: String) async throws -> Bool
    func logout() async throws -> Bool
}

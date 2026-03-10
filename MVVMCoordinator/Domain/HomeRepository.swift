//
//  HomeRepository.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

protocol HomeRepository {
    func fetchUsers() async throws -> [User]
}

//
//  User.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
}

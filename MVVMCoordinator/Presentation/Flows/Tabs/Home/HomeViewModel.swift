//
//  HomeViewModel.swift
//  MVVMCoordinator
//
//  Created on 10/03/26.
//  Copyright © 2026 . All rights reserved.
//  

import Foundation

@Observable
class HomeViewModel {
    var users: [User] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let homeRepository: HomeRepository
    
    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
    }

    func fetchUsers() async {
        if users.isEmpty == false { return }
        isLoading = true
        defer { isLoading = false }
        do {
            users = try await homeRepository.fetchUsers()
        } catch {
            errorMessage = "Failed to fetch users. \(error.localizedDescription)"
        }
    }
}

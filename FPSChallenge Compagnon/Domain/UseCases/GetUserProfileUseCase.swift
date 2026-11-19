//
//  GetUserProfileUseCase.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

struct GetUserProfileUseCase {
    private let repository: any UserRepository
    
    init(repository: any UserRepository) {
        self.repository = repository
    }
    
    func execute(username: String) async throws -> User {
        try await repository.fetchUser(username: username)
    }
}

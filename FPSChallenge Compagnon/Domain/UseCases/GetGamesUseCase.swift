//
//  GetGamesUseCase.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

struct GetGamesUseCase {
    private let repository: any GameRepository

    init(repository: any GameRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Game] {
        try await repository.fetchGames()
    }
}

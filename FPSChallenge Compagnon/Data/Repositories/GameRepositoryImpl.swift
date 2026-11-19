//
//  GameRepositoryImpl.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

final class GameRepositoryImpl: GameRepository {
    private let client: APIClient

    init(client: APIClient) {
        self.client = client
    }

    func fetchGames() async throws -> [Game] {
        do {
            let dtos: [GameDTO] = try await client.get("games")
            return dtos.map { $0.toDomain() }
        } catch let error as APIError {
            throw error.toDomain()
        }
    }
}

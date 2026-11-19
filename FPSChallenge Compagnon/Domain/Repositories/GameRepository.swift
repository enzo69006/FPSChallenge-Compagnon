//
//  GameRepository.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

protocol GameRepository {
    func fetchGames() async throws -> [Game]
}

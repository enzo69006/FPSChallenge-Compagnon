//
//  PreviewGameRepository.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

struct PreviewGameRepository: GameRepository {
    func fetchGames() async throws -> [Game] {
        [
            Game(id: 1, name: "Call of Duty 4", slug: "cod4", imageURL: nil),
            Game(id: 2, name: "Call of Duty 2", slug: "cod2", imageURL: nil),
            Game(id: 3, name: "Call of Duty 1.6x", slug: "cod1", imageURL: nil)
        ]
    }
}

//
//  PreviewUserRepository.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

struct PreviewUserRepository: UserRepository {
    func fetchUser(username: String) async throws -> User {
        User(
            id: 10073,
            name: "wsx",
            region: "Europe",
            avatarURL: nil,
            matchMaking: [
                MatchmakingStanding(id: 70, name: "5vs5 SD", regionSlug: "eu", gameSlug: "cod2", gameImageURL: nil, elo: 1235, rank: 405, winRate: nil),
                MatchmakingStanding(id: 1630, name: "2vs2 S&D", regionSlug: "eu", gameSlug: "cod1", gameImageURL: nil, elo: 1200, rank: 4, winRate: nil),
                MatchmakingStanding(id: 1, name: "5vs5 SD", regionSlug: "eu", gameSlug: "coduo", gameImageURL: nil, elo: 1087, rank: nil, winRate: nil)
            ]
        )
    }
}

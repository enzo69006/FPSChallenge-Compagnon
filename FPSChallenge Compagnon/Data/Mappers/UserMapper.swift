//
//  UserMapper.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

extension PugDTO {
    func toDomain() -> MatchmakingStanding {
        MatchmakingStanding(
            id: id,
            name: name,
            regionSlug: region.slug,
            gameSlug: game.slug,
            gameImageURL: URL(string: game.image),
            elo: elo,
            rank: rank,
            winRate: nil
        )
    }
}

extension UserDTO {
    func toDomain() -> User {
        User(
            id: id,
            name: username,
            region: region == "N/A" ? nil : region,
            avatarURL: URL(string: avatar),
            matchMaking: pugs.map { $0.toDomain() }
        )
    }
}

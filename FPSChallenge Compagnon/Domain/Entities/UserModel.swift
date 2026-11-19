//
//  UserModel.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation


struct User: Identifiable {
    let id: Int
    let name: String
    let region: String?
    let avatarURL: URL?
    let matchMaking: [MatchmakingStanding]
}

struct MatchmakingStanding: Identifiable {
    let id: Int
    let name: String
    let regionSlug: String
    let gameSlug: String
    let gameImageURL: URL?
    let elo: Int
    let rank: Int?
    let winRate: Double?
}

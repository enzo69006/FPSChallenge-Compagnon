//
//  PugDTO.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

struct PugDTO: Decodable {
    let id: Int
    let name: String
    let slug: String
    let rank: Int?
    let elo: Int
    let region: PugRegionDTO
    let game: PugGameDTO
}

struct PugRegionDTO: Decodable {
    let slug: String
}

struct PugGameDTO: Decodable {
    let slug: String
    let image: String
}

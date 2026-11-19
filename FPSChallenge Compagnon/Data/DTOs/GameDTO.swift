//
//  GameDTO.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

struct GameDTO: Decodable {
    let id: Int
    let name: String
    let slug: String
    let image: String
}

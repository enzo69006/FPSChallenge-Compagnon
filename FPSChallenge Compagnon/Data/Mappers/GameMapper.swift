//
//  GameMapper.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

extension GameDTO {
    func toDomain() -> Game {
        Game(
            id: id,
            name: name,
            slug: slug,
            imageURL: URL(string: image)
        )
    }
}

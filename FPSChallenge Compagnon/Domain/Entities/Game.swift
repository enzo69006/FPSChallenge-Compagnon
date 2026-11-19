//
//  Game.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

struct Game: Identifiable, Equatable {
    let id: Int
    let name: String
    let slug: String
    let imageURL: URL?
}

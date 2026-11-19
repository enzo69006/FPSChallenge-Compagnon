//
//  UserDTO.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation


struct UserDTO: Decodable {
    let id: Int
    let username: String
    let avatar: String
    let flag: String
    let region: String
    let pugs: [PugDTO]
}

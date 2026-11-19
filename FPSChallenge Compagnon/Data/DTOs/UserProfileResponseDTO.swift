//
//  UserProfileResponseDTO.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

struct UserProfileResponseDTO: Decodable {
    let data: UserProfileDataDTO
}

struct UserProfileDataDTO: Decodable {
    let user: UserDTO
}

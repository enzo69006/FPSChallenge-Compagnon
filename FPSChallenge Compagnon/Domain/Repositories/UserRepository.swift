//
//  UserRepository.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

protocol UserRepository {
    func fetchUser(username: String) async throws -> User
}

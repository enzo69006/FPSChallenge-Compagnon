//
//  UserRepositoryImpl.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    private let client: APIClient

    init(client: APIClient) {
        self.client = client
    }

    func fetchUser(username: String) async throws -> User {
        do {
            // 1. On demande à l'APIClient de décoder la réponse complète.
            //    Le type de la variable (UserProfileResponseDTO) lui dit quoi décoder :
            //    l'enveloppe extérieure, qui a la même forme que tout le JSON.
            //    Le chemin est un texte : "user/" + le pseudo, inséré avec \( ).
            let response: UserProfileResponseDTO = try await client.get("user/\(username)")

            // 2. On descend dans les enveloppes jusqu'au joueur (data → user),
            //    puis on le convertit en entité User avec le mapper.
            return response.data.user.toDomain()
        } catch let error as APIError {
            throw error.toDomain()
        }
    }
}

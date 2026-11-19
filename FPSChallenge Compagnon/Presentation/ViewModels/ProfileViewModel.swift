//
//  ProfileViewModel.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation
import Observation

@Observable
@MainActor
final class ProfileViewModel {
    enum State {
        case loading
        case loaded(User)
        case failed(String)
    }

    private(set) var state: State = .loading
    private let getUser: GetUserProfileUseCase

    init(getUser: GetUserProfileUseCase) {
        self.getUser = getUser
    }

    func load() async {
        state = .loading
        do {
            let user = try await getUser.execute(username: "wsx")
            state = .loaded(user)
        } catch DomainError.rateLimited {
            state = .failed("Trop de requêtes, réessaie dans une minute.")
        } catch DomainError.network {
            state = .failed("Pas de connexion internet.")
        } catch DomainError.notFound {
            state = .failed("Joueur introuvable")
        } catch {
            state = .failed("Impossible de charger l'utilisateur.")
        }
    }
}

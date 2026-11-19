//
//  GamesViewModel.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation
import Observation

@Observable
@MainActor
final class GamesViewModel {
    enum State {
        case loading
        case loaded([Game])
        case failed(String)
    }

    private(set) var state: State = .loading
    private let getGames: GetGamesUseCase

    init(getGames: GetGamesUseCase) {
        self.getGames = getGames
    }

    func load() async {
        state = .loading
        do {
            let games = try await getGames.execute()
            state = .loaded(games)
        } catch DomainError.rateLimited {
            state = .failed("Trop de requêtes, réessaie dans une minute.")
        } catch DomainError.network {
            state = .failed("Pas de connexion internet.")
        } catch {
            state = .failed("Impossible de charger les jeux.")
        }
    }
}

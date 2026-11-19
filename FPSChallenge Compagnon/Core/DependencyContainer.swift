//
//  DependencyContainer.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

final class DependencyContainer {
    private let gameRepository: any GameRepository
    private let userRepository: any UserRepository

    init() {
        let client = APIClient()
        gameRepository = GameRepositoryImpl(client: client)
        userRepository = UserRepositoryImpl(client: client)
    }

    func makeGamesViewModel() -> GamesViewModel {
        GamesViewModel(getGames: GetGamesUseCase(repository: gameRepository))
    }

    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(getUser: GetUserProfileUseCase(repository: userRepository))
    }
}

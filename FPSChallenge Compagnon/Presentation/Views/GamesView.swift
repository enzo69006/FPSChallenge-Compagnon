//
//  GamesView.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import SwiftUI

struct GamesView: View {
    @State private var viewModel: GamesViewModel

    init(viewModel: GamesViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let games):
                List(games) { game in
                    HStack(spacing: 12) {
                        AsyncImage(url: game.imageURL) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            Color.gray.opacity(0.2)
                        }
                        .frame(width: 40, height: 40)

                        Text(game.name)
                    }
                }
            case .failed(let message):
                ContentUnavailableView(message, systemImage: "wifi.exclamationmark")
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    GamesView(
        viewModel: GamesViewModel(
            getGames: GetGamesUseCase(repository: PreviewGameRepository())
        )
    )
}

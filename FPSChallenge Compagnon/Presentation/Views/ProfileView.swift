//
//  ProfileView.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import SwiftUI

struct ProfileView: View {
    @State private var viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [FPSTheme.barTop, .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            switch viewModel.state {
            case .loading:
                ProgressView()
                    .controlSize(.large)
                    .tint(FPSTheme.accent)

            case .loaded(let user):
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        ProfileHeader(user: user)
                        ProfileStats(user: user)
                        SectionTitle(text: "Solo queues")

                        ForEach(user.matchMaking) { standing in
                            StandingCard(standing: standing)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 24)
                }
                .safeAreaInset(edge: .top, spacing: 0) {
                    Color.clear
                        .frame(height: 0)
                        .background(FPSTheme.barTop.ignoresSafeArea(edges: .top))
                }

            case .failed(let message):
                ContentUnavailableView {
                    Label(message, systemImage: "exclamationmark.triangle")
                        .foregroundStyle(.white)
                } actions: {
                    Button("Réessayer") {
                        Task { await viewModel.load() }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(FPSTheme.accent)
                }
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

private struct ProfileHeader: View {
    let user: User

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: user.avatarURL) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                FPSTheme.barTop
            }
            .frame(width: 84, height: 84)
            .clipShape(ChamferedShape(cut: 14))
            .overlay {
                ChamferedShape(cut: 14)
                    .stroke(FPSTheme.accent, lineWidth: 2)
            }
            .shadow(color: FPSTheme.accent.opacity(0.5), radius: 10)

            VStack(alignment: .leading, spacing: 6) {
                Text("PROFIL JOUEUR")
                    .font(.system(size: 11, weight: .heavy).width(.condensed))
                    .tracking(2)
                    .foregroundStyle(FPSTheme.accent)

                Text(user.name)
                    .font(.system(size: 34, weight: .black).width(.condensed))
                    .foregroundStyle(.white)

                if let region = user.region {
                    Label(region, systemImage: "globe.europe.africa.fill")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(FPSTheme.inactive)
                }
            }
        }
    }
}

private struct ProfileStats: View {
    let user: User

    private var bestElo: Int? {
        user.matchMaking.map(\.elo).max()
    }

    private var bestRank: Int? {
        user.matchMaking.compactMap(\.rank).min()
    }

    var body: some View {
        HStack(spacing: 10) {
            StatTile(title: "Meilleur ELO", value: bestElo.map { "\($0)" } ?? "–")
            StatTile(title: "Meilleur rang", value: bestRank.map { "#\($0)" } ?? "–")
            StatTile(title: "Queues", value: "\(user.matchMaking.count)")
        }
    }
}

private struct StatTile: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(.system(size: 24, weight: .black).width(.condensed))
                .monospacedDigit()
                .foregroundStyle(.white)

            Text(title.uppercased())
                .font(.system(size: 10, weight: .heavy).width(.condensed))
                .tracking(1)
                .foregroundStyle(FPSTheme.inactive)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(FPSTheme.barTop, in: ChamferedShape(cut: 10))
        .overlay {
            ChamferedShape(cut: 10)
                .stroke(FPSTheme.accent.opacity(0.25), lineWidth: 1)
        }
    }
}

private struct SectionTitle: View {
    let text: String

    var body: some View {
        HStack(spacing: 10) {
            Rectangle()
                .fill(FPSTheme.accent)
                .frame(width: 3, height: 16)

            Text(text.uppercased())
                .font(.system(size: 14, weight: .heavy).width(.condensed))
                .tracking(2)
                .foregroundStyle(.white)

            Rectangle()
                .fill(FPSTheme.accent.opacity(0.25))
                .frame(height: 1)
        }
    }
}

private struct StandingCard: View {
    let standing: MatchmakingStanding

    var body: some View {
        HStack(spacing: 14) {
            AsyncImage(url: standing.gameImageURL) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Color.white.opacity(0.05)
            }
            .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: 4) {
                Text(standing.name)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.white)

                Text("\(standing.gameSlug) · \(standing.regionSlug)".uppercased())
                    .font(.system(size: 11, weight: .heavy).width(.condensed))
                    .tracking(1)
                    .foregroundStyle(FPSTheme.inactive)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("\(standing.elo)")
                    .font(.system(size: 26, weight: .black).width(.condensed))
                    .monospacedDigit()
                    .foregroundStyle(FPSTheme.accent)
                    .shadow(color: FPSTheme.accent.opacity(0.6), radius: 6)

                Text(standing.rank.map { "ELO · RANG #\($0)" } ?? "ELO")
                    .font(.system(size: 10, weight: .heavy).width(.condensed))
                    .tracking(1)
                    .foregroundStyle(FPSTheme.inactive)
            }
        }
        .padding(14)
        .background(
            LinearGradient(
                colors: [FPSTheme.barTop, FPSTheme.barBottom],
                startPoint: .top,
                endPoint: .bottom
            ),
            in: ChamferedShape(cut: 12)
        )
        .overlay {
            ChamferedShape(cut: 12)
                .stroke(FPSTheme.accent.opacity(0.3), lineWidth: 1)
        }
    }
}

#Preview {
    ProfileView(
        viewModel: ProfileViewModel(
            getUser: GetUserProfileUseCase(repository: PreviewUserRepository())
        )
    )
}

//
//  MainTabView.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import SwiftUI

enum AppTab: CaseIterable {
    case home
    case tournament
    case play
    case leaderboard
    case profile
    
    var title: String {
        switch self {
        case .home: "Home"
        case .tournament: "Tournament"
        case .play: "Play"
        case .leaderboard: "Leaderboard"
        case .profile: "Profile"
        }
        
    }
    
    var icon: String {
        switch self {
        case .home: "house.fill"
        case .tournament: "gamecontroller.fill"
        case .play: "play.fill"
        case .leaderboard: "star.fill"
        case .profile: "person.crop.circle.fill"
        }
    }
}

struct MainTabView: View {
    let container: DependencyContainer
    @State private var selectedTab: AppTab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(value: AppTab.home) {
                GamesView(viewModel: container.makeGamesViewModel())
                    .toolbar(.hidden, for: .tabBar)
            }
            Tab(value: AppTab.tournament) {
                TournamentView()
                    .toolbar(.hidden, for: .tabBar)
            }
            Tab(value: AppTab.play) {
                PlayView()
                    .toolbar(.hidden, for: .tabBar)
            }
            Tab(value: AppTab.leaderboard) {
                LeaderboardView()
                    .toolbar(.hidden, for: .tabBar)
            }
            Tab(value: AppTab.profile) {
                ProfileView()
                    .toolbar(.hidden, for: .tabBar)
            }
        }
        .safeAreaInset(edge: .bottom) {
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

struct ChamferedShape: Shape {
    var cut: CGFloat = 12

    func path(in rect: CGRect) -> Path {
        let c = min(cut, rect.width / 2, rect.height / 2)
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + c, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - c))
        path.addLine(to: CGPoint(x: rect.maxX - c, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + c))
        path.closeSubpath()
        return path
    }
}


struct CustomTabBar: View {
    @Binding var selectedTab: AppTab
    @Namespace private var animation

    var body: some View {
        HStack(spacing: 4) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                TabBarButton(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    namespace: animation
                ) {
                    withAnimation(.snappy(duration: 0.25)) {
                        selectedTab = tab
                    }
                }
            }
        }
        .padding(6)
        .background {
            ChamferedShape(cut: 16)
                .fill(
                    LinearGradient(
                        colors: [FPSTheme.barTop, FPSTheme.barBottom],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    ChamferedShape(cut: 16)
                        .stroke(
                            LinearGradient(
                                colors: [FPSTheme.accent.opacity(0.6), FPSTheme.accent.opacity(0.1)],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 1
                        )
                }
                .shadow(color: .black.opacity(0.6), radius: 16, y: 8)
        }
        .sensoryFeedback(.selection, trigger: selectedTab)
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }
}

private struct TabBarButton: View {
    let tab: AppTab
    let isSelected: Bool
    let namespace: Namespace.ID
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
                Image(systemName: tab.icon)
                    .font(.system(size: 18, weight: .semibold))
                    .scaleEffect(isSelected ? 1.1 : 1)
                    .shadow(color: isSelected ? FPSTheme.accent : .clear, radius: 6)
                    .accessibilityHidden(true)
                Text(tab.title.uppercased())
                    .font(.system(size: 10, weight: .heavy).width(.condensed))
                    .tracking(1)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .foregroundStyle(isSelected ? FPSTheme.accent : FPSTheme.inactive)
            .padding(.horizontal, 4)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background {
                if isSelected {
                    SelectionIndicator()
                        .matchedGeometryEffect(id: "selection", in: namespace)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

private struct SelectionIndicator: View {
    var body: some View {
        ChamferedShape(cut: 8)
            .fill(FPSTheme.accent.opacity(0.14))
            .overlay {
                ChamferedShape(cut: 8)
                    .stroke(FPSTheme.accent.opacity(0.7), lineWidth: 1)
            }
            .overlay(alignment: .top) {
                Rectangle()
                    .fill(FPSTheme.accent)
                    .frame(width: 20, height: 3)
                    .shadow(color: FPSTheme.accent, radius: 4)
            }
    }
}

#Preview {
    MainTabView(container: DependencyContainer())
}

//
//  FPSChallenge_CompagnonApp.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import SwiftUI

@main
struct FPSChallenge_CompagnonApp: App {
    private let container = DependencyContainer()

    var body: some Scene {
        WindowGroup {
            MainTabView(container: container)
        }
    }
}

enum FPSTheme {
    static let accent = Color(red: 0.00, green: 0.80, blue: 1.00)   // bleu électrique
    static let barTop = Color(red: 0.08, green: 0.10, blue: 0.13)
    static let barBottom = Color(red: 0.03, green: 0.04, blue: 0.06)
    static let inactive = Color.white.opacity(0.45)
}

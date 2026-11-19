//
//  DomainError.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

enum DomainError: Error {
    case notFound
    case rateLimited
    case network
    case unknown
}

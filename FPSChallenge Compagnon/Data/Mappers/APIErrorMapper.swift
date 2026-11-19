//
//  APIErrorMapper.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

extension APIError {
    func toDomain() -> DomainError {
        switch self {
        case .notFound:
            .notFound
        case .rateLimited:
            .rateLimited
        case .transport:
            .network
        case .invalidURL, .server, .decoding:
            .unknown
        }
    }
}

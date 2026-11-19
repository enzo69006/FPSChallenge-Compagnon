//
//  APIError.swift
//  FPSChallenge Compagnon
//
//  Created by Enzo Deshayes on 19/11/2026.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case transport(Error)
    case notFound
    case rateLimited
    case server(statusCode: Int)
    case decoding(Error)
}

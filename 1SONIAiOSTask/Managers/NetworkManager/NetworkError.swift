//
//  AuthError.swift
//  1SONIAiOSTask
//
//  Created by Mekhriddin Jumaev on 10/10/22.
//

import Foundation

enum NetworkError: Error {
    case invalidAuthCode
    case unableToComplete
    case invalidResponse
    case invalidData
}

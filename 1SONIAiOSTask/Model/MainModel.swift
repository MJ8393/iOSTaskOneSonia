//
//  MainModel.swift
//  1SONIAiOSTask
//
//  Created by Mekhriddin Jumaev on 10/10/22.
//

import Foundation

import Foundation

struct CharacterList: Codable {
    let results: [Character]
    let info: Info
}

struct Character: Codable {
    let name: String
    let status: String
    let location: Location
    let image: String?
}

struct Location: Codable {
    let name: String
}

struct Info: Codable {
    let next: String?
}

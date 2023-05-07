//
//  PersonModel.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 07.05.2023.
//

import Foundation

struct PersonModel: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String?
    let url: String
    let episodes: [String]?
    let origin: Place?
    let location: Place?
    
    struct Place: Decodable, Hashable {
        let name: String
    }
}

extension PersonModel: Hashable {
    static func == (lhs: PersonModel, rhs: PersonModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

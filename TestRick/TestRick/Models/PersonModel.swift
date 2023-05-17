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
    let episode: [String]?
    let origin: Place?
    let location: Place?
    
    struct Place: Decodable, Hashable {
        let name: String
    }
    
    init(object: PersonItem) {
        self.id = object.personId
        self.name = object.name
        self.status = object.status
        self.species = object.species
        self.type = object.type
        self.gender = object.gender
        self.image = object.image
        self.url = object.url
        self.episode = Array(object.episode)
        self.origin = Place(name: object.placeOrigin ?? "")
        self.location = Place(name: object.placeLocation ?? "")
    }
}

extension PersonModel: Hashable {
    static func == (lhs: PersonModel, rhs: PersonModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

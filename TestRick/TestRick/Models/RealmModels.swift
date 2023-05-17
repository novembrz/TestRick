//
//  RealmModels.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 14.05.2023.
//

import RealmSwift

final class PersonItem: Object, ObjectKeyIdentifiable {
    @Persisted var personId: Int
    @Persisted var name: String
    @Persisted var status: String
    @Persisted var species: String
    @Persisted var type: String
    @Persisted var gender: String
    @Persisted var image: String?
    @Persisted var url: String
    @Persisted var episode = List<String>()
    @Persisted var placeOrigin: String?
    @Persisted var placeLocation: String?
    
    override class func primaryKey() -> String? {
        "personId"
    }
    
    override init() {}
    
    init(personId: Int, name: String, status: String, species: String, type: String, gender: String, image: String? = nil, url: String, episode: [String]?, placeOrigin: String? = nil, placeLocation: String? = nil) {
        
        let _episode = List<String>()
        if let episode = episode {
            _episode.append(objectsIn: episode)
        }
        
        self.personId = personId
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.image = image
        self.url = url
        self.episode = _episode
        self.placeOrigin = placeOrigin
        self.placeLocation = placeLocation
    }
}

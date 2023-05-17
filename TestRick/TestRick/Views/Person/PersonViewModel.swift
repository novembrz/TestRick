//
//  PersonViewModel.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 12.05.2023.
//

import SwiftUI
import RealmSwift

extension PersonView {
    @MainActor class PersonViewModel: ObservableObject {

        let realmService = RealmService()
        @Published var personItem: PersonItem?

        
        var columns: [GridItem] = Array(repeating: .init(.flexible(maximum: UIScreen.main.bounds.width / 2), spacing: 10, alignment: .topLeading), count: 2)
        
        func checksIsItFavourite(_ personId: Int) {
            personItem = realmService.get(type: PersonItem.self, primaryKey: personId)
        }

        func tappedToFavourite(person: PersonModel) {
            if let personItem = personItem {
                realmService.delete(object: personItem)
                self.personItem = nil
            } else {
                realmService.add(object: PersonItem(
                        personId: person.id,
                        name: person.name,
                        status: person.status,
                        species: person.species,
                        type: person.type,
                        gender: person.gender,
                        image: person.image,
                        url: person.url,
                        episodes: person.episodes,
                        placeOrigin: person.origin?.name,
                        placeLocation: person.location?.name
                    )
                )
                personItem = realmService.get(type: PersonItem.self, primaryKey: person.id)
            }
       }
    }
}

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

        @Published var personItem: PersonItem?
        private let realmService = RealmService() //lazy // common service for all services with protocol

        var columns: [GridItem] = Array(repeating: .init(.flexible(maximum: UIScreen.main.bounds.width / 2), spacing: 10, alignment: .topLeading), count: 2)
        
        func getPersonItem(_ personId: Int) {
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
                        episode: person.episode,
                        placeOrigin: person.origin?.name,
                        placeLocation: person.location?.name
                    )
                )
                personItem = realmService.get(type: PersonItem.self, primaryKey: person.id)
            }
       }
    }
}

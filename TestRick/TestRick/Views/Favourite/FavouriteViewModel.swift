//
//  FavouriteViewModel.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 12.05.2023.
//

import SwiftUI
import RealmSwift

extension FavoriteView {
    @MainActor class FavoriteViewModel: ObservableObject {
        let realmService = RealmService()
        @Published var persons: [PersonModel] = []
        
        func getPersons() {
            let items = Array(realmService.getAll(type: PersonItem.self))
            
            for i in items {
                let person = PersonModel(object: i)
                persons.append(person)
            }
        }
    }
}

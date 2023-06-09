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
        
        private let realmService = RealmService()
        @Published var persons: [PersonModel] = []
        
        func getPersons() {
            persons = realmService.getAll(type: PersonItem.self).map { PersonModel(object: $0) }
        }
    }
}

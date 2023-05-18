//
//  SearchViewModel.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 07.05.2023.
//

import SwiftUI


extension SearchView {
    @MainActor class SearchViewModel: ObservableObject {
        private let service = NetworkService()
        
        @Published var persons: [PersonModel] = []
        @Published var fetchPersons: [PersonModel] = []
        @Published var searchText: String = ""

        var nextPage: String?
        var isSearching = false
        
        //MARK: - Fetch

        func getPersons() {
            Task {
                try? await fetchData()
            }
        }

        @MainActor
        private func fetchData() async throws {
            if let infoData = try await service.fetchData(
                urlString: (nextPage == nil ? .urlString : nextPage)!,
                model: InfoModel.self
            ) {
                self.fetchPersons += infoData.results
                self.persons = fetchPersons
                self.nextPage = infoData.info.next
            }
        }
        
        
        //MARK: - Search

        func searchPersons(_ text: String) {
            Task {
                try? await fetchSearchData(text)
            }
        }
        
        @MainActor
        private func fetchSearchData(_ text: String) async throws {
            guard !text.isEmpty else {
                self.persons = fetchPersons
                self.isSearching = false
                return
            }
            self.isSearching = true
            
            if let infoData = try await service.fetchData(
                urlString: .nameUrlString+text,
                model: InfoModel.self
            ) {
                self.persons = infoData.results
            }
        }
    }
}


//MARK: - Extensions

private extension String {
    static let urlString = "https://rickandmortyapi.com/api/character"
    static let nameUrlString = "https://rickandmortyapi.com/api/character/?name="
}

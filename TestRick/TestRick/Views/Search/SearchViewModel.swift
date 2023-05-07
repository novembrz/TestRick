//
//  SearchViewModel.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 07.05.2023.
//

import SwiftUI

enum LoadPage {
    case loading, refreshing
}

extension SearchView {
    @MainActor class SearchViewModel: ObservableObject {
        private let service = NetworkService()
        
        @Published var persons: [PersonModel] = []
        @Published var searchText: String = ""
        
        let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: .columnSpacing), count: .columnCount)
        
        
        //MARK: - Fetch

        
        func getPersons() {
            Task {
                try? await fetchData()
            }
        }
        
        @MainActor
        private func fetchData() async throws {
            if let infoData = try await service.fetchData(
                urlString: "https://rickandmortyapi.com/api/character",
                model: InfoModel.self
            ) {
                self.persons = infoData.results
            }
        }
    }
}


//MARK: - Extensions

private extension CGFloat {
    static let columnSpacing: CGFloat = 18
}

private extension Int {
    static let columnCount = 3
}

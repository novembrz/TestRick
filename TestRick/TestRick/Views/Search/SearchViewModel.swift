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

        var nextPage: String? = ""
        
        let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: .columnSpacing, alignment: .top), count: .columnCount)
        
        
        //MARK: - Fetch

        
        func getPersons() {
            Task {
                try? await fetchData()
            }
        }

        @MainActor
        private func fetchData() async throws {
            guard nextPage != nil else { return }
            
            if let infoData = try await service.fetchData(
                urlString: (nextPage == "" ? .urlString : nextPage)!,
                model: InfoModel.self
            ) {
                self.persons += infoData.results
                self.nextPage = infoData.info.next
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

private extension String {
    static let urlString = "https://rickandmortyapi.com/api/character"
}

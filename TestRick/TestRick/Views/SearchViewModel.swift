//
//  SearchViewModel.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 07.05.2023.
//

import SwiftUI

extension SearchView {
    @MainActor class SearchViewModel: ObservableObject {
        @Published var persons: [PersonModel] = []
        @Published var searchText: String = ""
        
        let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: .columnSpacing), count: .columnCount)
        
        func getPersons() {
            
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

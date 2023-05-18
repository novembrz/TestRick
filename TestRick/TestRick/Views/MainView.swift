//
//  ContentView.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 07.05.2023.
//

import SwiftUI

struct MainView: View {
    
    let realmService = RealmService()
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: .searchIconName)
                    Text(String.searchTitle)
                }
            
            FavoriteView(viewModel: FavoriteView.FavoriteViewModel(realmService: realmService))
                .tabItem {
                    Image(systemName: .favoriteIconName)
                    Text(String.favoriteTitle)
                }
        }
        .accentColor(.green)
    }
}

//MARK: - Extensions

private extension String {
    static let searchTitle = "Search"
    static let favoriteTitle = "Favorite"
    static let searchIconName = "magnifyingglass"
    static let favoriteIconName = "heart"
}

//MARK: - Previews

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

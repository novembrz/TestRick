//
//  FavoriteView.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 07.05.2023.
//

import SwiftUI
import RealmSwift

struct FavoriteView: View {
    
    @StateObject var viewModel = FavoriteViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.persons.isEmpty {
                    GridView(persons: viewModel.persons) { _ in }
                }
            }
            .padding(.horizontal, .horizontalPadding)
            .navigationTitle(String.title)
            .background(Color.background(), ignoresSafeAreaEdges: .all)
            .onAppear {
                viewModel.getPersons()
            }
            .onChange(of: viewModel.persons) { _ in
                viewModel.persons = []
                viewModel.getPersons()
            }
        }
    }
}
//MARK: - Extensions

private extension CGFloat {
    static let horizontalPadding: CGFloat = 20
}

private extension String {
    static let title = "Favourite"
}

//MARK: - Priviews

//struct FavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteView()
//    }
//}

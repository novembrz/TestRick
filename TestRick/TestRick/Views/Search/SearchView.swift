//
//  SearchView.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 07.05.2023.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: .verticalSpacing) {
                searchView
                GridView(persons: viewModel.persons) { isLast in
                    if isLast && !viewModel.isSearching {
                        viewModel.getPersons()
                    }
                }
            }
            .padding(.horizontal, .horizontalPadding)
            .navigationTitle(String.title)
            .background(Color.background(), ignoresSafeAreaEdges: .all)
            .onAppear {
                viewModel.getPersons()
            }
            .onChange(of: viewModel.searchText) { newValue in
                viewModel.searchPersons(newValue)
            }
        }
    }
    
    //MARK: - SearchView

    var searchView: some View {
        TextField(String.placeholder, text: $viewModel.searchText)
            .disableAutocorrection(true)
            .font(.system(size: .searchSize, weight: .regular))
            .foregroundColor(.black)
            .accentColor(.green)
            .padding(.vertical, .searchVerticalPadding)
            .padding(.horizontal, .searchHorizonralPadding)
            .background(Color.search().opacity(.colorOpacity))
            .cornerRadius(.seachRadius)
            .overlay {
                xmarkButtonAndIcon
            }
    }
    
    var xmarkButtonAndIcon: some View {
        HStack {
            Image(systemName: .searchIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: .searchSize)
                .foregroundColor(viewModel.searchText != "" ? .black : Color.search().opacity(.iconColorOpacity))
            
            Spacer()
            
            if viewModel.searchText != "" {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: .xmark)
                        .padding(.vertical)
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.horizontal, .searchIconsPadding)
        .foregroundColor(.black)
    }
}

//MARK: - Extensions

private extension CGFloat {
    static let searchSize: CGFloat = 16
    static let searchVerticalPadding: CGFloat = 7
    static let searchHorizonralPadding: CGFloat = 29
    static let searchIconsPadding: CGFloat = 8
    static let seachRadius: CGFloat = 10
    
    static let horizontalPadding: CGFloat = 20
    static let verticalSpacing: CGFloat = 26
}

private extension Double {
    static let colorOpacity: CGFloat = 0.2
    static let iconColorOpacity: CGFloat = 0.5
}

private extension String {
    static let title = "Rickipedia"
    static let placeholder = "Поиск"
    static let searchIconName = "magnifyingglass"
    static let xmark = "xmark.circle"
}

//MARK: - Priviews

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

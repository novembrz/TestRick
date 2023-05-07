//
//  SearchView.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 07.05.2023.
//

import SwiftUI

struct SearchView: View {
    let persons = ["Picture", "Picture 1", "Picture 2", "Picture 3"]
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: .columnSpacing), count: .columnCount)
    
    var body: some View {
        NavigationView {
            LazyVGrid(columns: columns, spacing: .rowSpacing) {
                ForEach(persons, id: \.self) { person in
                    VStack {
                        Image(person)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: .imageHeight)
                            .frame(minWidth: .minWidth, maxWidth: .maxWidth, alignment: .center)
                            .clipped()
                            .cornerRadius(.cornerRadius)
                        
                        Text(person)
                            .foregroundColor(.black)
                            .font(.system(size: .textSize, weight: .regular))
                    }
                }
            }
            .padding(.horizontal, .horizontalPadding)
            .navigationTitle(String.title)
            .background(Color(.colorName), ignoresSafeAreaEdges: .all)
        }
    }
}

//MARK: - Extensions

private extension CGFloat {
    static let rowSpacing: CGFloat = 23
    static let columnSpacing: CGFloat = 18
    static let imageHeight: CGFloat = 145
    static let minWidth: CGFloat = 90
    static let maxWidth: CGFloat = 125
    static let cornerRadius: CGFloat = 15
    static let textSize: CGFloat = 12
    static let horizontalPadding: CGFloat = 20
}
    
private extension Int {
    static let columnCount = 3
}

private extension String {
    static let colorName = "BackgroundColor"
    static let title = "Rickipedia"
}

//MARK: - Priviews

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

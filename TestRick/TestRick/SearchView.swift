//
//  SearchView.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 07.05.2023.
//

import SwiftUI

struct SearchView: View {
    let persons = ["Picture", "Picture 1", "Picture 2", "Picture 3"]
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 18), count: 3)
    
    var body: some View {
        NavigationView {
            LazyVGrid(columns: columns, spacing: 23) {
                ForEach(persons, id: \.self) { person in
                    VStack {
                        Image(person)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 145)
                            .frame(minWidth: 90, maxWidth: 125, alignment: .center)
                            .clipped()
                            .cornerRadius(15)
                        
                        Text(person)
                            .foregroundColor(.black)
                            .font(.system(size: 12, weight: .regular))
                    }
                }
            }
            .padding(.horizontal, 20)
            .navigationTitle("Rickipedia")
            .background(Color("BackgroundColor"), ignoresSafeAreaEdges: .all)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

//
//  GridView.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 12.05.2023.
//

import SwiftUI

struct GridView: View {
    
    var persons: [PersonModel]
    var completion: ((Bool) -> Void)
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: .columnSpacing, alignment: .top), count: .columnCount)
    
    
    var body: some View {
        ScrollView {
           LazyVGrid(columns: columns, spacing: .rowSpacing) {
                ForEach(0..<persons.count, id: \.self) { index in
                    CardView(
                        persons[index],
                        isLast: index == persons.count - 1
                    )
                }
            }
        }
    }
    
    @ViewBuilder
    func CardView(_ person: PersonModel, isLast: Bool) -> some View {
        NavigationLink {
            PersonView(person: person)
        } label: {
            VStack {
                if let image = person.image, let url =  URL(string: image) {
                    ImageView(url: url)
                } else {
                    ProgressView()
                }
                
                Text(person.name)
                    .font(.system(size: .textSize, weight: .regular))
                    .multilineTextAlignment(.center)
            }
            .onAppear {
                completion(isLast)
            }
        }
    }
    
    @ViewBuilder
    func ImageView(url: URL) -> some View {
        CacheAsyncImage(url: url) { phase in
            switch phase {
            case .empty, .failure(_):
                ProgressView()
            case .success(let image):
                image.resizable()
            @unknown default:
                fatalError()
            }
        }
        .aspectRatio(contentMode: .fill)
        .frame(height: .imageHeight)
        .frame(minWidth: .minWidth, maxWidth: .maxWidth, alignment: .top)
        .clipped()
        .cornerRadius(.itemCornerRadius)
    }
}

//MARK: - Extensions

private extension CGFloat {
    static let rowSpacing: CGFloat = 23
    static let columnSpacing: CGFloat = 18
    static let imageHeight: CGFloat = 145
    static let minWidth: CGFloat = 90
    static let maxWidth: CGFloat = 125
    static let itemCornerRadius: CGFloat = 15
    static let textSize: CGFloat = 12
}

private extension Int {
    static let columnCount = 3
}

//MARK: - Previews

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

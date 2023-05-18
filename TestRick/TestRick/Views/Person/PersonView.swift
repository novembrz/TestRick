//
//  PersonView.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 12.05.2023.
//

import SwiftUI
import RealmSwift

struct PersonView: View {
    @StateObject var viewModel = PersonViewModel()
    let person: PersonModel
        
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                avatarView
                titleView
                contentView
            }
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color.background(), ignoresSafeAreaEdges: .all)
        .toolbar {
            favouriteButton
        }
        .onAppear {
            viewModel.checksIsItFavourite(person.id)
        }
    }
    
    //MARK: - avatarView
    
    var avatarView: some View {
        VStack {
            GeometryReader { reader in
                AsyncImage(url: URL(string: person.image ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: reader.frame(in: .global).maxY + 660) // parallax
            }
            .frame(height: 450)
        }
    }
    
    //MARK: - favouriteButton
    
    var favouriteButton: some View {
        Button {
            viewModel.tappedToFavourite(person: person)
        } label: {
            Image(systemName: viewModel.personItem != nil ? "heart.fill" : "heart")
                .foregroundColor(.green)
        }
    }
    
    //MARK: - titleView
    
    var titleView: some View {
        Text(person.name)
            .font(.system(size: 36, weight: .bold))
            .offset(y: 110)
            .frame(width: 218, alignment: .leading)
            .padding(.horizontal, .horizontalSpacing)
    }
    
    //MARK: - contentView
    
    var contentView: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 50) {
                infoView
                locationView
                episodesView
            }
            .padding(.top, 23)
            .padding(.bottom, 150)
            .background(Color.background())
            
            .cornerRadius(25)
        }
        .offset(y: 90)
    }
    
    //MARK: - avatarView
        
    var infoView: some View {
        VStack(alignment: .leading, spacing: .titleSpacing) {
            HStack {
                Text(String.infoTitle)
                    .font(.system(size: .titleTextSize, weight: .bold))
                
                Spacer()
                
                Text(person.status)
                    .font(.system(size: 20, weight: .regular))
            }

            LazyVGrid(columns: viewModel.columns, alignment: .leading, spacing: 20) {
                TextWithIcon(iconName: "Marsian", text: person.species)
                TextWithIcon(iconName: "Face", text: person.gender)
                TextWithIcon(iconName: "Galaxy", text: person.type)
            }
        }
        .padding(.horizontal, .horizontalSpacing)
    }
    
    @ViewBuilder
    func TextWithIcon(iconName: String, text: String) -> some View {
        HStack(spacing: 9) {
            Image(iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 23)
            
            Text(text == "" ? "???" : text)
                .font(.system(size: 20, weight: .regular))
        }
    }
    
    //MARK: - location
    
    var locationView: some View {
        VStack(alignment: .leading, spacing: .titleSpacing) {
            Text(String.locationTitle)
                .font(.system(size: .titleTextSize, weight: .bold))
            
            if let location = person.location?.name {
                Location(title: .lastLocation, place: location)
            }
            
            if let origin = person.origin?.name {
                Location(title: .originLocation, place: origin)
            }
        }
        .padding(.horizontal, .horizontalSpacing)
    }
    
    @ViewBuilder
    func Location(title: String, place: String) -> some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(title)
                .font(.system(size: 18, weight: .light))
            
            Text(place)
                .font(.system(size: 20, weight: .medium))
        }
    }
    
    //MARK: - episodes
    
    var episodesView: some View {
        VStack(alignment: .leading, spacing: .titleSpacing) {
            if let episodes = person.episode {
                Text(String.episodesTitle)
                    .font(.system(size: .titleTextSize, weight: .bold))
                    .padding(.horizontal, 21)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 13) {
                        ForEach(episodes, id: \.self) { episode in
                            Episode(episode.deletingPrefix(.episodeUrl))
                        }
                    }
                    .padding(.horizontal, .horizontalSpacing)
                }
            }
        }
    }
    
    @ViewBuilder
    func Episode(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 16, weight: .regular))
            .padding(.horizontal, 24)
            .padding(.vertical, 5)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 1)
                    .frame(height: 25)
            }
    }
}

//MARK: - Extensions

private extension String {
    static let infoTitle = "Information"
    static let locationTitle = "Locations"
    static let episodesTitle = "Episodes"
    static let lastLocation = "Last known location"
    static let originLocation = "First seen in:"
    static let episodeUrl = "https://rickandmortyapi.com/api/episode/"
}

private extension CGFloat {
    static let titleSpacing: CGFloat = 20
    static let titleTextSize: CGFloat = 24
    static let horizontalSpacing: CGFloat = 21
}


//MARK: - Previews

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

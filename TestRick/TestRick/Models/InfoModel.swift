//
//  InfoModel.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 07.05.2023.
//

import Foundation

struct InfoModel: Decodable {
    let info: Info
    let results: [PersonModel]
    
    struct Info: Decodable {
        let next: String?
    }
}

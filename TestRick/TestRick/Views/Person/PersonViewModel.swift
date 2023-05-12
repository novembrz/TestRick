//
//  PersonViewModel.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 12.05.2023.
//

import SwiftUI

extension PersonView {
    @MainActor class PersonViewModel: ObservableObject {
        var columns: [GridItem] = Array(repeating: .init(.flexible(maximum: UIScreen.main.bounds.width / 2), spacing: 10, alignment: .topLeading), count: 2)
    }
}

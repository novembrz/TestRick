//
//  String + Extensions.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 17.05.2023.
//

import Foundation

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

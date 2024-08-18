//
//  Herb.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 17/08/2024.
//

import Foundation

struct Herb: Codable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let detail: String
    let imageSource: URL
}

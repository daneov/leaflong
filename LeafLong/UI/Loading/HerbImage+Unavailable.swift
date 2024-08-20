//
//  HerbImage+Unavailable.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 19/08/2024.
//

import Foundation
import SwiftUI
import UIKit

extension Image {
    static var unavailable: Data? {
        return UIImage(resource: .herbIconFallback).pngData()
    }
}

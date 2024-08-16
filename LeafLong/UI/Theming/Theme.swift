//
//  Color+Hex.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 16/08/2024.
//

import SwiftUI

protocol Theme {
    var primaryColor: Color { get }
    var secondaryColor: Color { get }
    
    var largeTitleFont: Font { get }
    var normalTitleFont: Font { get }
    var captionFont: Font { get }
}

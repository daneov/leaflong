//
//  MainTheme.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 16/08/2024.
//

import Foundation
import SwiftUI

struct MainTheme: Theme {
    var primaryColor: Color {
        .init("Chestnut")
    }
    
    var secondaryColor: Color {
        .init("Apple")
    }
    
    var backgroundColor: Color {
        .init("Cream")
    }
    
    var largeTitleFont: Font {
        .custom("Lora-Regular_SemiBold", size: 32)
    }
    
    var normalTitleFont: Font {
        .custom("Lora-Regular_SemiBold", size: 24)
    }
    
    var captionFont: Font {
        .custom("Lora-Regular", size: 12)
    }
    
}

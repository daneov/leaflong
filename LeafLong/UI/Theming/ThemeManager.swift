//
//  ThemeManager.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 16/08/2024.
//

import Foundation

class ThemeManager: ObservableObject {
    @Published var selectedTheme = ThemeManager.main
}

extension ThemeManager {
    static var main: MainTheme {
        return MainTheme()
    }
}

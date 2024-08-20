//
//  ThemedView.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 16/08/2024.
//

import Combine
import SwiftUI

protocol ThemedView {
    var themeManager: ThemeManager { get }
}

extension ThemedView {
    var theme: Theme {
        return self.themeManager.selectedTheme
    }
}

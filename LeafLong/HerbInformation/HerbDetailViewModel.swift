//
//  HerbDetailViewModel.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 16/08/2024.
//

import SwiftUI

/// This serves as ViewModel for `HerbDetailView`.
///
final class HerbDetailViewModel: ObservableObject {
    @Published var name: String
    @Published var detail: String
    
    /// Construct the ViewModel
    /// Parameters:
    ///   - name: The name of the herb. First letter will be capitalized
    ///   - detail: Detailed information about the herb. Currently only supports flat text, no styling.
    init(name: String, detail: String) {
        self.name = name.firstCapitalized
        self.detail = detail.firstCapitalized
    }
}

internal extension HerbDetailViewModel {
    /// Will look up the image in the Bundle based on the lowercases name
    /// Returns: an `ImageResource` representing the image
    var image: ImageResource {
        return ImageResource(name: self.name.lowercased(), bundle: .main)
    }
}

extension StringProtocol {
    /// The first letter in the `name` property will be capitalized using the Locale. Other parts of the string will be unaltered.
    var firstCapitalized: String {
        prefix(1).capitalized(with: Locale.current) + dropFirst()
    }
}

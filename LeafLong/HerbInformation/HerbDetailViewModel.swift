//
//  HerbDetailViewModel.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 16/08/2024.
//

import SwiftUI
import Combine

/// This serves as ViewModel for `HerbDetailView`.
///
final class HerbDetailViewModel: ObservableObject {
    @Published private(set) var name: String
    @Published private(set) var detail: String
    @Published private(set) var imageURL: URL
    
    private let sourceURL: URL

    /// Construct the ViewModel
    /// Parameters:
    ///   - name: The name of the herb. First letter will be capitalized
    ///   - detail: Detailed information about the herb. Currently only supports flat text, no styling.
    init(name: String, detail: String, imageURL: URL) {
        self.name = name.firstCapitalized
        self.detail = detail.firstCapitalized
        self.sourceURL = imageURL
        self.imageURL = imageURL
    }
}

extension HerbDetailViewModel {
    ///
    func loadImage() {
        sourceURL
            .convertToDataURL()
            .compactMap { $0 }
            .delay(for: 2, scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .assign(to: &$imageURL)
    }
}

extension StringProtocol {
    /// The first letter in the `name` property will be capitalized using the Locale. Other parts of the string will be unaltered.
    var firstCapitalized: String {
        prefix(1).capitalized(with: Locale.current) + dropFirst()
    }
}

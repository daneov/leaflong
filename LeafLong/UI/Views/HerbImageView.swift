//
//  HerbImageView.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 15/08/2024.
//

import SwiftUI

struct HerbImageView: ThemedView, View {
    @EnvironmentObject var themeManager: ThemeManager
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay {
                Circle().stroke(theme.primaryColor.opacity(0.8), lineWidth: 5)
            }
            .shadow(radius: 5)
            .background(theme.primaryColor)
            .clipShape(Circle())
    }
}

#Preview {
    HerbImageView(image: Image("garlic")).environmentObject(ThemeManager())
}

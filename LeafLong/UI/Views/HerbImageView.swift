//
//  HerbImageView.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 15/08/2024.
//

import Foundation
import SwiftUI

struct HerbImageView: ThemedView, View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.displayScale) var scale
    
    var imageURL: URL
    
    var body: some View {
        AsyncImage(url: imageURL, scale: scale) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay {
                    Circle().stroke(theme.primaryColor.opacity(0.8), lineWidth: 5)
                }
                .shadow(radius: 5)
                .background(theme.primaryColor)
                .clipShape(Circle())
                .environmentObject(themeManager)
        } placeholder: {
            LoadingLeaf().environmentObject(themeManager)
        }
    }
}

#Preview {
    HerbImageView(imageURL: URL(string: "https://imgv3.fotor.com/images/gallery/cartoon-character-generated-by-Fotor-ai-art-creator.jpg")!)
        .environmentObject(ThemeManager())
}

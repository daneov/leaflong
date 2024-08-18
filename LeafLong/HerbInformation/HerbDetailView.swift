//
//  HerbDetailView.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 16/08/2024.
//

import SwiftUI

struct HerbDetailView: View, ThemedView {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var viewModel: HerbDetailViewModel
    
    private(set) var shouldShowVertically = false
    
    var body: some View {
        containerView {
            HerbImageView(imageURL: viewModel.imageURL)
                .padding(.leading, 5)
                .frame(width: 150, height: 150)
            
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(theme.normalTitleFont)
                Text(viewModel.detail)
                    .font(theme.captionFont)
                    .multilineTextAlignment(.leading)
                    .font(.caption)
                    .padding(.top, 5)
                    .padding([.bottom])
            }
                .padding(.top, 5)
                .frame(maxHeight: 150)
            Spacer()
        }
        .padding(.top, 10)
        .padding(.bottom, 5)
        .onAppear {
            viewModel.loadImage()
        }
    }
    
    private var containerView: AnyLayout {
        if self.shouldShowVertically {
            return AnyLayout(VStackLayout(alignment: .leading))
        } else {
            return AnyLayout(HStackLayout(alignment: .top))
        }
    }
}

#Preview("Horizontal"){
    let viewModel = HerbDetailViewModel(name: "garlic", detail: "What a tasty herb!", imageURL: URL(string: "https://www.techsmith.com/blog/wp-content/uploads/2022/03/resize-image.png")!)
    return HerbDetailView(viewModel: viewModel)
        .environmentObject(ThemeManager())
}

#Preview("Vertical") {
    let viewModel = HerbDetailViewModel(name: "garlic", detail: "What a tasty herb!", imageURL: URL(string: "https://www.techsmith.com/blog/wp-content/uploads/2022/03/resize-image.png")!)
    return HerbDetailView(viewModel: viewModel, shouldShowVertically: true)
        .environmentObject(ThemeManager())
}

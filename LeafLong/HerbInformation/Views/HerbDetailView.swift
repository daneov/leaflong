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
    
    var body: some View {
        HStack(alignment: .top){
            HerbImageView(image: Image(viewModel.image))
                .padding(.leading, 5)
                .frame(minWidth: 100, idealWidth: 150, maxWidth: 150)

            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(theme.normalTitleFont)
                    .padding(.top, 15)
                    .padding(.bottom, 5)
                Text(viewModel.detail)
                    .font(theme.captionFont)
                    .multilineTextAlignment(.leading)
                    .font(.caption)
            }
            Spacer()
        }
    }
}

#Preview {
    let viewModel = HerbDetailViewModel(name: "garlic", detail: "What a tasty herb!")
    return HerbDetailView(viewModel: viewModel)
        .environmentObject(ThemeManager())
}

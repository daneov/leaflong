//
//  ContentView.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 10/08/2024.
//

import SwiftUI

struct HomeView: View, ThemedView {
    @StateObject var themeManager = ThemeManager()
    @ObservedObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            switch homeViewModel.state {
            case .idle:
                Color.clear.onAppear(perform: {
                    homeViewModel.load()
                })
            case .loading:
                Spacer()
                LoadingLeaf().environmentObject(themeManager)
            case .failed(let err):
                Text("Failed to load image :( \(err)")
            case .loaded(let herb):
                let targetViewModel = generateTargetViewModel(herb: herb)
                HerbDetailView(viewModel: targetViewModel)
                    .environmentObject(themeManager)
                    .frame(maxHeight: 300)
            }
            Spacer()
        }
    }
}

extension HomeView {
    func generateTargetViewModel(herb: Herb) -> HerbDetailViewModel {
        return HerbDetailViewModel(
            name: herb.name,
            detail: herb.detail,
            imageURL: herb.imageSource
        )
    }
}

#Preview {
    HomeView().environmentObject(ThemeManager())
}

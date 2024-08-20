//
//  HomeViewModel.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 17/08/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    @Published private(set) var imageCached = false
    
    enum StateError: Error {
        case cancelled
    }
    enum State: Equatable {
        static func == (lhs: HomeViewModel.State, rhs: HomeViewModel.State) -> Bool {
            if case let .failed(err) = lhs, case let .failed(err2) = rhs {
                return err.localizedDescription == err2.localizedDescription
            }
            
            return lhs == rhs
        }
        
        case idle
        case loading
        case failed(StateError)
        case loaded(Herb)
    }
    
    func load(herbFetcher: HerbModelFetcher = HerbModelController()) {
        state = .loading
        
        herbFetcher.fetchHerbOfTheDay()
            .map({ herb -> State in
                .loaded(herb)
            })
            .receive(on: DispatchQueue.main)
            .assign(to: &$state)
    }
}

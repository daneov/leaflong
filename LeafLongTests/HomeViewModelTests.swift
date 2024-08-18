//
//  HerbModelControllerTests.swift
//  LeafLongTests
//
//  Created by Daneo Van Overloop on 17/08/2024.
//

import XCTest
import Combine
@testable import LeafLong

final class HerbModelControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRetrievesHerbOfTheDay() throws {
        struct Fetcher: HerbModelFetcher {
            let expectedHerb = Herb(
                id: UUID(),
                name: "Herbzies",
                detail: "What's in a detail",
                imageSource: URL(string: "https://www.google.com")!
            )
            
            func fetchHerbOfTheDay() -> AnyPublisher<LeafLong.Herb, Never> {
                return Just(expectedHerb).eraseToAnyPublisher()
            }
        }
        
        let fetcher = Fetcher()
        let viewModel = HomeViewModel()
        viewModel.load(herbFetcher: fetcher)
        XCTAssertEqual(viewModel.state, .loaded(fetcher.expectedHerb))
    }

}

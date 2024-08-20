//
//  HerbDetailViewModelTests.swift
//  LeafLongTests
//
//  Created by Daneo Van Overloop on 16/08/2024.
//

import XCTest
@testable import LeafLong

final class HerbDetailViewModelTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testReflectsTheCorrectName() throws {
        let expectedName = "Garlic"
        let viewModel = HerbDetailViewModel(name: "garlic", detail: "", imageURL: URL(string: "https://www.google.com")!)
        
        XCTAssertEqual(viewModel.name, expectedName)
    }
    
    
}

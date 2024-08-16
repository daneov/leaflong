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

    func testChosesTheCorrectImage() throws {
        let expectedImage = ImageResource(name: "garlic", bundle: .main)
        let expectedName = "Garlic"
        
        let viewModel = HerbDetailViewModel(name: "garlic", detail: "")
        XCTAssertEqual(viewModel.name, expectedName)
        XCTAssertEqual(viewModel.image, expectedImage)
        XCTAssertNotNil(viewModel.image)
    }
}

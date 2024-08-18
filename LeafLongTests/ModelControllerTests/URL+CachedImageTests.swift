//
//  URL+CachedImageTests.swift
//  LeafLongTests
//
//  Created by Daneo Van Overloop on 19/08/2024.
//

import Combine
import XCTest
@testable import LeafLong

extension XCTestCase {
    func loadEmptyImage() throws -> Data {
        return try XCTUnwrap(Data(base64Encoded: "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVQYV2NgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII="))
        
    }
}

final class URL_CachedImageTests: XCTestCase {
    private var mockSession: URLSession!
    private var emptyImage: Data!
    private var successfulResponse: URLResponse!
    private var sourceURL: URL!
    
    override func setUp() async throws {
        emptyImage = try loadEmptyImage()
        sourceURL = try XCTUnwrap("https://some.tld/image".toURL())
        successfulResponse = try XCTUnwrap(HTTPURLResponse(url: sourceURL, statusCode: 200, httpVersion: nil, headerFields: nil))
        mockSession = generateSession(mocks: [
            sourceURL: (emptyImage, successfulResponse)
        ])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUsesCorrectFallbackImage() throws {
        let failedReponse = try XCTUnwrap(HTTPURLResponse(url: sourceURL, statusCode: 404, httpVersion: nil, headerFields: nil))
        mockSession = generateSession(mocks: [sourceURL: (Data("some".utf8), failedReponse)])
        
        let source = sourceURL.convertToDataURL(session: mockSession)
        let got = try awaitPublisher(source).absoluteString.deleting(prefix: URL.cachedURLPrefix)
        let encodedImage = UIImage(resource: ImageResource.herbIconFallback).pngData()?.base64EncodedString()
        let expected = try XCTUnwrap(encodedImage)
        XCTAssertEqual(got, expected, "Expected images to be equal")
    }
    
    func testCorrectlyTransformsImage() throws {
        let response = try awaitPublisher(sourceURL.convertToDataURL(session: mockSession))
        
        let got = response.absoluteString.deleting(prefix: "data:image/png;base64,")
        let expected = emptyImage.base64EncodedString()
        XCTAssertEqual(got, expected, "Expected images to be equal")
    } 
    
    func testInsertsCachingPrefix() throws {
        let response = try awaitPublisher(sourceURL.convertToDataURL(session: mockSession))
        let got = response.absoluteString
        XCTAssertTrue(got.hasPrefix(URL.cachedURLPrefix))
    }
    
    func testCachesImageInURL() throws {
        XCTAssertEqual(URL.cachedURLPrefix, "data:image/png;base64,")
    }
}

extension String {
    func deleting(prefix: String) -> Self {
        guard self.hasPrefix(prefix) else {
            return self
        }
        
        return Self(self.dropFirst(prefix.count))
    }
}
extension URL_CachedImageTests {
    func generateSession(mocks: [URL?: (Data, URLResponse)]) -> URLSession {
        // attach the mocks to our protocol handler
        URLProtocolMock.testURLs = mocks

       // now set up a configuration to use our mock
       let config = URLSessionConfiguration.ephemeral
       config.protocolClasses = [URLProtocolMock.self]

       // and create the URLSession from that
       return URLSession(configuration: config)
    }
}

private extension String {
    func toURL() throws -> URL {
        return try XCTUnwrap(URL(string: self))
    }
}

/// MARK  URLProtocol override
class URLProtocolMock: URLProtocol {
    // this dictionary maps URLs to test data
    static var testURLs = [URL?: (Data, URLResponse)]()

    // Say yes to every task so we can fake it
    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }
    // Say yes to every request so we can fake it
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    // ignore this method; just send back what we were given
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        // mark that we've finished
        defer { self.client?.urlProtocolDidFinishLoading(self) }
        // if we have a valid URL…
        guard let url = request.url else {
            return
        }
        
        // …and if we have test data for that URL…
        guard let (data, response) = Self.testURLs[url] else {
            return
        }
        
        // …load it immediately.
        self.client?.urlProtocol(self,
                                 didReceive: response,
                                 cacheStoragePolicy: .notAllowed)
        self.client?.urlProtocol(self, didLoad: data)
    }

    // this method is required but doesn't need to do anything
    override func stopLoading() { }
}

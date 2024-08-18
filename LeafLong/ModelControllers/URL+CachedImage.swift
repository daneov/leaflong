//
//  Herb+CachedImage.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 18/08/2024.
//

import Foundation
import Combine
import SwiftUI

enum HTTPError: Error {
    case unknown
    case status(code: Int)
}

extension URL {
    static var cachedURLPrefix: String {
        return "data:image/png;base64,"
    }
    
    func convertToDataURL(session: URLSession = URLSession.shared) -> AnyPublisher<URL, Never> {
        session.dataTaskPublisher(for: self)
            .tryMap({ (data, response) in
                guard let response = response as? HTTPURLResponse else {
                    throw HTTPError.unknown
                }
                
                guard response.statusCode == 200 else {
                    throw HTTPError.status(code: response.statusCode)
                }
                
                return data
            })
            .replaceError(with: Image.unavailable ?? Data("".utf8))
            .map { data in
                return URL(string: Self.cachedURLPrefix + data.base64EncodedString())!
            }
            .eraseToAnyPublisher()
    }
}

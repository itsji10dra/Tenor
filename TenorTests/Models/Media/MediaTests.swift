//
//  MediaTests.swift
//  TenorTests
//
//  Created by Jitendra on 28/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
@testable import Tenor

class MediaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDecoding() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "Media", withExtension: "json") else {
            XCTFail("Unable to load sample JSON")
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let media = try decoder.decode(Media.self, from: data)
            
            XCTAssertEqual(media.dimension?.count, 2)
            XCTAssertEqual(media.duration, 0.72)
            XCTAssertEqual(media.url?.absoluteString, "https://media.tenor.com/videos/7a7783a6b59d65bc68e4084b20f1f42b/mp4")
            XCTAssertEqual(media.preview?.absoluteString, "https://media.tenor.com/images/e58f5f986f7731431058e41934c9ca20/tenor.png")
            XCTAssertEqual(media.size, 12637)
        } catch {
            XCTFail("Error in parsing/decoding JSON")
        }
    }
}

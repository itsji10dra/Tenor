//
//  GIFTests.swift
//  TenorTests
//
//  Created by Jitendra on 29/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
@testable import Tenor

class GIFTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDecoding() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "GIF", withExtension: "json") else {
            XCTFail("Unable to load sample JSON")
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let gif = try decoder.decode(GIF.self, from: data)
            
            XCTAssertEqual(gif.tags?.count, 0)
            XCTAssertEqual(gif.media?.count, 2)
            XCTAssertNotNil(gif.media?.first?.nanoMP4)
            XCTAssertNotNil(gif.media?.first?.nanoWebM)
            XCTAssertNil(gif.media?.first?.nanoGIF)
            XCTAssertNotNil(gif.media?.last?.nanoMP4)
            XCTAssertNil(gif.media?.last?.gif)
            XCTAssertEqual(gif.url?.absoluteString, "https://tenor.com/HViv.gif")
            XCTAssertEqual(gif.created, 1489983130.001984)
            XCTAssertEqual(gif.shares, 1)
            XCTAssertEqual(gif.itemURL?.absoluteString, "https://tenor.com/view/mmmmmh-gif-8046009")
            XCTAssertEqual(gif.hasAudio, false)
            XCTAssertEqual(gif.title, "")
            XCTAssertEqual(gif.id, "8046009")
        } catch {
            XCTFail("Error in parsing/decoding JSON")
        }
    }
}

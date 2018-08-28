//
//  MediaCollectionTests.swift
//  TenorTests
//
//  Created by Jitendra on 29/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
@testable import Tenor

class MediaCollectionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDecoding() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let fileURL = testBundle.url(forResource: "MediaCollection", withExtension: "json") else {
            XCTFail("Unable to load sample JSON")
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let collection = try decoder.decode(MediaCollection.self, from: data)
            
            //Test nanoMP4
            XCTAssertNil(collection.nanoMP4)
            
            //Test nanoWebM
            XCTAssertEqual(collection.nanoWebM?.dimension, [128, 128])
            XCTAssertNil(collection.nanoWebM?.duration)
            XCTAssertEqual(collection.nanoWebM?.size, 11894)
            XCTAssertEqual(collection.nanoWebM?.url?.absoluteString, "https://media.tenor.com/videos/9547e1c42b48207402b1b478fc1bd200/webm")
            XCTAssertEqual(collection.nanoWebM?.preview?.absoluteString, "https://media.tenor.com/images/e58f5f986f7731431058e41934c9ca20/tenor.png")
            
            //Test tinyMP4
            XCTAssertEqual(collection.tinyMP4?.dimension, [128, 128])
            XCTAssertEqual(collection.tinyMP4?.duration, 0.7)
            XCTAssertEqual(collection.tinyMP4?.size, 12338)
            XCTAssertNil(collection.tinyMP4?.url)
            XCTAssertNil(collection.tinyMP4?.preview)

            //Test tinyWebM
            XCTAssertNil(collection.tinyWebM)

            //Test mediumGIF
            XCTAssertNil(collection.mediumGIF?.dimension)
            XCTAssertNil(collection.mediumGIF?.duration)
            XCTAssertEqual(collection.mediumGIF?.size, 34356)
            XCTAssertEqual(collection.mediumGIF?.url?.absoluteString, "https://media.tenor.com/images/69b56c923fc10c98349be05b3a6f5bbe/tenor.gif")
            XCTAssertEqual(collection.mediumGIF?.preview?.absoluteString, "https://media.tenor.com/images/5d6e6471eb5ebfffbc8bb832a1bd9517/tenor.gif")

            //Test nanoGIF
            XCTAssertEqual(collection.nanoGIF?.dimension, [90, 90])
            XCTAssertNil(collection.nanoGIF?.duration)
            XCTAssertEqual(collection.nanoGIF?.size, 6501)
            XCTAssertEqual(collection.nanoGIF?.url?.absoluteString, "https://media.tenor.com/images/868512f4a3c35bca25a1d4a40008197e/tenor.gif")
            XCTAssertEqual(collection.nanoGIF?.preview?.absoluteString, "https://media.tenor.com/images/93a1728f72e89088a4f36f8d6da3c342/tenor.gif")
        } catch {
            XCTFail("Error in parsing/decoding JSON")
        }
    }
}

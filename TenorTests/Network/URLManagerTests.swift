//
//  URLManagerTests.swift
//  TenorTests
//
//  Created by Jitendra on 29/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import XCTest
@testable import Tenor

class URLManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetURLWithoutParameter() {
        
        guard let url = URLManager.getURL(for: .search) else {
            XCTFail("Unable to get URL")
            return
        }

        let actualURL = URL(string: Configuration.url)
        
        XCTAssertEqual(url.host, actualURL?.host)
        XCTAssertEqual(url.scheme, actualURL?.scheme)
        XCTAssertEqual(url.path, EndPoint.search.rawValue)
        
        var actualQuery = "key=\(Configuration.key)"
        if let anonId = UserDefaults.standard.string(forKey: kAnonymousIdKey) {
            actualQuery = actualQuery + "&anon_id=\(anonId)"
        }
        XCTAssertEqual(url.query, actualQuery)
    }
    
    func testGetURLWithParameter() {

        guard let url = URLManager.getURL(for: .search, appending: ["q": "hello"]) else {
            XCTFail("Unable to get URL")
            return
        }

        let actualURL = URL(string: Configuration.url)

        XCTAssertEqual(url.host, actualURL?.host)
        XCTAssertEqual(url.scheme, actualURL?.scheme)
        XCTAssertEqual(url.path, EndPoint.search.rawValue)
        
        var actualQuery = "q=hello&key=\(Configuration.key)"
        if let anonId = UserDefaults.standard.string(forKey: kAnonymousIdKey) {
            actualQuery = actualQuery + "&anon_id=\(anonId)"
        }
        XCTAssertEqual(url.query, actualQuery)
    }
    
    func testGetURLWithParameterAndLimit() {
        
        guard let url = URLManager.getURL(for: .search, appending: ["q": "hello"], withLimit: true) else {
            XCTFail("Unable to get URL")
            return
        }
        
        let actualURL = URL(string: Configuration.url)
        
        XCTAssertEqual(url.host, actualURL?.host)
        XCTAssertEqual(url.scheme, actualURL?.scheme)
        XCTAssertEqual(url.path, EndPoint.search.rawValue)
        
        var actualQuery = "q=hello&key=\(Configuration.key)&limit=\(Configuration.pageLimit)"
        if let anonId = UserDefaults.standard.string(forKey: kAnonymousIdKey) {
            actualQuery = actualQuery + "&anon_id=\(anonId)"
        }
        XCTAssertEqual(url.query, actualQuery)
    }
}

// SnippetsTests RandomUserTests.swift
//
// Copyright © 2015, 2016, Roy Ratcliffe, Pioneering Software, United Kingdom
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS,” WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
//------------------------------------------------------------------------------

import XCTest
import Snippets

class RandomUserTests: XCTestCase {

  func testDefault() {
    // given
    let expectation = expectationWithDescription("Default")
    let randomUser = RandomUser()

    // when
    randomUser.get { (randomUser) -> Void in
      let nationality = randomUser["nationality"] as? String
      let results = randomUser["results"] as? [NSDictionary]
      let seed = randomUser["seed"] as? String
      let version = randomUser["version"] as? String
      XCTAssertNotNil(nationality)
      XCTAssertNotNil(results)
      XCTAssertNotNil(seed)
      XCTAssertEqual(version, "0.7")
      XCTAssertTrue(results?.count == 1)
      expectation.fulfill()
    }

    // then
    waitForExpectationsWithTimeout(10.0) { (error) -> Void in
      if let error = error {
        NSLog("%@", error.localizedDescription)
      }
      XCTAssertNil(error)
    }
  }

  /// Ask for three, you should receive three.
  func testThree() {
    // given
    let expectation = expectationWithDescription("Three")
    let randomUser = RandomUser()

    // when
    randomUser.results = 3
    randomUser.get { (randomUser) -> Void in
      let results = randomUser["results"] as? [NSDictionary]
      XCTAssertNotNil(results)
      XCTAssertTrue(results?.count == 3)
      expectation.fulfill()
    }

    // then
    waitForExpectationsWithTimeout(10.0) { (error) -> Void in
      if let error = error {
        NSLog("%@", error.localizedDescription)
      }
      XCTAssertNil(error)
    }
  }

  /// Ask for British people.
  func testGB() {
    // given
    let expectation = expectationWithDescription("GB")
    let randomUser = RandomUser()

    // when
    randomUser.nat = "GB"
    randomUser.get { (randomUser) -> Void in
      let nationality = randomUser["nationality"] as? String
      XCTAssertNotNil(nationality)
      XCTAssertEqual(nationality, "GB")
      expectation.fulfill()
    }

    // then
    waitForExpectationsWithTimeout(10.0) { (error) -> Void in
      if let error = error {
        NSLog("%@", error.localizedDescription)
      }
      XCTAssertNil(error)
    }
  }

}

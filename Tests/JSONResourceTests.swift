/*
 Copyright 2017 Roberto Pastor Ortiz
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import XCTest
@testable import Square1Network

class JSONResourceTests: XCTestCase {
  
  let session = URLSession.shared
  
  func testMultipleJSONRequest() {
    
    let request = MultiplePostRequest()
    let expect = expectation(description: "END")
    request.executeInSession(session) { (result) in
      
      switch (result) {

      case .success(let multiplePostResponse):
        XCTAssert(multiplePostResponse.posts.count == 100)
        break
        
      default:
        XCTFail()
        break
      }
    
      expect.fulfill()
    }
    
    waitForExpectations(timeout: 5.0)
  }
  
  func testSingleJSONRequest() {
    
    let request = SinglePostRequest()
    let expect = expectation(description: "END")
    request.executeInSession(session) { (result) in
      
      switch (result) {
        
      case .success(let singlePostResponse):
        XCTAssertEqual(singlePostResponse.post.id, 1)
        break
        
      default:
        XCTFail()
        break
      }
      
      expect.fulfill()
    }
    
    waitForExpectations(timeout: 5.0)
  }
    
}

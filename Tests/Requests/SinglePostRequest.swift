/*
 Copyright 2017 Roberto Pastor Ortiz
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation
@testable import Square1Network

struct SinglePostRequest: JSONServiceRequest {
    
    func parseReceivedData(data: Data) throws -> WebServiceResult<SinglePostResponse> {
              let decoder = JSONDecoder()
              let json = try decoder.decode(Post.self, from: data)
              let response = SinglePostResponse(jsonObject: json)
              return .success(response)
    }
    
  
  typealias JSONResponseType = Post
  typealias JSONServiceErrorType = JSONServiceEmptyError
  typealias Response = SinglePostResponse
  
  var baseUrl = URL(string: "https://jsonplaceholder.typicode.com")!
  var path = ["posts", "1"]
  var headerParams = (field:"Content-Type", value:"application/json")
  
//  func handleResponse(_ data: Data?, response: URLResponse?, error: NSError?) -> WebServiceResult<SinglePostResponse> {
//    if let error = error {
//      return .failure(error)
//    }
//    
//    guard let data = data else {
//      return .successNoData
//    }
//    
//    do {
//      let decoder = JSONDecoder()
//      let json = try decoder.decode(Post.self, from: data)
//      let response = SinglePostResponse(jsonObject: json)
//      return .success(response)
//    } catch let error as NSError {
//      return .failure(error)
//    }
//  }
}



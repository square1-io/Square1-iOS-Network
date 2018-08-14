/*
 Copyright 2017 Roberto Pastor Ortiz
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation

// MARK: - JSONServiceRequest
public protocol JSONServiceRequest: WebServiceRequest
where Task: URLSessionDataTask, Response: JSONServiceResponse {}

public extension JSONServiceRequest {
  public var accept: String? { return "application/json" }
}

// MARK: - DecodableJSONRequest
public protocol DecodableJSONServiceRequest: WebServiceRequest
where Task: URLSessionDataTask, Response: DecodableJSONServiceResponse {
  associatedtype JSONServiceErrorType: JSONServiceError
}

public extension DecodableJSONServiceRequest {
  public var accept: String? { return "application/json"}
  
  public func handle(_ data: Data?,
                     response: URLResponse?,
                     error: Error?) -> WebServiceResult<Response> {
    if let error = error {
      return .failure(error)
    }
    
    guard let data = data else {
      return .failure(ServiceError.invalidData)
    }
    
    // Catching error from API if any
    do {
      let decoder = JSONDecoder()
      let apiError = try decoder.decode(JSONServiceErrorType.self, from: data)
      return .failure(apiError.error)
    } catch {
      // If catched, the json is not an API error
    }
    
    do {
      let response = try Response(data: data)
      return .success(response)
    } catch let error {
      return .failure(error)
    }
  }
}

/*
 Copyright 2017 Roberto Pastor Ortiz
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation

// MARK: - JSONServiceResponse
public protocol JSONServiceResponse: WebServiceResponse {
  var json: [String: Any] { get set }
}

extension JSONServiceResponse {
  public init(data: Data) throws {
    self.init()
    json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
  }
}

// MARK: - DecodableJSONServiceResponse
public protocol DecodableJSONServiceResponse: WebServiceResponse {
  associatedtype JSONType: Decodable
  
  var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
  
  func processParsed(decodable: JSONType)
}

public extension DecodableJSONServiceResponse {

  var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
    return .deferredToDate
  }
  
  public init(data: Data) throws {
    self.init()
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = dateDecodingStrategy
    
    let json = try decoder.decode(JSONType.self, from: data)
    processParsed(decodable: json)
  }
}

// MARK: - JSONServiceError
public protocol JSONServiceError: Decodable {
  var error: NSError? { get }
}

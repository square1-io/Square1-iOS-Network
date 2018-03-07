/*
 Copyright 2017 Roberto Pastor Ortiz
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation

public protocol JSONServiceError: Decodable {
  var error: NSError? { get }
}


public protocol JSONServiceResponse: WebServiceResponse {
  init(jsonObject:Decodable)
}


public protocol JSONServiceRequest: WebServiceRequest where Task: URLSessionDataTask, Response: JSONServiceResponse {
  associatedtype JSONResponseType: Decodable
  associatedtype JSONServiceErrorType: JSONServiceError
  
  var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
  
  func handleResponse(_ data: Data?,
                      response: URLResponse?,
                      error: NSError?) -> WebServiceResult<Response>
}


public extension JSONServiceRequest {

  var accept: String? { return "application/json" }
  
  var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
    return .deferredToDate
  }

  var request: NSMutableURLRequest {
    let request = baseRequest
    
    // Request Body
    if let requestBody = requestBody {
      let data = try! JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
      request.httpBody = data
    }
    
    return request
  }
  
  @discardableResult
  func executeInSession(_ session: URLSession? = URLSession.shared,
                        completion: @escaping (WebServiceResult<Response>) -> ()) -> URLSessionDataTask? {
    let request = self.request as URLRequest
    
    let task = session!.dataTask(with: request) { data, response, error in
      let result = self.handleResponse(data, response: response, error: error as NSError?)
      DispatchQueue.main.async {
        completion(result)
      }
    }
    
    task.resume()
    return task
  }
  
  func handleResponse(_ data: Data?,
                      response: URLResponse?,
                      error: NSError?) -> WebServiceResult<Response> {
    if let error = error {
      return .failure(error)
    }
    
    guard let data = data else {
      return .successNoData
    }
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = dateDecodingStrategy
    
    do {
      let apiError = try decoder.decode(JSONServiceErrorType.self, from: data)
      return .failure(apiError.error)
    } catch {}
    
    do {
      let json = try decoder.decode(JSONResponseType.self, from: data)
      let response = Response(jsonObject: json)
      return .success(response)
    } catch let error as NSError {
      return .failure(error)
    }
  }
}

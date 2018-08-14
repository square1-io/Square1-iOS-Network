//
//  MultipartServiceRequest.swift
//  Square1Network
//
//  Created by Roberto Pastor Ortiz on 7/3/18.
//  Copyright © 2018 Square1. All rights reserved.
//

import Foundation


public protocol MultipartServiceRequest: WebServiceRequest where Task: URLSessionDataTask {
  var files: [FileUpload] { get }
  var params: [String: String] { get }
}


public extension MultipartServiceRequest {

  var method: HTTPMethod { return .POST }
    
  fileprivate var boundary: String  {
    return "boundary-d481cbe95f0e7a59ec7f93e6ede5dd05e3291a3c"
  }
  
  var contentType: String? {
    return "multipart/form-data; boundary=\(boundary)"
  }
  
    
  func prepareRequest(request:NSMutableURLRequest){

    let body = NSMutableData()
    
    // Request Body
    for file in files {
      body.append(data(for: file))
    }
    
    for (key, value) in params {
      body.append(data(for: key, and: value))
    }
    
    if body.length > 0 {
        body.append("--\(boundary)--")
        request.httpBody = body as Data
    }

    let stringData:String =  String(data: body as Data, encoding: String.Encoding.utf8)!
   print(stringData)
    
  }

  // MARK: - Private
  fileprivate func data(for file: FileUpload) -> Data {
    let data = NSMutableData()
    
    data.append("--\(boundary)\r\n")
    data.append("Content-Disposition: attachment; name=\"\(file.name)\"; filename=\"\(file.fileName)\"\r\n")
    
    if let mimeType = file.mimeType {
      data.append("Content-Type: \(mimeType)\r\n\r\n")
    } else {
      data.append("Content-Type: application/octet-stream\r\n\r\n")
    }
    
    data.append(file.data)
    data.append("\r\n")
    
    return data as Data
  }
  
  fileprivate func data(for key: String, and value: String ) -> Data {
    let data = NSMutableData()
    
    data.append("--\(boundary)\r\n")
    data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
    data.append("\(value)\r\n")
    
    return data as Data
  }
}
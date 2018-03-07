//
//  MultipartServiceRequest.swift
//  Square1Network
//
//  Created by Roberto Pastor Ortiz on 7/3/18.
//  Copyright © 2018 Square1. All rights reserved.
//

import Foundation


public protocol MultipartServiceRequest: WebServiceRequest where Task: URLSessionUploadTask {
  var files: [FileUpload] { get }
  var params: [String: String] { get }
}


public extension MultipartServiceRequest {

  fileprivate var boundary: String {
    return "Boundary-\(UUID().uuidString)"
  }
  
  var contentType: String? {
    return "multipart/form-data; boundary=\(boundary)"
  }
  
  var request: NSMutableURLRequest {
    let request = baseRequest
    
    let body = NSMutableData()
    
    // Request Body
    for file in files {
      body.append(data(for: file))
    }
    
    for (key, value) in params {
      body.append(data(for: key, and: value))
    }
    
    body.append("--\(boundary)--")
    
    request.httpBody = body as Data
    return request
  }
  
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

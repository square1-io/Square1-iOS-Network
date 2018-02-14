//
//  ImageResizeService.swift
//  Square1Network
//
//  Created by Roberto Pastor Ortiz on 14/2/18.
//  Copyright © 2018 Square1. All rights reserved.
//

import Foundation
import Square1Tools

open class ImageResizeService {
  
  // MARK: Properties
  private let host: String
  private let key: String
  private let secret: String
  
  public init(host: String, key: String, secret: String) {
    self.host = host
    self.key = key
    self.secret = secret
  }
  
  public func resizedImageUrl(for imageUrl: String, size: CGSize) -> URL? {
    guard let url = URL(string: imageUrl), host.isValidURL == true else { return nil }
    
    var mediaRequest = [String: Any?]()
    let scale = UIScreen.main.scale
    
    mediaRequest["url"] = url.absoluteString
    mediaRequest["width"] = size.width > 0 ? (size.width * scale) : nil
    mediaRequest["height"] = size.height > 0 ? (size.height * scale) : nil
    
    do {
      var jsonData = try JSONSerialization.data(withJSONObject: mediaRequest, options: [])
      var stringData = String(data: jsonData, encoding: .utf8)!
      let hash = "\(key)\(secret)\(stringData)".sha1
      
      let encodedData = ["data": stringData, "hash": hash]
      jsonData = try JSONSerialization.data(withJSONObject: encodedData, options: [])
      stringData = String(data: jsonData, encoding: .utf8)!
      
      guard let uri = stringData.base64Encoded?
        .replacingOccurrences(of: "/", with: "_")
        .replacingOccurrences(of: "+", with: "-") else { return nil }
      
      return URL(string: host)?
        .appendingPathComponent(key)
        .appendingPathComponent(uri)
      
    } catch {
      return nil
    }
  }
  
  
}

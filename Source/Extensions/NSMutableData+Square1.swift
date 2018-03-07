//
//  NSMutableData+Square1.swift
//  Square1Network
//
//  Created by Roberto Pastor Ortiz on 7/3/18.
//  Copyright © 2018 Square1. All rights reserved.
//

import Foundation

extension NSMutableData {
  func append(_ string: String) {
    let data = string.data(using: .utf8, allowLossyConversion: false)
    append(data!)
  }
}

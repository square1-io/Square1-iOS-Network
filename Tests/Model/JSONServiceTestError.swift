//
//  JSONServiceTestError.swift
//  Square1Network
//
//  Created by Roberto Pastor Ortiz on 14/8/18.
//  Copyright © 2018 Square1. All rights reserved.
//

import Foundation
@testable import Square1Network

public struct JSONServiceTestError: JSONServiceError {
  var message: String
  
  public var error: NSError? {
    return nil
  }
}

//
//  MultipartServiceResponse.swift
//  Square1NetworkTests
//
//  Created by Roberto Prato on 07/03/2018.
//  Copyright © 2018 Square1. All rights reserved.
//


import Foundation
@testable import Square1Network


class MultipartServiceResponse: WebServiceResponse {

    public let message:String
    
    required init(stringData: String) {
        self.message = stringData
    }
    
    public func valid() -> Bool {
        
        if let message:String = message as? String {
            return "hello this is a message".elementsEqual(message)
        }
        
        return false
        
    }
}

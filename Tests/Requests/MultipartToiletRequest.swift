//
//  MultipartToiletRequest.swift
//  Square1NetworkTests
//
//  Created by Roberto Prato on 07/03/2018.
//  Copyright © 2018 Square1. All rights reserved.
//

import Foundation
@testable import Square1Network

class MultipartToiletRequest: MultipartServiceRequest {
    
    func parseReceivedData(data: Data) throws -> WebServiceResult<MultipartServiceResponse> {

        if let stringData = String(data:data, encoding: String.Encoding.utf8) {
            let response = MultipartServiceResponse(stringData: stringData)
            return .success(response)
        }
        throw ServiceError.invalidData
    }
    
    
    var files: [FileUpload]
    var params: [String : String]
    

    typealias JSONResponseType = Dictionary
    typealias JSONServiceErrorType = JSONServiceEmptyError
    typealias Response = MultipartServiceResponse
    
    var baseUrl = URL(string: "http://ptsv2.com")!
    var path = ["t","6gunc-1520438438","post"]
    var headerParams = (field:"Content-Type", value:"application/json")
    
    public init(){
        self.files = []
        self.params = [:]
        
        for index in 1...5 {
            self.params["param\(index)"] = "value\(index)"
        }
    }
    
}

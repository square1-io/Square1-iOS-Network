//
//  Data+Square1.swift
//  Square1Network
//
//  Created by Roberto Prato on 08/03/2018.
//  Copyright © 2018 Square1. All rights reserved.
//

import UIKit

extension URL {

    var data:Data? {
        
        do {
            return try Data(contentsOf: self)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}

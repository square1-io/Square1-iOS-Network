//
//  UIImageView+Square1.swift
//  Square1Network
//
//  Created by Roberto Pastor Ortiz on 12/2/18.
//  Copyright © 2018 Square1. All rights reserved.
//

import Foundation
import Kingfisher

// Extension to dela with UIImageView remote image loading.
public extension UIImageView {
  
  
  /// Load remote image (using Kingfisher) into the UIImageView.
  ///
  /// - Parameters:
  ///   - url: url of the reote image.
  ///   - placeholder: placeholder `UIImage` to show while remote image is not present.
  ///   - completion: completion black with the returned image set on the image view.
  public func setRemoteImage(_ url: String, placeholder: UIImage? = nil, completion: ((UIImage?) -> ())? = nil ) {
    self.kf.setImage(with: URL(string:url)!,
                     placeholder: placeholder,
                     options: nil,
                     progressBlock: nil) { (image, _, _, _) in
      if let image = image {
        completion?(image)
      }
    }
    
  }
}

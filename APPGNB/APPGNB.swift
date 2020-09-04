//
//  APPGNB.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class APPGNB: NSObject {

    internal static let REQUEST_IDENTIFIER = String(describing: APPGNB.self)
    static let bundle = Bundle(for: APPGNB.self)
    
    static func loadImage(named imageName: String) -> UIImage? {
        return UIImage(named: imageName, in: APPGNB.bundle, compatibleWith: nil)
    }
    
}

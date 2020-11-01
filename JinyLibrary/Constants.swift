//
//  Constants.swift
//  JinyFramework
//
//  Created by Sumeet  Jain on 31/10/20.
//  Copyright © 2020 Sumeet Jain. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

extension UIView {
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }
        return self.bottomAnchor
    }
}

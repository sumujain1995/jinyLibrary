//
//  FloatingButtonWindow.swift
//  JinyLibrary
//
//  Created by Sumeet  Jain on 31/10/20.
//  Copyright © 2020 Sumeet Jain. All rights reserved.
//

import UIKit

class FloatingButtonWindow: UIWindow {

    var button: UIButton?

    init() {
        print("WINDOw initialization called")
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let button = button else {
            return false
        }
        let buttonPoint = convert(point, to: button)
        return button.point(inside: buttonPoint, with: event)
    }
}

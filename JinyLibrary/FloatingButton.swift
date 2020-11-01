//
//  FloatingButton.swift
//  JinyFramework
//
//  Created by Sumeet  Jain on 31/10/20.
//  Copyright © 2020 Sumeet Jain. All rights reserved.
//

import UIKit

class FloatingButton: UIButton {

    let xPos = screenWidth - (50 + 25) // 50 -> width of the button and 25 trailing space
    let yPos = screenHeight - (50 + 25) // 50 -> height of the button and 25 bottom space
    
    init() {
        super.init(frame: CGRect(x: xPos, y: yPos, width: 50, height: 50))
        self.backgroundColor = .black
        self.setTitle("＋", for: .normal)
        self.titleLabel?.textColor = .white
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        setUp()
    }
    
    func setUp(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2.0
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
    }

}



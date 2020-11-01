//
//  FloatingButtonViewController.swift
//  JinyLibrary
//
//  Created by Sumeet  Jain on 31/10/20.
//  Copyright © 2020 Sumeet Jain. All rights reserved.
//

import UIKit

class FloatingButtonViewController: UIViewController {
    
    private let window = FloatingButtonWindow()

    init() {
        print("VC initialization called")
        super.init(nibName: nil, bundle: nil)
        window.windowLevel = UIWindow.Level(CGFloat.greatestFiniteMagnitude)
        window.isHidden = false
        window.rootViewController = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        let view = UIView()
        let button = FloatingButton()
        view.addSubview(button)
        button.addTarget(self, action: #selector(check), for: .touchUpInside)
        self.view = view
        window.button = button
    }

    @objc func check() {
        print("Button Tapped")
    }
}

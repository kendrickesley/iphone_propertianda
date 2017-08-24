//
//  AppNavigationController.swift
//  Properti Anda
//
//  Created by Kendrick on 22/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material

class AppNavigationController: NavigationController {
        open override func prepare() {
        super.prepare()
        guard let v = navigationBar as? NavigationBar else {
            return
        }
        v.depthPreset = .none
        v.dividerColor = Color.green.lighten1
        v.backgroundColor = Color.green.lighten1
        prepareStatusBar()
    }
    
    fileprivate func prepareStatusBar() {
        // Access the statusBar.
        let statusBar:UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = Color.green.darken1
    }
}

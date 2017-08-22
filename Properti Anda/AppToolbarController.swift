//
//  AppToolbarController.swift
//  Properti Anda
//
//  Created by Kendrick on 22/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit

import Material

class AppToolbarController: ToolbarController {
    fileprivate var menuButton: IconButton!
    override func prepare() {
        super.prepare()
        prepareMenuButton()
        prepareStatusBar()
        prepareToolbar()
    }
}

extension AppToolbarController {
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
        menuButton.tintColor? = Color.white
        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }
    
    fileprivate func prepareStatusBar() {
        // Access the statusBar.
        statusBar.backgroundColor = Color.green.darken1
    }
    
    fileprivate func prepareToolbar() {
        
        toolbar.backgroundColor = Color.green.base
        toolbar.leftViews = [menuButton]
        toolbar.titleLabel.textColor = Color.white
        toolbar.detailLabel.textColor = Color.white
//        toolbar.rightViews = [switchControl, moreButton]
    }
}

extension AppToolbarController {
    @objc
    fileprivate func handleMenuButton() {
        navigationDrawerController?.toggleLeftView()
    }
}


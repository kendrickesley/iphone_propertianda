//
//  RootViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 19/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material

extension UIStoryboard {
    class func viewController(identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}

class RootViewController: UIViewController {
    
    lazy var rootDrawerController: RootDrawerController = {
        return UIStoryboard.viewController(identifier: "RootDrawerController") as! RootDrawerController
    }()
    
    lazy var drawerViewController: DrawerViewController = {
        return UIStoryboard.viewController(identifier: "DrawerViewController") as! DrawerViewController
    }()
    
    lazy var rootIntroController: RootViewController = {
        return UIStoryboard.viewController(identifier: "RootViewController") as! RootViewController
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool)
    {
//        self.performSegue(withIdentifier: "introSegue", sender: self);
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = AppNavigationDrawerController(rootViewController: rootDrawerController, leftViewController: drawerViewController, rightViewController: nil)
    }
    
    @IBAction func unwindToRoot(_ segue: UIStoryboardSegue) {
    }
}

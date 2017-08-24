//
//  RootViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 19/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material

class RootViewController: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool)
    {
        self.performSegue(withIdentifier: "introSegue", sender: self);
    }
    
    @IBAction func unwindToRoot(_ segue: UIStoryboardSegue) {
    }
}

//
//  RootDrawerController.swift
//  Properti Anda
//
//  Created by Kendrick on 21/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit

class RootDrawerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareToolbar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RootDrawerController {
    fileprivate func prepareToolbar() {
        guard let tc = toolbarController else {
            return
        }
        
        tc.toolbar.title = "Properties"
        tc.toolbar.detail = "Extends your portfolio"
    }
}

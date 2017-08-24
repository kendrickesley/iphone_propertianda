//
//  PropertySplitViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 22/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material

class PropertySplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
//        delegateMaster()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
//    func delegateMaster(){
//        guard let masterVC:PropertyListViewController = self.splitViewController?.viewControllers.first as? PropertyListViewController else {return}
//        guard let detailVC:PropertyDetailViewController = self.splitViewController?.viewControllers[1] as? PropertyDetailViewController else {return}
//        masterVC.delegate = detailVC
//        print("delegated")
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
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



//
//  PropertyDetailViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 22/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material

class PropertyDetailViewController: UIViewController {

    public var detailInfo:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationBar()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareNavigationBar(){
        navigationItem.title = "Property Detail"
        navigationItem.detail = "Address of Given Property"
        navigationItem.titleLabel.textColor = Color.white
        navigationItem.detailLabel.textColor = Color.white
        navigationItem.backBarButtonItem?.tintColor = Color.white
        navigationItem.backButton.tintColor = Color.white
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

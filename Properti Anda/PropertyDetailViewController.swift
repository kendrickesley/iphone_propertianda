//
//  PropertyDetailViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 22/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material

//protocol PropertySelectionDelegate: class {
//    func propertySelected(newProperty: Property)
//}

class PropertyDetailViewController: UIViewController {

    public var property:Property?{
        didSet{
            print("property Set")
            self.updateScreen()
        }
    }
    @IBOutlet weak var addressLabel:UILabel?
    @IBOutlet weak var emptyView:UIView?
    @IBOutlet weak var propertyScrollView:UIScrollView?
    @IBOutlet weak var propertyImage:UIImageView?
    @IBOutlet weak var propertyDetail:UILabel?
    @IBOutlet weak var investBtn:RaisedButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationBar()
        updateScreen()
        if self.property != nil {
            propertyScrollView?.alpha = 1.0
            emptyView?.alpha = 0
        }else{
            emptyView?.alpha = 1.0
            propertyScrollView?.alpha = 0
        }
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
    
    func updateScreen(){
        if property == nil {
            return
        }
        self.addressLabel?.text = self.property?.getAddress() ?? "Default Address"
        self.propertyImage?.downloadedFrom(link: (self.property?.getImageURL())!)
        self.propertyDetail?.text = self.property?.getDetail() ?? "No details provided"
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

//extension PropertyDetailViewController: PropertySelectionDelegate {
//    func propertySelected(newProperty: Property) {
//        print("property selected")
//        property = newProperty
//        updateScreen()
//    }
//}

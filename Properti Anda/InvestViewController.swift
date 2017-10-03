//
//  InvestViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 26/9/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material
import Alamofire
import SwiftyJSON
import SwiftSpinner

class InvestViewController: UIViewController, UITextFieldDelegate {

    var property: Property?
    
    @IBOutlet weak var addressLabel:UILabel?
    @IBOutlet weak var propertyImage:UIImageView?
    @IBOutlet weak var investText:TextField?
    @IBOutlet weak var investBtn: RaisedButton?
    
    var defaultColor: UIColor?
    
    @IBAction func invest(){
        
        SwiftSpinner.show("Investing...")
        var share: Double = Double(investText?.text ?? "0")! * 10560
        share /= (property?.price ?? 1)
        share *= Double(property?.share ?? 1)
        PARequest.invest(share: Int(share), property_id: property?.id ?? "", wallet_request: Double(investText?.text ?? "0")! * 10560){success in
            SwiftSpinner.hide()
            if success {
                let alert = UIAlertController(title: "Success!", message: "You are one of the investors now", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                    (alert: UIAlertAction!) in self.navigationController?.popViewController(animated: true)
                }
                ))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareNavigationBar()
        self.addressLabel?.text = self.property?.getAddress() ?? "Default Address"
        self.propertyImage?.downloadedFrom(link: (self.property?.getImageURL())!)
        investText?.delegate = self
        defaultColor = investBtn?.backgroundColor
        investText?.text="50"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Find out what the text field will be after adding the current edit
        var text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if Int(text) != nil && text.characters.count > 0 && Int(text)! > 0{
            // Text field converted to an Int
            investBtn?.isEnabled = true
            investBtn?.backgroundColor = self.defaultColor
        } else {
            // Text field is not an Int
            investBtn?.isEnabled = false
            investBtn?.backgroundColor = Color.grey.darken1
        }
        
        // Return true so the text field will be changed
        return true
    }
    
    func prepareNavigationBar(){
        navigationItem.title = "Invest for Property"
        navigationItem.detail = ""
        navigationItem.titleLabel.textColor = Color.white
        navigationItem.detailLabel.textColor = Color.white
        navigationItem.backBarButtonItem?.tintColor = Color.white
        navigationItem.backButton.tintColor = Color.white
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

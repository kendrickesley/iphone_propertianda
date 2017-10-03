//
//  LoginController.swift
//  Properti Anda
//
//  Created by Kendrick on 21/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Material
import SwiftSpinner

class LoginController: UIViewController {
    
    @IBOutlet weak var emailText: TextField?
    @IBOutlet weak var passwordText: TextField?
    @IBOutlet weak var errorLabel: UILabel?
    var appState = AppStateModel.sharedInstance;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel?.isHidden = true
        appState.getAppStates()
        // Do any additional setup after loading the view.
        PARequest.token_login(){success in
            if success{
                //go to the property list
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = AppNavigationDrawerController(rootViewController: appDelegate.propertySplitViewController, leftViewController: appDelegate.drawerViewController, rightViewController: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: Any){
        SwiftSpinner.show("Logging in...")
        PARequest.login(email: emailText?.text ?? "", password: passwordText?.text ?? ""){success in
            SwiftSpinner.hide()
            if success {
                self.errorLabel?.isHidden = true
                //go to the property list
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = AppNavigationDrawerController(rootViewController: appDelegate.propertySplitViewController, leftViewController: appDelegate.drawerViewController, rightViewController: nil)
            }else{
                self.errorLabel?.isHidden = false
            }
        }
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

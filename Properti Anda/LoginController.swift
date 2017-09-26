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
        let app:AppState? = self.appState.getAppState()
        if(app != nil && app?.token != nil && (app?.token?.characters.count)! > 0 && app?.email != nil && (app?.email?.characters.count)! > 0 && app?.first_name != nil && (app?.first_name?.characters.count)! > 0 && app?.last_name != nil && (app?.last_name?.characters.count)! > 0){
            SwiftSpinner.show("Logging in...")
            let parameters: Parameters = [
                "email": app?.email ?? "",
                "token": app?.token ?? "",
                "mode": "check_token"
            ]
            Alamofire.request("https://propertianda.com/php/user_auth.php", method: .post, parameters: parameters).responseJSON { response in
                print("Result: \(response.result)")                         // response serialization result
                SwiftSpinner.hide()
                if let body = response.result.value {
                    let json = JSON(body)
                    print("Body: \(json)")
                    if json["status"].stringValue == "OK"{
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = AppNavigationDrawerController(rootViewController: appDelegate.propertySplitViewController, leftViewController: appDelegate.drawerViewController, rightViewController: nil)
                        
                    }else{
                        self.appState.clearAuth(existing: app!)
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: Any){
        SwiftSpinner.show("Logging in...")
        let parameters: Parameters = [
            "email": emailText?.text ?? "",
            "password": passwordText?.text ?? "",
            "mode": "sign_in"
        ]
        Alamofire.request("https://propertianda.com/php/user_auth.php", method: .post, parameters: parameters).responseJSON { response in
            print("Result: \(response.result)")                         // response serialization result
            SwiftSpinner.hide()
            if let body = response.result.value {
                let json = JSON(body)
                print("Body: \(json)")
                if json["status"].stringValue == "OK"{
                    self.errorLabel?.isHidden = true
                    self.appState.saveAuth(email: json["email"].stringValue, firstName: json["first_name"].stringValue, lastName: json["last_name"].stringValue, token: json["token"].stringValue, existing: self.appState.getAppState()!)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = AppNavigationDrawerController(rootViewController: appDelegate.propertySplitViewController, leftViewController: appDelegate.drawerViewController, rightViewController: nil)

                }else{
                    self.errorLabel?.isHidden = false
                }
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

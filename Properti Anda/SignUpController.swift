//
//  SignUpController.swift
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

class SignUpController: UIViewController {

    @IBOutlet weak var emailLabel: TextField?
    @IBOutlet weak var passwordLabel: TextField?
    @IBOutlet weak var passwordConfirmationLabel: TextField?
    @IBOutlet weak var firstNameLabel: TextField?
    @IBOutlet weak var lastNameLabel: TextField?
    @IBOutlet weak var idLabel: TextField?
    @IBOutlet weak var errorLabel: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel?.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToLogin(sender: Any){
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func signUp(sender: Any){
        if passwordLabel?.text != passwordConfirmationLabel?.text {
            errorLabel?.isHidden = false
            errorLabel?.text = "Passwords do not match"
            return
        }
        if (emailLabel?.text?.characters.count)! <= 0 || (passwordLabel?.text?.characters.count)! <= 0 || (firstNameLabel?.text?.characters.count)! <= 0 || (lastNameLabel?.text?.characters.count)! <= 0 || (idLabel?.text?.characters.count)! <= 0 {
            errorLabel?.isHidden = false
            errorLabel?.text = "You haven't fill all the required information"
            return
        }
        errorLabel?.isHidden = true
        SwiftSpinner.show("Singing up...")
        PARequest.register(email: emailLabel?.text ?? "", password: passwordLabel?.text ?? "", firstName: firstNameLabel?.text ?? "", lastName: lastNameLabel?.text ?? "", id_number: idLabel?.text ?? ""){success in
            SwiftSpinner.hide()
            if success {
                self.errorLabel?.isHidden = true
                self.dismiss(animated: true, completion: nil)
            }else{
                self.errorLabel?.isHidden = false
                self.errorLabel?.text = "Whoops! The email is already been used"
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

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
    
    var appState = AppStateModel.sharedInstance;
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        appState.getAppStates()
    }
    override func viewDidAppear(_ animated: Bool)
    {
        let appState:AppState? = self.appState.getAppState()
        if appState != nil && (appState?.has_loaded)! {
            self.performSegue(withIdentifier: "rootLoginSegue", sender: self);
        }else{
            self.performSegue(withIdentifier: "introSegue", sender: self);
            self.appState.saveAppState(email: "", firstName: "", lastName: "", token: "", hasLoaded: true)
        }
    }
    
    @IBAction func unwindToRoot(_ segue: UIStoryboardSegue) {
    }
}

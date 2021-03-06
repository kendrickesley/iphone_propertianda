//
//  DrawerViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 21/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material

class DrawerViewController: UIViewController {

    @IBOutlet weak var drawerTableView:UITableView!
    @IBOutlet weak var drawerTableViewHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel?
    let drawers:DrawerData = DrawerData()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var appState = AppStateModel.sharedInstance;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawerTableView.delegate = self
        drawerTableView.dataSource = self
        appState.getAppStates()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        drawerTableViewHeightConstraint.constant = drawerTableView.contentSize.height
        let appState:AppState? = self.appState.getAppState()
        if appState != nil {
            nameLabel?.text = "Welcome,\n" + (appState?.first_name)! + " " + (appState?.last_name)!
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOut(sender: Any){
        self.appState.clearAuth(existing: self.appState.getAppState()!)
        let controller = UIStoryboard.viewController(identifier: "LoginController") as! LoginController
        appDelegate.window?.rootViewController = controller
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

extension DrawerViewController: UITableViewDelegate{
    
}

extension DrawerViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.drawers.getAllData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrawerCell")!
        cell.textLabel?.text = self.drawers.getData(byIndex: indexPath.row).getName()
        cell.imageView?.image = self.drawers.getData(byIndex: indexPath.row).getIcon()
        if indexPath.item == 0 {
            cell.imageView?.tintColor = Color.green.base
            cell.setSelected(true, animated: false)
            cell.backgroundColor = Color.grey.lighten2
        }else{
            cell.imageView?.tintColor = Color.grey.base
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = self.drawers.getData(byIndex: indexPath.row).getKey()
        for cell:DrawerCell in tableView.visibleCells as! [DrawerCell] {
            cell.imageView?.tintColor = Color.grey.base
            cell.backgroundColor = Color.white
        }
        tableView.cellForRow(at: indexPath)!.imageView?.tintColor = Color.green.base
        tableView.cellForRow(at: indexPath)!.backgroundColor = Color.grey.lighten2
        if section == "home"{
            handleHomeButton()
        }else if section == "portfolio"{
            handleInvestButton()
        }
        

    }
}

extension DrawerViewController {
    
    @objc
    fileprivate func handleHomeButton() {
//        toolbarController?.transition(to: appDelegate.propertySplitViewController, completion: closeNavigationDrawer)
        navigationDrawerController?.transition(to: appDelegate.propertySplitViewController, completion: closeNavigationDrawer)
    }
    
    @objc
    fileprivate func handleInvestButton() {
        //        toolbarController?.transition(to: appDelegate.propertySplitViewController, completion: closeNavigationDrawer)
        navigationDrawerController?.transition(to: appDelegate.investListViewContoller, completion: closeNavigationDrawer)
    }
    
    @objc
    fileprivate func handlePreferencesButton(){
//        toolbarController?.transition(to: appDelegate.preferencesViewController, completion: closeNavigationDrawer)
        navigationDrawerController?.transition(to: appDelegate.preferencesNavigationController, completion: closeNavigationDrawer)
    }
    
    fileprivate func closeNavigationDrawer(result: Bool) {
        navigationDrawerController?.closeLeftView()
    }
}

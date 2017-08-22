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
    let drawers:DrawerData = DrawerData()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawerTableView.delegate = self
        drawerTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        drawerTableViewHeightConstraint.constant = drawerTableView.contentSize.height
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
        }else if section == "preferences"{
            handlePreferencesButton()
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
    fileprivate func handlePreferencesButton(){
//        toolbarController?.transition(to: appDelegate.preferencesViewController, completion: closeNavigationDrawer)
        navigationDrawerController?.transition(to: appDelegate.preferencesViewController, completion: closeNavigationDrawer)
    }
    
    fileprivate func closeNavigationDrawer(result: Bool) {
        navigationDrawerController?.closeLeftView()
    }
}

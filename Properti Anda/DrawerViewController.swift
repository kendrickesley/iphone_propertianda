//
//  DrawerViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 21/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {

    @IBOutlet weak var drawerTableView:UITableView!
    @IBOutlet weak var drawerTableViewHeightConstraint:NSLayoutConstraint!
    let drawers:DrawerData = DrawerData()
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
        return cell
    }
}

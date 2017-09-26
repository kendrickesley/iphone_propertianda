//
//  InvestListViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 26/9/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material

class InvestListViewController: UITableViewController {
    fileprivate var menuButton: IconButton!
    var investments:Investments = Investments()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        prepareMenuButton()
        prepareNavigationItem()
    }
    
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
        menuButton.tintColor? = Color.white
        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }
    
    fileprivate func prepareNavigationItem() {
        navigationItem.title = "Portfolio"
        navigationItem.detail = "Your Investment"
        navigationItem.titleLabel.textColor = Color.white
        navigationItem.detailLabel.textColor = Color.white
        
        navigationItem.leftViews = [menuButton]
        //        navigationItem.rightViews = [starButton, searchButton]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.investments.getAllInvestments().count
    }
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:InvestCell = tableView.dequeueReusableCell(withIdentifier: "InvestCell") as? InvestCell else {return InvestCell()}
        _ = self.investments.getInvestment(byIndex: indexPath.row)
        return cell
    }

}

extension InvestListViewController {
    @objc
    fileprivate func handleMenuButton() {
        navigationDrawerController?.toggleLeftView()
    }
}

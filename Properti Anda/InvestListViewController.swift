//
//  InvestListViewController.swift
//  Properti Anda
//
//  Created by Kendrick on 26/9/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material
import SwiftSpinner

class InvestListViewController: UITableViewController {
    fileprivate var menuButton: IconButton!
    var investments:Investments = Investments()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func viewDidAppear(_ animated:Bool){
        super.viewDidAppear(animated)
        prepareMenuButton()
        prepareNavigationItem()
        SwiftSpinner.show("Requesting Information...")
        investments.requestInvestments(){_ in
            SwiftSpinner.hide()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        var numOfSections: Int = 0
        if(self.investments.getAllInvestments().count <= 0){
            let imageName = "noting"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
            imageView.image = image
            imageView.contentMode = UIViewContentMode.scaleAspectFill
            imageView.clipsToBounds = true
            self.tableView.backgroundView  = imageView
            self.tableView.separatorStyle  = .none
        }else{
            self.tableView.separatorStyle = .singleLine
            numOfSections            = 1
            self.tableView.backgroundView = nil
        }
        return numOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.investments.getAllInvestments().count
    }
 
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:InvestCell = tableView.dequeueReusableCell(withIdentifier: "InvestCell") as? InvestCell else {return InvestCell()}
        _ = self.investments.getInvestment(byIndex: indexPath.row)
        let investment = self.investments.getInvestment(byIndex: indexPath.row)
        cell.addressLabel?.text = investment.getAddress()
        cell.priceLabel?.text = investment.getPrice(formatted: true, independent: true)
        cell.contributionLabel?.text = investment.getContribution(formatted: true)
        cell.propertyImage?.downloadedFrom(link: investment.getImageURL(), contentMode: .scaleAspectFill)
        return cell
    }

}

extension InvestListViewController {
    @objc
    fileprivate func handleMenuButton() {
        navigationDrawerController?.toggleLeftView()
    }
}
